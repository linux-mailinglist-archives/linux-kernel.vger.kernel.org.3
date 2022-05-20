Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662E752ED83
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349983AbiETNut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiETNus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:50:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED11C0F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63F12B8294A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96137C385A9;
        Fri, 20 May 2022 13:50:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HAWKMXdY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653054639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5timXZFetmQYFCHoBi31th0HfU6/LKM9n08r9qPl9BE=;
        b=HAWKMXdY316oNqe4MsSCKN9RA9v0ML3n8rhLzdK7+mqUvmqvraq8v1ygsRrWJEokYr3tVi
        nB5Pjb+ibDpIROHiu1fe4ZAqMbw2lGToRbP4NM8yEM8eD01gOh2LVXWTRWtxuX8dOE1Ibk
        KeWCVFO3OqSNXyIeNDPjTdQLCgNJ5KI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6783fb84 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 13:50:39 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] char/mem: only use {read,write}_iter, not the old {read,write} functions
Date:   Fri, 20 May 2022 15:50:30 +0200
Message-Id: <20220520135030.166831-1-Jason@zx2c4.com>
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

Currently mem.c implements both the {read,write}_iter functions and the
{read,write} functions. But with {read,write} going away at some point
in the future, and most kernel code made to prefer {read,write}_iter,
there's no point in keeping around the old code. Actually, this comment
in __kernel_read() indicates that having both might be plain wrong:

        /*
         * Also fail if ->read_iter and ->read are both wired up as that
         * implies very convoluted semantics.
         */
        if (unlikely(!file->f_op->read_iter || file->f_op->read))
                return warn_unsupported(file, "read");

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/mem.c | 44 --------------------------------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index cc296f0823bd..0eb36b784b29 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -444,18 +444,6 @@ static ssize_t write_port(struct file *file, const char __user *buf,
 	return tmp-buf;
 }
 
-static ssize_t read_null(struct file *file, char __user *buf,
-			 size_t count, loff_t *ppos)
-{
-	return 0;
-}
-
-static ssize_t write_null(struct file *file, const char __user *buf,
-			  size_t count, loff_t *ppos)
-{
-	return count;
-}
-
 static ssize_t read_iter_null(struct kiocb *iocb, struct iov_iter *to)
 {
 	return 0;
@@ -504,33 +492,6 @@ static ssize_t read_iter_zero(struct kiocb *iocb, struct iov_iter *iter)
 	return written;
 }
 
-static ssize_t read_zero(struct file *file, char __user *buf,
-			 size_t count, loff_t *ppos)
-{
-	size_t cleared = 0;
-
-	while (count) {
-		size_t chunk = min_t(size_t, count, PAGE_SIZE);
-		size_t left;
-
-		left = clear_user(buf + cleared, chunk);
-		if (unlikely(left)) {
-			cleared += (chunk - left);
-			if (!cleared)
-				return -EFAULT;
-			break;
-		}
-		cleared += chunk;
-		count -= chunk;
-
-		if (signal_pending(current))
-			break;
-		cond_resched();
-	}
-
-	return cleared;
-}
-
 static int mmap_zero(struct file *file, struct vm_area_struct *vma)
 {
 #ifndef CONFIG_MMU
@@ -640,7 +601,6 @@ static int open_port(struct inode *inode, struct file *filp)
 
 #define zero_lseek	null_lseek
 #define full_lseek      null_lseek
-#define write_zero	write_null
 #define write_iter_zero	write_iter_null
 #define open_mem	open_port
 
@@ -658,8 +618,6 @@ static const struct file_operations __maybe_unused mem_fops = {
 
 static const struct file_operations null_fops = {
 	.llseek		= null_lseek,
-	.read		= read_null,
-	.write		= write_null,
 	.read_iter	= read_iter_null,
 	.write_iter	= write_iter_null,
 	.splice_write	= splice_write_null,
@@ -674,9 +632,7 @@ static const struct file_operations __maybe_unused port_fops = {
 
 static const struct file_operations zero_fops = {
 	.llseek		= zero_lseek,
-	.write		= write_zero,
 	.read_iter	= read_iter_zero,
-	.read		= read_zero,
 	.write_iter	= write_iter_zero,
 	.mmap		= mmap_zero,
 	.get_unmapped_area = get_unmapped_area_zero,
-- 
2.35.1

