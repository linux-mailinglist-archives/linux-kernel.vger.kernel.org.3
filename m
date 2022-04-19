Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF4E50708E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353630AbiDSOcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353387AbiDSOb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:31:58 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E244D38DBC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k23so33315083ejd.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=i/hN55LeSGds7voIOUUoPsxviI3bjusf3r96NnDo1ow=;
        b=erc++na5IYszO5wD8taOo41/Sz64NrybRt5aDQ637rH+Ye2Hxzm8HHUbZd8DwQgcrc
         oLKz/qmjWVgptv4zdgb+jWJQuh2VzG+y97ql+s9Cemx+YtjY1bAgSbuz2qc2uNDTcnxE
         ZBp19VX7rDBux4a8y/vHiFalDlOUpRRTdPNcqcxF6BM1Hm/YPz8A5LACIQeR0nrDr4b3
         BlE7zCxwyfStUbGKZhVFrZH4J/92UGg5Aq/1bKmMYAr/Pt9oky2gVvoVnAWvVNoSY7w7
         7hL5n/ow2UEPRI8OTRqNAHBT0ws+XPbo7qGS/AYiMQCBt35EcMa3OjiVdZL1Fw35c8tl
         Ihug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i/hN55LeSGds7voIOUUoPsxviI3bjusf3r96NnDo1ow=;
        b=59R/SoV2qt1pAyytZyXh/1vrjTC0eRs0Saqwld/JRPy6mbazifWxukyA1vpuBs0m2F
         e7KWBzMn/qIW6g3wJbHAsheApLCaiVbxm6OilZv+//6PgWpMPvgxStReaR8fTlLpVyNC
         egSKaIxpu1+uvJCtqh9iz37oGFBgTpUMJDeXByDvcSlTmDhV6Cog/JvmZyM+HI9VwLoj
         WAIOed3H1ElaFTlRUl1aGqncjUttXzF2OXs6GENe4O3Bqrjq5luku2kxIjKSpLTtZt6a
         wF/M4O8VwBzNWYOwGhQ5PVepECOk/PFrmFBH2EhfCmcBkMnnEH+Qo0CtvTDn+ELuN78Z
         0icQ==
X-Gm-Message-State: AOAM531QcrZLo/ASjPLKtvkITDK1YjsGZ2EI8GEpBu9HO8pIdYT7LJYu
        DOZ7qJ2rcax0zbnfe9/gCFs6wg==
X-Google-Smtp-Source: ABdhPJzA/phqkEgE3akbqqYpR+ZmzvEjslSTWMBd8zP7oXLh9y3yzspwHeL2fRi5vV+x4YEpvDUobg==
X-Received: by 2002:a17:907:7811:b0:6ef:a896:b407 with SMTP id la17-20020a170907781100b006efa896b407mr9053271ejc.645.1650378552458;
        Tue, 19 Apr 2022 07:29:12 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u10-20020a170906b10a00b006e1004406easm5761884ejy.93.2022.04.19.07.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:29:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 5/7] memory: tegra: mc: simplify platform_get_resource()
Date:   Tue, 19 Apr 2022 16:28:57 +0200
Message-Id: <20220419142859.380566-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220419142859.380566-1-krzysztof.kozlowski@linaro.org>
References: <20220419142859.380566-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() instead of platform_get_resource()
and devm_ioremap_resource().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/mc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index bf3abb6d8354..580e0987e5cd 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -719,7 +719,6 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
 
 static int tegra_mc_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct tegra_mc *mc;
 	u64 mask;
 	int err;
@@ -744,8 +743,7 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	/* length of MC tick in nanoseconds */
 	mc->tick = 30;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mc->regs = devm_ioremap_resource(&pdev->dev, res);
+	mc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mc->regs))
 		return PTR_ERR(mc->regs);
 
-- 
2.32.0

