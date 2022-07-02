Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B749E564350
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 01:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiGBXNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 19:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGBXMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 19:12:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D64BC84;
        Sat,  2 Jul 2022 16:12:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o9so7120533edt.12;
        Sat, 02 Jul 2022 16:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tfhcm8JZSEoxWkGuUHKnCtWh4qkCjWwjLcTzBInqbQ=;
        b=qbIIucf1dHuEEnkQJeZxhoxVXunTNBrwf9pPgBg71UJEDtXVOAHHMiaM/j3sUnPzF4
         46asSmFmH7jSYtv7wiE5CucIH7eN4l4/0NyOyVVrG8RpEP8QOgTGtC8buXFJUIm2EOwB
         PY+FXLWsmIz4WjcO/Cb9ZmEGV5zauPiwV+JW4P5LlnwK2vM5LfCTU8FTcXyuq7+m3Qci
         YcsNRVVO90cY4nHHJVbCD/loPHso+pV90AIizkTEqn42JyeLulqzGyRzVlbvQnqMLRB0
         t6cRg9MP/2bmRy3mxFm9EUOSrJ1otUePF1pzZvIGlTFak+pXO+sKwLHoer7KuqWWrnMd
         ic3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tfhcm8JZSEoxWkGuUHKnCtWh4qkCjWwjLcTzBInqbQ=;
        b=TMTNNMcIuYX27fLKOP2//a555+Du37TdQN3ZEiAmmM9DOuYsiECZ/W/SG5X5OBT9uu
         3NGWUkbVidVRB1OPm0ziXigpa54pFOISy7S9erUBrl5z0blAMpDxz7RbUikSiiR4wxk8
         y/s1aPqj0ufo4p04mJLhNhCI6IO1D3C0CvOQ4oO5D10cXypIDvbv8LJpt3jLWQltuHwk
         02kAB/k+AhjJ8Jxw12TL0kjdOV2h/WiTMADDb9uBzFHz5L4cA8L6N5kbHZVGOFm61CJe
         g5Ims+3lvBfEHNlPU/UZ65gqYyPUd8oriGQtdXtvgdUHBgaoh3kmFUbBSUZOf7KoBy3C
         afYQ==
X-Gm-Message-State: AJIora+WtfRqCZZkJhv9neagWvy63kXL3I3tO/NXn+X13r9vTnX5/6Lw
        3JmgR6Dm9ySIofRWsejgCJ+9MalAvok=
X-Google-Smtp-Source: AGRyM1sEQUtTu4io9H64uN46LrAbSLznCXdL3wuhSctJgfAka/2jCTDrvjy+AwrKFyWjb+CH6dGK4g==
X-Received: by 2002:a05:6402:950:b0:439:646e:c68e with SMTP id h16-20020a056402095000b00439646ec68emr18073691edz.42.1656803567209;
        Sat, 02 Jul 2022 16:12:47 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c4d4-2700-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c4d4:2700:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id uz12-20020a170907118c00b00711aed17047sm12234329ejb.28.2022.07.02.16.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 16:12:46 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 8/8] mtd: rawnand: intel: Use devm_platform_ioremap_resource_byname()
Date:   Sun,  3 Jul 2022 01:12:27 +0200
Message-Id: <20220702231227.1579176-9-martin.blumenstingl@googlemail.com>
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

