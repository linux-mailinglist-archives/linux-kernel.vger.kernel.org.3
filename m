Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2DB552544
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344197AbiFTUHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343854AbiFTUG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1DE1F61A;
        Mon, 20 Jun 2022 13:06:48 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n1so15843342wrg.12;
        Mon, 20 Jun 2022 13:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uoe8IKHiznCb2+08YYHq6Yn162+SdkatHT+ONYvtyvg=;
        b=VO5DAnqEeePAwi/axXTy4qE8A246zDDyLHKvfEeupMh4NJS9PKzy2HLbzv2HmLinOh
         sJDew7tvb/Du6JA9+pWT6wLYpZiUruBlDXuUNGniMiaSflxpZ999oM2RPoZbfWY8bM3s
         gls0xbSabfR+zndjmVVe2gZatWsAghFwtSJv7FWIrq2fOl5iZF4ORrEzRPpb9VagUUok
         bzn4DhZTxBTkt686Eof5bwsbZb+iffrPyGoKCrO/d9vttrGG2aS8UHirbaHGBHIZdzMU
         DZCNjjT5h1ru5g19uCfpQwoKH/YS5Rr49DFzT6RKpFmZ5PA1XwoUduGXijcI+1DBXDyM
         XTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uoe8IKHiznCb2+08YYHq6Yn162+SdkatHT+ONYvtyvg=;
        b=ARTfRv8e/xsEWlc5NdolwYAieEyBFvJ5mMrXJ/lRkq8Fno/TXo2cBsto+tA7GFPPSu
         EtHVhR2d0DUgSs2pFThe/5rufDBxjwaMijzJCmV9iy+NRwNeMtB5PgIAnZSVg4GlSjb9
         KMrRfmyfU8qVXandxHe/A42aTVTmfk5FB1Q8cYOXGQK9rWIvp7WgdPRXc+6Phx2Oaryv
         f7G6BKnw1tsKpb/4v+BSFF/FciENTXBBU+OQCJvVbV0M0BxfeIiDyQA59f478VwlqDut
         oSsk9tdnGweXBERfKnoRfy2Mi/j00raFxBHvm6zDYLAbwGchzM3bZ75+cJ2BtzXhNQME
         5CzQ==
X-Gm-Message-State: AJIora9mvSdYAnRQ8vRonyfg7p9swRoD14sh9dO/PPFaOaKekpPaNci3
        XW+mEoNuXzsscK7fECPS0k0=
X-Google-Smtp-Source: AGRyM1uZONrpz0spvVCV2D/AIVMzkFz9w2tp1QWQa34Ft0vrEMdw9wgaS52AsbxHhGWZBMtjoEgiDw==
X-Received: by 2002:adf:fec2:0:b0:21a:6cff:a4f1 with SMTP id q2-20020adffec2000000b0021a6cffa4f1mr18316222wrs.139.1655755607554;
        Mon, 20 Jun 2022 13:06:47 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id j27-20020a05600c1c1b00b0039c1396b495sm16596378wms.9.2022.06.20.13.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:47 -0700 (PDT)
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
Subject: [PATCH 21/49] mfd: tps65090: replace irqchip mask_invert with unmask_base
Date:   Mon, 20 Jun 2022 21:06:16 +0100
Message-Id: <20220620200644.1961936-22-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/tps65090.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
index bd6235308c6b..e474e1ca253a 100644
--- a/drivers/mfd/tps65090.c
+++ b/drivers/mfd/tps65090.c
@@ -127,8 +127,7 @@ static struct regmap_irq_chip tps65090_irq_chip = {
 	.num_irqs = ARRAY_SIZE(tps65090_irqs),
 	.num_regs = NUM_INT_REG,
 	.status_base = TPS65090_REG_INTR_STS,
-	.mask_base = TPS65090_REG_INTR_MASK,
-	.mask_invert = true,
+	.unmask_base = TPS65090_REG_INTR_MASK,
 };
 
 static bool is_volatile_reg(struct device *dev, unsigned int reg)
-- 
2.35.1

