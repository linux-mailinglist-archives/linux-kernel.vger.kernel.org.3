Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD4C49C0D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbiAZBsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:48:18 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:31690 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbiAZBsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:48:16 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 20Q1eoOV090812;
        Wed, 26 Jan 2022 09:40:50 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 Jan
 2022 09:48:13 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/2] media: aspeed: Fix unstable timing detection
Date:   Wed, 26 Jan 2022 09:47:25 +0800
Message-ID: <20220126014725.1511-3-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126014725.1511-1-jammy_huang@aspeedtech.com>
References: <20220126014725.1511-1-jammy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 20Q1eoOV090812
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using stable-signal in resolution detection, and try detection again
if unstable.

VE_MODE_DETECT_EXTSRC_ADC: 1 if video source is from ADC output.
VE_MODE_DETECT_H_STABLE: 1 if horizontal signal detection is stable.
VE_MODE_DETECT_V_STABLE: 1 if vertical signal detection is stable.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/media/platform/aspeed-video.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 5d1ec3de50ad..eb9c17ac0e14 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -153,9 +153,14 @@
 
 #define VE_MODE_DETECT_STATUS		0x098
 #define  VE_MODE_DETECT_H_PERIOD	GENMASK(11, 0)
+#define  VE_MODE_DETECT_EXTSRC_ADC	BIT(12)
+#define  VE_MODE_DETECT_H_STABLE	BIT(13)
+#define  VE_MODE_DETECT_V_STABLE	BIT(14)
 #define  VE_MODE_DETECT_V_LINES		GENMASK(27, 16)
 #define  VE_MODE_DETECT_STATUS_VSYNC	BIT(28)
 #define  VE_MODE_DETECT_STATUS_HSYNC	BIT(29)
+#define  VE_MODE_DETECT_VSYNC_RDY	BIT(30)
+#define  VE_MODE_DETECT_HSYNC_RDY	BIT(31)
 
 #define VE_SYNC_STATUS			0x09c
 #define  VE_SYNC_STATUS_HSYNC		GENMASK(11, 0)
@@ -909,6 +914,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 	bool invalid_resolution = true;
 	int rc;
 	int tries = 0;
+	u32 mds;
 	u32 src_lr_edge;
 	u32 src_tb_edge;
 	struct v4l2_bt_timings *det = &video->detected_timings;
@@ -939,6 +945,13 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 			return;
 		}
 
+		mds = aspeed_video_read(video, VE_MODE_DETECT_STATUS);
+		// try detection again if current signal isn't stable
+		if (!(mds & VE_MODE_DETECT_H_STABLE) ||
+		    !(mds & VE_MODE_DETECT_V_STABLE) ||
+		    (mds & VE_MODE_DETECT_EXTSRC_ADC))
+			continue;
+
 		aspeed_video_check_and_set_polarity(video);
 
 		aspeed_video_enable_mode_detect(video);
-- 
2.25.1

