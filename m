Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FDF4D372B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbiCIRKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbiCIRJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:09:51 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDC2178683
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:00:35 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5E0833F7DF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646845234;
        bh=1C2abaYPYBkDuzkzZwjwXPHr1LgPUoTyCzwwpANsRGs=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=c8mwumhSYolgAttT+LsZMAoW8j8r7TXxPw9Kh/gwT6lr5zjkqV2NDPb4UWXZf2q25
         NDUHXRVgad1r5Nw3Ke8nBJopYhb7QBiNyfe+uaWZCXATCgYw/Lr8kcbwhJnftoXqXE
         HXRb758+gUl4dLUAi3sdnDpjwIohzcO9do3Di+6oTt3NnxKX6IOnQjP5NruTzUMlvN
         LL29tzF/7QzHwyz8EfZyFUyfCavNkriKT49xqxyiX7mrF0RG3GWck6ZXzOPTqPOHMV
         D2G4MOZVd6YsDfrLTBQd363AKP5jPGnrxslLDMvYDhUFxS+6/nu5qfhrFId32HQ1gY
         k6ymIcON7vQ6g==
Received: by mail-ed1-f70.google.com with SMTP id r8-20020aa7d588000000b00416438ed9a2so1606315edq.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 09:00:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1C2abaYPYBkDuzkzZwjwXPHr1LgPUoTyCzwwpANsRGs=;
        b=Hmv++TJTbJJWTGaRE9sufDuN3KiP2oH4oytteOzQc5tYXLMYXbNePlwJIx9Yx+jH0B
         TDjLExqsTFRxsGFgBkZBkQ4tWr16iS4Zg0674AL2TIvdHBcAtTUvMbn2SuaLqbPk3U6i
         iRNdBa/JYvkl+FtkUnM9/RLYj2NcvnuoTget8r55iwx5tCv/iGuDe+1UctSrlZfC6/8p
         6oxeHHsh353BGwcXI3r65ZWdkD3oAZwX+FPZVYLa/lKmNSGDjtCcz0T7VepG8Sduo88y
         X6SaPQ71UcUZYLXmhHDMOrBvqfkbNcSIlM9BeSiFD/rdv5LxS0HWqVpf7Vx/yFFrZ1wF
         dl2A==
X-Gm-Message-State: AOAM5326TLqBoUCxNtwtBe2rQEj8G83sFQN/wVh1zspm9ZQFyOkgZ6jU
        vcBI12Khk/em6dD6yXib84vbaSjkUgDu77+qj9Eb/SHqN25LKa22HCzEEVXdmDecgM2mQOzAS9+
        IBhtLORe7hCAeSapPZW4SsgV9FKN3wIUH6lEd/cCAQA==
X-Received: by 2002:a17:906:6a26:b0:6da:873c:b9a2 with SMTP id qw38-20020a1709066a2600b006da873cb9a2mr647422ejc.727.1646845231650;
        Wed, 09 Mar 2022 09:00:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzrw1wchW3O6ryE+IVn5BJTWoAbUv5bAvi3pD7v2cxZRa7DtGFD01MOWRsewZfconSJ8erZ5A==
X-Received: by 2002:a17:906:6a26:b0:6da:873c:b9a2 with SMTP id qw38-20020a1709066a2600b006da873cb9a2mr647400ejc.727.1646845231437;
        Wed, 09 Mar 2022 09:00:31 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id h22-20020a1709062dd600b006dac66b8076sm944767eji.95.2022.03.09.09.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 09:00:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: samsung: exynos5250-sata: fix missing device put in probe error paths
Date:   Wed,  9 Mar 2022 18:00:28 +0100
Message-Id: <20220309170028.51913-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actions of of_find_i2c_device_by_node() in probe function should be
reversed in error paths by putting the reference to obtained device.

Fixes: bcff4cba41bc ("PHY: Exynos: Add Exynos5250 SATA PHY driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Rebased on top of (although it is independent, no conflicts):
https://lore.kernel.org/linux-samsung-soc/20220309124856.32632-1-linmq006@gmail.com/T/#u
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

