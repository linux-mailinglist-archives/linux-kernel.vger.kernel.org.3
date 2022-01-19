Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F1649360C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352255AbiASIOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351847AbiASIOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:14:23 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C126C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:14:23 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d12-20020a17090a628c00b001b4f47e2f51so2487861pjj.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nq/jKaSRe1/bkQM30U4aQy+RmE3rXa2zMWjbS6Sz4No=;
        b=BasuHzcz+xsL2EYzisN5MTFI5/39w44WqD8D57AnJbipJHEtataULAmhjBn0OIV1AU
         dMRoZ8R7bu40V0220L0PiLJYIehoIFXH4cVl/SW+tHoSWgk/EX/3/0pZZY3GFSQUz8pX
         lHb+TA3+kGT5DJze04wdiLHtfBZLczseuCwjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nq/jKaSRe1/bkQM30U4aQy+RmE3rXa2zMWjbS6Sz4No=;
        b=Gk/ymnEyIkh3iVevgaUD8O/vLEAuMZFZIc45QAAuuWLmxSHfS2jQnjobseH5qDeOPy
         jnLEmitWrPb3imqVs8J9oPeT2u/H4ypDeSS8d6TAc58yKLIm2p6aBiwJYWD7Hk+a8Wb/
         xtX2wsta6ySUlhXCAfRhtMQIE4j6GCW9MubofnqunDIMestbo3GVviqnEhWkPXVNncoX
         Et6azGpZ8sBRH1aicavmg0a6mimxjCb0a2xAiwWzJ/aILejy+6exYQISjZec2TMxct91
         L8oot+nrkbTBS2ilRWpCNjOrEDWnhEwVlIe6dbX4dVDiIWdr33wBYCCJ/mcf9wMdme0f
         iaFQ==
X-Gm-Message-State: AOAM5314KnlDVxJXrP3j0lZ/srGPFRvC48RSRoalYHjQhnv2KM2l/SGG
        thPR1Wi4AEiS5l4WrwZw4I8X3g==
X-Google-Smtp-Source: ABdhPJwhR2yLhXftLhKAUkPrMElACWDPYckLp6U6HO0QVqNgDZ/KhnxLLweIwCs6CYg8QqZwC0H2pQ==
X-Received: by 2002:a17:90b:4b47:: with SMTP id mi7mr2943908pjb.79.1642580063062;
        Wed, 19 Jan 2022 00:14:23 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:3343:314a:558d:5df7])
        by smtp.gmail.com with ESMTPSA id nl3sm5128635pjb.36.2022.01.19.00.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 00:14:22 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] media: videobuf2-dma-contig: Invalidate vmap range before DMA range
Date:   Wed, 19 Jan 2022 17:14:17 +0900
Message-Id: <20220119081417.20604-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph suggests [1] that invalidating vmap range before
direct mapping range makes more sense.

[1]: https://lore.kernel.org/all/20220111085958.GA22795@lst.de/
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 .../media/common/videobuf2/videobuf2-dma-contig.c    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index 7c4096e62173..0e3f264122af 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -132,12 +132,12 @@ static void vb2_dc_prepare(void *buf_priv)
 	if (!buf->non_coherent_mem)
 		return;
 
-	/* For both USERPTR and non-coherent MMAP */
-	dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
-
 	/* Non-coherent MMAP only */
 	if (buf->vaddr)
 		flush_kernel_vmap_range(buf->vaddr, buf->size);
+
+	/* For both USERPTR and non-coherent MMAP */
+	dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
 }
 
 static void vb2_dc_finish(void *buf_priv)
@@ -152,12 +152,12 @@ static void vb2_dc_finish(void *buf_priv)
 	if (!buf->non_coherent_mem)
 		return;
 
-	/* For both USERPTR and non-coherent MMAP */
-	dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
-
 	/* Non-coherent MMAP only */
 	if (buf->vaddr)
 		invalidate_kernel_vmap_range(buf->vaddr, buf->size);
+
+	/* For both USERPTR and non-coherent MMAP */
+	dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
 }
 
 /*********************************************/
-- 
2.34.1.703.g22d0c6ccf7-goog

