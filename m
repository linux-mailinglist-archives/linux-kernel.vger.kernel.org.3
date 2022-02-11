Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAA44B25E9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350223AbiBKMgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:36:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350198AbiBKMg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:36:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ADBFC2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:36:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2541B829DF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC9FC340E9;
        Fri, 11 Feb 2022 12:36:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pbHJBPrX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644582980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6+huIJjfj/t+DigUHYU4QErBjCfT1MuACGpOG09eJk=;
        b=pbHJBPrXt4PyF1wCw0rnRE9ePoNLtE17mq3QBFXVVNZtweoPwhsMatMnv8ona2GhPRZW1k
        wMQAaV/mrGZm2XzfH2RaaM4M7b4rhrwAuF29cUdA29dfbszdaTDTsAZL0Qjb4mt7oSItLf
        8OeKtBSf125OP8gCY3OdPstoBqYoqco=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e133e010 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 11 Feb 2022 12:36:20 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 8/9] random: group userspace read/write functions
Date:   Fri, 11 Feb 2022 13:35:45 +0100
Message-Id: <20220211123546.474952-9-Jason@zx2c4.com>
In-Reply-To: <20220211123546.474952-1-Jason@zx2c4.com>
References: <20220211123546.474952-1-Jason@zx2c4.com>
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

This pulls all of the userspace read/write-focused functions into the
fifth labeled section.

No functional changes.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 124 ++++++++++++++++++++++++++----------------
 1 file changed, 76 insertions(+), 48 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index f793bd3a1325..a4229474d7fa 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1320,30 +1320,60 @@ static void try_to_generate_entropy(void)
 	mix_pool_bytes(&stack.now, sizeof(stack.now));
 }
 
-static ssize_t urandom_read(struct file *file, char __user *buf, size_t nbytes,
-			    loff_t *ppos)
+/**********************************************************************
+ *
+ * Userspace reader/writer interfaces.
+ *
+ * getrandom(2) is the primary modern interface into the RNG and should
+ * be used in preference to anything else.
+ *
+ * Reading from /dev/random has the same functionality as calling
+ * getrandom(2) with flags=0. In earlier versions, however, it had
+ * vastly different semantics and should therefore be avoided, to
+ * prevent backwards compatibility issues.
+ *
+ * Reading from /dev/urandom has the same functionality as calling
+ * getrandom(2) with flags=GRND_INSECURE. Because it does not block
+ * waiting for the RNG to be ready, it should not be used.
+ *
+ * Writing to either /dev/random or /dev/urandom adds entropy to
+ * the input pool but does not credit it.
+ *
+ * Polling on /dev/random indicates when the RNG is initialized, on
+ * the read side, and when it wants new entropy, on the write side.
+ *
+ * Both /dev/random and /dev/urandom have the same set of ioctls for
+ * adding entropy, getting the entropy count, zeroing the count, and
+ * reseeding the crng.
+ *
+ **********************************************************************/
+
+SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count, unsigned int,
+		flags)
 {
-	static int maxwarn = 10;
+	if (flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE))
+		return -EINVAL;
 
-	if (!crng_ready() && maxwarn > 0) {
-		maxwarn--;
-		if (__ratelimit(&urandom_warning))
-			pr_notice("%s: uninitialized urandom read (%zd bytes read)\n",
-				  current->comm, nbytes);
-	}
+	/*
+	 * Requesting insecure and blocking randomness at the same time makes
+	 * no sense.
+	 */
+	if ((flags & (GRND_INSECURE | GRND_RANDOM)) == (GRND_INSECURE | GRND_RANDOM))
+		return -EINVAL;
 
-	return get_random_bytes_user(buf, nbytes);
-}
+	if (count > INT_MAX)
+		count = INT_MAX;
 
-static ssize_t random_read(struct file *file, char __user *buf, size_t nbytes,
-			   loff_t *ppos)
-{
-	int ret;
+	if (!(flags & GRND_INSECURE) && !crng_ready()) {
+		int ret;
 
-	ret = wait_for_random_bytes();
-	if (ret != 0)
-		return ret;
-	return get_random_bytes_user(buf, nbytes);
+		if (flags & GRND_NONBLOCK)
+			return -EAGAIN;
+		ret = wait_for_random_bytes();
+		if (unlikely(ret))
+			return ret;
+	}
+	return get_random_bytes_user(buf, count);
 }
 
 static __poll_t random_poll(struct file *file, poll_table *wait)
@@ -1395,6 +1425,32 @@ static ssize_t random_write(struct file *file, const char __user *buffer,
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
+static ssize_t random_read(struct file *file, char __user *buf, size_t nbytes,
+			   loff_t *ppos)
+{
+	int ret;
+
+	ret = wait_for_random_bytes();
+	if (ret != 0)
+		return ret;
+	return get_random_bytes_user(buf, nbytes);
+}
+
 static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 {
 	int size, ent_count;
@@ -1403,7 +1459,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 
 	switch (cmd) {
 	case RNDGETENTCNT:
-		/* inherently racy, no point locking */
+		/* Inherently racy, no point locking. */
 		if (put_user(input_pool.entropy_count, p))
 			return -EFAULT;
 		return 0;
@@ -1479,34 +1535,6 @@ const struct file_operations urandom_fops = {
 	.llseek = noop_llseek,
 };
 
-SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count, unsigned int,
-		flags)
-{
-	if (flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE))
-		return -EINVAL;
-
-	/*
-	 * Requesting insecure and blocking randomness at the same time makes
-	 * no sense.
-	 */
-	if ((flags & (GRND_INSECURE | GRND_RANDOM)) == (GRND_INSECURE | GRND_RANDOM))
-		return -EINVAL;
-
-	if (count > INT_MAX)
-		count = INT_MAX;
-
-	if (!(flags & GRND_INSECURE) && !crng_ready()) {
-		int ret;
-
-		if (flags & GRND_NONBLOCK)
-			return -EAGAIN;
-		ret = wait_for_random_bytes();
-		if (unlikely(ret))
-			return ret;
-	}
-	return get_random_bytes_user(buf, count);
-}
-
 /********************************************************************
  *
  * Sysctl interface
-- 
2.35.0

