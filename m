Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577165A6BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiH3SEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiH3SDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:03:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24288696CC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:03:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bq23so16625523lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Ch7MLzjtjxDAnl8q0BHET3tRA6bodCqHcVbiwE3Oe4g=;
        b=a5a22/m+UPenjdNvSoivou/95cRPjfTAPUYrIwBXwARzbxJLoro/WeeY8LDQd6q54C
         qa/4rKjYPpFmKABxLFYD6+GqbRSw239JMtGCCpENJee6kxgwleR9bFASo8vbocoaKvZo
         NxPtfOMJhglebUZD60i7VcvHhIoQrXcPRnEgHCIcCJq4RAJZjdKXx2XqkJV1NtjdCusZ
         vGMoGhF4M9o1qrBsplW3YgNaF3TfVW4Cn52w1iUK9YyqfvaaEyaEj6gRF54UnmKDtE1k
         vN3ZqnRcRV9O7K+dLttZh6PS8W1l4k6FdylGCVeXDhuGXAQgGODepmMOmjQritmJ1iPq
         Ku4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Ch7MLzjtjxDAnl8q0BHET3tRA6bodCqHcVbiwE3Oe4g=;
        b=WEKtu70u5JXsIvxmofnMwScj06aCIFIBNuuNFHALTE+sIiPHnnoMLeRF9uMKa76dHc
         OeA3LNm+xw/VVEoGqRiXmds3b5n0ubDV+nK5lwqsLBTLRbYoU+5zz9gRCi8TYncx1upE
         Cg2AqlWnlzj9I3casBJIDVMDcYdio6l6/5a7XiwIAJEiyXvRjsR+uM1P0MaadP/hF/3s
         Mj70LWsgXxLiyoICn+vPglFqcl5UlbKW/MfeStZ4LgLBG0s/P4E5ca9e1MmgHkYlLCoP
         WsRyE+kFnnMTWVcpWOgcLUQ2SX4ObsrqmClW6NWga9nTLgd1E/f2hAlGS7tnUwWRvM21
         gQDA==
X-Gm-Message-State: ACgBeo0hwe9XSmihEQ2fSY/LJH2Dq5neauDx5CmcWY8UCH757JF6LP2g
        gn3j8KjXVchdhX7mlhlFj4LYkUgykXizI0aK
X-Google-Smtp-Source: AA6agR4B6RPmmBpqIqWQK+WQ/FHVm/qy/0Kjy1i5/ymIBnlMsgywlvPmZo+HlEf7Ejw2wE9vzxYgQA==
X-Received: by 2002:ac2:4c4f:0:b0:48b:1358:67e3 with SMTP id o15-20020ac24c4f000000b0048b135867e3mr7689493lfk.441.1661882626425;
        Tue, 30 Aug 2022 11:03:46 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id c14-20020a056512324e00b0047255d211b2sm505298lfr.225.2022.08.30.11.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:03:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH] ARM: dts: aspeed: align SPI node name with dtschema
Date:   Tue, 30 Aug 2022 21:03:44 +0300
Message-Id: <20220830180344.15657-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The node names should be generic and DT schema expects certain pattern.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts | 2 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts      | 2 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts        | 2 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts    | 2 +-
 arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
index 9c6271a17ae8..5cd060029ea9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
@@ -77,7 +77,7 @@ aliases {
 		i2c55 = &imux55;
 	};
 
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		num-chipselects = <2>;
 		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>,
 			   <&gpio0 ASPEED_GPIO(X, 1) GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
index 27b43fe099f1..4b520d7ce3e1 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
@@ -44,7 +44,7 @@ chosen {
 		stdout-path = &uart5;
 	};
 
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		num-chipselects = <1>;
 		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
 	};
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts
index af58a73bbc49..6b319f34a9b9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts
@@ -207,7 +207,7 @@ aliases {
 		i2c143 = &imux143;
 	};
 
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		num-chipselects = <3>;
 		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>,
 			   <0>,	/* device reg=<1> does not exist */
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
index a901c8be49b9..ed305948386f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
@@ -67,7 +67,7 @@ ast-adc-hwmon {
 	 * full-duplex SPI transactions are not supported by ASPEED SPI
 	 * Controllers.
 	 */
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		status = "okay";
 		compatible = "spi-gpio";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
index 051de5bec345..31590d3186a2 100644
--- a/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
@@ -25,7 +25,7 @@ memory@80000000 {
 	 * full-duplex SPI transactions are not supported by ASPEED SPI
 	 * Controllers.
 	 */
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		status = "okay";
 		compatible = "spi-gpio";
 		#address-cells = <1>;
-- 
2.34.1

