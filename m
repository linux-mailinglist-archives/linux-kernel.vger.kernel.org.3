Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFD64FB595
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343555AbiDKIEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343503AbiDKIEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:04:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9F527CDA;
        Mon, 11 Apr 2022 01:01:46 -0700 (PDT)
X-UUID: 4a2b0ca5b13a46c1a920e8599cd56a1a-20220411
X-UUID: 4a2b0ca5b13a46c1a920e8599cd56a1a-20220411
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ping-lei.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1209623131; Mon, 11 Apr 2022 16:01:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Apr 2022 16:01:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 16:01:39 +0800
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
Subject: [PATCH v2 2/2] media: v4l: Add H265 pixel format
Date:   Mon, 11 Apr 2022 16:01:20 +0800
Message-ID: <20220411080120.26008-3-Ping-lei.Lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220411080120.26008-1-Ping-lei.Lin@mediatek.com>
References: <20220411080120.26008-1-Ping-lei.Lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../userspace-api/media/v4l/pixfmt-compressed.rst      | 10 ++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c                   |  1 +
 include/uapi/linux/videodev2.h                         |  1 +
 3 files changed, 12 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
index 967fc803ef94..75292aafe2eb 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
@@ -36,6 +36,16 @@ Compressed Formats
       - MPEG multiplexed stream. The actual format is determined by
 	extended control ``V4L2_CID_MPEG_STREAM_TYPE``, see
 	:ref:`mpeg-control-id`.
+    * .. _V4L2-PIX-FMT-H265:
+
+      - ``V4L2_PIX_FMT_H265``
+      - 'H265'
+      - H.265 Access Unit.
+	The decoder expects one Access Unit per buffer.
+	The encoder generates one Access Unit per buffer.
+	If :ref:`VIDIOC_ENUM_FMT` reports ``V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM``
+	then the decoder has no	requirements since it can parse all the
+	information from the raw bytestream.
     * .. _V4L2-PIX-FMT-H264:
 
       - ``V4L2_PIX_FMT_H264``
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 96e307fe3aab..aeaeb29307a4 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1402,6 +1402,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_JPEG:		descr = "JFIF JPEG"; break;
 		case V4L2_PIX_FMT_DV:		descr = "1394"; break;
 		case V4L2_PIX_FMT_MPEG:		descr = "MPEG-1/2/4"; break;
+		case V4L2_PIX_FMT_H265:		descr = "H.265"; break;
 		case V4L2_PIX_FMT_H264:		descr = "H.264"; break;
 		case V4L2_PIX_FMT_H264_NO_SC:	descr = "H.264 (No Start Codes)"; break;
 		case V4L2_PIX_FMT_H264_MVC:	descr = "H.264 MVC"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 3768a0a80830..636e4236bfb8 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -691,6 +691,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_JPEG     v4l2_fourcc('J', 'P', 'E', 'G') /* JFIF JPEG     */
 #define V4L2_PIX_FMT_DV       v4l2_fourcc('d', 'v', 's', 'd') /* 1394          */
 #define V4L2_PIX_FMT_MPEG     v4l2_fourcc('M', 'P', 'E', 'G') /* MPEG-1/2/4 Multiplexed */
+#define V4L2_PIX_FMT_H265     v4l2_fourcc('H', '2', '6', '5') /* H265 with start codes */
 #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /* H264 with start codes */
 #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /* H264 without start codes */
 #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /* H264 MVC */
-- 
2.18.0

