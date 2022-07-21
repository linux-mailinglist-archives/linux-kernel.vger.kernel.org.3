Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1102857C8AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiGUKNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbiGUKNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:13:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3490743E1;
        Thu, 21 Jul 2022 03:13:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bp15so2323800ejb.6;
        Thu, 21 Jul 2022 03:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6f3mIWXiAzo1mJeZEybIuFn6qGgQI7G+EgnjKVOR7uU=;
        b=ML8vUnPITuwwDOgosqSNiFGavktq7CUFvIlcrhoWxzLDzr83aED6K1RcCXQUGxNlgK
         k9PreOcejk1nuPw/INF8fWpgAnru8i6IjPV6ZkIMsHUx9sF4HCqsW4SAYP/mStgcGDJx
         UF6BFAUEZiR5xNSJ1SodYPFZnHG/Q9oUZ/pgZJaoqljcBxtYpwCNeaxXOo16yxBTzFl4
         ihddgOpzD7ljgFbjORONV61OQFxbVBD9Yd3XW052cWwLmcMw6yPQcBglpaPDdptFYV1o
         KPG+GuTX90IJmX4z8vhVWECE1qQjgoVrUpkR9wayHTwEk/RyAnzlutFa+3fTVdIPSEs/
         6d2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6f3mIWXiAzo1mJeZEybIuFn6qGgQI7G+EgnjKVOR7uU=;
        b=S/NvYcBrQ/fOrFgoxGAB67XyBwdi9eSaoUJluI42bDFrSD+KwzyWqGk4estZiFB2V9
         0kevmAll8rI07vVtuKkIzY1eicJIXQnjrG7C+T3aTh1dHfU1vAu/CLoKqiqdWbwBd+U+
         lCwX6cUYlj7yT70OmFLIsNqfvLOcxt39r6IidG/HyFxAVxiCuuK5zPqKYiU0PXYOvH3W
         8sBmhXIrpoYCpsqFP0COBNBEATrl8OGlQ72IXiTco60Bv+gbd67NEFxGVvRW1rPfshG2
         CxMhiJ2GskX/5Q5HPatqkhXvGKBF/k2XR6CkD3Hb9WTHU5yTMCme9PCm1lyovXmeIHgE
         hAtw==
X-Gm-Message-State: AJIora/EGM+oAsn9TwJ6yShm2K82Llib9QuiU7eRfkpbAsCNWSa7FTC4
        Y6NcO6eSgnxw5+tvXTwsvB7MNLHboKY=
X-Google-Smtp-Source: AGRyM1sQbUlMUHbftjmvExI1vm1+iVp2D2Sbn2momx6NlwErm5Nk2jpLynEyIjDajE60H8ooJhjHoA==
X-Received: by 2002:a17:907:3d87:b0:72e:dcfb:5ca7 with SMTP id he7-20020a1709073d8700b0072edcfb5ca7mr35038381ejc.586.1658398391343;
        Thu, 21 Jul 2022 03:13:11 -0700 (PDT)
Received: from localhost (92.40.202.7.threembb.co.uk. [92.40.202.7])
        by smtp.gmail.com with ESMTPSA id i8-20020aa7c9c8000000b0043bbf79b3ebsm722122edt.54.2022.07.21.03.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:13:10 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH -next] gpio: sl28cpld: Replace irqchip mask_invert with unmask_base
Date:   Thu, 21 Jul 2022 11:14:16 +0100
Message-Id: <20220721101416.18129-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following recent changes in regmap-irq, unmask registers can now
describe inverted mask registers where a '1' bit enables an IRQ.
Because this implements the same functionality as mask_invert and
is more straightforward, the mask_invert flag has been deprecated.

Update the driver by replacing all uses of mask_base & mask_invert
with unmask_base.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
This patch depends on the "regmap-irq cleanups and refactoring" series
which (at time of writing) is already in linux-next.
Link: https://lore.kernel.org/lkml/20220623211420.918875-1-aidanmacdonald.0x0@gmail.com/

 drivers/gpio/gpio-sl28cpld.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-sl28cpld.c b/drivers/gpio/gpio-sl28cpld.c
index 52404736ac86..2195f88c2048 100644
--- a/drivers/gpio/gpio-sl28cpld.c
+++ b/drivers/gpio/gpio-sl28cpld.c
@@ -70,8 +70,7 @@ static int sl28cpld_gpio_irq_init(struct platform_device *pdev,
 	irq_chip->num_irqs = ARRAY_SIZE(sl28cpld_gpio_irqs);
 	irq_chip->num_regs = 1;
 	irq_chip->status_base = base + GPIO_REG_IP;
-	irq_chip->mask_base = base + GPIO_REG_IE;
-	irq_chip->mask_invert = true;
+	irq_chip->unmask_base = base + GPIO_REG_IE;
 	irq_chip->ack_base = base + GPIO_REG_IP;
 
 	ret = devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),

base-commit: 353f7988dd8413c47718f7ca79c030b6fb62cfe5
prerequisite-patch-id: a45db1cac7537769dc10087fc61f977dc150744c
prerequisite-patch-id: cb8aa009c7bb7a6575eb05e3af65342dc8d0efa3
prerequisite-patch-id: 8d32557e53b894d1fb17250d2d0eb3673f068d37
prerequisite-patch-id: 5b293867ef81e3697892ac51b941bb53680a70dc
prerequisite-patch-id: 8138d39a4817e804141bfe8c2ad37d9c55456a40
prerequisite-patch-id: b01216129e887519d441cf556bbc75c397871773
prerequisite-patch-id: b5dcf0c0609113c2d81bc557c1fc95ef23f40811
prerequisite-patch-id: 622ca1c10e851b1889aaa567c1d2a0adf43cca44
prerequisite-patch-id: d28c5187f9bf0e43f27b2f4aa8dcf7fd91842a03
prerequisite-patch-id: d29d54b756be73304f844abeeaf9b46a5c0119d5
prerequisite-patch-id: 5d405790ae89c0831b46a359f86e94bac5a67470
prerequisite-patch-id: c90120e79acbb52ffa148bfedee1df9d35b5eced
prerequisite-patch-id: 2e35247a5cfe5a28565c9272b85fc6835011b032
-- 
2.35.1

