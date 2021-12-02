Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1369A4660E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356870AbhLBJ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:56:58 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:40761 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356817AbhLBJ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:56:38 -0500
Received: (Authenticated sender: herve.codina@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPA id D088E240016;
        Thu,  2 Dec 2021 09:53:13 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 3/6] pinctrl: spear: plgpio: Introduce regmap phandle
Date:   Thu,  2 Dec 2021 10:52:52 +0100
Message-Id: <20211202095255.165797-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202095255.165797-1-herve.codina@bootlin.com>
References: <20211202095255.165797-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resources need to be shared between pinmux and plgpio.

Introduce regmap phandle in order to retrieve the regmap
from the phandle if the property is present.
This allows to retrieve an external regmap (ie the one
used by pinmux if the phandle references the pinmux node)
from plgpio.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pinctrl/spear/pinctrl-plgpio.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/spear/pinctrl-plgpio.c b/drivers/pinctrl/spear/pinctrl-plgpio.c
index 28538ac99eed..b36449724f3f 100644
--- a/drivers/pinctrl/spear/pinctrl-plgpio.c
+++ b/drivers/pinctrl/spear/pinctrl-plgpio.c
@@ -523,6 +523,7 @@ static int plgpio_probe_dt(struct platform_device *pdev, struct plgpio *plgpio)
 
 static int plgpio_probe(struct platform_device *pdev)
 {
+	struct device_node *regmap_np;
 	struct plgpio *plgpio;
 	int ret, irq;
 
@@ -530,11 +531,22 @@ static int plgpio_probe(struct platform_device *pdev)
 	if (!plgpio)
 		return -ENOMEM;
 
-	plgpio->regmap = device_node_to_regmap(pdev->dev.of_node);
-	if (IS_ERR(plgpio->regmap)) {
-		dev_err(&pdev->dev, "Init regmap failed (%pe)\n",
-			plgpio->regmap);
-		return PTR_ERR(plgpio->regmap);
+	regmap_np = of_parse_phandle(pdev->dev.of_node, "regmap", 0);
+	if (regmap_np) {
+		plgpio->regmap = device_node_to_regmap(regmap_np);
+		of_node_put(regmap_np);
+		if (IS_ERR(plgpio->regmap)) {
+			dev_err(&pdev->dev, "Retrieve regmap failed (%pe)\n",
+				plgpio->regmap);
+			return PTR_ERR(plgpio->regmap);
+		}
+	} else {
+		plgpio->regmap = device_node_to_regmap(pdev->dev.of_node);
+		if (IS_ERR(plgpio->regmap)) {
+			dev_err(&pdev->dev, "Init regmap failed (%pe)\n",
+				plgpio->regmap);
+			return PTR_ERR(plgpio->regmap);
+		}
 	}
 
 	ret = plgpio_probe_dt(pdev, plgpio);
-- 
2.31.1

