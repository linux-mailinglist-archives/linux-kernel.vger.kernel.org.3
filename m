Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4117146AFF2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhLGBpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:45:36 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:58224 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbhLGBpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:45:35 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1B71GuqE058440;
        Tue, 7 Dec 2021 09:16:56 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 7 Dec
 2021 09:41:50 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] media: aspeed: use v4l2_info/v4l2_warn/v4l2_dbg for log
Date:   Tue, 7 Dec 2021 09:41:46 +0800
Message-ID: <20211207014147.226-2-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207014147.226-1-jammy_huang@aspeedtech.com>
References: <20211207014147.226-1-jammy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1B71GuqE058440
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debug log level, 0~3, is controlled by module_param, debug.
The higher the value, the more the information.
  0: off
  1: info
  2: debug
  3: register operations

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/media/platform/aspeed-video.c | 40 +++++++++++++++------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index f5c40d6b4ece..6af57467b6d4 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -30,6 +30,7 @@
 #include <media/v4l2-event.h>
 #include <media/v4l2-ioctl.h>
 #include <media/videobuf2-dma-contig.h>
+#include <linux/videodev2.h>
 
 #define DEVICE_NAME			"aspeed-video"
 
@@ -390,6 +391,8 @@ static const struct v4l2_dv_timings_cap aspeed_video_timings_cap = {
 	},
 };
 
+static unsigned int debug;
+
 static void aspeed_video_init_jpeg_table(u32 *table, bool yuv420)
 {
 	int i;
@@ -437,23 +440,23 @@ static void aspeed_video_update(struct aspeed_video *video, u32 reg, u32 clear,
 	t &= ~clear;
 	t |= bits;
 	writel(t, video->base + reg);
-	dev_dbg(video->dev, "update %03x[%08x -> %08x]\n", reg, before,
-		readl(video->base + reg));
+	v4l2_dbg(3, debug, &video->v4l2_dev, "update %03x[%08x -> %08x]\n",
+		 reg, before, readl(video->base + reg));
 }
 
 static u32 aspeed_video_read(struct aspeed_video *video, u32 reg)
 {
 	u32 t = readl(video->base + reg);
 
-	dev_dbg(video->dev, "read %03x[%08x]\n", reg, t);
+	v4l2_dbg(3, debug, &video->v4l2_dev, "read %03x[%08x]\n", reg, t);
 	return t;
 }
 
 static void aspeed_video_write(struct aspeed_video *video, u32 reg, u32 val)
 {
 	writel(val, video->base + reg);
-	dev_dbg(video->dev, "write %03x[%08x]\n", reg,
-		readl(video->base + reg));
+	v4l2_dbg(3, debug, &video->v4l2_dev, "write %03x[%08x]\n", reg,
+		 readl(video->base + reg));
 }
 
 static void update_perf(struct aspeed_video_perf *p)
@@ -474,13 +477,13 @@ static int aspeed_video_start_frame(struct aspeed_video *video)
 	u32 seq_ctrl = aspeed_video_read(video, VE_SEQ_CTRL);
 
 	if (video->v4l2_input_status) {
-		dev_dbg(video->dev, "No signal; don't start frame\n");
+		v4l2_warn(&video->v4l2_dev, "No signal; don't start frame\n");
 		return 0;
 	}
 
 	if (!(seq_ctrl & VE_SEQ_CTRL_COMP_BUSY) ||
 	    !(seq_ctrl & VE_SEQ_CTRL_CAP_BUSY)) {
-		dev_dbg(video->dev, "Engine busy; don't start frame\n");
+		v4l2_warn(&video->v4l2_dev, "Engine busy; don't start frame\n");
 		return -EBUSY;
 	}
 
@@ -489,7 +492,7 @@ static int aspeed_video_start_frame(struct aspeed_video *video)
 				       struct aspeed_video_buffer, link);
 	if (!buf) {
 		spin_unlock_irqrestore(&video->lock, flags);
-		dev_dbg(video->dev, "No buffers; don't start frame\n");
+		v4l2_warn(&video->v4l2_dev, "No buffers; don't start frame\n");
 		return -EPROTO;
 	}
 
