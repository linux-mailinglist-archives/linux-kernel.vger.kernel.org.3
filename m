Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1AE55258F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344547AbiFTULk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344444AbiFTUJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:09:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93F621E2B;
        Mon, 20 Jun 2022 13:07:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g27so9434564wrb.10;
        Mon, 20 Jun 2022 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=klzG1EiAdFscBZBcoCzDKMr3GKqX2S6ab3hLTukICYA=;
        b=l4GFUZrKtyjWTlZn2W6sbNe7RkJpSisjb5nPFCMRsK4VVftYk11OQgyGsUsVQOVVxd
         WveltYUyuvOFbYFUdYhxpXNuxE4S4YCumzKcvnxPGX4OsA13JEey1GXiYfj+BN3FyuAk
         YoyM6iFFHOgbk2ykc+NDEEHh/n23+NkaBHDoIRTmULng90YVn+qOGMdpsjX8phANF5/i
         sk5OxAxVvNJ2GPbb6NqRjZvP8u6Pf1FxTRCjPvzgHPcXQnzfgqR8rhEIYzbMNaK4cAp6
         yiv/olpO3Koxh4OhoUfRvU3fEVkmdETxuX090a9/gNWOJYRM4fDVw5XWJYzxI9yxqfA6
         IXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=klzG1EiAdFscBZBcoCzDKMr3GKqX2S6ab3hLTukICYA=;
        b=Mj6MLl20uYFHL5Mtdya4XtPph4a5+6SYuPWAFNEt6N+xo5Nnj3OztSAGXODz26S7yJ
         MpId9/0Z1dKaxTngzyN8eg+abvyZW6+Ze7ytwys+cKmXo3VQ/qb+bdor2djaXhnL5Tnt
         U4Hc4SmQ/dC2EuR0FfSeUnoRls/EKhDUuAbda4UQp5LRWeOp1FLPuKgeAeqUv5H729JO
         VEQGoptOhRhc4g1vCUxrrGaJYH0FPkiJmxEvHBKdr/WfHdFR5Hv8UQcxiKfP68t7zTGs
         ulaE1l4+TqrTrFZXWLpAW0MwTAfjYB7WEezqt20KGipBi7Ssy0XpSFsQTTgjF3KSuQ+a
         Y7JA==
X-Gm-Message-State: AJIora8rN2IrMWaPKvbXhI4jn5DKnUAmMJpHQqEdlg4ezBezeSfFT1N/
        vlMTp3OMjHvkqAv6jw4SA0k=
X-Google-Smtp-Source: AGRyM1tNlpsLQBbADqcDPRR01JRNtswf/HBtBf5oihaYlvZj08PdTVfZrZn0YfVlGpD8PsGFQGId1w==
X-Received: by 2002:a5d:5981:0:b0:218:51ae:8808 with SMTP id n1-20020a5d5981000000b0021851ae8808mr24885992wri.244.1655755648056;
        Mon, 20 Jun 2022 13:07:28 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id d3-20020adffbc3000000b0020e6ce4dabdsm14219147wrs.103.2022.06.20.13.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:07:27 -0700 (PDT)
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
Subject: [PATCH 45/49] regmap-irq: Remove mask_invert flag
Date:   Mon, 20 Jun 2022 21:06:40 +0100
Message-Id: <20220620200644.1961936-46-aidanmacdonald.0x0@gmail.com>
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

An inverted mask register can be represented more directly
as an unmask register. Drop the redundant mask_invert flag.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 30 ++++++++----------------------
 include/linux/regmap.h           |  2 --
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 8a718615fd09..0a8edaee064a 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -30,9 +30,6 @@ struct regmap_irq_chip_data {
 	int irq;
 	int wake_count;
 
-	unsigned int mask_base;
-	unsigned int unmask_base;
-
 	void *status_reg_buf;
 	unsigned int *main_status_buf;
 	unsigned int *status_buf;
@@ -126,8 +123,8 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 	 * suppress pointless writes.
 	 */
 	for (i = 0; i < d->chip->num_regs; i++) {
-		if (d->mask_base) {
-			reg = sub_irq_reg(d, d->mask_base, i);
+		if (d->chip->mask_base) {
+			reg = sub_irq_reg(d, d->chip->mask_base, i);
 			ret = regmap_irq_update_mask_bits(d, reg,
 					d->mask_buf_def[i], d->mask_buf[i]);
 			if (ret != 0)
@@ -135,8 +132,8 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 					reg);
 		}
 
-		if (d->unmask_base) {
-			reg = sub_irq_reg(d, d->unmask_base, i);
+		if (d->chip->unmask_base) {
+			reg = sub_irq_reg(d, d->chip->unmask_base, i);
 			ret = regmap_irq_update_mask_bits(d, reg,
 					d->mask_buf_def[i], ~d->mask_buf[i]);
 			if (ret != 0)
@@ -721,17 +718,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	d->chip = chip;
 	d->irq_base = irq_base;
 
-	/*
-	 * Swap role of mask_base and unmask_base if mask bits are inverted.
-	 */
-	if (chip->mask_invert) {
-		d->mask_base = chip->unmask_base;
-		d->unmask_base = chip->mask_base;
-	} else {
-		d->mask_base = chip->mask_base;
-		d->unmask_base = chip->unmask_base;
-	}
-
 	if (chip->irq_reg_stride)
 		d->irq_reg_stride = chip->irq_reg_stride;
 	else
@@ -756,8 +742,8 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	for (i = 0; i < chip->num_regs; i++) {
 		d->mask_buf[i] = d->mask_buf_def[i];
 
-		if (d->mask_base) {
-			reg = sub_irq_reg(d, d->mask_base, i);
+		if (d->chip->mask_base) {
+			reg = sub_irq_reg(d, d->chip->mask_base, i);
 			ret = regmap_irq_update_mask_bits(d, reg,
 					d->mask_buf_def[i], d->mask_buf[i]);
 			if (ret != 0) {
@@ -767,8 +753,8 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			}
 		}
 
-		if (d->unmask_base) {
-			reg = sub_irq_reg(d, d->unmask_base, i);
+		if (d->chip->unmask_base) {
+			reg = sub_irq_reg(d, d->chip->unmask_base, i);
 			ret = regmap_irq_update_mask_bits(d, reg,
 					d->mask_buf_def[i], ~d->mask_buf[i]);
 			if (ret != 0) {
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index a3103c88e936..bb625a1edef9 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1462,7 +1462,6 @@ struct regmap_irq_sub_irq_map {
  * @config_base: Base address for IRQ type config regs. If null unsupported.
  * @irq_reg_stride:  Stride to use for chips where registers are not contiguous.
  * @init_ack_masked: Ack all masked interrupts once during initalization.
- * @mask_invert: Inverted mask register: cleared bits are masked out.
  * @use_ack:     Use @ack register even if it is zero.
  * @ack_invert:  Inverted ack register: cleared bits for ack.
  * @clear_ack:  Use this to set 1 and 0 or vice-versa to clear interrupts.
@@ -1514,7 +1513,6 @@ struct regmap_irq_chip {
 	unsigned int irq_reg_stride;
 	bool mask_writeonly:1;
 	bool init_ack_masked:1;
-	bool mask_invert:1;
 	bool use_ack:1;
 	bool ack_invert:1;
 	bool clear_ack:1;
-- 
2.35.1

