Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC154A4C95
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380676AbiAaQ4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:56:47 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:42566 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiAaQ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:56:42 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 70E00200230;
        Mon, 31 Jan 2022 16:56:40 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id F026280F60; Mon, 31 Jan 2022 17:55:52 +0100 (CET)
Date:   Mon, 31 Jan 2022 17:55:52 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 2/2] random: only call crng_finalize_init() for
 primary_crng
Message-ID: <YfgUmAYoaxmlWe54@owl.dominikbrodowski.net>
References: <20220130210320.3997-1-linux@dominikbrodowski.net>
 <20220130210320.3997-2-linux@dominikbrodowski.net>
 <CAHmME9rqoweMb5zO95B1QsAHRFkSmcumbJKZTA+tqqRHN3mzGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9rqoweMb5zO95B1QsAHRFkSmcumbJKZTA+tqqRHN3mzGw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, Jan 30, 2022 at 11:11:22PM +0100 schrieb Jason A. Donenfeld:
> Thanks, I'll apply this. I do wonder, though, do we have locking
> concerns around crng_init transitioning from 1 to 2, or with calls to
> crng_need_final_init? For example, can crng_reseed be called at the
> same time as rand_initialize? Or are we still single core at this
> point in the boot sequence? I don't think that this patch changes
> anything from that perspective, which is why it seems reasonable to
> apply, but I do wonder.

Well, the comment

	 * crng_init is protected by primary_crng->lock

is currently not adhered to. It's unproblematic to set it at
rand_initialize() time (by calling crng_finalize_init()), as the system
is still running with IRQs disabled and only the boot CPU active (but
not yet in PID 1). So its call to crng_finalize_init() will not race
with crng_reseed() calling crng_finalize_init().

However, I think the other sites setting crng_init
	- crng_reseed() calling crng_finalize_init()
	- crng_fast_load()
might race, in particular two parallel calls to crng_reseed(). So let's
try to keep the promise to increase[*] crng_init only while holding
primary_crng->lock. UNTESTED, not even compile-tested patch below.

What do you think?

Thanks,
	Dominik

[*] The read sites still need to be checked, but at a first glance, I did
not notice any obvious problematic code.

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 7ed910c23858..e21c73cadcc2 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -465,7 +465,7 @@ static struct crng_state primary_crng = {
  * its value (from 0->1->2).
  */
 static int crng_init = 0;
-static bool crng_need_final_init = false;
+static bool crng_needs_numa_init = false;
 #define crng_ready() (likely(crng_init > 1))
 static int crng_init_cnt = 0;
 static unsigned long crng_global_init_time = 0;
@@ -788,31 +788,29 @@ static void crng_initialize_secondary(struct crng_state *crng)
 	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
 }
 
+static void crng_finalize_init(void)
+{
+	invalidate_batched_entropy();
+	/* We can't call numa_crng_init() until we have workqueues,
+	 * but we will pick this up in rand_initialize() */
+	if (system_wq)
+		numa_crng_init();
+	else
+		crng_needs_numa_init = true;
+	crng_init = 2;
+}
+
 static void __init crng_initialize_primary(void)
 {
 	_extract_entropy(&primary_crng.state[4], sizeof(u32) * 12);
 	if (crng_init_try_arch_early() && trust_cpu && crng_init < 2) {
-		invalidate_batched_entropy();
-		numa_crng_init();
-		crng_init = 2;
+		crng_finalize_init();
 		pr_notice("crng init done (trusting CPU's manufacturer)\n");
 	}
 	primary_crng.init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
 }
 
-static void crng_finalize_init(void)
-{
-	if (!system_wq) {
-		/* We can't call numa_crng_init until we have workqueues,
-		 * so mark this for processing later. */
-		crng_need_final_init = true;
-		return;
-	}
-
-	invalidate_batched_entropy();
-	numa_crng_init();
-	crng_init = 2;
-	crng_need_final_init = false;
+static void crng_late_init(void) {
 	process_random_ready_list();
 	wake_up_interruptible(&crng_init_wait);
 	kill_fasync(&fasync, SIGIO, POLL_IN);
@@ -896,12 +894,13 @@ static size_t crng_fast_load(const u8 *cp, size_t len)
 		p[crng_init_cnt % CHACHA_KEY_SIZE] ^= *cp;
 		cp++; crng_init_cnt++; len--; ret++;
 	}
-	spin_unlock_irqrestore(&primary_crng.lock, flags);
 	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
 		invalidate_batched_entropy();
 		crng_init = 1;
-		pr_notice("fast init done\n");
 	}
+	spin_unlock_irqrestore(&primary_crng.lock, flags);
+	if (crng_init == 1)
+		pr_notice("fast init done\n");
 	return ret;
 }
 
@@ -954,6 +953,7 @@ static void crng_reseed(struct crng_state *crng, bool use_input_pool)
 {
 	unsigned long flags;
 	int i, num;
+	bool needs_late_init = false;
 	union {
 		u8 block[CHACHA_BLOCK_SIZE];
 		u32 key[8];
@@ -978,9 +978,17 @@ static void crng_reseed(struct crng_state *crng, bool use_input_pool)
 	}
 	memzero_explicit(&buf, sizeof(buf));
 	WRITE_ONCE(crng->init_time, jiffies);
-	spin_unlock_irqrestore(&crng->lock, flags);
-	if (crng == &primary_crng && crng_init < 2)
+	if (crng == &primary_crng && crng_init < 2) {
 		crng_finalize_init();
+		/* crng_late_init() is only needed if crng_init progresses to 2
+		 * after rand_initialize(). Note that while userspace may reset
+		 * crng_global_init_time to 0, it cannot reset crng_init to 2 */
+		if (crng_global_init_time > 0)
+			needs_late_init = true;
+	}
+	spin_unlock_irqrestore(&crng->lock, flags);
+	if (needs_late_init)
+		crng_late_init();
 }
 
 static void _extract_crng(struct crng_state *crng, u8 out[CHACHA_BLOCK_SIZE])
@@ -1696,8 +1704,8 @@ static void __init init_std_data(void)
 int __init rand_initialize(void)
 {
 	init_std_data();
-	if (crng_need_final_init)
-		crng_finalize_init();
+	if (crng_needs_numa_init)
+		numa_crng_init();
 	crng_initialize_primary();
 	crng_global_init_time = jiffies;
 	if (ratelimit_disable) {


