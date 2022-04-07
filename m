Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26324F81C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiDGOfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344048AbiDGOfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:35:05 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC331AA041
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:33:04 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id qh7so11183030ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0TAzQQyPNU1EgPS8VUfo26k9TNfuGUl3earvG+VF99I=;
        b=i38AwXcU2ZfWid4WOd8yC6nFL/X1PwlRH5WJNl1Ubox53GScaSDBSn6UqI9G3inbD8
         7Lu9OpTVfqf/vgA9UjRw/333sDKlaf6VKbPM42T924BghK3JQuQxHaDbISGOiLPGV9Fq
         AktN2SqJymOGfavyOXDqCu2Nd1j06/HZjw9ju+Y40yacPWXajJ1XEl6zC1MfuSdUozqg
         KkXfEWsbf5uU/W43wwEmJJKy+yF45gHriGq2GUowK0YRTXjvyLLp7oxT/9c1GZ0pBgi0
         EAYk58AgNI2jCXG5qvz7V6UaVfu6p2XNKmGKOLKmVQGIpzglubdp1R1NNAyIEN92PbrY
         b2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0TAzQQyPNU1EgPS8VUfo26k9TNfuGUl3earvG+VF99I=;
        b=qMBfeZYdvnyJMwNyAGxXVKRmV1QAxKgAmwaHiLTopw/jmxtPrt1TRKWqGXLYmOGqCS
         IfMEGYF9Ho5eKtqeKIeH2U91xY+izNyBEs+9jD63OdbUDZsEExWiCmRZq2qNyl+qPnws
         4EvapG9SI2Lmcego57AK0QVm2JpdasUWESoqVD0iUabaKIG+cJxjEYHNNThQjfMd66h+
         96RQ1Epg+B2MBiGJLvKxViSzGrqWySQIq3NT4/QOJcOizMxhPBi/Bh+nE4z9eg1v5AZN
         dGR48lHIBn5LM8GUy11FmWkr7aj6+fW6A0j5VCXSX4/zSn5wrtifOGuaQVbO7ISCF4Mg
         5sEg==
X-Gm-Message-State: AOAM532yllyTF0P4WXyBcQYqwlarOaPlo2R1z0BMcgIyh7RxfflffQdB
        wSRtPJBdnQZcWuBGrOv4gK8szQ==
X-Google-Smtp-Source: ABdhPJy8PYhwc89e2VGBuc6MZsvxcFC02HNAPZvqr4IO8NBMMzByoyS5099bZvJ5EKHPk2yrUP9kPw==
X-Received: by 2002:a17:906:60d4:b0:6db:f0a8:f39e with SMTP id f20-20020a17090660d400b006dbf0a8f39emr13611261ejk.54.1649341922301;
        Thu, 07 Apr 2022 07:32:02 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id fy5-20020a1709069f0500b006e841c87243sm236526ejc.64.2022.04.07.07.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:32:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: freescale: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:31:55 +0200
Message-Id: <20220407143155.295187-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407143155.295187-1-krzysztof.kozlowski@linaro.org>
References: <20220407143155.295187-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and SPI NOR dtschema expects "flash".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi     | 10 +++++-----
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi        |  2 +-
 .../boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi   |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
index 10d2fe091965..6fab73d484b6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
@@ -104,21 +104,21 @@ &i2c3 {
 
 &dspi {
 	status = "okay";
-	dflash0: n25q128a@0 {
+	dflash0: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p80";
 		spi-max-frequency = <3000000>;
 		reg = <0>;
 	};
-	dflash1: sst25wf040b@1 {
+	dflash1: flash@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p80";
 		spi-max-frequency = <3000000>;
 		reg = <1>;
 	};
-	dflash2: en25s64@2 {
+	dflash2: flash@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p80";
@@ -129,7 +129,7 @@ dflash2: en25s64@2 {
 
 &qspi {
 	status = "okay";
-	flash0: s25fl256s1@0 {
+	flash0: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p80";
@@ -138,7 +138,7 @@ flash0: s25fl256s1@0 {
 		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
-	flash2: s25fl256s1@2 {
+	flash2: flash@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p80";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
index 4b71c4fcb35f..f8135c5c252d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
@@ -100,7 +100,7 @@ &i2c3 {
 
 &dspi {
 	status = "okay";
-	dflash0: n25q512a@0 {
+	dflash0: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p80";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi
index 7c4af71baab9..0dbdc9ec3fe5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi
@@ -98,7 +98,7 @@ &flexspi {
 	pinctrl-1 = <&pinctrl_flexspi1>;
 	status = "okay";
 
-	flash0: spi-flash@0 {
+	flash0: flash@0 {
 		reg = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
index 22a5ef771d4e..8f90eb02550d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
@@ -66,7 +66,7 @@ &ecspi1 {
 	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		compatible = "mxicy,mx25r1635f", "jedec,spi-nor";
 		spi-max-frequency = <80000000>;
 		reg = <0>;
-- 
2.32.0

