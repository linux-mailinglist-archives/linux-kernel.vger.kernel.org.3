Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0004AAB5E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381276AbiBESzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:55:48 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:60835 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381264AbiBESzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:55:14 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5413E240002;
        Sat,  5 Feb 2022 18:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+quzXmSLeW/9z2A42DWsC3K4J4WvAIG77KmdgY3FlMc=;
        b=l2E6lWMvXovhrV8hWwAJ9nrKTfPV85a2fG26zRZ1s/Rr4BuFmvT7/BDMrQmvOTMNlFjEH+
        2U8QbzkGsIoYOzVR/YEcJooneNpZb0PQwa4QeOcnM0VfPcQF5voVS60Xx6HCpFfq+bdJnN
        7e/KPxnripLy/3TZT8hyZGXtl1alM07429u0vsz1u2+ag0q0f5qTS6GEJmFE1Eu6KYhZNk
        RW/kFUEaAUOzfUsfHgpOUZcwwPivHCdOyAZCdvYAhsKthXFGUMBrwEMwLSvY92zRDYaFNz
        5TcE+JoT0MgunoW5G83mK/+rhn32K3sWkV7RnDBuYLwzqh+wE2fVUgI5w4Owxw==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 19/66] media: sun6i-csi: Grab bus clock instead of passing it to regmap
Date:   Sat,  5 Feb 2022 19:53:42 +0100
Message-Id: <20220205185429.2278860-20-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.34.1

