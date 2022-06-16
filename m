Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E798954D68F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350728AbiFPA41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350703AbiFPAzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:55:53 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B178858E64
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:52 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso353787pjl.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=41oDl2jkYIAe+UpezywZKxtSXaIGEAoKjC6bZyfTtEs=;
        b=DOiN6UX76c42v/jgl2qUiV53buDgk5YWZeo8dByu1FQ2aq4/5otgHCcyODA4MdnimL
         ZU7Xd/dqFSTp26HeKQSx7Mkzcd7m/8+IrkgqLSTAjteQKu+jBMV1IN7pyqj61H5eVgVi
         +7KzNjBo9NEUurkHL2VFIPxFdjUDOV+rsg1RGKXlSbjXbuPv9z00oD+2EnJqK1pWHMhG
         c02yYlcZo3Gs+hJJY09wD2RzonSXn6BlhUiAct9m2smdrTEmaKf07cT2bCmRvAhg7LjX
         lHaZlb+7zjfnuksVNo6Ae7HMLOIf0ZxyxEGQcnTo1JPaOtOWxTNfNmcGc3iU4dEEJSJm
         RCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41oDl2jkYIAe+UpezywZKxtSXaIGEAoKjC6bZyfTtEs=;
        b=x06xQ2+OwSQ0Jm0mpOzZKPKe/0kA/GJ0+e87cTADrThIYDJPKFhmdSwfSdpTmQNP1l
         WgwPVnXm/RHrFWd6X4XO1oUOaTOHyCxFaPWiqow/9FuN3xiLFFZ0VReU/6DNsRwU5HiV
         5L2s3wstazGDviimJu7mtSx7fqOY6JBFnNSUyWlbFmM8ud6QLALA6LxwXuqAujj7Auup
         u3J+C/Ur9KlL4RW2SBjABjFQFHVMQXxK5wYinRmXew48SK95ITJn3/9O3YKGLvXa8EIl
         neMgnZhvi3VE8WxqLsrj0R/m/tV7/2PFZxLTAG6lFyaUzpmAyBJ4CERSZ3s4hZr2zJMl
         NllA==
X-Gm-Message-State: AJIora/20vwmQbOrizpp4FnzjR246/YhW1/S7KJ9zqcctso7m9ShC0Vj
        cTADKrsb1pU9aMoh4GiwMFtNwg==
X-Google-Smtp-Source: AGRyM1tOHVXuNMucM3NzgAd6pRchdP6AcXNoi1quZmWnXVjrGfedyI7oE9F3AcaC1S1Y5q399i0kww==
X-Received: by 2002:a17:902:d583:b0:167:6e70:7953 with SMTP id k3-20020a170902d58300b001676e707953mr2353473plh.168.1655340886951;
        Wed, 15 Jun 2022 17:54:46 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 36/40] ARM: dts: aspeed: align gpio-key node names with dtschema
Date:   Wed, 15 Jun 2022 17:53:29 -0700
Message-Id: <20220616005333.18491-36-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 30 ++++++------
 .../boot/dts/aspeed-bmc-bytedance-g220a.dts   | 48 +++++++++----------
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts  |  8 ++--
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts  | 12 ++---
 .../boot/dts/aspeed-bmc-inspur-fp5280g2.dts   | 22 ++++-----
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts   | 23 ++++-----
 arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts   | 20 ++++----
 arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts   |  2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts |  2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  |  2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts    | 30 ++++++------
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts   | 12 ++---
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts   |  4 +-
 .../boot/dts/aspeed-bmc-opp-witherspoon.dts   | 16 +++----
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts    |  4 +-
 15 files changed, 118 insertions(+), 117 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
