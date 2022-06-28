Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5841C55D6C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345527AbiF1L2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345207AbiF1L2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:28:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466F5655C;
        Tue, 28 Jun 2022 04:28:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ge10so25095879ejb.7;
        Tue, 28 Jun 2022 04:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/vVPNNNi/M5hFZ14uI3yR7vQmNxehz58sZt8wiaUeE=;
        b=HaWubVbNaxSD+nlcHJa49uO9e6VAh9gOOIRMAfHc/SGLurGEg8A6CZo1MHioC4yM9T
         BF0JznCyJN2tmhkcShwNh03rwsG6BUiTv87W8haV9GF/CxjpFVr2idmrgq0UJzzXm9/a
         uYVinDWBpYg40+c5lzK2vpa96lAZjgm7jWCu6pIX/lqRa0EYeZFjRqRDsg1d9NjGH15b
         CazDQm2NN45LJqPwSDHocRDtYiDhXJ7BJjO1W8qbAzWtWcLAiCrOXcF1vYw0WWHSIGlr
         IYM/6MascnMHRGlSBL5Z137juzIVHeHJAX8YM02AKrWrUgl+7SN4HmN2Y3Rhi5RWeAVI
         61jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/vVPNNNi/M5hFZ14uI3yR7vQmNxehz58sZt8wiaUeE=;
        b=wLLTPWSV7xzPhjNI1nw8M2BIKYosBn3TLDvAcP/QNbf2Egt/diHO+39f0sNJuY+uso
         L6ssjktsNcu8v4O1e1blp8E0p4yHYbGs2ZgZ+gFTP+Lqe5T1zFG0bsSYB2vpVk+Bp2GX
         GN9l3WCZ+6bJL8Cc+dq0Ml0WTHzkgXubxxzHtfwUXbx5J9y8/agwK95VaLT4IrhZzVm7
         lzBfrkAGtaqhYEeIiC1TxIQ8MEOmVd9NrCiOwkUeRjByx5Ici23NQdg9L3gjmTqvF+BP
         /sZuqr1X/xN59GfeS5FNWp0twrUdSrF8h/or/ge+2hKI8OySJkqMFPiAs/U/HbbAP0Iu
         tQ4g==
X-Gm-Message-State: AJIora+04Fg200SSJePzyglOr1G77UR4g+5XWRZDBcxgBv2j/bRQuYOm
        1sypx9sv50DaAG1VPHZzHtc=
X-Google-Smtp-Source: AGRyM1tn25cwZFHS/DKbUQZdk6M3oiSNF7RkIMRFB9m1OpkuIcAdUMVXZJI1tQCvfXCkFMcBZmC9pg==
X-Received: by 2002:a17:907:6d1d:b0:726:363e:cca3 with SMTP id sa29-20020a1709076d1d00b00726363ecca3mr17142850ejc.713.1656415692784;
        Tue, 28 Jun 2022 04:28:12 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id h6-20020aa7cdc6000000b00435720b7a1csm9456318edw.20.2022.06.28.04.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 04:28:12 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 3/8] mtd: rawnand: intel: Read the chip-select line from the correct OF node
Date:   Tue, 28 Jun 2022 13:27:26 +0200
Message-Id: <20220628112731.2041976-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com>
References: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com>
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
2.36.1

