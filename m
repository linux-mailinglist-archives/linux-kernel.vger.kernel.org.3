Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79ED52E094
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343627AbiESXbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343572AbiESXbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:31:44 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A211E2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:31:43 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c22so6344141pgu.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+RsdF7f3Mu7C4iTNaFgCSBpFtuFSFFwFqZJwoYMIW08=;
        b=38WRsJCRa5OV3AzSmTbrHeWA6PJ0dfYCWIHx2YwHfFtJFNW5ZvWubIZYJ2QIuxDk2U
         SW/K2pe+MOHCBng/hrMTxqJviOAukrrvzSZqy7yy4oZ/IbPYUjvFs1IkSlTpB2RThWum
         A64yDtUcQJy/Pa+nS2woHbUXax0Z9ctiERQxIda027NDBjJ04Sg7YGT5DqSG796kE+hA
         tk9/CZ6I7stL449QGJqh+I4WwXm30znKGNRyBW874c9ogw7dLZnvLtVEXCynvTojlgdN
         X3ihNqx1dlPthU0zu2VUTdxg5xz0op7Nfb9vAAGhdL2E3SAXec8p+5zmL9to/CRiL0TS
         6+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+RsdF7f3Mu7C4iTNaFgCSBpFtuFSFFwFqZJwoYMIW08=;
        b=iGjPd0PWlZjjxx45CTfeI8sMXQUVrk8ygPSTdcKwy+jdnXyr+GSvViMSx+CN0MMvgK
         CmU60In8nLgidoWyv4gjmU+f/5bM+eVAzNSTzGxb4BwycB6BeFJ9Jaa7GbUU37o8LW0s
         ayVthp8LuYsK5l/b/dPDfB2DaGOusqYMCbUXUfeByuisPSmVYJKi/oAh/AVaI0vrG1Iq
         /vV129d79P+MPqNPxeXXBtnt5G4Dotm0bhHIt6aHGLcyNICHMDL0DZxx3RspC5EVeqg+
         lWxLIzP2dK/QNsvmAeiHjKwyCqgd4J2gmIOiWt7HntkE7P4fPL2XmCt/EcKelXK/aN0U
         JOpg==
X-Gm-Message-State: AOAM5330N3fZm27GCYilMVcFeJll6WAoLIjH/Go43L+xY29A560ssiYy
        zdgQq919c0SYyWWzS0p0BwvgLA==
X-Google-Smtp-Source: ABdhPJyYP6ih5NyMtAPGAWdZgmyLn86jOwpdpSEhTsVI6Cc2M1xnKVrEIyviusL5JGr0twuSd+0qkg==
X-Received: by 2002:a63:6886:0:b0:3c5:11f4:f055 with SMTP id d128-20020a636886000000b003c511f4f055mr6040567pgc.44.1653003102215;
        Thu, 19 May 2022 16:31:42 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ab9000b0016191b843e2sm4331249plr.235.2022.05.19.16.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 16:31:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tytso@mit.edu, Jason@zx2c4.com
Cc:     hch@lst.de, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] random: convert to using fops->read_iter()
Date:   Thu, 19 May 2022 17:31:36 -0600
Message-Id: <20220519233137.20415-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220519233137.20415-1-axboe@kernel.dk>
References: <20220519233137.20415-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a pre-requisite to writing up splice() again for the random
and urandom drivers.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/char/random.c | 44 ++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 0958fa91a964..d000fe6fbb5a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -397,11 +397,12 @@ void get_random_bytes(void *buf, size_t len)
 }
 EXPORT_SYMBOL(get_random_bytes);
 
-static ssize_t get_random_bytes_user(void __user *ubuf, size_t len)
+static ssize_t get_random_bytes_user(struct iov_iter *to)
 {
-	size_t block_len, left, ret = 0;
+	size_t block_len, ret = 0;
 	u32 chacha_state[CHACHA_STATE_WORDS];
 	u8 output[CHACHA_BLOCK_SIZE];
+	size_t len = iov_iter_count(to);
 
 	if (!len)
 		return 0;
@@ -418,25 +419,23 @@ static ssize_t get_random_bytes_user(void __user *ubuf, size_t len)
 	 * the user directly.
 	 */
 	if (len <= CHACHA_KEY_SIZE) {
-		ret = len - copy_to_user(ubuf, &chacha_state[4], len);
+		ret = copy_to_iter(&chacha_state[4], len, to);
 		goto out_zero_chacha;
 	}
 
 	for (;;) {
+		size_t copied;
+
 		chacha20_block(chacha_state, output);
 		if (unlikely(chacha_state[12] == 0))
 			++chacha_state[13];
 
 		block_len = min_t(size_t, len, CHACHA_BLOCK_SIZE);
-		left = copy_to_user(ubuf, output, block_len);
-		if (left) {
-			ret += block_len - left;
+		copied = copy_to_iter(output, block_len, to);
+		ret += copied;
+		if (copied != block_len)
 			break;
-		}
-
-		ubuf += block_len;
-		ret += block_len;
-		len -= block_len;
+		len -= copied;
 		if (!len)
 			break;
 
@@ -1248,6 +1247,9 @@ static void __cold try_to_generate_entropy(void)
 
 SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len, unsigned int, flags)
 {
+	struct iovec iov = { .iov_base = ubuf };
+	struct iov_iter iter;
+
 	if (flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE))
 		return -EINVAL;
 
@@ -1270,7 +1272,9 @@ SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len, unsigned int, flags
 		if (unlikely(ret))
 			return ret;
 	}
-	return get_random_bytes_user(ubuf, len);
+	iov.iov_len = len;
+	iov_iter_init(&iter, READ, &iov, 1, len);
+	return get_random_bytes_user(&iter);
 }
 
 static __poll_t random_poll(struct file *file, poll_table *wait)
@@ -1314,8 +1318,7 @@ static ssize_t random_write(struct file *file, const char __user *ubuf,
 	return (ssize_t)len;
 }
 
-static ssize_t urandom_read(struct file *file, char __user *ubuf,
-			    size_t len, loff_t *ppos)
+static ssize_t urandom_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 {
 	static int maxwarn = 10;
 
@@ -1332,22 +1335,21 @@ static ssize_t urandom_read(struct file *file, char __user *ubuf,
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
@@ -1409,7 +1411,7 @@ static int random_fasync(int fd, struct file *filp, int on)
 }
 
 const struct file_operations random_fops = {
-	.read = random_read,
+	.read_iter = random_read_iter,
 	.write = random_write,
 	.poll = random_poll,
 	.unlocked_ioctl = random_ioctl,
@@ -1419,7 +1421,7 @@ const struct file_operations random_fops = {
 };
 
 const struct file_operations urandom_fops = {
-	.read = urandom_read,
+	.read_iter = urandom_read_iter,
 	.write = random_write,
 	.unlocked_ioctl = random_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
-- 
2.35.1

