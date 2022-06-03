Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A601F53CA55
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244502AbiFCNDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239620AbiFCNC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:02:58 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400FFEA6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:02:57 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s68so7165777pgs.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 06:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tZJCVfkDNbBay4i/IKmSG4KPm/5ghCVouz6lrlhw4Pw=;
        b=MaWVICMaC/zGZ8g1mJjK/S0Pes5zL9LKaGTSWgBPnNdKuaNH7uyWn8YMDKDuM51oKq
         mKOClKlUG5Zn4q8hPp5oZztaHoPCO8DNOkro105LglfXuiConNRJDSaa/EEq+De/gm2I
         GyK69usJrjyrhKNjCkNOoyLFDaMxMLY/+XkbIMmtaUUbpxugSod15WR/6j3Fm7VKLnd2
         qOEFuUkp0Hsib9+2bvM5pTg0vwy0Azg870k1/3irrGCHJO+041R1dgh1w2x2X420Br9l
         def1NPqAr9NmK72VAF3geosOcjft4ULE8LcT6uFbeWQLg5yMvv1gSt0nAlizzgqri7dY
         oHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tZJCVfkDNbBay4i/IKmSG4KPm/5ghCVouz6lrlhw4Pw=;
        b=2QA2Pa0qxzz8y/EisFGYqEZxXXlspzkfwaks4Yeqd3qbd39kYcfA3KOTKPMOR/XqqC
         aKDQzrSeC3ZWTxSyHuiGVF8XaLSU22yXdNqjUckl+BVlVHmSq5wc2gyR71743wrOduVD
         DUlz/X3TmbG1VuGcKPOHwhvsfoe7QHJRpfyb77/2p36+uLDS8EIM7qdzStrjZn+RUq8/
         2jBHEEEYzHBJFrOFav3jkhQVKZnQah2KQk1Efq7TyR9VH+SsrL62k56Ko3ggOlM46Crd
         fy+9Bum8EPGt7FABjDuLGCcLq5yWSZ4Cv95JJLe/zGMbUoMnTc+2V0lSyeMZFh3SWC9V
         JPxA==
X-Gm-Message-State: AOAM532jAEzHMKcVUGQ87pHMIsmNKST8kpME9UumqV/6d14Bk4b9dzJf
        RAaAk+fuG/EbhrfYZ7hduY8=
X-Google-Smtp-Source: ABdhPJzf0mIOPrgihIY3TMa9YP5IUgr7IfJUpVPWFFzNJXZoYQ/Ue6+qTI2DgBc4hrEuoRDWZdcrMA==
X-Received: by 2002:a63:ff5a:0:b0:3fc:c8d7:f3e0 with SMTP id s26-20020a63ff5a000000b003fcc8d7f3e0mr8934157pgk.77.1654261376751;
        Fri, 03 Jun 2022 06:02:56 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id ge20-20020a17090b0e1400b001df4c5cab51sm5155472pjb.15.2022.06.03.06.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:02:56 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] soc: imx: gpc: Fix refcount leak in imx_gpc_probe
Date:   Fri,  3 Jun 2022 17:02:43 +0400
Message-Id: <20220603130245.36151-1-linmq006@gmail.com>
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

Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- update Fixes tag.
v1 Link: https://lore.kernel.org/r/20220602132355.29847-1-linmq006@gmail.com
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

