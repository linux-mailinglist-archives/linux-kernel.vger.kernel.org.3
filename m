Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDB353CB12
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244942AbiFCN5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244889AbiFCN4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:56:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1DE381BB;
        Fri,  3 Jun 2022 06:56:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso4378143wmn.4;
        Fri, 03 Jun 2022 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cx/gp/Zf/QVveVxqbkMsGI/KUlqkSV+vcSUZPyo3kCI=;
        b=qXerizvOA8TIf75essVIOe5kIDsQgJljHoxAdQ6GXgfCz02Nlq590sXYdsIuX3aj48
         XEmkYXi33q3Q12V/x1MXN1v2I1om6nkk9ADN880tSaa+USVy4opnTfXO/lmRi06xgNFf
         W7y7mq+8gsRdLdoVn683ldRY2m+dPPM5/6mpOFQ3dsWaEl9LwtPx9TI3sBJiFcRw5/qU
         /C7clgzt64udQ9zsdX7RN1dWCkIPx6yFYTY8p6Plv61LXcgfJ2uW6pq3AG7xbsH7Td+V
         HDqlunMTxMkm1/rM2M2QOriZiFvOp3jW2S7UgN3o3+VsyZlNE4arvt8ORVVdgNdUEYf4
         q4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cx/gp/Zf/QVveVxqbkMsGI/KUlqkSV+vcSUZPyo3kCI=;
        b=3fyUStSRFWy91LReTBUx+lDKQGG94hpUSUZJg6oREcAEn+N9IpAIBVdmm+RuMoNlAO
         46zY5GK9m73NIV0O4JyrCtrWH+wPJYMHRsuaxAv9QbZdsipRiSFOQ4knGYyPzi8N/5FI
         gwmzWZXOtFGom0Gd/z+nm8p/C1JfCp5rfwKjDuUl8q+JWEMt3bhC8PQRsXoBSWdrzHyY
         4AWMEuei30i67+VEtrYzt09thE9WHzFgSJxz9wu79xqzxEEl9DdyGo/RBjRAyMTYpfB0
         5FGg25zgEwsASx6V39vyNjWhM7xQ51B8TUz7BzEDw8gpMVsqaIEE4c3ANMkuVkwJ9mbb
         v9mA==
X-Gm-Message-State: AOAM533K832LwGzdEZtIMxPBJ/gS7hJF4hOWIEgtGTV5gZ0XmBM2uqSC
        BrZgGbadShYKxNdJQmcCQTg=
X-Google-Smtp-Source: ABdhPJwEGnIUPcLW1uipz+weCaHwWbqgYbvBQB1MMtjgwcETbCj7tNXCCG1TdwRsKBlMGw8R5PfJ+g==
X-Received: by 2002:a05:600c:1d20:b0:397:5a8b:a30a with SMTP id l32-20020a05600c1d2000b003975a8ba30amr8922975wms.89.1654264598832;
        Fri, 03 Jun 2022 06:56:38 -0700 (PDT)
Received: from localhost (92.40.203.126.threembb.co.uk. [92.40.203.126])
        by smtp.gmail.com with ESMTPSA id h11-20020a5d688b000000b0020e63ab5d78sm7334245wru.26.2022.06.03.06.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:56:38 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] regmap-irq: Add get_irq_reg to support unusual register layouts
Date:   Fri,  3 Jun 2022 14:57:05 +0100
Message-Id: <20220603135714.12007-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
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

Add a new callback, get_irq_reg, for regmap IRQ chips, to support devices
with unusual register layouts. This is required in the rare cases where
the offset of an IRQ register is not constant with respect to the base
register. This is probably best illustrated with an example:

            mask    status
    IRQ0    0x40    0x44
    IRQ1    0x41    0x45
    IRQ2    0x42    0x46
    IRQ3    0x43    0x47
    IRQ4    0x4a    0x4d

If we set mask_base = 0x40 and status_base = 0x44, the offsets of each
register relative to the base are:

            mask    status
    IRQ0    0       0
    IRQ1    1       1
    IRQ2    2       2
    IRQ3    3       3
    IRQ4    10      9

