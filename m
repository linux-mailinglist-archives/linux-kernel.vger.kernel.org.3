Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DEF55255C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbiFTUI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344405AbiFTUIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:08:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EFA21254;
        Mon, 20 Jun 2022 13:07:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q9so16080258wrd.8;
        Mon, 20 Jun 2022 13:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y97fwLubKQPhfVzVr/BJ8A0OiHWSUnBqrgJCFHiEuQo=;
        b=N5XPG9OplADmbLH0pHfxycXOk0ogBS6as/63+9NbBIR+tpKjwFF8jaDqvXytgN7eFN
         iCIGHlH+jU+vvt27pchv5bzTabl6azkQzKY7vFkafPwH50QQyWfkBzOGOCCVxQXhvncE
         YaWxNzKfmxeTvJUbcVoUMVUAWlE3JvZZ4lB+5+QyyAHS3e43yyMBrnmUQcQabmJqyNxu
         yz5S4TVH2O8DPD2Rf80CaJq7lQH+C0gh4FsLbgYgRXSmVebkFxyjrNjhCPP76XpsYQIa
         zUI7t6/WnGNbz1TtlV3gFxQsN1aO4fpmL8EGt0pWJOiQvv0pEELOjmzyWY2VXTtrFst3
         zOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y97fwLubKQPhfVzVr/BJ8A0OiHWSUnBqrgJCFHiEuQo=;
        b=pvaQNWQbCF0hYiRJwWD7wx3gQ+KUwBy6gWtHDqD9XVuVZQzZWet1Pc8yA6MT+sptQ2
         oOErs4UaXp7tyDnLjQFkAuqJXx9H8bfy4A9CgdEPS1qtxFLD1qUCUYb1izUKRjt1dCHj
         lAo9tshFRXEwwqhu9yiOaN12cEr5VXgftJr3x1Q+I+6NnxJJyNiIRAtLExcijBrdIkgZ
         LYGMrB1UCMVchISHk/KFyfuoWW19Aqq4dsJJg5xIrdZ5S+5Evl16gEQVdSJKCAERT49y
         polIfWoL8KQcWQvutNK2SX/J39EkGibq9aalYK18s7jF/XWrPSGyQkq3ArJ/WkoLBL+h
         4k6w==
X-Gm-Message-State: AJIora8d8MhcGsFeBU4v2JPMc3KgpYkt/PKAdX5HTe/wWjKx9Zpz6lZa
        HR6BKgru7OFN+ODZeDuZiCk=
X-Google-Smtp-Source: AGRyM1snTNRqPq+iZgzXYj3YO4MyMbr+ecuPp+zCi4PLi5xytxdvLNbc3QFI/5y6NXWpWtWF0rRckQ==
X-Received: by 2002:a5d:5e92:0:b0:21a:278c:b901 with SMTP id ck18-20020a5d5e92000000b0021a278cb901mr24824370wrb.461.1655755632740;
        Mon, 20 Jun 2022 13:07:12 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b0039c4ba160absm33779394wmq.2.2022.06.20.13.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:07:12 -0700 (PDT)
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
Subject: [PATCH 36/49] extcon: sm5502: drop useless mask_invert flag on irqchip
Date:   Mon, 20 Jun 2022 21:06:31 +0100
Message-Id: <20220620200644.1961936-37-aidanmacdonald.0x0@gmail.com>
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
 drivers/extcon/extcon-sm5502.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index f706f5288257..8401e8b27788 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -227,7 +227,6 @@ static const struct regmap_irq_chip sm5502_muic_irq_chip = {
 	.name			= "sm5502",
 	.status_base		= SM5502_REG_INT1,
 	.mask_base		= SM5502_REG_INTMASK1,
-	.mask_invert		= false,
 	.num_regs		= 2,
 	.irqs			= sm5502_irqs,
 	.num_irqs		= ARRAY_SIZE(sm5502_irqs),
@@ -276,7 +275,6 @@ static const struct regmap_irq_chip sm5504_muic_irq_chip = {
 	.name			= "sm5504",
 	.status_base		= SM5502_REG_INT1,
 	.mask_base		= SM5502_REG_INTMASK1,
-	.mask_invert		= false,
 	.num_regs		= 2,
 	.irqs			= sm5504_irqs,
 	.num_irqs		= ARRAY_SIZE(sm5504_irqs),
-- 
2.35.1

