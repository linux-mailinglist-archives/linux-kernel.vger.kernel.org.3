Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FA050BA34
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448716AbiDVOj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245041AbiDVOjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:39:21 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280605BD1D;
        Fri, 22 Apr 2022 07:36:27 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23MEYp7Q004664;
        Fri, 22 Apr 2022 16:36:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=3E2c39yb1aGbUTxvLFXeT2bxlC2OY8EbvTcWhBmFb/Q=;
 b=ONG31MPr6xmPIGOCiwmLsIgdEPkWMIX170wNkG5tkbD0or2f4L1fb0zHGznnjkPK7dYy
 zuYR8qXrCbQ/IjgY5UpvlxeVzfLCF+MtdGQKvegqGtHx0mmO6VSp2EWzc5lIqR3vb7is
 qdKNwXxirmw2zTwcbIvY6Zj9/KXC0g0FNHc8ilO1ye9FoMGnPGYoxuFapoGZZ2/upxDg
 pPWcyHie2iE/pIwsACjwSbg7Cq2y9sB3kdyWbdmM5Qlgo6DIOZxS9wXyPecmu/a8a6qB
 CjbbMTjHYHtSNVMmk85dVgIOeDMh0w9Y1BS0ot3Ix3ujgcauAhtkLIhxLg/BkCCDmf93 xA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ffpqe9qkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 16:36:18 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2C3DC10002A;
        Fri, 22 Apr 2022 16:36:18 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2309E22D172;
        Fri, 22 Apr 2022 16:36:18 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 22 Apr 2022 16:36:17
 +0200
From:   Fabien Dessenne <fabien.dessenne@foss.st.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-gpio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>
CC:     Fabien Dessenne <fabien.dessenne@foss.st.com>
Subject: [PATCH] pinctrl: stm32: improve bank clocks management
Date:   Fri, 22 Apr 2022 16:36:08 +0200
Message-ID: <20220422143608.226580-1-fabien.dessenne@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_04,2022-04-22_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of enabling/disabling the clock at each IO configuration update,
just keep the clock enabled from the probe.
This makes things simpler and more efficient (e.g. the time required to
toggle an output IO is drastically decreased) without significantly
increasing the power consumption.

Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c      | 82 ++++++++--------------
 drivers/pinctrl/stm32/pinctrl-stm32.h      |  1 +
 drivers/pinctrl/stm32/pinctrl-stm32mp135.c |  2 +-
 drivers/pinctrl/stm32/pinctrl-stm32mp157.c |  2 +-
 4 files changed, 34 insertions(+), 53 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index f7c9459f6628..b308e7bb7487 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -197,11 +197,7 @@ static inline void __stm32_gpio_set(struct stm32_gpio_bank *bank,
 	if (!value)
 		offset += STM32_GPIO_PINS_PER_BANK;
 
-	clk_enable(bank->clk);
-
 	writel_relaxed(BIT(offset), bank->base + STM32_GPIO_BSRR);
-
-	clk_disable(bank->clk);
 }
 
 static int stm32_gpio_request(struct gpio_chip *chip, unsigned offset)
@@ -225,25 +221,11 @@ static void stm32_gpio_free(struct gpio_chip *chip, unsigned offset)
 	pinctrl_gpio_free(chip->base + offset);
 }
 
-static int stm32_gpio_get_noclk(struct gpio_chip *chip, unsigned int offset)
-{
-	struct stm32_gpio_bank *bank = gpiochip_get_data(chip);
-
-	return !!(readl_relaxed(bank->base + STM32_GPIO_IDR) & BIT(offset));
-}
-
 static int stm32_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct stm32_gpio_bank *bank = gpiochip_get_data(chip);
-	int ret;
 
-	clk_enable(bank->clk);
-
-	ret = stm32_gpio_get_noclk(chip, offset);
-
-	clk_disable(bank->clk);
-
-	return ret;
+	return !!(readl_relaxed(bank->base + STM32_GPIO_IDR) & BIT(offset));
 }
 
 static void stm32_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
@@ -323,7 +305,7 @@ static void stm32_gpio_irq_trigger(struct irq_data *d)
 		return;
 
 	/* If level interrupt type then retrig */
-	level = stm32_gpio_get_noclk(&bank->gpio_chip, d->hwirq);
+	level = stm32_gpio_get(&bank->gpio_chip, d->hwirq);
 	if ((level == 0 && bank->irq_type[d->hwirq] == IRQ_TYPE_LEVEL_LOW) ||
 	    (level == 1 && bank->irq_type[d->hwirq] == IRQ_TYPE_LEVEL_HIGH))
 		irq_chip_retrigger_hierarchy(d);
@@ -365,7 +347,6 @@ static int stm32_gpio_irq_request_resources(struct irq_data *irq_data)
 {
 	struct stm32_gpio_bank *bank = irq_data->domain->host_data;
 	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
-	unsigned long flags;
 	int ret;
 
 	ret = stm32_gpio_direction_input(&bank->gpio_chip, irq_data->hwirq);
@@ -379,10 +360,6 @@ static int stm32_gpio_irq_request_resources(struct irq_data *irq_data)
 		return ret;
 	}
 
