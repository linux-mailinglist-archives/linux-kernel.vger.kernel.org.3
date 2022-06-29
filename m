Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0884560BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiF2Vfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiF2VfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:35:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFC531361;
        Wed, 29 Jun 2022 14:35:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id o25so2698991ejm.3;
        Wed, 29 Jun 2022 14:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yCQTaNx44e60e0RQIQkoEDKE0jArPjhRbsgoDMKp9c8=;
        b=j04Az8TdKock4zqoZCFJWAmKg8CGvIBEZlebcrwoG9NI4+Cks/OetYkjlYXfuHSIDl
         a5AkXoBaHwPrBtTLNXjds2Wt9iHbddbpfGm3ZhSb2lzBvogs8wQAyb3xZkHlVab5gRGn
         boI1numWT38W66YUI0stYYSGBbr8IUJ0W4O332OVHt6K3p7sCN52epmBMGgw237BvMhr
         MGXIKghGa8ngKh0AbAfT108AJCUKqyiWP3NmWO0quDc242lNWqaR0MBbiszNE4ediiI8
         KqTXYTjxm+p8IlynNGlyw1evF267B91FfPy3jqOmGMFUbR5H/Gyfws3eFqF7cfjC0dy/
         OFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yCQTaNx44e60e0RQIQkoEDKE0jArPjhRbsgoDMKp9c8=;
        b=Sm52izvQw80C0ItX1uIdeIzD/tNQeVuzfRNBxjbEq3bsYa50F51EwqL7GRSOgf6oCZ
         NW6bLaV3hphfQmeqAqVl7gcOAddZfV4IyHQuY5CPUPML40hW0EAP+L64H6Bbf0jiVjra
         WUiSoeAuB+P04hnN7WTIzOQd+FYGt4+2vofk9JKzo5JufHS0sOMavt2u+GBkZ1YTrWpZ
         PiYRJDYRUG4mzwJvlB/B3XdpjDq2T235YQ7X1O8SCrdAx+knCrNHYBenmn3fVq+inOek
         J6UQxIRyHb6LU9EYj53twjCFaH9iCfuNqYDQ71oWsL1rpnBqVXCNAg2jdVnjHFa1XMLn
         LERw==
X-Gm-Message-State: AJIora/krMKkXLZiXm4SR4vpxb7liI36LDBgWlGEfo7OcWWWxhSYcMnI
        FhKI/w7H0IEmbiPht/xMMs8=
X-Google-Smtp-Source: AGRyM1uI95qYilUtEQg7IwrvE8KFpZWoFelSQCO8lBL60wNYpCupJqBQwTiyo5Uq0CDT6XYXynIXUA==
X-Received: by 2002:a17:907:3ea6:b0:726:3554:cf7a with SMTP id hs38-20020a1709073ea600b007263554cf7amr5406240ejc.384.1656538522228;
        Wed, 29 Jun 2022 14:35:22 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-003-132.77.7.pool.telefonica.de. [77.7.3.132])
        by smtp.googlemail.com with ESMTPSA id s7-20020a1709066c8700b0070c4abe4706sm8237889ejr.158.2022.06.29.14.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:35:21 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/8] mtd: rawnand: intel: Read the chip-select line from the correct OF node
Date:   Wed, 29 Jun 2022 23:35:03 +0200
Message-Id: <20220629213508.1989600-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220629213508.1989600-1-martin.blumenstingl@googlemail.com>
References: <20220629213508.1989600-1-martin.blumenstingl@googlemail.com>
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

