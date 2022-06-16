Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E972754D6AB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350566AbiFPA4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357066AbiFPA4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:56:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC1259099
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:55:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id z14so99824pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+riFNmdMk75rZ1ustGEPNsT3m7X79ndXoLSyN8tVDBM=;
        b=ScjWl0N66G6RKiXyjRWzpNRqTnKnDwP7F/mMUJAxqrLZ6LaCpkTHGce9jUUXYKypyt
         /XJXvBVZsUi62/hD0y/TAuD2JR2vjukOWtny4kY5Uz02gjM0n9JFgtgWbqdmXOnQfDvN
         b4RmISvGUiNhYDry5V3rqh+fmiOh3ECot1IcL7prcRZbjBaCXHHmmEOT//r9+JfEFyd6
         P/d9XChA5ejwHJ0DEe+RbwWhs9kwT0pW7bdNXoI/22xjmaG+RBM75fhhMAcVv4upKg3w
         YMvV0c39LobM7tKumjolQmS/8ZAmxuDGxWXFCcJ1YmAayEMf2Gq61XsEGlB6iJDW9kyL
         5aKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+riFNmdMk75rZ1ustGEPNsT3m7X79ndXoLSyN8tVDBM=;
        b=vRFjpsBxUPnYEGd76ITtRg8cbV8GUGGa1ob85bIw8mUK+wtNEjFuCVBR2SoegiGsqS
         4klLDD25JCqN91/1aeIp1qqVhnYY1E9JyFb7wylKclX10KMp96awZj0mNOTB6fKMhf6j
         zwHG98ZSZz22w67GKGb3ihUyUKZOICMXrHDJ6/ms97wBHCkPI5gfQobCWW+7ipJVjyrH
         yUBvhq56/mM1utulw9ZWeB95Wkfo9vBw3gSDsk5+CmOjgbd2UrYgyXut6zwnqKVqxXLY
         fL2+6TQIDZEZ3I4Z8K1Y1B0PZtmf1NHSNM4/bRo2wqCh8mh/4rDs6eO7xhjIPHbAiYJw
         KZeQ==
X-Gm-Message-State: AJIora+pfX22+Mw9lDarjyeKsrxt9D15rqH6UvUnBDBmFhr4Ro8Bc/Pm
        /N+lU3gdkXKy8+DLV9CE3V4gn1EEv91siA==
X-Google-Smtp-Source: AGRyM1udExT3zMkQlP3PaI7iLyHDBxVwTO5oaMrwCBi2I0/yO3+AXvsXBWcx2dQpO2ZBcZPYWF9fzQ==
X-Received: by 2002:a17:903:485:b0:163:e1be:52b3 with SMTP id jj5-20020a170903048500b00163e1be52b3mr1914270plb.134.1655340892346;
        Wed, 15 Jun 2022 17:54:52 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 39/40] ARM: dts: at91: correct gpio-keys properties
Date:   Wed, 15 Jun 2022 17:53:32 -0700
Message-Id: <20220616005333.18491-39-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
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

gpio-keys children do not use unit addresses.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-kizbox.dts             | 2 --
 arch/arm/boot/dts/at91-kizbox2-common.dtsi    | 2 --
 arch/arm/boot/dts/at91-kizboxmini-common.dtsi | 2 --
 arch/arm/boot/dts/at91-qil_a9260.dts          | 2 --
 arch/arm/boot/dts/at91-wb45n.dts              | 5 +----
 arch/arm/boot/dts/at91-wb50n.dts              | 8 ++------
 6 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
index 87e972eb2ba6..307663b4eec2 100644
--- a/arch/arm/boot/dts/at91-kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -30,8 +30,6 @@ main_xtal {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		button-reset {
 			label = "PB_RST";
diff --git a/arch/arm/boot/dts/at91-kizbox2-common.dtsi b/arch/arm/boot/dts/at91-kizbox2-common.dtsi
index ed7146e23147..e5e21dff882f 100644
--- a/arch/arm/boot/dts/at91-kizbox2-common.dtsi
+++ b/arch/arm/boot/dts/at91-kizbox2-common.dtsi
@@ -33,8 +33,6 @@ main_xtal {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		button-prog {
 			label = "PB_PROG";
diff --git a/arch/arm/boot/dts/at91-kizboxmini-common.dtsi b/arch/arm/boot/dts/at91-kizboxmini-common.dtsi
index 8fb08e6fad7a..42640fe6b6d0 100644
--- a/arch/arm/boot/dts/at91-kizboxmini-common.dtsi
+++ b/arch/arm/boot/dts/at91-kizboxmini-common.dtsi
@@ -36,8 +36,6 @@ adc_op_clk {
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		key-prog {
 			label = "PB_PROG";
diff --git a/arch/arm/boot/dts/at91-qil_a9260.dts b/arch/arm/boot/dts/at91-qil_a9260.dts
index d09b3d15a828..9d26f9996348 100644
--- a/arch/arm/boot/dts/at91-qil_a9260.dts
+++ b/arch/arm/boot/dts/at91-qil_a9260.dts
@@ -198,8 +198,6 @@ user_led {
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		button-user {
 			label = "user_pb";
diff --git a/arch/arm/boot/dts/at91-wb45n.dts b/arch/arm/boot/dts/at91-wb45n.dts
index 3e46b29412d1..ef73f727f7bd 100644
--- a/arch/arm/boot/dts/at91-wb45n.dts
+++ b/arch/arm/boot/dts/at91-wb45n.dts
@@ -14,11 +14,8 @@ / {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		irqbtn@18 {
-			reg = <18>;
+		button {
 			label = "IRQBTN";
 			linux,code = <99>;
 			gpios = <&pioB 18 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/at91-wb50n.dts b/arch/arm/boot/dts/at91-wb50n.dts
index e2195bd3e4b4..ec2becf6133b 100644
--- a/arch/arm/boot/dts/at91-wb50n.dts
+++ b/arch/arm/boot/dts/at91-wb50n.dts
@@ -15,19 +15,15 @@ / {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		btn0@10 {
-			reg = <10>;
+		button-0 {
 			label = "BTNESC";
 			linux,code = <1>; /* ESC button */
 			gpios = <&pioA 10 GPIO_ACTIVE_LOW>;
 			wakeup-source;
 		};
 
-		irqbtn@31 {
-			reg = <31>;
+		button-1 {
 			label = "IRQBTN";
 			linux,code = <99>; /* SysReq button */
 			gpios = <&pioE 31 GPIO_ACTIVE_LOW>;
-- 
2.34.1

