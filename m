Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EBF5836D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiG1CXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiG1CXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:23:52 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E6A3C8C6;
        Wed, 27 Jul 2022 19:23:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f7so776181pjp.0;
        Wed, 27 Jul 2022 19:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YT7aKqQdyjtmWHNW8sJ30cGPw+a1f4DRON6Lwnb0qmw=;
        b=K5WUDv/bFfh0EhZsJ+2pmMbJxlNWOE0b0btX6cchVBgbv/hQus5BixPzqsCFG2ByXy
         N55Sxsz9WTGnndrIWqJU18LsdZRHRGXqRw2tPQkHzQbTCQhGPddB2qumQu7s6cFjssBd
         9w2RB01vBa5g/uof538d/QrwwAM+QdbTQoSMHUxz3S6OzuQxyEuyNkl/q9Qz9XFOLLyG
         /mGpP4ATzxu1VK3cPLN5HQEmdfIZKLy0zDCU+NWcaXP9zUmw+X/Q+2k2KF9h7+RtpYN+
         prvlYgVQDtB6tEnNDjzcZdxRl10lsiwtlmgg1++torwKWl3JInpTTc/7Ay2ZecD4wuRZ
         /uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YT7aKqQdyjtmWHNW8sJ30cGPw+a1f4DRON6Lwnb0qmw=;
        b=JWJmndK6+8Qxtnl2ILBCRnfA+1v0hat0FHeqNQl+WJvnqW2rL6BK+kWIyRVAfaHLDz
         mKKr2iDYTmMyuXDaV+rogN1Fe0ZFitnQYbif9wTe4fyEppgSuFXWGQRu6vG6KbMioHZA
         gLdJddf7SEXb0b3RbtZK8WGJ31fzV2Gmz5p73vD8FAVl4bJJb90dMoaBXD7E092blpz7
         l8XcyihT17sDazziPOudyZETPEz/2jOo9nJohQ3bIUtxGqR0R8iedCAPw6f7a77v3Xha
         MYMRFOvlDQt7pA3N8LBIvVav28o3bUiPY6gFHnFJD79YB30dN6lhMknxuvz+gMZ6JN+X
         0B3A==
X-Gm-Message-State: AJIora/9/8OcErWGGLCl1fQ8YygphHtrxj98gRtGRjKLVpXmEZ4TvS5f
        r42qmJKoL8p/Po9I3zQKoX+VU0xsDWNCmTA=
X-Google-Smtp-Source: AGRyM1sE76MS8HDzBiHGkjwAj0Vwd066DQUYW9ic2pAXcjXam5zCG5pqUBxVXKOpT1184Nmb5f2JaQ==
X-Received: by 2002:a17:903:3283:b0:16d:43f8:d971 with SMTP id jh3-20020a170903328300b0016d43f8d971mr22893634plb.171.1658975029873;
        Wed, 27 Jul 2022 19:23:49 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id s6-20020a170902a50600b0016a0ac06424sm14445329plq.51.2022.07.27.19.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 19:23:49 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        sakari.ailus@linux.intel.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] media: cx88: Fix a null-ptr-deref bug in buffer_prepare()
Date:   Thu, 28 Jul 2022 10:23:38 +0800
Message-Id: <20220728022338.466959-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver calls cx88_risc_buffer() to prepare the buffer, the
function call may fail, resulting in a empty buffer and null-ptr-deref
later in buffer_queue().

The following log can reveal it:

[   41.822762] general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
[   41.824488] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[   41.828027] RIP: 0010:buffer_queue+0xc2/0x500
[   41.836311] Call Trace:
[   41.836945]  __enqueue_in_driver+0x141/0x360
[   41.837262]  vb2_start_streaming+0x62/0x4a0
[   41.838216]  vb2_core_streamon+0x1da/0x2c0
[   41.838516]  __vb2_init_fileio+0x981/0xbc0
[   41.839141]  __vb2_perform_fileio+0xbf9/0x1120
[   41.840072]  vb2_fop_read+0x20e/0x400
[   41.840346]  v4l2_read+0x215/0x290
[   41.840603]  vfs_read+0x162/0x4c0

Fix this by checking the return value of cx88_risc_buffer()

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/media/pci/cx88/cx88-vbi.c   |  3 +-
 drivers/media/pci/cx88/cx88-video.c | 43 +++++++++++++++--------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/media/pci/cx88/cx88-vbi.c b/drivers/media/pci/cx88/cx88-vbi.c
