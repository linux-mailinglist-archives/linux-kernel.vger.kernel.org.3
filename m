Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC3958EAEF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiHJLKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiHJLKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:10:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FFFBCBB
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:10:15 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id v2so12102214lfi.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zz6bBMKcDFXn/vtbAjqVy8NZavjcIhEu5Pr02QOxaao=;
        b=JIjJtVvWZTvWuKaLr7qaAJqh5Hf6uMvaeIrp1AyhwjuZ2I6aUjKQSxeMzKE75q9MN2
         /v6O5yuJUeq5QQglhDAY4l29MufmFlJhTDCQAIaLIOTFofZ5TFG4pSQ/27X8vfV7kusg
         VueiMbtGgFWgVmBxkv3Le5CNolNsbLQRw69Vjqv11TdVkkJe6TCYgzMC/+1s0sxdgWVy
         pq+uGG4AX6eTZzuw5EcHSaMN+XSQ7QxkajvZkqsx3ZQGQzYcVol/TXVX1O8uaibtHy/n
         whSERAO3SgCbR7Vk2EOhFuuEok3n58v6eKXwrHU6p3qK22ZDFcKjGOx/v4O/n4+fLni+
         Bipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zz6bBMKcDFXn/vtbAjqVy8NZavjcIhEu5Pr02QOxaao=;
        b=a0/ywUFEt5SDPFiCtsGZaFJ7km3lPJ4I4fV/NFfRMTzBkQ1Dr+RAc/35QCzVQk8z7X
         zQYUzIpMtRJruasoDCQYz4vqUFlMXNAlOwPmX53VeoYzRdCDsH4F+/O8XQRBtpXafR7B
         QwE3WPuOmER6vfY3tBtcIQIhY9298yRYCZpG4zS+raAxq/TcpEzdVd5+kOItw99NsZAh
         KRZSRIj5g5EXNTEWpiuASqn7Og0EjqTB06rCsY8D77Nz1jucm/FVAFH1BdHBwy99lHB3
         J6ZDHNo/K0rEejHSAEqhE77uF8dFf3m2dTXWXvv31ZH3AnTZ0HVYwL9rAtyGFqg8RJFQ
         MfcQ==
X-Gm-Message-State: ACgBeo2StnG2AUt8r/HMH5MBNQ6OqTUg/SxWCphO+UvwaMQsJBnlkFpY
        bd7JCVFmrNr/pgpf1Umacsv+AA==
X-Google-Smtp-Source: AA6agR5rgWUogaEEYoR6xuBxir874zl9sWEgDBbhkgKbyLK3JP96hXXGQ7AOkcINCon3hg/JhZQkhg==
X-Received: by 2002:ac2:598a:0:b0:48a:fa75:c742 with SMTP id w10-20020ac2598a000000b0048afa75c742mr8971155lfn.573.1660129813045;
        Wed, 10 Aug 2022 04:10:13 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id u17-20020ac243d1000000b0048b0975ac7asm301425lfl.151.2022.08.10.04.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:10:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] ARM: dts: imx: align LED node names with dtschema
Date:   Wed, 10 Aug 2022 14:10:07 +0300
Message-Id: <20220810111008.280850-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220810111008.280850-1-krzysztof.kozlowski@linaro.org>
References: <20220810111008.280850-1-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and DT schema expects certain pattern.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/imx51-apf51dev.dts    | 2 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi | 2 +-
 arch/arm/boot/dts/imx6q-novena.dts      | 2 +-
 arch/arm/boot/dts/imx7d-zii-rmu2.dts    | 2 +-
 arch/arm/boot/dts/imx7d-zii-rpu2.dts    | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/imx51-apf51dev.dts
index c66f274ba4e9..b61d55ca1467 100644
--- a/arch/arm/boot/dts/imx51-apf51dev.dts
+++ b/arch/arm/boot/dts/imx51-apf51dev.dts
@@ -63,7 +63,7 @@ user-key {
 	leds {
 		compatible = "gpio-leds";
 
-		user {
+		led-user {
 			label = "Heartbeat";
 			gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index fe4244044a0f..d6a87c0c2934 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -71,7 +71,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&led_pin_gpio7_7>;
 
-		user {
+		led-user {
 			label = "Heartbeat";
 			gpios = <&gpio7 7 0>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/imx6q-novena.dts
index 225cf6b7a7a4..f8a8dd3e069f 100644
--- a/arch/arm/boot/dts/imx6q-novena.dts
+++ b/arch/arm/boot/dts/imx6q-novena.dts
@@ -99,7 +99,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_leds_novena>;
 
-		heartbeat {
+		led-heartbeat {
 			label = "novena:white:panel";
 			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
diff --git a/arch/arm/boot/dts/imx7d-zii-rmu2.dts b/arch/arm/boot/dts/imx7d-zii-rmu2.dts
index 1065941807e8..1c9f25848bf7 100644
--- a/arch/arm/boot/dts/imx7d-zii-rmu2.dts
+++ b/arch/arm/boot/dts/imx7d-zii-rmu2.dts
@@ -24,7 +24,7 @@ gpio-leds {
 		pinctrl-0 = <&pinctrl_leds_debug>;
 		pinctrl-names = "default";
 
-		debug {
+		led-debug {
 			label = "zii:green:debug1";
 			gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx7d-zii-rpu2.dts b/arch/arm/boot/dts/imx7d-zii-rpu2.dts
index 893bd30aa2a3..9d29490ab4c9 100644
--- a/arch/arm/boot/dts/imx7d-zii-rpu2.dts
+++ b/arch/arm/boot/dts/imx7d-zii-rpu2.dts
@@ -36,7 +36,7 @@ gpio-leds {
 		pinctrl-0 = <&pinctrl_leds_debug>;
 		pinctrl-names = "default";
 
-		debug {
+		led-debug {
 			label = "zii:green:debug1";
 			gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
-- 
2.34.1

