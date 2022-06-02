Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F270453B996
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbiFBNYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiFBNYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:24:06 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E3B2823EE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 06:24:05 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r71so4789341pgr.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 06:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+og5Yeb4185sTD8OGrlB2+zCZSKPKau88+Z65n/Fsdc=;
        b=e4x5bmlIS6xIJZaJiI4f+pU6+zuWb0iGbgdfo7XYrp3uw0o+Dx4q2TPn2vP4rUoF/c
         Io67w3LNXkbEyIhrKe5rCn+6hgj3gXNR+cU2SkFMPHgAXV5ldyTsFgkxhP0fQmfwmUwA
         Sisy5tF02DsmOlDCRoouhRUHdEvj1f+D5/qAxP0i0U3zA0jZ9Vhw5wQaOOJQKSbE6DNw
         44zNTuevuyhn1gxNpcmmnRYYjG88624/UW5KT95gcXQbCa9IwUwvkCB2ztobUaP5w2hk
         EBFXnITA5GZh9C0ZtxpdS0znCEVd6T8MlNbSJgeur4jfpsddgZ7e+XGtp/8PT1WlqKHv
         AHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+og5Yeb4185sTD8OGrlB2+zCZSKPKau88+Z65n/Fsdc=;
        b=Lxu2M1MGEw8qUkwubdFWAL8oXyrbwVPGI+hTidNWO8BS9ICiOFRIzBzrMFD1uCzBge
         BTiE5smR3pl0RwvyX0dQcVIalIlGlB0qW4NiV6FqINkyhIr0ptVL1wTcF8JkFa/EAW5n
         AZ8jHhepu7eto4RlBR7ITrVw6DvzwrOCNrClc/jJKvzIHWoL04KS61qaVL4VY0kmG9Ik
         Ju261nAdi4FZ0UmWRX+zi6ZFUUGEw0ApUWTbTZZacwnUDyNRuu9113BCgP2O9gAyfkUx
         e3XYiVSPDzInk5f7MxBhYqClz58/vX9I3JEDgaLWAzRya4XL9fQTlFUm+l2MQSNNJHbc
         3Vjg==
X-Gm-Message-State: AOAM533MKg4g0fUMsk45hFr04RXbmZCBvgbnuwel0C/T+mqgaOzIwTM/
        9/LhQ6+XHCM7hOu0EjXKfBhwhe8CaNtfS8nCATU=
X-Google-Smtp-Source: ABdhPJwm8YwOa1l2YYBjILf/L7Lk/9JJ3VQncruyKOiVbFuJHVipVaKide0lxzv0+3W5I9myJnPcyw==
X-Received: by 2002:a62:820a:0:b0:51b:d1f9:b45f with SMTP id w10-20020a62820a000000b0051bd1f9b45fmr1584026pfd.63.1654176244939;
        Thu, 02 Jun 2022 06:24:04 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id b10-20020a17090a5a0a00b001cd4989febcsm5910774pjd.8.2022.06.02.06.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:24:04 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: imx: gpc: Fix refcount leak in imx_gpc_probe
Date:   Thu,  2 Jun 2022 17:23:52 +0400
Message-Id: <20220602132355.29847-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
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

of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: format:721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/imx/gpc.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 90a8b2c0676f..5df47e6d7585 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -419,8 +419,10 @@ static int imx_gpc_probe(struct platform_device *pdev)
 		return 0;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		goto put_pgc_node;
+	}
 
 	regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
 					   &imx_gpc_regmap_config);
@@ -428,7 +430,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 		ret = PTR_ERR(regmap);
 		dev_err(&pdev->dev, "failed to init regmap: %d\n",
 			ret);
-		return ret;
+		goto put_pgc_node;
 	}
 
 	/*
@@ -464,15 +466,18 @@ static int imx_gpc_probe(struct platform_device *pdev)
 		int domain_index;
 
 		ipg_clk = devm_clk_get(&pdev->dev, "ipg");
-		if (IS_ERR(ipg_clk))
-			return PTR_ERR(ipg_clk);
+		if (IS_ERR(ipg_clk)) {
+			ret = PTR_ERR(ipg_clk);
+			goto put_pgc_node;
+		}
+
 		ipg_rate_mhz = clk_get_rate(ipg_clk) / 1000000;
 
 		for_each_child_of_node(pgc_node, np) {
 			ret = of_property_read_u32(np, "reg", &domain_index);
 			if (ret) {
 				of_node_put(np);
-				return ret;
+				goto put_pgc_node;
 			}
 			if (domain_index >= of_id_data->num_domains)
 				continue;
@@ -481,7 +486,8 @@ static int imx_gpc_probe(struct platform_device *pdev)
 							domain_index);
 			if (!pd_pdev) {
 				of_node_put(np);
-				return -ENOMEM;
+				ret = -ENOMEM;
+				goto put_pgc_node;
 			}
 
 			ret = platform_device_add_data(pd_pdev,
@@ -490,7 +496,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 			if (ret) {
 				platform_device_put(pd_pdev);
 				of_node_put(np);
-				return ret;
+				goto put_pgc_node;
 			}
 			domain = pd_pdev->dev.platform_data;
 			domain->regmap = regmap;
@@ -503,12 +509,17 @@ static int imx_gpc_probe(struct platform_device *pdev)
 			if (ret) {
 				platform_device_put(pd_pdev);
 				of_node_put(np);
-				return ret;
+				goto put_pgc_node;
 			}
 		}
 	}
 
+	of_node_put(pgc_node);
 	return 0;
+
+put_pgc_node:
+	of_node_put(pgc_node);
+	return ret;
 }
 
 static int imx_gpc_remove(struct platform_device *pdev)
-- 
2.25.1

