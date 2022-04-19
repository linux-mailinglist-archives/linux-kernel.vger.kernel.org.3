Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A071C507089
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353604AbiDSOcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353383AbiDSOb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:31:58 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83D238D90
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lc2so33263949ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ynz+wXsaKci/uCPa0T2egAwOljY4OEI2Not830eyYso=;
        b=GlWac5GHq4bFI2oMKXg1MyPfzXSaMwipfkARfjnZ5YqX1HUSIyuw+Y4MTxwtW6Wo6y
         Lkuot2RbGwKK46iIxOBVUhx5fhUMVAKtxeAv4JRC+F2+VLuyBRGJGhUL+5OfjacMArPp
         kZiNr7sdyXvNbaVwS3ghptVeG6X4LJXm/64uwgH2S+GNSoBsq7vJLF/eUCAF26JRtNTP
         JXPHmcOy2X4E8UuGq0w9l1VogtqMBtEvDdjEvRcJ569QjhstCXoCTcstSUqCFyzTC682
         8cuopAxbp6V2apVkZliSdCoKkKL5Br9XG/SdZ6gReLbhl3tBVuEmHi6SmQ4n2mAXCVwZ
         B1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ynz+wXsaKci/uCPa0T2egAwOljY4OEI2Not830eyYso=;
        b=ZnOZrMWJFbrchPe6wHoC42Y/LeOXd3str/nepGhZOrEeoI9SpIH+Rp9oO0bBGt8SyB
         Hy9T7OzuWcsiwKrWEtSEk5QSq2Y1FxnjgC15ocqRyYIUl5+wMl7geVKSSlIn6bNYhbwU
         ifd5hlHX4Ubn3mIj7pBMr8npYkvKYuWn2aDmKtOMtB7rXCF3h+hPRVN0AYI0i9fXnRBS
         wP6wgAU984ZO3AgrgroQopvoYxdr7cNhLrOpL8gywQGnwgERNYRkrRf+/O+Yt8/V+SQf
         KkD2/GsFdmQ5MKqaBz1TvEqt3KkRIHm4hkGAWqywGz40Uo2mLXz+v6V97qZ2fH2+9YNZ
         wzaw==
X-Gm-Message-State: AOAM53025ad9w5bIEiP4kSFytzQmwGKmjEVoQaaSLnuTxmP9TKSyGFtl
        lj7ZIP+LcGPGpDE+ReLtHdGgXQ==
X-Google-Smtp-Source: ABdhPJyAwjk70JTjJB+moeKuDW1E4dkWfB+u4jhaJ0VsVEhrDbhVshcuFYPOkdMHO3UzR71ZTSm85w==
X-Received: by 2002:a17:906:d10c:b0:6cd:4aa2:cd62 with SMTP id b12-20020a170906d10c00b006cd4aa2cd62mr13605827ejz.229.1650378551397;
        Tue, 19 Apr 2022 07:29:11 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u10-20020a170906b10a00b006e1004406easm5761884ejy.93.2022.04.19.07.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:29:10 -0700 (PDT)
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
Subject: [PATCH 4/7] memory: ti-emif-pm: simplify platform_get_resource()
Date:   Tue, 19 Apr 2022 16:28:56 +0200
Message-Id: <20220419142859.380566-4-krzysztof.kozlowski@linaro.org>
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

Use devm_platform_get_and_ioremap_resource() instead of
platform_get_resource() and devm_ioremap_resource().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/ti-emif-pm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/ti-emif-pm.c b/drivers/memory/ti-emif-pm.c
index 179fec2da56d..31d6266f008c 100644
--- a/drivers/memory/ti-emif-pm.c
+++ b/drivers/memory/ti-emif-pm.c
@@ -290,9 +290,9 @@ static int ti_emif_probe(struct platform_device *pdev)
 
 	emif_data->pm_data.ti_emif_sram_config = (unsigned long)match->data;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	emif_data->pm_data.ti_emif_base_addr_virt = devm_ioremap_resource(dev,
-									  res);
+	emif_data->pm_data.ti_emif_base_addr_virt = devm_platform_get_and_ioremap_resource(pdev,
+											   0,
+											   &res);
 	if (IS_ERR(emif_data->pm_data.ti_emif_base_addr_virt)) {
 		ret = PTR_ERR(emif_data->pm_data.ti_emif_base_addr_virt);
 		return ret;
-- 
2.32.0

