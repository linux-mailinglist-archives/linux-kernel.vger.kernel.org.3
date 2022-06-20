Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBE7552543
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbiFTUHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343673AbiFTUGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA84F1D31C;
        Mon, 20 Jun 2022 13:06:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g27so9431885wrb.10;
        Mon, 20 Jun 2022 13:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DxJmWv+hNttTbxmMnV8/0ynx/LV1OsxaVUXYP15PQh0=;
        b=BTO8A9HSWQnGNlJMXGdjduAwCNw3J11bxtii/kElmojKXpaQs9JJN+nB/Z11ecJ4+t
         aPcLjAvZTskP0Yy6Kx/uIv0Pq4VWXkpkS0ydzCVOuqbhT6f6VQizjp7Sw04Q9ffxbkhH
         csmvkrDN8vedL9apF4hjml4cDaHMUEENPeOpI+nc8qXBzi0Wj2VwJTYkHME9zb913aEV
         IKyBbkfVxi5GJtK2kKrwaqqf8HvGUo/7yih/Vli27G+00xxOpMWmGXBttaJ/eXDOS/2E
         m+aHlEaTYXuUuMTbUBmdEYfc5z0kBqJKMG9awNzXrPF6DsLmWYoGVOaU8py71drMcwzH
         ZOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DxJmWv+hNttTbxmMnV8/0ynx/LV1OsxaVUXYP15PQh0=;
        b=UyZsaEZSpgFfT6f12tiMwbsRsHphhQNCaUSprZ2YvJ5sd1oL0FFN4q/XksdcgfYh1k
         7sqlqe5GvMc16oLX0379qPhu8XtlBOgbOK90Fzcz6Vn21lloxB194KDpZDrJA6EkVPff
         D8a3yP4PrCZ1z66gQi3hc6/f8PRl0beRqA/uE0pGgLUnVHBzspUFu63+N9JKYRuYWLxF
         Xa3I2E2fipvH9HrwaqioOSRPMAJ+Gj3aLkni06et//MNqxMQ7lrTvPx4ReiQUvf2KYnM
         Af5khjtr5SjdLX0YTj5IO5ovnWEU8czMUZ/Sj0oAOcLksliH7weX4nNOQAGpUgTWIOIO
         cQtg==
X-Gm-Message-State: AJIora8ncE9dHfDLAqJwxBetmA0Az99EyWsERocoS3VRJlzNy+A2G2Cp
        VJrWlKdOzSXfvvZzkPJQIMI=
X-Google-Smtp-Source: AGRyM1u9FwilnQ/YSzQ7+AkLyasXeK9euw6s745o8xH3ioUxds4vNSlLHDgKFQb8ki5d0K5hJNGaTg==
X-Received: by 2002:adf:a35a:0:b0:21a:3431:fcc with SMTP id d26-20020adfa35a000000b0021a34310fccmr22166494wrb.241.1655755592351;
        Mon, 20 Jun 2022 13:06:32 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id a17-20020a056000101100b00213465d202esm14269010wrx.46.2022.06.20.13.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:31 -0700 (PDT)
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
Subject: [PATCH 11/49] regmap-irq: Remove old type register support, refactor
Date:   Mon, 20 Jun 2022 21:06:06 +0100
Message-Id: <20220620200644.1961936-12-aidanmacdonald.0x0@gmail.com>
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

Now that all users have been converted to use config registers
for setting IRQ types, the old type register handling code can
be removed. Also refactor the parts related to type_in_mask.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 102 +++++--------------------------
 include/linux/regmap.h           |   4 --
 2 files changed, 14 insertions(+), 92 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 5a3e255816fd..85d7fd4e07d7 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -36,8 +36,7 @@ struct regmap_irq_chip_data {
 	unsigned int *mask_buf;
 	unsigned int *mask_buf_def;
 	unsigned int *wake_buf;
-	unsigned int *type_buf;
-	unsigned int *type_buf_def;
+	unsigned int *mask_type_buf;
 	unsigned int **config_buf;
 
 	unsigned int irq_reg_stride;
@@ -199,24 +198,6 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 		}
 	}
 
