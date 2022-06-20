Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3842E55256F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242118AbiFTUJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344671AbiFTUIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:08:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A821B2181A;
        Mon, 20 Jun 2022 13:07:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w17so16066166wrg.7;
        Mon, 20 Jun 2022 13:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NcUaD1/hetXoR1Hr3zOaIrV5ibqb80WKTQCzVE8bVrc=;
        b=JYv78xaECQZTaj29SjmNHnhs4gfEEratnCgfJZagJJiK+EVif7vCkcuTP1QF0wfouK
         JhOxz5Q0vETS+bhO7JLSkwPttvHYnqkEyX3HWyCMGYjjskRlAQvkUsr5XtoBlAJVGwhM
         Gw+0xCBp9YPW230YKLPHGegCcK1UoKqqxF+q0NM7n1ss/f9b2tA03ELnh9lj8wNVqRiD
         p3oWRBH9z/0ejlWRohZ3vCWr/VL+wIvmrnrFxL5IVwRiWT8mfm+mPnriC/8/NBkGAEQT
         cw5lNfhGyRNeY0VAdg2EvhXglVeSK8bk4eq65rFbOML/1pGcXaRo+6lWO3/nbDyuiy/y
         5z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NcUaD1/hetXoR1Hr3zOaIrV5ibqb80WKTQCzVE8bVrc=;
        b=ReXB9y16Hv53gBhRAuyxlS3PRomiA6egr3YS5G/IR5zeJr8KzcD7/z0DGcW3mo19rk
         N9Xa3XRCdA/tcp1zAVo/dfAVfoJBfa8eBaBPg+uMcEO9Vv8Nf+q93JjnTliO/rMhOhJq
         6tmAI2B+cx2ZEfzM7vTHlMlyJjPxGGABv68U8K+aTFL9YPf83nilST5s7o/+XD4JfkTm
         C0X7eGhTRFLw88cYFkHK7jljafFqG3Au/P57rYrgC0S184BO8I9wh0/HzB31MKTSapr+
         IHjn/QcmmkPPnO/9nTGWobKvEnNS75LFYg6BVPBXvIVaTZMsoZZ+S8PggFwI3LcKCz7E
         U67g==
X-Gm-Message-State: AJIora+WVbdn2Dryxo+FfPGUICXpCwcYur32r2udU4+7i3tq4TykVKN2
        bEJhtC2HieESD5kWKPgFpQ4=
X-Google-Smtp-Source: AGRyM1t6EjGq1Ksd7MyVDLpDLClD84TIjP3RmrRekqAiittfXcb8Cp1PUoN9E0quIHfglyDXxzFsVA==
X-Received: by 2002:a5d:4601:0:b0:21b:9035:d295 with SMTP id t1-20020a5d4601000000b0021b9035d295mr6103622wrq.63.1655755637616;
        Mon, 20 Jun 2022 13:07:17 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id m42-20020a05600c3b2a00b003973435c517sm16572141wms.0.2022.06.20.13.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:07:17 -0700 (PDT)
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
Subject: [PATCH 39/49] gpio: sl28cpld: replace irqchip mask_invert with unmask_base
Date:   Mon, 20 Jun 2022 21:06:34 +0100
Message-Id: <20220620200644.1961936-40-aidanmacdonald.0x0@gmail.com>
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

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/gpio/gpio-sl28cpld.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-sl28cpld.c b/drivers/gpio/gpio-sl28cpld.c
index 52404736ac86..2195f88c2048 100644
--- a/drivers/gpio/gpio-sl28cpld.c
+++ b/drivers/gpio/gpio-sl28cpld.c
@@ -70,8 +70,7 @@ static int sl28cpld_gpio_irq_init(struct platform_device *pdev,
 	irq_chip->num_irqs = ARRAY_SIZE(sl28cpld_gpio_irqs);
 	irq_chip->num_regs = 1;
 	irq_chip->status_base = base + GPIO_REG_IP;
-	irq_chip->mask_base = base + GPIO_REG_IE;
-	irq_chip->mask_invert = true;
+	irq_chip->unmask_base = base + GPIO_REG_IE;
 	irq_chip->ack_base = base + GPIO_REG_IP;
 
 	ret = devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),
-- 
2.35.1

