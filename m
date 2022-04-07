Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456904F892A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiDGUsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiDGUsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:48:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABDB35C6CE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:41:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l26so13334983ejx.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V4mNTz/8CcAHti6X+Vv2CZRSMwUxmp6WCS8EUSUnqow=;
        b=SyuhimNYVprwclikI//wbPyoDaZxDVw9KD89Svwb0aGalAi+g4k0xhh0TjhMC2QHvF
         3iMwhi5I/JMW671T3CllWhG3b0m6QvQgCC2xjd4wFANfFnnISm9aC4NMYY6A72otPbvl
         ixSyZUuX6JX2K13+AAdXuZMa+tz9RdWL1hDkJBcS2pV6/HOkE6otg/JbLZH6V07wzlOE
         dbLgR2bvhH9lDyriuwm8rWlA6sRNOIbMMy5sd2W5cC9Ey3+wr0t/R33X5FSgcuLhzuiO
         l804HVzJwJJRHARc+7LWf4qBOhyNwjuhurbNxlZUF3tr4bsq/AzkIV1HyHLzfPEw6KTo
         ew6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V4mNTz/8CcAHti6X+Vv2CZRSMwUxmp6WCS8EUSUnqow=;
        b=XHndUo5zV4/om8Gm9aCXJMHjI2cnycT9rzwk+h+r9vIyJdTiF8K/aDKvypfTG01Rdl
         X1B/hLuoePfLD2Ai7J7qjdyOiEt6hYtFv4F7rFccLnCMyRI5bHi6eIw8/faeYn6uh7A2
         xSGUzRiUXZrtbkbTFPM+DLwS0H5iPS/+QLXqeynVgvNHh7A1Nb+t3M443lSZ+JG9FNIN
         a7gqKUZhGl2s8EffAHFqCpMUl+BnBRLVRAzb4YBRoq34Q+PPzbYyUKOhO81zFL7uu8SD
         dY2MLldTHpj7QK1cO4nheP68j6ACKv54+AmMaRb5pV7KmSYVYiXDbZMZouif4P1ckrRf
         eAvg==
X-Gm-Message-State: AOAM533mN8vLzFWL8rzTyNTYtsRN/IlUMWa+e6L/dx7s8OioMK3yPYo+
        Nyq3jhA5ovoebMSPhqJXTqjS6g==
X-Google-Smtp-Source: ABdhPJwn1rHVVeku9gArS6EyajtcOT1ZosArLNwnoPnGjveEuuV1MEf0qTCfaVKLrhzK1kaGZDMSeQ==
X-Received: by 2002:a17:906:58c7:b0:6da:955b:d300 with SMTP id e7-20020a17090658c700b006da955bd300mr15014938ejs.481.1649364078683;
        Thu, 07 Apr 2022 13:41:18 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id qq21-20020a17090720d500b006e7eec5c96csm5202286ejb.0.2022.04.07.13.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 13:41:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH] arm64: dts: synaptics: remove unused DTSI for AS370
Date:   Thu,  7 Apr 2022 22:41:15 +0200
Message-Id: <20220407204115.34350-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

The as370.dtsi for Synaptics AS370 SoC does not have a user (DTS board
file), is uncompilable and untestable.  It was added back in 2018.  No
user appeared since that time, so assume it won't be added.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>

---

The AS370 board was submitted for review in Aug 2021 [1] but after few
comments there were no resubmits, so basically this is still a dead
DTSI.

[1] https://lore.kernel.org/all/CAK8P3a2vkZVt1bb7-iDGaSHp20U9d8QXu6AcrUMceJSS9Q_-4Q@mail.gmail.com/
---
 .../devicetree/bindings/arm/syna.txt          |   4 -
 arch/arm64/boot/dts/synaptics/as370.dtsi      | 173 ------------------
 2 files changed, 177 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/synaptics/as370.dtsi

diff --git a/Documentation/devicetree/bindings/arm/syna.txt b/Documentation/devicetree/bindings/arm/syna.txt
index d8b48f2edf1b..851f48ead927 100644
--- a/Documentation/devicetree/bindings/arm/syna.txt
+++ b/Documentation/devicetree/bindings/arm/syna.txt
@@ -18,10 +18,6 @@ stable binding/ABI.
 
 ---------------------------------------------------------------
 
