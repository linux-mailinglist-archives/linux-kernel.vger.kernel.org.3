Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C999555259A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344355AbiFTULh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344186AbiFTUI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:08:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F6C21E0B;
        Mon, 20 Jun 2022 13:07:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o8so16103423wro.3;
        Mon, 20 Jun 2022 13:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XaILMaaUfjKKrrd1BT5yUC0wzaqueGQvAdQj7TQ0vLM=;
        b=imip7dzGE8pif//iZiBwRPgT0Zy30AicR52p+YSjODyhTVrRZ2lor3isprtfe5BvRf
         6g0qehbR9h2oP87ubh9puaYqDZ7h0g3Qr9cE+rFnZyOveR2FPmH15B6/0Pb9aqj9zL2t
         1WdH5LJC+mlljGPaehp7prMgTu/wr2dyHT4f+0DWYEPU53OC4k7EcUfjdBa8Y0jLKd7f
         jOCRN3c+t45IpipXCIFg8ljs4JDcpiwga1eEgM8TL6lytc62RYsXd2Xi9hxEDHg2Johr
         jswOtD5N2Zu8rtBWb5ETbrZRPG5UV6rhvYOpjg7uu/p7IFU2L64Kf3biwJJ9dht9BHHs
         DmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XaILMaaUfjKKrrd1BT5yUC0wzaqueGQvAdQj7TQ0vLM=;
        b=1jY2Zm7jWJnct7XK5OoDqT3+6bP2e24S3lCIkBaHJOEkPucZIDqtoMez9KkvMoITVA
         JkK6S4UmDCj3JwkvhEtP1qJE4y8ZpVGjuvrFmtDoJoTmBCqUOFGngFMLNKMEO8jkHEW1
         yfzvoDVtM52VkcaSxKplPPZfay0+quVt/JrH8gI0VA50RLGPhPPrkOtQC0Ic9T7VgBCg
         DV9SR289GY+qR63qjvhNSH+FCl/Gw6bqUVq/eg3kVe6SuthhtpS5EMhOEBji8ccUBedZ
         fkvocDDYiZjPbKWpgZUHuXsB0CwEolHJl9IxVMBGLq2h3r7F3qO0aWe8WWg9bj5/bjha
         SqeQ==
X-Gm-Message-State: AJIora8grWWqN41HQmDJ/iJrBKj2twX6iLowN8vHp+3T3mttC2ccU0XO
        UR17BoXA04bln6+PyCJ+PE0=
X-Google-Smtp-Source: AGRyM1t9IFcsSmUxm6NbAdug13RNQx5axNz4NGatMxkirYwyQ+EAH80iv3Me1JZp6GMwiYGFFjPvjg==
X-Received: by 2002:a5d:4cc4:0:b0:21b:8a19:b8a6 with SMTP id c4-20020a5d4cc4000000b0021b8a19b8a6mr10152154wrt.590.1655755651340;
        Mon, 20 Jun 2022 13:07:31 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d5941000000b0020c5253d907sm14219807wri.83.2022.06.20.13.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:07:30 -0700 (PDT)
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
Subject: [PATCH 47/49] regmap-irq: Add get_irq_reg() callback
Date:   Mon, 20 Jun 2022 21:06:42 +0100
Message-Id: <20220620200644.1961936-48-aidanmacdonald.0x0@gmail.com>
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

