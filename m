Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48966478823
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhLQJyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:54:03 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:40775 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbhLQJyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:54:02 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1BH9SGrS026176;
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
Subject: [PATCH 4/4] media: aspeed: Fix timing polarity incorrect
Date:   Fri, 17 Dec 2021 17:54:03 +0800
Message-ID: <20211217095403.2618-5-jammy_huang@aspeedtech.com>
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
X-MAIL: twspam01.aspeedtech.com 1BH9SGrS026176
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a workaround for polarity unstable.
Sync value get by VR09C counts from sync's rising edge, which means
sync's polarity is negative if sync value is bigger than total/2.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/media/platform/aspeed-video.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 5ad3a20c5bac..f628f69bb7dd 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -989,6 +989,15 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 		video->frame_top = FIELD_GET(VE_SRC_TB_EDGE_DET_TOP,
 					     src_tb_edge);
 		det->vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
+		/*
+		 * Workaround for polarity detection
+		 * Use sync(VR098) counts from sync's rising edge till falling
+		 * edge to tell sync polarity.
+		 */
+		if (det->vsync > (FIELD_GET(VE_MODE_DETECT_V_LINES, mds) >> 1))
+			det->polarities &= ~V4L2_DV_VSYNC_POS_POL;
+		else
+			det->polarities |= V4L2_DV_VSYNC_POS_POL;
 		if (det->polarities & V4L2_DV_VSYNC_POS_POL) {
 			det->vbackporch = video->frame_top - det->vsync;
 			det->vfrontporch =
@@ -1010,6 +1019,15 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 		video->frame_left = FIELD_GET(VE_SRC_LR_EDGE_DET_LEFT,
 					      src_lr_edge);
 		det->hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
+		/*
+		 * Workaround for polarity detection
+		 * Use sync(VR098) counts from sync's rising edge till falling
+		 * edge to tell sync polarity.
+		 */
+		if (det->hsync > (htotal >> 1))
+			det->polarities &= ~V4L2_DV_HSYNC_POS_POL;
+		else
+			det->polarities |= V4L2_DV_HSYNC_POS_POL;
 		if (det->polarities & V4L2_DV_HSYNC_POS_POL) {
 			det->hbackporch = video->frame_left - det->hsync;
 			det->hfrontporch = htotal - video->frame_right;
-- 
2.25.1

