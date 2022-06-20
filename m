Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5814155250A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbiFTUGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245336AbiFTUG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4751AF11;
        Mon, 20 Jun 2022 13:06:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z17so6379642wmi.1;
        Mon, 20 Jun 2022 13:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n7C5fvVEgBv5GCdLdnesehqd1UexDtPscEtDq8TpQ98=;
        b=iqvQ3lEYGu10uGW18Rm99ayT8x3XLn8XsO9ymyUHVGvqkrAaQyuQPHeJloUfiJLsCF
         brvGIxTPxFY1qneHHNIXCVo9xBJ6RdKlEW0a+M06XrPY9smcUzKXBODzoRGSYX2fBOi0
         ois+9p71zNywpoyFgK1TIsJrPw8oRs+q2dNOU0miygmL4JPhI83OXUTFGpe0qYtNO5ma
         dzfiFEZpepT2Nxpnrff763DGS7DNF3ILweh1b8BAmm8zFxc2WGUKCoGEy5vMCKQkMK8d
         xKAxIIl3WT/W48wenSiIcIm+nDxzv7O78vP0Jryl5YepV6he0PFC0T0HzFB52vF6jmKy
         3vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n7C5fvVEgBv5GCdLdnesehqd1UexDtPscEtDq8TpQ98=;
        b=hqTC+A8TMPNVvhtHEWDZLAh5CqI/bO7ipg3P2RWcZ7W3Jxyhya4kGOK9mDucOHnFJz
         /OJ48Ca9EloWPsfMwF9GR7SIT4o1wMWSZTv/vrl2jauPiUncH6vrRyS1hvs7xiYJJ/iQ
         bmSDT9BFKV/j4drpAym9zYUKGUJsI1kXUEGuGrtCgf6+hmj2wa6JRLeZaZE9yplaJHgx
         LMb077YwRsrLfEJ4DN1SEgbLK9okIOTxEoRu0VX/ZMxOk7vOCYq0KWlhWxBs3GFMvgCk
         +0HA0QIbSzOlmFHedPFuq3eyHM7rp1+5DmreK8iRoksLk0BqrTbBZ0lipp34eMVC+c0N
         x+SA==
X-Gm-Message-State: AOAM531cjriSjSs0ze8voBqeHoRF+QQ3GU2IwoOp9c1E23CuMoPupRcD
        2JuWXUmxu+UzSb5rlyCRGOw=
X-Google-Smtp-Source: ABdhPJx6f36rmenVzwLf28ElgO1YJCiHAg7RsENbp/+lJ/G4kOpdScdIio38B+uaAC+s+EJF6BDpIQ==
X-Received: by 2002:a05:600c:4f14:b0:39c:8612:a95e with SMTP id l20-20020a05600c4f1400b0039c8612a95emr37337282wmq.107.1655755581260;
        Mon, 20 Jun 2022 13:06:21 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id d8-20020adfc088000000b00213ba0cab3asm14319173wrf.44.2022.06.20.13.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:20 -0700 (PDT)
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
Subject: [PATCH 04/49] regmap-irq: Introduce config registers for irq types
Date:   Mon, 20 Jun 2022 21:05:59 +0100
Message-Id: <20220620200644.1961936-5-aidanmacdonald.0x0@gmail.com>
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

Config registers provide a more uniform approach to handling irq type
registers. They are essentially an extension of the virtual registers
used by the qcom-pm8008 driver.

Config registers can be represented as a 2D array:

    config_base[0]      reg0,0      reg0,1      reg0,2      reg0,3
    config_base[1]      reg1,0      reg1,1      reg1,2      reg1,3
    config_base[2]      reg2,0      reg2,1      reg2,2      reg2,3

There are 'num_config_bases' base registers, each of which is used to
address 'num_config_regs' registers. The addresses are calculated in
the same way as for other bases. It is assumed that an irq's type is
controlled by one column of registers; that column is identified by
the irq's 'type_reg_offset'.

The set_type_config() callback is responsible for updating the config
register contents. It receives an array of buffers (each represents a
row of registers) and the index of the column to update, along with
the 'struct regmap_irq' description and requested irq type.

