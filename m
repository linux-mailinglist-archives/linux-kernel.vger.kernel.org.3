Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AA247169C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhLKVPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbhLKVOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:48 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36A4C0698CC;
        Sat, 11 Dec 2021 13:14:41 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id l22so24096451lfg.7;
        Sat, 11 Dec 2021 13:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C5+BX638e/zr1wlcSpe5wD1KbonKJ+ofJR/o6bNYwLY=;
        b=S4tTGwU2J41V0zrJCpXdp1qxBO7MQP9fh/s5edR+Rq1nuUrXWLH1gkdntzrUR1A/g2
         BGz0dv+X69+fn+R1k9i0+sB/PwXa7lkaXahdFhCifq4rMqCMDWaWhAv7ixNVoAlf32yi
         SpoLVyuEFHp3kLjQygSZ3OSRxjzsnvnUMkWJm+kP1H/fl+xh3bZpAtOl+1ri0QrK3iBW
         CsYtJHG0IZYC2LxmKw+wYSf8/qFFsZipmK5FnnipPnHixEDbHyMhoCXkkSEFLx1vo/Im
         y1//BnJx4XNJDxW4Lmmn8tRkPq9Osi7KkQJ5dMWgXYyaLhZGqfv76xT84g8uFfxhhUmY
         NMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C5+BX638e/zr1wlcSpe5wD1KbonKJ+ofJR/o6bNYwLY=;
        b=8GcXYNUWs43Ftr3oIOda+chl6+FMrzZYM/oqCYEpBKPvacHOQnpJ3IV0Dn6EBMK7mg
         cf3K4QYoVDdR/cspNO3n6V9I1AD8x1GqVneq7oqUY1opCHH+mZHO7AdPkRVW0qOh8i0Q
         JeW+wHCMa/ebrrGEjiKZ2BC9CPRpSrdxJq8fzcImP1MbtniG5XBjAKGnKgkqH+NctFW6
         A3nt0Cg6RnXey9aj0Arwo3rb9e0/xMhnnr1+89+Zi62jRAtnMr3smbd86C+3dy/c0vGh
         c61jTdktX1GNN5NfimGMZgmMK1xAcDXnS+sqFNo/mhzBR4CIIiK6dI2peURQ6JYwV0qL
         yBGQ==
X-Gm-Message-State: AOAM530ctuPsDVX/VERFWns/kKoN0Ixc4+E+w/Om6XEAuYK71toMXGFz
        papypYV69Q2KCe3xzo0jhyU=
X-Google-Smtp-Source: ABdhPJyLXaZpmA35EJMWVZ53d9IaqNIE4KD+6BFBSKFaToaJ2Ikx8jxhf+GliFnkBiUpD340sZ2KBA==
X-Received: by 2002:ac2:5e89:: with SMTP id b9mr11220227lfq.616.1639257280059;
        Sat, 11 Dec 2021 13:14:40 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:39 -0800 (PST)
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
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 18/28] ARM: tegra: Add CPU thermal zones to Nyan device-tree
Date:   Sun, 12 Dec 2021 00:14:02 +0300
Message-Id: <20211211211412.10791-19-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
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

