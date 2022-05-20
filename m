Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561DB52E14A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344078AbiETAlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343938AbiETAlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:41:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413BB35265
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:41:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E568761AC8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DE8C385B8;
        Fri, 20 May 2022 00:41:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fwWP7O5j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653007270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vkxnEo4pirJjax+GcZ9VlzCPXywbCo9wzJe/TT1cyeM=;
        b=fwWP7O5j6wOB2ya+VD3CPI4mjd/9uFa4CBgbzIVHaQ8o3Nxw4MZBReUJ8UcWaIUkndsr59
        AMMjoXW0qKsp2Oe8qusThwiDhQ7FRkrdJuUeuhnUYfUfO1Y/5VIvkYpsrb9OeFFwVJy5mb
        i8zNvQRFgKghurRm0onRg7SsRunFza8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 166ebe75 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 00:41:09 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v3 3/3] random: wire up fops->splice_{read,write}_iter()
Date:   Fri, 20 May 2022 02:40:58 +0200
Message-Id: <20220520004058.96691-4-Jason@zx2c4.com>
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

Now that random/urandom is using {read,write}_iter, we can wire it up to
using the generic splice handlers.

Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[Jason: added the splice_write path.]
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a664e2b89ae0..90d779c5d1a1 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1417,6 +1417,8 @@ const struct file_operations random_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
+	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 };
 
 const struct file_operations urandom_fops = {
@@ -1426,6 +1428,8 @@ const struct file_operations urandom_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
+	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 };
 
 
-- 
2.35.1

