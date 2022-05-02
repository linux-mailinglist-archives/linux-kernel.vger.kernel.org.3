Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D562A5172A0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385761AbiEBPfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385802AbiEBPfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:35:34 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121CDB1FC;
        Mon,  2 May 2022 08:32:04 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242DcwT8016032;
        Mon, 2 May 2022 17:31:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=8ralpS6yoB5LO57RRVOsPiKbowhvCD5Zg9HRkpvi//Q=;
 b=amVVkvUB++ArDu1frvMEWiCWegAHeCFncbNip1pkxC/kFaDNO7VQZpScJACiJVd5G10+
 yY99knlCzJLv+Gf34FSTbV85KIAwbFp5I5Yiyw/y3M7foD51HhGFmn5giQdzCJJxbmB6
 eYsLpRFNmsCmnx2kOO/l1b/VYKqyHjul+d14dOPYbskcyyBqLcuMIhOV/8YZ1m5Od9yJ
 c8XmVEblaQNeMmwnEdlxjUsIfZG83gXG+cQrTP89MFnAYNxNksTB3XMX5OVXlfuTPMO/
 OtUfde2YKUtDDS3vpyHYG3laU2cID1W0A2CamWg82no0s8QcnG/7PW52efZrUq+8pEdZ 3w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frv0g1wnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 17:31:51 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6F58210002A;
        Mon,  2 May 2022 17:31:42 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 672CE22ECE6;
        Mon,  2 May 2022 17:31:42 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 2 May 2022 17:31:41
 +0200
From:   Fabien Dessenne <fabien.dessenne@foss.st.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-gpio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@foss.st.com>
Subject: [PATCH] pinctrl: stm32: prevent the use of the secure protected pins
Date:   Mon, 2 May 2022 17:31:14 +0200
Message-ID: <20220502153114.283618-1-fabien.dessenne@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_04,2022-05-02_03,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware denies any access from the Linux non-secure world to the
secure-protected pins. Hence, prevent any driver to request such a pin.

Mark the secure-protected GPIO lines as invalid (.init_valid_mask) and
prevent the pinmux request / pinconf setting operations.
Identify the secure pins with "NO ACCESS" in the pinconf sysfs.

Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c      | 64 ++++++++++++++++++++++
 drivers/pinctrl/stm32/pinctrl-stm32.h      |  1 +
 drivers/pinctrl/stm32/pinctrl-stm32mp135.c |  1 +
 3 files changed, 66 insertions(+)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index b308e7bb7487..e81772255e43 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -43,6 +43,7 @@
 #define STM32_GPIO_LCKR		0x1c
 #define STM32_GPIO_AFRL		0x20
 #define STM32_GPIO_AFRH		0x24
+#define STM32_GPIO_SECCFGR	0x30
 
 /* custom bitfield to backup pin status */
 #define STM32_GPIO_BKP_MODE_SHIFT	0
@@ -94,6 +95,7 @@ struct stm32_gpio_bank {
 	u32 bank_ioport_nr;
 	u32 pin_backup[STM32_GPIO_PINS_PER_BANK];
 	u8 irq_type[STM32_GPIO_PINS_PER_BANK];
+	bool secure_control;
 };
 
 struct stm32_pinctrl {
@@ -283,6 +285,33 @@ static int stm32_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 	return ret;
 }
 
+static int stm32_gpio_init_valid_mask(struct gpio_chip *chip,
+				      unsigned long *valid_mask,
+				      unsigned int ngpios)
+{
+	struct stm32_gpio_bank *bank = gpiochip_get_data(chip);
+	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
+	unsigned int i;
+	u32 sec;
+
+	/* All gpio are valid per default */
+	bitmap_fill(valid_mask, ngpios);
+
+	if (bank->secure_control) {
+		/* Tag secured pins as invalid */
+		sec = readl_relaxed(bank->base + STM32_GPIO_SECCFGR);
+
+		for (i = 0; i < ngpios; i++) {
+			if (sec & BIT(i)) {
+				clear_bit(i, valid_mask);
+				dev_dbg(pctl->dev, "No access to gpio %d - %d\n", bank->bank_nr, i);
+			}
+		}
+	}
+
+	return 0;
+}
+
 static const struct gpio_chip stm32_gpio_template = {
 	.request		= stm32_gpio_request,
 	.free			= stm32_gpio_free,
@@ -293,6 +322,7 @@ static const struct gpio_chip stm32_gpio_template = {
 	.to_irq			= stm32_gpio_to_irq,
 	.get_direction		= stm32_gpio_get_direction,
 	.set_config		= gpiochip_generic_config,
+	.init_valid_mask	= stm32_gpio_init_valid_mask,
 };
 
 static void stm32_gpio_irq_trigger(struct irq_data *d)
@@ -837,12 +867,32 @@ static int stm32_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 	return stm32_pmx_set_mode(bank, pin, !input, 0);
 }
 
