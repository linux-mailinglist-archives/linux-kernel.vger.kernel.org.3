Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A824E447E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbiCVQsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbiCVQsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:48:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EF25DE72
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:47:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF742B81C88
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E3EC340EC;
        Tue, 22 Mar 2022 16:47:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Qq4R4Hl6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647967628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+Bdvu5RBjQNG591rMAtEvu8k5n3fpkZV7AeAbLFJd/M=;
        b=Qq4R4Hl6C1WUUNCpfMnrvKGrPo3ff4dT+4p1YsxxvKIpn4owcYY3pbzNVXu5tka7/VqodF
        wPYc72Su5NotRuRg7i7SyZSULpXrBymnKBjdrlkffkEEAd4B6eUuoGJKhwBTRSWLOtyMYy
        bVVuqseU6l2wGW2tQoLRB9yiU/g805c=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id aadffafb (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 22 Mar 2022 16:47:07 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: go back to not blocking in /dev/urandom
Date:   Tue, 22 Mar 2022 10:46:55 -0600
Message-Id: <20220322164655.83229-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6f98a4bfee72 ("random: block in /dev/urandom").

We tried this, but Guenter Roeck immediately reported issues after it
hit mainline, on arm, m68k, microblaze, sparc32, and xtensa. So it
sounds like we've got some more work to do on weird architectures in
weird situations before we can make this change. Alas, but that's how it
goes, as the kernel is quite strict about not intentionally breaking
userspace, and here is some clear breakage.

Link: https://lore.kernel.org/lkml/20220322155820.GA1745955@roeck-us.net/
Link: https://lore.kernel.org/lkml/CAHk-=wjH7rNyP_S7ut3EUPfa_dOYAP1T6yOxS6hdVi3zPV9SzA@mail.gmail.com/
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/mem.c     |  2 +-
 drivers/char/random.c  | 70 ++++++++++++++++++++++++++++++++----------
 include/linux/random.h |  2 +-
 3 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 9f586025dbe6..cc296f0823bd 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -707,7 +707,7 @@ static const struct memdev {
 	 [5] = { "zero", 0666, &zero_fops, FMODE_NOWAIT },
 	 [7] = { "full", 0666, &full_fops, 0 },
 	 [8] = { "random", 0666, &random_fops, 0 },
-	 [9] = { "urandom", 0666, &random_fops, 0 },
+	 [9] = { "urandom", 0666, &urandom_fops, 0 },
 #ifdef CONFIG_PRINTK
 	[11] = { "kmsg", 0644, &kmsg_fops, 0 },
 #endif
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 78e0ed46a7cb..706f08edf0dc 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -89,14 +89,17 @@ static RAW_NOTIFIER_HEAD(random_ready_chain);
 /* Control how we warn userspace. */
 static struct ratelimit_state unseeded_warning =
 	RATELIMIT_STATE_INIT("warn_unseeded_randomness", HZ, 3);
+static struct ratelimit_state urandom_warning =
+	RATELIMIT_STATE_INIT("warn_urandom_randomness", HZ, 3);
 static int ratelimit_disable __read_mostly;
 module_param_named(ratelimit_disable, ratelimit_disable, int, 0644);
 MODULE_PARM_DESC(ratelimit_disable, "Disable random ratelimit suppression");
 
 /*
  * Returns whether or not the input pool has been seeded and thus guaranteed
- * to supply cryptographically secure random numbers. This applies to
- * get_random_bytes() and get_random_{u32,u64,int,long}().
+ * to supply cryptographically secure random numbers. This applies to: the
+ * /dev/urandom device, the get_random_bytes function, and the get_random_{u32,
+ * ,u64,int,long} family of functions.
  *
  * Returns: true if the input pool has been seeded.
  *          false if the input pool has not been seeded.
@@ -112,10 +115,10 @@ static void try_to_generate_entropy(void);
 
 /*
  * Wait for the input pool to be seeded and thus guaranteed to supply
- * cryptographically secure random numbers. This applies to
- * get_random_bytes() and get_random_{u32,u64,int,long}(). Using any
- * of these functions without first calling this function means that
- * the returned numbers might not be cryptographically secure.
+ * cryptographically secure random numbers. This applies to: the /dev/urandom
+ * device, the get_random_bytes function, and the get_random_{u32,u64,int,long}
+ * family of functions. Using any of these functions without first calling
+ * this function forfeits the guarantee of security.
  *
  * Returns: 0 if the input pool has been seeded.
  *          -ERESTARTSYS if the function was interrupted by a signal.
@@ -220,9 +223,9 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller, void
  *	unsigned long get_random_long()
  *
  * These interfaces will return the requested number of random bytes
- * into the given buffer or as a return value. The returned numbers are
- * the same as those of getrandom(0). The integer family of functions may
- * be higher performance for one-off random integers, because they do a
+ * into the given buffer or as a return value. This is equivalent to
+ * a read from /dev/urandom. The integer family of functions may be
+ * higher performance for one-off random integers, because they do a
  * bit of buffering and do not invoke reseeding.
  *
  *********************************************************************/
@@ -300,6 +303,11 @@ static void crng_reseed(bool force)
 				  unseeded_warning.missed);
 			unseeded_warning.missed = 0;
 		}
