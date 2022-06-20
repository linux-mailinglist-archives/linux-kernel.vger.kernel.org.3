Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E271552550
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343925AbiFTUIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344089AbiFTUHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:07:32 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBC81EAF6;
        Mon, 20 Jun 2022 13:06:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n1so15842863wrg.12;
        Mon, 20 Jun 2022 13:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DTY/U6s0Ls/Dtw06y3+h8JI8hTjwct+Am+4ddShNVBI=;
        b=YLV9HVC+AuiPiyFoS3kBS6rWy2Gjdbs/RM2nFfy9wTqwdZFX0UXlXKk5xti7k7/YfQ
         2P62pyaX41f81Mx4DSWuyjatSY+/7lA/G8nV48egrVJ2yaymGBYB2GNCkXpSY8BVwdPc
         UfIABhiWRF+9AghYCFIxPI5Zxc5kChjXJpHLRgpieDaKOWBp5sHc9iq/i8aKzPSn9tFm
         4gxgSzdozxH22+jMKs/x0dBZBgERtmU1igIsm48zLXwthMic+vhyTYQctNH5OkVynDcN
         7mpW0MeJmLgfC+VbxloiSMxT2IAuB2PsvQjFG1L99Vog+c+Ukv3qRMNVf6Kq/ifo+mKe
         7Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DTY/U6s0Ls/Dtw06y3+h8JI8hTjwct+Am+4ddShNVBI=;
        b=2Ld4bOsfSsPvr2oGEeU2k11h9fl9Bl8eYdyw6pu6ozuJJPEaQ+q3H+nFQtaGSeOCD4
         mf1a1qc3yvAFO4CB2jus63UPS2EGs3wzoCrzZL64djnN1mb/tB5FCGub9DIn0PBgyMPZ
         CTMLcnS33FLp7Mah8SK73v9zMg78zjVD+hhF5XnOZLyWKfbEpihydJk2nV1024d0wMPy
         zdq+8kApr+VyFyDy7pUhcxUHEYePw13fUaED6bJFZnclH3OPIDDwmDxyqv217dkOhV9d
         zwz8uXgMMluOzXnAsFFWLZ/wcNhFojrNn7m1XAuAxjLqJ8pW1oWsj7EB2OXUHVXz5dZ/
         BdQQ==
X-Gm-Message-State: AJIora+PZiRiVav8/Y9p4fl7e9dFSzlERw+/fxXz6GW9PF2Rl/XgTw/x
        JTev3MbTJVK+x3lIEGaoHOk=