+static int stm32_pmx_request(struct pinctrl_dev *pctldev, unsigned int gpio)
+{
+	struct stm32_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct pinctrl_gpio_range *range;
+
+	range = pinctrl_find_gpio_range_from_pin_nolock(pctldev, gpio);
+	if (!range) {
+		dev_err(pctl->dev, "No gpio range defined.\n");
+		return -EINVAL;
+	}
+
+	if (!gpiochip_line_is_valid(range->gc, stm32_gpio_pin(gpio))) {
+		dev_warn(pctl->dev, "Can't access gpio %d\n", gpio);
+		return -EACCES;
+	}
+
+	return 0;
+}
+
 static const struct pinmux_ops stm32_pmx_ops = {
 	.get_functions_count	= stm32_pmx_get_funcs_cnt,
 	.get_function_name	= stm32_pmx_get_func_name,
 	.get_function_groups	= stm32_pmx_get_func_groups,
 	.set_mux		= stm32_pmx_set_mux,
 	.gpio_set_direction	= stm32_pmx_gpio_set_direction,
+	.request		= stm32_pmx_request,
 	.strict			= true,
 };
 
@@ -1039,6 +1089,11 @@ static int stm32_pconf_parse_conf(struct pinctrl_dev *pctldev,
 	bank = gpiochip_get_data(range->gc);
 	offset = stm32_gpio_pin(pin);
 
+	if (!gpiochip_line_is_valid(range->gc, offset)) {
+		dev_warn(pctl->dev, "Can't access gpio %d\n", pin);
+		return -EACCES;
+	}
+
 	switch (param) {
 	case PIN_CONFIG_DRIVE_PUSH_PULL:
 		ret = stm32_pconf_set_driving(bank, offset, 0);
@@ -1141,6 +1196,11 @@ static void stm32_pconf_dbg_show(struct pinctrl_dev *pctldev,
 	bank = gpiochip_get_data(range->gc);
 	offset = stm32_gpio_pin(pin);
 
+	if (!gpiochip_line_is_valid(range->gc, offset)) {
+		seq_puts(s, "NO ACCESS");
+		return;
+	}
+
 	stm32_pmx_get_mode(bank, offset, &mode, &alt);
 	bias = stm32_pconf_get_bias(bank, offset);
 
@@ -1253,6 +1313,7 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 	bank->gpio_chip.parent = dev;
 	bank->bank_nr = bank_nr;
 	bank->bank_ioport_nr = bank_ioport_nr;
+	bank->secure_control = pctl->match_data->secure_control;
 	spin_lock_init(&bank->lock);
 
 	/* create irq hierarchical domain */
@@ -1567,6 +1628,9 @@ static int __maybe_unused stm32_pinctrl_restore_gpio_regs(
 	if (!range)
 		return 0;
 
+	if (!gpiochip_line_is_valid(range->gc, offset))
+		return 0;
+
 	pin_is_irq = gpiochip_line_is_irq(range->gc, offset);
 
 	if (!desc || (!pin_is_irq && !desc->gpio_owner))
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.h b/drivers/pinctrl/stm32/pinctrl-stm32.h
index b9584039cdf5..d078c3ac5815 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.h
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.h
@@ -58,6 +58,7 @@ struct stm32_desc_pin {
 struct stm32_pinctrl_match_data {
 	const struct stm32_desc_pin *pins;
 	const unsigned int npins;
+	bool secure_control;
 };
 
 struct stm32_gpio_bank;
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32mp135.c b/drivers/pinctrl/stm32/pinctrl-stm32mp135.c
index f98717fe23ed..fde1df191c24 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32mp135.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32mp135.c
@@ -1649,6 +1649,7 @@ static const struct stm32_desc_pin stm32mp135_pins[] = {
 static struct stm32_pinctrl_match_data stm32mp135_match_data = {
 	.pins = stm32mp135_pins,
 	.npins = ARRAY_SIZE(stm32mp135_pins),
+	.secure_control = true,
 };
 
 static const struct of_device_id stm32mp135_pctrl_match[] = {
-- 
2.25.1

