Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854FD552505
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343626AbiFTUGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245436AbiFTUG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FBF1D0D3;
        Mon, 20 Jun 2022 13:06:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p6-20020a05600c1d8600b0039c630b8d96so6919402wms.1;
        Mon, 20 Jun 2022 13:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wkuS+j3EIennvsLgZYGM7vfpABGRVV/MeAPfOizAshw=;
        b=M57wXO9iRmAgu6U0WPasocwyW6YC4HvS/IJuioNN538vnmyv29ll0KmRtJRGqY4itN
         I5gbLCbLPlKHq7ZNuKC0QkXblcjbrochyZFlSuHnjjhoHPPr1Vg/TNn/mngewPIWO169
         E27kNJdVJV3Q769UkEnpR1Oh4c69WClUwfdfkWm6pR4le2OgBRbLQJrUBMFotv/eASj1
         YU0JLn4khTyo1PQcOGGFf4AknS/GI3pTm1R4xxZ86sjh87yWudtYtwnb4CMZDPW1zXwd
         CLfvknNTNJG/K6TH6GcO0gCA7f0ytehD0u7KI3rLDYx1D5YiPv3fyPkopDKkyw4YaySB
         j/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wkuS+j3EIennvsLgZYGM7vfpABGRVV/MeAPfOizAshw=;
        b=EnANE990rwhHm617RfwAXO4bPVzPYq7DXMHBIDSqRYrNphxp7rw5NylfWqDAylurPw
         VJdcgZLYYOObhvYA8JATTEkRQ982ZskQlA9zSihYdZLi+lKe6d1QQabq9dFAE4uXH2Cc
         CKzrtOiVeC365oqanQNjkchog5QyxrbfWUHwSDtnosokP3cpqeKtBfcGBlFbeVdjUkNW
         EUKCFIBb9sWAi7DCsCfSlPgYm0ui1u8p9RK83vu+mpXlwZrCD6LynmxkIug2vSC6cIhi
         byi8lpnB5fxHffNjgDSQd4zgMifEQj/JBayBYwRXaDh0ftC2rFGq4Lr0d269oTIvbURA
         I3eQ==
X-Gm-Message-State: AJIora/5PequDusLEpQl6qgM+VzPVbtrXryzCo5np0EEZfotzd1B1veQ
        lH0z8EXb/bpQh+Jf8/PuKNI=
X-Google-Smtp-Source: AGRyM1uEEMAc+8FJxLc/mlb8t301IgpWCnjiYLUqgY6m1IDXCYaAeszmfVIolkVxg0Mtj7p66FG3gQ==
X-Received: by 2002:a05:600c:5112:b0:397:53f5:e15b with SMTP id o18-20020a05600c511200b0039753f5e15bmr26724095wms.93.1655755584181;
        Mon, 20 Jun 2022 13:06:24 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id t22-20020a05600c41d600b0039db7f1a3f5sm15482666wmh.45.2022.06.20.13.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:23 -0700 (PDT)
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
Subject: [PATCH 06/49] mfd: wcd934x: Convert irq chip to config regs
Date:   Mon, 20 Jun 2022 21:06:01 +0100
Message-Id: <20220620200644.1961936-7-aidanmacdonald.0x0@gmail.com>
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

Switch the driver to config registers. This will allow the old
type register code in regmap-irq to be removed.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/wcd934x.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index 68e2fa2fda99..07e884087f2c 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -55,17 +55,22 @@ static const struct regmap_irq wcd934x_irqs[] = {
 	WCD934X_REGMAP_IRQ_REG(WCD934X_IRQ_SOUNDWIRE, 2, BIT(4)),
 };
 
+static const unsigned int wcd934x_config_regs[] = {
+	WCD934X_INTR_LEVEL0,
+};
+
 static const struct regmap_irq_chip wcd934x_regmap_irq_chip = {
 	.name = "wcd934x_irq",
 	.status_base = WCD934X_INTR_PIN1_STATUS0,
 	.mask_base = WCD934X_INTR_PIN1_MASK0,
 	.ack_base = WCD934X_INTR_PIN1_CLEAR0,
-	.type_base = WCD934X_INTR_LEVEL0,
-	.num_type_reg = 4,
-	.type_in_mask = false,
 	.num_regs = 4,
 	.irqs = wcd934x_irqs,
 	.num_irqs = ARRAY_SIZE(wcd934x_irqs),
+	.config_base = wcd934x_config_regs,
+	.num_config_bases = ARRAY_SIZE(wcd934x_config_regs),
+	.num_config_regs = 4,
+	.set_type_config = regmap_irq_set_type_config_simple,
 };
 
 static bool wcd934x_is_volatile_register(struct device *dev, unsigned int reg)
-- 
2.35.1

