Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C495600DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbiF2NIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiF2NHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:07:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB7739BAE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:07:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C41661DFD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 13:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E926BC34114;
        Wed, 29 Jun 2022 13:07:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GGQZiZRq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656508041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tt6O9oFpgSW1be2gi+tkV3zV3GgcM4jVqfcAvlW31+g=;
        b=GGQZiZRqndPmOSUe39Om8ZAl5KPNn8plE38hWfuS3k5+k98Ilsbgm6vVlbMLTto+rUDOqe
        WipsReO+D1MtXrj5cNyB5XOhyH5qFzK19HEtdmhtpftruho0OCRObCdgQIEKOBWSXvUTuq
        n8c3UWClj+XOQC2fkSJZ6NcE8qo4TRI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cf6b3aac (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 29 Jun 2022 13:07:21 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v3 6/7] dma-buf: remove useless FMODE_LSEEK flag
Date:   Wed, 29 Jun 2022 15:07:01 +0200
Message-Id: <20220629130702.954310-7-Jason@zx2c4.com>
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

This is already set by anon_inode_getfile(), since dma_buf_fops has
non-NULL ->llseek, so we don't need to set it here too.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/dma-buf/dma-buf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 32f55640890c..3f08e0b960ec 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -549,7 +549,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 		goto err_dmabuf;
 	}
 
-	file->f_mode |= FMODE_LSEEK;
 	dmabuf->file = file;
 
 	mutex_init(&dmabuf->lock);
-- 
2.35.1

