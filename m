Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7E853DD1D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351303AbiFEQh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351253AbiFEQhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:37:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67D413F35
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 09:37:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q1so24801974ejz.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kLBqK+sVHzWIIm5nOxMG+Dh2jn0qvbbmZtBkyosv5yg=;
        b=QZGzB5GulN3hGDiDLmNiJ6dfpnmU7aXQXZLlHqbWfkV0U0TXe1DJEsfWeJcWj4qfw9
         xv8ikbJ9i+OIuwv16arEwfV5FNu6YewNe13GNTacFqHHJ4Z/ph2DPTKewozv/no2QN/h
         Ojc0Ik/ZtR3Oo9BKbGioelha1MMmih9/Cil0ZAY/M1JfXrxmtRF6c/7L7DKXStW3Gn9Q
         mCCeUiUSwAsKvhGpQ2Y6ISPl/d/aqHcY0NGt1oF1an4HagED8OKRBmOmRhbN0o9kNq52
         qb0LZsM/ZOvSSNs2c85sT/Z+RP73iVvlf4Ui7t3YV47yivEWAzR2odjNztVKQiakl1Wp
         8jJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kLBqK+sVHzWIIm5nOxMG+Dh2jn0qvbbmZtBkyosv5yg=;
        b=uD42aAR4GlHOsnwKDbBQs0ILKpEzHRqRwFh5kXtErBl8/cXo29hpGLtWa5SMr+Ul6f
         aTExG9tzFz92loT22HNdZRsAC+kahSy4/MqXMR00Rh8JGWl/4qaqnMr9AEE1bTrUNzIm
         Si1vMLMgZ5NjINo6xzT2YkE+TrZd+PqYSTSaDjm+QTgbPkUSVI18IJvk1+4w+1iTWk6k
         8ze+n+MAh+y7ilipg7wEZH2QWZ0pUinyYAdSyyUYVBfQnYk50TpksE1Z2H6GGAiTdYPf
         JnfSer1rtVd5ziGAW0PP6scBeiOyBkCbju3TYCLktUssNYmTBdfaNVVjOATnRsOkVQL3
         JrNQ==
X-Gm-Message-State: AOAM531pYlJ1azWx3DYuGViUR+DHlb2JmEV7N9GCDZW5ozcAIhsZV1eh
        dbTcFVq8clYzjSUSkVkzyrWADQ==
X-Google-Smtp-Source: ABdhPJw0vMT3Z5as/3FZQ7GtHPAJkrpVc6moQUIzNKf75xDddQKMgwbZ1pmtCRgnI2Xr+q3ImBW3VQ==
X-Received: by 2002:a17:907:2ce3:b0:6ff:153f:5372 with SMTP id hz3-20020a1709072ce300b006ff153f5372mr18355052ejc.197.1654447036327;
        Sun, 05 Jun 2022 09:37:16 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w3-20020a1709064a0300b006ff0b457cdasm5346770eju.53.2022.06.05.09.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 09:37:15 -0700 (PDT)
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
Subject: [PATCH v2 1/4] ARM: dts: exynos: align MMC node name with dtschema
Date:   Sun,  5 Jun 2022 18:37:07 +0200
Message-Id: <20220605163710.144210-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220605163710.144210-1-krzysztof.kozlowski@linaro.org>
References: <20220605163710.144210-1-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 78dad233ff34..326b9e0ed8d3 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -376,7 +376,7 @@ hsotg: hsotg@12480000 {
 			status = "disabled";
 		};
 
-		mshc_0: mshc@12510000 {
+		mshc_0: mmc@12510000 {
 			compatible = "samsung,exynos5420-dw-mshc";
 			reg = <0x12510000 0x1000>;
 			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
@@ -388,7 +388,7 @@ mshc_0: mshc@12510000 {
 			status = "disabled";
 		};
 
-		mshc_1: mshc@12520000 {
+		mshc_1: mmc@12520000 {
 			compatible = "samsung,exynos5420-dw-mshc";
 			reg = <0x12520000 0x1000>;
 			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
@@ -400,7 +400,7 @@ mshc_1: mshc@12520000 {
 			status = "disabled";
 		};
 
-		mshc_2: mshc@12530000 {
+		mshc_2: mmc@12530000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12530000 0x1000>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

