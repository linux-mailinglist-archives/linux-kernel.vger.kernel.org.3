Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD2D4F81C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbiDGOfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344023AbiDGOfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:35:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F011A5D48
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:32:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bg10so11286258ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdY+F6xvAyzWtskSAzF5baAt59NngnjVCycs5ox2N3Y=;
        b=m20jN7X6r8d95tEVgAmGLxoVymS82aD+MaG05kXP9gfeDFxQ2WZa7mPdqOzFFR1lF0
         lYSQu8dSMl+EECfpDd8KMsBXYcWVQIoFAgQ8DhGH6B5VkMVdNjKlH8k5/ertkQRUdCBR
         h8Vfd9LsPXnU9++3oPNeacGuikCXzfltoI5LvNwUudspNGPzwU1Y9N1vS/8ZyntwUovR
         ztOtcjDjaHEdOtVXg5z7j/xcRNWj2d0ls8F+jL61zxAUyvthWOxTbvqKXSt3TYamv3GQ
         wbC6zAdVFsS/RbCD7/HUFsjCR9z3PSZ48T+9keQvL3TAuPbPOXUHtOwQrjcYD4FutNAl
         olgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdY+F6xvAyzWtskSAzF5baAt59NngnjVCycs5ox2N3Y=;
        b=bh1UeWBgMNnWI1N4xs8T65VbP9C6qHyVRpCJ2pCHewtkOYNqKL/t6kIjzqoAEyRZGT
         Ozc/PoPN6C49NnEdjE1QCu7lkMwBfSxp9xx85SITL2PcfAziQXsf6EztYMl1/EUbS28B
         Gz3+ARRU5QRCtrCxEQFZSzqT1ZLBIIpOpVgmEvJkykyWPEGq7FpeN5rGI0B4Y2FcNgaG
         vqMAlxxy6/3av/zNQAyP5lzKUxh5J2ssG2trxLiITEFPzaqZcOEUVrgUQ43EFAIY/Ju3
         8rV0CSV1mC26wZCvqNdozGEQrVehtzSgr3vyfH9BopeFJl1aOU/uywrTVnSb8KKI2EHb
         J2xg==
X-Gm-Message-State: AOAM531Fyqec/HyaOf9oeDxSGUnwwUPAMvAhu13zvL95n0oORsvmBhc+
        WY310RW267lEW7w5fFcGKYcqOw==
X-Google-Smtp-Source: ABdhPJwNKTJFyu6fqY/56zly1XOEXADAV0/mmhO8OnAfHPVNTNfhYFmwDVRNcXiyqk9nJe8CV8nBJw==
X-Received: by 2002:a17:906:dc8f:b0:6e0:5ce7:d80e with SMTP id cs15-20020a170906dc8f00b006e05ce7d80emr14084251ejc.435.1649341946507;
        Thu, 07 Apr 2022 07:32:26 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id d12-20020a50cf4c000000b0041cc12dc1f3sm6618038edk.71.2022.04.07.07.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:32:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: microchip: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:32:23 +0200
Message-Id: <20220407143223.295344-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407143223.295344-1-krzysztof.kozlowski@linaro.org>
References: <20220407143223.295344-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and SPI NOR dtschema expects "flash".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/microchip/sparx5_nand.dtsi         | 2 +-
 arch/arm64/boot/dts/microchip/sparx5_pcb125.dts        | 4 ++--
 arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi | 4 ++--
 arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_nand.dtsi b/arch/arm64/boot/dts/microchip/sparx5_nand.dtsi
index 03f107e427d7..ce0747fd6444 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_nand.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_nand.dtsi
@@ -19,7 +19,7 @@ spi@e {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <14>; /* CS14 */
-		spi-flash@6 {
+		flash@6 {
 			compatible = "spi-nand";
 			pinctrl-0 = <&cs14_pins>;
 			pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts b/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
index 9baa085d7861..dbf8c1d48a02 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
@@ -47,7 +47,7 @@ spi@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0>;	/* CS0 */
-		spi-flash@9 {
+		flash@9 {
 			compatible = "jedec,spi-nor";
 			spi-max-frequency = <8000000>;
 			reg = <0x9>;	/* SPI */
@@ -59,7 +59,7 @@ spi@1 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <1>; /* CS1 */
-		spi-flash@9 {
+		flash@9 {
 			compatible = "spi-nand";
 			pinctrl-0 = <&cs1_pins>;
 			pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
index 33faf1f3264f..699256f1b9d8 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
@@ -274,7 +274,7 @@ gpio@1 {
 
 &spi0 {
 	status = "okay";
-	spi-flash@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		spi-max-frequency = <8000000>;
 		reg = <0>;
@@ -289,7 +289,7 @@ spi@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0>;	/* CS0 */
-		spi-flash@9 {
+		flash@9 {
 			compatible = "jedec,spi-nor";
 			spi-max-frequency = <8000000>;
 			reg = <0x9>;	/* SPI */
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
index ef96e6d8c6b3..d10a9172b529 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
@@ -89,7 +89,7 @@ i2cmux_s32: i2cmux-3 {
 
 &spi0 {
 	status = "okay";
-	spi-flash@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		spi-max-frequency = <8000000>;
 		reg = <0>;
@@ -104,7 +104,7 @@ spi@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0>; /* CS0 */
-		spi-flash@9 {
+		flash@9 {
 			compatible = "jedec,spi-nor";
 			spi-max-frequency = <8000000>;
 			reg = <0x9>; /* SPI */
-- 
2.32.0

