Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF6247CDF9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243266AbhLVIVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:21:53 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:24152 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbhLVIVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:21:52 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1BM8GBaG076076;
        Wed, 22 Dec 2021 16:16:11 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Dec
 2021 16:21:37 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] media: aspeed: Correct values for detected timing
Date:   Wed, 22 Dec 2021 16:21:38 +0800
Message-ID: <20211222082139.26933-4-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222082139.26933-1-jammy_huang@aspeedtech.com>
References: <20211222082139.26933-1-jammy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1BM8GBaG076076
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
            |  |     |    v i d e o      |     |  |
         +--+  +-----+                   +-----+  +---+

       vsync+--+
   frame_top+--------+
frame_bottom+----------------------------+

                  +-------------------+
                  |    v i d e o      |
      +--+  +-----+                   +-----+  +---+
         |  |                               |  |
         +--+                               +--+
       vsync+-------------------------------+
   frame_top+-----+
frame_bottom+-------------------------+

[Horizontal timing]
            +--+     +-------------------+     +--+
            |  |     |    v i d e o      |     |  |
         +--+  +-----+                   +-----+  +---+

       hsync+--+
  frame_left+--------+
 frame_right+----------------------------+

                  +-------------------+
                  |    v i d e o      |
      +--+  +-----+                   +-----+  +---+
         |  |                               |  |
         +--+                               +--+
       hsync+-------------------------------+
  frame_left+-----+
 frame_right+-------------------------+

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 v2:
  - Code refined per Joel's suggestion
  - Update commit message to have name matching variable
---
 drivers/media/platform/aspeed-video.c | 30 ++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index c241038ee27c..7c50567f5ab0 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -936,7 +936,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 	u32 src_lr_edge;
 	u32 src_tb_edge;
 	u32 sync;
-	u32 htotal;
+	u32 htotal, vtotal, vsync, hsync;
 	struct v4l2_bt_timings *det = &video->detected_timings;
 
 	det->width = MIN_WIDTH;
@@ -983,21 +983,35 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 		mds = aspeed_video_read(video, VE_MODE_DETECT_STATUS);
 		sync = aspeed_video_read(video, VE_SYNC_STATUS);
 		htotal = aspeed_video_read(video, VE_H_TOTAL_PIXELS);
+		vtotal = FIELD_GET(VE_MODE_DETECT_V_LINES, mds);
+		vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
+		hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
 
 		video->frame_bottom = FIELD_GET(VE_SRC_TB_EDGE_DET_BOT, src_tb_edge);
 		video->frame_top = FIELD_GET(VE_SRC_TB_EDGE_DET_TOP, src_tb_edge);
-		det->vfrontporch = video->frame_top;
-		det->vbackporch = FIELD_GET(VE_MODE_DETECT_V_LINES, mds) -
-			video->frame_bottom;
-		det->vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
+		if (det->polarities & V4L2_DV_VSYNC_POS_POL) {
+			det->vbackporch = video->frame_top - vsync;
+			det->vfrontporch = vtotal - video->frame_bottom;
+			det->vsync = vsync;
+		} else {
+			det->vbackporch = video->frame_top;
+			det->vfrontporch = vsync - video->frame_bottom;
+			det->vsync = vtotal - vsync;
+		}
 		if (video->frame_top > video->frame_bottom)
 			continue;
 
 		video->frame_right = FIELD_GET(VE_SRC_LR_EDGE_DET_RT, src_lr_edge);
 		video->frame_left = FIELD_GET(VE_SRC_LR_EDGE_DET_LEFT, src_lr_edge);
-		det->hfrontporch = video->frame_left;
-		det->hbackporch = htotal - video->frame_right;
-		det->hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
+		if (det->polarities & V4L2_DV_HSYNC_POS_POL) {
+			det->hbackporch = video->frame_left - hsync;
+			det->hfrontporch = htotal - video->frame_right;
+			det->hsync = hsync;
+		} else {
+			det->hbackporch = video->frame_left;
+			det->hfrontporch = hsync - video->frame_right;
+			det->hsync = htotal - hsync;
+		}
 		if (video->frame_left > video->frame_right)
 			continue;
 
-- 
2.25.1

