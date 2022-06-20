Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F240A552593
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344732AbiFTULx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344570AbiFTUJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:09:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC012220CB;
        Mon, 20 Jun 2022 13:07:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso8276740wms.2;
        Mon, 20 Jun 2022 13:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gGGGI5LNQd5QfFmuY5vVwQrtUD8WBKwvWjL6Bicr/nE=;
        b=S/EtAgiYih2o97vzKZ46FuXvAcLZH4aZSRqS9u2yBKGwrnkXOKPCMGGLd7i9ZmxQaG
         BnBbK63aSq4v1vSjGAPc164mZGaSk3LPHtRt8daUl8xMv0xp20Wh0ybrxjQLqHXLqdDy
         yhDIj9t6XfrHHFv3whu+IVZQrWETjZ1AesrYnf54NJGg7Cy+3sRgTPv9faAKYSFooPY0
         45O48rrjzHJTrXu/6XULoJep5LjaBkkIDGdtmMKtfzD41Z5IcTn0ruAikZetXvnqo0Tl
         Zdz1vCizcAGpaQKPTcGKQxbHlaaCG3L3c003lP0kS60LBM2I8ti3fkUMC/+0uVt3nR1g
         Y3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGGGI5LNQd5QfFmuY5vVwQrtUD8WBKwvWjL6Bicr/nE=;
        b=V6mYZhraa+r19xr65iPPGyVil2wGL6CdM0InYTMK0U5V0tiQUDLhP3mcWeVHzP1eug
         VO5SV4J31vdxfBypf5MFWUTo3eTCH92eUZPcdm+OhyWxPeXuqlogzE6Y8P8raTPYEhAd
         cIZBDldTRIKE2/krY4YVbTPdbMBGZCBUNHl9IGIlJv7PXgW6Lx33vRuznbgHSv9S6s0y
         oVOl+OEo2+MkIu1t3FMu+UfnvzP4J47inWvj/a/CXKY9VPMQGXc0L4bJR7i+jyh9pZo+
         R/PgP8F07msI4UuxO1ed5bLiqpvlNzZMOP7KswxFR9ue+tpgG72YKQxQIBHlGy94tkQH
         4uVw==
X-Gm-Message-State: AJIora87Bt3QwjtkbXzFR9sHtCOvi4iJTb8Q8SpiqG3Sl2XrRYOIlNe4
        3lc2sjbxK1fa38PyBalCY2A=
X-Google-Smtp-Source: AGRyM1t7nmjsnyP7qTIA/w/988Wjv4MiUTlTDpMZzgOJTqyM5/Li8wCJHVRxnaV0tBlHxN/JpqOs4g==
X-Received: by 2002:a05:600c:4ec7:b0:39c:84a7:3762 with SMTP id g7-20020a05600c4ec700b0039c84a73762mr25749060wmq.153.1655755653087;
        Mon, 20 Jun 2022 13:07:33 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d6a87000000b0021b8c99860asm5606007wru.115.2022.06.20.13.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:07:32 -0700 (PDT)
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
Subject: [PATCH 48/49] mfd: qcom-pm8008: Use get_irq_reg() for irq chip
Date:   Mon, 20 Jun 2022 21:06:43 +0100
Message-Id: <20220620200644.1961936-49-aidanmacdonald.0x0@gmail.com>
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

