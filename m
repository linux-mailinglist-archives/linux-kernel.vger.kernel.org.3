Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C63F552556
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbiFTUIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343894AbiFTUHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:07:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0682E20190;
        Mon, 20 Jun 2022 13:07:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g4so16059750wrh.11;
        Mon, 20 Jun 2022 13:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RL0fwUpj3N31VObGflnvTdc3SYbFvbOFJTIucbQixBw=;
        b=Mlv4ZVoHQKH/diZ7wxwIL4K/NMJzc8U94Vgk4Cv6mLqtv2zUYMSW25mN9q0aL0QiaD
         ypWyVxkxCSP8wGvJCokCsjQ6tDA09v/ytF7zvcl648K7FlONHBR2wfNK3QShVbur16Ms
         Etfs+ATYrdsjBlliM9yYPEfiDP24lw5E53L/DQ+aFBEaoSuyH0FKKVlxJgKMAVEDu74C
         qNbf8xDFV/CcJqFhatQhPeGSPTWRTO55xPy2YKxC6vO/a5lLkP3E2xpOBkHescTgDCGf
         6sV5K6mdGgz67dpXL7CLkkp/9x203Hye1oIstypDYQK4gwAVULEnVqIxaa7ZmZAes0sL
         9TIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RL0fwUpj3N31VObGflnvTdc3SYbFvbOFJTIucbQixBw=;
        b=h0r3xXI6j04VogwBtKVWLaKEuk1b4XOAgtqfOx4xU1VuZyvpE5yXOhiuoK5O3sQFI6
         e12W6HHVoBI0pdY42iYM73sqsaXvNb+v2BuAhRPaZh0SnHHWMQVoKitX4pu8L2/ojVp6
         v3gOEC8rXaM5xPl0lAK3PFxZBhaoU6XPoLphXz5Xu64P9RktVmGr/V3pcPSwTLHRCKBu
         3OgII15zxeMHU7AvZq3YewGsIm/Moh97XXY0Aydiwo5R7EQ58epzEXW0MFOWDCyNa78g
         bpfGK6mQpWl2e42JvGl0QjiU++Bst9McLQo/NxIqsrpbDqq3NK+/6Bte/L6W4n2DpAEB
         nuUg==
X-Gm-Message-State: AJIora8MKZCQQHcyJTzFtmE8J7EEB6h+yNo5MozhVLjiuPnNX/wHYxQ3
        BepDW9Caa3v/iEt/iJnuNu8=
X-Google-Smtp-Source: AGRyM1sc2kxmFsNd28wLHl+sBWx8EhrjSubA+8EnJdnvaG1LPBATT/Oqb8jppvaI5mcfhWVI8YU61A==
X-Received: by 2002:a5d:47a8:0:b0:217:b5ea:bdfb with SMTP id 8-20020a5d47a8000000b00217b5eabdfbmr25488579wrb.492.1655755620510;
        Mon, 20 Jun 2022 13:07:00 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b0039c5224bfcbsm20985958wms.46.2022.06.20.13.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:07:00 -0700 (PDT)
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
Subject: [PATCH 29/49] mfd: atc260x: replace irqchip mask_invert with unmask_base
Date:   Mon, 20 Jun 2022 21:06:24 +0100
Message-Id: <20220620200644.1961936-30-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/atc260x-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/atc260x-core.c b/drivers/mfd/atc260x-core.c
index 7148ff5b05b1..7c5de3ae776e 100644
--- a/drivers/mfd/atc260x-core.c
+++ b/drivers/mfd/atc260x-core.c
@@ -100,8 +100,7 @@ static const struct regmap_irq_chip atc2603c_regmap_irq_chip = {
 	.num_irqs = ARRAY_SIZE(atc2603c_regmap_irqs),
 	.num_regs = 1,
 	.status_base = ATC2603C_INTS_PD,
-	.mask_base = ATC2603C_INTS_MSK,
-	.mask_invert = true,
+	.unmask_base = ATC2603C_INTS_MSK,
 };
 
 static const struct regmap_irq_chip atc2609a_regmap_irq_chip = {
@@ -110,8 +109,7 @@ static const struct regmap_irq_chip atc2609a_regmap_irq_chip = {
 	.num_irqs = ARRAY_SIZE(atc2609a_regmap_irqs),
 	.num_regs = 1,
 	.status_base = ATC2609A_INTS_PD,
-	.mask_base = ATC2609A_INTS_MSK,
-	.mask_invert = true,
+	.unmask_base = ATC2609A_INTS_MSK,
 };
 
 static const struct resource atc2603c_onkey_resources[] = {
-- 
2.35.1

