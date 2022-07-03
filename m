Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91032564716
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiGCLVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiGCLUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:20:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC35A473;
        Sun,  3 Jul 2022 04:20:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b26so9491264wrc.2;
        Sun, 03 Jul 2022 04:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bSfmZia4N88+QuTxam9V/x71AfxUr34uHrXfe8m2m+s=;
        b=e0+8yuwI5okIBqeg5zNokoRoOPY6/DvUlVK3PEspKrysI9Cm/plvvpX8r2n4JGYxCV
         AIHBaGq6klA+HnJWjq8f4VrQCkqxak4cPpTS2W5cvsYwrDNaylMYL2hr8RE0h19/gNe4
         MJbSLf0lWAZBFbNf/vtT9qDr0MKA+feZNHZ8VW718/xpbAve+7y0u1OuLQ8rhwJH4Efe
         j5BbxDvbsoP2AODrMXp0/JFhXZw9uZMAQciJBGthoT/09g4THMemx6mPvE0lFtruMtn8
         LsHGUnhbr0SLvLhv0pvQv5q1Wh7KebpCT8VYCjSRfK4InZFuB90G7CIsAuvUDP5A6cbD
         CNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bSfmZia4N88+QuTxam9V/x71AfxUr34uHrXfe8m2m+s=;
        b=tSg252AaOU3Lld5Ugd6h5UqLBAPQkt0BFD+a0+zhcoLw3GZzvA3Mu2plkvjQ8jbhvE
         rqSmEQXdvYLZpr8nC25BPvwIqraDjnLaSN0Am6i2g0ZNtZk31x17xIMcNCQ3U2dIp/Nb
         yiRRg/lqvBgyoBJTjIH09Emf0ay1mCYqktGH/WcYImNe0B8LnXOzTdeMh2fCcXew7bOx
         lJDtodh4Ade2KQV/DDhPISBCWvLaIuDX7EZPnE18S+DsCHcWBU+8ZAPvS7zEqprhaaqy
         4Vnx160mfPnkeAynTxyxDFGMkDiUdCUAy8X/7JJjAp1qdyBHwa/RMCkEn8KSpeGhVB8V
         Mhdg==
X-Gm-Message-State: AJIora84sSf34Y5cvnaNEoDIENv+LLtNo5A5m6cKt8/2DjJm4zbkNMyJ
        b7DkGTuJBw0fNPSlqDW5ZSY=
X-Google-Smtp-Source: AGRyM1u6zxqrBezWUIlyy0xQlViWwHxIPyUF3G2qIa+Bsp4QteaBXh0kIIkKnDs6SQX8XohcGakrmw==
X-Received: by 2002:a5d:59a7:0:b0:21b:cd67:52d9 with SMTP id p7-20020a5d59a7000000b0021bcd6752d9mr22914933wrr.194.1656847226625;
        Sun, 03 Jul 2022 04:20:26 -0700 (PDT)
Received: from localhost (92.40.202.9.threembb.co.uk. [92.40.202.9])
        by smtp.gmail.com with ESMTPSA id v7-20020adfa1c7000000b0021d6924b777sm626421wrv.115.2022.07.03.04.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:20:26 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, krzk@kernel.org,
        m.szyprowski@samsung.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 10/12] regmap-irq: Fix inverted handling of unmask registers
Date:   Sun,  3 Jul 2022 12:20:59 +0100
Message-Id: <20220703112101.24493-11-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220703112101.24493-1-aidanmacdonald.0x0@gmail.com>
References: <20220703112101.24493-1-aidanmacdonald.0x0@gmail.com>
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