Buffered values are written to registers in regmap_irq_sync_unlock().
Note that the entire register contents are overwritten, which is a
minor change in behavior from type registers via 'type_base'.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 102 ++++++++++++++++++++++++++++++-
 include/linux/regmap.h           |  12 ++++
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 59cfd4000e63..be35f2e41b8c 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -39,6 +39,7 @@ struct regmap_irq_chip_data {
 	unsigned int *type_buf;
 	unsigned int *type_buf_def;
 	unsigned int **virt_buf;
+	unsigned int **config_buf;
 
 	unsigned int irq_reg_stride;
 	unsigned int type_reg_stride;
@@ -231,6 +232,17 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 		}
 	}
 
+	for (i = 0; i < d->chip->num_config_bases; i++) {
+		for (j = 0; j < d->chip->num_config_regs; j++) {
+			reg = sub_irq_reg(d, d->chip->config_base[i], j);
+			ret = regmap_write(map, reg, d->config_buf[i][j]);
+			if (ret != 0)
+				dev_err(d->map->dev,
+					"Failed to write config %x: %d\n",
+					reg, ret);
+		}
+	}
+
 	if (d->chip->runtime_pm)
 		pm_runtime_put(map->dev);
 
@@ -298,6 +310,10 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 
 	reg = t->type_reg_offset / map->reg_stride;
 
+	if (d->chip->set_type_config)
+		return d->chip->set_type_config(d->config_buf, type,
+						irq_data, reg);
+
 	if (t->type_reg_mask)
 		d->type_buf[reg] &= ~t->type_reg_mask;
 	else
@@ -603,6 +619,62 @@ static const struct irq_domain_ops regmap_domain_ops = {
 	.xlate	= irq_domain_xlate_onetwocell,
 };
 
+/**
+ * regmap_irq_set_type_config_simple() - Simple IRQ type configuration callback.
+ *
+ * @buf: Buffer containing configuration register values, this is a 2D array of
+ *       `num_config_bases` rows, each of `num_config_regs` elements.
+ * @type: The requested IRQ type.
+ * @irq_data: The IRQ being configured.
+ * @idx: Index of the irq's config registers within each array `buf[i]`
+ *
+ * This is a &struct regmap_irq_chip->set_type_config callback suitable for
+ * chips with one config register. Register values are updated according to
+ * the &struct regmap_irq_type data associated with an IRQ.
+ */
+int regmap_irq_set_type_config_simple(unsigned int **buf, unsigned int type,
+				      const struct regmap_irq *irq_data, int idx)
+{
+	const struct regmap_irq_type *t = &irq_data->type;
+
+	if (t->type_reg_mask)
+		buf[0][idx] &= ~t->type_reg_mask;
+	else
+		buf[0][idx] &= ~(t->type_falling_val |
+				 t->type_rising_val |
+				 t->type_level_low_val |
+				 t->type_level_high_val);
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_FALLING:
+		buf[0][idx] |= t->type_falling_val;
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		buf[0][idx] |= t->type_rising_val;
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		buf[0][idx] |= (t->type_falling_val |
+				t->type_rising_val);
+		break;
+
+	case IRQ_TYPE_LEVEL_HIGH:
+		buf[0][idx] |= t->type_level_high_val;
+		break;
+
+	case IRQ_TYPE_LEVEL_LOW:
+		buf[0][idx] |= t->type_level_low_val;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(regmap_irq_set_type_config_simple);
+
 /**
  * regmap_add_irq_chip_fwnode() - Use standard regmap IRQ controller handling
  *
@@ -728,6 +800,24 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		}
 	}
 
+	if (chip->num_config_bases && chip->num_config_regs) {
+		/*
+		 * Create config_buf[num_config_bases][num_config_regs]
+		 */
+		d->config_buf = kcalloc(chip->num_config_bases,
+					sizeof(*d->config_buf), GFP_KERNEL);
+		if (!d->config_buf)
+			goto err_alloc;
+
+		for (i = 0; i < chip->num_config_regs; i++) {
+			d->config_buf[i] = kcalloc(chip->num_config_regs,
+						   sizeof(unsigned int),
+						   GFP_KERNEL);
+			if (!d->config_buf[i])
+				goto err_alloc;
+		}
+	}
+
 	d->irq_chip = regmap_irq_chip;
 	d->irq_chip.name = chip->name;
 	d->irq = irq;
