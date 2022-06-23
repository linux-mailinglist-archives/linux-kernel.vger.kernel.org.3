Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC72558A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiFWVOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiFWVNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:13:47 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0491851310
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:44 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p6-20020a05600c1d8600b003a035657950so410542wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bSfmZia4N88+QuTxam9V/x71AfxUr34uHrXfe8m2m+s=;
        b=CJKxIDKcSn9k4/Oba6B7a3sSuUvr8v3/17i15mO921Fg+Ib0mQd1DnUaRARHHQlb+N
         TvKbO4kgpprV9fqFcBdriPBe65vB3PWaS5ZwxtCNbP+eoeWlKwZx5b52RifJEjEyoS/Z
         c8aKO1oqoAL6audyCk1Vqxk3iEZvclXXyZl9vWwpHRokYhh9e0ChMfYonMCpvs02H/ky
         vKOOUIqBPSRRrlBDUbe5JJC5l0kFGFg/2QTIXSzeXR0xhbASEE5xlKoY/Leo3Xor48Kr
         F3F3UneROvGrqzEbDEjcbqqzXf24Bnr3jSloC5SNm3w+zL+pERUJs9NFrVMjuSeNRr1b
         nSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bSfmZia4N88+QuTxam9V/x71AfxUr34uHrXfe8m2m+s=;
        b=Kq1uYHSuTOy+puU1hpN0WCWv/GzCFtw2ghwllkpPg4+UrkyyBc6aDdxdVVmc24m2tf
         t5Crm+aR5I6GFvabDf3uiALQgUlSV9nEm9RUVDgD51wMl3ffAZvzRRLg3ByVm3wOF5DW
         m9DPUGUoavwfiqYniYt46JXQdEEAk693c/mGA3Eko/Yt9fCvSfKZ6dncHtJsQ3z9xgwP
         58i7+xt+Zzj+PZoHQAriN/VhCVgbXScR57BX+jnMNxihUdCwKtCi9uUMotp8QE5Ixk2s
         +9OQ4X4Qjr4TUJUBk3qVGF0xfivFWV2GMws8Wf0e23w1yz2p4L5zIxWrmW71zO15fIhP
         a+MQ==
X-Gm-Message-State: AJIora9aX6vHX6A6ASkGXEJrfRnH/nmmpIeUl4RinCSl06WRgKQKv1ER
        3/NjRjH7PnXpznh0e1DCGlw=
X-Google-Smtp-Source: AGRyM1tRW4NrB3WocxJX0YlwG4yc9l7mZO1xHjrPfMacDIz6u91cTbjM3SZCBhpkc2BE2J/GVBIdlw==
X-Received: by 2002:a05:600c:4fd4:b0:3a0:334e:241e with SMTP id o20-20020a05600c4fd400b003a0334e241emr4332887wmq.73.1656018822404;
        Thu, 23 Jun 2022 14:13:42 -0700 (PDT)
Received: from localhost (92.40.171.44.threembb.co.uk. [92.40.171.44])
        by smtp.gmail.com with ESMTPSA id j3-20020adfe503000000b0021b8a0d680esm400456wrm.86.2022.06.23.14.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:13:42 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/12] regmap-irq: Fix inverted handling of unmask registers
Date:   Thu, 23 Jun 2022 22:14:18 +0100
Message-Id: <20220623211420.918875-11-aidanmacdonald.0x0@gmail.com>
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

To me "unmask" suggests that we write 1s to the register when
an interrupt is enabled. This also makes sense because it's the
opposite of what the "mask" register does (write 1s to disable
an interrupt).

But regmap-irq does the opposite: for a disabled interrupt, it
writes 1s to "unmask" and 0s to "mask". This is surprising and
deviates from the usual way mask registers are handled.

Additionally, mask_invert didn't interact with unmask registers
properly -- it caused them to be ignored entirely.

Fix this by making mask and unmask registers orthogonal, using
the following behavior:

* Mask registers are written with 1s for disabled interrupts.
* Unmask registers are written with 1s for enabled interrupts.

This behavior supports both normal or inverted mask registers
and separate set/clear registers via different combinations of
mask_base/unmask_base.

The old unmask register behavior is deprecated. Drivers need to
opt-in to the new behavior by setting mask_unmask_non_inverted.
Warnings are issued if the driver relies on deprecated behavior.
Chips that only set one of mask_base/unmask_base don't have to
use the mask_unmask_non_inverted flag because that use case was
previously not supported.

