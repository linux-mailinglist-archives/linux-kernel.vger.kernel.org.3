Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E792D4641B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344640AbhK3Wpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344945AbhK3WmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:42:25 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F84EC06175C;
        Tue, 30 Nov 2021 14:39:04 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id p8so30609342ljo.5;
        Tue, 30 Nov 2021 14:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMUuIocGtaz/dim3Sr66ib6en8JPWKmr1OX/eip6Er8=;
        b=NNx5Y+8CmlR1ciyvRnzSjkCPNJybaxUTY0f1sz+8mhz3/Pg3jw1e++LfQgg7SEgTBk
         8CM+L9YfScNBPHM0gY7qf/377I1e6itJtRZnFItdmZdXbtFLzcH/u2l1L/XOSojwSbgJ
         j3O5VgY1rnR8r11jMILXLON/P5WYG+kf/V2kZhuW7X4pVxSwQovzckGHson4J8SlvIGU
         5zCC+bCDWsNbokXP2K3Y1nRUrswg6E7m6szRW7an9N33DHd3IxBmzCHFrx0q35cu+W2J
         rnSOxm/mFc1XOwtokKrQW0fzNUQZpTHA26V/TxFoxM/00AfW3dyV3q4N9eQ9r2en7AS3
         Rsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMUuIocGtaz/dim3Sr66ib6en8JPWKmr1OX/eip6Er8=;
        b=OLGBS7408VdEQZJw/MPePRxUCc8Gaueuf0IEhRFGFY6lOcepB53H5zSQQijd0zlQqU
         oV/SUL4xC2iKXbDNSc65eOUqo3abnjSnFDvw/DL0whhgsvgaN7ZzrJXZy6bh63ZMtZoC
         Cdp9Cjc9pSp6fw5P42TeBJ9W8qWQBrIcscS8hfSgi5maBHwSNgrX31IZf7XOZU2FQJYC
         QJLjVQ/Gj1zhhYrWwCtpZssUnRhYvBh4ZEpqzQm+z9kn65CzohqS9C7e+xaabKwnNJHM
         Tomagi46ufr/vwlL1X+pYmgO3jVPURHnTUv/cfqV5wMoMwxE4sqfAzytrfmAZGUSo2Uf
         tsbg==
X-Gm-Message-State: AOAM530uQjFgQWNhNeMn/T2tPgDoUDD8sG2/DNxblIMdVuEE1fFWUWTT
        tkZfi9fdBO7wwaQMt9lfPA0=
X-Google-Smtp-Source: ABdhPJz7n7KNbRlaOL3ANWj5M75i3WhVoVQRxPZi6A6AT25RSgZvhDRAHfKaaz8QlHvDcgt6ztTodQ==
X-Received: by 2002:a2e:a48e:: with SMTP id h14mr1697156lji.211.1638311942993;
        Tue, 30 Nov 2021 14:39:02 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y11sm1820518ljd.117.2021.11.30.14.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:39:02 -0800 (PST)
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
Subject: [PATCH v4 21/24] ARM: tegra: nexus7: Use common LVDS display device-tree
Date:   Wed,  1 Dec 2021 01:38:17 +0300
Message-Id: <20211130223820.23609-22-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130223820.23609-1-digetx@gmail.com>
References: <20211130223820.23609-1-digetx@gmail.com>
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

