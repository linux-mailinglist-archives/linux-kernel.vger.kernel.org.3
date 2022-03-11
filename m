Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136164D6387
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349435AbiCKOhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349411AbiCKOhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:37:01 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280411C8D9E;
        Fri, 11 Mar 2022 06:35:57 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 456D1240004;
        Fri, 11 Mar 2022 14:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tUV9pToXc97GruDFUILdAEx8PuuZu4dV5AXoi5Yg5kY=;
        b=OCg9rH7jIUCvz9N3IkVUtWDFo+Fq7PJnwOBs4ZJ63qVflQlRjD5xXd1Aj0oClc3u5bJhJc
        RhQ+2dQ3bDtH1AMhFiUYKw7Vw5ksTVuAu49bg+y4IAF1bNi5mZKPJSwEp+O7j/TAxFWNw9
        HzRz/NpT5gK4ezzvLWigf5AHEsd56Nd85ls9B+qobInxF0xcGoBI3O3C9cufsUTSH3EHWt
        ijkm9MMfl7j+kqB6cWQmagcrJOWgxNKCj0WJRgF1JisBvWzQzkicVS4/pSyAzqNXACSHoo
        pEElKKV+v0/a6+dBhtmrLpwJhRXdpXWcnbYZOpcKeKBpUSy+KA/K7glrLlpV0w==
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
Subject: [PATCH v3 03/46] media: sun6i-csi: Grab bus clock instead of passing it to regmap
Date:   Fri, 11 Mar 2022 15:34:49 +0100
Message-Id: <20220311143532.265091-4-paul.kocialkowski@bootlin.com>
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

Since the bus clock alone is not enough to get access to the registers,
don't pass it to regmap and manage it instead just like the other
clocks.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 10 ++++++++--
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 5fbaa1e99412..dc79f3c14336 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -827,13 +827,19 @@ static int sun6i_csi_resource_request(struct sun6i_csi_device *csi_dev,
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
 
-	csi_dev->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "bus", io_base,
-						    &sun6i_csi_regmap_config);
+	csi_dev->regmap = devm_regmap_init_mmio(&pdev->dev, io_base,
+						&sun6i_csi_regmap_config);
 	if (IS_ERR(csi_dev->regmap)) {
 		dev_err(&pdev->dev, "Failed to init register map\n");
 		return PTR_ERR(csi_dev->regmap);
 	}
 
+	csi_dev->clk_bus = devm_clk_get(&pdev->dev, "bus");
+	if (IS_ERR(csi_dev->clk_bus)) {
+		dev_err(&pdev->dev, "Unable to acquire bus clock\n");
+		return PTR_ERR(csi_dev->clk_bus);
+	}
+
 	csi_dev->clk_mod = devm_clk_get(&pdev->dev, "mod");
 	if (IS_ERR(csi_dev->clk_mod)) {
 		dev_err(&pdev->dev, "Unable to acquire csi clock\n");
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index e4e7ac6c869f..356661b413f8 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -51,6 +51,7 @@ struct sun6i_csi_device {
 	struct sun6i_video		video;
 
 	struct regmap			*regmap;
+	struct clk			*clk_bus;
 	struct clk			*clk_mod;
 	struct clk			*clk_ram;
 	struct reset_control		*reset;
-- 
2.35.1

