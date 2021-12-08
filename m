Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82F946D9FC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238290AbhLHRlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbhLHRlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:41:39 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC45C061D60;
        Wed,  8 Dec 2021 09:38:06 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id bn20so5006290ljb.8;
        Wed, 08 Dec 2021 09:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YAMw4tqKA5C3CvfSPpZ+eRH7uuyLJuH7fFO7xKKE9cg=;
        b=AvFRTFOKtN1IQMjHuI42vlZ+8r/SiDPAT14/DHVI1AdhW9UDfvkSbkWGv84Vxat2na
         nT3ANX4xz7j80yY123lzdetJR+01axv0IpRk6u/1+AzqauEYVSknoI6CsoStr1HdeojG
         fcKZ4gvXIOzSKRswXRDLv68lofzfffMlGFX/BPKcqnMNKuBSPu3qUEORcPvirJBrZwDX
         zccIZ8ZKFFVjVNR0LQNkxgB3oFZQzaBcjT+fsNGkM9NQXcHWxurTsVJXk2MEilNmIi7g
         McHOTdeIchWv5MknvVn1sf/BcoMbimvnQc6BZx2awiOh12ht9DsTZaYxlZrUv/Ws0WMW
         jwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YAMw4tqKA5C3CvfSPpZ+eRH7uuyLJuH7fFO7xKKE9cg=;
        b=6nbNiL2uGYgKPgQ1TwTzHi2FBzvMQTHf3raE6wgNMXVdn7IA617PUkKCFagoBtZ8+W
         KSyzJQW/uCBYUd9GPyDaJXXKTnrTB0wsZgmGuxKGS4R0f46LkFDz4rv2pZDdp+FKBZoq
         PM15HQaEP/AWlA5hg/ZR7YHQfIeJoo9Dc4kMW11IVfTbKWzcE7+g9N/PKgkNgw6SSlL8
         2Ed1npu+FR+0HFB1O1GruiuqqCTSqPyF/RsKsvCfxAo/dYA4fwXyhoR/03ndK4cjISzt
         H1982VXk8puHC5+o4sfEMq9s9+6B57nB+QocFt5LFQuPRpVVeR/Ki6idqhtx35brTAOi
         y2Nw==
X-Gm-Message-State: AOAM530B9wMa+VW0/FyjAKXLPwGVPl47sPbxW63DQrgONoWteAt/Ccqo
        F9c3pSPqbGzDHRLcWXQHd/w=
X-Google-Smtp-Source: ABdhPJzm5eqaEAHfPFsUA6ccEp7X+EoTXczm0DK23YZc4X5h8I8hqpXOdS6fAWi9SnakRAcjOIVDGQ==
X-Received: by 2002:a2e:a553:: with SMTP id e19mr784143ljn.341.1638985084942;
        Wed, 08 Dec 2021 09:38:04 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id a25sm349159lfm.250.2021.12.08.09.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:38:04 -0800 (PST)
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
Subject: [PATCH v5 07/24] ARM: tegra: Add common device-tree for LVDS display panels of Tegra30 ASUS tablets
Date:   Wed,  8 Dec 2021 20:35:52 +0300
Message-Id: <20211208173609.4064-8-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208173609.4064-1-digetx@gmail.com>
References: <20211208173609.4064-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Schwalm <maxim.schwalm@gmail.com>

All Tegra30 ASUS tablets have a similar design pattern in terms of
hardware integration of LVDS display panels, like exactly the same GPIOs
are used for power and reset, etc. Add a common device-tree for LVDS
display panels of Tegra30 ASUS tablets to avoid replicating the
boilerplate panel description.

[digetx@gmail.com: factored out common part into separate patch and wrote commit message]
Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../boot/dts/tegra30-asus-lvds-display.dtsi   | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra30-asus-lvds-display.dtsi

diff --git a/arch/arm/boot/dts/tegra30-asus-lvds-display.dtsi b/arch/arm/boot/dts/tegra30-asus-lvds-display.dtsi
new file mode 100644
index 000000000000..a047abfa6369
--- /dev/null
+++ b/arch/arm/boot/dts/tegra30-asus-lvds-display.dtsi
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* This dtsi file describes parts common for Asus T30 devices with a LVDS panel. */
+
+/ {
+	host1x@50000000 {
+		lcd: dc@54200000 {
+			rgb {
+				status = "okay";
+
+				port@0 {
+					dpi_output: endpoint {
+						remote-endpoint = <&bridge_input>;
+						bus-width = <24>;
+					};
+				};
+			};
+		};
+	};
+
+	display-panel {
+		power-supply = <&vdd_pnl>;
+		ddc-i2c-bus = <&lcd_ddc>;
+		backlight = <&backlight>;
+
+		port {
+			panel_input: endpoint {
+				remote-endpoint = <&bridge_output>;
+			};
+		};
+	};
+
+	/* Texas Instruments SN75LVDS83B LVDS Transmitter */
+	lvds-encoder {
+		compatible = "ti,sn75lvds83", "lvds-encoder";
+
+		powerdown-gpios = <&gpio TEGRA_GPIO(N, 6) GPIO_ACTIVE_LOW>;
+		power-supply = <&vdd_3v3_sys>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				bridge_input: endpoint {
+					remote-endpoint = <&dpi_output>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				bridge_output: endpoint {
+					remote-endpoint = <&panel_input>;
+				};
+			};
+		};
+	};
+};
-- 
2.33.1

