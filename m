Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF564507091
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353574AbiDSOcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353372AbiDSOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:31:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B972D38BF4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g18so33292913ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9ycsKLgtbrDvPBZQp/V5BOPcgPxcbdE+L/fSZOvoL1k=;
        b=mWcZfCB9WwT4sr/dCQ2dVSMQVrpi4j9AimPSecRSrzqvvjRTU563LgPuYfkU2X9yft
         hlsSwlKSs6VX85oXN5CqAvuueaVEeZhLiWDWRTeSyDTwQhA3fOoUd+5NwMFBz8xlIo8z
         46RKukuYuQ5uSAFP/1X7aMxIYLdc+4oIImo0oSFqHxhlpV5RI/AMAqWMXM3cO1HdtYh1
         69ZNh37WQt3Z/Bm90OQcVMH/DTknE7Bc3xiTRG8dHwuTxi2+fToBsMw7o4y+xpEGNYO0
         xdMPWXNjGKbcHIlxTWY1ElZnPH1jiSZPHnYN25Fhl3b21iwnvqHyHsEWpsb6SFsqfiCW
         SoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ycsKLgtbrDvPBZQp/V5BOPcgPxcbdE+L/fSZOvoL1k=;
        b=HiRyLstvy+aJpS9373V4ULqudBwtNBBQ79LW7GmK4ve1c/2qL3/G/m7buWqdM3NljH
         9y0zOklK1wyKP1cByADqffsjo8eVGIotRIURfqQsMuWFfL0g5x81E/+2sEKqYMTdbF+s
         WD0h6xmdSPA0dlbwikAsPTq1HKGeuuwsbvaEoz15e8EEX3uq42WkffnQ7wy4+gzEgkzo
         HFloS215P9MzzB0LCZI5T1uyigp1LX6mJaNwyXnXxq2sj7pTaYjJw8Zvr9mTwh/jsE0f
         psWMU2/NcjPpmiiphM064qeR130ivj6Hh5jTONzIlitM2Q7bgQ2uYcUmMa7NaGsq1Q56
         cOlA==
X-Gm-Message-State: AOAM5332TI8jVT76aKnhvcJkvLImZtkLSTlu0jMkSaaU7CqXzGT93nan
        KuXeBrqd8y770xXq3KwUNcq7tA==
X-Google-Smtp-Source: ABdhPJxtgiL8brvjHKi1NQt223Se/3569MkYsfsTAdEFzWH0xdJ13oU15IQOKY5xU3fQRfK57x2OFQ==
X-Received: by 2002:a17:906:c10e:b0:6ef:8d09:bffd with SMTP id do14-20020a170906c10e00b006ef8d09bffdmr11125816ejc.135.1650378550281;
        Tue, 19 Apr 2022 07:29:10 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u10-20020a170906b10a00b006e1004406easm5761884ejy.93.2022.04.19.07.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:29:09 -0700 (PDT)
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
Subject: [PATCH 3/7] memory: ti-emif: simplify platform_get_resource()
Date:   Tue, 19 Apr 2022 16:28:55 +0200
Message-Id: <20220419142859.380566-3-krzysztof.kozlowski@linaro.org>
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
 drivers/memory/ti-aemif.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 51d20c2ccb75..f81e7df8798a 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -328,7 +328,6 @@ static int aemif_probe(struct platform_device *pdev)
 {
 	int i;
 	int ret = -ENODEV;
-	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct device_node *child_np;
@@ -362,8 +361,7 @@ static int aemif_probe(struct platform_device *pdev)
 	else if (pdata)
 		aemif->cs_offset = pdata->cs_offset;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	aemif->base = devm_ioremap_resource(dev, res);
+	aemif->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(aemif->base)) {
 		ret = PTR_ERR(aemif->base);
 		goto error;
-- 
2.32.0

