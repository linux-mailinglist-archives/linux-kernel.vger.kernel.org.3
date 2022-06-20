Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B3C55252C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344420AbiFTUIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344056AbiFTUHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:07:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC67219C2E;
        Mon, 20 Jun 2022 13:06:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q9so16080258wrd.8;
        Mon, 20 Jun 2022 13:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dZq4DXS5hfuZufkfinYetDi/sPSwHy1FNwiaqhpssa4=;
        b=bpjyLwVivcFSW5QVbgosK/o2QuZHms1vCc6tC1sGza+OT1YZWe465cW4jNRW7fx4ks
         msy9Ia4HJKGcKj1u1StthDIoGNe0jPNNRCwfixCCbhsIu8kl5EdbhBkaAOJGTjzxLAZf
         Bv9bbx8NKTphmbx8bemLzrtymECuH5WWFEStWDPJlp6dqluOf0EOgjov5G1nTwcbn/99
         6V1IcwQ/cUBFnAQ+UHfvGn1YssCCtL98+3EotWIqSk0wFS+MMtuhmD5WuWOcv9MXK3SK
         oL+O91AqJHe+kT2bNOas/VelkJQaxBD6di93/z4nY9iPMcMc3LCgHQ1sLEmd+cWZ+9Od
         WH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dZq4DXS5hfuZufkfinYetDi/sPSwHy1FNwiaqhpssa4=;
        b=HdmHxVTPTBR7cIEVo6Vb8PiCouXmbAa0QOv83Ej3FHtQLHAurBx4VvlfU1YRJtKrMh
         ahzbeU0vpYeqJav+L9XmL/plcl7Oa7R7vHUCc3nOzmdu4MiOZ8IXxP81PMxPkjYpYoNc
         rJ5qPv0eozy/VfxbmSMJ+L1Y5A4zkPfz7gXvwkkdT8MZShSGp/EVQvDfnmw4VT4OOM+2
         hj7r+a1oceWVExJ4WXc2Gc+lyOlQYM8G8cNXyzMtbViHC46R/UXTj7tCo0mY2jllLZLd
         y+fdkyo5EDwGhJmLVsgK1XaU0bE7WgNrnN7eI8LNWFaGIb2IkMzquzbs/kgidc/2LOWE
         IPVA==
X-Gm-Message-State: AJIora9GbpKrc8k/Zr8ttGv2m3brVc44NASogY3cOgWEhHakgt8bxCHZ
        L0+f96IEHDiWrjLoeEEtW08=
X-Google-Smtp-Source: AGRyM1uUe+TJYcYrAuoAsTQoql0GG3zgxE4cm70M4L11J/HjtjuiCzoxQPxyTkB4HBjRJYR8SssVEQ==
X-Received: by 2002:adf:fb06:0:b0:21a:3dc9:f12d with SMTP id c6-20020adffb06000000b0021a3dc9f12dmr19252192wrr.204.1655755617100;
        Mon, 20 Jun 2022 13:06:57 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id x1-20020adff0c1000000b002103cfd2fbasm14315943wro.65.2022.06.20.13.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:56 -0700 (PDT)
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
Subject: [PATCH 27/49] mfd: gateworks-gsc: replace irqchip mask_invert with unmask_base
Date:   Mon, 20 Jun 2022 21:06:22 +0100
Message-Id: <20220620200644.1961936-28-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/gateworks-gsc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/gateworks-gsc.c b/drivers/mfd/gateworks-gsc.c
index d87876747b91..28ec167a9861 100644
--- a/drivers/mfd/gateworks-gsc.c
+++ b/drivers/mfd/gateworks-gsc.c
@@ -189,8 +189,7 @@ static const struct regmap_irq_chip gsc_irq_chip = {
 	.num_irqs = ARRAY_SIZE(gsc_irqs),
 	.num_regs = 1,
 	.status_base = GSC_IRQ_STATUS,
-	.mask_base = GSC_IRQ_ENABLE,
-	.mask_invert = true,
+	.unmask_base = GSC_IRQ_ENABLE,
 	.ack_base = GSC_IRQ_STATUS,
 	.ack_invert = true,
 };
-- 
2.35.1

