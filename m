Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF296472DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbhLMNvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:51:46 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49039 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbhLMNvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403504; x=1670939504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c7zR7YV+/NaEAUBvJ084GX1l4HCMOCQS7YcMiVzt3gE=;
  b=R1GLg4Am3nZI7D3ugqjezRRcwFcdHclCLiUB5L3Ux/OCMx9KU70b+b9+
   pESAO99xJ2VtDla92D7xpj11NdDtn84nEfsjIFbXKjpY2Z2h6/aL5OcJm
   LD6ldzSAkjRKwI5OQUrbe0HL0TMQ3jagqCifguuFq++9IKi8en7XvBRrO
   Kp2KfOvP6B3tIcEIxMY7F2WcmmFMgGmEChXSzg/s9XGr6YfcMT07g2U57
   bD6JggaipOYlxj8ZAcm7BjlCguitulm8VkRbZs+DE5F7OcK4QpFqCGUdL
   AlwiRafbtZPuvJqXgL4kADnSfrymg+qpbV9KCLefYjLRI0JOmK/htSHIJ
   A==;
IronPort-SDR: y9aGpxpaDDb9680ihLzHFrF7XWaqk8xmeaTztOF144hdzbmAuoPqba6C3pUHD4BiXa4qhpUs4a
 OPJ2Kzrx1HC0cQJxUoTRfFD9e4ikLMBfNaamNSmq6ErfJPz1F7oS6+xhEoMECBGjonlIZQk3t0
 6Gni4F5vrRUwgkxQIXM/13MDr64gQmsHF/33NVjaurIz9PQfXIVk6YkBgsO11S90PkELUS25UY
 XowK2fv9oEEhD8eVKpj+RoRAY7m4NHVD9yv5SDNHZvnpX9IZNoK1mIhMztaksxWqOsuqZoqPXK
 t6bn0vnZ3t5RV6Nn+6TbM6mq
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="79361613"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:51:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:51:43 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:51:30 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 07/23] media: atmel: atmel-isc-base: use streaming status when queueing buffers
Date:   Mon, 13 Dec 2021 15:49:24 +0200
Message-ID: <20211213134940.324266-8-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During experiments with libcamera, it looks like vb2_is_streaming returns
true before our start streaming is called.
Order of operations is streamon -> queue -> start_streaming
ISC would have started the DMA immediately when a buffer is being added
to the vbqueue if the queue is streaming.
It is more safe to start the DMA after the start streaming of the driver is
called.
Thus, even if vb2queue is streaming, add the buffer to the dma queue of the
driver instead of actually starting the DMA process, if the start streaming
has not been called yet.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index 26a6090f056c..e6c9071c04f0 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -441,12 +441,14 @@ static void isc_buffer_queue(struct vb2_buffer *vb)
 	unsigned long flags;
 
 	spin_lock_irqsave(&isc->dma_queue_lock, flags);
-	if (!isc->cur_frm && list_empty(&isc->dma_queue) &&
-		vb2_is_streaming(vb->vb2_queue)) {
+
+	if (!isc->cur_frm && list_empty(&isc->dma_queue) && !isc->stop) {
 		isc->cur_frm = buf;
 		isc_start_dma(isc);
-	} else
+	} else {
 		list_add_tail(&buf->list, &isc->dma_queue);
+	}
+
 	spin_unlock_irqrestore(&isc->dma_queue_lock, flags);
 }
 
@@ -1014,7 +1016,7 @@ static int isc_s_fmt_vid_cap(struct file *file, void *priv,
 {
 	struct isc_device *isc = video_drvdata(file);
 
-	if (vb2_is_streaming(&isc->vb2_vidq))
+	if (!isc->stop)
 		return -EBUSY;
 
 	return isc_set_fmt(isc, f);
@@ -1536,7 +1538,7 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
 
 		isc_update_awb_ctrls(isc);
 
-		if (vb2_is_streaming(&isc->vb2_vidq)) {
+		if (!isc->stop) {
 			/*
 			 * If we are streaming, we can update profile to
 			 * have the new settings in place.
@@ -1552,8 +1554,7 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
 		}
 
 		/* if we have autowhitebalance on, start histogram procedure */
-		if (ctrls->awb == ISC_WB_AUTO &&
-		    vb2_is_streaming(&isc->vb2_vidq) &&
+		if (ctrls->awb == ISC_WB_AUTO && !isc->stop &&
 		    ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code))
 			isc_set_histogram(isc, true);
 
@@ -1829,6 +1830,8 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	struct vb2_queue *q = &isc->vb2_vidq;
 	int ret = 0;
 
+	isc->stop = true;
+
 	INIT_WORK(&isc->awb_work, isc_awb_work);
 
 	ret = v4l2_device_register_subdev_nodes(&isc->v4l2_dev);
-- 
2.25.1

