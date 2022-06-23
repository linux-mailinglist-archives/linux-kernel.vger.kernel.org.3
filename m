Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386CA558A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiFWVOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiFWVNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:13:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32995158B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e7so469582wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4wAUZpTIJxBkOyoOQbWOwMBIqWSc9cnroPNft8+Q9Og=;
        b=BtYrJrxQexQXMvNKWGoF2/jsVA2PbyjZYzxFsMhIS7XWRyrwWJujZeBZl37Zwrl1Tz
         c7WDgmQfJnT4RoL+gGsMFxYHeAWBmaeW+44rC6KzKNyDWE4dl+umzbgSDPKlnaYkaCqP
         Ziiklr+0xKKaxSKLGpUhh53xwZuh+hjTJoMZ/w1WMiDpPLCF788jRfn8Vlm/irIlzKPl
         J7QH7OrmyV7eV+cFyJCQuwOYMKNMAF2KU2IOYTk8REyKWyPtrMAR4X/vLcrbHPaNLUde
         Axzmc/FJHeAe1RQA0cY5zbBsfWq8Ejk9xrmz2beB/mhXaGi8besEK9L9sbtF3LzO1iqO
         HfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4wAUZpTIJxBkOyoOQbWOwMBIqWSc9cnroPNft8+Q9Og=;
        b=6+F8woJumqiEalExb7pLqrj/jhwl+Lkq9LL5HswE4Un25M4d5+dPm53SP+EjgE8pTP
         qwY/knHSR8MC+9fN9OHjwPLNPOeB6pP333055Ih+zZpjC6nrpX946AcFsFXASobwBnob
         k+yZLuoT0MxVt9MN4F0UodvtG/eYhJRqnjwE9hU1djIqgcG8xkgb88m+IdG360VCwmlE
         uSZHWuOkufF0cfvzIhHxVl6NWjHrVanmGd/1ddrtZjJ6IWr5a5I0kFCgOLVN59v2zMyI
         eZdRSaI3xpIiTiYnLy8IeHG0LntsC9wxhAUt7+95RCjqDa8nbFyCsX9HQfRa9KFkIuCH
         OwIQ==
X-Gm-Message-State: AJIora/4d5BNf9nGcxpaKFXi1S5qwLXqvrO8Dbdx2BPMcmycCKgxA7Xc
        aOPEl32l823K6RmS1bxJQS4=
X-Google-Smtp-Source: AGRyM1tSv1SfX0OYx4eRsSrMWm54i/BOa8nYAGjf4DpF9tgHOiK0heTqQKWhi1W88OreIdL3NoNfgg==
X-Received: by 2002:adf:fb49:0:b0:21a:3ccc:fb77 with SMTP id c9-20020adffb49000000b0021a3cccfb77mr10085804wrs.280.1656018824112;
        Thu, 23 Jun 2022 14:13:44 -0700 (PDT)
Received: from localhost (92.40.171.44.threembb.co.uk. [92.40.171.44])
        by smtp.gmail.com with ESMTPSA id j14-20020adfa54e000000b0021b93b29cacsm468918wrb.99.2022.06.23.14.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:13:43 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/12] regmap-irq: Add get_irq_reg() callback
Date:   Thu, 23 Jun 2022 22:14:19 +0100
Message-Id: <20220623211420.918875-12-aidanmacdonald.0x0@gmail.com>
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

Replace the internal sub_irq_reg() function with a public callback
that drivers can use when they have more complex register layouts.
The default implementation is regmap_irq_get_irq_reg_linear(), used
if the chip doesn't provide its own callback.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 126 ++++++++++++++++++++-----------
 include/linux/regmap.h           |  15 +++-
 2 files changed, 93 insertions(+), 48 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 2c724ae185c4..71de097847a7 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -46,30 +46,12 @@ struct regmap_irq_chip_data {
 
 	unsigned int irq_reg_stride;
 
+	unsigned int (*get_irq_reg)(struct regmap_irq_chip_data *data,
+				    unsigned int base, int index);
+
 	unsigned int clear_status:1;
 };
 
-static int sub_irq_reg(struct regmap_irq_chip_data *data,
-		       unsigned int base_reg, int i)
-{
-	const struct regmap_irq_chip *chip = data->chip;
-	struct regmap *map = data->map;
-	struct regmap_irq_sub_irq_map *subreg;
-	unsigned int offset;
-	int reg = 0;
-
-	if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {
-		/* Assume linear mapping */
-		reg = base_reg + (i * map->reg_stride * data->irq_reg_stride);
-	} else {
-		subreg = &chip->sub_reg_offsets[i];
-		offset = subreg->offset[0];
-		reg = base_reg + offset;
-	}
-
-	return reg;
-}
-
 static inline const
 struct regmap_irq *irq_to_regmap_irq(struct regmap_irq_chip_data *data,
 				     int irq)
