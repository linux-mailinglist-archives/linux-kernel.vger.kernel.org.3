Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E115464192
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344850AbhK3WoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344656AbhK3WmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:42:09 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85633C06175C;
        Tue, 30 Nov 2021 14:38:46 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bu18so57769584lfb.0;
        Tue, 30 Nov 2021 14:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4IwO4kGobLVHvjCSSLERenRQeivNnevZnqLU5GOyCYY=;
        b=DUN1tq6f2SqbT02gGDuZxFRZUX98m2JP0lELWmuB3zw7mOvmbcpbMP9CiRJ5nWbbIw
         meDFmm8xjctAJ3w26k6N8F2RBaBUAaYAQomb396vqiQSIoRsCe8F4LQxz//91qJwVAA3
         mB88Kcb97P13bzDIeAnbUf62yhXvijop4bLkyzmnVmQsZJIaQ+X/XhfpyswI1cFbgyCu
         hQ1qWmbCd5UlKFm9wr35HMY060pr4s7hu2vkfXafWTW43Fd6FveVbeudHSjAaYcgc7Io
         YGXefGtU6th4uOF3OurTQCxlxzz2VQ5RqlfLmRwgxwtl45lXjagx6r40CwWqKkMUnqjb
         0x8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4IwO4kGobLVHvjCSSLERenRQeivNnevZnqLU5GOyCYY=;
        b=oiHaOUxj0Wy5Me0xQfvbQSapNec7HyGmTS4DZmK1cB+P32MWRWJeoF1RRjk+91Z+22
         rLA9d0HcBTixWYeU71F5HF8prhMLl04fzX4PN1msFn6968AKxVE+7bBC5k6rli61ZysP
         fIIa4pkK02jYno0xDxncB3wFFm0z3uQrr3yMRAxvU0AieGbuT5DwHmVAziS83RqoSlfb
         7QTVVdC9gyqd5q35ij0hmGDY/hG2q8wsgvzG/2772PdNlZ+ejB9dX1I8uqiCM0r66nLt
         I8xWB4FS1P7Jef2RrMPkUKtNrOGD/+Na7P6SeJxs1J2ny/sBekW5vTvgPBwvMNMNpCLl
         dJ4Q==
X-Gm-Message-State: AOAM531Jn5AmXGJ0DCNApUEowZBFJ0NTZnk3a92nKiMPTlFkb76knsXy
        2BJ/zTqbU2j5//7yP4949uo=
X-Google-Smtp-Source: ABdhPJyiDabLkXgCMijWNhXGdocmPp7QDnehxxFoDNNE6Ah/kKxx/D15CUzMYtUDBeTOITTKyQyMSw==
X-Received: by 2002:ac2:5e75:: with SMTP id a21mr2041605lfr.7.1638311924890;
        Tue, 30 Nov 2021 14:38:44 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y11sm1820518ljd.117.2021.11.30.14.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:38:44 -0800 (PST)
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
Subject: [PATCH v4 07/24] ARM: tegra: Add common device-tree for display panel of ASUS devices
Date:   Wed,  1 Dec 2021 01:38:03 +0300
Message-Id: <20211130223820.23609-8-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130223820.23609-1-digetx@gmail.com>
References: <20211130223820.23609-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Schwalm <maxim.schwalm@gmail.com>

All ASUS tablets have a similar design pattern in regards to hardware
integration of display panels, like exactly the same GPIOs are used for
power and reset, same LVDS bridge and etc. Add common device-tree for
display panel of ASUS devices. It will be used by ASUS devices instead
of replicating the boilerplate display graph.

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

