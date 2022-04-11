Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395034FB58F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343547AbiDKIEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343526AbiDKID6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:03:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8C3DE8;
        Mon, 11 Apr 2022 01:01:44 -0700 (PDT)
X-UUID: cbce46d03cda4f509c2a93359d02afd7-20220411
X-UUID: cbce46d03cda4f509c2a93359d02afd7-20220411
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <ping-lei.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2070875496; Mon, 11 Apr 2022 16:01:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Apr 2022 16:01:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 16:01:34 +0800
From:   James_Lin <Ping-lei.Lin@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Arnd Bergmann <arnd@arndb.de>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Ming Qian <ming.qian@nxp.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <ping-lei.lin@mediatek.com>,
        <lecopzer.chen@mediatek.com>, <max.yan@mediatek.com>,
        <sherlock.chang@mediatek.com>, <tm.wu@mediatek.com>,
        James_Lin <Ping-lei.Lin@mediatek.com>
Subject: [PATCH v2 1/2] media: usb: uvc: Add H265 pixel format
Date:   Mon, 11 Apr 2022 16:01:19 +0800
Message-ID: <20220411080120.26008-2-Ping-lei.Lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220411080120.26008-1-Ping-lei.Lin@mediatek.com>
References: <20220411080120.26008-1-Ping-lei.Lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add H265 pixel format.
So driver can recognize external camera devices 
whom use h265 to describe High Efficiency Video Coding method.

Signed-off-by: James_Lin <Ping-lei.Lin@mediatek.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 5 +++++
 drivers/media/usb/uvc/uvcvideo.h   | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index dda0f0aa78b8..ebb807c33e57 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -154,6 +154,11 @@ static struct uvc_format_desc uvc_fmts[] = {
 		.guid		= UVC_GUID_FORMAT_H264,
 		.fcc		= V4L2_PIX_FMT_H264,
 	},
+	{
+		.name		= "H.265",
+		.guid		= UVC_GUID_FORMAT_H265,
+		.fcc		= V4L2_PIX_FMT_H265,
+	},
 	{
 		.name		= "Greyscale 8 L/R (Y8I)",
 		.guid		= UVC_GUID_FORMAT_Y8I,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 143230b3275b..41f4d8c33f2a 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -139,6 +139,9 @@
 #define UVC_GUID_FORMAT_H264 \
 	{ 'H',  '2',  '6',  '4', 0x00, 0x00, 0x10, 0x00, \
 	 0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
+#define UVC_GUID_FORMAT_H265 \
+	{ 'H',  '2',  '6',  '5', 0x00, 0x00, 0x10, 0x00, \
+	 0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
 #define UVC_GUID_FORMAT_Y8I \
 	{ 'Y',  '8',  'I',  ' ', 0x00, 0x00, 0x10, 0x00, \
 	 0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
-- 
2.18.0

