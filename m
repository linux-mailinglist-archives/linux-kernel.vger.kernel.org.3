Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B8046DA1B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbhLHRmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbhLHRl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:41:56 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F64CC0698DA;
        Wed,  8 Dec 2021 09:38:22 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bu18so7185153lfb.0;
        Wed, 08 Dec 2021 09:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMUuIocGtaz/dim3Sr66ib6en8JPWKmr1OX/eip6Er8=;
        b=NiSZEzDsJcb8CxU33QQfE1TFg/eNmk35X1jM0BR4Upza0OpneVFcxtDAqmFp9LqbAe
         XpKuU/waXjb1GuXSiqtHAo0e65czdjDIWW+PZz3kQhkep0W2AUUiOsj9Gskc+g8cGs0l
         kKZ6pvQF4lYauzHnCK+uIui9WEcfbiyzNXDYTSLwJLnW8KUcTImZxgweu/DuVhiHW4gW
         OpB2fdiqdms5sx3vL0cFcs0RA1/YkXAf8G3Xfwat2xCtFGQWygWkHVHpYu48rBoToNeh
         HMYAVNW1VRKSm2/9jIJGnSy6/jihTrLogSpnlpDSjnxIEwcDoLoNwI6LhH2ZnutqCl0T
         BPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMUuIocGtaz/dim3Sr66ib6en8JPWKmr1OX/eip6Er8=;
        b=xCoTUsF2GjmMnhA+dxcGBB4AJr3nslSz6GCjbxDv2ZpDzyQF/pNGbcumO6xyCTq5Ib
         C+IGMehFHOtOqu189rjPxwGHPTKpVIlES2ygCc4Ixe7XcOMRk2XIw+zaAKvxhelDRXCi
         r/78t5t/euwdK+OI1Ybli7sYL9QR2CqgsTGPpplCVGBuqKmaSGRlO224NKFWmPfWOyKT
         iSXL1W0lc65A0h6x8yjXEBRiKdhZmHcJFkwdoq31trTT9jSOcpinMo8AWuaObgaTl5xn
         LcY8wXHRDqaBMbpK3dyfT5KCQBKi5TIDjM49RqHPqjdSqM7hu/Br3XWKLENw5xg9kw7b
         Nhhg==
X-Gm-Message-State: AOAM530kC63vKXCXThTnQ4NoOOK152HVEU1pWlzhQ1a+H3a4s+2XYoA+
        +L1DkJi8riMXGe/OkfX47Jc=
X-Google-Smtp-Source: ABdhPJyztRfD6DwpjCpKbUI3ms5gvdy7bWoo/b813iPFH6FK6qpGT04zT1nH+R3ED5NTSO78HV0U7Q==
X-Received: by 2002:ac2:5dc2:: with SMTP id x2mr847968lfq.228.1638985100643;
        Wed, 08 Dec 2021 09:38:20 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id a25sm349159lfm.250.2021.12.08.09.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:38:20 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 21/24] ARM: tegra: nexus7: Use common LVDS display device-tree
Date:   Wed,  8 Dec 2021 20:36:06 +0300
Message-Id: <20211208173609.4064-22-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208173609.4064-1-digetx@gmail.com>
References: <20211208173609.4064-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Schwalm <maxim.schwalm@gmail.com>

Make Nexus 7 device-tree to use common LVDS bridge description. This makes
device-trees more consistent.

[digetx@gmail.com: factored Nexus7 change into separate patch and wrote commit message]
Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../tegra30-asus-nexus7-grouper-common.dtsi   | 54 ++-----------------
 1 file changed, 3 insertions(+), 51 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
index e6aed19a5f3b..861ac96bd806 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
@@ -8,6 +8,7 @@
 #include "tegra30.dtsi"
 #include "tegra30-cpu-opp.dtsi"
 #include "tegra30-cpu-opp-microvolt.dtsi"
+#include "tegra30-asus-lvds-display.dtsi"
 
 / {
 	aliases {
@@ -59,21 +60,6 @@ trustzone@bfe00000 {
 		};
 	};
 
-	host1x@50000000 {
-		dc@54200000 {
-			rgb {
-				status = "okay";
-
-				port@0 {
-					lcd_output: endpoint {
-						remote-endpoint = <&lvds_encoder_input>;
-						bus-width = <24>;
-					};
-				};
-			};
-		};
-	};
-
 	gpio@6000d000 {
 		init-mode-hog {
 			gpio-hog;
@@ -1114,20 +1100,14 @@ display-panel {
 		 */
 		compatible = "panel-lvds";
 
-		power-supply = <&vdd_pnl>;
-		backlight = <&backlight>;
-
 		width-mm = <94>;
 		height-mm = <150>;
 		rotation = <180>;
 
 		data-mapping = "jeida-24";
 
-		port {
-			panel_input: endpoint {
-				remote-endpoint = <&lvds_encoder_output>;
-			};
-		};
+		/* DDC unconnected on Nexus 7 */
+		/delete-property/ ddc-i2c-bus;
 	};
 
 	firmware {
@@ -1179,34 +1159,6 @@ volume-down {
 		};
 	};
 
-	lvds-encoder {
-		compatible = "ti,sn75lvds83", "lvds-encoder";
-
-		powerdown-gpios = <&gpio TEGRA_GPIO(N, 6) GPIO_ACTIVE_LOW>;
-		power-supply = <&vdd_3v3_sys>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-
-				lvds_encoder_input: endpoint {
-					remote-endpoint = <&lcd_output>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-
-				lvds_encoder_output: endpoint {
-					remote-endpoint = <&panel_input>;
-				};
-			};
-		};
-	};
-
 	vdd_5v0_sys: regulator-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_5v0";
-- 
2.33.1

