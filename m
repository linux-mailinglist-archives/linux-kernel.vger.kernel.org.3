Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96970495F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380590AbiAUNPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:15:22 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:38473 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350597AbiAUNPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642770921; x=1674306921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=90mw6wISjBdLTNNxTG/BgqJuSTNAKubVgA1+rrwpVU8=;
  b=MS4hnM566ZgJrR6qtUCUX7Xq11ktpCZf4Lm11Az4AZdSdzTtxewxUUWg
   A31j74Loj2k3snUX82uGyk4QV5sWpdzGezaMLBvp4mM5/uhgJO4cbfGfw
   OsNgQD7q3771hSo7XtKZkXqeIv4levcDd7N4git5UfvJ7RStNx7T4pUlO
   3XRXS1HpyrX5688VDjikrF3hIGyB3UTSgog5qpxGmVioYweUni4JgFcWN
   cTb+BSIXF4WMlMnqe5Wg5sNGjYsPH4tc5GgqTwrKBNWSc6pulYcVkXR+L
   6sc5M+fjepxW3D7jp38R6kSF3hmgPTeQmfNpboDPGby00nX4bSh88G1v5
   Q==;
IronPort-SDR: kTsR5MUwRq2CT9roV1nvuSx+4gF/i20ECvUj3IFbMyVRMb3Z+k0BlbmUowbD1vsLQne6FRN/nX
 yy1i7L1kmggSG+qnm9kIROw2ncatd517G/JqMQ/aGgOrOS/j1QBLeP7n9guvCQC4pT4lEJ+A44
 n58kjDdKo3ACFCVzvgoshNVAPRYHfyuix4T/H1hC3A/dnKCClgAtMwESxLf+7EaN0ZovlH3jBA
 kkKg5RzhUBH/Nx0UgkoiIRIDgjGZBk4OiOqhjqn4vKhlVYxkKOYerBcuU72BoTWrP4btkGqO3s
 oRYHxuPO+Jw9U9rruxaab2U9
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="150454050"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2022 06:15:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 21 Jan 2022 06:15:20 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 21 Jan 2022 06:14:51 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <jacopo+renesas@jmondi.org>, <hverkuil-cisco@xs4all.nl>
CC:     <nicolas.ferre@microchip.com>, <sakari.ailus@iki.fi>,
        <laurent.pinchart@ideasonboard.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v4 02/11] media: atmel: atmel-isc-base: use streaming status when queueing buffers
Date:   Fri, 21 Jan 2022 15:14:07 +0200
Message-ID: <20220121131416.603972-3-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121131416.603972-1-eugen.hristev@microchip.com>
References: <20220121131416.603972-1-eugen.hristev@microchip.com>
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
Tho achieve this, we have to use vb2_start_streaming_called instead of
vb2_is_streaming.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v4:
- changed to using vb2_start_streaming_called instead of stop variable

 drivers/media/platform/atmel/atmel-isc-base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index 9c62d0ae7887..6b0005987a17 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -439,7 +439,7 @@ static void isc_buffer_queue(struct vb2_buffer *vb)
 
 	spin_lock_irqsave(&isc->dma_queue_lock, flags);
 	if (!isc->cur_frm && list_empty(&isc->dma_queue) &&
-		vb2_is_streaming(vb->vb2_queue)) {
+		vb2_start_streaming_called(vb->vb2_queue)) {
 		isc->cur_frm = buf;
 		isc_start_dma(isc);
 	} else
@@ -1532,7 +1532,7 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
 
 		isc_update_awb_ctrls(isc);
 
-		if (vb2_is_streaming(&isc->vb2_vidq)) {
+		if (vb2_start_streaming_called(&isc->vb2_vidq)) {
 			/*
 			 * If we are streaming, we can update profile to
 			 * have the new settings in place.
@@ -1549,7 +1549,7 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
 
 		/* if we have autowhitebalance on, start histogram procedure */
 		if (ctrls->awb == ISC_WB_AUTO &&
-		    vb2_is_streaming(&isc->vb2_vidq) &&
+		    vb2_start_streaming_called(&isc->vb2_vidq) &&
 		    ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code))
 			isc_set_histogram(isc, true);
 
-- 
2.25.1

