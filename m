Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6039A584DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiG2IxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbiG2IxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:53:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C009C8320A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:53:02 -0700 (PDT)
Date:   Fri, 29 Jul 2022 10:52:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659084780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=7Y+4CzlXeDZUd8rbWP+Eg66SJDHJEP/kxXso2o/zUu0=;
        b=tUFytNMfXiYfa2axNdctwvlhyfCB+x2lbKVncd4+pbVJ9NAv8jExwYPK+qYAtfu31Zj1IH
        CHCMHA8tta7AeE0ZK1UprvBp6Xd40N6129Dbf85jfXipC1RCw2a61tDZyvUUCKSs76P49K
        vylhIYOtptUFl1bFabBPFrUwRcyZgrxbLqjbl6cmcdtoXLCobXjsJkzaGkZymXlPLlqhh5
        3mQrUCMRGHitMeiwf0gKztHdjIvZjKY2AyYKKMVmC8rrmY6MMxCzH9XeshHz6ac0Yinzzl
        7ygGmDWOVGpdNvl/J6Iwgn/lqrMfEjxsTWwGizPPaJzPUR4TP8RqsJ7wPv2uzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659084780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=7Y+4CzlXeDZUd8rbWP+Eg66SJDHJEP/kxXso2o/zUu0=;
        b=0XSLoC3VnSr2HywrXt0D1vtnckX47A+c/qPKhqIyh9grNaehGesc/IWP4ZleeJ9U2VNygM
        /+ShyNLLh0WuqBBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] random: Initialize vsprintf's pointer hash once the random
 core is ready.
Message-ID: <YuOf6qu453dOkR+S@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printk code invokes vnsprintf in order to compute the complete
string before adding it into its buffer. This happens in an IRQ-off
region which leads to a warning on PREEMPT_RT in the random code if the
format strings contains a %p for pointer printing. This happens because
the random core acquires locks which become sleeping locks on PREEMPT_RT
which must not be acquired with disabled interrupts and or preemption.
By default the pointers are hashed which requires a random value on the
first invocation (either by printk or another user which comes first.

One could argue that there is no need for printk to disable interrupts
during the vsprintf() invocation which would fix the just mentioned
problem. However printk itself can be invoked in a context with
disabled interrupts which would lead to the very same problem.

This late init via printk can be avoided by explicitly initializing
vsprintf's random value once the random-core has been initialized.

Remove the on demand init from __ptr_to_hashval() and keep the -EAGAIN if
the init has not yet been performed. Move the actual init bits to
vsprintf_init_hash_pointer() which are invoked from random-core once it
has been initialized and get_random_bytes() is available.

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/char/random.c  |  8 +++++++-
 include/linux/random.h |  2 ++
 lib/vsprintf.c         | 36 +++++++++++++++---------------------
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a1af90bacc9f8..98f99026d1fba 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -202,6 +202,7 @@ static void extract_entropy(void *buf, size_t len);
 /* This extracts a new crng key from the input pool. */
 static void crng_reseed(void)
 {
+	bool init_hash_pointer = false;
 	unsigned long flags;
 	unsigned long next_gen;
 	u8 key[CHACHA_KEY_SIZE];
@@ -221,10 +222,15 @@ static void crng_reseed(void)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
 	WRITE_ONCE(base_crng.birth, jiffies);
-	if (!static_branch_likely(&crng_is_ready))
+	if (!static_branch_likely(&crng_is_ready)) {
 		crng_init = CRNG_READY;
+		init_hash_pointer = true;
+	}
 	spin_unlock_irqrestore(&base_crng.lock, flags);
 	memzero_explicit(key, sizeof(key));
+
+	if (init_hash_pointer)
+		vsprintf_init_hash_pointer();
 }
 
 /*
diff --git a/include/linux/random.h b/include/linux/random.h
index 20e389a14e5c7..229743ba5b4de 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -144,4 +144,6 @@ int random_online_cpu(unsigned int cpu);
 extern const struct file_operations random_fops, urandom_fops;
 #endif
 
+void vsprintf_init_hash_pointer(void);
+
 #endif /* _LINUX_RANDOM_H */
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3c1853a9d1c09..6fa2ebb9f9b9e 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -751,36 +751,30 @@ static int __init debug_boot_weak_hash_enable(char *str)
 early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
 
 static DEFINE_STATIC_KEY_FALSE(filled_random_ptr_key);
+static siphash_key_t ptr_key __read_mostly;
 
-static void enable_ptr_key_workfn(struct work_struct *work)
+void vsprintf_init_hash_pointer(void)
 {
-	static_branch_enable(&filled_random_ptr_key);
+	static DEFINE_SPINLOCK(filling);
+	unsigned long flags;
+	static bool filled;
+
+	spin_lock_irqsave(&filling, flags);
+	if (!filled) {
+		get_random_bytes(&ptr_key, sizeof(ptr_key));
+		filled = true;
+		static_branch_enable(&filled_random_ptr_key);
+	}
+	spin_unlock_irqrestore(&filling, flags);
 }
 
 /* Maps a pointer to a 32 bit unique identifier. */
 static inline int __ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
 {
-	static siphash_key_t ptr_key __read_mostly;
 	unsigned long hashval;
 
-	if (!static_branch_likely(&filled_random_ptr_key)) {
-		static bool filled = false;
-		static DEFINE_SPINLOCK(filling);
-		static DECLARE_WORK(enable_ptr_key_work, enable_ptr_key_workfn);
-		unsigned long flags;
-
-		if (!system_unbound_wq || !rng_is_initialized() ||
-		    !spin_trylock_irqsave(&filling, flags))
-			return -EAGAIN;
-
-		if (!filled) {
-			get_random_bytes(&ptr_key, sizeof(ptr_key));
-			queue_work(system_unbound_wq, &enable_ptr_key_work);
-			filled = true;
-		}
-		spin_unlock_irqrestore(&filling, flags);
-	}
-
+	if (!static_branch_likely(&filled_random_ptr_key))
+		return -EAGAIN;
 
 #ifdef CONFIG_64BIT
 	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
-- 
2.36.1

