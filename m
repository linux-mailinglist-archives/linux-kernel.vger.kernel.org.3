Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C9E55252E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344156AbiFTUHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343818AbiFTUG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041B81EEFF;
        Mon, 20 Jun 2022 13:06:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id q15so6374723wmj.2;
        Mon, 20 Jun 2022 13:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F4wATPKotQB5JDuhaBZ5Jb5Nh8kCkmxeR4cD85ob0jA=;
        b=e+BrKFyUAEKrBpsdiTI0hXdQRnQfzScB8duoVAuFg+GJ0Jh4zZD5Q/yH5NsPA1D9fK
         uaNwGLpdVywtGRLROPl5tTxFT7A8jPHaWbjaPAMdsjcQoj2Fxm0OgNstaADl0insuEPU
         P50NDcoj6V57762q+5c86res9ZHtgVjfYyuGy0xSGWhhHkfr1HpoVpzrKy1Z/3zFEUFZ
         67Fh85T75VnGSm9kPme9xBV7w8ac712S9ul2GLnNaWtQDEdomD1S1aBv1jYpvYeu5a7r
         MGwYhNujO4gNlNbVwu8A+bWELyeb6pNXvwP3xhw3JTzKit4mY+kzcbb6HrnaUC5RjRIY
         8xkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F4wATPKotQB5JDuhaBZ5Jb5Nh8kCkmxeR4cD85ob0jA=;
        b=0H+Q1xMDLttWjRL88b9dOqGzgvs+6yX2YEeysL8YbULx2cMfRYA1Q7/yY7jrvTBnoj
         6uiD+psjTT8MPMynMddkJoZYxNQBEbEBsz1s6DkLKS0hjJC3HSyAw/Ihz7Y2k3FtuXBc
         UOBkjAQZv2p+dUCmudo3G6OKbsjc40At5fY93/w3S0xVN4FNZOhrhsuoEF7fY1+N137r
         z8bYerLXxlfysyFtWpapiWCxUYGexixzVKmi3yRyDug9wNIZFxD2DfqhSMdNCkvtiL1K
         NzmVaDsNI5QMpo/xECuvNVTSh3jI2HOsv5UKLJufflD9BRNHtAvXZgst43JIQ1FH6NoJ
         bVOQ==
X-Gm-Message-State: AJIora9evc7Dz3dXcc2MIx7oisXsP2c3ZapB2Zejif3SaOR+TIitm6TU
        pjNo45kR+ffjvXcdaW/kkI8=
X-Google-Smtp-Source: AGRyM1viZL39dZzsNTWFK1Nii5H/dfYG1kHfbnLLGc84T/J91auGii4XODLgdHEKlU2wd9OGVZncsg==
X-Received: by 2002:a7b:cc8e:0:b0:39c:829d:609b with SMTP id p14-20020a7bcc8e000000b0039c829d609bmr27634897wma.160.1655755604433;
        Mon, 20 Jun 2022 13:06:44 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id y16-20020a5d6150000000b0021b932de5d6sm2486492wrt.39.2022.06.20.13.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:44 -0700 (PDT)
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
Subject: [PATCH 19/49] mfd: stpmic1: Add broken_mask_unmask irq chip flag
Date:   Mon, 20 Jun 2022 21:06:14 +0100
Message-Id: <20220620200644.1961936-20-aidanmacdonald.0x0@gmail.com>
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

The STPMIC1 has a normal "1 to disable" mask register with
separate set and clear registers. It's relying on masks and
unmasks being inverted from their intuitive meaning, so it
needs the broken_mask_unmask flag.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/stpmic1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index eb3da558c3fb..2307d1b0269d 100644
--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -110,6 +110,7 @@ static const struct regmap_irq_chip stpmic1_regmap_irq_chip = {
 	.status_base = INT_PENDING_R1,
 	.mask_base = INT_CLEAR_MASK_R1,
 	.unmask_base = INT_SET_MASK_R1,
+	.broken_mask_unmask = true,
 	.ack_base = INT_CLEAR_R1,
 	.num_regs = STPMIC1_PMIC_NUM_IRQ_REGS,
 	.irqs = stpmic1_irqs,
-- 
2.35.1

