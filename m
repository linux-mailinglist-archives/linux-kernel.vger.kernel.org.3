Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03A8497C08
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiAXJeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:34:11 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:42326 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiAXJeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:34:01 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 20O9QVlT054148;
        Mon, 24 Jan 2022 17:26:31 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 Jan
 2022 17:33:48 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/4] media: aspeed: Fix timing polarity incorrect
Date:   Mon, 24 Jan 2022 17:33:45 +0800
Message-ID: <20220124093345.3935-5-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124093345.3935-1-jammy_huang@aspeedtech.com>
References: <20220124093345.3935-1-jammy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 20O9QVlT054148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a workaround for polarity detection unstable.
Because h/v sync polarity got from VR098 could be wrong, we try to use
ast SoC's characteristic to confirm sync polarity.

In ast SoC's design, sync value got by VR09C counts from sync's rising
edge, which means sync value = bp + active + fp if negative polarity.
Thus, sync value would be larger than de if negative.

Ex. 1920x1200@60
  VR098: c4d3efff, VR09C: 04cc001f
  v-total = 0x4D3 (VR098[27:16]) = 1235
  v-sync  = 0x4CC (VR09C[27:16]) = 1228

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 v3:
  - Use active rather than 'total/2' as critera for workaround
 v2:
  - Use 'total/2' rather than 'total<<1'
  - Update comment
---
 drivers/media/platform/aspeed-video.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 7e988cd05161..a135a31b4234 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -985,6 +985,20 @@ static void aspeed_video_get_timings(struct aspeed_video *v,
 	vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
 	hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
 
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
 	if (det->polarities & V4L2_DV_VSYNC_POS_POL) {
 		det->vbackporch = v->frame_top - vsync;
 		det->vfrontporch = vtotal - v->frame_bottom;
-- 
2.25.1

