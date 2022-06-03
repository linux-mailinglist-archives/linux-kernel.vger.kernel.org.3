Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9389953C7EA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243241AbiFCJuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243217AbiFCJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:49:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5639D2494E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 02:49:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id er5so9433025edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 02:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ums06lpbM+PTGvsWcIDhEEbhw0J/2ZTCTZEOaQpH01c=;
        b=atYIgWK/6FRawaETkeUwdXYIh+5RCPmZ6VyzX0t1MxzCN7gsZGXo89BKMBDxxpxCbw
         ESnWPHa3fkokCeYzHS7HI/ToXVIi+ZqW9WQ5Fhvbkhnx1eANmO222pfUml31+LYrH2y7
         EkW/Ww2cZdpMyFu8XuHwezN3rEDD/utnsi2LIR7+vzN0vaRMlSLbd5MbeeTUoQGcHGY3
         Z0bRgDr7z7LoDz60cBWExz+ScIQXHVfa8lXxnOT1iNM9rg2dljw1Giy0PdKw4F+sdgeu
         BvVn0XDB3Ww6dfdY5j8wOqGk/5DHoFQ/PdN9AJ9AGjYtEFACIM0l173LQDYeZNPB9Vyt
         VxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ums06lpbM+PTGvsWcIDhEEbhw0J/2ZTCTZEOaQpH01c=;
        b=en6B6/4Ehp4tfybT0j8NYjkY8H5co42lDhR9c2irVJbwBdKzT8t5sa6wS1aJwWKrRw
         T+Rfxqt8ZcRLnUrOpwqlBBEkD/cVRmAmjsIlhADRG6QkeTo0O/R3rgkF8W0epA1U7cc4
         KWH/7qPObMcPabLifTUgp/N6Ms2978LXr6ja/pSmI3I9C6UfeYo+ONui2ikBVwvCiaZt
         F8LiuQZGnJ1zuDXYDzxmqpt9DUD3KU8q0h3dD4NAVwqZVmdjKY0/DSeyVlF9JQJutPAx
         ptSKsY6fA3zWl70qaPdKbdqEID5bnxcEvSpjkgmgMt1ZVPcdLZ8+mjrqH6N12EqQgx4H
         16Zg==
X-Gm-Message-State: AOAM533GKB6VEddljDa70ycwUGmArBEbaC9CN6QtSW78YCGYNnotTNIS
        y9DcrXfnjequAmKAdpuasiwk3g==
X-Google-Smtp-Source: ABdhPJzrd3PUALKrqr7kQ7Hn+0AluZ6uwepz5o7BbwOoD/e3jxFINqcWp42bWORfoFn+OT2gGlztHg==
X-Received: by 2002:a05:6402:e99:b0:41d:11f2:85e0 with SMTP id h25-20020a0564020e9900b0041d11f285e0mr9670216eda.339.1654249793985;
        Fri, 03 Jun 2022 02:49:53 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y22-20020aa7ca16000000b0042dcbc3f302sm3669561eds.36.2022.06.03.02.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:49:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] arm64: dts: exynos: align MMC node name with dtschema
Date:   Fri,  3 Jun 2022 11:49:45 +0200
Message-Id: <20220603094946.509919-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220603094946.509919-1-krzysztof.kozlowski@linaro.org>
References: <20220603094946.509919-1-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and MMC controller dtschema expects
"mmc".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 75b548e495a0..bd6a354b9cb5 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1820,7 +1820,7 @@ usbhost_dwc3: usb@15a00000 {
 			};
 		};
 
-		mshc_0: mshc@15540000 {
+		mshc_0: mmc@15540000 {
 			compatible = "samsung,exynos7-dw-mshc-smu";
 			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
@@ -1833,7 +1833,7 @@ mshc_0: mshc@15540000 {
 			status = "disabled";
 		};
 
-		mshc_1: mshc@15550000 {
+		mshc_1: mmc@15550000 {
 			compatible = "samsung,exynos7-dw-mshc-smu";
 			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
@@ -1846,7 +1846,7 @@ mshc_1: mshc@15550000 {
 			status = "disabled";
 		};
 
-		mshc_2: mshc@15560000 {
+		mshc_2: mmc@15560000 {
 			compatible = "samsung,exynos7-dw-mshc-smu";
 			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
-- 
2.34.1