index 1b2e7ad37566..82a6f14a45f0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
@@ -100,91 +100,91 @@ identify {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		shutdown_ack {
+		event-shutdown-ack {
 			label = "SHUTDOWN_ACK";
 			gpios = <&gpio ASPEED_GPIO(G, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(G, 2)>;
 		};
 
-		reboot_ack {
+		event-reboot-ack {
 			label = "REBOOT_ACK";
 			gpios = <&gpio ASPEED_GPIO(J, 3) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 3)>;
 		};
 
-		S0_overtemp {
+		event-s0-overtemp {
 			label = "S0_OVERTEMP";
 			gpios = <&gpio ASPEED_GPIO(G, 3) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(G, 3)>;
 		};
 
-		S0_hightemp {
+		event-s0-hightemp {
 			label = "S0_HIGHTEMP";
 			gpios = <&gpio ASPEED_GPIO(J, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 0)>;
 		};
 
-		S0_cpu_fault {
+		event-s0-cpu-fault {
 			label = "S0_CPU_FAULT";
 			gpios = <&gpio ASPEED_GPIO(J, 1) GPIO_ACTIVE_HIGH>;
 			linux,code = <ASPEED_GPIO(J, 1)>;
 		};
 
-		S0_scp_auth_fail {
+		event-s0-scp-auth-fail {
 			label = "S0_SCP_AUTH_FAIL";
 			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 2)>;
 		};
 
-		S1_scp_auth_fail {
+		event-s1-scp-auth-fail {
 			label = "S1_SCP_AUTH_FAIL";
 			gpios = <&gpio ASPEED_GPIO(Z, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(Z, 5)>;
 		};
 
-		S1_overtemp {
+		event-s1-overtemp {
 			label = "S1_OVERTEMP";
 			gpios = <&gpio ASPEED_GPIO(Z, 6) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(Z, 6)>;
 		};
 
-		S1_hightemp {
+		event-s1-hightemp {
 			label = "S1_HIGHTEMP";
 			gpios = <&gpio ASPEED_GPIO(AB, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(AB, 0)>;
 		};
 
-		S1_cpu_fault {
+		event-s1-cpu-fault {
 			label = "S1_CPU_FAULT";
 			gpios = <&gpio ASPEED_GPIO(Z, 1) GPIO_ACTIVE_HIGH>;
 			linux,code = <ASPEED_GPIO(Z, 1)>;
 		};
 
-		id_button {
+		event-id {
 			label = "ID_BUTTON";
 			gpios = <&gpio ASPEED_GPIO(Q, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(Q, 5)>;
 		};
 
-		psu1_vin_good {
+		event-psu1-vin-good {
 			label = "PSU1_VIN_GOOD";
 			gpios = <&gpio ASPEED_GPIO(H, 4) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(H, 4)>;
 		};
 
-		psu2_vin_good {
+		event-psu2-vin-good {
 			label = "PSU2_VIN_GOOD";
 			gpios = <&gpio ASPEED_GPIO(H, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(H, 5)>;
 		};
 
-		psu1_present {
+		event-psu1-present {
 			label = "PSU1_PRESENT";
 			gpios = <&gpio ASPEED_GPIO(I, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(I, 0)>;
 		};
 
-		psu2_present {
+		event-psu2-present {
 			label = "PSU2_PRESENT";
 			gpios = <&gpio ASPEED_GPIO(I, 1) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(I, 1)>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts b/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
index 0d1fb5ccfd36..f75cad41ae6f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
@@ -100,7 +100,7 @@ bmc_alive {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		burn-in-signal {
+		event-burn-in-signal {
 			label = "burn-in";
 			gpios = <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(R, 5)>;
@@ -111,139 +111,139 @@ gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		poll-interval = <1000>;
 
-		rear-riser1-presence {
+		event-rear-riser1-presence {
 			label = "rear-riser1-presence";
 			gpios = <&pca0 1 GPIO_ACTIVE_LOW>;
 			linux,code = <1>;
 		};
 
-		alrt-pvddq-cpu0 {
+		event-alrt-pvddq-cpu0 {
 			label = "alrt-pvddq-cpu0";
 			gpios = <&pca0 8 GPIO_ACTIVE_LOW>;
 			linux,code = <2>;
 		};
 
-		rear-riser0-presence {
+		event-rear-riser0-presence {
 			label = "rear-riser0-presence";
 			gpios = <&pca0 9 GPIO_ACTIVE_LOW>;
 			linux,code = <3>;
 		};
 
-		fault-pvddq-cpu0 {
+		event-fault-pvddq-cpu0 {
 			label = "fault-pvddq-cpu0";
 			gpios = <&pca0 10 GPIO_ACTIVE_LOW>;
 			linux,code = <4>;
 		};
 
-		alrt-pvddq-cpu1 {
+		event-alrt-pvddq-cpu1 {
 			label = "alrt-pvddq-cpu1";
 			gpios = <&pca0 11 GPIO_ACTIVE_LOW>;
 			linux,code = <5>;
 		};
 
-		fault-pvddq-cpu1 {
+		event-fault-pvddq-cpu1 {
 			label = "alrt-pvddq-cpu1";
 			gpios = <&pca0 12 GPIO_ACTIVE_LOW>;
 			linux,code = <6>;
 		};
 
-		fault-pvccin-cpu1 {
+		event-fault-pvccin-cpu1 {
 			label = "fault-pvccin-cpuq";
 			gpios = <&pca0 13 GPIO_ACTIVE_LOW>;
 			linux,code = <7>;
 		};
 
-		bmc-rom0-wp {
+		event-bmc-rom0-wp {
 			label = "bmc-rom0-wp";
 			gpios = <&pca1 0 GPIO_ACTIVE_LOW>;
 			linux,code = <8>;
 		};
 
-		bmc-rom1-wp {
+		event-bmc-rom1-wp {
 			label = "bmc-rom1-wp";
 			gpios = <&pca1 1 GPIO_ACTIVE_LOW>;
 			linux,code = <9>;
 		};
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca1 2 GPIO_ACTIVE_LOW>;
 			linux,code = <10>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca1 3 GPIO_ACTIVE_LOW>;
 			linux,code = <11>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca1 4 GPIO_ACTIVE_LOW>;
 			linux,code = <12>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca1 5 GPIO_ACTIVE_LOW>;
 			linux,code = <13>;
 		};
 
-		fan4-presence {
+		event-fan4-presence {
 			label = "fan4-presence";
 			gpios = <&pca1 6 GPIO_ACTIVE_LOW>;
 			linux,code = <14>;
 		};
 
-		fan5-presence {
+		event-fan5-presence {
 			label = "fan5-presence";
 			gpios = <&pca1 7 GPIO_ACTIVE_LOW>;
 			linux,code = <15>;
 		};
 
-		front-bp1-presence {
+		event-front-bp1-presence {
 			label = "front-bp1-presence";
 			gpios = <&pca1 8 GPIO_ACTIVE_LOW>;
 			linux,code = <16>;
 		};
 
-		rear-bp-presence {
+		event-rear-bp-presence {
 			label = "rear-bp-presence";
 			gpios = <&pca1 9 GPIO_ACTIVE_LOW>;
 			linux,code = <17>;
 		};
 
-		fault-pvccin-cpu0 {
+		event-fault-pvccin-cpu0 {
 			label = "fault-pvccin-cpu0";
 			gpios = <&pca1 10 GPIO_ACTIVE_LOW>;
 			linux,code = <18>;
 		};
 
-		alrt-p1v05-pvcc {
+		event-alrt-p1v05-pvcc {
 			label = "alrt-p1v05-pvcc1";
 			gpios = <&pca1 11 GPIO_ACTIVE_LOW>;
 			linux,code = <19>;
 		};
 
-		fault-p1v05-pvccio {
+		event-fault-p1v05-pvccio {
 			label = "alrt-p1v05-pvcc1";
 			gpios = <&pca1 12 GPIO_ACTIVE_LOW>;
 			linux,code = <20>;
 		};
 
-		alrt-p1v8-pvccio {
+		event-alrt-p1v8-pvccio {
 			label = "alrt-p1v8-pvccio";
 			gpios = <&pca1 13 GPIO_ACTIVE_LOW>;
 			linux,code = <21>;
 		};
 
-		fault-p1v8-pvccio {
+		event-fault-p1v8-pvccio {
 			label = "fault-p1v8-pvccio";
 			gpios = <&pca1 14 GPIO_ACTIVE_LOW>;
 			linux,code = <22>;
 		};
 
-		front-bp0-presence {
+		event-front-bp0-presence {
 			label = "front-bp0-presence";
 			gpios = <&pca1 15 GPIO_ACTIVE_LOW>;
 			linux,code = <23>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index 382da7934eaa..afad8d732cc3 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -193,25 +193,25 @@ gpio-keys-polled {
 		#size-cells = <0>;
 		poll-interval = <1000>;
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca0 15 GPIO_ACTIVE_LOW>;
 			linux,code = <15>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca0 14 GPIO_ACTIVE_LOW>;
 			linux,code = <14>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca0 13 GPIO_ACTIVE_LOW>;
 			linux,code = <13>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca0 12 GPIO_ACTIVE_LOW>;
 			linux,code = <12>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 7213434695bf..fc8222ea2dd0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -183,37 +183,37 @@ gpio-keys-polled {
 		#size-cells = <0>;
 		poll-interval = <1000>;
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca0 6 GPIO_ACTIVE_LOW>;
 			linux,code = <6>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca0 7 GPIO_ACTIVE_LOW>;
 			linux,code = <7>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca0 8 GPIO_ACTIVE_LOW>;
 			linux,code = <8>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca0 9 GPIO_ACTIVE_LOW>;
 			linux,code = <9>;
 		};
 
-		fan4-presence {
+		event-fan4-presence {
 			label = "fan4-presence";
 			gpios = <&pca0 10 GPIO_ACTIVE_LOW>;
 			linux,code = <10>;
 		};
 
-		fan5-presence {
+		event-fan5-presence {
 			label = "fan5-presence";
 			gpios = <&pca0 11 GPIO_ACTIVE_LOW>;
 			linux,code = <11>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
index 60a39ea10ab1..208b0f094ed9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
@@ -73,19 +73,19 @@ fsi: gpio-fsi {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(B, 3) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(B, 3)>;
 		};
 
-		ps0-presence {
+		event-ps0-presence {
 			label = "ps0-presence";
 			gpios = <&gpio ASPEED_GPIO(F, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(F, 0)>;
 		};
 
-		ps1-presence {
+		event-ps1-presence {
 			label = "ps1-presence";
 			gpios = <&gpio ASPEED_GPIO(F, 1) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(F, 1)>;
@@ -97,49 +97,49 @@ gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		poll-interval = <1000>;
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca1 0 GPIO_ACTIVE_LOW>;
 			linux,code = <1>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca1 1 GPIO_ACTIVE_LOW>;
 			linux,code = <2>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca1 2 GPIO_ACTIVE_LOW>;
 			linux,code = <3>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca1 3 GPIO_ACTIVE_LOW>;
 			linux,code = <4>;
 		};
 
-		fan4-presence {
+		event-fan4-presence {
 			label = "fan4-presence";
 			gpios = <&pca1 4 GPIO_ACTIVE_LOW>;
 			linux,code = <5>;
 		};
 
-		fan5-presence {
+		event-fan5-presence {
 			label = "fan5-presence";
 			gpios = <&pca1 5 GPIO_ACTIVE_LOW>;
 			linux,code = <6>;
 		};
 
-		fan6-presence {
+		event-fan6-presence {
 			label = "fan6-presence";
 			gpios = <&pca1 6 GPIO_ACTIVE_LOW>;
 			linux,code = <7>;
 		};
 
-		fan7-presence {
+		event-fan7-presence {
 			label = "fan7-presence";
 			gpios = <&pca1 7 GPIO_ACTIVE_LOW>;
 			linux,code = <8>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
index a52a289cee85..48776fb663fb 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
@@ -92,30 +92,31 @@ video_engine_memory: jpegbuffer {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		air-water {
+		event-air-water {
 			label = "air-water";
 			gpios = <&gpio ASPEED_GPIO(F, 6) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(F, 6)>;
 		};
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 2)>;
 		};
 
-		ps0-presence {
+		event-ps0-presence {
 			label = "ps0-presence";
 			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(Z, 2)>;
 		};
 
-		ps1-presence {
+		event-ps1-presence {
 			label = "ps1-presence";
 			gpios = <&gpio ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(Z, 0)>;
 		};
-		id-button {
+
+		button-id {
 			label = "id-button";
 			gpios = <&gpio ASPEED_GPIO(F, 1) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(F, 1)>;
@@ -126,37 +127,37 @@ gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		poll-interval = <1000>;
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca9552 9 GPIO_ACTIVE_LOW>;
 			linux,code = <9>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca9552 10 GPIO_ACTIVE_LOW>;
 			linux,code = <10>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca9552 11 GPIO_ACTIVE_LOW>;
 			linux,code = <11>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca9552 12 GPIO_ACTIVE_LOW>;
 			linux,code = <12>;
 		};
 
-		fan4-presence {
+		event-fan4-presence {
 			label = "fan4-presence";
 			gpios = <&pca9552 13 GPIO_ACTIVE_LOW>;
 			linux,code = <13>;
 		};
 
-		fan5-presence {
+		event-fan5-presence {
 			label = "fan5-presence";
 			gpios = <&pca9552 14 GPIO_ACTIVE_LOW>;
 			linux,code = <14>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
index 7d38d121ec6d..31ff19ef87a0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
@@ -46,31 +46,31 @@ video_engine_memory: jpegbuffer {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		air-water {
+		event-air-water {
 			label = "air-water";
 			gpios = <&gpio ASPEED_GPIO(F, 6) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(F, 6)>;
 		};
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 2)>;
 		};
 
-		ps0-presence {
+		event-ps0-presence {
 			label = "ps0-presence";
 			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(Z, 2)>;
 		};
 
-		ps1-presence {
+		event-ps1-presence {
 			label = "ps1-presence";
 			gpios = <&gpio ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(Z, 0)>;
 		};
 
-		id-button {
+		button-id {
 			label = "id-button";
 			gpios = <&gpio ASPEED_GPIO(F, 1) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(F, 1)>;
@@ -81,31 +81,31 @@ gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		poll-interval = <1000>;
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca9552 9 GPIO_ACTIVE_LOW>;
 			linux,code = <9>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca9552 10 GPIO_ACTIVE_LOW>;
 			linux,code = <10>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca9552 11 GPIO_ACTIVE_LOW>;
 			linux,code = <11>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca9552 12 GPIO_ACTIVE_LOW>;
 			linux,code = <12>;
 		};
 
-		fan4-presence {
+		event-fan4-presence {
 			label = "fan4-presence";
 			gpios = <&pca9552 13 GPIO_ACTIVE_LOW>;
 			linux,code = <13>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts b/arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts
index 3d4bdad27c2d..ac0d666ca10e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts
@@ -96,7 +96,7 @@ fsi: gpio-fsi {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 2)>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
index cd660c1ff3f5..45631b47a7b3 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -73,7 +73,7 @@ fsi: gpio-fsi {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(P, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(P, 5)>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
index 084f54866f38..893e621ecab1 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
@@ -87,7 +87,7 @@ fsi: gpio-fsi {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 2)>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
index 4816486c0c9e..bbf864f84d37 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
@@ -38,37 +38,37 @@ gfx_memory: framebuffer {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		air-water {
+		event-air-water {
 			label = "air-water";
 			gpios = <&gpio ASPEED_GPIO(B, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(B, 5)>;
 		};
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 2)>;
 		};
 
-		ps0-presence {
+		event-ps0-presence {
 			label = "ps0-presence";
 			gpios = <&gpio ASPEED_GPIO(R, 7) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(R, 7)>;
 		};
 
-		ps1-presence {
+		event-ps1-presence {
 			label = "ps1-presence";
 			gpios = <&gpio ASPEED_GPIO(N, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(N, 0)>;
 		};
 
-		oppanel-presence {
+		event-oppanel-presence {
 			label = "oppanel-presence";
 			gpios = <&gpio ASPEED_GPIO(A, 7) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(A, 7)>;
 		};
 
-		opencapi-riser-presence {
+		event-opencapi-riser-presence {
 			label = "opencapi-riser-presence";
 			gpios = <&gpio ASPEED_GPIO(I, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(I, 0)>;
@@ -84,55 +84,55 @@ gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		poll-interval = <1000>;
 
-		scm0-presence {
+		event-scm0-presence {
 			label = "scm0-presence";
 			gpios = <&pca9552 6 GPIO_ACTIVE_LOW>;
 			linux,code = <6>;
 		};
 
-		scm1-presence {
+		event-scm1-presence {
 			label = "scm1-presence";
 			gpios = <&pca9552 7 GPIO_ACTIVE_LOW>;
 			linux,code = <7>;
 		};
 
-		cpu0vrm-presence {
+		event-cpu0vrm-presence {
 			label = "cpu0vrm-presence";
 			gpios = <&pca9552 12 GPIO_ACTIVE_LOW>;
 			linux,code = <12>;
 		};
 
-		cpu1vrm-presence {
+		event-cpu1vrm-presence {
 			label = "cpu1vrm-presence";
 			gpios = <&pca9552 13 GPIO_ACTIVE_LOW>;
 			linux,code = <13>;
 		};
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca0 5 GPIO_ACTIVE_LOW>;
 			linux,code = <5>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca0 6 GPIO_ACTIVE_LOW>;
 			linux,code = <6>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca0 7 GPIO_ACTIVE_LOW>;
 			linux,code = <7>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca0 8 GPIO_ACTIVE_LOW>;
 			linux,code = <8>;
 		};
 
-		fanboost-presence {
+		event-fanboost-presence {
 			label = "fanboost-presence";
 			gpios = <&pca0 9 GPIO_ACTIVE_LOW>;
 			linux,code = <9>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index 72b7a6639ed9..6f6a35fe2caf 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -50,13 +50,13 @@ vga_memory: region@bf000000 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		ps0-presence {
+		event-ps0-presence {
 			label = "ps0-presence";
 			gpios = <&gpio0 ASPEED_GPIO(H, 3) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(H, 3)>;
 		};
 
-		ps1-presence {
+		event-ps1-presence {
 			label = "ps1-presence";
 			gpios = <&gpio0 ASPEED_GPIO(E, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(E, 5)>;
@@ -69,25 +69,25 @@ gpio-keys-polled {
 		#size-cells = <0>;
 		poll-interval = <1000>;
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca0 4 GPIO_ACTIVE_LOW>;
 			linux,code = <4>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca0 5 GPIO_ACTIVE_LOW>;
 			linux,code = <5>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca0 6 GPIO_ACTIVE_LOW>;
 			linux,code = <6>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca0 7 GPIO_ACTIVE_LOW>;
 			linux,code = <7>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
index 328ef472c479..8a7fb55ab489 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
@@ -63,13 +63,13 @@ alarm_yel {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		button_checkstop {
+		event-checkstop {
 			label = "checkstop";
 			linux,code = <74>;
 			gpios = <&gpio ASPEED_GPIO(P, 5) GPIO_ACTIVE_LOW>;
 		};
 
-		button_identify {
+		event-identify {
 			label = "identify";
 			linux,code = <152>;
 			gpios = <&gpio ASPEED_GPIO(O, 7) GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index 230f3584bcab..a20a532fc280 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -51,25 +51,25 @@ video_engine_memory: jpegbuffer {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		air-water {
+		event-air-water {
 			label = "air-water";
 			gpios = <&gpio ASPEED_GPIO(B, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(B, 5)>;
 		};
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(J, 2)>;
 		};
 
-		ps0-presence {
+		event-ps0-presence {
 			label = "ps0-presence";
 			gpios = <&gpio ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(P, 7)>;
 		};
 
-		ps1-presence {
+		event-ps1-presence {
 			label = "ps1-presence";
 			gpios = <&gpio ASPEED_GPIO(N, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(N, 0)>;
@@ -85,25 +85,25 @@ gpio-keys-polled {
 		compatible = "gpio-keys-polled";
 		poll-interval = <1000>;
 
-		fan0-presence {
+		event-fan0-presence {
 			label = "fan0-presence";
 			gpios = <&pca0 4 GPIO_ACTIVE_LOW>;
 			linux,code = <4>;
 		};
 
-		fan1-presence {
+		event-fan1-presence {
 			label = "fan1-presence";
 			gpios = <&pca0 5 GPIO_ACTIVE_LOW>;
 			linux,code = <5>;
 		};
 
-		fan2-presence {
+		event-fan2-presence {
 			label = "fan2-presence";
 			gpios = <&pca0 6 GPIO_ACTIVE_LOW>;
 			linux,code = <6>;
 		};
 
-		fan3-presence {
+		event-fan3-presence {
 			label = "fan3-presence";
 			gpios = <&pca0 7 GPIO_ACTIVE_LOW>;
 			linux,code = <7>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
index 7ae4ea0d2931..0cb7b20ff3ab 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
@@ -58,13 +58,13 @@ onewire3 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		checkstop {
+		event-checkstop {
 			label = "checkstop";
 			gpios = <&gpio ASPEED_GPIO(F, 7) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(F, 7)>;
 		};
 
-		pcie-e2b-present{
+		event-pcie-e2b-present{
 			label = "pcie-e2b-present";
 			gpios = <&gpio ASPEED_GPIO(E, 7) GPIO_ACTIVE_LOW>;
 			linux,code = <ASPEED_GPIO(E, 7)>;
-- 
2.34.1

