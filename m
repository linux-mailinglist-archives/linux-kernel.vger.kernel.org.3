Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14660569737
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiGGBKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiGGBKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:10:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CDB2D1DA;
        Wed,  6 Jul 2022 18:10:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u12so29817208eja.8;
        Wed, 06 Jul 2022 18:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+jHWIY2YSdrFjsb7SITOmNywGPRwpwNzxjK0A4jYIk=;
        b=iITrxxZ3LPuYbfjO//m0evPxzVgZj99uSWjySaxBJlc+dVIHFa3gM7T8ePin1bYsSK
         oKvGTET1d7+XJs5noOSzZ5Yuaa5vU85ZdqkZ/Vyom+/wY5Ugh3Gq/0C64F1v5czSJ2O7
         lRTzcwa6rr00TZwBPiQ18RBPeH8YpcLFaC1U37iazGpYZ4W/iUHuyaFmxF6px84J+2UJ
         9Xq405MkuRHs0Smjg8ECOByAjn8H1u7f1T9zl5RPc5pFyTCiZCQ8JK57Hk+qjOpKtxZC
         TgyAAOb6LdyPrCMufQaXC7yJmMqGOWogspiGMpYEYYIMGxG0+otDFkBRXaiV78P9Csid
         M6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+jHWIY2YSdrFjsb7SITOmNywGPRwpwNzxjK0A4jYIk=;
        b=gO3//+T10U8lZY2r3WZh8+yjnLBy64IIOpMHukRu5d3QeVmgrkSnzygC0Y5g3yCRsc
         tT5B5mI03olRsX931n2U+1SyONJ1qR4nLUYE9cjaoq4nGWElherK47lKxkKGM1kNlCxh
         9+qejmAIu0uTz8NqXH8MmNmYKKcA+A8jXffzEm1CKfxizApvbNZ1dEINZ4qgY8QUGOMy
         odHRghIlf/tNbeIckzqWG3gpj7IHYwDz+uCIAbEUWaQh6OAQ3mO6y9IrVRIVHdzxt8BC
         nmgYNo3yygB18ci3qBVKTNAc7uQ75rqgaP3X21cbNF2b+OsixzF1WuETWa8R1yo6hay5
         0xag==
X-Gm-Message-State: AJIora8Q/INfb1/Rw1B0JWLq89dfqFELOG0JHS7NFtwa3P2njj7H6T1S
        aKVnIGdVh5B/LpMA9RndW+k=
X-Google-Smtp-Source: AGRyM1sVZQM62n8HhzmQLeVMmbIfJmqtLwQxYymCef8hUd44AoMreg85GCIjWXcQ55iET2M8jInHeQ==
X-Received: by 2002:a17:907:d18:b0:726:3172:2266 with SMTP id gn24-20020a1709070d1800b0072631722266mr42268550ejc.476.1657156208111;
        Wed, 06 Jul 2022 18:10:08 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id u17-20020a056402111100b0043a6e807febsm6915464edv.46.2022.07.06.18.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 18:10:07 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/8] ARM: dts: qcom: add missing snps,dwmac compatible for gmac ipq8064
Date:   Thu,  7 Jul 2022 03:09:38 +0200
Message-Id: <20220707010943.20857-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707010943.20857-1-ansuelsmth@gmail.com>
References: <20220707010943.20857-1-ansuelsmth@gmail.com>
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

Add missing snps,dwmac compatible for gmac ipq8064 dtsi.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 7cccfe99bf00..a80090f5509e 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -1042,7 +1042,7 @@ stmmac_axi_setup: stmmac-axi-config {
 
 		gmac0: ethernet@37000000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37000000 0x200000>;
 			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -1066,7 +1066,7 @@ gmac0: ethernet@37000000 {
 
 		gmac1: ethernet@37200000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37200000 0x200000>;
 			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -1090,7 +1090,7 @@ gmac1: ethernet@37200000 {
 
 		gmac2: ethernet@37400000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37400000 0x200000>;
 			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -1114,7 +1114,7 @@ gmac2: ethernet@37400000 {
 
 		gmac3: ethernet@37600000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37600000 0x200000>;
 			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
-- 
2.36.1

