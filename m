Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11E7478822
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhLQJx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:53:58 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:57884 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbhLQJx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:53:57 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1BH9SGVB026175;
        Fri, 17 Dec 2021 17:28:16 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 17 Dec
 2021 17:53:46 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] media: aspeed: Correct values for detected timing
Date:   Fri, 17 Dec 2021 17:54:02 +0800
Message-ID: <20211217095403.2618-4-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217095403.2618-1-jammy_huang@aspeedtech.com>
References: <20211217095403.2618-1-jammy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1BH9SGVB026175
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

            +--+     +-------------------+     +--+
            |  |     |    v i d e o      |     |  |
         +--+  +-----+                   +-----+  +---+

        sync+--+
    left/top+--------+
right/bottom+----------------------------+

                  +-------------------+
                  |    v i d e o      |
      +--+  +-----+                   +-----+  +---+
         |  |                               |  |
         +--+                               +--+
        sync+-------------------------------+
    left/top+-----+
right/bottom+-------------------------+

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/media/platform/aspeed-video.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 581a4261f9b7..5ad3a20c5bac 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -988,10 +988,20 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 						src_tb_edge);
 		video->frame_top = FIELD_GET(VE_SRC_TB_EDGE_DET_TOP,
 					     src_tb_edge);
-		det->vfrontporch = video->frame_top;
-		det->vbackporch = FIELD_GET(VE_MODE_DETECT_V_LINES, mds) -
-			video->frame_bottom;
 		det->vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
+		if (det->polarities & V4L2_DV_VSYNC_POS_POL) {
+			det->vbackporch = video->frame_top - det->vsync;
+			det->vfrontporch =
+				FIELD_GET(VE_MODE_DETECT_V_LINES, mds) -
+				video->frame_bottom;
+		} else {
+			det->vsync = FIELD_GET(VE_MODE_DETECT_V_LINES, mds) -
+					       det->vsync;
+			det->vbackporch = video->frame_top;
+			det->vfrontporch =
+				FIELD_GET(VE_MODE_DETECT_V_LINES, mds) -
+				video->frame_bottom - det->vsync;
+		}
 		if (video->frame_top > video->frame_bottom)
 			continue;
 
@@ -999,9 +1009,16 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 					       src_lr_edge);
 		video->frame_left = FIELD_GET(VE_SRC_LR_EDGE_DET_LEFT,
 					      src_lr_edge);
-		det->hfrontporch = video->frame_left;
-		det->hbackporch = htotal - video->frame_right;
 		det->hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
+		if (det->polarities & V4L2_DV_HSYNC_POS_POL) {
+			det->hbackporch = video->frame_left - det->hsync;
+			det->hfrontporch = htotal - video->frame_right;
+		} else {
+			det->hsync = htotal - det->hsync;
+			det->hbackporch = video->frame_left;
+			det->hfrontporch = htotal - video->frame_right -
+					   det->hsync;
+		}
 		if (video->frame_left > video->frame_right)
 			continue;
 
-- 
2.25.1

