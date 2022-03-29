Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622234EAC4B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiC2La6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiC2Lax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:30:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD863215919
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:29:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b24so20305702edu.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oeY2VwpzFpq+ahpdKff0SvoKtIxVNW39tqhBA+XG7Pw=;
        b=E3iUpWr4K4oxsFdairIy8IPoKPb8A5Z9Rslrnt5uD7TA7OjHlP6XEs0leXi7BYmlBB
         fX/Gywja0ECNstL71d5ys63cDrvYqHdvg+7kHSQiJo4AqCViS54TzaSWPvdBlkqhwTDt
         VzO0T/Kn2Kn7IK3KDtSczaWwM3FNeXyRb5h8ABt+mZnlSEnueTR3vgruqeBSfo62E8Fi
         /aqtKuwk6/wBo+dTHNsEfFzth4cIOiBH8drVIleVLMNjGnnSBCXrf7nvK4gWyV8rwb6v
         pOrs9FchbOYtiKniYqdpSM0gEeWeqR1sPo2wBPy21TAYL34bM9oaDqM1lI5uSnDPSJNR
         3XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oeY2VwpzFpq+ahpdKff0SvoKtIxVNW39tqhBA+XG7Pw=;
        b=Q9ugvRXsmbDeLVckJKB1sPkcUI4t41RwULcTK5mY+QpFoONKdL2Of8dOtZTV1hknb3
         ts7oQtRnmJsCKUaUqL2IVYMzC4kxu3ncflUVKrAQrfLkO2IqIO77xIqyhAy5AVBRF0Dv
         JZSDRYunNqOuyZskVI7qR8+g0q9IwpYjf4c188HTe8gikXwakgNgpNZ3BDmqjfOi90wE
         58LgUF9d4FyOAxaax+yitLqEVGMgX9KctCjxbG0k9mst92vHLYXSele/h7NlZlSgCKkh
         0Uf4hvLueGUHjgqrgm6hdvXzRrLaA0jNsLnOL7TXVj2SM15Fm0NqG2Q/0K8zd1qLL3V7
         S5GA==
X-Gm-Message-State: AOAM531L7voQQJBIX3varw3vlGNqHK2oVISkG7nC76c/hAbSj2blIfHo
        yvKVVNSU8o81Kz2eruP/X83yRXVDDZR49hPZ
X-Google-Smtp-Source: ABdhPJyL9/o3X64nZeOHCAVP2P8R0/sQb/sL5/MrwdEeHc4B16wUTFqJuM59hyR60G29ny1CUz4JXg==
X-Received: by 2002:a05:6402:34c4:b0:419:e00e:64c1 with SMTP id w4-20020a05640234c400b00419e00e64c1mr3978193edc.88.1648553349028;
        Tue, 29 Mar 2022 04:29:09 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id t19-20020a056402525300b0041952a1a764sm8510909edd.33.2022.03.29.04.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:29:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: qcom: msm8916: align dmas in SPI with DT schema
Date:   Tue, 29 Mar 2022 13:29:00 +0200
Message-Id: <20220329112902.252937-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329112902.252937-1-krzysztof.kozlowski@linaro.org>
References: <20220329112902.252937-1-krzysztof.kozlowski@linaro.org>
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

The DT schema expects dma channels in tx-rx order.  No functional
change.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index e34963505e07..6e5e7883c747 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1529,8 +1529,8 @@ blsp_spi1: spi@78b5000 {
 			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp_dma 5>, <&blsp_dma 4>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 4>, <&blsp_dma 5>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi1_default>;
 			pinctrl-1 = <&spi1_sleep>;
@@ -1561,8 +1561,8 @@ blsp_spi2: spi@78b6000 {
 			clocks = <&gcc GCC_BLSP1_QUP2_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp_dma 7>, <&blsp_dma 6>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 6>, <&blsp_dma 7>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi2_default>;
 			pinctrl-1 = <&spi2_sleep>;
@@ -1593,8 +1593,8 @@ blsp_spi3: spi@78b7000 {
 			clocks = <&gcc GCC_BLSP1_QUP3_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp_dma 9>, <&blsp_dma 8>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 8>, <&blsp_dma 9>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi3_default>;
 			pinctrl-1 = <&spi3_sleep>;
@@ -1625,8 +1625,8 @@ blsp_spi4: spi@78b8000 {
 			clocks = <&gcc GCC_BLSP1_QUP4_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp_dma 11>, <&blsp_dma 10>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 10>, <&blsp_dma 11>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi4_default>;
 			pinctrl-1 = <&spi4_sleep>;
@@ -1657,8 +1657,8 @@ blsp_spi5: spi@78b9000 {
 			clocks = <&gcc GCC_BLSP1_QUP5_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp_dma 13>, <&blsp_dma 12>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 12>, <&blsp_dma 13>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi5_default>;
 			pinctrl-1 = <&spi5_sleep>;
@@ -1689,8 +1689,8 @@ blsp_spi6: spi@78ba000 {
 			clocks = <&gcc GCC_BLSP1_QUP6_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-			dmas = <&blsp_dma 15>, <&blsp_dma 14>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
+			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi6_default>;
 			pinctrl-1 = <&spi6_sleep>;
-- 
2.32.0