The mask_invert flag is also deprecated in favor of describing
inverted mask registers as unmask registers.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 114 +++++++++++++++++++------------
 include/linux/regmap.h           |  18 ++++-
 2 files changed, 84 insertions(+), 48 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 8cbc62c3d638..2c724ae185c4 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -30,6 +30,9 @@ struct regmap_irq_chip_data {
 	int irq;
 	int wake_count;
 
+	unsigned int mask_base;
+	unsigned int unmask_base;
+
 	void *status_reg_buf;
 	unsigned int *main_status_buf;
 	unsigned int *status_buf;
@@ -95,7 +98,6 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 	struct regmap *map = d->map;
 	int i, j, ret;
 	u32 reg;
-	u32 unmask_offset;
 	u32 val;
 
 	if (d->chip->runtime_pm) {
@@ -124,35 +126,23 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 	 * suppress pointless writes.
 	 */
 	for (i = 0; i < d->chip->num_regs; i++) {
-		if (!d->chip->mask_base)
-			continue;
-
-		reg = sub_irq_reg(d, d->chip->mask_base, i);
-		if (d->chip->mask_invert) {
+		if (d->mask_base) {
+			reg = sub_irq_reg(d, d->mask_base, i);
 			ret = regmap_update_bits(d->map, reg,
-					 d->mask_buf_def[i], ~d->mask_buf[i]);
-		} else if (d->chip->unmask_base) {
-			/* set mask with mask_base register */
+					d->mask_buf_def[i], d->mask_buf[i]);
+			if (ret)
+				dev_err(d->map->dev, "Failed to sync masks in %x\n",
+					reg);
+		}
+
+		if (d->unmask_base) {
+			reg = sub_irq_reg(d, d->unmask_base, i);
 			ret = regmap_update_bits(d->map, reg,
 					d->mask_buf_def[i], ~d->mask_buf[i]);
-			if (ret < 0)
-				dev_err(d->map->dev,
-					"Failed to sync unmasks in %x\n",
+			if (ret)
+				dev_err(d->map->dev, "Failed to sync masks in %x\n",
 					reg);
-			unmask_offset = d->chip->unmask_base -
-							d->chip->mask_base;
-			/* clear mask with unmask_base register */
-			ret = regmap_update_bits(d->map,
-					reg + unmask_offset,
-					d->mask_buf_def[i],
-					d->mask_buf[i]);
-		} else {
-			ret = regmap_update_bits(d->map, reg,
-					 d->mask_buf_def[i], d->mask_buf[i]);
 		}
-		if (ret != 0)
-			dev_err(d->map->dev, "Failed to sync masks in %x\n",
-				reg);
 
 		reg = sub_irq_reg(d, d->chip->wake_base, i);
 		if (d->wake_buf) {
@@ -704,7 +694,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	int ret = -ENOMEM;
 	int num_type_reg;
 	u32 reg;
-	u32 unmask_offset;
 
 	if (chip->num_regs <= 0)
 		return -EINVAL;
@@ -832,6 +821,42 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	d->chip = chip;
 	d->irq_base = irq_base;
 
+	if (chip->mask_base && chip->unmask_base &&
+	    !chip->mask_unmask_non_inverted) {
+		/*
+		 * Chips that specify both mask_base and unmask_base used to
+		 * get inverted mask behavior by default, with no way to ask
+		 * for the normal, non-inverted behavior. This "inverted by
+		 * default" behavior is deprecated, but we have to support it
+		 * until existing drivers have been fixed.
+		 *
+		 * Existing drivers should be updated by swapping mask_base
+		 * and unmask_base and setting mask_unmask_non_inverted=true.
+		 * New drivers should always set the flag.
+		 */
+		dev_warn(map->dev, "mask_base and unmask_base are inverted, please fix it");
+
+		/* Might as well warn about mask_invert while we're at it... */
+		if (chip->mask_invert)
+			dev_warn(map->dev, "mask_invert=true ignored");
+
+		d->mask_base = chip->unmask_base;
+		d->unmask_base = chip->mask_base;
+	} else if (chip->mask_invert) {
+		/*
+		 * Swap the roles of mask_base and unmask_base if the bits are
+		 * inverted. This is deprecated, drivers should use unmask_base
+		 * directly.
+		 */
+		dev_warn(map->dev, "mask_invert=true is deprecated; please switch to unmask_base");
+
+		d->mask_base = chip->unmask_base;
+		d->unmask_base = chip->mask_base;
+	} else {
+		d->mask_base = chip->mask_base;
+		d->unmask_base = chip->unmask_base;
+	}
+
 	if (chip->irq_reg_stride)
 		d->irq_reg_stride = chip->irq_reg_stride;
 	else
@@ -854,28 +879,27 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	/* Mask all the interrupts by default */
 	for (i = 0; i < chip->num_regs; i++) {
 		d->mask_buf[i] = d->mask_buf_def[i];
-		if (!chip->mask_base)
-			continue;
-
-		reg = sub_irq_reg(d, d->chip->mask_base, i);
 
-		if (chip->mask_invert)
+		if (d->mask_base) {
+			reg = sub_irq_reg(d, d->mask_base, i);
 			ret = regmap_update_bits(d->map, reg,
-					 d->mask_buf[i], ~d->mask_buf[i]);
-		else if (d->chip->unmask_base) {
-			unmask_offset = d->chip->unmask_base -
-					d->chip->mask_base;
-			ret = regmap_update_bits(d->map,
-					reg + unmask_offset,
-					d->mask_buf[i],
-					d->mask_buf[i]);
-		} else
+					d->mask_buf_def[i], d->mask_buf[i]);
+			if (ret) {
+				dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
+					reg, ret);
+				goto err_alloc;
+			}
+		}
+
+		if (d->unmask_base) {
+			reg = sub_irq_reg(d, d->unmask_base, i);
 			ret = regmap_update_bits(d->map, reg,
-					 d->mask_buf[i], d->mask_buf[i]);
-		if (ret != 0) {
-			dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
-				reg, ret);
-			goto err_alloc;
+					d->mask_buf_def[i], ~d->mask_buf[i]);
+			if (ret) {
+				dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
+					reg, ret);
+				goto err_alloc;
+			}
 		}
 
 		if (!chip->init_ack_masked)
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 2b5b07f85cc0..708f36dfaeda 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1451,9 +1451,10 @@ struct regmap_irq_sub_irq_map {
  *		   main_status set.
  *
  * @status_base: Base status register address.
- * @mask_base:   Base mask register address.
- * @unmask_base:  Base unmask register address. for chips who have
- *                separate mask and unmask registers
+ * @mask_base:   Base mask register address. Mask bits are set to 1 when an
+ *               interrupt is masked, 0 when unmasked.
+ * @unmask_base:  Base unmask register address. Unmask bits are set to 1 when
+ *                an interrupt is unmasked and 0 when masked.
  * @ack_base:    Base ack address. If zero then the chip is clear on read.
  *               Using zero value is possible with @use_ack bit.
  * @wake_base:   Base address for wake enables.  If zero unsupported.
@@ -1465,6 +1466,16 @@ struct regmap_irq_sub_irq_map {
  * @irq_reg_stride:  Stride to use for chips where registers are not contiguous.
  * @init_ack_masked: Ack all masked interrupts once during initalization.
  * @mask_invert: Inverted mask register: cleared bits are masked out.
+ *		 Deprecated; prefer describing an inverted mask register as
+ *		 an unmask register.
+ * @mask_unmask_non_inverted: Controls mask bit inversion for chips that set
+ *	both @mask_base and @unmask_base. If false, mask and unmask bits are
+ *	inverted (which is deprecated behavior); if true, bits will not be
+ *	inverted and the registers keep their normal behavior. Note that if
+ *	you use only one of @mask_base or @unmask_base, this flag has no
+ *	effect and is unnecessary. Any new drivers that set both @mask_base
+ *	and @unmask_base should set this to true to avoid relying on the
+ *	deprecated behavior.
  * @use_ack:     Use @ack register even if it is zero.
  * @ack_invert:  Inverted ack register: cleared bits for ack.
  * @clear_ack:  Use this to set 1 and 0 or vice-versa to clear interrupts.
@@ -1530,6 +1541,7 @@ struct regmap_irq_chip {
 	unsigned int irq_reg_stride;
 	unsigned int init_ack_masked:1;
 	unsigned int mask_invert:1;
+	unsigned int mask_unmask_non_inverted:1;
 	unsigned int use_ack:1;
 	unsigned int ack_invert:1;
 	unsigned int clear_ack:1;
-- 
2.35.1

