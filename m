Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C3552E943
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347916AbiETJpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347950AbiETJp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:45:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C66814B651
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBC3CB82297
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F952C385A9;
        Fri, 20 May 2022 09:45:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WJZNLD9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653039919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w2s4/EPOaBhwby3ZhNih+pgq+QSJUBTa6LO6++W+QMM=;
        b=WJZNLD9udT66Q2OJs1CSqfzg2tQeckWdFjOBMG0jOwYpMaU8HWSpEd3GptR/P3ZgocBIZ7
        2/LsdcnPCeNI2vpeP1QZANzUvDqaYSN8vFureHCbybnHGQjudt6aQzW6hMIdEtVOf/R8KS
        9o7o116SPhCByBPpmOYTMoCp3edEgB4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e6914df7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 09:45:19 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v4 3/3] random: wire up fops->splice_{read,write}_iter()
Date:   Fri, 20 May 2022 11:44:59 +0200
Message-Id: <20220520094459.116240-4-Jason@zx2c4.com>
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

Now that random/urandom is using {read,write}_iter, we can wire it up to
using the generic splice handlers.

Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[Jason: added the splice_write path. Note that sendfile() and such still
 does not work for read, though it does for write, because of the
 outdated file type restriction in splice_direct_to_actor(), which I'll
 address separately.]
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 831cafcd1034..15a9e5ea1b3f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1412,6 +1412,8 @@ const struct file_operations random_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
+	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 };
 
 const struct file_operations urandom_fops = {
@@ -1421,6 +1423,8 @@ const struct file_operations urandom_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
+	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 };
 
 
-- 
2.35.1

