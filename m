Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2A9502D19
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355457AbiDOPeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355367AbiDOPda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:33:30 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7D1D8F54;
        Fri, 15 Apr 2022 08:29:09 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D38A1E0008;
        Fri, 15 Apr 2022 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650036547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a4cnzWuTGffjryQBqgGBFOHFWDCSqhQFuFNHTBbesc8=;
        b=XCVcJmrQqhxE4TzSjVzyggVUK/fFX8TRrpguo+t7PW1LjswkIxkA0cRKrw7LxabH5vqx7I
        W63h81hAagaar/3XXMrrmRjndAwFXluaYP0X4Bgbx9A7az5FSb8sCB8bMRMxgr+pM6YvU7
        +NPw+kAmxS+zbBDGV7k76u9OERUb+2V5AGQRvc7ZnIxY6S69lWjdxfYMJL58Icb+M5TPXM
        Z9RrEsF34TOJ2uCJiEG4sybHHU9mKY1lx9HGJkHYZn8WRTULXpMck882bIxngGJJgPakNS
        FxtV34AdpZBhAqgz1ymHtRqVuGhszOaHLCdPZKR0yvWOHTL1s5B6Wmpr9Ihgfw==
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
Subject: [PATCH v4 41/45] media: sun6i-csi: Add extra checks to the interrupt routine
Date:   Fri, 15 Apr 2022 17:28:07 +0200
Message-Id: <20220415152811.636419-42-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
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
index 43b6557b3207..3963a88a2e0b 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -105,13 +105,17 @@ static void sun6i_csi_v4l2_cleanup(struct sun6i_csi_device *csi_dev)
 static irqreturn_t sun6i_csi_interrupt(int irq, void *private)
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
@@ -132,6 +136,7 @@ static irqreturn_t sun6i_csi_interrupt(int irq, void *private)
 	if (status & SUN6I_CSI_CH_INT_STA_VS)
 		sun6i_csi_capture_sync(csi_dev);
 
+complete:
 	regmap_write(regmap, SUN6I_CSI_CH_INT_STA_REG, status);
 
 	return IRQ_HANDLED;
-- 
2.35.2

