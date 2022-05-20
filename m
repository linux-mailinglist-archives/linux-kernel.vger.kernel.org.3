Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F6452E941
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347931AbiETJp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347916AbiETJpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:45:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC22014B652
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A936B82297
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F415C385A9;
        Fri, 20 May 2022 09:45:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AVWjTQ02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653039912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ksmISZlIi6nB2NESgItDN22QTvPuay/eWLB20U+Sbs=;
        b=AVWjTQ02CpZ+ErHAFozJunpPnNdFp1pk7iLPzMsRVYXHoRKeQg3D5NmbfFOR5Ovjil3piG
        BXu/VChBl6kvmGDhQ67zWmU45pijSM6lWVT0i3weyN7zRTQi7FYLrLnHyKmNHiZw/5Ugau
        PlulYfO1BYTLuJHjN5MfQuWWRRBTjSM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c62442fa (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 09:45:12 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v4 1/3] random: convert to using fops->read_iter()
Date:   Fri, 20 May 2022 11:44:57 +0200
Message-Id: <20220520094459.116240-2-Jason@zx2c4.com>
In-Reply-To: <20220520094459.116240-1-Jason@zx2c4.com>
References: <20220520094459.116240-1-Jason@zx2c4.com>
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

This is a pre-requisite to wiring up splice() again for the random
and urandom drivers. It also allows us to remove the INT_MAX check in
getrandom(), because import_single_range() applies capping internally.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
[Jason: rewrote get_random_bytes_user() to simplify and also incorporate
 additional suggestions from Al.]
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 55 +++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 0958fa91a964..f8cd747acec2 100644
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
+	size_t ret = 0, copied;
 
-	if (!len)
+	if (!iov_iter_count(to))
 		return 0;
 
 	/*
@@ -417,8 +417,8 @@ static ssize_t get_random_bytes_user(void __user *ubuf, size_t len)
 	 * use chacha_state after, so we can simply return those bytes to
 	 * the user directly.
 	 */
-	if (len <= CHACHA_KEY_SIZE) {
-		ret = len - copy_to_user(ubuf, &chacha_state[4], len);
+	if (iov_iter_count(to) <= CHACHA_KEY_SIZE) {
+		ret = copy_to_iter(&chacha_state[4], CHACHA_KEY_SIZE, to);
 		goto out_zero_chacha;
 	}
 
@@ -427,17 +427,9 @@ static ssize_t get_random_bytes_user(void __user *ubuf, size_t len)
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
+		copied = copy_to_iter(output, CHACHA_BLOCK_SIZE, to);
+		ret += copied;
+		if (!iov_iter_count(to) || copied != CHACHA_BLOCK_SIZE)
 			break;
 
 		BUILD_BUG_ON(PAGE_SIZE % CHACHA_BLOCK_SIZE != 0);
@@ -1248,6 +1240,10 @@ static void __cold try_to_generate_entropy(void)
 
 SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len, unsigned int, flags)
 {
+	struct iov_iter to;
+	struct iovec iov;
+	int ret;
+
 	if (flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE))
 		return -EINVAL;
 
@@ -1258,19 +1254,18 @@ SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len, unsigned int, flags
 	if ((flags & (GRND_INSECURE | GRND_RANDOM)) == (GRND_INSECURE | GRND_RANDOM))
 		return -EINVAL;
 
-	if (len > INT_MAX)
-		len = INT_MAX;
-
 	if (!crng_ready() && !(flags & GRND_INSECURE)) {
-		int ret;
-
 		if (flags & GRND_NONBLOCK)
 			return -EAGAIN;
 		ret = wait_for_random_bytes();
 		if (unlikely(ret))
 			return ret;
 	}
-	return get_random_bytes_user(ubuf, len);
+
+	ret = import_single_range(READ, ubuf, len, &iov, &to);
+	if (unlikely(ret))
+		return ret;
+	return get_random_bytes_user(&to);
 }
 
 static __poll_t random_poll(struct file *file, poll_table *wait)
@@ -1314,8 +1309,7 @@ static ssize_t random_write(struct file *file, const char __user *ubuf,
 	return (ssize_t)len;
 }
 
-static ssize_t urandom_read(struct file *file, char __user *ubuf,
-			    size_t len, loff_t *ppos)
+static ssize_t urandom_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 {
 	static int maxwarn = 10;
 
@@ -1332,22 +1326,21 @@ static ssize_t urandom_read(struct file *file, char __user *ubuf,
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
@@ -1409,7 +1402,7 @@ static int random_fasync(int fd, struct file *filp, int on)
 }
 
 const struct file_operations random_fops = {
-	.read = random_read,
+	.read_iter = random_read_iter,
 	.write = random_write,
 	.poll = random_poll,
 	.unlocked_ioctl = random_ioctl,
@@ -1419,7 +1412,7 @@ const struct file_operations random_fops = {
 };
 
 const struct file_operations urandom_fops = {
-	.read = urandom_read,
+	.read_iter = urandom_read_iter,
 	.write = random_write,
 	.unlocked_ioctl = random_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
-- 
2.35.1

