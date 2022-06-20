Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EDD552506
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343659AbiFTUGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245078AbiFTUG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C781CFE9;
        Mon, 20 Jun 2022 13:06:24 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g4so16059750wrh.11;
        Mon, 20 Jun 2022 13:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+RKr+XEaRdRjV4wQDDo6dA3o5NhQRFg9bdRqt89GYJ0=;
        b=MFe3Q+6q+h4xcL+TmQJO+X66B7qIj60KwU1bFNqVSVGdb6rLV0HBSOV2kqB2IjbUOu
         EeUFb2zxP73mwWK5HebDmiVlcTN8/lZAhuLs1PYprMOgS3IJsFXo991qtdEe757TgDt9
         PNPQFGJRS+9ee64SFv8BTOpI+yUy8iMY6XDOthlwL791AZzHrgjOrzL2Z+WNMe4Q5oWF
         qoB1e1HBzkv5OpvL4CfZkeKUFNVwqSHVXe+sPPHD6FW/G5Yf9GVjSClhAKk8/5129GdY
         Md+190DcO8iXrY/zsP1mYBAaO/sM8k8KeCFB2bYWTrEW6jR8+hXYDV/1ognbiuUqqzMD
         dr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+RKr+XEaRdRjV4wQDDo6dA3o5NhQRFg9bdRqt89GYJ0=;
        b=2Mu1u3QsFS+VHDyubNuraQmf+2ck1Xd8ppLpLdJGoCmfzhvlNbfGCIVTA/iru/LNUv
         Ix8r366Qk7c/KYfc52aGfpbmhqfPglthJ8JdwZi+QC/33qhCKgFXKHLVHv8gMWsohvuy
         aL+Q1GBq5GBPfivYRYopKMVNV8DUL5xc94boTrYMpcShmTQaEOamK+aNCHyJSkud9xQW
         r4jGZiv77O0S7cV2lS34adORHFuI6pqH5wGS/T9naz6Zl+Hti31k1nyfgm3BRWXDTOVP
         vfdk5YFM7fZCpaamqSr87p6YLhvrEAe+ZBeookf/aBS/fIurUv6cikf/UzAk6Mc5DB4y
         UXQA==
X-Gm-Message-State: AJIora9CgNVj41q40z4cfH+F1huZBsqmertO2mPAogjGR6xsT+Z3cgJi
        yj2EJNlY8jdEwaMDA3m4PlY=
X-Google-Smtp-Source: AGRyM1s4brtjxXAe+5dbgtT8AX6IW9qXMEOUfwY6ndJ5c4LaV2MOHLy/q9oiZpUl7AFgXk1xm6zPXA==
X-Received: by 2002:a5d:6d8f:0:b0:218:45ef:30c2 with SMTP id l15-20020a5d6d8f000000b0021845ef30c2mr23978566wrs.411.1655755582833;
        Mon, 20 Jun 2022 13:06:22 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id x13-20020adfdd8d000000b0021b81855c1csm12567311wrl.27.2022.06.20.13.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:22 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl,
        tglx@linutronix.de, maz@kernel.org, lee.jones@linaro.org,
        mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, rjones@gateworks.com,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org
Subject: [PATCH 05/49] mfd: qcom-pm8008: Convert irq chip to config regs
Date:   Mon, 20 Jun 2022 21:06:00 +0100
Message-Id: <20220620200644.1961936-6-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use config registers to simplify the driver, putting all of the
code for irq type configuration in one place instead of splitting
it up arbitrarily between type and virtual registers.

Remove the initial register setting in pm8008_init(). The comment
indicates this is a hack to work around quirks in regmap-irq, but
this is not necessary if using config registers.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/qcom-pm8008.c | 76 +++++++++++----------------------------
 1 file changed, 21 insertions(+), 55 deletions(-)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index c472d7f8103c..da16566f7883 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -73,15 +73,16 @@ static struct regmap_irq_sub_irq_map pm8008_sub_reg_offsets[] = {
 	REGMAP_IRQ_MAIN_REG_OFFSET(p3_offs),
 };
 
