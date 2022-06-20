Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A0C55255E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344296AbiFTUJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344097AbiFTUIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:08:22 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF4F21249;
        Mon, 20 Jun 2022 13:07:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso6197188wml.1;
        Mon, 20 Jun 2022 13:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rzfzyKEVoJaKFIv88YU1vTCrVQJBpK7ii1ptmDvGvSE=;
        b=qBJcC0LrxQSAdxyKj5Dt7HUFUmjMISoYgjBHUUClNbIz3vAp9h4I6Lqto2o/8nRZZx
         +mUtIMCKQ+xDXPL3Fzv7A9LsfxQhVJy+J3jisVRnKW/heO0ptBVZJfGA10gsSJrLxZO+
         MObbJW6hGStsGnZRd48uGh/4qGcgNShaBsFXlaMlKP83cLUJ5mnOfQscQbtReaFC3JVv
         djWshs0XGTygSwTV7AEfyGWiz4kJ7raOzjYloQWDqDDB2Jm1I+3fzts9p4jEUGs+ylCU
         BlkyfP5HaSiXqAYXZ7zggOUoAuRHWYspwGWZ2TzWqacHn9MVYPY2Vzt3RKPNhtN644ir
         H1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rzfzyKEVoJaKFIv88YU1vTCrVQJBpK7ii1ptmDvGvSE=;
        b=AXBLqiyJ0uqNIm7UWWbRALy7woyYwMVrW29TZ2C56HzZ1+H9jEnU1EDQAlzdQbA9hv
         U9xymh5oJzy5efgoe4uiMLfQH+mzs+ZlFgf5YkmQewVBFpujhlwhWZxw6nBGo3KVr0w6
         pf85W9Zn4AGJ/qFPGqwxW8klC7lJlkKAjY+aLTHgEvQzg51/AsyA/MD+dzbXPjbsi6DP
         mMqXL+K65eWydj7cWSSCEvWmsveJv1gQG/Fq7zy/YfI+faa6f/UPzePXs9QRm/qgokbg
         W+qUqAFzJo7WssJHt9wA9ZoSJ/vqXByrljl7G8G7Iy1hY9m4/9bmgFm1H8y9UKNXQGQS
         7sLQ==
X-Gm-Message-State: AOAM533OefxMhXvocSFrVLin1zJg6Gfg9t/jbWTUS+fd/KdV+mYSClKO
        oxD5QZjldw0Tci5yQQ96yvI=
X-Google-Smtp-Source: ABdhPJyInyenW+OvDrbjpJKIaFUgNOigofr86k1OtUqbh4EqGuM90WNh58WAi7KJRkr+4OM3pXCRPQ==
X-Received: by 2002:a1c:4c13:0:b0:39c:5a6b:8540 with SMTP id z19-20020a1c4c13000000b0039c5a6b8540mr36262410wmf.106.1655755624155;
        Mon, 20 Jun 2022 13:07:04 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b0039c5645c60fsm28045293wms.3.2022.06.20.13.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:07:03 -0700 (PDT)
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
Subject: [PATCH 31/49] mfd: max14577: replace irqchip mask_invert with unmask_base
Date:   Mon, 20 Jun 2022 21:06:26 +0100
Message-Id: <20220620200644.1961936-32-aidanmacdonald.0x0@gmail.com>
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

An inverted mask register can be described more directly
as an unmask register.

Also drop useless mask_invert flag from the pmic irq chip.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/max14577.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index 6c487fa14e9c..7a501dcc48f6 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -209,8 +209,7 @@ static const struct regmap_irq max14577_irqs[] = {
 static const struct regmap_irq_chip max14577_irq_chip = {
 	.name			= "max14577",
 	.status_base		= MAX14577_REG_INT1,
-	.mask_base		= MAX14577_REG_INTMASK1,
-	.mask_invert		= true,
+	.unmask_base		= MAX14577_REG_INTMASK1,
 	.num_regs		= 3,
 	.irqs			= max14577_irqs,
 	.num_irqs		= ARRAY_SIZE(max14577_irqs),
@@ -239,8 +238,7 @@ static const struct regmap_irq max77836_muic_irqs[] = {
 static const struct regmap_irq_chip max77836_muic_irq_chip = {
 	.name			= "max77836-muic",
 	.status_base		= MAX14577_REG_INT1,
-	.mask_base		= MAX14577_REG_INTMASK1,
-	.mask_invert		= true,
+	.unmask_base		= MAX14577_REG_INTMASK1,
 	.num_regs		= 3,
 	.irqs			= max77836_muic_irqs,
 	.num_irqs		= ARRAY_SIZE(max77836_muic_irqs),
@@ -255,7 +253,6 @@ static const struct regmap_irq_chip max77836_pmic_irq_chip = {
 	.name			= "max77836-pmic",
 	.status_base		= MAX77836_PMIC_REG_TOPSYS_INT,
 	.mask_base		= MAX77836_PMIC_REG_TOPSYS_INT_MASK,
-	.mask_invert		= false,
 	.num_regs		= 1,
 	.irqs			= max77836_pmic_irqs,
 	.num_irqs		= ARRAY_SIZE(max77836_pmic_irqs),
-- 
2.35.1

