Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34218495F88
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380572AbiAUNOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:14:53 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:17292 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380564AbiAUNOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642770892; x=1674306892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BYYXVCKs1JCrJsDzDJXziUYTB89mGKLgyoq8H+1C8Qk=;
  b=AopBZ1SWp3xlI99vhK4YX3SwsOyBJvhM/FyDPDiw3VIGIQzvmMb7v6To
   NnROq3w7BaQO6+AV72qFDjljy1OdH6tTepLOq2ufae7o5bxGkGCADEu/0
   fttW9G132Ey7j8Vv9O1GOdgV8pKFCEqg8NBBhl4fo1+Zo0wKHvCfrU0+Z
   vwxwjtRiTMRswnCC2LpbXkxuRT+L7QSKwGmsS4NiJUoaEijQRMcRl3Nno
   pLxtUmqkcEKZsSsmPP/nhAkApRS0JN2xalFHNnRdipsZRsZyEeingPb3V
   lYeVM17ucD5QDXR2drZfYtzrAV2kE0JDStL86EJlcxkXWvL5TvVpdzEIE
   Q==;
IronPort-SDR: poy7PptaPgGUdsUQgNjNBOK8se4QIPy8Vf4QOSi1iZcl+fUyd7WL7h5pas/XJj1gNyc7v+xNm5
 WttFiHymCQmVUomj7MLCraaZ03Qteg6woXEC8vIJTrfZ3RxbL69OiHOUIeDxZh0RL3BUjG8jIy
 WwWG6wueN4ROGNGPH6EyuKEy1sqcs6fMXQ6X+TpsQSt/yX3mQgNPCMEzVXm5iNlb38bT4pNV6v
 9CywHuKbsrR63sKuEioyh2VFZNjWvAKqL69N+gJQ+xGNUNY7t9DcsBVhzD4qAfDGNdTnAaJsGT
 0+sa1MH6vmGkIQqTD1JW7tNx
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="146183353"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2022 06:14:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 21 Jan 2022 06:14:50 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 21 Jan 2022 06:14:42 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <jacopo+renesas@jmondi.org>, <hverkuil-cisco@xs4all.nl>
CC:     <nicolas.ferre@microchip.com>, <sakari.ailus@iki.fi>,
        <laurent.pinchart@ideasonboard.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH v4 01/11] media: atmel: atmel-isc: replace 'stop' variable with vb2 calls
Date:   Fri, 21 Jan 2022 15:14:06 +0200
Message-ID: <20220121131416.603972-2-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121131416.603972-1-eugen.hristev@microchip.com>
References: <20220121131416.603972-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stop variable is redundant as the state of the streaming can be obtained
by calling vb2_start_streaming_called(&isc->vb2_vidq) or by calling
vb2_is_busy(&isc->vb2_vidq).
Thus, remove the stop variable completely.

Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v4:
- new patch

 drivers/media/platform/atmel/atmel-isc-base.c | 12 +++++-------
 drivers/media/platform/atmel/atmel-isc.h      |  2 --
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index db15770d5b88..9c62d0ae7887 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -362,7 +362,6 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
 	spin_lock_irqsave(&isc->dma_queue_lock, flags);
 
 	isc->sequence = 0;
-	isc->stop = false;
 	reinit_completion(&isc->comp);
 
 	isc->cur_frm = list_first_entry(&isc->dma_queue,
@@ -403,8 +402,6 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 
 	v4l2_ctrl_activate(isc->do_wb_ctrl, false);
 
-	isc->stop = true;
-
 	/* Wait until the end of the current frame */
 	if (isc->cur_frm && !wait_for_completion_timeout(&isc->comp, 5 * HZ))
 		v4l2_err(&isc->v4l2_dev,
@@ -1029,7 +1026,7 @@ static int isc_s_fmt_vid_cap(struct file *file, void *priv,
 {
 	struct isc_device *isc = video_drvdata(file);
 
-	if (vb2_is_streaming(&isc->vb2_vidq))
+	if (vb2_is_busy(&isc->vb2_vidq))
 		return -EBUSY;
 
 	return isc_set_fmt(isc, f);
@@ -1236,7 +1233,8 @@ irqreturn_t isc_interrupt(int irq, void *dev_id)
 			isc->cur_frm = NULL;
 		}
 
-		if (!list_empty(&isc->dma_queue) && !isc->stop) {
+		if (!list_empty(&isc->dma_queue) &&
+		    vb2_start_streaming_called(&isc->vb2_vidq)) {
 			isc->cur_frm = list_first_entry(&isc->dma_queue,
 						     struct isc_buffer, list);
 			list_del(&isc->cur_frm->list);
@@ -1244,7 +1242,7 @@ irqreturn_t isc_interrupt(int irq, void *dev_id)
 			isc_start_dma(isc);
 		}
 
-		if (isc->stop)
+		if (!vb2_start_streaming_called(&isc->vb2_vidq))
 			complete(&isc->comp);
 
 		ret = IRQ_HANDLED;
@@ -1398,7 +1396,7 @@ static void isc_awb_work(struct work_struct *w)
 	int ret;
 
 	/* streaming is not active anymore */
-	if (isc->stop)
+	if (!vb2_start_streaming_called(&isc->vb2_vidq))
 		return;
 
 	if (ctrls->hist_stat != HIST_ENABLED)
diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
index 07fa6dbf8460..5fbf52a9080b 100644
--- a/drivers/media/platform/atmel/atmel-isc.h
+++ b/drivers/media/platform/atmel/atmel-isc.h
@@ -201,7 +201,6 @@ struct isc_reg_offsets {
  * @dma_queue:		the queue for dma buffers
  * @cur_frm:		current isc frame/buffer
  * @sequence:		current frame number
- * @stop:		true if isc is not streaming, false if streaming
  * @comp:		completion reference that signals frame completion
  *
  * @fmt:		current v42l format
@@ -276,7 +275,6 @@ struct isc_device {
 	struct list_head	dma_queue;
 	struct isc_buffer	*cur_frm;
 	unsigned int		sequence;
-	bool			stop;
 	struct completion	comp;
 
 	struct v4l2_format	fmt;
-- 
2.25.1