Replace the internal sub_irq_reg() function with a public callback
that drivers can use when they have more complex register layouts.
The default implementation is regmap_irq_get_irq_reg_linear(), used
if the chip doesn't provide its own callback.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 122 ++++++++++++++++++++-----------
 include/linux/regmap.h           |  15 +++-
 2 files changed, 92 insertions(+), 45 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 7b5bd1d45fc0..acbd6e22b0cd 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -41,30 +41,12 @@ struct regmap_irq_chip_data {
 
 	unsigned int irq_reg_stride;
 
+	unsigned int (*get_irq_reg)(struct regmap_irq_chip_data *data,
+				    unsigned int base, int index);
+
 	bool clear_status:1;
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
@@ -76,8 +58,14 @@ static bool regmap_irq_can_bulk_read_status(struct regmap_irq_chip_data *data)
 {
 	struct regmap *map = data->map;
 
+	/*
+	 * While possible that a user-defined get_irq_reg callback might be
+	 * linear enough to support bulk reads, most of the time it won't.
+	 * Therefore only allow them if the default callback is being used.
+	 */
 	return !map->use_single_read && map->reg_stride == 1 &&
-		data->irq_reg_stride == 1;
+		data->irq_reg_stride == 1 &&
+		data->get_irq_reg == regmap_irq_get_irq_reg_linear;
 }
 
 static void regmap_irq_lock(struct irq_data *data)
@@ -114,7 +102,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 
 	if (d->clear_status) {
 		for (i = 0; i < d->chip->num_regs; i++) {
-			reg = sub_irq_reg(d, d->chip->status_base, i);
+			reg = d->get_irq_reg(d, d->chip->status_base, i);
 
 			ret = regmap_read(map, reg, &val);
 			if (ret)
@@ -132,7 +120,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 	 */
 	for (i = 0; i < d->chip->num_regs; i++) {
 		if (d->chip->mask_base) {
-			reg = sub_irq_reg(d, d->chip->mask_base, i);
+			reg = d->get_irq_reg(d, d->chip->mask_base, i);
 			ret = regmap_irq_update_mask_bits(d, reg,
 					d->mask_buf_def[i], d->mask_buf[i]);
 			if (ret != 0)
@@ -141,7 +129,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 		}
 
 		if (d->chip->unmask_base) {
-			reg = sub_irq_reg(d, d->chip->unmask_base, i);
+			reg = d->get_irq_reg(d, d->chip->unmask_base, i);
 			ret = regmap_irq_update_mask_bits(d, reg,
 					d->mask_buf_def[i], ~d->mask_buf[i]);
 			if (ret != 0)
@@ -149,7 +137,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 					reg);
 		}
 
-		reg = sub_irq_reg(d, d->chip->wake_base, i);
+		reg = d->get_irq_reg(d, d->chip->wake_base, i);
 		if (d->wake_buf) {
 			if (d->chip->wake_invert)
 				ret = regmap_update_bits(d->map, reg,
@@ -173,7 +161,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 		 * it'll be ignored in irq handler, then may introduce irq storm
 		 */
 		if (d->mask_buf[i] && (d->chip->ack_base || d->chip->use_ack)) {
-			reg = sub_irq_reg(d, d->chip->ack_base, i);
+			reg = d->get_irq_reg(d, d->chip->ack_base, i);
 
 			/* some chips ack by write 0 */
 			if (d->chip->ack_invert)
@@ -194,7 +182,7 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 
 	for (i = 0; i < d->chip->num_config_bases; i++) {
 		for (j = 0; j < d->chip->num_config_regs; j++) {
-			reg = sub_irq_reg(d, d->chip->config_base[i], j);
+			reg = d->get_irq_reg(d, d->chip->config_base[i], j);
 			ret = regmap_write(map, reg, d->config_buf[i][j]);
 			if (ret != 0)
 				dev_err(d->map->dev,
@@ -316,14 +304,17 @@ static inline int read_sub_irq_data(struct regmap_irq_chip_data *data,
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
+		 * Note we can't use get_irq_reg() here because the offsets
+		 * in 'subreg' are *not* interchangeable with indices.
+		 */
 		subreg = &chip->sub_reg_offsets[b];
 		for (i = 0; i < subreg->num_regs; i++) {
 			unsigned int offset = subreg->offset[i];
@@ -389,10 +380,19 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		 * sake of simplicity. and add bulk reads only if needed
 		 */
 		for (i = 0; i < chip->num_main_regs; i++) {
-			ret = regmap_read(map, chip->main_status +
-				  (i * map->reg_stride
-				   * data->irq_reg_stride),
-				  &data->main_status_buf[i]);
+			/*
+			 * For not_fixed_stride, don't use get_irq_reg().
+			 * It would produce an incorrect result.
+			 */
+			if (data->chip->not_fixed_stride)
+				reg = chip->main_status +
+					(i * map->reg_stride *
+					 data->irq_reg_stride);
+			else
+				reg = data->get_irq_reg(data,
+							chip->main_status, i);
+
+			ret = regmap_read(map, reg, &data->main_status_buf[i]);
 			if (ret) {
 				dev_err(map->dev,
 					"Failed to read IRQ status %d\n",
@@ -457,7 +457,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 
 	} else {
 		for (i = 0; i < data->chip->num_regs; i++) {
-			unsigned int reg = sub_irq_reg(data,
+			unsigned int reg = data->get_irq_reg(data,
 					data->chip->status_base, i);
 			ret = regmap_read(map, reg, &data->status_buf[i]);
 
@@ -485,7 +485,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		data->status_buf[i] &= ~data->mask_buf[i];
 
 		if (data->status_buf[i] && (chip->ack_base || chip->use_ack)) {
-			reg = sub_irq_reg(data, data->chip->ack_base, i);
+			reg = data->get_irq_reg(data, data->chip->ack_base, i);
 
 			if (chip->ack_invert)
 				ret = regmap_write(map, reg,
@@ -545,6 +545,37 @@ static const struct irq_domain_ops regmap_domain_ops = {
 	.xlate	= irq_domain_xlate_onetwocell,
 };
 
+/**
+ * regmap_irq_get_irq_reg_linear() - Linear IRQ register mapping callback.
+ *
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
+	 * NOTE: This is for backward compatibility only and will be removed
+	 * when not_fixed_stride is dropped (it's only used by qcom-pm8008).
+	 */
+	if (chip->not_fixed_stride && chip->sub_reg_offsets) {
+		struct regmap_irq_sub_irq_map *subreg;
+
+		subreg = &chip->sub_reg_offsets[0];
+		return base + subreg->offset[0];
+	}
+
+	return base + index * (map->reg_stride * chip->irq_reg_stride);
+}
+EXPORT_SYMBOL_GPL(regmap_irq_get_irq_reg_linear);
+
 /**
  * regmap_irq_set_type_config_simple() - Simple IRQ type configuration callback.
  *
@@ -730,6 +761,11 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
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
@@ -749,7 +785,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		d->mask_buf[i] = d->mask_buf_def[i];
 
 		if (d->chip->mask_base) {
-			reg = sub_irq_reg(d, d->chip->mask_base, i);
+			reg = d->get_irq_reg(d, d->chip->mask_base, i);
 			ret = regmap_irq_update_mask_bits(d, reg,
 					d->mask_buf_def[i], d->mask_buf[i]);
 			if (ret != 0) {
@@ -760,7 +796,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		}
 
 		if (d->chip->unmask_base) {
-			reg = sub_irq_reg(d, d->chip->unmask_base, i);
+			reg = d->get_irq_reg(d, d->chip->unmask_base, i);
 			ret = regmap_irq_update_mask_bits(d, reg,
 					d->mask_buf_def[i], ~d->mask_buf[i]);
 			if (ret != 0) {
@@ -774,7 +810,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			continue;
 
 		/* Ack masked but set interrupts */
-		reg = sub_irq_reg(d, d->chip->status_base, i);
+		reg = d->get_irq_reg(d, d->chip->status_base, i);
 		ret = regmap_read(map, reg, &d->status_buf[i]);
 		if (ret != 0) {
 			dev_err(map->dev, "Failed to read IRQ status: %d\n",
@@ -786,7 +822,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			d->status_buf[i] = ~d->status_buf[i];
 
 		if (d->status_buf[i] && (chip->ack_base || chip->use_ack)) {
-			reg = sub_irq_reg(d, d->chip->ack_base, i);
+			reg = d->get_irq_reg(d, d->chip->ack_base, i);
 			if (chip->ack_invert)
 				ret = regmap_write(map, reg,
 					~(d->status_buf[i] & d->mask_buf[i]));
@@ -811,7 +847,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	if (d->wake_buf) {
 		for (i = 0; i < chip->num_regs; i++) {
 			d->wake_buf[i] = d->mask_buf_def[i];
-			reg = sub_irq_reg(d, d->chip->wake_base, i);
+			reg = d->get_irq_reg(d, d->chip->wake_base, i);
 
 			if (chip->wake_invert)
 				ret = regmap_update_bits(d->map, reg,
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index bb625a1edef9..be51af0a2425 100644
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
@@ -1489,6 +1491,13 @@ struct regmap_irq_sub_irq_map {
  * @handle_post_irq: Driver specific callback to handle interrupt from device
  *		     after handling the interrupts in regmap_irq_handler().
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
@@ -1535,11 +1544,13 @@ struct regmap_irq_chip {
 	int (*handle_post_irq)(void *irq_drv_data);
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

