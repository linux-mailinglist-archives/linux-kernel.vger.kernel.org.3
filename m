Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B2B5506E2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 23:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiFRVkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 17:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiFRVkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 17:40:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660EAEE04;
        Sat, 18 Jun 2022 14:39:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o10so10359641edi.1;
        Sat, 18 Jun 2022 14:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UTY/s32m0Wtb8ceiKoFbYE3NzsS87wWfGqUvXHlMqlU=;
        b=glDzJ1XuBItb+SjA7RGVPzxgTYN4TWodLSVBNGz4fwxTefjyMMS0MnuR06XKXwzeHW
         ijgyo0VoQlGz3n3L4jhMK+sltwllUw9VWhqIZ4iNHlfLvcTjnKavakKfLPVWYZzb4TMY
         BBfcG5rV/0b9PjnnIPEOzzLbBPv6whwY3Y57i56y3wZV+eLyWouGUEEhDDz1bUcNYEeV
         95L+28bWYqftxEKE4Yi12yfE3Hs3StfwuXmSP+seyo8Qcql+fkWIZMlUkGLklYg1NGOQ
         9n2rKvStm+TZmFT0nzzzhG70EXzDglYbKEVMuAXlGXDdy1o5EoIXq0ZWSeJOaBgiVHOn
         RlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UTY/s32m0Wtb8ceiKoFbYE3NzsS87wWfGqUvXHlMqlU=;
        b=dKyFMObDwIiabeZ7v+AiOa/heWtw0XUK+RwbbgD3TNHRP/1UD8+XA+8CKtuU97kN+1
         9fYZUYnPIY95bQ2Jsh26cYsKDVwzrJLJa5EsA199R+i7HnThASkxCe7QG+C8NYRiRPO/
         BS1/cywd2zO3b8nnIs9P7tICdUbyry9pjXUM/MSY5Vfxc/7/1NK635GOFpbVNVDzqxlV
         GrpX7TXgsCTIsTVVB4oRz1TF2tFAgWNhNM5JvrsotVAOoKdRBT0v9jyfgIFiUcZv85Ud
         BSJdrcsYjf6l/sIcUNztUEeE5RJS7Nf4JBC/vZXo0ZzZqsOUxn1Yv13uEmfCFky68Jau
         K5Tg==
X-Gm-Message-State: AJIora8twa0bnt8ybOtqhOO+7mBL284tNFZj25IaffENXjgtDFokk6Q7
        1wkqMFXGgI4sJbSv1xNQliM=
X-Google-Smtp-Source: AGRyM1uIncf3FCatoVZbEOcZy057dosvVm1M+HIBG4nrUYcL0Q/BuqU45yNz80UbSPowQ+m5JKQClw==
X-Received: by 2002:a05:6402:2399:b0:42e:1400:818b with SMTP id j25-20020a056402239900b0042e1400818bmr20741818eda.159.1655588398061;
        Sat, 18 Jun 2022 14:39:58 -0700 (PDT)
Received: from localhost (92.40.169.177.threembb.co.uk. [92.40.169.177])
        by smtp.gmail.com with ESMTPSA id c6-20020a170906170600b00706242d297fsm3738302eje.212.2022.06.18.14.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 14:39:57 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 01/16] regmap-irq: Use sub_irq_reg() to calculate unmask register address
Date:   Sat, 18 Jun 2022 22:39:54 +0100
Message-Id: <20220618214009.2178567-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
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
to avoid relying on the fact that sub_irq_reg() is a linear function
of "base_reg" and "i".

Unmask registers were the only type that didn't use sub_irq_reg() for
address calculation; thus, sub_irq_reg() is now the only method used
to obtain register addresses.

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

