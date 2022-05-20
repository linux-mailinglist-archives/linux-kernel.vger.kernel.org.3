Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AECD52ED84
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349993AbiETNvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350060AbiETNvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:51:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2DD2183
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D65E61A41
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67758C385A9;
        Fri, 20 May 2022 13:51:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DXDes+eQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653054666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nSTYvkNc0Kli2MjzgAhQgfzOMmCUcDFC3yLiCpm97cQ=;
        b=DXDes+eQMvAqO+6Iu7b9VTksQ6WQMZSLfT6RME2A/5O7CDdwvT0MGgztiB28cKYp0icUkM
        +5Zcc1aD/cG5bnPBqGa+ku7HVOQR9IOgd2ThtRnvSHVoNAmL6DZlGOv4F9lXSmws11r9Qf
        GWtLcFGOBO2bXkaWrDMSo1/LaL5Xh7M=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4bc6b890 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 13:51:06 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] fs: prefer read_iter over read and write_iter over write
Date:   Fri, 20 May 2022 15:51:03 +0200
Message-Id: <20220520135103.166972-1-Jason@zx2c4.com>
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

Most kernel code prefers read_iter over read and write_iter over write,
yet the read function pointer is tested first. Reverse these so that the
iter function is always used first.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 fs/read_write.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index e643aec2b0ef..78a81aa5fa76 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -476,10 +476,10 @@ ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
 
-	if (file->f_op->read)
-		ret = file->f_op->read(file, buf, count, pos);
-	else if (file->f_op->read_iter)
+	if (file->f_op->read_iter)
 		ret = new_sync_read(file, buf, count, pos);
+	else if (file->f_op->read)
+		ret = file->f_op->read(file, buf, count, pos);
 	else
 		ret = -EINVAL;
 	if (ret > 0) {
@@ -585,10 +585,10 @@ ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
 	file_start_write(file);
-	if (file->f_op->write)
-		ret = file->f_op->write(file, buf, count, pos);
-	else if (file->f_op->write_iter)
+	if (file->f_op->write_iter)
 		ret = new_sync_write(file, buf, count, pos);
+	else if (file->f_op->write)
+		ret = file->f_op->write(file, buf, count, pos);
 	else
 		ret = -EINVAL;
 	if (ret > 0) {
-- 
2.35.1

