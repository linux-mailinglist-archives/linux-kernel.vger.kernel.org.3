Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576C3560BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiF2Vfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiF2Vfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:35:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F229F32EF4;
        Wed, 29 Jun 2022 14:35:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ay16so35173773ejb.6;
        Wed, 29 Jun 2022 14:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tfhcm8JZSEoxWkGuUHKnCtWh4qkCjWwjLcTzBInqbQ=;
        b=oaq594aJORkc4igVhEmAnz0tkKUz3k05Guf1B279q0eOY+2zLcShs6V1Q631zqvpSl
         X3BdluSPlIbMXeGsi/mi0rNaYlWDifQwFtCq8ABKYmqvQHXi8oKBiszAUijLT3rj7LM+
         vXXwgF9tkQ3otFWn3c+yChCAqJkJu6EaV+xitTplrc0DykRi0OAN9TUWleLNjjjvzPYJ
         yoxvip4VMqiM6c8hmxpzalaUZNY6/77OWedK00AyseDNyFkogdq6hn56v65Q1E4Qnvi/
         HALW+UFk4u+jEmruo7FCyoAP8xG9GzMnKjW/e5GzVKI2T9E2gRCUFgbPoVP96N8shhas
         DJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tfhcm8JZSEoxWkGuUHKnCtWh4qkCjWwjLcTzBInqbQ=;
        b=lZsB1DN+iyiCHE9S8DsP2+fhUH+7rhUPYk0teVV4vz9jgTckiHrIDyTfZFAiiwqDND
         5PjfhkHIuPqdxpQ+KfzTmS8+ls79eZzNR1CJt5ZauYPJs5HZJDPsuzICT80LiMhNMopG
         verXv56G1weU3itb0BJinttALKN5CSY8AWGvPw6G6WZceIxM1rmXRqHhUae3Xevx6KYn
         BHZvGBTbqcZp/J8C5rGVcz51D0jAbn9j3SgHsHPiCCwZehHA9CPW8h5Pvr5FsNr9JZye
         C0uDXYh7JbEfi526ZzGZNkwJUWosQ77Vo4dkBJWON1a7sTh4zpRlsLAds3FZO+yMpeCk
         ncAw==
X-Gm-Message-State: AJIora/SSKHKwbmpZLTk6qxvYfYIPgU4Zva/f1sQ+w0SLEHZ5YVQjbtZ
        VlQJIoukTWPncFOxNU+OBrw=
X-Google-Smtp-Source: AGRyM1vW89vMC6hdRwv48UbekRqLhvtYfRRKtoMLQHN16sjs2/WwOiGw+E3YgTnOj6scRy/JfOL2KQ==
X-Received: by 2002:a17:906:3ed5:b0:6f5:108c:a45 with SMTP id d21-20020a1709063ed500b006f5108c0a45mr5284383ejj.623.1656538526513;
        Wed, 29 Jun 2022 14:35:26 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-003-132.77.7.pool.telefonica.de. [77.7.3.132])
        by smtp.googlemail.com with ESMTPSA id s7-20020a1709066c8700b0070c4abe4706sm8237889ejr.158.2022.06.29.14.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:35:26 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 8/8] mtd: rawnand: intel: Use devm_platform_ioremap_resource_byname()
Date:   Wed, 29 Jun 2022 23:35:08 +0200
Message-Id: <20220629213508.1989600-9-martin.blumenstingl@googlemail.com>
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

Switch from open-coded platform_get_resource_byname() and
devm_ioremap_resource() to devm_platform_ioremap_resource_byname() where
possible to simplify the code.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index e486db11ecc3..d4a0987e93ac 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -592,13 +592,11 @@ static int ebu_nand_probe(struct platform_device *pdev)
 	ebu_host->dev = dev;
 	nand_controller_init(&ebu_host->controller);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ebunand");
-	ebu_host->ebu = devm_ioremap_resource(&pdev->dev, res);
+	ebu_host->ebu = devm_platform_ioremap_resource_byname(pdev, "ebunand");
 	if (IS_ERR(ebu_host->ebu))
 		return PTR_ERR(ebu_host->ebu);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hsnand");
-	ebu_host->hsnand = devm_ioremap_resource(&pdev->dev, res);
+	ebu_host->hsnand = devm_platform_ioremap_resource_byname(pdev, "hsnand");
 	if (IS_ERR(ebu_host->hsnand))
 		return PTR_ERR(ebu_host->hsnand);
 
@@ -620,8 +618,8 @@ static int ebu_nand_probe(struct platform_device *pdev)
 	ebu_host->cs_num = cs;
 
 	resname = devm_kasprintf(dev, GFP_KERNEL, "nand_cs%d", cs);
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, resname);
-	ebu_host->cs[cs].chipaddr = devm_ioremap_resource(dev, res);
+	ebu_host->cs[cs].chipaddr = devm_platform_ioremap_resource_byname(pdev,
+									  resname);
 	if (IS_ERR(ebu_host->cs[cs].chipaddr))
 		return PTR_ERR(ebu_host->cs[cs].chipaddr);
 
-- 
2.37.0

