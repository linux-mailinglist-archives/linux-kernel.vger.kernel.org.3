Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589FA552523
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343930AbiFTUHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245574AbiFTUG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:59 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9D61F2E3;
        Mon, 20 Jun 2022 13:06:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a10so6374645wmj.5;
        Mon, 20 Jun 2022 13:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1GpLIZISKqF9zFT4V1VJAxmf6nn2WqheoAcUl14eN+0=;
        b=jmla8ZkAOgrPskXynLCx05NWcsoEkbzw4ryinc4jYDe2RQIqHhPmV85RQKl7U9EmUI
         bF6TQ7O+iemjbNinkBjDldrg2yYic5jWOfe5sSL2/VPNdE+cj0lrEbPwTlpJTZs7BttW
         crq3WUJJa6c/dObTJx9WHn0Fl68Y8gRDUlBvzH70ODYLEG0pgioICXVMDThfVXbcB68W
         ixmvmMn2GGU7Gnw+8ih+LjNZ3VEsZF5IpRaRfmraY75SBGsUraU0gCZChrsxbjdlp0c3
         X2WoHLbmrUSCLmnOMru0muZcahA8wUBHqdqxnvkpgp8UxCePBtXvm2MD7P0hwoO2uvZb
         BGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GpLIZISKqF9zFT4V1VJAxmf6nn2WqheoAcUl14eN+0=;
        b=HTw4yWS7AhzBS2WDE6OGr+XoGE0RKJqtRAXRKnXTFTF3SAZRcoZmEFZ3Ci44dv8RJb
         r+ENdeah9BprgFcLlxFo5o+mNzQbQPTOTh2vlSb83h2p7tEWXLEc25Qh5m20heHwTAA1
         CAT6+KIMqmLyjEACiB7XNJ5VMr+21ZVZMIdqLYgO9VpZe0pvkiB/E103J5P0H9jFz8cq
         4KTxTtTmqKrmtCLrk7b1W2oV2Vg2S6nuymoGINUY4sZ4cCBcz8gtQoDL31dspdxQQKUH
         2VMaBD+72/tMpP3U0+dygfZLiyTnoNrQym469Y5QcQsxPhcLG0be3Y0Q0nh2EG709ad+
         NSUQ==
X-Gm-Message-State: AOAM533FjnZmUjwnGKDMVgjuFbCxABAe/P0JhgCcSqvlWA9IHgsEgUyG
        Ugm7a9bHqZ4fCc2liR/oIas=
X-Google-Smtp-Source: ABdhPJx5dO+fQ4bSwFvdlpiB13bqVgu0Tmz5FemzXFKDgDhK5sVpfqzf/x7Jf9ygCYEoM4c832uaSw==
X-Received: by 2002:a05:600c:19cb:b0:397:51db:446f with SMTP id u11-20020a05600c19cb00b0039751db446fmr36963462wmq.182.1655755605944;
        Mon, 20 Jun 2022 13:06:45 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id t17-20020adfe111000000b002102cc4d63asm17480550wrz.81.2022.06.20.13.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:45 -0700 (PDT)
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
Subject: [PATCH 20/49] regmap-irq: Fix inverted handling of unmask registers
Date:   Mon, 20 Jun 2022 21:06:15 +0100
Message-Id: <20220620200644.1961936-21-aidanmacdonald.0x0@gmail.com>
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
mask_base/unmask_base. The mask_invert flag is made redundant,
since an inverted mask register can be described more directly
as an unmask register.

