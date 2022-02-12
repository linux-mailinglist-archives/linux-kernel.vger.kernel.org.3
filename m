Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713384B34E9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 13:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbiBLMYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 07:24:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbiBLMXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 07:23:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518C727168
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 04:23:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF5C4B80735
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 12:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AF0C340F0;
        Sat, 12 Feb 2022 12:23:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kAGOg18e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644668622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DKIyEOMgPV9hNg7dPpb9e9c9iQsgX08siVTCmaCVzxw=;
        b=kAGOg18ea7tSzf63lWezD2Ho80hTibZq1a1TUWrTU5Aud2hPnRVhOBn6Odp8ZdKnQU0ikv
        IRn36uliKLYk5492LlkDW65bnH04su/vdzNxeLSrPxPZbBeY0xQmf/wpT3d5dUNc8s2jNB
        VH2rC4ybYVIFeAxvkZ6N0TkT2JWr6gs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 790e2be9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 12 Feb 2022 12:23:42 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2 08/10] random: group userspace read/write functions
Date:   Sat, 12 Feb 2022 13:23:16 +0100
Message-Id: <20220212122318.623435-9-Jason@zx2c4.com>
In-Reply-To: <20220212122318.623435-1-Jason@zx2c4.com>
References: <20220212122318.623435-1-Jason@zx2c4.com>
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
 drivers/char/random.c | 125 ++++++++++++++++++++++++++----------------
 1 file changed, 77 insertions(+), 48 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d878c8506af9..b2af2dc96d20 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1462,30 +1462,61 @@ static void try_to_generate_entropy(void)
 	mix_pool_bytes(&stack.now, sizeof(stack.now));
 }
 
-static ssize_t urandom_read(struct file *file, char __user *buf, size_t nbytes,
-			    loff_t *ppos)
+
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
@@ -1537,6 +1568,32 @@ static ssize_t random_write(struct file *file, const char __user *buffer,
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
@@ -1545,7 +1602,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 
 	switch (cmd) {
 	case RNDGETENTCNT:
-		/* inherently racy, no point locking */
+		/* Inherently racy, no point locking. */
 		if (put_user(input_pool.entropy_count, p))
 			return -EFAULT;
 		return 0;
@@ -1621,34 +1678,6 @@ const struct file_operations urandom_fops = {
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

