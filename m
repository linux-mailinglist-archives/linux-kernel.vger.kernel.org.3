Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EB85524FD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245626AbiFTUGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245505AbiFTUGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342AD1DA42;
        Mon, 20 Jun 2022 13:06:26 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n1so15841978wrg.12;
        Mon, 20 Jun 2022 13:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rwq1xrraD4RZAx2kCX1gT4beeMnmuxO1mM9UwNM/j94=;
        b=QNECaX952+TTlSLlpOVs/6XitpxYvWRdZb+grPlyuTrwlpraID/DEO7pF7pRWsRnhg
         hjsEeZ5QkVN79568dtxIQ2IXGLbC5nR7sF+MgWAVMh5hkBWMw0P53fMMGZkmjvLcFNNa
         dhUutUl0wGwONV7Kom3uv28INHcBCYzOkQGuNSDENRNw1sxJZQ0/eMfiA/Qgxb87L4I8
         /Ptke0D3H96sRWpppziAeYZU/tnFck/UsfeMN/LXYqm2I78lehUvPTyO3hQ8x4y7ScUk
         uchno9kgBiWN8XY4/R7yf92muZ6rRsjh0pZSVJsyikq3CxlSVWLF/qU3eR8EP1K+XGbx
         gjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rwq1xrraD4RZAx2kCX1gT4beeMnmuxO1mM9UwNM/j94=;
        b=LmFCvrh6VeLGZ6jK7/A5n2FaSznmyoL8UVdXP1K+RezCRHoiwT+rv3Ya7xKbksuDC0
         TIL1wijWv7BB3WEa4d+dOqr2Y8UbpFz8sdElLf9BfdZ8fZFnZ9kS3NeNolpQ+Q1onzg6
         6D9fD/VJ2VzElTHdD73f3rkmKL04oVKtcvIHgkzwbEbg0fyGWI03jPqNxdn/QHsGgwe/
         Jyj6ST513m3Zgvw0UiFzsk167X+2ivBE1CZqMosAmvP3AmX7SO2Z33kIlacP7UNPk5di
         g67Kt2bdaK/7+2dFfVccW11/KEZA1cIExM38n45LnZjSCERotRG1i10a4XZxMb0ky4WT
         ZZJw==
X-Gm-Message-State: AJIora/MBS6rSENsJc5aPZpV2O5XizhisFrkdACBQL1xXL2Wu+DOqRPJ
        t4zHgvjpbARAPEGu96h25rU=
X-Google-Smtp-Source: AGRyM1tP2UDTugiqATrashu5vRyEcZXwb3725FZvBb5Omwk2LFohTTxHAY3xss+vpJU1LZ+f8ik2aw==
X-Received: by 2002:adf:ef42:0:b0:21b:8e58:f24b with SMTP id c2-20020adfef42000000b0021b8e58f24bmr7537796wrp.257.1655755585865;
        Mon, 20 Jun 2022 13:06:25 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id u3-20020adfeb43000000b0021a34023ca3sm13936104wrn.62.2022.06.20.13.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:25 -0700 (PDT)
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
Subject: [PATCH 07/49] sound: soc: codecs: wcd9335: Convert irq chip to config regs
Date:   Mon, 20 Jun 2022 21:06:02 +0100
Message-Id: <20220620200644.1961936-8-aidanmacdonald.0x0@gmail.com>
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
 sound/soc/codecs/wcd9335.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 617a36a89dfe..727d4436142a 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -5020,16 +5020,22 @@ static const struct regmap_irq wcd9335_codec_irqs[] = {
 	},
 };
 
+static const unsigned int wcd9335_config_regs[] = {
+	WCD9335_INTR_LEVEL0,
+};
+
 static const struct regmap_irq_chip wcd9335_regmap_irq1_chip = {
 	.name = "wcd9335_pin1_irq",
 	.status_base = WCD9335_INTR_PIN1_STATUS0,
 	.mask_base = WCD9335_INTR_PIN1_MASK0,
 	.ack_base = WCD9335_INTR_PIN1_CLEAR0,
-	.type_base = WCD9335_INTR_LEVEL0,
-	.num_type_reg = 4,
 	.num_regs = 4,
 	.irqs = wcd9335_codec_irqs,
 	.num_irqs = ARRAY_SIZE(wcd9335_codec_irqs),
+	.config_base = wcd9335_config_regs,
+	.num_config_bases = ARRAY_SIZE(wcd9335_config_regs),
+	.num_config_regs = 4,
+	.set_type_config = regmap_irq_set_type_config_simple,
 };
 
 static int wcd9335_parse_dt(struct wcd9335_codec *wcd)
-- 
2.35.1

