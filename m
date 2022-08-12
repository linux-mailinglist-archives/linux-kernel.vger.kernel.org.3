Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57657590D63
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbiHLI2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbiHLI2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:28:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A13A8943
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:28:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gk3so794417ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YtXfWrLU1BZPc0rfRaWUKHk31M+JfVKZR86pVQ/2Egk=;
        b=UzrkX0IxhkIOXzUyXy0xY8Pll/YDDoDIG7iHl3U+UObYWU6CeqAZ3hcuERe48Eg4qj
         cV2/S/42bnyKsJY1Si7MlZEp5/u4Wrf87aCqSvdBIulw5gLv/3RRZ3uJZYOiJofkZ9Y2
         KEhuG+yWXpjouBuYLYdfniUlwiOWgmCv6E00nCK+SPNXnWJ/sdthIkFtZTnhRkuzTBJz
         n0MPn7fLsJU7m2vNk/p07lG0AK1qejrV3+dRBJxRmDPU38AO3Ifuu7uVk4JARAkrruB8
         3SBPXHwiQIkGe0dhUtIBBZWwFvkzYroUPIJcpzxCqd/9r13jF+8wFglO+UmMWtrGYEz9
         kvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YtXfWrLU1BZPc0rfRaWUKHk31M+JfVKZR86pVQ/2Egk=;
        b=76OdMDC5Y3niP+3J+zS/Ql1qY3WjgaCWV65Vwh/qtcJL6ZLig8iWxneLbO9oMreY29
         WPMP851VLDv4L/JJcbXpHQ286nML32mYSQ/wlyMbM5Os5fqsKrk/YgVBASu8/+jS9C+L
         1O6nh8gHp+B+2pqye8ENCXot2s4/K34RTyLEqaA8qYw5MoTenqsW7EkhEN/B6pUo34mN
         nOInwO6sesqVHOywZYhm7+ETXnVagBk6vxI0sGGJDwxCem9JHNycnDm4sxF99FKVaALf
         rMRZq839xWgw0257eqo6REAiPv2aAbFOk4Q7TiLL85h/sWedFaA8tJ6DRy0baTLUliSY
         HccA==
X-Gm-Message-State: ACgBeo3SWB/eFkOh4oyXuQobLGNGnnyZwRftC9/eNTn6IQeHQk5i4csX
        UMCZXaiNDUzTRYCqJPpbdkcZDQ==
X-Google-Smtp-Source: AA6agR7S1IBFsA6x0Q1AZL0/ULItvXSqg/Ku54We6vkcsLprZSGLimKyiRcd6EL7RotjPHmIr9Qkow==
X-Received: by 2002:a17:907:842:b0:731:3310:4187 with SMTP id ww2-20020a170907084200b0073133104187mr1879973ejb.578.1660292884039;
        Fri, 12 Aug 2022 01:28:04 -0700 (PDT)
Received: from otso.arnhem.chello.nl (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id y6-20020a056402134600b0043cf1c6bb10sm971326edw.25.2022.08.12.01.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 01:28:03 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: sm6350: Add GPI DMA nodes
Date:   Fri, 12 Aug 2022 10:27:21 +0200
Message-Id: <20220812082721.1125759-4-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812082721.1125759-1-luca.weiss@fairphone.com>
References: <20220812082721.1125759-1-luca.weiss@fairphone.com>
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

Add nodes for the gpi_dma0 and gpi_dma1 which are (optionally) used for
various i2c busses based on the qup firmware configuration.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 59 ++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 76f14d54ae1c..5de6eb26f904 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/clock/qcom,gcc-sm6350.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
@@ -517,6 +518,26 @@ opp-384000000 {
 			};
 		};
 
+		gpi_dma0: dma-controller@800000 {
+			compatible = "qcom,sm6350-gpi-dma";
+			reg = <0 0x00800000 0 0x60000>;
+			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <10>;
+			dma-channel-mask = <0x1f>;
+			iommus = <&apps_smmu 0x56 0x0>;
+			#dma-cells = <3>;
+			status = "disabled";
+		};
+
 		qupv3_id_0: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x8c0000 0x0 0x2000>;
@@ -537,6 +558,9 @@ i2c0: i2c@880000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_i2c0_default>;
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -550,12 +574,35 @@ i2c2: i2c@888000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_i2c2_default>;
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
 			};
 		};
 
+		gpi_dma1: dma-controller@900000 {
+			compatible = "qcom,sm6350-gpi-dma";
+			reg = <0 0x00900000 0 0x60000>;
+			interrupts = <GIC_SPI 645 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 646 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 647 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 648 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 649 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 650 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 651 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 652 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 653 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 654 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <10>;
+			dma-channel-mask = <0x3f>;
+			iommus = <&apps_smmu 0x4d6 0x0>;
+			#dma-cells = <3>;
+			status = "disabled";
+		};
+
 		qupv3_id_1: geniqup@9c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x9c0000 0x0 0x2000>;
@@ -576,6 +623,9 @@ i2c6: i2c@980000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_i2c6_default>;
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -589,6 +639,9 @@ i2c7: i2c@984000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_i2c7_default>;
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -602,6 +655,9 @@ i2c8: i2c@988000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_i2c8_default>;
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma1 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -626,6 +682,9 @@ i2c10: i2c@990000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_i2c10_default>;
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&gpi_dma1 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
-- 
2.37.1

