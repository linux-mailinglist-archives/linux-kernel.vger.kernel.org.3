Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9156455253F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344073AbiFTUH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343745AbiFTUGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:48 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968EF1EC6A;
        Mon, 20 Jun 2022 13:06:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v14so16097604wra.5;
        Mon, 20 Jun 2022 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A1yO+P1r84NYRYcFw/ZOtSs0+i9q2Gv8RY8Jy0yOWqY=;
        b=j2RQqZvh6APhdsK/EoTEu81N6Pul31dRgCB3yZd8hs5x1U3Wtqcpi2IyHAfCICffHg
         gRE46BYS28U7XDvZvtUKB6Bkt51LTKNLuZl3ptMzn6BQlBgLD2r3jh/R/AjmK32xBhB/
         0LpqqAVt8CRLw8siXXmzBnqgCtafznYB6s/GT5pjpaL3Ybu6ff4EmEAU0UeweWfDlu9D
         gOHJaQkTCVmjnZ/VC5kfoHwVeu8ak+VVcbBIvos7fbcasrp9o1zr3tS8GqZqPBD0EZVy
         6K+rt8doOLqgDBdCB8rSjJnqOboGjisOhkwGg2ROmQbfj+bRGDs7mmQs1WJsKO3Yyqid
         O2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1yO+P1r84NYRYcFw/ZOtSs0+i9q2Gv8RY8Jy0yOWqY=;
        b=nWtFLrsNs08MUomBWrE63NIqwQg/SOLXW5Rcr0mg6ZbwkoFDvDCv98bY2CMQgVoAkt
         +/k2eQCiHQCok9vxaTQylr45iKTeI5VAfEEhgNsSBwwR0dOBcyTzHar/J8O8j9Ip2bDn
         qh/lyUvc79e3BixIyxKkyWjoKdKSg89i8017XK+m/CqjYvPkamLghRIpk3GqnIRYEXHY
         vlreE12If2Hq9xLOCpuXaYbVMEFBALv2fJw0lGEKPcjdUs4aL6sgpGhlgMbldkALJnEt
         EzT7z3IVu6dGyrkvJy3XuhabYUucbiX2oD+WjB58/dCv10trDSwkJYeeyyu/6zAaMFhh
         gL8g==
X-Gm-Message-State: AJIora8qIndvBiFDtAjWTTuWfFA1c2WBHphhMS3HI8OckDT17+6LQbHI
        wuxEfg0pCUkMQtyh16QqqtY=
X-Google-Smtp-Source: AGRyM1vhjUq4WlL+gX1y0tyZ4A5CURR86xjVYNDJLu6ZP96h77dZI91Uh7rAWnxqjmtwV7H8z5gWhg==
X-Received: by 2002:a5d:67c3:0:b0:21b:8cd4:ad60 with SMTP id n3-20020a5d67c3000000b0021b8cd4ad60mr8680011wrw.380.1655755600064;
        Mon, 20 Jun 2022 13:06:40 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d4201000000b0021a36955493sm14274307wrq.74.2022.06.20.13.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:39 -0700 (PDT)
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
Subject: [PATCH 16/49] regmap-irq: Rename regmap_irq_update_bits()
Date:   Mon, 20 Jun 2022 21:06:11 +0100
Message-Id: <20220620200644.1961936-17-aidanmacdonald.0x0@gmail.com>
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

This function should only be used for updating mask bits, since
it checks the mask_writeonly flag. To avoid confusion, rename it
to regmap_irq_update_mask_bits().

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 4c0d7f7aa544..875415fc3133 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -79,9 +79,9 @@ static void regmap_irq_lock(struct irq_data *data)
 	mutex_lock(&d->lock);
 }
 
-static int regmap_irq_update_bits(struct regmap_irq_chip_data *d,
-				  unsigned int reg, unsigned int mask,
-				  unsigned int val)
+static int regmap_irq_update_mask_bits(struct regmap_irq_chip_data *d,
+				       unsigned int reg, unsigned int mask,
+				       unsigned int val)
 {
 	if (d->chip->mask_writeonly)
 		return regmap_write(d->map, reg, val & mask);
@@ -129,11 +129,11 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 
 		reg = sub_irq_reg(d, d->chip->mask_base, i);
 		if (d->chip->mask_invert) {
-			ret = regmap_irq_update_bits(d, reg,
+			ret = regmap_irq_update_mask_bits(d, reg,
 					 d->mask_buf_def[i], ~d->mask_buf[i]);
 		} else if (d->chip->unmask_base) {
 			/* set mask with mask_base register */
-			ret = regmap_irq_update_bits(d, reg,
+			ret = regmap_irq_update_mask_bits(d, reg,
 					d->mask_buf_def[i], ~d->mask_buf[i]);
 			if (ret < 0)
 				dev_err(d->map->dev,
@@ -142,12 +142,12 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 			unmask_offset = d->chip->unmask_base -
 							d->chip->mask_base;
 			/* clear mask with unmask_base register */
-			ret = regmap_irq_update_bits(d,
+			ret = regmap_irq_update_mask_bits(d,
 					reg + unmask_offset,
 					d->mask_buf_def[i],
 					d->mask_buf[i]);
 		} else {
-			ret = regmap_irq_update_bits(d, reg,
+			ret = regmap_irq_update_mask_bits(d, reg,
 					 d->mask_buf_def[i], d->mask_buf[i]);
 		}
 		if (ret != 0)
@@ -761,17 +761,17 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		reg = sub_irq_reg(d, d->chip->mask_base, i);
 
 		if (chip->mask_invert)
-			ret = regmap_irq_update_bits(d, reg,
+			ret = regmap_irq_update_mask_bits(d, reg,
 					 d->mask_buf[i], ~d->mask_buf[i]);
 		else if (d->chip->unmask_base) {
 			unmask_offset = d->chip->unmask_base -
 					d->chip->mask_base;
-			ret = regmap_irq_update_bits(d,
+			ret = regmap_irq_update_mask_bits(d,
 					reg + unmask_offset,
 					d->mask_buf[i],
 					d->mask_buf[i]);
 		} else
-			ret = regmap_irq_update_bits(d, reg,
+			ret = regmap_irq_update_mask_bits(d, reg,
 					 d->mask_buf[i], d->mask_buf[i]);
 		if (ret != 0) {
 			dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
-- 
2.35.1

