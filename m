Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14E352DDD6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244544AbiESTbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbiESTbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:31:38 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B662340F1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 12:31:38 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id s12so4302030iln.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 12:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I26Y3sjJgoEOJyE8IwpRuHAsv+OINUDBnys4ArSZn+s=;
        b=zyPwJW4kDBbt0MZCL9+U2rZ7ipHLh3t3CPzn4OFvK/hfH9J+xTSMEBoGc8YbbpajBF
         kvmxZK1BTqM1hj7+FqPtdPBtyXV/65JvfrpOuyJurC+v5QwqgbeY4zSQ0WrdmLOiENZs
         G/KogBc5C4jlSj88BMG3I/JHJWYPlAC16H9vosnAbf835Uxf+0z6DzxuaCBzxeQAg/K1
         RXuTRw4fUSCAOEYknixIrZrMSZQWtizBDkdu13J6FIxgrd9fhyhrpQ8PrYS+/xYmJOfq
         FU9m39x2oeyznJk6iWHN2V2kgnF1wIs+3zCwtQPpc4sQRzQAwNvpLAXD7b+lud55Hl1h
         RYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I26Y3sjJgoEOJyE8IwpRuHAsv+OINUDBnys4ArSZn+s=;
        b=GwEpGacNr5LLc69pia+LlN5sJMwNXZ+pADO+fzgOWvmORazxTrheE9YZc8uUFyRuZ8
         njpx3zhXseEPnaYcEhWRb+IwcD6vz2U7eE+Lx38aOj0lIALXoJVnXFGgEGdsXvQfI4u4
         DGFFRjyzZFkgcpWkYosJEXD/urHMMf8uFumkLXSkntQlbQG9ptL5d08fSS4wwzFiBsXG
         SIynk1K98N4h5c73kVffW71kITlCcn3B+62HYkc9eaJun4jsN3qi2MdKvLwmSdX9bZTg
         0Z96lk0USUfY1GX24KkbykJpdC81RR6ek8me1idP0yeDlTmTsJhVGiyIKbuCpop7f84B
         LP4A==
X-Gm-Message-State: AOAM5313ZCaaC+9GbylF72HH5Wwsk62C6ffgV18oUcXtehP4GVG8ZYSN
        nKYW66UUFIo1q9NBF1KVQ14I/3FM5vlwLA==
X-Google-Smtp-Source: ABdhPJxskmKOm5qmqWyBCY8GDoLgZa4TK1Lrzmc/3KngQmb+Np3MJtdrdzHgie9qgR/lZOOHQhWi6w==
X-Received: by 2002:a92:3606:0:b0:2cf:45d6:c777 with SMTP id d6-20020a923606000000b002cf45d6c777mr3519301ila.110.1652988697409;
        Thu, 19 May 2022 12:31:37 -0700 (PDT)
Received: from m1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y10-20020a05663824ca00b0032e7456da06sm134390jat.15.2022.05.19.12.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 12:31:36 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tytso@mit.edu, Jason@zx2c4.com
Cc:     hch@lst.de, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] random: convert to using fops->read_iter()
Date:   Thu, 19 May 2022 13:31:32 -0600
Message-Id: <20220519193133.194138-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220519193133.194138-1-axboe@kernel.dk>
References: <20220519193133.194138-1-axboe@kernel.dk>
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
 drivers/char/random.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4c9adb4f3d5d..529afd31d549 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -528,11 +528,12 @@ void get_random_bytes(void *buf, size_t nbytes)
 }
 EXPORT_SYMBOL(get_random_bytes);
 
-static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
+static ssize_t get_random_bytes_user(struct iov_iter *to)
 {
-	size_t len, left, ret = 0;
+	size_t len, ret = 0;
 	u32 chacha_state[CHACHA_STATE_WORDS];
 	u8 output[CHACHA_BLOCK_SIZE];
+	size_t nbytes = iov_iter_count(to);
 
 	if (!nbytes)
 		return 0;
@@ -549,7 +550,7 @@ static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
 	 * the user directly.
 	 */
 	if (nbytes <= CHACHA_KEY_SIZE) {
-		ret = nbytes - copy_to_user(buf, &chacha_state[4], nbytes);
+		ret = copy_to_iter(&chacha_state[4], nbytes, to);
 		goto out_zero_chacha;
 	}
 
@@ -559,13 +560,10 @@ static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
 			++chacha_state[13];
 
 		len = min_t(size_t, nbytes, CHACHA_BLOCK_SIZE);
-		left = copy_to_user(buf, output, len);
-		if (left) {
-			ret += len - left;
+		len = copy_to_iter(output, len, to);
+		if (!len)
 			break;
-		}
 
-		buf += len;
 		ret += len;
 		nbytes -= len;
 		if (!nbytes)
@@ -1466,6 +1464,9 @@ static void try_to_generate_entropy(void)
 SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count, unsigned int,
 		flags)
 {
+	struct iovec iov = { .iov_base = buf };
+	struct iov_iter iter;
+
 	if (flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE))
 		return -EINVAL;
 
@@ -1488,7 +1489,9 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count, unsigned int,
 		if (unlikely(ret))
 			return ret;
 	}
-	return get_random_bytes_user(buf, count);
+	iov.iov_len = count;
+	iov_iter_init(&iter, READ, &iov, 1, count);
+	return get_random_bytes_user(&iter);
 }
 
 static __poll_t random_poll(struct file *file, poll_table *wait)
@@ -1540,8 +1543,7 @@ static ssize_t random_write(struct file *file, const char __user *buffer,
 	return (ssize_t)count;
 }
 
-static ssize_t urandom_read(struct file *file, char __user *buf, size_t nbytes,
-			    loff_t *ppos)
+static ssize_t urandom_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 {
 	static int maxwarn = 10;
 
@@ -1556,21 +1558,20 @@ static ssize_t urandom_read(struct file *file, char __user *buf, size_t nbytes,
 		maxwarn--;
 		if (__ratelimit(&urandom_warning))
 			pr_notice("%s: uninitialized urandom read (%zd bytes read)\n",
-				  current->comm, nbytes);
+				  current->comm, iov_iter_count(to));
 	}
 
-	return get_random_bytes_user(buf, nbytes);
+	return get_random_bytes_user(to);
 }
 
-static ssize_t random_read(struct file *file, char __user *buf, size_t nbytes,
-			   loff_t *ppos)
+static ssize_t random_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 {
 	int ret;
 
 	ret = wait_for_random_bytes();
 	if (ret != 0)
 		return ret;
-	return get_random_bytes_user(buf, nbytes);
+	return get_random_bytes_user(to);
 }
 
 static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
@@ -1639,7 +1640,7 @@ static int random_fasync(int fd, struct file *filp, int on)
 }
 
 const struct file_operations random_fops = {
-	.read = random_read,
+	.read_iter = random_read_iter,
 	.write = random_write,
 	.poll = random_poll,
 	.unlocked_ioctl = random_ioctl,
@@ -1649,7 +1650,7 @@ const struct file_operations random_fops = {
 };
 
 const struct file_operations urandom_fops = {
-	.read = urandom_read,
+	.read_iter = urandom_read_iter,
 	.write = random_write,
 	.unlocked_ioctl = random_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
-- 
2.35.1

