Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673FA47CDFA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243272AbhLVIV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:21:58 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:5715 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbhLVIV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:21:57 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1BM8GB1I076083;
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
Subject: [PATCH v2 4/4] media: aspeed: Fix timing polarity incorrect
Date:   Wed, 22 Dec 2021 16:21:39 +0800
Message-ID: <20211222082139.26933-5-jammy_huang@aspeedtech.com>
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
X-MAIL: twspam01.aspeedtech.com 1BM8GB1I076083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a workaround for sync polarity unstable.
Sync value get by VR09C counts from sync's rising edge, which means
sync's polarity is negative if sync value is bigger than total/2.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 v2:
  - Use 'total/2' rather than 'total<<1'
  - Update comment
---
 drivers/media/platform/aspeed-video.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 7c50567f5ab0..c3e3343d91e1 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -989,6 +989,16 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 
 		video->frame_bottom = FIELD_GET(VE_SRC_TB_EDGE_DET_BOT, src_tb_edge);
 		video->frame_top = FIELD_GET(VE_SRC_TB_EDGE_DET_TOP, src_tb_edge);
+
+		/*
+		 * This is a workaround for polarity detection when the sync
+		 * value is larger than half.
+		 */
+		if (vsync > (vtotal / 2))
+			det->polarities &= ~V4L2_DV_VSYNC_POS_POL;
+		else
+			det->polarities |= V4L2_DV_VSYNC_POS_POL;
+
 		if (det->polarities & V4L2_DV_VSYNC_POS_POL) {
 			det->vbackporch = video->frame_top - vsync;
 			det->vfrontporch = vtotal - video->frame_bottom;
@@ -1003,6 +1013,16 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 
 		video->frame_right = FIELD_GET(VE_SRC_LR_EDGE_DET_RT, src_lr_edge);
 		video->frame_left = FIELD_GET(VE_SRC_LR_EDGE_DET_LEFT, src_lr_edge);
+
+		/*
+		 * This is a workaround for polarity detection when the sync
+		 * value is larger than half.
+		 */
+		if (hsync > (htotal / 2))
+			det->polarities &= ~V4L2_DV_HSYNC_POS_POL;
+		else
+			det->polarities |= V4L2_DV_HSYNC_POS_POL;
+
 		if (det->polarities & V4L2_DV_HSYNC_POS_POL) {
 			det->hbackporch = video->frame_left - hsync;
 			det->hfrontporch = htotal - video->frame_right;
-- 
2.25.1