-static unsigned int pm8008_virt_regs[] = {
+static unsigned int pm8008_config_regs[] = {
+	PM8008_TYPE_BASE,
 	PM8008_POLARITY_HI_BASE,
 	PM8008_POLARITY_LO_BASE,
 };
 
 enum {
+	SET_TYPE_INDEX,
 	POLARITY_HI_INDEX,
 	POLARITY_LO_INDEX,
-	PM8008_NUM_VIRT_REGS,
 };
 
 static struct regmap_irq pm8008_irqs[] = {
@@ -95,32 +96,36 @@ static struct regmap_irq pm8008_irqs[] = {
 	REGMAP_IRQ_REG(PM8008_IRQ_GPIO2,	PM8008_GPIO2,	BIT(0)),
 };
 
-static int pm8008_set_type_virt(unsigned int **virt_buf,
-				      unsigned int type, unsigned long hwirq,
-				      int reg)
+static int pm8008_set_type_config(unsigned int **buf, unsigned int type,
+				  const struct regmap_irq *irq_data, int idx)
 {
 	switch (type) {
 	case IRQ_TYPE_EDGE_FALLING:
 	case IRQ_TYPE_LEVEL_LOW:
-		virt_buf[POLARITY_HI_INDEX][reg] &= ~pm8008_irqs[hwirq].mask;
-		virt_buf[POLARITY_LO_INDEX][reg] |= pm8008_irqs[hwirq].mask;
+		buf[POLARITY_HI_INDEX][idx] &= ~irq_data->mask;
+		buf[POLARITY_LO_INDEX][idx] |= irq_data->mask;
 		break;
 
 	case IRQ_TYPE_EDGE_RISING:
 	case IRQ_TYPE_LEVEL_HIGH:
-		virt_buf[POLARITY_HI_INDEX][reg] |= pm8008_irqs[hwirq].mask;
-		virt_buf[POLARITY_LO_INDEX][reg] &= ~pm8008_irqs[hwirq].mask;
+		buf[POLARITY_HI_INDEX][idx] |= irq_data->mask;
+		buf[POLARITY_LO_INDEX][idx] &= ~irq_data->mask;
 		break;
 
 	case IRQ_TYPE_EDGE_BOTH:
-		virt_buf[POLARITY_HI_INDEX][reg] |= pm8008_irqs[hwirq].mask;
-		virt_buf[POLARITY_LO_INDEX][reg] |= pm8008_irqs[hwirq].mask;
+		buf[POLARITY_HI_INDEX][idx] |= irq_data->mask;
+		buf[POLARITY_LO_INDEX][idx] |= irq_data->mask;
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		buf[SET_TYPE_INDEX][idx] |= irq_data->mask;
+	else
+		buf[SET_TYPE_INDEX][idx] &= ~irq_data->mask;
+
 	return 0;
 }
 
@@ -128,20 +133,19 @@ static struct regmap_irq_chip pm8008_irq_chip = {
 	.name			= "pm8008_irq",
 	.main_status		= I2C_INTR_STATUS_BASE,
 	.num_main_regs		= 1,
-	.num_virt_regs		= PM8008_NUM_VIRT_REGS,
 	.irqs			= pm8008_irqs,
 	.num_irqs		= ARRAY_SIZE(pm8008_irqs),
 	.num_regs		= PM8008_NUM_PERIPHS,
 	.not_fixed_stride	= true,
 	.sub_reg_offsets	= pm8008_sub_reg_offsets,
-	.set_type_virt		= pm8008_set_type_virt,
 	.status_base		= PM8008_STATUS_BASE,
 	.mask_base		= PM8008_MASK_BASE,
 	.unmask_base		= PM8008_UNMASK_BASE,
-	.type_base		= PM8008_TYPE_BASE,
 	.ack_base		= PM8008_ACK_BASE,
-	.virt_reg_base		= pm8008_virt_regs,
-	.num_type_reg		= PM8008_NUM_PERIPHS,
+	.config_base		= pm8008_config_regs,
+	.num_config_bases	= ARRAY_SIZE(pm8008_config_regs),
+	.num_config_regs	= PM8008_NUM_PERIPHS,
+	.set_type_config	= pm8008_set_type_config,
 };
 
 static struct regmap_config qcom_mfd_regmap_cfg = {
@@ -150,34 +154,6 @@ static struct regmap_config qcom_mfd_regmap_cfg = {
 	.max_register	= 0xFFFF,
 };
 
-static int pm8008_init(struct pm8008_data *chip)
-{
-	int rc;
-
-	/*
-	 * Set TEMP_ALARM peripheral's TYPE so that the regmap-irq framework
-	 * reads this as the default value instead of zero, the HW default.
-	 * This is required to enable the writing of TYPE registers in
-	 * regmap_irq_sync_unlock().
-	 */
-	rc = regmap_write(chip->regmap,
-			 (PM8008_TEMP_ALARM_ADDR | INT_SET_TYPE_OFFSET),
-			 BIT(0));
-	if (rc)
-		return rc;
-
-	/* Do the same for GPIO1 and GPIO2 peripherals */
-	rc = regmap_write(chip->regmap,
-			 (PM8008_GPIO1_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
-	if (rc)
-		return rc;
-
-	rc = regmap_write(chip->regmap,
-			 (PM8008_GPIO2_ADDR | INT_SET_TYPE_OFFSET), BIT(0));
-
-	return rc;
-}
-
 static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
 					int client_irq)
 {
@@ -185,20 +161,10 @@ static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
 	struct regmap_irq_type *type;
 	struct regmap_irq_chip_data *irq_data;
 
-	rc = pm8008_init(chip);
-	if (rc) {
-		dev_err(chip->dev, "Init failed: %d\n", rc);
-		return rc;
-	}
-
 	for (i = 0; i < ARRAY_SIZE(pm8008_irqs); i++) {
 		type = &pm8008_irqs[i].type;
 
-		type->type_reg_offset	  = pm8008_irqs[i].reg_offset;
-		type->type_rising_val	  = pm8008_irqs[i].mask;
-		type->type_falling_val	  = pm8008_irqs[i].mask;
-		type->type_level_high_val = 0;
-		type->type_level_low_val  = 0;
+		type->type_reg_offset = pm8008_irqs[i].reg_offset;
 
 		if (type->type_reg_offset == PM8008_MISC)
 			type->types_supported = IRQ_TYPE_EDGE_RISING;
-- 
2.35.1