X-Google-Smtp-Source: AGRyM1sDxyahRh5I6JQeiiGBQbk9ax/ShTfPCo/d3S6kQfwtlTUB/zSFPkFow3AhqZQhxwOVIp9FHQ==
X-Received: by 2002:a5d:64e9:0:b0:218:3fdb:bfd2 with SMTP id g9-20020a5d64e9000000b002183fdbbfd2mr25588725wri.717.1655755618712;
        Mon, 20 Jun 2022 13:06:58 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id d9-20020a056000114900b0021b8dd05f45sm4858105wrx.55.2022.06.20.13.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:58 -0700 (PDT)
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
Subject: [PATCH 28/49] mfd: axp20x: replace irqchip mask_invert with unmask_base
Date:   Mon, 20 Jun 2022 21:06:23 +0100
Message-Id: <20220620200644.1961936-29-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/axp20x.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 8161a5dc68e8..3be0d0aa8b34 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -506,8 +506,7 @@ static const struct regmap_irq_chip axp152_regmap_irq_chip = {
 	.name			= "axp152_irq_chip",
 	.status_base		= AXP152_IRQ1_STATE,
 	.ack_base		= AXP152_IRQ1_STATE,
-	.mask_base		= AXP152_IRQ1_EN,
-	.mask_invert		= true,
+	.unmask_base		= AXP152_IRQ1_EN,
 	.init_ack_masked	= true,
 	.irqs			= axp152_regmap_irqs,
 	.num_irqs		= ARRAY_SIZE(axp152_regmap_irqs),
@@ -518,8 +517,7 @@ static const struct regmap_irq_chip axp20x_regmap_irq_chip = {
 	.name			= "axp20x_irq_chip",
 	.status_base		= AXP20X_IRQ1_STATE,
 	.ack_base		= AXP20X_IRQ1_STATE,
-	.mask_base		= AXP20X_IRQ1_EN,
-	.mask_invert		= true,
+	.unmask_base		= AXP20X_IRQ1_EN,
 	.init_ack_masked	= true,
 	.irqs			= axp20x_regmap_irqs,
 	.num_irqs		= ARRAY_SIZE(axp20x_regmap_irqs),
@@ -531,8 +529,7 @@ static const struct regmap_irq_chip axp22x_regmap_irq_chip = {
 	.name			= "axp22x_irq_chip",
 	.status_base		= AXP20X_IRQ1_STATE,
 	.ack_base		= AXP20X_IRQ1_STATE,
-	.mask_base		= AXP20X_IRQ1_EN,
-	.mask_invert		= true,
+	.unmask_base		= AXP20X_IRQ1_EN,
 	.init_ack_masked	= true,
 	.irqs			= axp22x_regmap_irqs,
 	.num_irqs		= ARRAY_SIZE(axp22x_regmap_irqs),
@@ -543,8 +540,7 @@ static const struct regmap_irq_chip axp288_regmap_irq_chip = {
 	.name			= "axp288_irq_chip",
 	.status_base		= AXP20X_IRQ1_STATE,
 	.ack_base		= AXP20X_IRQ1_STATE,
-	.mask_base		= AXP20X_IRQ1_EN,
-	.mask_invert		= true,
+	.unmask_base		= AXP20X_IRQ1_EN,
 	.init_ack_masked	= true,
 	.irqs			= axp288_regmap_irqs,
 	.num_irqs		= ARRAY_SIZE(axp288_regmap_irqs),
@@ -556,8 +552,7 @@ static const struct regmap_irq_chip axp803_regmap_irq_chip = {
 	.name			= "axp803",
 	.status_base		= AXP20X_IRQ1_STATE,
 	.ack_base		= AXP20X_IRQ1_STATE,
-	.mask_base		= AXP20X_IRQ1_EN,
-	.mask_invert		= true,
+	.unmask_base		= AXP20X_IRQ1_EN,
 	.init_ack_masked	= true,
 	.irqs			= axp803_regmap_irqs,
 	.num_irqs		= ARRAY_SIZE(axp803_regmap_irqs),
@@ -568,8 +563,7 @@ static const struct regmap_irq_chip axp806_regmap_irq_chip = {
 	.name			= "axp806",
 	.status_base		= AXP20X_IRQ1_STATE,
 	.ack_base		= AXP20X_IRQ1_STATE,
-	.mask_base		= AXP20X_IRQ1_EN,
-	.mask_invert		= true,
+	.unmask_base		= AXP20X_IRQ1_EN,
 	.init_ack_masked	= true,
 	.irqs			= axp806_regmap_irqs,
 	.num_irqs		= ARRAY_SIZE(axp806_regmap_irqs),
@@ -580,8 +574,7 @@ static const struct regmap_irq_chip axp809_regmap_irq_chip = {
 	.name			= "axp809",
 	.status_base		= AXP20X_IRQ1_STATE,
 	.ack_base		= AXP20X_IRQ1_STATE,
-	.mask_base		= AXP20X_IRQ1_EN,
-	.mask_invert		= true,
+	.unmask_base		= AXP20X_IRQ1_EN,
 	.init_ack_masked	= true,
 	.irqs			= axp809_regmap_irqs,
 	.num_irqs		= ARRAY_SIZE(axp809_regmap_irqs),
-- 
2.35.1

