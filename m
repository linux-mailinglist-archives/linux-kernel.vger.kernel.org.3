Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1409D5600B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbiF2NH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiF2NHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:07:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A39E3056A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:07:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD22EB8247C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 13:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28345C34114;
        Wed, 29 Jun 2022 13:07:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DXAtfjYX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656508033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvE0BKgPDO1cJ8ektMA5oLNbrpPCbklfBAJRfkPtISQ=;
        b=DXAtfjYXWdb18qM61XU1udfp19hbvKqM0JdDxRofNMfHXG1T/a057g0Exq60OP4mMEnARr
        oxrb6lLVAIfDo2/vkZGY5EbC7v+3Fj44F3CmZV3+oCbvqhw//unbD6qcIlxVm0ZMM7dZXK
        6/6wzFesfbmHYTqL2+RswUk6g2OI7k0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 37953b19 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 29 Jun 2022 13:07:13 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 3/7] fs: check FMODE_LSEEK to control internal pipe splicing
Date:   Wed, 29 Jun 2022 15:06:58 +0200
Message-Id: <20220629130702.954310-4-Jason@zx2c4.com>
In-Reply-To: <20220629130702.954310-1-Jason@zx2c4.com>
References: <20220629130702.954310-1-Jason@zx2c4.com>
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

The original direct splicing mechanism from Jens required the input to
be a regular file because it was avoiding the special socket case. It
also recognized blkdevs as being close enough to a regular file. But it
forgot about chardevs, which behave the same way and work fine here.

This is an okayish heuristic, but it doesn't totally work. For example,
a few chardevs should be spliceable here. And a few regular files
shouldn't. This patch fixes this by instead checking whether FMODE_LSEEK
is set, which represents decently enough what we need rewinding for when
splicing to internal pipes.

Fixes: b92ce5589374 ("[PATCH] splice: add direct fd <-> fd splicing support")
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 fs/splice.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 047b79db8eb5..93a2c9bf6249 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -814,17 +814,15 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 {
 	struct pipe_inode_info *pipe;
 	long ret, bytes;
-	umode_t i_mode;
 	size_t len;
 	int i, flags, more;
 
 	/*
-	 * We require the input being a regular file, as we don't want to
-	 * randomly drop data for eg socket -> socket splicing. Use the
-	 * piped splicing for that!
+	 * We require the input to be seekable, as we don't want to randomly
+	 * drop data for eg socket -> socket splicing. Use the piped splicing
+	 * for that!
 	 */
-	i_mode = file_inode(in)->i_mode;
-	if (unlikely(!S_ISREG(i_mode) && !S_ISBLK(i_mode)))
+	if (unlikely(!(in->f_mode & FMODE_LSEEK)))
 		return -EINVAL;
 
 	/*
-- 
2.35.1

