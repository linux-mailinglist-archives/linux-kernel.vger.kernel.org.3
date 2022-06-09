Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A39544A7E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbiFILlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243914AbiFILkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:40:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5701E226F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:40:10 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g25so403770ejh.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P9oBYdB3cH6UNLeExvbtuDOVwCrp/TsONqfDaucXFbw=;
        b=fZ4JEOqAQRXFr5hjTFzHenFWi3rDqczjovhirnLU/ZTrQj4CPkoLAsxzTLHDM1ImQd
         isMy9oQUMTclERqBBmKnIKn4FCT72SqI6umZetSyfwJebuyLgQN8vfLK/PJRdY/0MK8w
         yxrIF1hz/hs63/0Xj8aX+ysBfr5B0lOSFjqWhxxTsVeijCBiVod2cYCdmR5Bx2lvhh54
         hWQXJf9qyqfxaOJe5LmTtgmMZm7dZ5I1SnE7b7U6FNEzjhu5bQyYH7kTOpKdaXa+gaIj
         q1midSbS3DD4Ah5yYuJljC0ktoWW3bSrlYGx05LE9vp5NbX5fP6+yn2/tXgWFQYsPz3L
         +o+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P9oBYdB3cH6UNLeExvbtuDOVwCrp/TsONqfDaucXFbw=;
        b=gJpiLBAcHA9lkg+wNAV86uUnCAIKpDW7DccWSlVZeZuWSVsI3hifflNq3OqaqI5+nW
         FeJGvElKcuJow4wrqTp0MOPHLahNi1VIgPpDxyRkYJ6Ua0ymn6E8zlDzVPNf8a5JujDL
         wOF+kfYv+L3iS7UhTEQtuuKSNcyuHWTgrc9BhVZ+cvKgvAp7ryJpJnz3zzZYfXx/XfiZ
         R+uA5moERJXZF1zsxhPzVkn+g2nqUmAc6/9/Pr+B7MWyK22VEgnxx/I6Vx+flk9efG3o
         T6S+SDiQq+WgexeC2Qqw4Cr+7dWNrhBJjV/eef9ImPAJZrn3nuY2wZWyjVcKqTu7fCLo
         5Fbg==
X-Gm-Message-State: AOAM531GvU7PDT0L6rWOofEyqDKYPZc8oRGFiRhsucBFH7qGkr65B/PB
        Hp2pye6EQkcJsRvxQVBvoZbx9Q==
X-Google-Smtp-Source: ABdhPJw621KFEfqq0WVisJDSKzJYjbuGlTy1lMED0K0HnwW9JdMWBxSZsowxtq2v7a4skM5zO0uIaw==
X-Received: by 2002:a17:906:3bd2:b0:711:ce53:5d5f with SMTP id v18-20020a1709063bd200b00711ce535d5fmr19371461ejf.500.1654774808894;
        Thu, 09 Jun 2022 04:40:08 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q1-20020a170906360100b006ff59151e34sm10638441ejb.39.2022.06.09.04.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:40:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 20/48] ARM: dts: marvell: correct gpio-keys properties
Date:   Thu,  9 Jun 2022 13:39:53 +0200
Message-Id: <20220609114002.380563-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio-keys children do not use unit addresses.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/armada-370-rd.dts                      | 2 --
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi       | 2 --
 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi | 2 --
 arch/arm/boot/dts/armada-xp-axpwifiap.dts                | 2 --
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts            | 2 --
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts         | 2 --
 6 files changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index c910d157a686..6ba7699b69ed 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -84,8 +84,6 @@ usb@51000 {
 
 			gpio-keys {
 				compatible = "gpio-keys";
-				#address-cells = <1>;
-				#size-cells = <0>;
 				button {
 					label = "Software Button";
 					linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
index cf7bffdd1c21..866b8630d407 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
@@ -108,8 +108,6 @@ gpio-fan {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		button-power {
 			label = "Power button";
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
index 6c33e3ba4ffb..702a85af2078 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -83,8 +83,6 @@ regulator@1 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		button-power {
 			label = "Power button";
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index 86a0ad9bd5cc..5a74197be0ad 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -71,8 +71,6 @@ ethernet@74000 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = <&keys_pin>;
 		pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 51b2eb8bb4fd..622ac40dd164 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -174,8 +174,6 @@ bm-bppi {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = <&keys_pin>;
 		pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index ff698d6ebb87..1ecf72a61bca 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -99,8 +99,6 @@ green_led {
 
 			gpio-keys {
 				compatible = "gpio-keys";
-				#address-cells = <1>;
-				#size-cells = <0>;
 
 				button-init {
 					label = "Init Button";
-- 
2.34.1