@@ -904,6 +994,11 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			kfree(d->virt_buf[i]);
 		kfree(d->virt_buf);
 	}
+	if (d->config_buf) {
+		for (i = 0; i < chip->num_config_bases; i++)
+			kfree(d->config_buf[i]);
+		kfree(d->config_buf);
+	}
 	kfree(d);
 	return ret;
 }
@@ -944,7 +1039,7 @@ EXPORT_SYMBOL_GPL(regmap_add_irq_chip);
 void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *d)
 {
 	unsigned int virq;
-	int hwirq;
+	int i, hwirq;
 
 	if (!d)
 		return;
@@ -974,6 +1069,11 @@ void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *d)
 	kfree(d->mask_buf);
 	kfree(d->status_reg_buf);
 	kfree(d->status_buf);
+	if (d->config_buf) {
+		for (i = 0; i < d->chip->num_config_bases; i++)
+			kfree(d->config_buf[i]);
+		kfree(d->config_buf);
+	}
 	kfree(d);
 }
 EXPORT_SYMBOL_GPL(regmap_del_irq_chip);
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 8952fa3d0d59..e48d65756fb4 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1460,6 +1460,7 @@ struct regmap_irq_sub_irq_map {
  * @wake_base:   Base address for wake enables.  If zero unsupported.
  * @type_base:   Base address for irq type.  If zero unsupported.
  * @virt_reg_base:   Base addresses for extra config regs.
+ * @config_base: Base address for IRQ type config regs. If null unsupported.
  * @irq_reg_stride:  Stride to use for chips where registers are not contiguous.
  * @init_ack_masked: Ack all masked interrupts once during initalization.
  * @mask_invert: Inverted mask register: cleared bits are masked out.
@@ -1489,12 +1490,15 @@ struct regmap_irq_sub_irq_map {
  *		     If zero unsupported.
  * @type_reg_stride: Stride to use for chips where type registers are not
  *			contiguous.
+ * @num_config_bases:	Number of config base registers.
+ * @num_config_regs:	Number of config registers for each config base register.
  * @handle_pre_irq:  Driver specific callback to handle interrupt from device
  *		     before regmap_irq_handler process the interrupts.
  * @handle_post_irq: Driver specific callback to handle interrupt from device
  *		     after handling the interrupts in regmap_irq_handler().
  * @set_type_virt:   Driver specific callback to extend regmap_irq_set_type()
  *		     and configure virt regs.
+ * @set_type_config: Callback used for configuring irq types.
  * @irq_drv_data:    Driver specific IRQ data which is passed as parameter when
  *		     driver specific pre/post interrupt handler is called.
  *
@@ -1517,6 +1521,7 @@ struct regmap_irq_chip {
 	unsigned int wake_base;
 	unsigned int type_base;
 	unsigned int *virt_reg_base;
+	const unsigned int *config_base;
 	unsigned int irq_reg_stride;
 	bool mask_writeonly:1;
 	bool init_ack_masked:1;
@@ -1539,17 +1544,24 @@ struct regmap_irq_chip {
 
 	int num_type_reg;
 	int num_virt_regs;
+	int num_config_bases;
+	int num_config_regs;
 	unsigned int type_reg_stride;
 
 	int (*handle_pre_irq)(void *irq_drv_data);
 	int (*handle_post_irq)(void *irq_drv_data);
 	int (*set_type_virt)(unsigned int **buf, unsigned int type,
 			     unsigned long hwirq, int reg);
+	int (*set_type_config)(unsigned int **buf, unsigned int type,
+			       const struct regmap_irq *irq_data, int idx);
 	void *irq_drv_data;
 };
 
 struct regmap_irq_chip_data;
 
+int regmap_irq_set_type_config_simple(unsigned int **buf, unsigned int type,
+				      const struct regmap_irq *irq_data, int idx);
+
 int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 			int irq_base, const struct regmap_irq_chip *chip,
 			struct regmap_irq_chip_data **data);
-- 
2.35.1

