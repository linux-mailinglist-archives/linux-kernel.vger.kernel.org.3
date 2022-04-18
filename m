Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79622504E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 11:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiDRJKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 05:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiDRJKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 05:10:13 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155816472;
        Mon, 18 Apr 2022 02:07:33 -0700 (PDT)
X-UUID: 1f199b7dbfda49249de0c3a925becb73-20220418
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:8a168a53-d47d-4dbf-bd84-1b844faa3477,OB:0,LO
        B:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:100
X-CID-INFO: VERSION:1.1.4,REQID:8a168a53-d47d-4dbf-bd84-1b844faa3477,OB:0,LOB:
        10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:100
X-CID-META: VersionHash:faefae9,CLOUDID:549b3cef-06b0-4305-bfbf-554bfc9d151a,C
        OID:92f24a434910,Recheck:0,SF:12|15|28|16|19|48,TC:nil,Content:1,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 1f199b7dbfda49249de0c3a925becb73-20220418
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ping-lei.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 854381594; Mon, 18 Apr 2022 17:07:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Apr 2022 17:07:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Apr 2022 17:07:29 +0800
From:   James_Lin <Ping-lei.Lin@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Arnd Bergmann <arnd@arndb.de>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <ping-lei.lin@mediatek.com>,
        <sherlock.chang@mediatek.com>, <lecopzer.chen@mediatek.com>,
        <max.yan@mediatek.com>, <tm.wu@mediatek.com>,
        James_Lin <Ping-lei.Lin@mediatek.com>
Subject: [PATCH v3] media: usb: uvc: Add UVC_GUID_FORMAT_H265
Date:   Mon, 18 Apr 2022 17:06:52 +0800
Message-ID: <20220418090652.3156-1-Ping-lei.Lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

This patch aims to add UVC_GUID_FORMAT_H265
High Efficiency Video Coding (HEVC), also known as H.265 and MPEG-H Part 2.
They describe the same video encoding method.
So for handling their behavior is the same.
However, when external camera device describes this encoding method, 
some use hevc, some use h265.
There is no uniform specification to describe this encoding method.
So if an external camera device use h265 to describe this encoding method,
driver will not recognize it.
Therefore, this patch is to enable driver to read HEVC/H265 
and convert it to V4L2_PIX_FMT_HEVC.

Signed-off-by: James_Lin <Ping-lei.Lin@mediatek.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 5 +++++
 drivers/media/usb/uvc/uvcvideo.h   | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index dda0f0aa78b8..e437e9f95890 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -154,6 +154,11 @@ static struct uvc_format_desc uvc_fmts[] = {
 		.guid		= UVC_GUID_FORMAT_H264,
 		.fcc		= V4L2_PIX_FMT_H264,
 	},
+	{
+		.name		= "H.265",
+		.guid		= UVC_GUID_FORMAT_H265,
+		.fcc		= V4L2_PIX_FMT_HEVC,
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

