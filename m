Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90708482ADC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 12:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiABLow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 06:44:52 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:57343 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiABLov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 06:44:51 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 3zI8nnkadTdRT3zI9nVcQv; Sun, 02 Jan 2022 12:44:50 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 02 Jan 2022 12:44:50 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     awalls@md.metrocast.net, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] media: Remove usage of the deprecated "pci-dma-compat.h" API
Date:   Sun,  2 Jan 2022 12:44:47 +0100
Message-Id: <b739c087e520c9b99bae3ff0a97c691b7fe3f60a.1641123690.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In [1], Christoph Hellwig has proposed to remove the wrappers in
include/linux/pci-dma-compat.h.

Some reasons why this API should be removed have been given by Julia
Lawall in [2].

A coccinelle script has been used to perform the needed transformation.
Only relevant parts are given below.

@@ @@
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE

@@ @@
-    PCI_DMA_NONE
+    DMA_NONE

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
+    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_device(e1, e2, e3, e4)
+    dma_sync_single_for_device(&e1->dev, e2, e3, e4)

[1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
[2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/pci/cx18/cx18-queue.h |  6 +++---
 drivers/media/pci/ivtv/ivtv-queue.h | 25 ++++++++++++++-----------
 drivers/media/pci/ivtv/ivtv-udma.h  |  8 ++++----
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/media/pci/cx18/cx18-queue.h b/drivers/media/pci/cx18/cx18-queue.h
index e0a34bd6539e..26f2097c0496 100644
--- a/drivers/media/pci/cx18/cx18-queue.h
+++ b/drivers/media/pci/cx18/cx18-queue.h
@@ -15,15 +15,15 @@
 static inline void cx18_buf_sync_for_cpu(struct cx18_stream *s,
 	struct cx18_buffer *buf)
 {
-	pci_dma_sync_single_for_cpu(s->cx->pci_dev, buf->dma_handle,
+	dma_sync_single_for_cpu(&s->cx->pci_dev->dev, buf->dma_handle,
 				s->buf_size, s->dma);
 }
 
 static inline void cx18_buf_sync_for_device(struct cx18_stream *s,
 	struct cx18_buffer *buf)
 {
-	pci_dma_sync_single_for_device(s->cx->pci_dev, buf->dma_handle,
-				s->buf_size, s->dma);
+	dma_sync_single_for_device(&s->cx->pci_dev->dev, buf->dma_handle,
+				   s->buf_size, s->dma);
 }
 
 void _cx18_mdl_sync_for_device(struct cx18_stream *s, struct cx18_mdl *mdl);
diff --git a/drivers/media/pci/ivtv/ivtv-queue.h b/drivers/media/pci/ivtv/ivtv-queue.h
index 586b0bf63c26..b8fc2669a358 100644
--- a/drivers/media/pci/ivtv/ivtv-queue.h
+++ b/drivers/media/pci/ivtv/ivtv-queue.h
@@ -17,20 +17,20 @@
 
 static inline int ivtv_might_use_pio(struct ivtv_stream *s)
 {
-	return s->dma == PCI_DMA_NONE || (SLICED_VBI_PIO && s->type == IVTV_ENC_STREAM_TYPE_VBI);
+	return s->dma == DMA_NONE || (SLICED_VBI_PIO && s->type == IVTV_ENC_STREAM_TYPE_VBI);
 }
 
 static inline int ivtv_use_pio(struct ivtv_stream *s)
 {
 	struct ivtv *itv = s->itv;
 
-	return s->dma == PCI_DMA_NONE ||
+	return s->dma == DMA_NONE ||
 	    (SLICED_VBI_PIO && s->type == IVTV_ENC_STREAM_TYPE_VBI && itv->vbi.sliced_in->service_set);
 }
 
 static inline int ivtv_might_use_dma(struct ivtv_stream *s)
 {
-	return s->dma != PCI_DMA_NONE;
+	return s->dma != DMA_NONE;
 }
 
 static inline int ivtv_use_dma(struct ivtv_stream *s)
@@ -41,15 +41,16 @@ static inline int ivtv_use_dma(struct ivtv_stream *s)
 static inline void ivtv_buf_sync_for_cpu(struct ivtv_stream *s, struct ivtv_buffer *buf)
 {
 	if (ivtv_use_dma(s))
-		pci_dma_sync_single_for_cpu(s->itv->pdev, buf->dma_handle,
-				s->buf_size + 256, s->dma);
+		dma_sync_single_for_cpu(&s->itv->pdev->dev, buf->dma_handle,
+					s->buf_size + 256, s->dma);
 }
 
 static inline void ivtv_buf_sync_for_device(struct ivtv_stream *s, struct ivtv_buffer *buf)
 {
 	if (ivtv_use_dma(s))
-		pci_dma_sync_single_for_device(s->itv->pdev, buf->dma_handle,
-				s->buf_size + 256, s->dma);
+		dma_sync_single_for_device(&s->itv->pdev->dev,
+					   buf->dma_handle, s->buf_size + 256,
+					   s->dma);
 }
 
 int ivtv_buf_copy_from_user(struct ivtv_stream *s, struct ivtv_buffer *buf, const char __user *src, int copybytes);
@@ -70,15 +71,17 @@ void ivtv_stream_free(struct ivtv_stream *s);
 static inline void ivtv_stream_sync_for_cpu(struct ivtv_stream *s)
 {
 	if (ivtv_use_dma(s))
-		pci_dma_sync_single_for_cpu(s->itv->pdev, s->sg_handle,
-			sizeof(struct ivtv_sg_element), PCI_DMA_TODEVICE);
+		dma_sync_single_for_cpu(&s->itv->pdev->dev, s->sg_handle,
+					sizeof(struct ivtv_sg_element),
+					DMA_TO_DEVICE);
 }
 
 static inline void ivtv_stream_sync_for_device(struct ivtv_stream *s)
 {
 	if (ivtv_use_dma(s))
-		pci_dma_sync_single_for_device(s->itv->pdev, s->sg_handle,
-			sizeof(struct ivtv_sg_element), PCI_DMA_TODEVICE);
+		dma_sync_single_for_device(&s->itv->pdev->dev, s->sg_handle,
+					   sizeof(struct ivtv_sg_element),
+					   DMA_TO_DEVICE);
 }
 
 #endif
diff --git a/drivers/media/pci/ivtv/ivtv-udma.h b/drivers/media/pci/ivtv/ivtv-udma.h
index 0eef104e03b9..12b9426b2db2 100644
--- a/drivers/media/pci/ivtv/ivtv-udma.h
+++ b/drivers/media/pci/ivtv/ivtv-udma.h
@@ -23,14 +23,14 @@ void ivtv_udma_start(struct ivtv *itv);
 
 static inline void ivtv_udma_sync_for_device(struct ivtv *itv)
 {
-	pci_dma_sync_single_for_device(itv->pdev, itv->udma.SG_handle,
-		sizeof(itv->udma.SGarray), PCI_DMA_TODEVICE);
+	dma_sync_single_for_device(&itv->pdev->dev, itv->udma.SG_handle,
+				   sizeof(itv->udma.SGarray), DMA_TO_DEVICE);
 }
 
 static inline void ivtv_udma_sync_for_cpu(struct ivtv *itv)
 {
-	pci_dma_sync_single_for_cpu(itv->pdev, itv->udma.SG_handle,
-		sizeof(itv->udma.SGarray), PCI_DMA_TODEVICE);
+	dma_sync_single_for_cpu(&itv->pdev->dev, itv->udma.SG_handle,
+				sizeof(itv->udma.SGarray), DMA_TO_DEVICE);
 }
 
 #endif
-- 
2.32.0

