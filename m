Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6F1544ADE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244480AbiFILpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244543AbiFILmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:42:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB381F12A2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:41:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id me5so46374500ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SVfrIIONPl2pU7g3Eas4LBzlC/IRw5PSti0JMwZFx1I=;
        b=wIvtozXbQcmPqcVkitLW8E6lji3pdsQozMAhHWYB0R6Boy+mdR7DwZc3zI2GixONua
         zuewTleJ7IkdzYsBv5L1np+YoNlZUBl947yej1onr6YASRUl/lvylnD5cP/He3snTi+c
         06XaAqQxuZhaEQvjDqV2RZ0JcIfDkA8vJy4T9h/mRS5syHBri0FAz+xubEHBkOI/WwJQ
         6WMhOpXQ0bN4aKrLUPSJ+208HJUnGOu+6ch6BrNLRd+KHbBvMt1XvuEVG9Bz6xQLcn3I
         k3lg3ehYAMCKAQJ96s6Wv+fE51A9ExnmtJeXI1smXlPi263Hlat+kcCt4BCKFA+Fpwc2
         hu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SVfrIIONPl2pU7g3Eas4LBzlC/IRw5PSti0JMwZFx1I=;
        b=S9V6Il5YFml8HmETxPNzUsRI3RiB0QkAFfzcvdyDI9FP9sGcaMYq3yrA5DIfUkLsbq
         zTFgX0mRxMI9KOUre6dqkmSvA4U56KNZ1XtorbPdziYVlBvCSZxWBTuCwYTGTDMOuAyE
         H/GxePD+l/HD7hxXEqIvuZIBkOHPnlnZadY1v8HGjBGJQ5R3KcMu49BlNE5futtdEjkD
         X2Du0B6O5Djk8oKW9MNtqjby0Nfot1gL74vzI/86tkIEZPtlXICfkwGvTKhS/h0qToPb
         IJ8n89vg4P9QZajNEikfEupMcq4nfEO/4F8j28O0GTe3CpLuhzErDn7LMORYl+XvRC60
         M4wA==
X-Gm-Message-State: AOAM5324VIUj4Y1o852Zg/bkLhAz2gTMsu5qm5EkVB/bALoNy1Oc4xqz
        25quSAubC2lFnZbpar9XJ9Jurw==
X-Google-Smtp-Source: ABdhPJxuoQKLVRCbJIz6hjE4taKkPgc8DuF0y71AR64+yrzGXM9oultaUQJmgCrKk8kp5ZdRy0g1iw==
X-Received: by 2002:a17:907:6d24:b0:70c:81d9:d5b9 with SMTP id sa36-20020a1709076d2400b0070c81d9d5b9mr31335840ejc.597.1654774860896;
        Thu, 09 Jun 2022 04:41:00 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bk2-20020a170906b0c200b006fef557bb7asm10498662ejb.80.2022.06.09.04.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:41:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 45/48] ARM: dts: at91: correct gpio-keys properties
Date:   Thu,  9 Jun 2022 13:40:44 +0200
Message-Id: <20220609114047.380793-6-krzysztof.kozlowski@linaro.org>
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

