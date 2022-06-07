Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123F95402EC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344473AbiFGPw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344372AbiFGPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:52:37 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5885002B;
        Tue,  7 Jun 2022 08:52:33 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bg6so16257921ejb.0;
        Tue, 07 Jun 2022 08:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5wUI1Rc8KiEurG0wbCSq8IZqjw2W0EgDdU1++1cCCWM=;
        b=Emf/lwDUGI2N6DQorjI6he/SYFGTJlkZOMtKuP4sXkPq4PvFfv/8cukdYUMt7ff+RA
         skLv9O9QtGh6S20hfzOcc93A4i6uWoAvBPfuFacpLIHQU8J+TwbF1nhU+haXf6Rv9zcJ
         wiIOZU79BNUeFDOhVx7zGby20lsHT7IGf1UuaTtodok6fLR5Lyo3VNxjsgE3pVoEhjqg
         3KmPYA3hTetp+bUfnKckQKk58R7zBeLE0X1JgSef9VmuoP+nCjKocsDvLLJKT/TyD2R7
         5ha20m5gCtNblcURx662Nvz9n49Xf3Cd68gbUihcEW9Yi97dM1wUzpoh1pDwO3UaiMEA
         C82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5wUI1Rc8KiEurG0wbCSq8IZqjw2W0EgDdU1++1cCCWM=;
        b=fkWNKg4Dgn+1u/0Bow4Naw9Gcd2s/zzYwpdF1hwicGVlEuBr8tfjQjOshmxO+ir5dx
         RcxFuglULv9FjJx3yQqYKvry+9lRNmjagfobA/3oJFrTwZi0nIllt154Y0ImDwZzC1wz
         xOdArzHdP8NpWbbZcvSFD+5QF/V+uECf/Z2TVzadqakQgg8hOt9FInQqWFnj7JhqXaON
         fbj+LhiZBSyc8FxoDRY1wH/84wE2UJKjzlfzsKFG9ChgSfkLDuZ3k5RZT4EztSI+RpHe
         WtfhnVB8Cb3960vvWPOvRYXz0iTWcH4+f+MaPfahzwQdJhCcVKyo8o9cwRAG59IvTPws
         GY8Q==
X-Gm-Message-State: AOAM532oKLFdC297EW8Fj62PQGwCxM1D4LfiremhNRSUMJm7Zb2A0wy6
        irTNQa08TFf5IGG3H3YagNE=
X-Google-Smtp-Source: ABdhPJxfI6iulmnsTbvkiGuT2Q5vXR0VYA/C/3Kjix3Hy+kVBu5q8LoDGYnUmD8O3088m7Ow7LVeGA==
X-Received: by 2002:a17:907:a0ca:b0:6f8:5bef:b9c with SMTP id hw10-20020a170907a0ca00b006f85bef0b9cmr27508744ejc.630.1654617146660;
        Tue, 07 Jun 2022 08:52:26 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id n9-20020a170906700900b006fe8ac6bc69sm7982284ejj.140.2022.06.07.08.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:52:26 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 01/17] regmap-irq: Use sub_irq_reg() to calculate unmask register address
Date:   Tue,  7 Jun 2022 16:53:08 +0100
Message-Id: <20220607155324.118102-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
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

Call sub_irq_reg() instead of calculating the offset of the register
to avoid relying on the fact that sub_irq_reg() is a linear function.
This prepares for allowing drivers to override the default sub_irq_reg
implementation if the default behavior is unsuitable.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 400c7412a7dc..4a2e1f6aa94d 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -97,7 +97,6 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 	struct regmap *map = d->map;
 	int i, j, ret;
 	u32 reg;
-	u32 unmask_offset;
 	u32 val;
 
 	if (d->chip->runtime_pm) {
@@ -141,11 +140,11 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
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
@@ -632,7 +631,6 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	int ret = -ENOMEM;
 	int num_type_reg;
 	u32 reg;
-	u32 unmask_offset;
 
 	if (chip->num_regs <= 0)
 		return -EINVAL;
@@ -773,10 +771,9 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
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
-- 
2.35.1

