Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794D24F7B6E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243744AbiDGJVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243733AbiDGJVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:21:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC521CABCA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:19:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id f18so5662948edc.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VNbnKRlfaQArckBwqtyPd//4SBBVpRdJ3XTbCofIYRs=;
        b=iKMF7HKH1ujVrO+HWsVSZBima3JdMAbH4p58+DPB86kQEpFAapqdqaaGmPgM+CCT5c
         4ijl8uuyUSC5K0ptya67Bi4z1z1WrZKDC/36CqWVCJOVDF2l6HbaACSlJwQET6tyc9ON
         E83TgMGDZMbug8Upqcm5z8MPN3P+7sKYJy/vK1t1/UC7ImP5BSBT7lrXg1fA31fWjMV9
         6FPdUiH3UDQCyKi+cGH9xeeljybBQU9++yW9sMK/wsMVTUWqs6A+5gqWBSKUxZRPHSwW
         zvwYy1SOGxeKXBfcPn5FoSdzkg/cveW3tZVciql/oQhQnmMYs0P0sIhdaLg96L8yZEfm
         oGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VNbnKRlfaQArckBwqtyPd//4SBBVpRdJ3XTbCofIYRs=;
        b=gtUEVIhVz2bqZXVPAeLK0PVUe+MrCBoJC5l+2yKIvYjbaVDtu0Z84x/uUrdBnpE+SC
         lN1H8Kn055R1qpX5H3PJhO6JVcAPwst72thcIm50WImR1TZlFOPzVBVmgOsolyvsTG2O
         fX1nVR13E0+bZ8BFhtFNU7LU6jnAoaRjr4d+gQTjcyuxAgM9vTMzI+VcInS4fbMC/ePv
         joouOdQl3kJEPSduWSGxw4o4rCQxEgXrm09v5FmNq6ldyx82A/OjqZ+qTXTm39rR4AqI
         zQyHnMAI/Bia1xuAoUz9Qmg6Fno7t7psN7kU3u0xkCGx770PR14NeZ+nmxh5pUfRixAT
         A4Hg==
X-Gm-Message-State: AOAM533ap3fmoYTGhiZ7Ua/VqdesN3di39RIGhZZQAikv14wh0bXaJXv
        HxtcB7PqStgmtdGWpzkRaJ5Vxw==
X-Google-Smtp-Source: ABdhPJzFsBM5gI6o2DREc7Xi8f5GVAMfoqKmYdFDqhcq0iN5kCkieW3N33D+6qQ3NnRe9X9N43TCtQ==
X-Received: by 2002:a05:6402:5107:b0:419:935d:bb6e with SMTP id m7-20020a056402510700b00419935dbb6emr13218359edd.242.1649323146442;
        Thu, 07 Apr 2022 02:19:06 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id m1-20020a170906848100b006e8053c7cdcsm2927752ejx.39.2022.04.07.02.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 02:19:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Girish K S <ks.giri@samsung.com>,
        Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>,
        Vasanth Ananthan <vasanth.a@samsung.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/2] phy: samsung: exynos5250-sata: fix missing device put in probe error paths
Date:   Thu,  7 Apr 2022 11:18:57 +0200
Message-Id: <20220407091857.230386-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407091857.230386-1-krzysztof.kozlowski@linaro.org>
References: <20220407091857.230386-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actions of of_find_i2c_device_by_node() in probe function should be
reversed in error paths by putting the reference to obtained device.

Fixes: bcff4cba41bc ("PHY: Exynos: Add Exynos5250 SATA PHY driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/phy/samsung/phy-exynos5250-sata.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5250-sata.c b/drivers/phy/samsung/phy-exynos5250-sata.c
index 6c305a3fe187..595adba5fb8f 100644
--- a/drivers/phy/samsung/phy-exynos5250-sata.c
+++ b/drivers/phy/samsung/phy-exynos5250-sata.c
@@ -196,20 +196,21 @@ static int exynos_sata_phy_probe(struct platform_device *pdev)
 	sata_phy->phyclk = devm_clk_get(dev, "sata_phyctrl");
 	if (IS_ERR(sata_phy->phyclk)) {
 		dev_err(dev, "failed to get clk for PHY\n");
-		return PTR_ERR(sata_phy->phyclk);
+		ret = PTR_ERR(sata_phy->phyclk);
+		goto put_dev;
 	}
 
 	ret = clk_prepare_enable(sata_phy->phyclk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable source clk\n");
-		return ret;
+		goto put_dev;
 	}
 
 	sata_phy->phy = devm_phy_create(dev, NULL, &exynos_sata_phy_ops);
 	if (IS_ERR(sata_phy->phy)) {
-		clk_disable_unprepare(sata_phy->phyclk);
 		dev_err(dev, "failed to create PHY\n");
-		return PTR_ERR(sata_phy->phy);
+		ret = PTR_ERR(sata_phy->phy);
+		goto clk_disable;
 	}
 
 	phy_set_drvdata(sata_phy->phy, sata_phy);
@@ -217,11 +218,18 @@ static int exynos_sata_phy_probe(struct platform_device *pdev)
 	phy_provider = devm_of_phy_provider_register(dev,
 					of_phy_simple_xlate);
 	if (IS_ERR(phy_provider)) {
-		clk_disable_unprepare(sata_phy->phyclk);
-		return PTR_ERR(phy_provider);
+		ret = PTR_ERR(phy_provider);
+		goto clk_disable;
 	}
 
 	return 0;
+
+clk_disable:
+	clk_disable_unprepare(sata_phy->phyclk);
+put_dev:
+	put_device(&sata_phy->client->dev);
+
+	return ret;
 }
 
 static const struct of_device_id exynos_sata_phy_of_match[] = {
-- 
2.32.0

