Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D0F507097
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353439AbiDSOc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353320AbiDSOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:31:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7618C37AA8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k23so33314738ejd.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2N/Ro8Ws00N9zI662d9l1Uiu28krkVVTLr3w9xUy4LE=;
        b=VkTpfjX53d6k+MKXNZ17GJFxNNwjHIX4otStVY0qaCFky7SWV1jEP88NkSV8z/b6JD
         uqXMYrjDPk4TsAP/Ld/W5wvHtr8h+7TCqJKHgPGSQVlyCGoWMKY53pOqQa2/eFCukxsQ
         BKx+rHKl+tgySR/zzxG7/r74pN0hzK7Ky+/AVF2ayxGtmjHH6av1GsceyY4Dwh5j3eBy
         /Xkb2fQFklMm65GUMwi0vwl+fI1cK8gVIuplHiT9GuZT31rMHm8Is0ERKMoKs21nZo9F
         FQxG3+zfj+WfVHpN4tiYjCR3R8NZ9pL8va6rRyKB22gMFXMCV2FXqu+zlwfUl3yxdSfC
         q9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2N/Ro8Ws00N9zI662d9l1Uiu28krkVVTLr3w9xUy4LE=;
        b=g7nl3FGmmDWWLqY8j26rG95mwQVL06uSVNTOwrpCuq66JKd33EMw5jaADYOGOj1eef
         IaXpbOF7jdLkqPs7sSCKVdkrB1BUV2QhXzYTjpNsVQBRua7+//uu/XO0FfML4AnbJOr4
         cOJSOsPAGH3iXnpWlzp5uMYb77hDag7o9h8Uj8tBtgyeF9NpVEfbo3OaI1n0TVXySfi7
         xTCGeK6cgeZosnlwmUGTj9jbrXVHsY0yJZWHPb7HAd7ywbOnsXBNZ1p7ihDUui8Yoqxd
         bbgZs8s0LJDMVeHhZYm56VrD86G1ksJA8wDJzvWSuGLxwDc3lBCOq+VjQGZbhXFkW8L4
         MZgA==
X-Gm-Message-State: AOAM531SVJ9fUUP9LM/pylGPVv+7e4qKIc7i+27Ejar0Rgc5rXk2qExL
        6h0rgIt71g02SRwLRCHisPC++Q==
X-Google-Smtp-Source: ABdhPJzotgX/HM13ib5WFyPurhgxFPdKifNZn2lb6iKuv5tvbGiSnyjrNsCjIf+iBtLGEWtPehJYtw==
X-Received: by 2002:a17:906:99c5:b0:6df:8215:4ccd with SMTP id s5-20020a17090699c500b006df82154ccdmr13791540ejn.684.1650378549067;
        Tue, 19 Apr 2022 07:29:09 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u10-20020a170906b10a00b006e1004406easm5761884ejy.93.2022.04.19.07.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:29:08 -0700 (PDT)
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
Subject: [PATCH 2/7] memory: emif: simplify platform_get_resource()
Date:   Tue, 19 Apr 2022 16:28:54 +0200
Message-Id: <20220419142859.380566-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220419142859.380566-1-krzysztof.kozlowski@linaro.org>
References: <20220419142859.380566-1-krzysztof.kozlowski@linaro.org>
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

Use devm_platform_ioremap_resource() instead of platform_get_resource()
and devm_ioremap_resource().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/emif.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index edf3ba7447ed..6c2a421b86e3 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1107,7 +1107,6 @@ static struct emif_data *__init_or_module get_device_details(
 static int __init_or_module emif_probe(struct platform_device *pdev)
 {
 	struct emif_data	*emif;
-	struct resource		*res;
 	int			irq, ret;
 
 	if (pdev->dev.of_node)
@@ -1126,8 +1125,7 @@ static int __init_or_module emif_probe(struct platform_device *pdev)
 	emif->dev = &pdev->dev;
 	platform_set_drvdata(pdev, emif);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	emif->base = devm_ioremap_resource(emif->dev, res);
+	emif->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emif->base))
 		goto error;
 
-- 
2.32.0

