Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE9351C087
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379248AbiEENZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiEENZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:25:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6434A44A0A;
        Thu,  5 May 2022 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651756896; x=1683292896;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kq5s4HkqETdpFGmupob4Ar1Psqe2LdMq9WDLKKEnRjQ=;
  b=Z/jgZoxK4/2fmmOSQ1j+STBfn42JulH3+qJrTGamTvjjqveJdcQd4sLH
   oJMV1f/tPeK8ioSmektT03KrTnlqr5yakUqMi5FSfv9pXWtue4gIdKFec
   BVxigLlT8jPsxdDqWOI5Rtcnhp/9q39Cz83ykXOUvg3s69JQKL1rC34iQ
   P7uYxeUxIHmzC8MiUlv+OzMj4uJ6rPw0AZ3BQ/EdWlCjzA+Y1+XE0N47Z
   9OXesKhDqqsk/XDXMyNaoAHR+UvIvzhmZAe0fmt1S5syXzn6x89e4JPaW
   aUFFqj6xrv84VRhzthQLuAhZpGJwD88zBw9n6uA3UBBIQOdR2geZEIpi9
   w==;
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="157919934"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2022 06:21:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 5 May 2022 06:21:34 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 5 May 2022 06:21:33 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>
CC:     <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [RFC PATCH] media: atmel: atmel-isc: move media_pipeline_* to (un)prepare cb
Date:   Thu, 5 May 2022 16:21:31 +0300
Message-ID: <20220505132131.50994-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the media_pipeline_start/stop calls from start/stop streaming to
the new prepare_streaming and unprepare_streaming callbacks.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---

Only applies on top of
[RFC PATCHv2] vb2: add support for (un)prepare_streaming queue ops

and the series
[PATCH v10 0/5] media: atmel: atmel-isc: implement media controller
+
[PATCH v10 0/8] media: atmel: atmel-isc: various fixes



 drivers/media/platform/atmel/atmel-isc-base.c | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index 4d71e92aa5ea..894c22081397 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -324,6 +324,13 @@ static int isc_configure(struct isc_device *isc)
 	return isc_update_profile(isc);
 }
 
+static int isc_prepare_streaming(struct vb2_queue *vq)
+{
+	struct isc_device *isc = vb2_get_drv_priv(vq);
+
+	return media_pipeline_start(&isc->video_dev.entity, &isc->mpipe);
+}
+
 static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
 {
 	struct isc_device *isc = vb2_get_drv_priv(vq);
@@ -332,10 +339,6 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
 	unsigned long flags;
 	int ret;
 
-	ret = media_pipeline_start(&isc->video_dev.entity, &isc->mpipe);
-	if (ret)
-		goto err_pipeline_start;
-
 	/* Enable stream on the sub device */
 	ret = v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 1);
 	if (ret && ret != -ENOIOCTLCMD) {
@@ -384,9 +387,6 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
 	v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 0);
 
 err_start_stream:
-	media_pipeline_stop(&isc->video_dev.entity);
-
-err_pipeline_start:
 	spin_lock_irqsave(&isc->dma_queue_lock, flags);
 	list_for_each_entry(buf, &isc->dma_queue, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
@@ -396,6 +396,14 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
 	return ret;
 }
 
+static void isc_unprepare_streaming(struct vb2_queue *vq)
+{
+	struct isc_device *isc = vb2_get_drv_priv(vq);
+
+	/* Stop media pipeline */
+	media_pipeline_stop(&isc->video_dev.entity);
+}
+
 static void isc_stop_streaming(struct vb2_queue *vq)
 {
 	struct isc_device *isc = vb2_get_drv_priv(vq);
@@ -425,9 +433,6 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 	if (ret && ret != -ENOIOCTLCMD)
 		v4l2_err(&isc->v4l2_dev, "stream off failed in subdev\n");
 
-	/* Stop media pipeline */
-	media_pipeline_stop(&isc->video_dev.entity);
-
 	/* Release all active buffers */
 	spin_lock_irqsave(&isc->dma_queue_lock, flags);
 	if (unlikely(isc->cur_frm)) {
@@ -466,6 +471,8 @@ static const struct vb2_ops isc_vb2_ops = {
 	.start_streaming	= isc_start_streaming,
 	.stop_streaming		= isc_stop_streaming,
 	.buf_queue		= isc_buffer_queue,
+	.prepare_streaming	= isc_prepare_streaming,
+	.unprepare_streaming	= isc_unprepare_streaming,
 };
 
 static int isc_querycap(struct file *file, void *priv,
-- 
2.25.1

