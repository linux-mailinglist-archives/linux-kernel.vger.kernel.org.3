Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917DC552502
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245039AbiFTUGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244759AbiFTUGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E147A2AF8;
        Mon, 20 Jun 2022 13:06:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w17so16063400wrg.7;
        Mon, 20 Jun 2022 13:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8yaggp5fpGj18LvMF3HyT2CJ/UUMH+aDaQflQSqacJg=;
        b=paYIdrfsy1HcKjFG3USjGArwLlnXJ403FKBZEPKprh1PE/RRI93VAPiwepWUj+Ro7c
         ENC61PGASfcrY+pgOAuseMs4lQ6AScSKlCWwru9Ljvgf7pC4KMSA0bK4eGu3OCxV7qm5
         wgVWfAf3vE7WG0I2f3RsPT0dXYiyX6GqnUHQvuabUHTfmg5nJMNWCtH5ZMzBwNs25wX4
         t9E8oLF5DpWG+D3DpftCIf9mTSQJxDqoYaVCZhTgCuJRmMfUgjPLjlE/ERIuOv1UJLCy
         WClaj8RTIGJTGfmnGr90xpS3FB0zska6QllBOTUIBV7q3LzA4TCoQEqAIklVfUSlFkfB
         OuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8yaggp5fpGj18LvMF3HyT2CJ/UUMH+aDaQflQSqacJg=;
        b=tpk4a6vp/CE4RpA4+2xty0aNfKvhRYVl1WnBBcUbUBXhJEFHsYM/XIOGHp716CReC1
         R9c724hZnsiThSufC5DZ7ZvSUmfzJjxexBXMcopwvyeRH7YNfOdBkVS4SHTgUgoM7qTC
         yXcJ2oo8Ppjm2GiZa8nuGJXyQJx/lRc7cl2g5WQAP8BECF34b13I/iCwmlPWNGiupzYa
         baRGznpDpnHl3DLWs31Gn6gQQ5ZFS8AGglO0AAdXkurM6yhXdtnUvDIGAm9P8b0beHzV
         gkoB84iRe/Zh+D3+zNJtzTJh8Lu7yK8xpMxjUMNJ5M7ax1L7wqXHDAoBKdpkXEvOLGzo
         EQkg==
X-Gm-Message-State: AJIora880CiHE1tOuq+JPyb2gP94sSIBVdiwAm8LXbvkxc0QghIIE55z
        S17PA5X0Usv32C7+oOZJcLk=
X-Google-Smtp-Source: AGRyM1tqaOvSQ7Sb2fsCdfhlkOWzq8CIvRvGO9y9U1DjiSWuL/0J+/imI8fVxdWC8klmC3T0EKcKBg==
X-Received: by 2002:adf:fec2:0:b0:21a:6cff:a4f1 with SMTP id q2-20020adffec2000000b0021a6cffa4f1mr18314590wrs.139.1655755576525;
        Mon, 20 Jun 2022 13:06:16 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d48ce000000b0021020517639sm14093823wrs.102.2022.06.20.13.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:16 -0700 (PDT)
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
Subject: [PATCH 01/49] regmap-irq: Fix a bug in regmap_irq_enable() for type_in_mask chips
Date:   Mon, 20 Jun 2022 21:05:56 +0100
Message-Id: <20220620200644.1961936-2-aidanmacdonald.0x0@gmail.com>
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

When enabling a type_in_mask irq, the type_buf contents must be
AND'd with the mask of the IRQ we're enabling to avoid enabling
other IRQs by accident, which can happen if several type_in_mask
irqs share a mask register.

Fixes: bc998a730367 ("regmap: irq: handle HW using separate rising/falling edge interrupts")
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 400c7412a7dc..4f785bc7981c 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -252,6 +252,7 @@ static void regmap_irq_enable(struct irq_data *data)
 	struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
 	struct regmap *map = d->map;
 	const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
+	unsigned int reg = irq_data->reg_offset / map->reg_stride;
 	unsigned int mask, type;
 
 	type = irq_data->type.type_falling_val | irq_data->type.type_rising_val;
@@ -268,14 +269,14 @@ static void regmap_irq_enable(struct irq_data *data)
 	 * at the corresponding offset in regmap_irq_set_type().
 	 */
 	if (d->chip->type_in_mask && type)
-		mask = d->type_buf[irq_data->reg_offset / map->reg_stride];
+		mask = d->type_buf[reg] & irq_data->mask;
 	else
 		mask = irq_data->mask;
 
 	if (d->chip->clear_on_unmask)
 		d->clear_status = true;
 
-	d->mask_buf[irq_data->reg_offset / map->reg_stride] &= ~mask;
+	d->mask_buf[reg] &= ~mask;
 }
 
 static void regmap_irq_disable(struct irq_data *data)
-- 
2.35.1