-	flags = irqd_get_trigger_type(irq_data);
-	if (flags & IRQ_TYPE_LEVEL_MASK)
-		clk_enable(bank->clk);
-
 	return 0;
 }
 
@@ -390,9 +367,6 @@ static void stm32_gpio_irq_release_resources(struct irq_data *irq_data)
 {
 	struct stm32_gpio_bank *bank = irq_data->domain->host_data;
 
-	if (bank->irq_type[irq_data->hwirq] & IRQ_TYPE_LEVEL_MASK)
-		clk_disable(bank->clk);
-
 	gpiochip_unlock_as_irq(&bank->gpio_chip, irq_data->hwirq);
 }
 
@@ -769,7 +743,6 @@ static int stm32_pmx_set_mode(struct stm32_gpio_bank *bank,
 	unsigned long flags;
 	int err = 0;
 
-	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
 	if (pctl->hwlock) {
@@ -798,7 +771,6 @@ static int stm32_pmx_set_mode(struct stm32_gpio_bank *bank,
 
 unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
-	clk_disable(bank->clk);
 
 	return err;
 }
@@ -811,7 +783,6 @@ void stm32_pmx_get_mode(struct stm32_gpio_bank *bank, int pin, u32 *mode,
 	int alt_offset = STM32_GPIO_AFRL + (pin / 8) * 4;
 	unsigned long flags;
 
-	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
 	val = readl_relaxed(bank->base + alt_offset);
@@ -823,7 +794,6 @@ void stm32_pmx_get_mode(struct stm32_gpio_bank *bank, int pin, u32 *mode,
 	*mode = val >> (pin * 2);
 
 	spin_unlock_irqrestore(&bank->lock, flags);
-	clk_disable(bank->clk);
 }
 
 static int stm32_pmx_set_mux(struct pinctrl_dev *pctldev,
@@ -886,7 +856,6 @@ static int stm32_pconf_set_driving(struct stm32_gpio_bank *bank,
 	u32 val;
 	int err = 0;
 
-	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
 	if (pctl->hwlock) {
@@ -910,7 +879,6 @@ static int stm32_pconf_set_driving(struct stm32_gpio_bank *bank,
 
 unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
-	clk_disable(bank->clk);
 
 	return err;
 }
@@ -921,14 +889,12 @@ static u32 stm32_pconf_get_driving(struct stm32_gpio_bank *bank,
 	unsigned long flags;
 	u32 val;
 
-	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
 	val = readl_relaxed(bank->base + STM32_GPIO_TYPER);
 	val &= BIT(offset);
 
 	spin_unlock_irqrestore(&bank->lock, flags);
-	clk_disable(bank->clk);
 
 	return (val >> offset);
 }
@@ -941,7 +907,6 @@ static int stm32_pconf_set_speed(struct stm32_gpio_bank *bank,
 	u32 val;
 	int err = 0;
 
-	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
 	if (pctl->hwlock) {
@@ -965,7 +930,6 @@ static int stm32_pconf_set_speed(struct stm32_gpio_bank *bank,
 
 unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
-	clk_disable(bank->clk);
 
 	return err;
 }
@@ -976,14 +940,12 @@ static u32 stm32_pconf_get_speed(struct stm32_gpio_bank *bank,
 	unsigned long flags;
 	u32 val;
 
-	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
 	val = readl_relaxed(bank->base + STM32_GPIO_SPEEDR);
 	val &= GENMASK(offset * 2 + 1, offset * 2);
 
 	spin_unlock_irqrestore(&bank->lock, flags);
-	clk_disable(bank->clk);
 
 	return (val >> (offset * 2));
 }
@@ -996,7 +958,6 @@ static int stm32_pconf_set_bias(struct stm32_gpio_bank *bank,
 	u32 val;
 	int err = 0;
 
-	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
 	if (pctl->hwlock) {
@@ -1020,7 +981,6 @@ static int stm32_pconf_set_bias(struct stm32_gpio_bank *bank,
 
 unlock:
 	spin_unlock_irqrestore(&bank->lock, flags);
-	clk_disable(bank->clk);
 
 	return err;
 }
@@ -1031,14 +991,12 @@ static u32 stm32_pconf_get_bias(struct stm32_gpio_bank *bank,
 	unsigned long flags;
 	u32 val;
 
-	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
 	val = readl_relaxed(bank->base + STM32_GPIO_PUPDR);
 	val &= GENMASK(offset * 2 + 1, offset * 2);
 
 	spin_unlock_irqrestore(&bank->lock, flags);
-	clk_disable(bank->clk);
 
 	return (val >> (offset * 2));
 }
@@ -1049,7 +1007,6 @@ static bool stm32_pconf_get(struct stm32_gpio_bank *bank,
 	unsigned long flags;
 	u32 val;
 
-	clk_enable(bank->clk);
 	spin_lock_irqsave(&bank->lock, flags);
 
 	if (dir)
@@ -1060,7 +1017,6 @@ static bool stm32_pconf_get(struct stm32_gpio_bank *bank,
 			 BIT(offset));
 
 	spin_unlock_irqrestore(&bank->lock, flags);
-	clk_disable(bank->clk);
 
 	return val;
 }
@@ -1256,9 +1212,9 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 	if (IS_ERR(bank->base))
 		return PTR_ERR(bank->base);
 
-	err = clk_prepare(bank->clk);
+	err = clk_prepare_enable(bank->clk);
 	if (err) {
-		dev_err(dev, "failed to prepare clk (%d)\n", err);
+		dev_err(dev, "failed to prepare_enable clk (%d)\n", err);
 		return err;
 	}
 
@@ -1306,17 +1262,23 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 					STM32_GPIO_IRQ_LINE, bank->fwnode,
 					&stm32_gpio_domain_ops, bank);
 
-	if (!bank->domain)
-		return -ENODEV;
+	if (!bank->domain) {
+		err = -ENODEV;
+		goto err_clk;
+	}
 
 	err = gpiochip_add_data(&bank->gpio_chip, bank);
 	if (err) {
 		dev_err(dev, "Failed to add gpiochip(%d)!\n", bank_nr);
-		return err;
+		goto err_clk;
 	}
 
 	dev_info(dev, "%s bank added\n", bank->gpio_chip.label);
 	return 0;
+
+err_clk:
+	clk_disable_unprepare(bank->clk);
+	return err;
 }
 
 static struct irq_domain *stm32_pctrl_get_irq_domain(struct device_node *np)
@@ -1575,6 +1537,10 @@ int stm32_pctl_probe(struct platform_device *pdev)
 			ret = stm32_gpiolib_register_bank(pctl, child);
 			if (ret) {
 				of_node_put(child);
+
+				for (i = 0; i < pctl->nbanks; i++)
+					clk_disable_unprepare(pctl->banks[i].clk);
+
 				return ret;
 			}
 
@@ -1647,12 +1613,26 @@ static int __maybe_unused stm32_pinctrl_restore_gpio_regs(
 	return 0;
 }
 
+int __maybe_unused stm32_pinctrl_suspend(struct device *dev)
+{
+	struct stm32_pinctrl *pctl = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < pctl->nbanks; i++)
+		clk_disable(pctl->banks[i].clk);
+
+	return 0;
+}
+
 int __maybe_unused stm32_pinctrl_resume(struct device *dev)
 {
 	struct stm32_pinctrl *pctl = dev_get_drvdata(dev);
 	struct stm32_pinctrl_group *g = pctl->groups;
 	int i;
 
+	for (i = 0; i < pctl->nbanks; i++)
+		clk_enable(pctl->banks[i].clk);
+
 	for (i = 0; i < pctl->ngroups; i++, g++)
 		stm32_pinctrl_restore_gpio_regs(pctl, g->pin);
 
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.h b/drivers/pinctrl/stm32/pinctrl-stm32.h
index b0882d120765..b9584039cdf5 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.h
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.h
@@ -65,6 +65,7 @@ struct stm32_gpio_bank;
 int stm32_pctl_probe(struct platform_device *pdev);
 void stm32_pmx_get_mode(struct stm32_gpio_bank *bank,
 			int pin, u32 *mode, u32 *alt);
+int stm32_pinctrl_suspend(struct device *dev);
 int stm32_pinctrl_resume(struct device *dev);
 
 #endif /* __PINCTRL_STM32_H */
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32mp135.c b/drivers/pinctrl/stm32/pinctrl-stm32mp135.c
index 4ab03520c407..f98717fe23ed 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32mp135.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32mp135.c
@@ -1660,7 +1660,7 @@ static const struct of_device_id stm32mp135_pctrl_match[] = {
 };
 
 static const struct dev_pm_ops stm32_pinctrl_dev_pm_ops = {
-	 SET_LATE_SYSTEM_SLEEP_PM_OPS(NULL, stm32_pinctrl_resume)
+	 SET_LATE_SYSTEM_SLEEP_PM_OPS(stm32_pinctrl_suspend, stm32_pinctrl_resume)
 };
 
 static struct platform_driver stm32mp135_pinctrl_driver = {
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32mp157.c b/drivers/pinctrl/stm32/pinctrl-stm32mp157.c
index 2ccb99d64df8..91b2fc8ddbdb 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32mp157.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32mp157.c
@@ -2343,7 +2343,7 @@ static const struct of_device_id stm32mp157_pctrl_match[] = {
 };
 
 static const struct dev_pm_ops stm32_pinctrl_dev_pm_ops = {
-	 SET_LATE_SYSTEM_SLEEP_PM_OPS(NULL, stm32_pinctrl_resume)
+	 SET_LATE_SYSTEM_SLEEP_PM_OPS(stm32_pinctrl_suspend, stm32_pinctrl_resume)
 };
 
 static struct platform_driver stm32mp157_pinctrl_driver = {
-- 
2.25.1

