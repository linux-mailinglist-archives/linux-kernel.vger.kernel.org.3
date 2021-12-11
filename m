Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BD7471677
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhLKVOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbhLKVOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:30 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B638DC061751;
        Sat, 11 Dec 2021 13:14:29 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m6so12314330lfu.1;
        Sat, 11 Dec 2021 13:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YAMw4tqKA5C3CvfSPpZ+eRH7uuyLJuH7fFO7xKKE9cg=;
        b=I/ZxXyIY+swSk/4TP/tZmyw2WssCngUJqoFixvS/zk23gZDbJwD7AWxP1jlpvbaAVR
         2jvrb44xn7u2AcKZgD73Xo/X0EKVl/bGAbOhngKm/Isq53BHhCEoiAHVOmmL3jis/3il
         TN8eUA2h53oom8yOnhg64kQAL1fa6bud363TbQXleFEeqImpXI78vVMwNVvbdV9LI4FM
         O9kYGZxyMkvhYXhRDodhmmw3xI0wNq86cwoX6XZBZtsU9CIMA5OHAXUANdt+BIf3kyT3
         hxfMk2YfVy7MBOjPG5PPZ+4tp0iy+FPOKg2fwb6meBzhnrS5BLXJcksxn00qHdVN1kHr
         +IGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YAMw4tqKA5C3CvfSPpZ+eRH7uuyLJuH7fFO7xKKE9cg=;
        b=Hk5ag9DyitKk7yL8TWSEmFfpuUH2eAv3YBrK5/BBAsHy+PMVMy+w1PIpQRUvT2V0KW
         wQEW2ww08g1puleA6uv5jKiKnGiNtKueHEzN/MkPQ2rvS/7ta3C+hR9oiZOkcp0pA2VV
         2cMHCpzk1dfgu1nt1aVxOXeUkJ6nB8UIsV4t71TUtEIFNXT5NmuEUj/zihtH+GBPbdsX
         VcIcwG9G3VGXu1T0PEzI8Nr6thZeVcb4Ro+yEjW6p+Ik+ylkQ3/xNbg+DT7sFjsliW7s
         s6Of2xjRaOHjWdF+v4KpRwFi96Q/QSJoHNbdb7cYWru8eJXAx7RwBdUIEEck5w67YpIs
         p57A==
X-Gm-Message-State: AOAM533fsoh8rIxBO9XkZtIvBE0XEANh/zbftqA7S73kFtHJzkhJcgnM
        udov7uI5sy/p+7HVfniS4G8=
X-Google-Smtp-Source: ABdhPJytTcB8kxdmpeO2kRahLakucqcmFvuX4wrE6B7KQE7NfzLLxwkqHDuNJe6U/hDgZYKGRlm7Gg==
X-Received: by 2002:a19:c50f:: with SMTP id w15mr20025610lfe.479.1639257268038;
        Sat, 11 Dec 2021 13:14:28 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:27 -0800 (PST)
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
Subject: [PATCH v6 07/28] ARM: tegra: Add common device-tree for LVDS display panels of Tegra30 ASUS tablets
Date:   Sun, 12 Dec 2021 00:13:51 +0300
Message-Id: <20211211211412.10791-8-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
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

