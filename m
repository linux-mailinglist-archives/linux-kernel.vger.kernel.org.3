Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B7B5343EE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344559AbiEYTKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344249AbiEYTH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:07:58 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DFC12AB0;
        Wed, 25 May 2022 12:07:23 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 53E6C1C0019;
        Wed, 25 May 2022 19:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653505636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=caV9nRuGoEA6+0iGltaXNYvrIvAMcvIE8iyAgygIsdg=;
        b=f21hMsp+Fpb2Od2HAJo/ZykPlu9QAq0UhZ6catUZx7yIp/pPGHMD9/azdNMGDc5//sCOuj
        ia3kpORcSYt6b1mv1axVsq8qJOfrjpdXQ3iyGxwWZ89ljNlibRPFGCIQJxmNzVl8pJ7noR
        Az5bUN58X51RxoO8c9lp4f7IDA2TznVK6xb5Di2S/FEr9RybjivJIeakG404JsFyN9UJjy
        d5YJSY8jkPqJuU2p0NfXzwtL8B2A2x0rOaCf0goiuSjHpq4FZZfqOprjtwGFEgPK/Ofp+1
        m7YlUTUcLo7exrjef6MdH0/UhXRSMUgvmHFIjFwmooDSLdG6e/d2KtKzZPhrnQ==
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
Subject: [PATCH v5 42/44] media: sun6i-csi: Add extra checks to the interrupt routine
Date:   Wed, 25 May 2022 21:06:15 +0200
Message-Id: <20220525190617.696344-43-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525190617.696344-1-paul.kocialkowski@bootlin.com>
References: <20220525190617.696344-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check against the enabled bits and make sure capture is running before
serving an interrupt, to add extra safety in the process.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index eaf62cab0b64..46c5f98702e1 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -89,13 +89,17 @@ static void sun6i_csi_v4l2_cleanup(struct sun6i_csi_device *csi_dev)
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
@@ -116,6 +120,7 @@ static irqreturn_t sun6i_csi_interrupt(int irq, void *private)
 	if (status & SUN6I_CSI_CH_INT_STA_VS)
 		sun6i_csi_capture_sync(csi_dev);
 
+complete:
 	regmap_write(regmap, SUN6I_CSI_CH_INT_STA_REG, status);
 
 	return IRQ_HANDLED;
-- 
2.36.1

