Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB1F4D63DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbiCKOkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349601AbiCKOiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:38:08 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0B11C9472;
        Fri, 11 Mar 2022 06:36:54 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 75385240008;
        Fri, 11 Mar 2022 14:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xswwx9naACSRayy5J2yvzI10IWOb2cFHob9k2G9cPIo=;
        b=jvFRD/OyMrB/P2RaiH1rf8nVEXZOA4RIZeSnHGQzVLv9PH+XcMDoSvYzFAK/sR2pSJKmQN
        2J3A43En8u10TzyXnWPr7BhBq08jEbSKkf7/eyBR4VPxnR/WXt9zq8tfdM8DhcRlFQK+7D
        i9L3YgaGf1Yi/QTlKuK18N7jy2krzbUuuLoKZQ8BKC8Gemk76JRriLpqqHtx9CukPl1qYv
        GnPytbupYg6B3ZuLS3v0gaITa+FSvzz+VPnN+yRwFBwAPAXySL3483Sf4eoxoJcua9V7oX
        S4VDbSgr4hK39Yy8I9ZCSrDS/WQL4R6N/Q0/wwzb+eKo87TSdfhORdoJdi1Bxg==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 42/46] media: sun6i-csi: Add extra checks to the interrupt routine
Date:   Fri, 11 Mar 2022 15:35:28 +0100
Message-Id: <20220311143532.265091-43-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check against the enabled bits and make sure capture is running before
serving an interrupt, to add extra safety in the process.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 19b4f2fe58ff..b28e5eaf4622 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -105,13 +105,17 @@ static void sun6i_csi_v4l2_cleanup(struct sun6i_csi_device *csi_dev)
 static irqreturn_t sun6i_csi_isr(int irq, void *private)
 {
 	struct sun6i_csi_device *csi_dev = private;
+	bool capture_streaming = csi_dev->capture.state.streaming;
 	struct regmap *regmap = csi_dev->regmap;
-	u32 status;
+	u32 status = 0, enable = 0;
 
 	regmap_read(regmap, SUN6I_CSI_CH_INT_STA_REG, &status);
+	regmap_read(regmap, SUN6I_CSI_CH_INT_EN_REG, &enable);
 
-	if (!(status & 0xFF))
+	if (!status)
 		return IRQ_NONE;
+	else if (!(status & enable) || !capture_streaming)
+		goto complete;
 
 	if ((status & SUN6I_CSI_CH_INT_STA_FIFO0_OF) ||
 	    (status & SUN6I_CSI_CH_INT_STA_FIFO1_OF) ||
@@ -132,6 +136,7 @@ static irqreturn_t sun6i_csi_isr(int irq, void *private)
 	if (status & SUN6I_CSI_CH_INT_STA_VS)
 		sun6i_csi_capture_sync(csi_dev);
 
+complete:
 	regmap_write(regmap, SUN6I_CSI_CH_INT_STA_REG, status);
 
 	return IRQ_HANDLED;
-- 
2.35.1

