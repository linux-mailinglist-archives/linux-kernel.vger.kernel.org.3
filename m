Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4243E552520
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343825AbiFTUIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbiFTUHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:07:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E52720187;
        Mon, 20 Jun 2022 13:06:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m1so8326231wrb.2;
        Mon, 20 Jun 2022 13:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RxzMqxj/eXn7w9NNf93GCQveT2W3i+9cnq4DwR+RJyE=;
        b=o76wuo0xPC/x3J+fSzV08PvTJNEDSkggAXYsoR9+fouiAFePVvNZxWHKb6V2vQ92OA
         SE+0Tgogz4/JpWBQo32vpyKXLh2Katf4rLXy/5aiL3oY3i7H+xTu8fBXo9Kmwm+1LdJN
         n17o06/gfXQXFoYWk4+a7o5AXR1yv4WDcHzYxk5Bo6GjGCsBM4jzZLPAZskoHBAppBrr
         O0akQIZhIrT1LlNKwQ0GBml8Y9QIufqmcfQWayZorKoyOzzGnKmI65dWbbANUzud/obW
         h52Jbwhvf8dXR/t08i55bKKmJaWPIdWVSrVoX8K6QhSQSAGB7kcnC01lTkvgx2dqq/2U
         cwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RxzMqxj/eXn7w9NNf93GCQveT2W3i+9cnq4DwR+RJyE=;
        b=WhswbX0vsbCQsOlxmZLGhKRMY9OM4zrxYUoM9G+pF92IMI9E/CWm0rf89jxOT0uMls
         bc3b3W2++/DGHcPJqSr3fD/hDod+jTdMyiQDA1cAnlo+v1uTfgzqxU3Sr+jRBXo7hdTk
         hC6GQEQWp41jp5BXO6nYooE9KQBvgNnUPWNBuHjxaSWe4DE1+cvM3AtWoYEwsXo9omEO
         erqB28vJgm3p0k8qSyFF4hCAUc8kPsfcQo1ffTbbJ3hnA12nV13a+KIUpDepcGykZIEJ
         snUC+yNFENRKSD1Qy/nq7qg+sHn9L3PtUNclNM2j5oBHkoN8UlQOk1KwQugLzvs2VcC/
         S0hw==
X-Gm-Message-State: AJIora+DnoThwymJNXuskRh1bk/X1y3SmSrtJaS6EFnoo3+TtEoicDS8
        YPekWWVCe9vwA4KNX58uUIo=
X-Google-Smtp-Source: AGRyM1uQHejr8zASwoWiI73KhsStma0zb82PJc1yA+xXQ76Hdedooq3WaNWKMgmFn77ar+BE+OUVCQ==
X-Received: by 2002:a5d:4592:0:b0:21b:8e50:7fb9 with SMTP id p18-20020a5d4592000000b0021b8e507fb9mr7563688wrq.428.1655755613935;
        Mon, 20 Jun 2022 13:06:53 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d452d000000b0021a3d94c7bdsm11884838wra.28.2022.06.20.13.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:53 -0700 (PDT)
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
Subject: [PATCH 25/49] mfd: rohm-bd71828: replace irqchip mask_invert with unmask_base
Date:   Mon, 20 Jun 2022 21:06:20 +0100
Message-Id: <20220620200644.1961936-26-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/rohm-bd71828.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index 714d9fcbf07b..3c5c6c393650 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -413,9 +413,8 @@ static struct regmap_irq_chip bd71828_irq_chip = {
 	.irqs = &bd71828_irqs[0],
 	.num_irqs = ARRAY_SIZE(bd71828_irqs),
 	.status_base = BD71828_REG_INT_BUCK,
-	.mask_base = BD71828_REG_INT_MASK_BUCK,
+	.unmask_base = BD71828_REG_INT_MASK_BUCK,
 	.ack_base = BD71828_REG_INT_BUCK,
-	.mask_invert = true,
 	.init_ack_masked = true,
 	.num_regs = 12,
 	.num_main_regs = 1,
@@ -430,9 +429,8 @@ static struct regmap_irq_chip bd71815_irq_chip = {
 	.irqs = &bd71815_irqs[0],
 	.num_irqs = ARRAY_SIZE(bd71815_irqs),
 	.status_base = BD71815_REG_INT_STAT_01,
-	.mask_base = BD71815_REG_INT_EN_01,
+	.unmask_base = BD71815_REG_INT_EN_01,
 	.ack_base = BD71815_REG_INT_STAT_01,
-	.mask_invert = true,
 	.init_ack_masked = true,
 	.num_regs = 12,
 	.num_main_regs = 1,
-- 
2.35.1

