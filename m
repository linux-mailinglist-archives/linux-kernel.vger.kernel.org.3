Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CFB564344
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 01:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiGBXMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 19:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGBXMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 19:12:45 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7687BBC27;
        Sat,  2 Jul 2022 16:12:44 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c65so7154455edf.4;
        Sat, 02 Jul 2022 16:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yCQTaNx44e60e0RQIQkoEDKE0jArPjhRbsgoDMKp9c8=;
        b=dgxlSIjFJwSCBjcvyW+PrWZomTklrALAUl2SxmBCl2+hC6/UnRF5C/QTl3DI+XlaVm
         zPO8X3hufGMWdx72k5+9W8OKCvBdvH9sJi62Lzdwy1jCQ7DwQFh/WtXIhbtDXFnP9DF3
         n+xyF3SF1GEjaCY5YFD4IqX8XYShGmQ1AP1p/mxjajLRY0pMb941kFcCysS76Nv/vosM
         Y+1pJzmWG6ZcEky7XuMSGEC9onUjyVQF57dI7uMF/+4W9DNHFjHZZ3esF62Jw1IBV1I3
         8Ihy3m3EuL2VX4CoUBd3zbxYNfVrTfaHzHIlvmn1KYV702KpO0NM4K51sbBbVJVeNEM2
         +tPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yCQTaNx44e60e0RQIQkoEDKE0jArPjhRbsgoDMKp9c8=;
        b=5aA9tfu7WEa7htXVwxerbBfW2njDbykYycRjz6WA5vmxx4qe7gCL7sca9AnXkgL6U8
         bvmvetaURretUpdvh+B8wJ5LoaD4R4CKeHPwi1nD2ntIh7/9mCcr9O9/37LfTNlxflBh
         y9GBnlVlj+b4zVDbK95VjRzkT/aOhg/IgFRgqxJ25ZYg15DupO2cT7OpNqso5CNIzjww
         54HQKbVJI0UO80rkxrcepbm0R3IMZwuUtgqNk75n2C508lFqaRLUskuALXCJW51tBLNJ
         PbTyZLDzlqVaHiM7g54M6d+EyB4Y2tTJYBZTu/zX+PqXIfJA408CSmozwrGxuwsrH1a+
         e3Gw==
X-Gm-Message-State: AJIora/G3hXqnjOmnyDUy4pg6UZoOKZ/p82Nup7JyD/vcZU65OMDjsZ6
        pFYy5xqD4gI9k/cCOSXStkM=
X-Google-Smtp-Source: AGRyM1sKu0kp3FtCCbBKNYht3OJTpZgRKfuJVirFs6MCvvcbODpijjhQI7TKv9HNwbq7BMmmy6Kzag==
X-Received: by 2002:aa7:c9cf:0:b0:435:de3b:c499 with SMTP id i15-20020aa7c9cf000000b00435de3bc499mr27700806edt.321.1656803562966;
        Sat, 02 Jul 2022 16:12:42 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c4d4-2700-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c4d4:2700:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id uz12-20020a170907118c00b00711aed17047sm12234329ejb.28.2022.07.02.16.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 16:12:42 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 3/8] mtd: rawnand: intel: Read the chip-select line from the correct OF node
Date:   Sun,  3 Jul 2022 01:12:22 +0200
Message-Id: <20220702231227.1579176-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220702231227.1579176-1-martin.blumenstingl@googlemail.com>
References: <20220702231227.1579176-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The chip select has to be read from the flash node which is a child node
of the NAND controller.

Fixes: 0b1039f016e8a3 ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index e91b879b32bd..3df3f32423f9 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -16,6 +16,7 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand.h>
 
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -580,6 +581,7 @@ static int ebu_nand_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ebu_nand_controller *ebu_host;
+	struct device_node *chip_np;
 	struct nand_chip *nand;
 	struct mtd_info *mtd;
 	struct resource *res;
@@ -604,7 +606,12 @@ static int ebu_nand_probe(struct platform_device *pdev)
 	if (IS_ERR(ebu_host->hsnand))
 		return PTR_ERR(ebu_host->hsnand);
 
-	ret = device_property_read_u32(dev, "reg", &cs);
+	chip_np = of_get_next_child(dev->of_node, NULL);
+	if (!chip_np)
+		return dev_err_probe(dev, -EINVAL,
+				     "Could not find child node for the NAND chip\n");
+
+	ret = of_property_read_u32(chip_np, "reg", &cs);
 	if (ret) {
 		dev_err(dev, "failed to get chip select: %d\n", ret);
 		return ret;
@@ -660,7 +667,7 @@ static int ebu_nand_probe(struct platform_device *pdev)
 	writel(ebu_host->cs[cs].addr_sel | EBU_ADDR_MASK(5) | EBU_ADDR_SEL_REGEN,
 	       ebu_host->ebu + EBU_ADDR_SEL(cs));
 
-	nand_set_flash_node(&ebu_host->chip, dev->of_node);
+	nand_set_flash_node(&ebu_host->chip, chip_np);
 
 	mtd = nand_to_mtd(&ebu_host->chip);
 	if (!mtd->name) {
-- 
2.37.0