The existing mapping mechanisms can't include IRQ4 in the same irqchip
as IRQ0-3 because the offset of IRQ4's register depends on which type
of register we're asking for, ie. which base register is used.

The get_irq_reg callback allows drivers to specify an arbitrary mapping
of (base register, register index) pairs to register addresses, instead
of the default linear mapping "base_register + register_index". This
allows unusual layouts, like the one above, to be handled using a single
regmap IRQ chip.

The drawback is that when get_irq_reg is used, it's impossible to use
bulk reads for status registers even if some of them are contiguous,
because the mapping is opaque to regmap-irq. This should be acceptable
for the case of a few infrequently-polled status registers.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 19 +++++++++----------
 include/linux/regmap.h           |  5 +++++
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 400c7412a7dc..e50437b18284 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -55,7 +55,9 @@ static int sub_irq_reg(struct regmap_irq_chip_data *data,
 	unsigned int offset;
 	int reg = 0;
 
-	if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {
+	if (chip->get_irq_reg) {
+		reg = chip->get_irq_reg(base_reg, i);
+	} else if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {
 		/* Assume linear mapping */
 		reg = base_reg + (i * map->reg_stride * data->irq_reg_stride);
 	} else {
@@ -97,7 +99,6 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 	struct regmap *map = d->map;
 	int i, j, ret;
 	u32 reg;
-	u32 unmask_offset;
 	u32 val;
 
 	if (d->chip->runtime_pm) {
@@ -141,11 +142,11 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 				dev_err(d->map->dev,
 					"Failed to sync unmasks in %x\n",
 					reg);
-			unmask_offset = d->chip->unmask_base -
-							d->chip->mask_base;
+
 			/* clear mask with unmask_base register */
+			reg = sub_irq_reg(d, d->chip->unmask_base, i);
 			ret = regmap_irq_update_bits(d,
-					reg + unmask_offset,
+					reg,
 					d->mask_buf_def[i],
 					d->mask_buf[i]);
 		} else {
@@ -480,7 +481,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 
 		}
 	} else if (!map->use_single_read && map->reg_stride == 1 &&
-		   data->irq_reg_stride == 1) {
+		   data->irq_reg_stride == 1 && !chip->get_irq_reg) {
 
 		u8 *buf8 = data->status_reg_buf;
 		u16 *buf16 = data->status_reg_buf;
@@ -632,7 +633,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	int ret = -ENOMEM;
 	int num_type_reg;
 	u32 reg;
-	u32 unmask_offset;
 
 	if (chip->num_regs <= 0)
 		return -EINVAL;
@@ -773,10 +773,9 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			ret = regmap_irq_update_bits(d, reg,
 					 d->mask_buf[i], ~d->mask_buf[i]);
 		else if (d->chip->unmask_base) {
-			unmask_offset = d->chip->unmask_base -
-					d->chip->mask_base;
+			reg = sub_irq_reg(d, d->chip->unmask_base, i);
 			ret = regmap_irq_update_bits(d,
-					reg + unmask_offset,
+					reg,
 					d->mask_buf[i],
 					d->mask_buf[i]);
 		} else
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 8952fa3d0d59..4828021ab9e8 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1495,6 +1495,10 @@ struct regmap_irq_sub_irq_map {
  *		     after handling the interrupts in regmap_irq_handler().
  * @set_type_virt:   Driver specific callback to extend regmap_irq_set_type()
  *		     and configure virt regs.
+ * @get_irq_reg:     Callback to map a register index in range [0, num_regs[
+ *		     to a register, relative to a specific base register. This
+ *		     is mainly useful for devices where the register offsets
+ *		     change depending on the base register.
  * @irq_drv_data:    Driver specific IRQ data which is passed as parameter when
  *		     driver specific pre/post interrupt handler is called.
  *
@@ -1545,6 +1549,7 @@ struct regmap_irq_chip {
 	int (*handle_post_irq)(void *irq_drv_data);
 	int (*set_type_virt)(unsigned int **buf, unsigned int type,
 			     unsigned long hwirq, int reg);
+	int (*get_irq_reg)(unsigned int base_reg, int i);
 	void *irq_drv_data;
 };
 
-- 
2.35.1

