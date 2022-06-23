Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B858558A85
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiFWVOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiFWVNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:13:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71E051310
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m1so542041wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFicCXDe5rb79PhZKoaZ8t2q32vOWXf1ocVF975OVTs=;
        b=bz3W2eW4ow4FraSLDvoD8TxAt3V1s+cOxxbEl5XanYbi0yPQ95jBgJMyPcIOPVYfWT
         L1UI8wcyeVIjrUw9XTsZDxgeQsn1/6WEO69ajLqP801NJfSj3ufjeC7xRmblVL2sggdF
         AJluDa/3NjkEr0g6tJDIUUS1EROB1tp9JH4wj3A2pC1g+AcxV2t1/XcuCphMCx0isFUe
         QHgzhpNh/8rYSH/o/wL19oO0Kg8hZpG5zAoEFdDOOqVcbS20iBMYa8qIGa9DtDbDrwxd
         3PIc89K+NVTuUkj5911jxKv0EULDlAKjluQjhxiIoJJeaHvUhzDQWSa/m17coDEruUAa
         T2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFicCXDe5rb79PhZKoaZ8t2q32vOWXf1ocVF975OVTs=;
        b=7lMxr14PAu9pV8CUeFlZ6bTApeyTnnD4LCj9CWZTPQAio7zmBuqCW6FIBW9QYUyqsQ
         Ex49miZaBvguVgjJHOrPthfZAhMUmBJFvwYbGQz4nQWyWhWrzPeKPzh57+CGenFeJSdX
         5gaD2u+UUQtkxKpIgjyc2G3RTlaGyHfwsOb55x8rqRrymzbds0ix2N1y5CK+y2/92sve
         LrSOYgM2L3sTkby5fKRzcWnciTrld2Wfug10Vw+pQbd1FFvXeW0X3xOx7S+lt5dSvz7E
         d2uuqAKxSg4dC9sYsQ4A+7bZpS/KKO53pWFS9cBpNNibS741hfPi/yRNvb6xtcNpVnZa
         ghlg==
X-Gm-Message-State: AJIora963XyMvDqOmULAHF1eBDzJeIBBUDIKPAbmBESfUcPiLjCIxwpj
        v6gaJ22H0Q6HmhWI/4GmpHk=
X-Google-Smtp-Source: AGRyM1voHJkzFyYajsOuikNeOsCZERztTnrtJAFi5sQVnWu2o8J/amkEKkzuO6mDeF3aNMhZJdr3pg==
X-Received: by 2002:a5d:452d:0:b0:21b:81f6:d91 with SMTP id j13-20020a5d452d000000b0021b81f60d91mr9855146wra.521.1656018819218;
        Thu, 23 Jun 2022 14:13:39 -0700 (PDT)
Received: from localhost (92.40.171.44.threembb.co.uk. [92.40.171.44])
        by smtp.gmail.com with ESMTPSA id j14-20020adfa54e000000b0021b93b29cacsm468757wrb.99.2022.06.23.14.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:13:38 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/12] regmap-irq: Introduce config registers for irq types
Date:   Thu, 23 Jun 2022 22:14:16 +0100
Message-Id: <20220623211420.918875-9-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
References: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
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
 drivers/base/regmap/regmap-irq.c | 115 +++++++++++++++++++++++++++++--
 include/linux/regmap.h           |  12 ++++
 2 files changed, 122 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 5f9a5856c45e..e3dbf55a561f 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -39,6 +39,7 @@ struct regmap_irq_chip_data {
 	unsigned int *type_buf;
 	unsigned int *type_buf_def;
 	unsigned int **virt_buf;
+	unsigned int **config_buf;
 
 	unsigned int irq_reg_stride;
 
@@ -228,6 +229,17 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 		}
 	}
 
+	for (i = 0; i < d->chip->num_config_bases; i++) {
+		for (j = 0; j < d->chip->num_config_regs; j++) {
+			reg = sub_irq_reg(d, d->chip->config_base[i], j);
+			ret = regmap_write(map, reg, d->config_buf[i][j]);
+			if (ret)
+				dev_err(d->map->dev,
+					"Failed to write config %x: %d\n",
+					reg, ret);
+		}
+	}
+
 	if (d->chip->runtime_pm)
 		pm_runtime_put(map->dev);
 
@@ -287,7 +299,7 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 	struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
 	struct regmap *map = d->map;
 	const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
-	int reg;
+	int reg, ret;
 	const struct regmap_irq_type *t = &irq_data->type;
 
 	if ((t->types_supported & type) != type)
@@ -327,9 +339,19 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 		return -EINVAL;
 	}
 
-	if (d->chip->set_type_virt)
-		return d->chip->set_type_virt(d->virt_buf, type, data->hwirq,
-					      reg);
+	if (d->chip->set_type_virt) {
+		ret = d->chip->set_type_virt(d->virt_buf, type, data->hwirq,
+					     reg);
+		if (ret)
+			return ret;
+	}
+
+	if (d->chip->set_type_config) {
+		ret = d->chip->set_type_config(d->config_buf, type,
+					       irq_data, reg);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -599,6 +621,61 @@ static const struct irq_domain_ops regmap_domain_ops = {
 	.xlate	= irq_domain_xlate_onetwocell,
 };
 
+/**
+ * regmap_irq_set_type_config_simple() - Simple IRQ type configuration callback.
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
@@ -724,6 +801,24 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
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
+						   sizeof(**d->config_buf),
+						   GFP_KERNEL);
+			if (!d->config_buf[i])
+				goto err_alloc;
+		}
+	}
+
 	d->irq_chip = regmap_irq_chip;
 	d->irq_chip.name = chip->name;
 	d->irq = irq;
@@ -894,6 +989,11 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
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
@@ -934,7 +1034,7 @@ EXPORT_SYMBOL_GPL(regmap_add_irq_chip);
 void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *d)
 {
 	unsigned int virq;
-	int hwirq;
+	int i, hwirq;
 
 	if (!d)
 		return;
@@ -964,6 +1064,11 @@ void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *d)
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
index d21eb8ad2675..432449f318cb 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1459,6 +1459,7 @@ struct regmap_irq_sub_irq_map {
  * @wake_base:   Base address for wake enables.  If zero unsupported.
  * @type_base:   Base address for irq type.  If zero unsupported.
  * @virt_reg_base:   Base addresses for extra config regs.
+ * @config_base: Base address for IRQ type config regs. If null unsupported.
  * @irq_reg_stride:  Stride to use for chips where registers are not contiguous.
  * @init_ack_masked: Ack all masked interrupts once during initalization.
  * @mask_invert: Inverted mask register: cleared bits are masked out.
@@ -1488,12 +1489,15 @@ struct regmap_irq_sub_irq_map {
  * @num_type_reg:    Number of type registers.
  * @num_virt_regs:   Number of non-standard irq configuration registers.
  *		     If zero unsupported.
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
@@ -1516,6 +1520,7 @@ struct regmap_irq_chip {
 	unsigned int wake_base;
 	unsigned int type_base;
 	unsigned int *virt_reg_base;
+	const unsigned int *config_base;
 	unsigned int irq_reg_stride;
 	unsigned int init_ack_masked:1;
 	unsigned int mask_invert:1;
@@ -1537,16 +1542,23 @@ struct regmap_irq_chip {
 
 	int num_type_reg;
 	int num_virt_regs;
+	int num_config_bases;
+	int num_config_regs;
 
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