-Boards with the Synaptics AS370 SoC shall have the following properties:
-  Required root node property:
-    compatible: "syna,as370"
-
 Boards with a SoC of the Marvell Berlin family, e.g. Armada 1500
 shall have the following properties:
 
diff --git a/arch/arm64/boot/dts/synaptics/as370.dtsi b/arch/arm64/boot/dts/synaptics/as370.dtsi
deleted file mode 100644
index 4bb5d650df9c..000000000000
--- a/arch/arm64/boot/dts/synaptics/as370.dtsi
+++ /dev/null
@@ -1,173 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2018 Synaptics Incorporated
- *
- * Author: Jisheng Zhang <jszhang@kernel.org>
- */
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-
-/ {
-	compatible = "syna,as370";
-	interrupt-parent = <&gic>;
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	psci {
-		compatible = "arm,psci-1.0";
-		method = "smc";
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			compatible = "arm,cortex-a53";
-			device_type = "cpu";
-			reg = <0x0>;
-			enable-method = "psci";
-			next-level-cache = <&l2>;
-			cpu-idle-states = <&CPU_SLEEP_0>;
-		};
-
-		cpu1: cpu@1 {
-			compatible = "arm,cortex-a53";
-			device_type = "cpu";
-			reg = <0x1>;
-			enable-method = "psci";
-			next-level-cache = <&l2>;
-			cpu-idle-states = <&CPU_SLEEP_0>;
-		};
-
-		cpu2: cpu@2 {
-			compatible = "arm,cortex-a53";
-			device_type = "cpu";
-			reg = <0x2>;
-			enable-method = "psci";
-			next-level-cache = <&l2>;
-			cpu-idle-states = <&CPU_SLEEP_0>;
-		};
-
-		cpu3: cpu@3 {
-			compatible = "arm,cortex-a53";
-			device_type = "cpu";
-			reg = <0x3>;
-			enable-method = "psci";
-			next-level-cache = <&l2>;
-			cpu-idle-states = <&CPU_SLEEP_0>;
-		};
-
-		l2: cache {
-			compatible = "cache";
-		};
-
-		idle-states {
-			entry-method = "psci";
-			CPU_SLEEP_0: cpu-sleep-0 {
-				compatible = "arm,idle-state";
-				local-timer-stop;
-				arm,psci-suspend-param = <0x0010000>;
-				entry-latency-us = <75>;
-				exit-latency-us = <155>;
-				min-residency-us = <1000>;
-			};
-		};
-	};
-
-	osc: osc {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <25000000>;
-	};
-
-	pmu {
-		compatible = "arm,cortex-a53-pmu";
-		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&cpu0>,
-				     <&cpu1>,
-				     <&cpu2>,
-				     <&cpu3>;
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
-	soc@f7000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0 0xf7000000 0x1000000>;
-
-		gic: interrupt-controller@901000 {
-			compatible = "arm,gic-400";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			reg = <0x901000 0x1000>,
-			      <0x902000 0x2000>,
-			      <0x904000 0x2000>,
-			      <0x906000 0x2000>;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-		};
-
-		apb@e80000 {
-			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0xe80000 0x10000>;
-
-			uart0: serial@c00 {
-				compatible = "snps,dw-apb-uart";
-				reg = <0xc00 0x100>;
-				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&osc>;
-				reg-shift = <2>;
-				status = "disabled";
-			};
-
-			gpio0: gpio@1800 {
-				compatible = "snps,dw-apb-gpio";
-				reg = <0x1800 0x400>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				porta: gpio-port@0 {
-					compatible = "snps,dw-apb-gpio-port";
-					gpio-controller;
-					#gpio-cells = <2>;
-					ngpios = <32>;
-					reg = <0>;
-					interrupt-controller;
-					#interrupt-cells = <2>;
-					interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
-				};
-			};
-
-			gpio1: gpio@2000 {
-				compatible = "snps,dw-apb-gpio";
-				reg = <0x2000 0x400>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				portb: gpio-port@1 {
-					compatible = "snps,dw-apb-gpio-port";
-					gpio-controller;
-					#gpio-cells = <2>;
-					ngpios = <32>;
-					reg = <0>;
-					interrupt-controller;
-					#interrupt-cells = <2>;
-					interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-				};
-			};
-		};
-	};
-};
-- 
2.32.0

