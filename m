Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7108857C8C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiGUKQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiGUKQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:16:22 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE248211E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:16:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w12so1513197edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=st0E36+WH2TqKccPLbW7n5jqteOUV+oadrqrZV8+maY=;
        b=gEn0GtVgw+R7z07+dLImpJjUzbn8WfKfKpHdOe67wl6m+8/h0JTpaTS/VkD+3sgHwH
         VM/xVh0z+BQLiG2gDMBmclI32qzNzh1NNHEOEYhMO6URt7CCToSdfTW4HQA8ZGRJHe8e
         ChuhZgRH8/+EjmOI9xq5s2LCj63kcsWrxvHDD69OrwFOYaGO217ZcMf4DPUlKtqgDX4D
         +qNr3as0jOKlIdJMZ/Gjkikx9ddpI26PSZbmNTzYF6jf1cXG1EDST/ZHDWh6Enosjq9J
         46DUqDu4odqPl7EWt9VfncVmeBVQJshxVr4siZtxSTIMQKYaLDCbrs5zSvKFwokFMbmr
         rKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=st0E36+WH2TqKccPLbW7n5jqteOUV+oadrqrZV8+maY=;
        b=YpPSG6A3YSo6mYQVypsUgq7uzSyW4PjP6lvTSEgH6oEZ34COeER/VByKaLmvv/fUFh
         yOkChTfgZUhUpDfw9VNEu1B3Fz7Ue9W3jJUKCu1GyjJWBWfd12Z3WMqNpLgyF0dZMBZW
         ZqEuZrIvCrdYCxnS37gySHUXFqFi430GcBedHUj+N1f/j1FWXFz/kw92/rf1wMJMtYKA
         9EIoa0k1h0+z8sweaRDzEVocLnY2qOVPOgNuXxYb9eo+u7A/WXwPyOY8XufYdCAFDplJ
         6k8Rmgw4wl1+LkeRC8kp+sJ2lC6TcSDsLmTk+cQxetTyqbHmmIjfQstsWwyBlvuWTzyw
         xMyQ==
X-Gm-Message-State: AJIora+JwPk7A6FnYLYlEYv8K88TYXAp6XZ3yrpJTHaNOUt2J8+DxXk+
        /Hc2YSIJHwdrtK2fVCmOrIXXX41I1GE=
X-Google-Smtp-Source: AGRyM1tXS+/MaKoa4XQlPybTpKSFJS2+bH978lIvyNNNrLesWzvENWM5WkZBpeCySjt+3d9rlZAy+Q==
X-Received: by 2002:a05:6402:1772:b0:43b:b794:87f8 with SMTP id da18-20020a056402177200b0043bb79487f8mr10206588edb.237.1658398579854;
        Thu, 21 Jul 2022 03:16:19 -0700 (PDT)
Received: from localhost (92.40.202.7.threembb.co.uk. [92.40.202.7])
        by smtp.gmail.com with ESMTPSA id nc19-20020a1709071c1300b00722d5b26ecesm653708ejc.205.2022.07.21.03.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:16:19 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     tglx@linutronix.de, maz@kernel.org, michael@walle.cc
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH -next] irqchip: sl28cpld: Replace irqchip mask_invert with unmask_base
Date:   Thu, 21 Jul 2022 11:17:23 +0100
Message-Id: <20220721101723.19956-1-aidanmacdonald.0x0@gmail.com>
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

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
This patch depends on the "regmap-irq cleanups and refactoring" series
which (at time of writing) is already in linux-next.
Link: https://lore.kernel.org/lkml/20220623211420.918875-1-aidanmacdonald.0x0@gmail.com/

 drivers/irqchip/irq-sl28cpld.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sl28cpld.c b/drivers/irqchip/irq-sl28cpld.c
index fbb354413ffa..f2172240172c 100644
--- a/drivers/irqchip/irq-sl28cpld.c
+++ b/drivers/irqchip/irq-sl28cpld.c
@@ -65,8 +65,7 @@ static int sl28cpld_intc_probe(struct platform_device *pdev)
 	irqchip->chip.num_irqs = ARRAY_SIZE(sl28cpld_irqs);
 	irqchip->chip.num_regs = 1;
 	irqchip->chip.status_base = base + INTC_IP;
-	irqchip->chip.mask_base = base + INTC_IE;
-	irqchip->chip.mask_invert = true;
+	irqchip->chip.unmask_base = base + INTC_IE;
 	irqchip->chip.ack_base = base + INTC_IP;
 
 	return devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),

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