To cope with existing drivers that rely on the old "backward"
behavior, check for the broken_mask_unmask flag and swap the
roles of mask/unmask registers. This is a compatibility measure
which can be dropped once the drivers are updated to use the
new, more consistent behavior.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 96 +++++++++++++++++---------------
 include/linux/regmap.h           |  7 ++-
 2 files changed, 55 insertions(+), 48 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 875415fc3133..082a2981120c 100644
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
 			ret = regmap_irq_update_mask_bits(d, reg,
-					 d->mask_buf_def[i], ~d->mask_buf[i]);
-		} else if (d->chip->unmask_base) {
-			/* set mask with mask_base register */
+					d->mask_buf_def[i], d->mask_buf[i]);
+			if (ret != 0)
+				dev_err(d->map->dev, "Failed to sync masks in %x\n",
+					reg);
+		}
+
+		if (d->unmask_base) {
+			reg = sub_irq_reg(d, d->unmask_base, i);
 			ret = regmap_irq_update_mask_bits(d, reg,
 					d->mask_buf_def[i], ~d->mask_buf[i]);
-			if (ret < 0)
-				dev_err(d->map->dev,
-					"Failed to sync unmasks in %x\n",
+			if (ret != 0)
+				dev_err(d->map->dev, "Failed to sync masks in %x\n",
 					reg);
-			unmask_offset = d->chip->unmask_base -
-							d->chip->mask_base;
-			/* clear mask with unmask_base register */
-			ret = regmap_irq_update_mask_bits(d,
-					reg + unmask_offset,
-					d->mask_buf_def[i],
-					d->mask_buf[i]);
-		} else {
-			ret = regmap_irq_update_mask_bits(d, reg,
-					 d->mask_buf_def[i], d->mask_buf[i]);
 		}
-		if (ret != 0)
-			dev_err(d->map->dev, "Failed to sync masks in %x\n",
-				reg);
 
 		reg = sub_irq_reg(d, d->chip->wake_base, i);
 		if (d->wake_buf) {
@@ -634,7 +624,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	int i;
 	int ret = -ENOMEM;
 	u32 reg;
-	u32 unmask_offset;
 
 	if (chip->num_regs <= 0)
 		return -EINVAL;
@@ -732,6 +721,24 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	d->chip = chip;
 	d->irq_base = irq_base;
 
+	/*
+	 * Swap role of mask_base and unmask_base if mask bits are inverted.
+	 *
+	 * Historically, chips that specify both mask_base and unmask_base
+	 * got inverted mask behavior; this was arguably a bug in regmap-irq
+	 * and there was no way to get the normal, non-inverted behavior.
+	 * Those chips will set the broken_mask_unmask flag. They don't set
+	 * mask_invert so there is no need to worry about interactions with
+	 * that flag.
+	 */
+	if (chip->mask_invert || chip->broken_mask_unmask) {
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
@@ -755,28 +762,27 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	/* Mask all the interrupts by default */
 	for (i = 0; i < chip->num_regs; i++) {
 		d->mask_buf[i] = d->mask_buf_def[i];
-		if (!chip->mask_base)
-			continue;
 
-		reg = sub_irq_reg(d, d->chip->mask_base, i);
-
-		if (chip->mask_invert)
+		if (d->mask_base) {
+			reg = sub_irq_reg(d, d->mask_base, i);
 			ret = regmap_irq_update_mask_bits(d, reg,
-					 d->mask_buf[i], ~d->mask_buf[i]);
-		else if (d->chip->unmask_base) {
-			unmask_offset = d->chip->unmask_base -
-					d->chip->mask_base;
-			ret = regmap_irq_update_mask_bits(d,
-					reg + unmask_offset,
-					d->mask_buf[i],
-					d->mask_buf[i]);
-		} else
+					d->mask_buf_def[i], d->mask_buf[i]);
+			if (ret != 0) {
+				dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
+					reg, ret);
+				goto err_alloc;
+			}
+		}
+
+		if (d->unmask_base) {
+			reg = sub_irq_reg(d, d->unmask_base, i);
 			ret = regmap_irq_update_mask_bits(d, reg,
-					 d->mask_buf[i], d->mask_buf[i]);
-		if (ret != 0) {
-			dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
-				reg, ret);
-			goto err_alloc;
+					d->mask_buf_def[i], ~d->mask_buf[i]);
+			if (ret != 0) {
+				dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
+					reg, ret);
+				goto err_alloc;
+			}
 		}
 
 		if (!chip->init_ack_masked)
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 21a70fd99493..0cf3c4a66946 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1451,10 +1451,11 @@ struct regmap_irq_sub_irq_map {
  *		   main_status set.
  *
  * @status_base: Base status register address.
- * @mask_base:   Base mask register address.
+ * @mask_base:   Base mask register address. Mask bits are set to 1 when an
+ *               interrupt is masked, 0 when unmasked.
  * @mask_writeonly: Base mask register is write only.
- * @unmask_base:  Base unmask register address. for chips who have
- *                separate mask and unmask registers
+ * @unmask_base:  Base unmask register address. Unmask bits are set to 1 when
+ *                an interrupt is unmasked and 0 when masked.
  * @ack_base:    Base ack address. If zero then the chip is clear on read.
  *               Using zero value is possible with @use_ack bit.
  * @wake_base:   Base address for wake enables.  If zero unsupported.
-- 
2.35.1