-	/* Don't update the type bits if we're using mask bits for irq type. */
-	if (!d->chip->type_in_mask) {
-		for (i = 0; i < d->chip->num_type_reg; i++) {
-			if (!d->type_buf_def[i])
-				continue;
-			reg = sub_irq_reg(d, d->chip->type_base, i);
-			if (d->chip->type_invert)
-				ret = regmap_irq_update_bits(d, reg,
-					d->type_buf_def[i], ~d->type_buf[i]);
-			else
-				ret = regmap_irq_update_bits(d, reg,
-					d->type_buf_def[i], d->type_buf[i]);
-			if (ret != 0)
-				dev_err(d->map->dev, "Failed to sync type in %x\n",
-					reg);
-		}
-	}
-
 	for (i = 0; i < d->chip->num_config_bases; i++) {
 		for (j = 0; j < d->chip->num_config_regs; j++) {
 			reg = sub_irq_reg(d, d->chip->config_base[i], j);
@@ -259,11 +240,11 @@ static void regmap_irq_enable(struct irq_data *data)
 	 *
 	 * If the interrupt we're enabling defines any supported types
 	 * then instead of using the regular mask bits for this interrupt,
-	 * use the value previously written to the type buffer at the
+	 * use the value previously written to the mask_type buffer at the
 	 * corresponding offset in regmap_irq_set_type().
 	 */
 	if (d->chip->type_in_mask && irq_data->type.types_supported)
-		mask = d->type_buf[reg] & irq_data->mask;
+		mask = d->mask_type_buf[reg] & irq_data->mask;
 	else
 		mask = irq_data->mask;
 
@@ -287,50 +268,21 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 	struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
 	struct regmap *map = d->map;
 	const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
-	int reg;
 	const struct regmap_irq_type *t = &irq_data->type;
+	unsigned int reg;
 
-	if ((t->types_supported & type) != type)
+	if ((irq_data->type.types_supported & type) != type)
 		return 0;
 
 	reg = t->type_reg_offset / map->reg_stride;
 
+	if (d->chip->type_in_mask)
+		return regmap_irq_set_type_config_simple(&d->mask_type_buf,
+							 type, irq_data, reg);
 	if (d->chip->set_type_config)
 		return d->chip->set_type_config(d->config_buf, type,
 						irq_data, reg);
 
-	if (t->type_reg_mask)
-		d->type_buf[reg] &= ~t->type_reg_mask;
-	else
-		d->type_buf[reg] &= ~(t->type_falling_val |
-				      t->type_rising_val |
-				      t->type_level_low_val |
-				      t->type_level_high_val);
-	switch (type) {
-	case IRQ_TYPE_EDGE_FALLING:
-		d->type_buf[reg] |= t->type_falling_val;
-		break;
-
-	case IRQ_TYPE_EDGE_RISING:
-		d->type_buf[reg] |= t->type_rising_val;
-		break;
-
-	case IRQ_TYPE_EDGE_BOTH:
-		d->type_buf[reg] |= (t->type_falling_val |
-					t->type_rising_val);
-		break;
-
-	case IRQ_TYPE_LEVEL_HIGH:
-		d->type_buf[reg] |= t->type_level_high_val;
-		break;
-
-	case IRQ_TYPE_LEVEL_LOW:
-		d->type_buf[reg] |= t->type_level_low_val;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
@@ -682,7 +634,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	struct regmap_irq_chip_data *d;
 	int i;
 	int ret = -ENOMEM;
-	int num_type_reg;
 	u32 reg;
 	u32 unmask_offset;
 
@@ -750,16 +701,10 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			goto err_alloc;
 	}
 
-	num_type_reg = chip->type_in_mask ? chip->num_regs : chip->num_type_reg;
-	if (num_type_reg) {
-		d->type_buf_def = kcalloc(num_type_reg,
-					  sizeof(unsigned int), GFP_KERNEL);
-		if (!d->type_buf_def)
-			goto err_alloc;
-
-		d->type_buf = kcalloc(num_type_reg, sizeof(unsigned int),
-				      GFP_KERNEL);
-		if (!d->type_buf)
+	if (chip->type_in_mask) {
+		d->mask_type_buf = kcalloc(chip->num_regs,
+					   sizeof(unsigned int), GFP_KERNEL);
+		if (!d->mask_type_buf)
 			goto err_alloc;
 	}
 
@@ -899,23 +844,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		}
 	}
 
-	if (chip->num_type_reg && !chip->type_in_mask) {
-		for (i = 0; i < chip->num_type_reg; ++i) {
-			reg = sub_irq_reg(d, d->chip->type_base, i);
-
-			ret = regmap_read(map, reg, &d->type_buf_def[i]);
-
-			if (d->chip->type_invert)
-				d->type_buf_def[i] = ~d->type_buf_def[i];
-
-			if (ret) {
-				dev_err(map->dev, "Failed to get type defaults at 0x%x: %d\n",
-					reg, ret);
-				goto err_alloc;
-			}
-		}
-	}
-
 	if (irq_base)
 		d->domain = irq_domain_create_legacy(fwnode, chip->num_irqs,
 						     irq_base, 0,
@@ -945,8 +873,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 err_domain:
 	/* Should really dispose of the domain but... */
 err_alloc:
-	kfree(d->type_buf);
-	kfree(d->type_buf_def);
+	kfree(d->mask_type_buf);
 	kfree(d->wake_buf);
 	kfree(d->mask_buf_def);
 	kfree(d->mask_buf);
@@ -1020,8 +947,7 @@ void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *d)
 	}
 
 	irq_domain_remove(d->domain);
