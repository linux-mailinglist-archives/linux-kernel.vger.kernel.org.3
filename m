Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C815B552561
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbiFTUJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344467AbiFTUI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:08:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2B321266;
        Mon, 20 Jun 2022 13:07:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id q15so6375291wmj.2;
        Mon, 20 Jun 2022 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ioRXJqRjZqDXf4uhS+zPl4sLu26/rBgrPA3q0xnI1Pk=;
        b=bnHiwq/OClrzuqi/qkl++cxkoDtbanVKeopfnQWVzhU6b4gvB+73xPfwfecrFvG0fg
         c94hGekA8YHpGAXe9zm4qRYYRU0MygrSlEa2zYIu7XgB36o7uYhJEoYrROKQmUBSIY4o
         GC/IaRLTd6YmBywt5HAzxlmtbcVviB558rpnzU3IVr9JxhUY6/cumMLeOBejkhO41DwT
         DsEaO5ReO1eTDEIa8hszhVJBZB5Hbw7MzANj+u8x+/yO6D10YAQ3WQUnywEkt8FEYgLt
         +TQ57DgXgy4ZTyDpkcfoqzaf3zEuCixQ6UraTBXfq3S+ppuoQQgmhycH0ATq77SlYom2
         h4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ioRXJqRjZqDXf4uhS+zPl4sLu26/rBgrPA3q0xnI1Pk=;
        b=hLb1KtD6u9DGyN8WI8k9lvm92CxwGF4OhhDQ3TjnCdq2xiqibiSv009z84m3H+RIAD
         1Z9E8fzR9DUvbazaFYlhIqX9Wg9wb4b1xnB1WYszm2r7iw49Zzwe40PjZssgJIwy0ANK
         Wn/5CVMOSYczWOD2EBodHFYeXZzIAva8JEuFXTucBmMdcpH0s7+YSH5BFuFscz0LRDzU
         m9cjtIiH9K+rVEbrNtGaYeqNaHrh5dknNBVTS3oJHnQOuqJ2q85+PfufffNjbkrX8pWS
         WqGXIBy9EG0MxWvr6jHit/xIO0P49wcMlO7EzRH6O/kk3c7rbE7Mm1LzmNtEKxNZUGhm
         DXgw==
X-Gm-Message-State: AOAM5329m+jt+flJsb++aMnce5/nfaBuUbDlkxDCHGoKJQlzPFt60XZe
        z/97j11chR+wQHbmgCtbZ5E=
X-Google-Smtp-Source: ABdhPJyk2pG0lVa2PXgg+IL73pDXXybyl784/0CAFzghroiptrtMxz7E7l4unjYw5iEqpwxxNZmr7A==
X-Received: by 2002:a1c:4c0d:0:b0:39c:5233:1873 with SMTP id z13-20020a1c4c0d000000b0039c52331873mr37323556wmf.28.1655755627588;
        Mon, 20 Jun 2022 13:07:07 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c4d0a000000b003942a244ee6sm15738587wmh.43.2022.06.20.13.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:07:07 -0700 (PDT)
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
Subject: [PATCH 33/49] mfd: rohm-bd718x7: drop useless mask_invert flag on irqchip
Date:   Mon, 20 Jun 2022 21:06:28 +0100
Message-Id: <20220620200644.1961936-34-aidanmacdonald.0x0@gmail.com>
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

There's no need to set the flag explicitly to false, since that
is the default value from zero initialization.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/rohm-bd718x7.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index bfd81f78beae..ad6c0971a997 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -70,7 +70,6 @@ static struct regmap_irq_chip bd718xx_irq_chip = {
 	.mask_base = BD718XX_REG_MIRQ,
 	.ack_base = BD718XX_REG_IRQ,
 	.init_ack_masked = true,
-	.mask_invert = false,
 };
 
 static const struct regmap_range pmic_status_range = {
-- 
2.35.1

