Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E33749AC96
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358280AbiAYGrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:47:03 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:53380 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358031AbiAYGob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:44:31 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 20P6aluw078229;
        Tue, 25 Jan 2022 14:36:47 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 25 Jan
 2022 14:44:07 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/3] media: aspeed: Correct values for detected timing
Date:   Tue, 25 Jan 2022 14:44:09 +0800
Message-ID: <20220125064409.5502-4-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220125064409.5502-1-jammy_huang@aspeedtech.com>
References: <20220125064409.5502-1-jammy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 20P6aluw078229
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct timing's fp/sync/bp value based on the information below.
It should be noticed that the calculation formula should be changed
per sync polarity.

The sequence of signal: sync - backporch - video data - frontporch

The following registers start counting from sync's rising edge:
1. VR090: frame edge's left and right
2. VR094: frame edge's top and bottom
3. VR09C: counting from sync's rising edge to falling edge

[Vertical timing]
            +--+     +-------------------+     +--+
            |  |     |     v i d e o     |     |  |
         +--+  +-----+                   +-----+  +---+
       vsync+--+
   frame_top+--------+
frame_bottom+----------------------------+

                  +-------------------+
                  |     v i d e o     |
      +--+  +-----+                   +-----+  +---+
         |  |                               |  |
         +--+                               +--+
       vsync+-------------------------------+
   frame_top+-----+
frame_bottom+-------------------------+

[Horizontal timing]
            +--+     +-------------------+     +--+
            |  |     |     v i d e o     |     |  |
         +--+  +-----+                   +-----+  +---+
       hsync+--+
  frame_left+--------+
 frame_right+----------------------------+

                  +-------------------+
                  |     v i d e o     |
      +--+  +-----+                   +-----+  +---+
         |  |                               |  |
         +--+                               +--+
       hsync+-------------------------------+
  frame_left+-----+
 frame_right+-------------------------+

Ex. 1920x1200@60 whose vsync polarity is negative
  VR098: c4d3efff, VR09C: 04cc001f
  v-total = 0x4D3 (VR098[27:16]) = 1235
  v-sync  = 0x4CC (VR09C[27:16]) = 1228

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 v4:
  - Combine this one with patch 4
 v3:
  - Add API, aspeed_video_get_timings(), to handle the calculation of timings.
 v2:
  - Code refined per Joel's suggestion
  - Update commit message to have name matching variable
---
 drivers/media/platform/aspeed-video.c | 109 +++++++++++++++++++++++---
 1 file changed, 97 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index c241038ee27c..90cdc6fe0caa 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -925,6 +925,99 @@ static void aspeed_video_calc_compressed_size(struct aspeed_video *video,
 		 video->max_compressed_size);
 }
 
