Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B358552548
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343966AbiFTUIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343925AbiFTUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:07:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28241EAFB;
        Mon, 20 Jun 2022 13:06:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id o8so16102762wro.3;
        Mon, 20 Jun 2022 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/LPf9h09XUJR/z/RdQdPV0VQS/kTyakjP+1OAofeWXA=;
        b=fwpJrSBMfmFPeeNXJrlpjWlkFshzFm6Y1DWOVq+h4L71A/9e1R5aHmopQ9JlXAYX77
         p/aPMsuwp0jXJ6JA/lErm+8RcPw1nwj/qzcNe82rYLGJJE87iMHlnWgUuO98N/3+uLWl
         HoFIstzlvMDtCLgfhnOriWLoNwZv6+3clTJtgU5AJImo5hzLcA8Xl5biIy+qCPN0Yl2h
         sSZ3MIekuF7sfDNA5dosij4OPFFY4DXnc1sarY9jKvYuFBzZIvgCKpyr0XlJB/Ymar7p
         76Xyx3zNFdDnkRRyU54ZBIwLy/ubU9zZyaI0NzK9C8RtA20uucTc0zHujNOvDTsjWaG+
         UbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/LPf9h09XUJR/z/RdQdPV0VQS/kTyakjP+1OAofeWXA=;
        b=5zyP9iDTayzNUHX2jrK+4Xo5jIqFGovJwmn+wIC7M4AsNJ7EYYdogvIhJQMe8nFpPZ
         eAYPUIYEqkQKdp/OCHaxgEfpRbBGB17KwPG4K251Xc2kf+GlmeY3fcSy6U5EDq6UEZ54
         Yl3Qbo98UI9Ja9mARBjHXAfFC+iD5EYK0z3GKUx0OjSyZUkuyKJwTYissorNQ7+sovMF
         tKVjFPZyM8em5prJ60wH7zb9IhrQ5MV6d/mW4EJdgeQe5U4bMXbkAFoYsuA7HwH6xO/c
         H3WBgZjL9tnTLmInF6O0x7S1IHg0zyOleBLjpzYJcRf7zj7d0QN8RBoSOM33tW7NcGVf
         AaQQ==
X-Gm-Message-State: AJIora8PZvyImUZP81FSpprzxuzHg3xPc3RKGHLQorF0X8L9hJ68Rnkv
        UOXackf/n29UDvusJxQcRGE=
X-Google-Smtp-Source: AGRyM1saqWHhZeAqgNDua/lIIE8QUgq+ce7t9oCt2daRUSekH7GNKx27L1qwZwbxMxNYwR5edglGYw==
X-Received: by 2002:a05:6000:156c:b0:218:5691:e72b with SMTP id 12-20020a056000156c00b002185691e72bmr24333023wrz.95.1655755612132;
        Mon, 20 Jun 2022 13:06:52 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c2cb100b00397393419e3sm20418814wmc.28.2022.06.20.13.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:51 -0700 (PDT)
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
Subject: [PATCH 24/49] mfd: rt5033: replace irqchip mask_invert with unmask_base
Date:   Mon, 20 Jun 2022 21:06:19 +0100
Message-Id: <20220620200644.1961936-25-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/rt5033.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index f1236a9acf30..dc9bf4057a09 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -29,8 +29,7 @@ static const struct regmap_irq rt5033_irqs[] = {
 static const struct regmap_irq_chip rt5033_irq_chip = {
 	.name		= "rt5033",
 	.status_base	= RT5033_REG_PMIC_IRQ_STAT,
-	.mask_base	= RT5033_REG_PMIC_IRQ_CTRL,
-	.mask_invert	= true,
+	.unmask_base	= RT5033_REG_PMIC_IRQ_CTRL,
 	.num_regs	= 1,
 	.irqs		= rt5033_irqs,
 	.num_irqs	= ARRAY_SIZE(rt5033_irqs),
-- 
2.35.1

