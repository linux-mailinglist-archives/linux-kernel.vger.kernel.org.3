Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88728552596
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344708AbiFTULs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344623AbiFTUJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:09:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019D6220D4;
        Mon, 20 Jun 2022 13:07:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m1so8328310wrb.2;
        Mon, 20 Jun 2022 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8kelxsU1mTvCHb8JyuDiGnwBNKthLdTp6riqPTxASyE=;
        b=o6bhf9AeZ2+5NqgP4pO+3P9gyNweVr/bGU2k/NUXa6NYXjGakzCObDD7wDkgdnebAg
         v6HJT2NvVLc4mo3MpTeYh7ui7/s+BGJ7Q4/gnJt/JyyKpgFnZPhBR2Ka+BdipZTmpezs
         50XXSFPysaMCnC2KyoQqTfJgpwHcP8Qs6csQsoSjKJr7YEOzIlf0AvxEBaBGy51urmg4
         0Qc9l+ouyuPb6zVKalYja0H/6iGdSRaP0Jx3Ik9CPxUwZcQPoSFsBH2qzIwE8XNgSX1u
         1SryEGKFSLwPnYG9/aqm/DK+EGcho8O+D/L54CfDLfTFRjDpxwWLjKpGj0GZHfs/pPGX
         yvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8kelxsU1mTvCHb8JyuDiGnwBNKthLdTp6riqPTxASyE=;
        b=NODORLP8gEvs6jwWpB2eRLvVw22NeBxEhGrRL5qMQ7QVptqNAIjIlIPu0xIsg0rKCg
         aW4NKW3bnx+XaB8mFdK+p8kDo0/s9WfWXf8Tw/c7sIOwovLX2W83VeTUYLuxX9scA1e5
         vkoiGyk8kyiAStYNJ1ZUCtOl8Lgv7IDvxsQwiB3A/m93B+dhWSJR/EzXCn1jD9xs3phl
         iHpCaD15618Vv2O4wiqAf+K5bVV3yGvqgtqsazXsBZu4hmvv7zPpsALCQehgEXhA1yDC
         KIdw73jOkFIC0HptNN3L3LynryHRc4s1s3ODKiYeWgN34dkSNnIECVLIqU/QrV/Aa3hN
         x5mA==
X-Gm-Message-State: AJIora8slbMCbWStkhVOEEBLfuujqRR1EtXy8vwMXE/uJAmjpOUxKJ9z
        T1VuBfxaKfUWwhpAcxErp98=
X-Google-Smtp-Source: AGRyM1svSmsGihGwSulWHMLA111MOtQXrfsi0glFa3Tcg1QRdKrN9n0oiKBKxxv3eSGlgwCYymRU0Q==
X-Received: by 2002:a05:6000:1689:b0:218:3fb1:fd30 with SMTP id y9-20020a056000168900b002183fb1fd30mr24704084wrd.302.1655755655073;
        Mon, 20 Jun 2022 13:07:35 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id j6-20020adff006000000b0021b892f4b35sm7152390wro.98.2022.06.20.13.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:07:34 -0700 (PDT)
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
Subject: [PATCH 49/49] regmap-irq: Remove not_fixed_stride flag
Date:   Mon, 20 Jun 2022 21:06:44 +0100
Message-Id: <20220620200644.1961936-50-aidanmacdonald.0x0@gmail.com>
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

Clean up all the cruft related to not_fixed_stride. The same thing
can be accomplished with a custom get_irq_reg() callback.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 41 +++-----------------------------
 include/linux/regmap.h           |  7 ------
 2 files changed, 3 insertions(+), 45 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index acbd6e22b0cd..0c9dd218614a 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -320,15 +320,8 @@ static inline int read_sub_irq_data(struct regmap_irq_chip_data *data,
 			unsigned int offset = subreg->offset[i];
 			unsigned int index = offset / map->reg_stride;
 
-			if (chip->not_fixed_stride)
-				ret = regmap_read(map,
-						chip->status_base + offset,
-						&data->status_buf[b]);
-			else
-				ret = regmap_read(map,
-						chip->status_base + offset,
-						&data->status_buf[index]);
-
+			ret = regmap_read(map, chip->status_base + offset,
+					  &data->status_buf[index]);
 			if (ret)
 				break;
 		}
@@ -380,18 +373,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		 * sake of simplicity. and add bulk reads only if needed
 		 */
 		for (i = 0; i < chip->num_main_regs; i++) {
-			/*
-			 * For not_fixed_stride, don't use get_irq_reg().
-			 * It would produce an incorrect result.
-			 */
-			if (data->chip->not_fixed_stride)
-				reg = chip->main_status +
-					(i * map->reg_stride *
-					 data->irq_reg_stride);
-			else
-				reg = data->get_irq_reg(data,
-							chip->main_status, i);
-
+			reg = data->get_irq_reg(data, chip->main_status, i);
 			ret = regmap_read(map, reg, &data->main_status_buf[i]);
 			if (ret) {
 				dev_err(map->dev,
@@ -561,17 +543,6 @@ unsigned int regmap_irq_get_irq_reg_linear(struct regmap_irq_chip_data *data,
 	const struct regmap_irq_chip *chip = data->chip;
 	struct regmap *map = data->map;
 
-	/*
-	 * NOTE: This is for backward compatibility only and will be removed
-	 * when not_fixed_stride is dropped (it's only used by qcom-pm8008).
-	 */
-	if (chip->not_fixed_stride && chip->sub_reg_offsets) {
-		struct regmap_irq_sub_irq_map *subreg;
-
-		subreg = &chip->sub_reg_offsets[0];
-		return base + subreg->offset[0];
-	}
-
 	return base + index * (map->reg_stride * chip->irq_reg_stride);
 }
 EXPORT_SYMBOL_GPL(regmap_irq_get_irq_reg_linear);
@@ -674,12 +645,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			return -EINVAL;
 	}
 
-	if (chip->not_fixed_stride) {
-		for (i = 0; i < chip->num_regs; i++)
-			if (chip->sub_reg_offsets[i].num_regs != 1)
-				return -EINVAL;
-	}
-
 	if (irq_base) {
 		irq_base = irq_alloc_descs(irq_base, 0, chip->num_irqs, 0);
 		if (irq_base < 0) {
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index be51af0a2425..ecd3682de269 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1446,9 +1446,6 @@ struct regmap_irq_chip_data;
  *		     status_base. Should contain num_regs arrays.
  *		     Can be provided for chips with more complex mapping than
  *		     1.st bit to 1.st sub-reg, 2.nd bit to 2.nd sub-reg, ...
- *		     When used with not_fixed_stride, each one-element array
- *		     member contains offset calculated as address from each
- *		     peripheral to first peripheral.
  * @num_main_regs: Number of 'main status' irq registers for chips which have
  *		   main_status set.
  *
@@ -1474,9 +1471,6 @@ struct regmap_irq_chip_data;
  * @clear_on_unmask: For chips with interrupts cleared on read: read the status
  *                   registers before unmasking interrupts to clear any bits
  *                   set when they were masked.
- * @not_fixed_stride: Used when chip peripherals are not laid out with fixed
- * 		      stride. Must be used with sub_reg_offsets containing the
- * 		      offsets to each peripheral.
  * @status_invert: Inverted status register: cleared bits are active interrupts.
  * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
  *
@@ -1529,7 +1523,6 @@ struct regmap_irq_chip {
 	bool runtime_pm:1;
 	bool type_in_mask:1;
 	bool clear_on_unmask:1;
-	bool not_fixed_stride:1;
 	bool status_invert:1;
 
 	int num_regs;
-- 
2.35.1

