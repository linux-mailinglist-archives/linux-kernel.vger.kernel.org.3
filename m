Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E06753DD3B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351329AbiFEQ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiFEQ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:57:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7641F25C4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 09:57:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n10so24878764ejk.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4gqvv7SB+vS5l3sqUpll/2cHcxIjp6YvEKZyVVCwBAk=;
        b=PJUDXWiCMxR7AxgHes6RlyFPB4Hqhx0E/apkUeoejAP+4Qn4En61gOevroQ0A8O9tb
         U9S6gjEE35m0eRzkqnebWnEBkovvW9Dv6AjjQp86oGqgVON44begcZjF5JB8hgoU7XXq
         LvO9+z7uUIIXRoy28HKyqrMLWUWgpHl0BWRRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4gqvv7SB+vS5l3sqUpll/2cHcxIjp6YvEKZyVVCwBAk=;
        b=Cbc/QVqn5kRO99x+L5vEZbimtIEkHugZFTLAM6bP7MqAXpdQvofVIjYkkEwhoNUwQi
         f4PbhNxOA5eXCnDuNFXvLakyGsCIbyxOVcbX6NZ88tS1eE69ArqvyHDmVH8rOT/f4NIM
         zTqOJKR97q3IrVLwwcOgzxlwFarE2dKlgPLL6WzDYotu9q4LCQm8gdsrt9yrxSeqe6hY
         xbT4qr5hrlvuTQc8AVaxWLpTsPBNPoNeHmXYUVnxPEJbpvmDVGjK0dg/T91ogZ/FrlEP
         moA+ou3gIwOoY2Kcujxm2j0+0M1Bxxl03qkBVBpiTYOjYzIScly5WN8hP32VUT/QocVC
         G1zg==
X-Gm-Message-State: AOAM532Noq381zNeV9/22WIUC53lQ3hcPRNMmBmgNn7plvzUy+zHI6NA
        gAebfsVBklIBJ9xKHJcAQChM8g==
X-Google-Smtp-Source: ABdhPJwMquTNTd2K8G7UERrgOxRkssN9xrKIq+cVSgfXCiGbnl4ACZB2UjmWZBzzwjwGLTrluADy0g==
X-Received: by 2002:a17:906:c797:b0:711:8c01:32d4 with SMTP id cw23-20020a170906c79700b007118c0132d4mr4733057ejb.205.1654448229001;
        Sun, 05 Jun 2022 09:57:09 -0700 (PDT)
Received: from localhost.localdomain (mob-83-225-9-201.net.vodafone.it. [83.225.9.201])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906660c00b0070e3f58ed5csm3260761ejp.48.2022.06.05.09.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 09:57:08 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 1/3] clk: bd718x7: Clean up the code, no functional changes
Date:   Sun,  5 Jun 2022 18:57:01 +0200
Message-Id: <20220605165703.1565234-2-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220605165703.1565234-1-michael@amarulasolutions.com>
References: <20220605165703.1565234-1-michael@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/clk/clk-bd718x7.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
index ac40b669d60b..04cc0beb67df 100644
--- a/drivers/clk/clk-bd718x7.c
+++ b/drivers/clk/clk-bd718x7.c
@@ -81,27 +81,28 @@ static int bd71837_clk_probe(struct platform_device *pdev)
 	struct bd718xx_clk *c;
 	int rval = -ENOMEM;
 	const char *parent_clk;
+	struct device *dev = &pdev->dev;
 	struct device *parent = pdev->dev.parent;
 	struct clk_init_data init = {
 		.name = "bd718xx-32k-out",
 		.ops = &bd71837_clk_ops,
+		.num_parents = 1,
 	};
 	enum rohm_chip_type chip = platform_get_device_id(pdev)->driver_data;
 
-	c = devm_kzalloc(&pdev->dev, sizeof(*c), GFP_KERNEL);
+	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
 	if (!c)
 		return -ENOMEM;
 
-	c->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	c->regmap = dev_get_regmap(parent, NULL);
 	if (!c->regmap)
 		return -ENODEV;
 
-	init.num_parents = 1;
 	parent_clk = of_clk_get_parent_name(parent->of_node, 0);
 
 	init.parent_names = &parent_clk;
 	if (!parent_clk) {
-		dev_err(&pdev->dev, "No parent clk found\n");
+		dev_err(dev, "No parent clk found\n");
 		return -EINVAL;
 	}
 	switch (chip) {
@@ -119,7 +120,7 @@ static int bd71837_clk_probe(struct platform_device *pdev)
 		c->mask = CLK_OUT_EN_MASK;
 		break;
 	default:
-		dev_err(&pdev->dev, "Unknown clk chip\n");
+		dev_err(dev, "Unknown clk chip\n");
 		return -EINVAL;
 	}
 	c->pdev = pdev;
@@ -128,15 +129,15 @@ static int bd71837_clk_probe(struct platform_device *pdev)
 	of_property_read_string_index(parent->of_node,
 				      "clock-output-names", 0, &init.name);
 
-	rval = devm_clk_hw_register(&pdev->dev, &c->hw);
+	rval = devm_clk_hw_register(dev, &c->hw);
 	if (rval) {
-		dev_err(&pdev->dev, "failed to register 32K clk");
+		dev_err(dev, "failed to register 32K clk");
 		return rval;
 	}
-	rval = devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_simple_get,
+	rval = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
 					   &c->hw);
 	if (rval)
-		dev_err(&pdev->dev, "adding clk provider failed\n");
+		dev_err(dev, "adding clk provider failed\n");
 
 	return rval;
 }
-- 
2.25.1

