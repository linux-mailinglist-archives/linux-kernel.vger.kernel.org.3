Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABD252E149
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344103AbiETAlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344029AbiETAlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:41:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792973615A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:41:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0210B82954
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62406C385AA;
        Fri, 20 May 2022 00:41:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jpuZIX9k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653007267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rn7LVTW5ffXKQvok9WzGgZaKZ49uE7a0y7KHzsCIXdc=;
        b=jpuZIX9kUDD/hamIBEep6W4O83hKRnoadMwK49EMoSV3InXt7FsWQ1Bez7QdDFvFDGuWL0
        dP9PhpKlTBJqXfimpqtu7AEXS6BVyD9lHdhi2SZ9SyyjJY61XNz7G3fSPgHiqp1fm5hqYD
        T555BElS2a5WqM/BIQq9CXQoJfbgGH8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9a9cdf4d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 00:41:07 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v3 2/3] random: convert to using fops->write_iter()
Date:   Fri, 20 May 2022 02:40:57 +0200
Message-Id: <20220520004058.96691-3-Jason@zx2c4.com>
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

Now that the read side has been converted to fix a regression with
splice, convert the write side as well to have some symmetry in the
interface used (and help deprecate ->write()).

Signed-off-by: Jens Axboe <axboe@kernel.dk>
[Jason: cleaned up random_ioctl a bit, require full writes in
 RNDADDENTROPY since it's crediting entropy, and minimize control flow of
 write_pool().]
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 68 +++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2b2c3681f172..a664e2b89ae0 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1278,39 +1278,32 @@ static __poll_t random_poll(struct file *file, poll_table *wait)
 	return crng_ready() ? EPOLLIN | EPOLLRDNORM : EPOLLOUT | EPOLLWRNORM;
 }
 
-static int write_pool(const char __user *ubuf, size_t len)
+static ssize_t write_pool(struct iov_iter *from)
 {
-	size_t block_len;
-	int ret = 0;
 	u8 block[BLAKE2S_BLOCK_SIZE];
+	ssize_t ret = 0;
 
-	while (len) {
-		block_len = min(len, sizeof(block));
-		if (copy_from_user(block, ubuf, block_len)) {
-			ret = -EFAULT;
-			goto out;
-		}
-		len -= block_len;
-		ubuf += block_len;
-		mix_pool_bytes(block, block_len);
+	if (!iov_iter_count(from))
+		return 0;
+
+	for (;;) {
+		size_t copied, block_len = min(iov_iter_count(from), sizeof(block));
+
+		copied = copy_from_iter(block, block_len, from);
+		ret += copied;
+		mix_pool_bytes(block, copied);
+		if (!iov_iter_count(from) || copied != block_len)
+			break;
 		cond_resched();
 	}
 
-out:
 	memzero_explicit(block, sizeof(block));
-	return ret;
+	return ret ? ret : -EFAULT;
 }
 
-static ssize_t random_write(struct file *file, const char __user *ubuf,
-			    size_t len, loff_t *ppos)
+static ssize_t random_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 {
-	int ret;
-
-	ret = write_pool(ubuf, len);
-	if (ret)
-		return ret;
-
-	return (ssize_t)len;
+	return write_pool(from);
 }
 
 static ssize_t urandom_read_iter(struct kiocb *kiocb, struct iov_iter *to)
@@ -1349,9 +1342,8 @@ static ssize_t random_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 
 static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 {
-	int size, ent_count;
 	int __user *p = (int __user *)arg;
-	int retval;
+	int ent_count;
 
 	switch (cmd) {
 	case RNDGETENTCNT:
@@ -1368,20 +1360,32 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EINVAL;
 		credit_init_bits(ent_count);
 		return 0;
-	case RNDADDENTROPY:
+	case RNDADDENTROPY: {
+		struct iov_iter iter;
+		struct iovec iov;
+		ssize_t ret;
+		int len;
+
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		if (get_user(ent_count, p++))
 			return -EFAULT;
 		if (ent_count < 0)
 			return -EINVAL;
-		if (get_user(size, p++))
+		if (get_user(len, p++))
+			return -EFAULT;
+
+		iov.iov_base = p;
+		iov.iov_len = len;
+		iov_iter_init(&iter, WRITE, &iov, 1, len);
+		ret = write_pool(&iter);
+		if (ret < 0)
+			return ret;
+		if (ret != len)
 			return -EFAULT;
-		retval = write_pool((const char __user *)p, size);
-		if (retval < 0)
-			return retval;
 		credit_init_bits(ent_count);
 		return 0;
+	}
 	case RNDZAPENTCNT:
 	case RNDCLEARPOOL:
 		/* No longer has any effect. */
@@ -1407,7 +1411,7 @@ static int random_fasync(int fd, struct file *filp, int on)
 
 const struct file_operations random_fops = {
 	.read_iter = random_read_iter,
-	.write = random_write,
+	.write_iter = random_write_iter,
 	.poll = random_poll,
 	.unlocked_ioctl = random_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
@@ -1417,7 +1421,7 @@ const struct file_operations random_fops = {
 
 const struct file_operations urandom_fops = {
 	.read_iter = urandom_read_iter,
-	.write = random_write,
+	.write_iter = random_write_iter,
 	.unlocked_ioctl = random_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
-- 
2.35.1