@@ -569,7 +572,7 @@ static void aspeed_video_bufs_done(struct aspeed_video *video,
 
 static void aspeed_video_irq_res_change(struct aspeed_video *video, ulong delay)
 {
-	dev_dbg(video->dev, "Resolution changed; resetting\n");
+	v4l2_dbg(1, debug, &video->v4l2_dev, "Resolution changed; resetting\n");
 
 	set_bit(VIDEO_RES_CHANGE, &video->flags);
 	clear_bit(VIDEO_FRAME_INPRG, &video->flags);
@@ -770,8 +773,8 @@ static void aspeed_video_calc_compressed_size(struct aspeed_video *video,
 	aspeed_video_write(video, VE_STREAM_BUF_SIZE,
 			   compression_buffer_size_reg);
 
-	dev_dbg(video->dev, "Max compressed size: %x\n",
-		video->max_compressed_size);
+	v4l2_dbg(1, debug, &video->v4l2_dev, "Max compressed size: %#x\n",
+		 video->max_compressed_size);
 }
 
 #define res_check(v) test_and_clear_bit(VIDEO_MODE_DETECT_DONE, &(v)->flags)
@@ -808,7 +811,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 						      res_check(video),
 						      MODE_DETECT_TIMEOUT);
 		if (!rc) {
-			dev_dbg(video->dev, "Timed out; first mode detect\n");
+			v4l2_warn(&video->v4l2_dev, "Timed out; first mode detect\n");
 			clear_bit(VIDEO_RES_DETECT, &video->flags);
 			return;
 		}
@@ -822,7 +825,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 						      MODE_DETECT_TIMEOUT);
 		clear_bit(VIDEO_RES_DETECT, &video->flags);
 		if (!rc) {
-			dev_dbg(video->dev, "Timed out; second mode detect\n");
+			v4l2_warn(&video->v4l2_dev, "Timed out; second mode detect\n");
 			return;
 		}
 
@@ -856,7 +859,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 	} while (invalid_resolution && (tries++ < INVALID_RESOLUTION_RETRIES));
 
 	if (invalid_resolution) {
-		dev_dbg(video->dev, "Invalid resolution detected\n");
+		v4l2_warn(&video->v4l2_dev, "Invalid resolution detected\n");
 		return;
 	}
 
@@ -873,8 +876,8 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 	aspeed_video_update(video, VE_SEQ_CTRL, 0,
 			    VE_SEQ_CTRL_AUTO_COMP | VE_SEQ_CTRL_EN_WATCHDOG);
 
-	dev_dbg(video->dev, "Got resolution: %dx%d\n", det->width,
-		det->height);
+	v4l2_dbg(1, debug, &video->v4l2_dev, "Got resolution: %dx%d\n",
+		 det->width, det->height);
 }
 
 static void aspeed_video_set_resolution(struct aspeed_video *video)
@@ -1501,7 +1504,7 @@ static void aspeed_video_stop_streaming(struct vb2_queue *q)
 				!test_bit(VIDEO_FRAME_INPRG, &video->flags),
 				STOP_TIMEOUT);
 	if (!rc) {
-		dev_dbg(video->dev, "Timed out when stopping streaming\n");
+		v4l2_warn(&video->v4l2_dev, "Timed out when stopping streaming\n");
 
 		/*
 		 * Need to force stop any DMA and try and get HW into a good
@@ -1851,6 +1854,9 @@ static struct platform_driver aspeed_video_driver = {
 
 module_platform_driver(aspeed_video_driver);
 
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Debug level (0=off,1=info,2=debug,3=reg ops)");
+
 MODULE_DESCRIPTION("ASPEED Video Engine Driver");
 MODULE_AUTHOR("Eddie James");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

