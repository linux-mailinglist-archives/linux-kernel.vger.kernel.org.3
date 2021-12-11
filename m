Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F22B4716A0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhLKVPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbhLKVOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:50 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED083C061B38;
        Sat, 11 Dec 2021 13:14:45 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id bn20so18476545ljb.8;
        Sat, 11 Dec 2021 13:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMUuIocGtaz/dim3Sr66ib6en8JPWKmr1OX/eip6Er8=;
        b=Oj82Q7g3WRlBilM1XIvXrJX9TIzAjCxkBNuQslMbgo9exmhod7AuyJ4XXno/1XuQlA
         qDG/JsOYlB3mVhSPes2oWb7swKU9ctLeQ7dnQCyy3XLcxyyMcTSkjHhumYY1nHPwLXtF
         YUYxjk7FN/v+ruXvimOExiR+8lVfYuklpaAIc3GtbmKdMKg4c842fqE9Co0/6Sjss5T8
         6RiDc0GDwMN1I59pQpGcPVxehAMI94wPbJ1slea8EwFVxobrSQVAW3uc0HrHQcj/ij7B
         /KYTprUYGKQSOD7BpRZkaLSF6i3REkxya6gIp/Qvq5tA4N2hK9gkc7i7/ZquFygEKEql
         D1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMUuIocGtaz/dim3Sr66ib6en8JPWKmr1OX/eip6Er8=;
        b=23IXY7ANhFsytb5ZjONKLi0sbskl/pVm7OzMrlGKOjTBDfC0Y3jAheX/rEhcxlHsxZ
         Ww4mZfmhh1bLFatkQEcJXColJDkqHo6VqH4ZRhSCy/cLK/4cPVJScaBM0kDi5IqFmMR4
         fH5CIRVTwDy5z4+tbgmgUWDnkUdhhGbi6azxLez9tJd7xQxjHQRACCiNGk0081ipVwzR
         WNFPJoEMYI/xe43i1lhU4c8IZVlu5P4hYPCiN3gcmYwLTKqFszEgh8uk1Vvy9raXnyLb
         6uxHezh2Ks3Y6oYs4rAAkh2SgM7tIm/3kiLC6dqs0nSkM3sDP6LGEq9HmCuKI6iAnzZ+
         0CDQ==
X-Gm-Message-State: AOAM531FJn82EiDl+CEIb2FYOjNQxlFZ4m1Lym99kuz1KpQrb/V0W3FO
        ZfjuUNqM2qAi5SPn3WF/nLc=
X-Google-Smtp-Source: ABdhPJzDEBy3PGpyU/eRCFzUqyR5KBf6q1fg5UYzi3pDxLEFuhZohFVhSs+tf+UwLaN1IXkTwga6Kg==
X-Received: by 2002:a2e:a279:: with SMTP id k25mr20365421ljm.37.1639257284310;
        Sat, 11 Dec 2021 13:14:44 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:43 -0800 (PST)
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
Subject: [PATCH v6 22/28] ARM: tegra: nexus7: Use common LVDS display device-tree
Date:   Sun, 12 Dec 2021 00:14:06 +0300
Message-Id: <20211211211412.10791-23-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
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

