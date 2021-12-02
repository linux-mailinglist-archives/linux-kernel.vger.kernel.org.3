Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963C74660F5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbhLBJ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:58:13 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:39905 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356708AbhLBJ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:56:30 -0500
Received: (Authenticated sender: herve.codina@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPA id 6B87A24000E;
        Thu,  2 Dec 2021 09:53:05 +0000 (UTC)
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
Subject: [PATCH 1/6] pinctrl: spear: spear: Convert to regmap
Date:   Thu,  2 Dec 2021 10:52:50 +0100
Message-Id: <20211202095255.165797-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202095255.165797-1-herve.codina@bootlin.com>
References: <20211202095255.165797-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resources need to be shared between pinmux and plgpio.

Use regmap (syscon) to access resources to allow an
easy way to share resources.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pinctrl/spear/pinctrl-spear.c | 10 +++++++---
 drivers/pinctrl/spear/pinctrl-spear.h | 12 ++++++++----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/spear/pinctrl-spear.c b/drivers/pinctrl/spear/pinctrl-spear.c
index 948f56abb9ae..e0543c1ad641 100644
--- a/drivers/pinctrl/spear/pinctrl-spear.c
+++ b/drivers/pinctrl/spear/pinctrl-spear.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -367,9 +368,12 @@ int spear_pinctrl_probe(struct platform_device *pdev,
 	if (!pmx)
 		return -ENOMEM;
 
-	pmx->vbase = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(pmx->vbase))
-		return PTR_ERR(pmx->vbase);
+	pmx->regmap = device_node_to_regmap(np);
+	if (IS_ERR(pmx->regmap)) {
+		dev_err(&pdev->dev, "Init regmap failed (%pe).\n",
+			pmx->regmap);
+		return PTR_ERR(pmx->regmap);
+	}
 
 	pmx->dev = &pdev->dev;
 	pmx->machdata = machdata;
diff --git a/drivers/pinctrl/spear/pinctrl-spear.h b/drivers/pinctrl/spear/pinctrl-spear.h
index db029b148c87..63a0b5ea56ef 100644
--- a/drivers/pinctrl/spear/pinctrl-spear.h
+++ b/drivers/pinctrl/spear/pinctrl-spear.h
@@ -15,6 +15,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/io.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/regmap.h>
 #include <linux/types.h>
 
 struct platform_device;
@@ -172,24 +173,27 @@ struct spear_pinctrl_machdata {
  * @dev: pointer to struct dev of platform_device registered
  * @pctl: pointer to struct pinctrl_dev
  * @machdata: pointer to SoC or machine specific structure
- * @vbase: virtual base address of pinmux controller
+ * @regmap: regmap of pinmux controller
  */
 struct spear_pmx {
 	struct device *dev;
 	struct pinctrl_dev *pctl;
 	struct spear_pinctrl_machdata *machdata;
-	void __iomem *vbase;
+	struct regmap *regmap;
 };
 
 /* exported routines */
 static inline u32 pmx_readl(struct spear_pmx *pmx, u32 reg)
 {
-	return readl_relaxed(pmx->vbase + reg);
+	u32 val;
+
+	regmap_read(pmx->regmap, reg, &val);
+	return val;
 }
 
 static inline void pmx_writel(struct spear_pmx *pmx, u32 val, u32 reg)
 {
-	writel_relaxed(val, pmx->vbase + reg);
+	regmap_write(pmx->regmap, reg, val);
 }
 
 void pmx_init_addr(struct spear_pinctrl_machdata *machdata, u16 reg);
-- 
2.31.1

