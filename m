Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAD255C81C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345558AbiF1L2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345496AbiF1L2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:28:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85B410543;
        Tue, 28 Jun 2022 04:28:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r18so9230163edb.9;
        Tue, 28 Jun 2022 04:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSWuOS2cAYv5FuJkZUEc6ND5j48qnvL32xgmlNFYci4=;
        b=FvZMPG4RvTvduiJLbxdgkpBmHO0eivfuDB3c9SxChryaMNJW+RHsG0LmEDG9Dw19sU
         +7kHR0ctkFPFGOzNyssScuN0/V6YJe1/jvh9gInfgAzF6JsMIKuFIEyXLrCsof1hI6uN
         ZkQgi842QELzR98SBpzr4fT6W/EvvNFPTkJlL2EMmHMiuCjvTXVkGI+ZQgEeXhmKYkdd
         zFWcZrdkpewXgyHVxaAEbaXRvd+LMr44fGqNdY4wToMrbyw8vJdaEaDMhAE92k31vfoq
         igJWVXzBZ29TByMze6b7uWTfch6DYTBA4eItcWvNKFVAqGqKk/g6Vzz4ucX1bg8aMnps
         vSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSWuOS2cAYv5FuJkZUEc6ND5j48qnvL32xgmlNFYci4=;
        b=zA+DBYjucJ6qe1DQ5fnduSRYG/JU41PaVOASftNJxEur2G0GSyt1Zw3NouOLbWsgsQ
         tpgaxqYKyMVtBIIu1wZlYEUSExWJ6ilwboJibjjy7TOCZ1T+0B+xd3pgLIXYXpR80Iby
         uzlC3HKVNIJiBpoPaSPwi7xF+Z3LkvzAlEvvT/Xix69YCXoZbelTbdOTWEauwpAn5Sas
         iftMp9ZQ4syjiu12loojI7LGiUxg7CAg5eqMIpGdgL29pIwQipWJquDSQhabu5ohIHcB
         Nk5tqB+vxhRq9Ksoplxrq91Rk4v6n4rvo1VmbJZ6tSy+9pYz4sJ+WroWoexd3nwrKkE0
         nA8Q==
X-Gm-Message-State: AJIora+MlmDy8YjMpGgNnnjUtzHBIuE5Pbk+s+U6pl5AqRG1I/Wg3ZsT
        sNlS/s9k3o6XpLQm0U9OjkM=
X-Google-Smtp-Source: AGRyM1tN9+xICqng9ViA9oB4fb9cf2sQb53hvOku9jNJTaaO+oR/dcUdswOIf+hv1Nr6y/+uWwoFfw==
X-Received: by 2002:aa7:c7c4:0:b0:431:75d6:6b3 with SMTP id o4-20020aa7c7c4000000b0043175d606b3mr22099442eds.280.1656415698324;
        Tue, 28 Jun 2022 04:28:18 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id h6-20020aa7cdc6000000b00435720b7a1csm9456318edw.20.2022.06.28.04.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 04:28:17 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 8/8] mtd: rawnand: intel: Use devm_platform_ioremap_resource_byname()
Date:   Tue, 28 Jun 2022 13:27:31 +0200
Message-Id: <20220628112731.2041976-9-martin.blumenstingl@googlemail.com>
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
2.36.1

