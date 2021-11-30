Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2554641A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345047AbhK3Wol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344858AbhK3WmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:42:21 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B790CC061748;
        Tue, 30 Nov 2021 14:39:00 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id l7so44083944lja.2;
        Tue, 30 Nov 2021 14:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C5+BX638e/zr1wlcSpe5wD1KbonKJ+ofJR/o6bNYwLY=;
        b=aVcyR5fpPgypXRrNW8M6Z20ss6njoTs2lIqGxkWL2+mI1d4yEoBS2Q3EHwwG1ESuph
         CMqrTOE7BHtwPs9GwC0JlT98KgZSKKFlKeq9eEaalJ89NsP8J6hbFyPqB4bjcyZUqKD9
         c3c6e8LVL4ur5FmCpmljR4AsqefnyokgPa+x7H2GU7YqFQBv/cmZws5KlCIQmMTgdjtW
         qDxQ0IAEwM7HCCgB8eJUwpopZpOq7pC9Xi8ijo+h78HXntpnQLKmQGYqYjsuCBzF/B1A
         Cz/SwrKZmhpvG0FAebQTtCf6yzN2BHvQufPeeOUlgJBbA3UZJLgtPMwN8W3AcJ3jLhZp
         ThCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C5+BX638e/zr1wlcSpe5wD1KbonKJ+ofJR/o6bNYwLY=;
        b=LVPXlNbY0UW/NnsYsa4baC5SENt/ToSXqsAkorSnqfXHKqmqi2ppVyxadn/I5LzAPx
         Mfh21aJGC7UMP/ZfWih59lUf7T7UgJEjtyP7sYKxWKHSXUrzUhRCX37Bxu9bDMzCCGBp
         GFE5Pl9Tvyc258MmkupISl8PKJy40jI6RKLJwlHl0qD+vuKWL/6MfaNUjC8nJ3grL9BN
         tmgN9twlOxNk7YbkSxADckvVWvGD/yeXwj/8L5qFRGc2myilXHnJcML9knGX95Kbz+Dp
         KScKjnljp2PHwOKHgl20NyKb4GwG4ZiX1zfGMedi4Jh5HAWRaIrx/3cYvP7t8KTA/FL6
         hcqg==
X-Gm-Message-State: AOAM532k5z/yaOygs90KjOxMIptl+UrpjWk7g7OEihLRrlQg0UzqAs4r
        cG64CYTvFlC0kG4LzFt23oA=
X-Google-Smtp-Source: ABdhPJxn8l2480a6DecgV3ino9MOUL8qxnmu4Ew5/hufA28ydoTcPUzpXhIZGHvwrJMHkw9q+qkSUQ==
X-Received: by 2002:a05:651c:550:: with SMTP id q16mr1690044ljp.371.1638311939095;
        Tue, 30 Nov 2021 14:38:59 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y11sm1820518ljd.117.2021.11.30.14.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:38:58 -0800 (PST)
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
Subject: [PATCH v4 18/24] ARM: tegra: Add CPU thermal zones to Nyan device-tree
Date:   Wed,  1 Dec 2021 01:38:14 +0300
Message-Id: <20211130223820.23609-19-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130223820.23609-1-digetx@gmail.com>
References: <20211130223820.23609-1-digetx@gmail.com>
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

