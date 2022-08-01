Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBAA586CA5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiHAOM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiHAOM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:12:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4551EEF5
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB6AE6133A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D58C433D6;
        Mon,  1 Aug 2022 14:12:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HWnxBrqw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659363172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X4tKf6FgniCc1281GaudYPm1vPNCHThlMMWoY3WX4EU=;
        b=HWnxBrqwDvyM28dg12VoWc5ev/cAHf0qjwQHfrU9H5ohbYvryE32t5d0bkS0/kiiOAnrkK
        uGyeDcF2eykI+HMdwwIW6/HxD+yhaxgP3L4s7mdFuhPUBtnmJGTlEJNWyonL1eZ17JYYb9
        DRq1w2QIKA/cqaIA6f1UsU1GMDAFUjg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1a84c9dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Aug 2022 14:12:51 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v5] lib/vsprintf: defer filling siphash key on RT
Date:   Mon,  1 Aug 2022 16:12:45 +0200
Message-Id: <20220801141245.124787-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9qP2ZR6oQY3bf8W42RHW+-DamrzT=Gh1XJ3O7f72NU_bQ@mail.gmail.com>
References: <CAHmME9qP2ZR6oQY3bf8W42RHW+-DamrzT=Gh1XJ3O7f72NU_bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RT, we can't call get_random_bytes() from inside of the raw locks
that callers of vsprintf might take, because get_random_bytes() takes
normal spinlocks. So on those RT systems, defer the siphash key
generation to a worker.

We also do the deferal for CONFIG_PROVE_RAW_LOCK_NESTING systems, which
catches RT issues on non-RT. Branching on CONFIG_PROVE_RAW_LOCK_NESTING
is partly awful, as it basically defeats the purpose of lockdep. But in
this case, it really generates incorrect splats.

Also, avoid using a static_branch, as this isn't the fast path.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Sebastian - again, feel free to take this and modify it as needed. Just
posting ideas... -Jason

 lib/vsprintf.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3c1853a9d1c0..a2a61915eb6b 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -750,37 +750,43 @@ static int __init debug_boot_weak_hash_enable(char *str)
 }
 early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
 
-static DEFINE_STATIC_KEY_FALSE(filled_random_ptr_key);
+static bool filled_ptr_key __read_mostly;
+static siphash_key_t ptr_key __read_mostly;
 
-static void enable_ptr_key_workfn(struct work_struct *work)
+static void fill_ptr_key_workfn(struct work_struct *work)
 {
-	static_branch_enable(&filled_random_ptr_key);
+	if (READ_ONCE(filled_ptr_key))
+		return;
+	get_random_bytes(&ptr_key, sizeof(ptr_key));
+	/* Pairs with smp_rmb() before reading ptr_key. */
+	smp_wmb();
+	WRITE_ONCE(filled_ptr_key, true);
 }
 
 /* Maps a pointer to a 32 bit unique identifier. */
 static inline int __ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
 {
-	static siphash_key_t ptr_key __read_mostly;
 	unsigned long hashval;
 
-	if (!static_branch_likely(&filled_random_ptr_key)) {
-		static bool filled = false;
+	if (!READ_ONCE(filled_ptr_key)) {
 		static DEFINE_SPINLOCK(filling);
-		static DECLARE_WORK(enable_ptr_key_work, enable_ptr_key_workfn);
 		unsigned long flags;
 
-		if (!system_unbound_wq || !rng_is_initialized() ||
-		    !spin_trylock_irqsave(&filling, flags))
+		if ((IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_PROVE_RAW_LOCK_NESTING)) &&
+		    rng_is_initialized()) {
+			static DECLARE_WORK(fill_ptr_key_work, fill_ptr_key_workfn);
+			queue_work(system_unbound_wq, &fill_ptr_key_work);
 			return -EAGAIN;
-
-		if (!filled) {
-			get_random_bytes(&ptr_key, sizeof(ptr_key));
-			queue_work(system_unbound_wq, &enable_ptr_key_work);
-			filled = true;
 		}
+
+		if (!rng_is_initialized() || !spin_trylock_irqsave(&filling, flags))
+			return -EAGAIN;
+
+		fill_ptr_key_workfn(NULL);
 		spin_unlock_irqrestore(&filling, flags);
 	}
-
+	/* Pairs with smp_wmb() after writing ptr_key. */
+	smp_rmb();
 
 #ifdef CONFIG_64BIT
 	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
-- 
2.35.1

