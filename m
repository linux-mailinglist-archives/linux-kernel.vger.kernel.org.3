Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7986F552537
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344209AbiFTUH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343707AbiFTUHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:07:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891522AF8;
        Mon, 20 Jun 2022 13:06:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g27so9432647wrb.10;
        Mon, 20 Jun 2022 13:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gBD4FGBJfr7WfKu1UZU1bV8IB7E8/qXlLxTviEK1Akg=;
        b=n+dv2OHyeLcXNTmM5AoQ5y71hnTNJIpcERPeXRAZGzH3I/VENsQCVHYqLkDxbEjmN/
         TTkfawWz7sGx1fEvNmiL1zWs5fqtd8PmEYJ/uuxwTzmlN3TNWDIjfT7h7X2oiiCeJDJo
         G0D3xiO8ep0dRDPxWfA7mglV2rl0lfdiXs/NgfHf3uClxo2T0zSzKmcugT014uVsbBA4
         a8d72hUTWqP7aMSTkN4E6jMQH1AsJpvanWTcr/TzYICesUohxeYCLmlbHF8Or3sDiq5E
         ReozveZPFU1OGId9YBAanmpEq2oZ6/HDOKmehZPgromaOnVKCB0W7RktevOubR0I+UbT
         T3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gBD4FGBJfr7WfKu1UZU1bV8IB7E8/qXlLxTviEK1Akg=;
        b=6JH4+cctLqHH39ZSncHjlYvz7fHrD2P4QvazMTeS/I1Rouk/bXlw4hMa0r/ecrvcDK
         vXaw42S3fbeGqUQit+0T0D5fZFIv2O8cNIbnzrhy/o413glsgYYoLLcgep35sjbN+DDL
         PcZM2TLr9i69r/wBdfG9LFdv8YgsTbgWaM0ZO1idKNy0XVzv5FCcfyrfkbHyVvQLVdQa
         MB3t7NoCyLCDw0NkW78Gu8xpGi+GiakMzsmPyscD+74SKIYSgtmd1/IEJ29Y7A5DWUdM
         xWGoH66jP112xTcpbn0vbK8bURJepPV4KsDvUQqrubKvVqQXvTahLFlhvJFjh6veMHJT
         BD6A==
X-Gm-Message-State: AJIora9HaLrt1lkIWfy+llcTkImkWaPCKCwECbr0stZFa4kkhxDooLsT
        vqo8G6afu8OGhM58rDzkIBY=
X-Google-Smtp-Source: AGRyM1ueeTVj4W+irPUqcFh4aibJZGRQv0luVUmTWKHSamp2328uXg/JWH281sGfd9zcwAAoGkXCMQ==
X-Received: by 2002:adf:ae09:0:b0:20e:e4f0:2133 with SMTP id x9-20020adfae09000000b0020ee4f02133mr24684442wrc.104.1655755608969;
        Mon, 20 Jun 2022 13:06:48 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c4f0900b0039db500714fsm16981828wmq.6.2022.06.20.13.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:48 -0700 (PDT)
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
Subject: [PATCH 22/49] mfd: sun4i-gpadc: replace irqchip mask_invert with unmask_base
Date:   Mon, 20 Jun 2022 21:06:17 +0100
Message-Id: <20220620200644.1961936-23-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/sun4i-gpadc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/sun4i-gpadc.c b/drivers/mfd/sun4i-gpadc.c
index cfe14d9bf6dc..edc180d83a4b 100644
--- a/drivers/mfd/sun4i-gpadc.c
+++ b/drivers/mfd/sun4i-gpadc.c
@@ -34,9 +34,8 @@ static const struct regmap_irq_chip sun4i_gpadc_regmap_irq_chip = {
 	.name = "sun4i_gpadc_irq_chip",
 	.status_base = SUN4I_GPADC_INT_FIFOS,
 	.ack_base = SUN4I_GPADC_INT_FIFOS,
-	.mask_base = SUN4I_GPADC_INT_FIFOC,
+	.unmask_base = SUN4I_GPADC_INT_FIFOC,
 	.init_ack_masked = true,
-	.mask_invert = true,
 	.irqs = sun4i_gpadc_regmap_irq,
 	.num_irqs = ARRAY_SIZE(sun4i_gpadc_regmap_irq),
 	.num_regs = 1,
-- 
2.35.1

