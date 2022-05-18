Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475D652C362
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241923AbiERTaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242010AbiERTaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:30:22 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D20A3230217;
        Wed, 18 May 2022 12:30:16 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,235,1647270000"; 
   d="scan'208";a="120092124"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 19 May 2022 04:30:16 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id F0D6E4004CF5;
        Thu, 19 May 2022 04:30:08 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 4/7] gpio: gpiolib: Dont assume child_offset_to_irq callback always succeeds
Date:   Wed, 18 May 2022 20:29:21 +0100
Message-Id: <20220518192924.20948-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220518192924.20948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220518192924.20948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Renesas RZ/G2L SoC not all the GPIO pins can be simultaneously used as
interrupts. The SoC allows 32 interrupts which is first come first serve
basis and is dynamic i.e. if there is a free slot (after rmmod) this can
be used by other GPIO pins being used as an interrupt.

To handle such cases change child_offset_to_irq() callback to return error
codes in case of failure. All the users of child_offset_to_irq() callback
are also updated with this API change.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpio/gpio-tegra186.c             | 14 ++++++++++---
 drivers/gpio/gpiolib.c                   | 25 +++++++++++++++++++-----
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c |  7 +++++--
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c  |  7 +++++--
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c |  7 +++++--
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c  |  7 +++++--
 include/linux/gpio/driver.h              |  9 ++++++---
 7 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 031fe105b58e..baf73290ba44 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -552,14 +552,20 @@ static int tegra186_gpio_child_to_parent_hwirq(struct gpio_chip *chip,
 					       unsigned int *parent_hwirq,
 					       unsigned int *parent_type)
 {
-	*parent_hwirq = chip->irq.child_offset_to_irq(chip, hwirq);
+	int ret;
+
+	ret = chip->irq.child_offset_to_irq(chip, hwirq, parent_hwirq);
+	if (ret)
+		return ret;
+
 	*parent_type = type;
 
 	return 0;
 }
 
 static unsigned int tegra186_gpio_child_offset_to_irq(struct gpio_chip *chip,
-						      unsigned int offset)
+						      unsigned int offset,
+						      unsigned int *hwirq)
 {
 	struct tegra_gpio *gpio = gpiochip_get_data(chip);
 	unsigned int i;
@@ -571,7 +577,9 @@ static unsigned int tegra186_gpio_child_offset_to_irq(struct gpio_chip *chip,
 		offset -= gpio->soc->ports[i].pins;
 	}
 
-	return offset + i * 8;
+	*hwirq = offset + i * 8;
+
+	return 0;
 }
 
 static const struct of_device_id tegra186_pmc_of_match[] = {
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 43dbc4ee9d67..65e344a23c6a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1036,6 +1036,7 @@ static void gpiochip_set_hierarchical_irqchip(struct gpio_chip *gc,
 			unsigned int parent_hwirq;
 			unsigned int parent_type;
 			struct gpio_irq_chip *girq = &gc->irq;
+			unsigned int hwirq;
 
 			/*
 			 * We call the child to parent translation function
@@ -1053,9 +1054,16 @@ static void gpiochip_set_hierarchical_irqchip(struct gpio_chip *gc,
 				continue;
 			}
 
+			ret = girq->child_offset_to_irq(gc, i, &hwirq);
+			if (ret) {
+				chip_err(gc,
+					 "child_offset_to_irq() failed to return hwirq for GPIO line %d: %d\n",
+					 i, ret);
+				continue;
+			}
 			fwspec.fwnode = gc->irq.fwnode;
 			/* This is the hwirq for the GPIO line side of things */
-			fwspec.param[0] = girq->child_offset_to_irq(gc, i);
+			fwspec.param[0] = hwirq;
 			/* Just pick something */
 			fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
 			fwspec.param_count = 2;
@@ -1176,10 +1184,12 @@ static int gpiochip_hierarchy_irq_domain_alloc(struct irq_domain *d,
 	return ret;
 }
 
-static unsigned int gpiochip_child_offset_to_irq_noop(struct gpio_chip *gc,
-						      unsigned int offset)
+static int gpiochip_child_offset_to_irq_noop(struct gpio_chip *gc,
+					     unsigned int offset,
+					     unsigned int *hwirq)
 {
-	return offset;
+	*hwirq = offset;
+	return 0;
 }
 
 static void gpiochip_hierarchy_setup_domain_ops(struct irq_domain_ops *ops)
@@ -1420,10 +1430,15 @@ static int gpiochip_to_irq(struct gpio_chip *gc, unsigned int offset)
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	if (irq_domain_is_hierarchy(domain)) {
 		struct irq_fwspec spec;
+		unsigned int hwirq;
+		int ret;
 
+		ret = gc->irq.child_offset_to_irq(gc, offset, &hwirq);
+		if (ret)
+			return ret;
 		spec.fwnode = domain->fwnode;
 		spec.param_count = 2;
-		spec.param[0] = gc->irq.child_offset_to_irq(gc, offset);
+		spec.param[0] = hwirq;
 		spec.param[1] = IRQ_TYPE_NONE;
 
 		return irq_create_fwspec_mapping(&spec);
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 4fbf8d3938ef..30cd4080af09 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -947,9 +947,12 @@ static int pmic_gpio_domain_translate(struct irq_domain *domain,
 }
 
 static unsigned int pmic_gpio_child_offset_to_irq(struct gpio_chip *chip,
-						  unsigned int offset)
+						  unsigned int offset,
+						  unsigned int *hwirq)
 {
-	return offset + PMIC_GPIO_PHYSICAL_OFFSET;
+	*hwirq = offset + PMIC_GPIO_PHYSICAL_OFFSET;
+
+	return 0;
 }
 
 static int pmic_gpio_child_to_parent_hwirq(struct gpio_chip *chip,
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index 6937157f50b3..a712a4deff34 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -804,9 +804,12 @@ static int pmic_mpp_domain_translate(struct irq_domain *domain,
 }
 
 static unsigned int pmic_mpp_child_offset_to_irq(struct gpio_chip *chip,
-						  unsigned int offset)
+						 unsigned int offset,
+						 unsigned int *hwirq)
 {
-	return offset + PMIC_MPP_PHYSICAL_OFFSET;
+	*hwirq = offset + PMIC_MPP_PHYSICAL_OFFSET;
+
+	return 0;
 }
 
 static int pmic_mpp_child_to_parent_hwirq(struct gpio_chip *chip,
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index 1b41adda8129..c3a7af6dc9cc 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -678,9 +678,12 @@ static int pm8xxx_domain_translate(struct irq_domain *domain,
 }
 
 static unsigned int pm8xxx_child_offset_to_irq(struct gpio_chip *chip,
-					       unsigned int offset)
+					       unsigned int offset,
+					       unsigned int *hwirq)
 {
-	return offset + PM8XXX_GPIO_PHYSICAL_OFFSET;
+	*hwirq = offset + PM8XXX_GPIO_PHYSICAL_OFFSET;
+
+	return 0;
 }
 
 static int pm8xxx_child_to_parent_hwirq(struct gpio_chip *chip,
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
index 49893a5133a8..1733743a6813 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
@@ -748,9 +748,12 @@ static int pm8xxx_mpp_domain_translate(struct irq_domain *domain,
 }
 
 static unsigned int pm8xxx_mpp_child_offset_to_irq(struct gpio_chip *chip,
-						   unsigned int offset)
+						   unsigned int offset,
+						   unsigned int *hwirq)
 {
-	return offset + PM8XXX_MPP_PHYSICAL_OFFSET;
+	*hwirq = offset + PM8XXX_MPP_PHYSICAL_OFFSET;
+
+	return 0;
 }
 
 static int pm8821_mpp_child_to_parent_hwirq(struct gpio_chip *chip,
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 4ec3f010df7c..a04428c7ba79 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -120,10 +120,13 @@ struct gpio_irq_chip {
 	 * This optional callback is used to translate the child's GPIO line
 	 * offset on the GPIO chip to an IRQ number for the GPIO to_irq()
 	 * callback. If this is not specified, then a default callback will be
-	 * provided that returns the line offset.
+	 * provided that sets hwirq to the line offset.
+	 *
+	 * If the hardware is not capable of handling anymore IRQs a negative
+	 * error code is returned and on success 0 is returned.
 	 */
-	unsigned int (*child_offset_to_irq)(struct gpio_chip *gc,
-					    unsigned int pin);
+	int (*child_offset_to_irq)(struct gpio_chip *gc, unsigned int pin,
+				   unsigned int *hwirq);
 
 	/**
 	 * @child_irq_domain_ops:
-- 
2.25.1

