Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F1E46DA1A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbhLHRmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbhLHRlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:41:55 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A65DC0698CB;
        Wed,  8 Dec 2021 09:38:19 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id u22so5002964lju.7;
        Wed, 08 Dec 2021 09:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C5+BX638e/zr1wlcSpe5wD1KbonKJ+ofJR/o6bNYwLY=;
        b=NdRnazLDGP39FMNnfpQagOAvxDlNBXU0va0P9CYPQ5uwy5zpe2SdiVZf+dBx1KCUTy
         2IFUlOoL0Nhm1FYcVyU6ZDb8yG/kTRsumEEKJmt+2kU/GPFeaWj36Vcobnih5/6R163p
         CcIsmbfOu3VvOFPXkYxFHhEjhK57z3By7MnhFQqQHc0o3qnd0HQDM/TMCKIe5S8Z1NVm
         yDMBlDX/wx2dSn0X65y9cAl0yst35ig2kS7bEI+3ExXUZ0SQsBXY/tBWoPf5zGilcPos
         zdsuhxLHE/eRCiwE+UGd2zrGFZWgS1pNWcRncIP4j0eEfni7BP0KRd3VLyFUAGPJthFo
         YSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C5+BX638e/zr1wlcSpe5wD1KbonKJ+ofJR/o6bNYwLY=;
        b=zYKykm7/kzUx5cdyeCjscY97kAQcgMU0RPcE3wwcAxOMGV2iRZfe8GLjEaP9uBwNbd
         V+yyPjbAijW/3RIRes+Oqt9zwbp1/GvUc2KM6z94haqFabfZTGbaGtkKISR1u3nwNKJA
         zC8xxjysQd/Dm3Q2U644UDCfUDroQYtaqCuzP2cQP3eYYagfCYkPR4a/8Bx+eFKEWMrt
         wfE/Wf6KxHTA8n5S4BS10vGtQQG27uMgm+Dn9Z/xCK53c75N2VUPZNgJYiAuOUeI5QmM
         QUIr3tDO+2Ar4fvlKBPHvCh1064rygoRT0GNwIkC+X0lDp3XtabLKP5jCNQhvKUy0DmK
         HEyw==
X-Gm-Message-State: AOAM532XV8IeTvJil3loo9UVmcdQqyssjdSw3lsIfnNuVcDW2YR4dU5F
        vEFBUHgKK6PKpwJFBzHhq3I=
X-Google-Smtp-Source: ABdhPJyzJ6b4Qha7+L0hrWjKPXB/3g0enzvPuBaACXO7cPzqveLoEJq0wTOHM0HUIe/V9rvHUbj7rw==
X-Received: by 2002:a2e:9654:: with SMTP id z20mr889412ljh.254.1638985097699;
        Wed, 08 Dec 2021 09:38:17 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id a25sm349159lfm.250.2021.12.08.09.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:38:17 -0800 (PST)
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
Subject: [PATCH v5 18/24] ARM: tegra: Add CPU thermal zones to Nyan device-tree
Date:   Wed,  8 Dec 2021 20:36:03 +0300
Message-Id: <20211208173609.4064-19-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208173609.4064-1-digetx@gmail.com>
References: <20211208173609.4064-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU of Nyan Chromebooks is overheating badly because apparently hardware
soctherm controller doesn't work well. Add CPU thermal zones to enable
software thermal control over CPU and fix the overheat trouble.

Tested-by: Thomas Graichen <thomas.graichen@gmail.com> # T124 Nyan Big
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 49 +++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index ec01a23d4d47..b16cce7476ef 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/thermal/thermal.h>
 #include "tegra124.dtsi"
 
 / {
@@ -87,7 +88,7 @@ acodec: audio-codec@10 {
 			interrupts = <TEGRA_GPIO(H, 4) IRQ_TYPE_EDGE_FALLING>;
 		};
 
-		temperature-sensor@4c {
+		tmp451: temperature-sensor@4c {
 			compatible = "ti,tmp451";
 			reg = <0x4c>;
 			interrupt-parent = <&gpio>;
@@ -789,6 +790,52 @@ gpio-restart {
 		gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
 		priority = <200>;
 	};
+
+	cpus {
+		cpu0: cpu@0 {
+			#cooling-cells = <2>;
+		};
+
+		cpu1: cpu@1 {
+			#cooling-cells = <2>;
+		};
+
+		cpu2: cpu@2 {
+			#cooling-cells = <2>;
+		};
+
+		cpu3: cpu@3 {
+			#cooling-cells = <2>;
+		};
+	};
+
+	thermal-zones {
+		cpu-skin-thermal {
+			polling-delay-passive = <1000>; /* milliseconds */
+			polling-delay = <5000>; /* milliseconds */
+
+			thermal-sensors = <&tmp451 0>;
+
+			trips {
+				cpu_passive_trip: cpu-alert0 {
+					/* throttle at 70C until temperature drops to 69.8C */
+					temperature = <70000>;
+					hysteresis = <200>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_passive_trip>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
 };
 
 #include "cros-ec-keyboard.dtsi"
-- 
2.33.1