+/*
+ * Update v4l2_bt_timings per current status.
+ * frame_top/frame_bottom/frame_left/frame_right need to be ready.
+ *
+ * The following registers start counting from sync's rising edge:
+ * 1. VR090: frame edge's left and right
+ * 2. VR094: frame edge's top and bottom
+ * 3. VR09C: counting from sync's rising edge to falling edge
+ *
+ * [Vertical timing]
+ *             +--+     +-------------------+     +--+
+ *             |  |     |     v i d e o     |     |  |
+ *          +--+  +-----+                   +-----+  +---+
+ *        vsync+--+
+ *    frame_top+--------+
+ * frame_bottom+----------------------------+
+ *
+ *                   +-------------------+
+ *                   |     v i d e o     |
+ *       +--+  +-----+                   +-----+  +---+
+ *          |  |                               |  |
+ *          +--+                               +--+
+ *        vsync+-------------------------------+
+ *    frame_top+-----+
+ * frame_bottom+-------------------------+
+ *
+ * [Horizontal timing]
+ *             +--+     +-------------------+     +--+
+ *             |  |     |     v i d e o     |     |  |
+ *          +--+  +-----+                   +-----+  +---+
+ *        hsync+--+
+ *   frame_left+--------+
+ *  frame_right+----------------------------+
+ *
+ *                   +-------------------+
+ *                   |     v i d e o     |
+ *       +--+  +-----+                   +-----+  +---+
+ *          |  |                               |  |
+ *          +--+                               +--+
+ *        hsync+-------------------------------+
+ *   frame_left+-----+
+ *  frame_right+-------------------------+
+ *
+ * @v: the struct of aspeed_video
+ * @det: v4l2_bt_timings to be updated.
+ */
+static void aspeed_video_get_timings(struct aspeed_video *v,
+				     struct v4l2_bt_timings *det)
+{
+	u32 mds, sync, htotal, vtotal, vsync, hsync;
+
+	mds = aspeed_video_read(v, VE_MODE_DETECT_STATUS);
+	sync = aspeed_video_read(v, VE_SYNC_STATUS);
+	htotal = aspeed_video_read(v, VE_H_TOTAL_PIXELS);
+	vtotal = FIELD_GET(VE_MODE_DETECT_V_LINES, mds);
+	vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
+	hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
+
+	/*
+	 * This is a workaround for polarity detection.
+	 * Because ast-soc counts sync from sync's rising edge, the reg value
+	 * of sync would be larger than video's active area if negative.
+	 */
+	if (vsync > det->height)
+		det->polarities &= ~V4L2_DV_VSYNC_POS_POL;
+	else
+		det->polarities |= V4L2_DV_VSYNC_POS_POL;
+	if (hsync > det->width)
+		det->polarities &= ~V4L2_DV_HSYNC_POS_POL;
+	else
+		det->polarities |= V4L2_DV_HSYNC_POS_POL;
+
+	if (det->polarities & V4L2_DV_VSYNC_POS_POL) {
+		det->vbackporch = v->frame_top - vsync;
+		det->vfrontporch = vtotal - v->frame_bottom;
+		det->vsync = vsync;
+	} else {
+		det->vbackporch = v->frame_top;
+		det->vfrontporch = vsync - v->frame_bottom;
+		det->vsync = vtotal - vsync;
+	}
+
+	if (det->polarities & V4L2_DV_HSYNC_POS_POL) {
+		det->hbackporch = v->frame_left - hsync;
+		det->hfrontporch = htotal - v->frame_right;
+		det->hsync = hsync;
+	} else {
+		det->hbackporch = v->frame_left;
+		det->hfrontporch = hsync - v->frame_right;
+		det->hsync = htotal - hsync;
+	}
+}
+
 #define res_check(v) test_and_clear_bit(VIDEO_MODE_DETECT_DONE, &(v)->flags)
 
 static void aspeed_video_get_resolution(struct aspeed_video *video)
@@ -935,8 +1028,6 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 	u32 mds;
 	u32 src_lr_edge;
 	u32 src_tb_edge;
-	u32 sync;
-	u32 htotal;
 	struct v4l2_bt_timings *det = &video->detected_timings;
 
 	det->width = MIN_WIDTH;
@@ -980,24 +1071,16 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 
 		src_lr_edge = aspeed_video_read(video, VE_SRC_LR_EDGE_DET);
 		src_tb_edge = aspeed_video_read(video, VE_SRC_TB_EDGE_DET);
-		mds = aspeed_video_read(video, VE_MODE_DETECT_STATUS);
-		sync = aspeed_video_read(video, VE_SYNC_STATUS);
-		htotal = aspeed_video_read(video, VE_H_TOTAL_PIXELS);
 
 		video->frame_bottom = FIELD_GET(VE_SRC_TB_EDGE_DET_BOT, src_tb_edge);
 		video->frame_top = FIELD_GET(VE_SRC_TB_EDGE_DET_TOP, src_tb_edge);
-		det->vfrontporch = video->frame_top;
-		det->vbackporch = FIELD_GET(VE_MODE_DETECT_V_LINES, mds) -
-			video->frame_bottom;
-		det->vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
+
 		if (video->frame_top > video->frame_bottom)
 			continue;
 
 		video->frame_right = FIELD_GET(VE_SRC_LR_EDGE_DET_RT, src_lr_edge);
 		video->frame_left = FIELD_GET(VE_SRC_LR_EDGE_DET_LEFT, src_lr_edge);
-		det->hfrontporch = video->frame_left;
-		det->hbackporch = htotal - video->frame_right;
-		det->hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
+
 		if (video->frame_left > video->frame_right)
 			continue;
 
@@ -1013,6 +1096,8 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 	det->width = (video->frame_right - video->frame_left) + 1;
 	video->v4l2_input_status = 0;
 
+	aspeed_video_get_timings(video, det);
+
 	/*
 	 * Enable mode-detect watchdog, resolution-change watchdog and
 	 * automatic compression after frame capture.
-- 
2.25.1

