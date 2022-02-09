Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3A94AEE21
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiBIJjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:39:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiBIJfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:35:05 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CA6E011168
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:34:55 -0800 (PST)
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id 2198ZbGv073078
        for <linux-kernel@vger.kernel.org>; Wed, 9 Feb 2022 16:35:37 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2198YGiU072902;
        Wed, 9 Feb 2022 16:34:16 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Feb
 2022 16:42:27 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] media: aspeed: Use full swing as JFIF to fix incorrect color
Date:   Wed, 9 Feb 2022 16:42:25 +0800
Message-ID: <20220209084225.4456-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2198YGiU072902
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NO_DNS_FOR_FROM,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current settings for video capture rgb-2-yuv is BT.601(studio swing),
but JFIF uses BT.601(full swing) to deocde. This mismatch will lead
to incorrect color. For example, input RGB value, (0, 0, 255), will
become (16, 16, 235) after jpg decoded.

Add an enum, aspeed_video_capture_format, to define VR008[7:6]
capture format and correct default settings for video capture to fix
the problem.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
v2:
 - update subject from 'media: aspeed: Fix-incorrect-color' to
   'media: aspeed: Use full swing as JFIF to fix incorrect'
 - update commit message
 - add enum, aspeed_video_capture_format, to define VR008[7:6]
---
 drivers/media/platform/aspeed-video.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index eb9c17ac0e14..5bcf60b4628b 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -86,8 +86,6 @@
 #define  VE_CTRL_SOURCE			BIT(2)
 #define  VE_CTRL_INT_DE			BIT(4)
 #define  VE_CTRL_DIRECT_FETCH		BIT(5)
-#define  VE_CTRL_YUV			BIT(6)
-#define  VE_CTRL_RGB			BIT(7)
 #define  VE_CTRL_CAPTURE_FMT		GENMASK(7, 6)
 #define  VE_CTRL_AUTO_OR_CURSOR		BIT(8)
 #define  VE_CTRL_CLK_INVERSE		BIT(11)
@@ -202,6 +200,15 @@ enum {
 	VIDEO_CLOCKS_ON,
 };
 
+// for VE_CTRL_CAPTURE_FMT
+enum aspeed_video_capture_format {
+	VIDEO_CAP_FMT_YUV_STUDIO = 0,
+	VIDEO_CAP_FMT_YUV_FULL,
+	VIDEO_CAP_FMT_RGB,
+	VIDEO_CAP_FMT_GRAY,
+	VIDEO_CAP_FMT_MAX
+};
+
 struct aspeed_video_addr {
 	unsigned int size;
 	dma_addr_t dma;
@@ -1089,7 +1096,8 @@ static void aspeed_video_init_regs(struct aspeed_video *video)
 	u32 comp_ctrl = VE_COMP_CTRL_RSVD |
 		FIELD_PREP(VE_COMP_CTRL_DCT_LUM, video->jpeg_quality) |
 		FIELD_PREP(VE_COMP_CTRL_DCT_CHR, video->jpeg_quality | 0x10);
-	u32 ctrl = VE_CTRL_AUTO_OR_CURSOR;
+	u32 ctrl = VE_CTRL_AUTO_OR_CURSOR |
+		FIELD_PREP(VE_CTRL_CAPTURE_FMT, VIDEO_CAP_FMT_YUV_FULL);
 	u32 seq_ctrl = video->jpeg_mode;
 
 	if (video->frame_rate)
-- 
2.25.1