index a075788c64d4..eb68499e5c23 100644
--- a/drivers/media/pci/cx88/cx88-vbi.c
+++ b/drivers/media/pci/cx88/cx88-vbi.c
@@ -144,11 +144,10 @@ static int buffer_prepare(struct vb2_buffer *vb)
 		return -EINVAL;
 	vb2_set_plane_payload(vb, 0, size);
 
-	cx88_risc_buffer(dev->pci, &buf->risc, sgt->sgl,
+	return cx88_risc_buffer(dev->pci, &buf->risc, sgt->sgl,
 			 0, VBI_LINE_LENGTH * lines,
 			 VBI_LINE_LENGTH, 0,
 			 lines);
-	return 0;
 }
 
 static void buffer_finish(struct vb2_buffer *vb)
diff --git a/drivers/media/pci/cx88/cx88-video.c b/drivers/media/pci/cx88/cx88-video.c
index d3729be89252..26336671e555 100644
--- a/drivers/media/pci/cx88/cx88-video.c
+++ b/drivers/media/pci/cx88/cx88-video.c
@@ -431,6 +431,7 @@ static int queue_setup(struct vb2_queue *q,
 
 static int buffer_prepare(struct vb2_buffer *vb)
 {
+	int ret;
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 	struct cx8800_dev *dev = vb->vb2_queue->drv_priv;
 	struct cx88_core *core = dev->core;
@@ -445,35 +446,35 @@ static int buffer_prepare(struct vb2_buffer *vb)
 
 	switch (core->field) {
 	case V4L2_FIELD_TOP:
-		cx88_risc_buffer(dev->pci, &buf->risc,
-				 sgt->sgl, 0, UNSET,
-				 buf->bpl, 0, core->height);
+		ret = cx88_risc_buffer(dev->pci, &buf->risc,
+						 sgt->sgl, 0, UNSET,
+						 buf->bpl, 0, core->height);
 		break;
 	case V4L2_FIELD_BOTTOM:
-		cx88_risc_buffer(dev->pci, &buf->risc,
-				 sgt->sgl, UNSET, 0,
-				 buf->bpl, 0, core->height);
+		ret = cx88_risc_buffer(dev->pci, &buf->risc,
+						 sgt->sgl, UNSET, 0,
+						 buf->bpl, 0, core->height);
 		break;
 	case V4L2_FIELD_SEQ_TB:
-		cx88_risc_buffer(dev->pci, &buf->risc,
-				 sgt->sgl,
-				 0, buf->bpl * (core->height >> 1),
-				 buf->bpl, 0,
-				 core->height >> 1);
+		ret = cx88_risc_buffer(dev->pci, &buf->risc,
+						 sgt->sgl,
+						 0, buf->bpl * (core->height >> 1),
+						 buf->bpl, 0,
+						 core->height >> 1);
 		break;
 	case V4L2_FIELD_SEQ_BT:
-		cx88_risc_buffer(dev->pci, &buf->risc,
-				 sgt->sgl,
-				 buf->bpl * (core->height >> 1), 0,
-				 buf->bpl, 0,
-				 core->height >> 1);
+		ret = cx88_risc_buffer(dev->pci, &buf->risc,
+						 sgt->sgl,
+						 buf->bpl * (core->height >> 1), 0,
+						 buf->bpl, 0,
+						 core->height >> 1);
 		break;
 	case V4L2_FIELD_INTERLACED:
 	default:
-		cx88_risc_buffer(dev->pci, &buf->risc,
-				 sgt->sgl, 0, buf->bpl,
-				 buf->bpl, buf->bpl,
-				 core->height >> 1);
+		ret = cx88_risc_buffer(dev->pci, &buf->risc,
+						 sgt->sgl, 0, buf->bpl,
+						 buf->bpl, buf->bpl,
+						 core->height >> 1);
 		break;
 	}
 	dprintk(2,
@@ -481,7 +482,7 @@ static int buffer_prepare(struct vb2_buffer *vb)
 		buf, buf->vb.vb2_buf.index, __func__,
 		core->width, core->height, dev->fmt->depth, dev->fmt->fourcc,
 		(unsigned long)buf->risc.dma);
-	return 0;
+	return ret;
 }
 
 static void buffer_finish(struct vb2_buffer *vb)
-- 
2.25.1