@@ -81,7 +63,13 @@ static bool regmap_irq_can_bulk_read_status(struct regmap_irq_chip_data *data)
 {
 	struct regmap *map = data->map;
 
+	/*
+	 * While possible that a user-defined ->get_irq_reg() callback might
+	 * be linear enough to support bulk reads, most of the time it won't.
+	 * Therefore only allow them if the default callback is being used.
+	 */
 	return data->irq_reg_stride == 1 && map->reg_stride == 1 &&
+	       data->get_irq_reg == regmap_irq_get_irq_reg_linear &&
 	       !map->use_single_read;
 }
 
@@ -109,7 +97,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 
 	if (d->clear_status) {
 		for (i = 0; i < d->chip->num_regs; i++) {
-			reg = sub_irq_reg(d, d->chip->status_base, i);
+			reg = d->get_irq_reg(d, d->chip->status_base, i);
 
 			ret = regmap_read(map, reg, &val);
 			if (ret)
@@ -127,7 +115,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 	 */
 	for (i = 0; i < d->chip->num_regs; i++) {
 		if (d->mask_base) {
-			reg = sub_irq_reg(d, d->mask_base, i);
+			reg = d->get_irq_reg(d, d->mask_base, i);
 			ret = regmap_update_bits(d->map, reg,
 					d->mask_buf_def[i], d->mask_buf[i]);
 			if (ret)
@@ -136,7 +124,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 		}
 
 		if (d->unmask_base) {
-			reg = sub_irq_reg(d, d->unmask_base, i);
+			reg = d->get_irq_reg(d, d->unmask_base, i);
 			ret = regmap_update_bits(d->map, reg,
 					d->mask_buf_def[i], ~d->mask_buf[i]);
 			if (ret)
@@ -144,7 +132,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 					reg);
 		}
 
-		reg = sub_irq_reg(d, d->chip->wake_base, i);
+		reg = d->get_irq_reg(d, d->chip->wake_base, i);
 		if (d->wake_buf) {
 			if (d->chip->wake_invert)
 				ret = regmap_update_bits(d->map, reg,
@@ -168,7 +156,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 		 * it'll be ignored in irq handler, then may introduce irq storm
 		 */
 		if (d->mask_buf[i] && (d->chip->ack_base || d->chip->use_ack)) {
-			reg = sub_irq_reg(d, d->chip->ack_base, i);
+			reg = d->get_irq_reg(d, d->chip->ack_base, i);
 
 			/* some chips ack by write 0 */
 			if (d->chip->ack_invert)
@@ -192,7 +180,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 		for (i = 0; i < d->chip->num_type_reg; i++) {
 			if (!d->type_buf_def[i])
 				continue;
-			reg = sub_irq_reg(d, d->chip->type_base, i);
+			reg = d->get_irq_reg(d, d->chip->type_base, i);
 			if (d->chip->type_invert)
 				ret = regmap_update_bits(d->map, reg,
 					d->type_buf_def[i], ~d->type_buf[i]);
@@ -208,8 +196,8 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 	if (d->chip->num_virt_regs) {
 		for (i = 0; i < d->chip->num_virt_regs; i++) {
 			for (j = 0; j < d->chip->num_regs; j++) {
-				reg = sub_irq_reg(d, d->chip->virt_reg_base[i],
-						  j);
+				reg = d->get_irq_reg(d, d->chip->virt_reg_base[i],
+						     j);
 				ret = regmap_write(map, reg, d->virt_buf[i][j]);
 				if (ret != 0)
 					dev_err(d->map->dev,
@@ -221,7 +209,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 
 	for (i = 0; i < d->chip->num_config_bases; i++) {
 		for (j = 0; j < d->chip->num_config_regs; j++) {
-			reg = sub_irq_reg(d, d->chip->config_base[i], j);
+			reg = d->get_irq_reg(d, d->chip->config_base[i], j);
 			ret = regmap_write(map, reg, d->config_buf[i][j]);
 			if (ret)
 				dev_err(d->map->dev,
@@ -382,14 +370,17 @@ static inline int read_sub_irq_data(struct regmap_irq_chip_data *data,
 	const struct regmap_irq_chip *chip = data->chip;
 	struct regmap *map = data->map;
 	struct regmap_irq_sub_irq_map *subreg;
+	unsigned int reg;
 	int i, ret = 0;
 
 	if (!chip->sub_reg_offsets) {
-		/* Assume linear mapping */
-		ret = regmap_read(map, chip->status_base +
-				  (b * map->reg_stride * data->irq_reg_stride),
-				   &data->status_buf[b]);
+		reg = data->get_irq_reg(data, chip->status_base, b);
+		ret = regmap_read(map, reg, &data->status_buf[b]);
 	} else {
+		/*
+		 * Note we can't use ->get_irq_reg() here because the offsets
+		 * in 'subreg' are *not* interchangeable with indices.
+		 */
 		subreg = &chip->sub_reg_offsets[b];
 		for (i = 0; i < subreg->num_regs; i++) {
 			unsigned int offset = subreg->offset[i];
@@ -455,10 +446,18 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		 * sake of simplicity. and add bulk reads only if needed
 		 */
 		for (i = 0; i < chip->num_main_regs; i++) {
-			ret = regmap_read(map, chip->main_status +
-				  (i * map->reg_stride
-				   * data->irq_reg_stride),
-				  &data->main_status_buf[i]);
+			/*
+			 * For not_fixed_stride, don't use ->get_irq_reg().
+			 * It would produce an incorrect result.
+			 */
+			if (data->chip->not_fixed_stride)
+				reg = chip->main_status +
+					i * map->reg_stride * data->irq_reg_stride;
+			else
+				reg = data->get_irq_reg(data,
+							chip->main_status, i);
+
+			ret = regmap_read(map, reg, &data->main_status_buf[i]);
 			if (ret) {
 				dev_err(map->dev,
 					"Failed to read IRQ status %d\n",
@@ -523,7 +522,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 
 	} else {
 		for (i = 0; i < data->chip->num_regs; i++) {
-			unsigned int reg = sub_irq_reg(data,
+			unsigned int reg = data->get_irq_reg(data,
 					data->chip->status_base, i);
 			ret = regmap_read(map, reg, &data->status_buf[i]);
 
@@ -551,7 +550,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		data->status_buf[i] &= ~data->mask_buf[i];
 
 		if (data->status_buf[i] && (chip->ack_base || chip->use_ack)) {
-			reg = sub_irq_reg(data, data->chip->ack_base, i);
+			reg = data->get_irq_reg(data, data->chip->ack_base, i);
 
 			if (chip->ack_invert)
 				ret = regmap_write(map, reg,
@@ -611,6 +610,36 @@ static const struct irq_domain_ops regmap_domain_ops = {
 	.xlate	= irq_domain_xlate_onetwocell,
 };
 
+/**
+ * regmap_irq_get_irq_reg_linear() - Linear IRQ register mapping callback.
+ * @data: Data for the &struct regmap_irq_chip
+ * @base: Base register
+ * @index: Register index
+ *
+ * Returns the register address corresponding to the given @base and @index
+ * by the formula ``base + index * regmap_stride * irq_reg_stride``.
+ */
+unsigned int regmap_irq_get_irq_reg_linear(struct regmap_irq_chip_data *data,
+					   unsigned int base, int index)
+{
+	const struct regmap_irq_chip *chip = data->chip;
+	struct regmap *map = data->map;
+
+	/*
+	 * FIXME: This is for backward compatibility and should be removed
+	 * when not_fixed_stride is dropped (it's only used by qcom-pm8008).
+	 */
+	if (chip->not_fixed_stride && chip->sub_reg_offsets) {
+		struct regmap_irq_sub_irq_map *subreg;
+
+		subreg = &chip->sub_reg_offsets[0];
+		return base + subreg->offset[0];
+	}
+
+	return base + index * map->reg_stride * chip->irq_reg_stride;
+}
+EXPORT_SYMBOL_GPL(regmap_irq_get_irq_reg_linear);
+
 /**
  * regmap_irq_set_type_config_simple() - Simple IRQ type configuration callback.
  * @buf: Buffer containing configuration register values, this is a 2D array of
@@ -862,6 +891,11 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	else
 		d->irq_reg_stride = 1;
 
+	if (chip->get_irq_reg)
+		d->get_irq_reg = chip->get_irq_reg;
+	else
+		d->get_irq_reg = regmap_irq_get_irq_reg_linear;
+
 	if (regmap_irq_can_bulk_read_status(d)) {
 		d->status_reg_buf = kmalloc_array(chip->num_regs,
 						  map->format.val_bytes,
@@ -881,7 +915,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		d->mask_buf[i] = d->mask_buf_def[i];
 
 		if (d->mask_base) {
-			reg = sub_irq_reg(d, d->mask_base, i);
+			reg = d->get_irq_reg(d, d->mask_base, i);
 			ret = regmap_update_bits(d->map, reg,
 					d->mask_buf_def[i], d->mask_buf[i]);
 			if (ret) {
@@ -892,7 +926,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		}
 
 		if (d->unmask_base) {
-			reg = sub_irq_reg(d, d->unmask_base, i);
+			reg = d->get_irq_reg(d, d->unmask_base, i);
 			ret = regmap_update_bits(d->map, reg,
 					d->mask_buf_def[i], ~d->mask_buf[i]);
 			if (ret) {
@@ -906,7 +940,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			continue;
 
 		/* Ack masked but set interrupts */
-		reg = sub_irq_reg(d, d->chip->status_base, i);
+		reg = d->get_irq_reg(d, d->chip->status_base, i);
 		ret = regmap_read(map, reg, &d->status_buf[i]);
 		if (ret != 0) {
 			dev_err(map->dev, "Failed to read IRQ status: %d\n",
@@ -918,7 +952,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			d->status_buf[i] = ~d->status_buf[i];
 
 		if (d->status_buf[i] && (chip->ack_base || chip->use_ack)) {
-			reg = sub_irq_reg(d, d->chip->ack_base, i);
+			reg = d->get_irq_reg(d, d->chip->ack_base, i);
 			if (chip->ack_invert)
 				ret = regmap_write(map, reg,
 					~(d->status_buf[i] & d->mask_buf[i]));
@@ -943,7 +977,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	if (d->wake_buf) {
 		for (i = 0; i < chip->num_regs; i++) {
 			d->wake_buf[i] = d->mask_buf_def[i];
-			reg = sub_irq_reg(d, d->chip->wake_base, i);
+			reg = d->get_irq_reg(d, d->chip->wake_base, i);
 
 			if (chip->wake_invert)
 				ret = regmap_update_bits(d->map, reg,
@@ -963,7 +997,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 
 	if (chip->num_type_reg && !chip->type_in_mask) {
 		for (i = 0; i < chip->num_type_reg; ++i) {
-			reg = sub_irq_reg(d, d->chip->type_base, i);
+			reg = d->get_irq_reg(d, d->chip->type_base, i);
 
 			ret = regmap_read(map, reg, &d->type_buf_def[i]);
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 708f36dfaeda..ae5f1f7d4b5a 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1424,6 +1424,8 @@ struct regmap_irq_sub_irq_map {
 	unsigned int *offset;
 };
 
+struct regmap_irq_chip_data;
+
 /**
  * struct regmap_irq_chip - Description of a generic regmap irq_chip.
  *
@@ -1515,6 +1517,13 @@ struct regmap_irq_sub_irq_map {
  *		     and configure virt regs. Deprecated, use @set_type_config
  *		     callback and config registers instead.
  * @set_type_config: Callback used for configuring irq types.
+ * @get_irq_reg: Callback for mapping (base register, index) pairs to register
+ *		 addresses. The base register will be one of @status_base,
+ *		 @mask_base, etc., @main_status, or any of @config_base.
+ *		 The index will be in the range [0, num_main_regs[ for the
+ *		 main status base, [0, num_type_settings[ for any config
+ *		 register base, and [0, num_regs[ for any other base.
+ *		 If unspecified then regmap_irq_get_irq_reg_linear() is used.
  * @irq_drv_data:    Driver specific IRQ data which is passed as parameter when
  *		     driver specific pre/post interrupt handler is called.
  *
@@ -1569,11 +1578,13 @@ struct regmap_irq_chip {
 			     unsigned long hwirq, int reg);
 	int (*set_type_config)(unsigned int **buf, unsigned int type,
 			       const struct regmap_irq *irq_data, int idx);
+	unsigned int (*get_irq_reg)(struct regmap_irq_chip_data *data,
+				    unsigned int base, int index);
 	void *irq_drv_data;
 };
 
-struct regmap_irq_chip_data;
-
+unsigned int regmap_irq_get_irq_reg_linear(struct regmap_irq_chip_data *data,
+					   unsigned int base, int index);
 int regmap_irq_set_type_config_simple(unsigned int **buf, unsigned int type,
 				      const struct regmap_irq *irq_data, int idx);
 
-- 
2.35.1

