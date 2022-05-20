Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3721952E14C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344145AbiETAlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344007AbiETAlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:41:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB233631B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:41:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69076B828D4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67B8C385B8;
        Fri, 20 May 2022 00:41:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZjqZvTex"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653007265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CjspdeBWDGhe4cGBMj1ukhgsSZgmcHVj6Y/pJcZHSEQ=;
        b=ZjqZvTexCihOozS+2vh5OtM6u94hIucBX0CQTjFccZA5d2kF6QStVNV2vihrxlBsyaEvN1
        HrKWhA3bEbGMYPFBxzpsnJ8UBjdTamw7YYUBNwnvVs1/6smozCVJvGeUuCW316JeZg4NZN
        LFfl5a0+Mo4mjWn6Jss7Mc6Lf2ZGnEc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 97d1d727 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 00:41:05 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v3 1/3] random: convert to using fops->read_iter()
Date:   Fri, 20 May 2022 02:40:56 +0200
Message-Id: <20220520004058.96691-2-Jason@zx2c4.com>
In-Reply-To: <20220520004058.96691-1-Jason@zx2c4.com>
References: <20220520004058.96691-1-Jason@zx2c4.com>
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

From: Jens Axboe <axboe@kernel.dk>

This is a pre-requisite to writing up splice() again for the random
and urandom drivers.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
[Jason: simplify control flow a bit in get_random_bytes_user().]
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 49 ++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 0958fa91a964..2b2c3681f172 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -397,13 +397,13 @@ void get_random_bytes(void *buf, size_t len)
 }
 EXPORT_SYMBOL(get_random_bytes);
 
-static ssize_t get_random_bytes_user(void __user *ubuf, size_t len)
+static ssize_t get_random_bytes_user(struct iov_iter *to)
 {
-	size_t block_len, left, ret = 0;
 	u32 chacha_state[CHACHA_STATE_WORDS];
 	u8 output[CHACHA_BLOCK_SIZE];
+	size_t ret = 0;
 
-	if (!len)
+	if (!iov_iter_count(to))
 		return 0;
 
 	/*
@@ -417,27 +417,21 @@ static ssize_t get_random_bytes_user(void __user *ubuf, size_t len)
 	 * use chacha_state after, so we can simply return those bytes to
 	 * the user directly.
 	 */
-	if (len <= CHACHA_KEY_SIZE) {
-		ret = len - copy_to_user(ubuf, &chacha_state[4], len);
+	if (iov_iter_count(to) <= CHACHA_KEY_SIZE) {
+		ret = copy_to_iter(&chacha_state[4], iov_iter_count(to), to);
 		goto out_zero_chacha;
 	}
 
 	for (;;) {
+		size_t copied, block_len = min_t(size_t, iov_iter_count(to), CHACHA_BLOCK_SIZE);
+
 		chacha20_block(chacha_state, output);
 		if (unlikely(chacha_state[12] == 0))
 			++chacha_state[13];
 
-		block_len = min_t(size_t, len, CHACHA_BLOCK_SIZE);
-		left = copy_to_user(ubuf, output, block_len);
-		if (left) {
-			ret += block_len - left;
-			break;
-		}
-
-		ubuf += block_len;
-		ret += block_len;
-		len -= block_len;
-		if (!len)
+		copied = copy_to_iter(output, block_len, to);
+		ret += copied;
+		if (!iov_iter_count(to) || copied != block_len)
 			break;
 
 		BUILD_BUG_ON(PAGE_SIZE % CHACHA_BLOCK_SIZE != 0);
@@ -1248,6 +1242,9 @@ static void __cold try_to_generate_entropy(void)
 
 SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len, unsigned int, flags)
 {
+	struct iovec iov = { .iov_base = ubuf };
+	struct iov_iter iter;
+
 	if (flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE))
 		return -EINVAL;
 
@@ -1270,7 +1267,9 @@ SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len, unsigned int, flags
 		if (unlikely(ret))
 			return ret;
 	}
-	return get_random_bytes_user(ubuf, len);
+	iov.iov_len = len;
+	iov_iter_init(&iter, READ, &iov, 1, len);
+	return get_random_bytes_user(&iter);
 }
 
 static __poll_t random_poll(struct file *file, poll_table *wait)
@@ -1314,8 +1313,7 @@ static ssize_t random_write(struct file *file, const char __user *ubuf,
 	return (ssize_t)len;
 }
 
-static ssize_t urandom_read(struct file *file, char __user *ubuf,
-			    size_t len, loff_t *ppos)
+static ssize_t urandom_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 {
 	static int maxwarn = 10;
 
@@ -1332,22 +1330,21 @@ static ssize_t urandom_read(struct file *file, char __user *ubuf,
 		else if (ratelimit_disable || __ratelimit(&urandom_warning)) {
 			--maxwarn;
 			pr_notice("%s: uninitialized urandom read (%zd bytes read)\n",
-				  current->comm, len);
+				  current->comm, iov_iter_count(to));
 		}
 	}
 
-	return get_random_bytes_user(ubuf, len);
+	return get_random_bytes_user(to);
 }
 
-static ssize_t random_read(struct file *file, char __user *ubuf,
-			   size_t len, loff_t *ppos)
+static ssize_t random_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 {
 	int ret;
 
 	ret = wait_for_random_bytes();
 	if (ret != 0)
 		return ret;
-	return get_random_bytes_user(ubuf, len);
+	return get_random_bytes_user(to);
 }
 
 static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
@@ -1409,7 +1406,7 @@ static int random_fasync(int fd, struct file *filp, int on)
 }
 
 const struct file_operations random_fops = {
-	.read = random_read,
+	.read_iter = random_read_iter,
 	.write = random_write,
 	.poll = random_poll,
 	.unlocked_ioctl = random_ioctl,
@@ -1419,7 +1416,7 @@ const struct file_operations random_fops = {
 };
 
 const struct file_operations urandom_fops = {
-	.read = urandom_read,
+	.read_iter = urandom_read_iter,
 	.write = random_write,
 	.unlocked_ioctl = random_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
-- 
2.35.1