-	kfree(d->type_buf);
-	kfree(d->type_buf_def);
+	kfree(d->mask_type_buf);
 	kfree(d->wake_buf);
 	kfree(d->mask_buf_def);
 	kfree(d->mask_buf);
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index bb8c89a83b51..879afdc81526 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1458,7 +1458,6 @@ struct regmap_irq_sub_irq_map {
  * @ack_base:    Base ack address. If zero then the chip is clear on read.
  *               Using zero value is possible with @use_ack bit.
  * @wake_base:   Base address for wake enables.  If zero unsupported.
- * @type_base:   Base address for irq type.  If zero unsupported.
  * @config_base: Base address for IRQ type config regs. If null unsupported.
  * @irq_reg_stride:  Stride to use for chips where registers are not contiguous.
  * @init_ack_masked: Ack all masked interrupts once during initalization.
@@ -1484,7 +1483,6 @@ struct regmap_irq_sub_irq_map {
  * @irqs:        Descriptors for individual IRQs.  Interrupt numbers are
  *               assigned based on the index in the array of the interrupt.
  * @num_irqs:    Number of descriptors.
- * @num_type_reg:    Number of type registers.
  * @type_reg_stride: Stride to use for chips where type registers are not
  *			contiguous.
  * @num_config_bases:	Number of config base registers.
@@ -1514,7 +1512,6 @@ struct regmap_irq_chip {
 	unsigned int unmask_base;
 	unsigned int ack_base;
 	unsigned int wake_base;
-	unsigned int type_base;
 	const unsigned int *config_base;
 	unsigned int irq_reg_stride;
 	bool mask_writeonly:1;
@@ -1536,7 +1533,6 @@ struct regmap_irq_chip {
 	const struct regmap_irq *irqs;
 	int num_irqs;
 
-	int num_type_reg;
 	int num_config_bases;
 	int num_config_regs;
 	unsigned int type_reg_stride;
-- 
2.35.1

