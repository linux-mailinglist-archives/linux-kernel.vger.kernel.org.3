Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED1152E946
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347827AbiETJpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347939AbiETJp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:45:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68EF14AF63
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ADDCB82956
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE73C34113;
        Fri, 20 May 2022 09:45:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Vv0CbJwB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653039917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AjqxppiLVbK2RRhIoss04u4+2YUT3AE7xNSn/In95Hk=;
        b=Vv0CbJwBVd8C3Svpv1DhZ+an2yySZJ1EUfFMolbtu4ZGaXEtnTpdnLuAdwvKDGZSKgq01i
        Tp7ZvLnneVpjDb8HC3JoLB9zQivdiFa4B83FI/ecMfxI9V3lpqRv9HRaAGmi7Eb6lF42hr
        ssW5afDKU4lo2tSTEeLX64XF/RyAQks=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f8dcb615 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 09:45:17 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v4 2/3] random: convert to using fops->write_iter()
Date:   Fri, 20 May 2022 11:44:58 +0200
Message-Id: <20220520094459.116240-3-Jason@zx2c4.com>
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

Now that the read side has been converted to fix a regression with
splice, convert the write side as well to have some symmetry in the
interface used (and help deprecate ->write()).

Signed-off-by: Jens Axboe <axboe@kernel.dk>
[Jason: cleaned up random_ioctl a bit, require full writes in
 RNDADDENTROPY since it's crediting entropy, simplify control flow of
 write_pool(), and incorporate suggestions from Al.]
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 67 ++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index f8cd747acec2..831cafcd1034 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1274,39 +1274,31 @@ static __poll_t random_poll(struct file *file, poll_table *wait)
 	return crng_ready() ? EPOLLIN | EPOLLRDNORM : EPOLLOUT | EPOLLWRNORM;
 }
 
-static int write_pool(const char __user *ubuf, size_t len)
+static ssize_t write_pool(struct iov_iter *from)
 {
-	size_t block_len;
-	int ret = 0;
 	u8 block[BLAKE2S_BLOCK_SIZE];
+	ssize_t ret = 0;
+	size_t copied;
 
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
+		copied = copy_from_iter(block, sizeof(block), from);
+		ret += copied;
+		mix_pool_bytes(block, copied);
+		if (!iov_iter_count(from) || copied != sizeof(block))
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
@@ -1345,9 +1337,8 @@ static ssize_t random_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 
 static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 {
-	int size, ent_count;
 	int __user *p = (int __user *)arg;
-	int retval;
+	int ent_count;
 
 	switch (cmd) {
 	case RNDGETENTCNT:
@@ -1364,20 +1355,32 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EINVAL;
 		credit_init_bits(ent_count);
 		return 0;
-	case RNDADDENTROPY:
+	case RNDADDENTROPY: {
+		struct iov_iter from;
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
+		ret = import_single_range(WRITE, p, len, &iov, &from);
+		if (unlikely(ret))
+			return ret;
+		ret = write_pool(&from);
+		if (unlikely(ret < 0))
+			return ret;
+		if (unlikely(ret != len))
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
@@ -1403,7 +1406,7 @@ static int random_fasync(int fd, struct file *filp, int on)
 
 const struct file_operations random_fops = {
 	.read_iter = random_read_iter,
-	.write = random_write,
+	.write_iter = random_write_iter,
 	.poll = random_poll,
 	.unlocked_ioctl = random_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
@@ -1413,7 +1416,7 @@ const struct file_operations random_fops = {
 
 const struct file_operations urandom_fops = {
 	.read_iter = urandom_read_iter,
-	.write = random_write,
+	.write_iter = random_write_iter,
 	.unlocked_ioctl = random_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
-- 
2.35.1

