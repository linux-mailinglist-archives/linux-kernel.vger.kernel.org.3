Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2656552535
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344227AbiFTUIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343717AbiFTUHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:07:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFF31FA75;
        Mon, 20 Jun 2022 13:06:51 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z17so6380192wmi.1;
        Mon, 20 Jun 2022 13:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=83f6yOVGHF33wbJFNUqHVsMRQC83Nm7l3Jffulf5Q20=;
        b=nSss6m1iZMp9y7Vv5974YLuhhJUZ614v32RzAfng7nP1DgOtE0Apdk3S4hwIYaOcx1
         golYgrNSS7bRWfwoAUSA5Og7WysO98jLMv2W9IlYLvHZnPWxMcZHBnXlEYNbFGYXAe4h
         zkX/QFUpTqAkwk57wIfRoBajgsGcPIRZsVFEZEBTCfHJUtpgAuIwl1tCoiFICvSGYFcM
         iW1sdZy6IBsByUO4a0aRbsf/NzuzhMMy7unrWxcauagegTS75O7aSHLZgHRYpLH0BAZ+
         4ZZseSMNKYwbZHqZFgQqC8T4HX4zh6g3gg0Rzx4vx6r8K2qxxQIrzGRKLh03m3NFkovC
         6bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83f6yOVGHF33wbJFNUqHVsMRQC83Nm7l3Jffulf5Q20=;
        b=Xen39+zDYZDwRRSCL/AJnCMYpnwT8HSxVtpG639vfi991INStdMTTQHZ7MjCuOcm7Z
         TRsX0WEl003VMjITOqfC7S+8w9aL5cRVPkVdZxnsInELtm9WGuqK6dNviXiL0dueOvGM
         TRF66gDa+AE9eNLMM+Fv7CcT39L3+PmeR3fBsKb/ljqqwE+u30RzDUONOPVjJCAdSt4T
         6fp70olXqxN4euoi1MRU7c1CKr5VVhB25brCKD9yDQqmgu0GeUWF0N/5BeYzQluiZ987
         cxYFd7IruCsvyWn5vGdVg6Fx6z5N8fPG98/rgaykOk6xnCWUkF1qvSXpZsKqf+DzQeDl
         7idQ==
X-Gm-Message-State: AOAM533u76y/lq3FWLMtCc39af0+LvpG0Y9Mxhnd9+LBOBg1QYrLfARC
        oBFnZjp5QO3BK1/kJZc3MU4=
X-Google-Smtp-Source: ABdhPJy5hxDd4tBIdG/h7CHZ7zMWEzJh0oBujvFGRYSxBfUs0KG9/aftZhFj9CMuaUDM6O3W6BLpoA==
X-Received: by 2002:a05:600c:1547:b0:39c:7fc6:3082 with SMTP id f7-20020a05600c154700b0039c7fc63082mr36832709wmg.189.1655755610410;
        Mon, 20 Jun 2022 13:06:50 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id cl10-20020a5d5f0a000000b0021b92171d28sm3418468wrb.54.2022.06.20.13.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:50 -0700 (PDT)
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
Subject: [PATCH 23/49] mfd: sprd-sc27xx-spi: replace irqchip mask_invert with unmask_base
Date:   Mon, 20 Jun 2022 21:06:18 +0100
Message-Id: <20220620200644.1961936-24-aidanmacdonald.0x0@gmail.com>
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
 drivers/mfd/sprd-sc27xx-spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index d05a47c5187f..a4a9b81a952b 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -181,11 +181,10 @@ static int sprd_pmic_probe(struct spi_device *spi)
 	ddata->irq_chip.name = dev_name(&spi->dev);
 	ddata->irq_chip.status_base =
 		pdata->irq_base + SPRD_PMIC_INT_MASK_STATUS;
-	ddata->irq_chip.mask_base = pdata->irq_base + SPRD_PMIC_INT_EN;
+	ddata->irq_chip.unmask_base = pdata->irq_base + SPRD_PMIC_INT_EN;
 	ddata->irq_chip.ack_base = 0;
 	ddata->irq_chip.num_regs = 1;
 	ddata->irq_chip.num_irqs = pdata->num_irqs;
-	ddata->irq_chip.mask_invert = true;
 
 	ddata->irqs = devm_kcalloc(&spi->dev,
 				   pdata->num_irqs, sizeof(struct regmap_irq),
-- 
2.35.1