Replace the not_fixed_stride flag with a get_irq_reg() callback,
which expresses what we want to do here more directly instead of
relying on a convoluted hierarchy of offsets.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/qcom-pm8008.c | 56 +++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index c778f2f87a17..f6407aa0bcfc 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -44,16 +44,6 @@ enum {
 #define PM8008_GPIO1_ADDR	PM8008_PERIPH_2_BASE
 #define PM8008_GPIO2_ADDR	PM8008_PERIPH_3_BASE
 
-#define PM8008_STATUS_BASE	(PM8008_PERIPH_0_BASE | INT_LATCHED_STS_OFFSET)
-#define PM8008_MASK_BASE	(PM8008_PERIPH_0_BASE | INT_EN_CLR_OFFSET)
-#define PM8008_UNMASK_BASE	(PM8008_PERIPH_0_BASE | INT_EN_SET_OFFSET)
-#define PM8008_TYPE_BASE	(PM8008_PERIPH_0_BASE | INT_SET_TYPE_OFFSET)
-#define PM8008_ACK_BASE		(PM8008_PERIPH_0_BASE | INT_LATCHED_CLR_OFFSET)
-#define PM8008_POLARITY_HI_BASE	(PM8008_PERIPH_0_BASE | INT_POL_HIGH_OFFSET)
-#define PM8008_POLARITY_LO_BASE	(PM8008_PERIPH_0_BASE | INT_POL_LOW_OFFSET)
-
-#define PM8008_PERIPH_OFFSET(paddr)	(paddr - PM8008_PERIPH_0_BASE)
-
 struct pm8008_data {
 	struct device *dev;
 	struct regmap *regmap;
@@ -61,22 +51,10 @@ struct pm8008_data {
 	struct regmap_irq_chip_data *irq_data;
 };
 
-static unsigned int p0_offs[] = {PM8008_PERIPH_OFFSET(PM8008_PERIPH_0_BASE)};
-static unsigned int p1_offs[] = {PM8008_PERIPH_OFFSET(PM8008_PERIPH_1_BASE)};
-static unsigned int p2_offs[] = {PM8008_PERIPH_OFFSET(PM8008_PERIPH_2_BASE)};
-static unsigned int p3_offs[] = {PM8008_PERIPH_OFFSET(PM8008_PERIPH_3_BASE)};
-
-static struct regmap_irq_sub_irq_map pm8008_sub_reg_offsets[] = {
-	REGMAP_IRQ_MAIN_REG_OFFSET(p0_offs),
-	REGMAP_IRQ_MAIN_REG_OFFSET(p1_offs),
-	REGMAP_IRQ_MAIN_REG_OFFSET(p2_offs),
-	REGMAP_IRQ_MAIN_REG_OFFSET(p3_offs),
-};
-
 static unsigned int pm8008_config_regs[] = {
-	PM8008_TYPE_BASE,
-	PM8008_POLARITY_HI_BASE,
-	PM8008_POLARITY_LO_BASE,
+	INT_SET_TYPE_OFFSET,
+	INT_POL_HIGH_OFFSET,
+	INT_POL_LOW_OFFSET,
 };
 
 enum {
@@ -96,6 +74,23 @@ static struct regmap_irq pm8008_irqs[] = {
 	REGMAP_IRQ_REG(PM8008_IRQ_GPIO2,	PM8008_GPIO2,	BIT(0)),
 };
 
+static const unsigned int pm8008_periph_base[] = {
+	PM8008_PERIPH_0_BASE,
+	PM8008_PERIPH_1_BASE,
+	PM8008_PERIPH_2_BASE,
+	PM8008_PERIPH_3_BASE,
+};
+
+static unsigned int pm8008_get_irq_reg(struct regmap_irq_chip_data *data,
+				       unsigned int base, int index)
+{
+	/* Simple linear addressing for the main status register */
+	if (base == I2C_INTR_STATUS_BASE)
+		return base + index;
+
+	return pm8008_periph_base[index] + base;
+}
+
 static int pm8008_set_type_config(unsigned int **buf, unsigned int type,
 				  const struct regmap_irq *irq_data, int idx)
 {
@@ -136,17 +131,16 @@ static struct regmap_irq_chip pm8008_irq_chip = {
 	.irqs			= pm8008_irqs,
 	.num_irqs		= ARRAY_SIZE(pm8008_irqs),
 	.num_regs		= PM8008_NUM_PERIPHS,
-	.not_fixed_stride	= true,
-	.sub_reg_offsets	= pm8008_sub_reg_offsets,
-	.status_base		= PM8008_STATUS_BASE,
-	.mask_base		= PM8008_MASK_BASE,
-	.unmask_base		= PM8008_UNMASK_BASE,
+	.status_base		= INT_LATCHED_STS_OFFSET,
+	.mask_base		= INT_EN_CLR_OFFSET,
+	.unmask_base		= INT_EN_SET_OFFSET,
 	.mask_writeonly		= true,
-	.ack_base		= PM8008_ACK_BASE,
+	.ack_base		= INT_LATCHED_CLR_OFFSET,
 	.config_base		= pm8008_config_regs,
 	.num_config_bases	= ARRAY_SIZE(pm8008_config_regs),
 	.num_config_regs	= PM8008_NUM_PERIPHS,
 	.set_type_config	= pm8008_set_type_config,
+	.get_irq_reg		= pm8008_get_irq_reg,
 };
 
 static struct regmap_config qcom_mfd_regmap_cfg = {
-- 
2.35.1