+		if (urandom_warning.missed) {
+			pr_notice("%d urandom warning(s) missed due to ratelimiting\n",
+				  urandom_warning.missed);
+			urandom_warning.missed = 0;
+		}
 	}
 }
 
@@ -979,8 +987,10 @@ int __init rand_initialize(void)
 		pr_notice("crng init done (trusting CPU's manufacturer)\n");
 	}
 
-	if (ratelimit_disable)
+	if (ratelimit_disable) {
+		urandom_warning.interval = 0;
 		unseeded_warning.interval = 0;
+	}
 	return 0;
 }
 
@@ -1420,16 +1430,20 @@ static void try_to_generate_entropy(void)
  * getrandom(2) is the primary modern interface into the RNG and should
  * be used in preference to anything else.
  *
- * Reading from /dev/random and /dev/urandom both have the same effect
- * as calling getrandom(2) with flags=0. (In earlier versions, however,
- * they each had different semantics.)
+ * Reading from /dev/random has the same functionality as calling
+ * getrandom(2) with flags=0. In earlier versions, however, it had
+ * vastly different semantics and should therefore be avoided, to
+ * prevent backwards compatibility issues.
+ *
+ * Reading from /dev/urandom has the same functionality as calling
+ * getrandom(2) with flags=GRND_INSECURE. Because it does not block
+ * waiting for the RNG to be ready, it should not be used.
  *
  * Writing to either /dev/random or /dev/urandom adds entropy to
  * the input pool but does not credit it.
  *
- * Polling on /dev/random or /dev/urandom indicates when the RNG
- * is initialized, on the read side, and when it wants new entropy,
- * on the write side.
+ * Polling on /dev/random indicates when the RNG is initialized, on
+ * the read side, and when it wants new entropy, on the write side.
  *
  * Both /dev/random and /dev/urandom have the same set of ioctls for
  * adding entropy, getting the entropy count, zeroing the count, and
@@ -1514,6 +1528,21 @@ static ssize_t random_write(struct file *file, const char __user *buffer,
 	return (ssize_t)count;
 }
 
+static ssize_t urandom_read(struct file *file, char __user *buf, size_t nbytes,
+			    loff_t *ppos)
+{
+	static int maxwarn = 10;
+
+	if (!crng_ready() && maxwarn > 0) {
+		maxwarn--;
+		if (__ratelimit(&urandom_warning))
+			pr_notice("%s: uninitialized urandom read (%zd bytes read)\n",
+				  current->comm, nbytes);
+	}
+
+	return get_random_bytes_user(buf, nbytes);
+}
+
 static ssize_t random_read(struct file *file, char __user *buf, size_t nbytes,
 			   loff_t *ppos)
 {
@@ -1600,6 +1629,15 @@ const struct file_operations random_fops = {
 	.llseek = noop_llseek,
 };
 
+const struct file_operations urandom_fops = {
+	.read = urandom_read,
+	.write = random_write,
+	.unlocked_ioctl = random_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+	.fasync = random_fasync,
+	.llseek = noop_llseek,
+};
+
 
 /********************************************************************
  *
diff --git a/include/linux/random.h b/include/linux/random.h
index c0baffe7afb1..f673fbb838b3 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -48,7 +48,7 @@ extern int unregister_random_ready_notifier(struct notifier_block *nb);
 extern size_t __must_check get_random_bytes_arch(void *buf, size_t nbytes);
 
 #ifndef MODULE
-extern const struct file_operations random_fops;
+extern const struct file_operations random_fops, urandom_fops;
 #endif
 
 u32 get_random_u32(void);
-- 
2.35.1

