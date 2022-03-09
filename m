Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200494D2D9A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiCILC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiCILCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:02:55 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8023106CB4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:01:56 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id h5so259080plf.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 03:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=uMENzkKdA+Cycwv2RjlL4eOHNjlYxkelbnza/x9xMCo=;
        b=CdBzhLNe15o3w4/whWA35PbLedYesspkw+62C75GegLfv48MdGSTZzJ5f4n9Pj0D5/
         HP7fKPID8O3X0mTcRPAp2pNrJ5RE2fkTUYL1oKCMNExeToruK+4NOzyTmx07AVHqEhuH
         8GvENlgSMuVyBK+U9+el48l0haURmJliLHPxImvHcipDKB40AQCV0vs0XUumVrOvLsfI
         /b5gVKeoxcXjZji+++pxj+w4UIVTRk1MljbuI91UZFuSK0dYXno+TFjxfYJFsbhtK5Sk
         7TAB6YRzT/UMW/PRgNnHnSH9zYmYTtBvS1d3JtsLCsyl0idBNJsMpBbRwe8rtEOAqUry
         Z8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uMENzkKdA+Cycwv2RjlL4eOHNjlYxkelbnza/x9xMCo=;
        b=DSSBL3XG8VREBHJsHhjsImOfRGRqcn4E1xuprk0Z1mJn+ljcLpTHtiIgKOU68GwHfO
         q7zD/UNy9PdTMX3vXzTY0k7Ex6GJo6rVUX+SDakd4jHWb5b/sVlJYTVjspOxeXT3K8uP
         Ns896oKi7ZuveaRDUkfK/gWYTPkMj6oRtKl/ln2SXYBuRwsFQ5ZArIEc46ZU/q8PnFsN
         MpXOdTmpbs3IHMqeGRJ3O6mIPez+CHd15CEbyuk9hPClNd+hETdKmMOqhGWaIpgAlIZy
         6cws1SwxlZ/3Z76nLWpfkm/l2GL2eW+IFs8qe4A6f2S/uimfQezGTfCUWLkTSATu8C9O
         ldpw==
X-Gm-Message-State: AOAM5302JzqAkF3txNCm0tMi3CBF+qWkE2FsU7YI6umHhO86wuhYNjIS
        JlHUEcmDOL1Tj8Ml7IHP0/w=
X-Google-Smtp-Source: ABdhPJxFXuDe2A9f+ayjVCidSoPzQQfMM66scU+hQ84B+zGrg4zQ9oAYeJY2KTKrt2zNb50p2WWdNg==
X-Received: by 2002:a17:902:ea0d:b0:151:df90:779f with SMTP id s13-20020a170902ea0d00b00151df90779fmr17772260plg.1.1646823715498;
        Wed, 09 Mar 2022 03:01:55 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id nm14-20020a17090b19ce00b001bf2404fd9dsm2197382pjb.31.2022.03.09.03.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 03:01:55 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linmq006@gmail.com
Subject: [PATCH] memory: atmel-ebi: Fix missing of_node_put in atmel_ebi_probe
Date:   Wed,  9 Mar 2022 11:01:43 +0000
Message-Id: <20220309110144.22412-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_node pointer is returned by of_parse_phandle() with refcount
incremented. We should use of_node_put() on it when done.

Fixes: 87108dc78eb8 ("memory: atmel-ebi: Enable the SMC clock if specified")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/memory/atmel-ebi.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index c267283b01fd..e749dcb3ddea 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -544,20 +544,27 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 	smc_np = of_parse_phandle(dev->of_node, "atmel,smc", 0);
 
 	ebi->smc.regmap = syscon_node_to_regmap(smc_np);
-	if (IS_ERR(ebi->smc.regmap))
-		return PTR_ERR(ebi->smc.regmap);
+	if (IS_ERR(ebi->smc.regmap)) {
+		ret = PTR_ERR(ebi->smc.regmap);
+		goto put_node;
+	}
 
 	ebi->smc.layout = atmel_hsmc_get_reg_layout(smc_np);
-	if (IS_ERR(ebi->smc.layout))
-		return PTR_ERR(ebi->smc.layout);
+	if (IS_ERR(ebi->smc.layout)) {
+		ret = PTR_ERR(ebi->smc.layout);
+		goto put_node;
+	}
 
 	ebi->smc.clk = of_clk_get(smc_np, 0);
 	if (IS_ERR(ebi->smc.clk)) {
-		if (PTR_ERR(ebi->smc.clk) != -ENOENT)
-			return PTR_ERR(ebi->smc.clk);
+		if (PTR_ERR(ebi->smc.clk) != -ENOENT) {
+			ret = PTR_ERR(ebi->smc.clk);
+			goto put_node;
+		}
 
 		ebi->smc.clk = NULL;
 	}
+	of_node_put(smc_np);
 	ret = clk_prepare_enable(ebi->smc.clk);
 	if (ret)
 		return ret;
@@ -608,6 +615,10 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 	}
 
 	return of_platform_populate(np, NULL, NULL, dev);
+
+put_node:
+	of_node_put(smc_np);
+	return ret;
 }
 
 static __maybe_unused int atmel_ebi_resume(struct device *dev)
-- 
2.17.1

