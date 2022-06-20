Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A290755256A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344681AbiFTUJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344687AbiFTUIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:08:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6B521829;
        Mon, 20 Jun 2022 13:07:27 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v14so16099319wra.5;
        Mon, 20 Jun 2022 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drtbL6Ol3nSvJosEWn6BWyNAP++5ZasjbOfmzop3MZQ=;
        b=QjvV+I2LY/VPVY45eWYJLbt7si9DgUbUdBiK1tnDmgIOAGcJlPEfPEbz0xPv6PFG6C
         fqwpwN657JaXPxJXBP5AOwcKcjfbM0nFCo3ly+/TCctIcxL8Ez9srZzj3C6ZbVZaRiqz
         JbpxIf/a/wjakAyd7TsXsc3ArAii392QnIxa2RXb5I35fEt59JdMD+jqhaGkdRCDDnM/
         pAKKZGaQWk1j3re/9CnNYt5bHRviVWNWQz6tjo3Kf2EI4KjNuph2+cI7M7xbk0fkDW+c
         fBjVbekqWUfyD7IfdeqH1QuljKLVCEXC/+72mhEJsa01pPfOg9ygPXXe7cysaPnB7z2q
         C0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drtbL6Ol3nSvJosEWn6BWyNAP++5ZasjbOfmzop3MZQ=;
        b=5WqnUZTXB1ng2Vx9usv3Kqhf37etv0qY0djhqOVi5EKFsO+d2FGs4VYQjbDo6hxqgw
         TKMCFxmFk8TQLz+EIu8cYjPfG4oyYOzi6OPm86kLpkp/JLzro2bcWdyw5n/58QzZ85Py
         MHpXJnf1XxM2pIpFTclWD6OWm+SYaM5UbH8QYvAjIFU3zWE59QlV7/mUIOEvN2V8ctJ7
         g9ZNSi6CXtXaethagrGKx9e3Tkcq+VMJNLjzmr3g4Psud4QqPBsqznD41YvspYNh0Y5M
         N0QOHKhci8LkW4hgd3LuVnmmCjuawF1TvOcVAq27a/vsLOf3lDxSoCFbiKHqr+X+xzxS
         /o6Q==
X-Gm-Message-State: AJIora97VzCDT9OE7PjTKnyW0bjD85uhZ8v8rSK6C5Po1cTM83zX2qbm
        MVzY/VsZWoOV0mmfj3Qk0ZA=
X-Google-Smtp-Source: AGRyM1upACNZTooDfHG9XrmiWJXxBNAesYYQbcORquUwOuEJ3OJEEk57wgHnkZp1ZcThb45MTPunjw==
X-Received: by 2002:a05:6000:1788:b0:219:e28f:dc98 with SMTP id e8-20020a056000178800b00219e28fdc98mr24527156wrg.144.1655755639378;
        Mon, 20 Jun 2022 13:07:19 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id c130-20020a1c3588000000b0039c798b2dc5sm19765399wma.8.2022.06.20.13.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:07:18 -0700 (PDT)
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
Subject: [PATCH 40/49] mfd: stpmic1: Fix broken mask/unmask in irq chip
Date:   Mon, 20 Jun 2022 21:06:35 +0100
Message-Id: <20220620200644.1961936-41-aidanmacdonald.0x0@gmail.com>
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

Swap mask_base and unmask_base, and drop the broken_mask_unmask
flag since we're now expecting the registers to have their usual
behavior.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/stpmic1.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index 2307d1b0269d..11f3d92acbc0 100644
--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -108,9 +108,8 @@ static const struct regmap_irq stpmic1_irqs[] = {
 static const struct regmap_irq_chip stpmic1_regmap_irq_chip = {
 	.name = "pmic_irq",
 	.status_base = INT_PENDING_R1,
-	.mask_base = INT_CLEAR_MASK_R1,
-	.unmask_base = INT_SET_MASK_R1,
-	.broken_mask_unmask = true,
+	.mask_base = INT_SET_MASK_R1,
+	.unmask_base = INT_CLEAR_MASK_R1,
 	.ack_base = INT_CLEAR_R1,
 	.num_regs = STPMIC1_PMIC_NUM_IRQ_REGS,
 	.irqs = stpmic1_irqs,
-- 
2.35.1

