Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0324CB48C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiCCBpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiCCBo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:44:59 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21311B65C6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:44:15 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id v3so3382056qta.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 17:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEJaO0Vi4Kwfv0Wb4WQ2+Q+z6zunlr1TGnFG+5J/o0Y=;
        b=O6yWcrDHwFQRhE4PxZR/mpmttlr1A73V9h8HAbSE18gjKpEOxOGOMDG5nRHWozR3uz
         r5yBzWz88Em4bNspoQZKRA3tyiOO7tWB/cs9THxzZMxikI5vBT8mQhAxaW53oIDItQn/
         UzAV2Ca11pywRutZrQTj85YDlx5pm0XHgwEw0onY2aKOijiEXYfxkAp/NYyBcIrKo6RR
         45HkDkbLqHCv63Ol+HzagOrNbeZKLJI+lRYTGb28QAl5lCzcNu5mRs3Fk1zUv8ztVh4Y
         p3LZdlIV1Qa6P7QEtWtQtD+FanQFb65EbMtPSauzYCsm8KeQCuDw40FRyQwAaCi+e4S7
         TZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEJaO0Vi4Kwfv0Wb4WQ2+Q+z6zunlr1TGnFG+5J/o0Y=;
        b=sk9UhDeQgUUmpSrA+yPIn92wDI5M9ksMm6ceb+DaWlgA85Jxb0MseMgkVnHR/87Efz
         034cgDWOb0W0cHlr13m+zN+4MfZh4jrn6HC17YAEBsyX8e7h3gXLtwbCDqAvBh1L5iH1
         E0ukofoYpQsujRf5YO6ce/ARzxZrFJIVKEAnLWXdLwE4pohVvk47bbcxgwOWF9gPLi07
         wammpUIYJF7p20T8ieZ0Oby7/AiDfhb0ZDhtUiXZv03gg7F0ft+3SULHKWrlz3zpIx+S
         7ylh5xPoHMItPfwrE3pXOG9w3k5p9RBWjmz+M2hSTNES9xLaHdu39tkJzAINYEW4VS7v
         8wUw==
X-Gm-Message-State: AOAM532p8cCLg9TOoRDxEigA1q259Ah40Z0Cm58q+y0+QD+gbsiY6UrA
        ZEG1jbwAm5DJcQpmf+jgLoo=
X-Google-Smtp-Source: ABdhPJyFwaId4iQ/+ux2jZP4uLbwMNoJjMfyEd5/rGbhuWf7T6m6Bku7ZaVtuiJ1awSuOKjGHH98fg==
X-Received: by 2002:ac8:5a05:0:b0:2de:15ef:8bd5 with SMTP id n5-20020ac85a05000000b002de15ef8bd5mr25783831qta.71.1646271854779;
        Wed, 02 Mar 2022 17:44:14 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d13-20020a05622a05cd00b002dffcc45ba5sm563131qtb.4.2022.03.02.17.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 17:44:14 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     kishon@ti.com
Cc:     vkoul@kernel.org, heiko@sntech.de, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] phy/rockchip: Use of_device_get_match_data()
Date:   Thu,  3 Mar 2022 01:44:06 +0000
Message-Id: <20220303014406.2059140-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/phy/rockchip/phy-rockchip-dphy-rx0.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-dphy-rx0.c b/drivers/phy/rockchip/phy-rockchip-dphy-rx0.c
index 4df9476ef2a9..639452f47869 100644
--- a/drivers/phy/rockchip/phy-rockchip-dphy-rx0.c
+++ b/drivers/phy/rockchip/phy-rockchip-dphy-rx0.c
@@ -327,7 +327,6 @@ static int rk_dphy_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	const struct rk_dphy_drv_data *drv_data;
 	struct phy_provider *phy_provider;
-	const struct of_device_id *of_id;
 	struct rk_dphy *priv;
 	struct phy *phy;
 	unsigned int i;
@@ -347,11 +346,7 @@ static int rk_dphy_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	of_id = of_match_device(rk_dphy_dt_ids, dev);
-	if (!of_id)
-		return -EINVAL;
-
-	drv_data = of_id->data;
+	drv_data = of_device_get_match_data(dev);
 	priv->drv_data = drv_data;
 	priv->clks = devm_kcalloc(&pdev->dev, drv_data->num_clks,
 				  sizeof(*priv->clks), GFP_KERNEL);
-- 
2.25.1

