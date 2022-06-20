Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD288552571
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344537AbiFTUJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344480AbiFTUI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:08:26 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B7B1EEEE;
        Mon, 20 Jun 2022 13:07:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so2062728wmb.5;
        Mon, 20 Jun 2022 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJAftx/p0C7OJqXldJ+ksCvuM2Jz1/dLJXnCMlN2VIw=;
        b=SqSwnGBcriuBOSFplaryTgzwQV9etoBhh79kFYweRlmDdxQeRvrcZhZxeGzYrNQvjK
         69NE66snB8AAFxosGQi32hwg8wAh/0UlVrRlylnlYpF3UP2foQigCMMdDJ2hf1VoUcQw
         IGJhoucIfU9bShmNTRIW7SeERFLMl9SzWwa/gkuyhaNnZGAegN5/b8AD7xgZbr+q96V3
         wIZE74xoK0opWS9DO77kd+xhhjv05vYGMC2P4dGUBy6pWp5QiJg6JRI3NjoqvsL5Fuv7
         /rYrzhVG+vkyLBPngH5EcdERxjCI3qHqaUK8MI70z8mDb7VK4k5Utxh9mIEOvpvvGk/6
         VkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJAftx/p0C7OJqXldJ+ksCvuM2Jz1/dLJXnCMlN2VIw=;
        b=Otq8M6+42b71o3G3Q3Rvo1ZkViaqyr87cDw5mRcyeKX9Zn1ocRW+PwqfCWBJkoz8L4
         4msQqfgoswgV95LK7YxozpRgdak4Aj/HKG9fp+xmljeLZMQ90oJ9hWOwAJULE8Cz22eU
         MMhSTXW9WK4rG28vgefhJutuZkl7pbYJtgCAJwCSHQrCLTICtZ6iP42VsVNLLHhAfyDX
         TrKbmWufV6RP9UmIMauBDJ1Bn1z8Q2SshaLw8hDbjQ7392/VQbgR2gtMwWjaxGnjI7bO
         /5av8+TMwaLlvKCml0BVSJ09aezcrbeeCguMZlhQuxSvbBzhTmtTOfSqm2n0LjcFjHM1
         t+ZQ==
X-Gm-Message-State: AJIora/XUR513u3XzLqCQxbWKHr1gAzUzISEhfknHGY3r8Jx0l9/E6uC
        XI/Mc926bbZngZlSvHWeLGkAahpGYH4=
X-Google-Smtp-Source: AGRyM1uYqQE7GmYoWseO34ZpgDLrPdxmQJYvkYR87njx8ZglDl7MI8oKPbgMJxyF1RluTFoj9tUheA==
X-Received: by 2002:a1c:c909:0:b0:3a0:1725:619d with SMTP id f9-20020a1cc909000000b003a01725619dmr5451578wmb.19.1655755629537;
        Mon, 20 Jun 2022 13:07:09 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id q7-20020adf9dc7000000b0020cdcb0efa2sm7500229wre.34.2022.06.20.13.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:07:09 -0700 (PDT)
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
Subject: [PATCH 34/49] mfd: max77843: drop useless mask_invert flag on irqchip
Date:   Mon, 20 Jun 2022 21:06:29 +0100
Message-Id: <20220620200644.1961936-35-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/max77843.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/max77843.c b/drivers/mfd/max77843.c
index 209ee24d9ce1..4da58eab1603 100644
--- a/drivers/mfd/max77843.c
+++ b/drivers/mfd/max77843.c
@@ -59,7 +59,6 @@ static const struct regmap_irq_chip max77843_irq_chip = {
 	.name		= "max77843",
 	.status_base	= MAX77843_SYS_REG_SYSINTSRC,
 	.mask_base	= MAX77843_SYS_REG_SYSINTMASK,
-	.mask_invert	= false,
 	.num_regs	= 1,
 	.irqs		= max77843_irqs,
 	.num_irqs	= ARRAY_SIZE(max77843_irqs),
-- 
2.35.1

