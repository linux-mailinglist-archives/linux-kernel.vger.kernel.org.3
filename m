Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDC24AA81B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 11:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379688AbiBEKfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 05:35:17 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:58142 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbiBEKfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 05:35:12 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 87BD52012DD;
        Sat,  5 Feb 2022 10:35:10 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 8CDD181211; Sat,  5 Feb 2022 11:35:07 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH 2/2] random: fix locking for crng_init in crng_reseed()
Date:   Sat,  5 Feb 2022 11:34:58 +0100
Message-Id: <20220205103458.133386-3-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220205103458.133386-1-linux@dominikbrodowski.net>
References: <20220205103458.133386-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crng_init is protected by primary_crng->lock. Therefore, we need
to hold this lock when increasing crng_init to 2. As we shouldn't
hold this lock for too long, only hold it for crng_finalize_init(),
and split out the parts which can be delayed to crng_late_init().

If crng_finalize_init() cannot proceed due to workqueues not yet
being available, it is called again in rand_initialize(). Then, we
do not need to call crng_late_init(): At this time, the boot
process is still so early that there are no other processes to wake
up.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/random.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2df08d05e850..c70a9abbd8cb 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -557,19 +557,24 @@ static void __init crng_initialize_primary(void)
 	primary_crng.init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
 }
 
-static void crng_finalize_init(void)
+static bool crng_finalize_init(void)
 {
 	if (!system_wq) {
 		/* We can't call numa_crng_init until we have workqueues,
 		 * so mark this for processing later. */
 		crng_need_final_init = true;
-		return;
+		return false;
 	}
 
 	invalidate_batched_entropy();
 	numa_crng_init();
 	crng_init = 2;
 	crng_need_final_init = false;
+	return true;
+}
+
+static void crng_late_init(void)
+{
 	process_random_ready_list();
 	wake_up_interruptible(&crng_init_wait);
 	kill_fasync(&fasync, SIGIO, POLL_IN);
@@ -710,6 +715,7 @@ static int crng_slow_load(const u8 *cp, size_t len)
 
 static void crng_reseed(struct crng_state *crng)
 {
+	bool needs_late_init = false;
 	unsigned long flags;
 	int i;
 	union {
@@ -744,9 +750,11 @@ static void crng_reseed(struct crng_state *crng)
 	}
 	memzero_explicit(&buf, sizeof(buf));
 	WRITE_ONCE(crng->init_time, jiffies);
-	spin_unlock_irqrestore(&crng->lock, flags);
 	if (crng == &primary_crng && crng_init < 2)
-		crng_finalize_init();
+		needs_late_init = crng_finalize_init();
+	spin_unlock_irqrestore(&crng->lock, flags);
+	if (needs_late_init)
+		crng_late_init();
 }
 
 static void _extract_crng(struct crng_state *crng, u8 out[CHACHA_BLOCK_SIZE])
@@ -1383,8 +1391,10 @@ static void __init init_std_data(void)
 int __init rand_initialize(void)
 {
 	init_std_data();
-	if (crng_need_final_init)
+	if (crng_need_final_init) {
 		crng_finalize_init();
+		pr_notice("crng init done\n");
+	}
 	crng_initialize_primary();
 	crng_global_init_time = jiffies;
 	if (ratelimit_disable) {
-- 
2.35.1

