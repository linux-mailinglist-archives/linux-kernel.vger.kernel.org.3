Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D73349BEC9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiAYWou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiAYWot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:44:49 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79D8C061747
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:44:48 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so4304378pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+2f4cgMKFZkt703lEpU72MPLqkpxKW2wYDJEk12UsQ=;
        b=J1jH4hqcJ6FsZAS5lZsOmIeaBWRMzktwpQzM8wotXftUFG3P9VyueVjaEGppMZcHTT
         eD6Uw/6BoH6+cKQbqNMX0eDRvKBHPc/AjUwiaezDdrq+DqbxVhcmax1AwI97kc86eTAa
         SgGrLCT1ngUZCD1d/dtcdmceu8rJ2yEwC+CO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+2f4cgMKFZkt703lEpU72MPLqkpxKW2wYDJEk12UsQ=;
        b=LVhRrLsfbJhPCaRAIDDBCOSv7xmc7+DCT1TM3VofWuO+tbQ0XeIpry1cwESddRNngG
         8XyKDFmQLDWggjctttj0Wy1PkFNy2SdAbfnhYU0DygdpahnVrMhEt0O7XYaAEDZOOsbb
         H91CqMND1YNkk3M6bKXQxJklnrbYqDbvS3UKfeuQBUkYDp0Jd+dctrnwPhcE6+lhmGSY
         ZxAaOzIpaQeI0bjLO0/cDRiRYBuUqdsUVRH4AmeN8EnvcOLnE+OXoWYpavYD0/e6KOia
         hy70LkskizohnUpyHs5zMa2YtSAsJMK8ML9xjcUlV1xm8Kx9d1/AmvbCeJkOCMsjPGnP
         KBnA==
X-Gm-Message-State: AOAM533fK1y5hHbu6yxrrclQDppeY1djxQI6BpEzk/Al7nTn3K43fqHq
        nAYFKZuDa107CziLjHnlOtaafQ==
X-Google-Smtp-Source: ABdhPJzf4bl0fi2pw5CU6TDG4SjJQgkzHZ5QZbQcy90ax0pfu5z+wN7JANoFMOn8dnN5YLdPYq0j2g==
X-Received: by 2002:a17:902:8f91:b0:149:87ff:ac85 with SMTP id z17-20020a1709028f9100b0014987ffac85mr20836859plo.162.1643150688343;
        Tue, 25 Jan 2022 14:44:48 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f313:ff03:9fc5:6152])
        by smtp.gmail.com with ESMTPSA id p12sm1322335pjj.55.2022.01.25.14.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:44:48 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     konrad.dybcio@somainline.org, swboyd@chromium.org,
        kgodara@codeaurora.org, mka@chromium.org, sibis@codeaurora.org,
        pmaliset@codeaurora.org, quic_rjendra@quicinc.com,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] arm64: dts: qcom: sc7280: Factor out Chrome common fragment
Date:   Tue, 25 Jan 2022 14:44:20 -0800
Message-Id: <20220125144316.v2.3.Iac012fa8d727be46448d47027a1813ea716423ce@changeid>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220125224422.544381-1-dianders@chromium.org>
References: <20220125224422.544381-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This factors out a device tree fragment from some sc7280 device
trees. It represents the device tree bits that should be included for
"Chrome" based sc7280 boards. On these boards the bootloader (Coreboot
+ Depthcharge) configures things slightly different than the
bootloader that Qualcomm provides. The modem firmware on these boards
also works differently than on other Qulacomm products and thus the
reserved memory map needs to be adjusted.

NOTES:
- This is _not_ quite a no-op change. The "herobrine" and "idp"
  fragments here were different and it looks like someone simply
  forgot to update the herobrine version. This updates a few numbers
  to match IDP. This will also cause the `pmk8350_pon` to be disabled
  on idp/crd, which I belive is a correct change.
- At the moment this assumes LTE skus. Once it's clearer how WiFi SKUs
  will work (how much of the memory map they can reclaim) we may add
  an extra fragment that will rejigger one way or the other.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- memory-region syntax change as per Stephen.

 .../boot/dts/qcom/sc7280-chrome-common.dtsi   | 97 +++++++++++++++++++
 .../qcom/sc7280-herobrine-herobrine-r0.dts    | 70 +------------
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      | 75 +-------------
 3 files changed, 101 insertions(+), 141 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
new file mode 100644
index 000000000000..9f4a9c263c35
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * sc7280 fragment for devices with Chrome bootloader
+ *
+ * This file mainly tries to abstract out the memory protections put into
+ * place by the Chrome bootloader which are different than what's put into
+ * place by Qualcomm's typical bootloader. It also has a smattering of other
+ * things that will hold true for any conceivable Chrome design
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+/*
+ * Reserved memory changes
+ *
+ * Delete all unused memory nodes and define the peripheral memory regions
+ * required by the setup for Chrome boards.
+ */
+
+/delete-node/ &hyp_mem;
+/delete-node/ &xbl_mem;
+/delete-node/ &reserved_xbl_uefi_log;
+/delete-node/ &sec_apps_mem;
+
+/ {
+	reserved-memory {
+		adsp_mem: memory@86700000 {
+			reg = <0x0 0x86700000 0x0 0x2800000>;
+			no-map;
+		};
+
+		camera_mem: memory@8ad00000 {
+			reg = <0x0 0x8ad00000 0x0 0x500000>;
+			no-map;
+		};
+
+		venus_mem: memory@8b200000 {
+			reg = <0x0 0x8b200000 0x0 0x500000>;
+			no-map;
+		};
+
+		mpss_mem: memory@8b800000 {
+			reg = <0x0 0x8b800000 0x0 0xf600000>;
+			no-map;
+		};
+
+		wpss_mem: memory@9ae00000 {
+			reg = <0x0 0x9ae00000 0x0 0x1900000>;
+			no-map;
+		};
+
+		mba_mem: memory@9c700000 {
+			reg = <0x0 0x9c700000 0x0 0x200000>;
+			no-map;
+		};
+	};
+};
+
+/* The PMIC PON code isn't compatible w/ how Chrome EC/BIOS handle things. */
+&pmk8350_pon {
+	status = "disabled";
+};
+
+/*
+ * Chrome designs always boot from SPI flash hooked up to the qspi.
+ *
+ * It's expected that all boards will support "dual SPI" at 37.5 MHz.
+ * If some boards need a different speed or have a package that allows
+ * Quad SPI together with WP then those boards can easily override.
+ */
+&qspi {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi_clk>, <&qspi_cs0>, <&qspi_data01>;
+
+	spi_flash: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+
+		spi-max-frequency = <37500000>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
+	};
+};
+
+/* Modem setup is different on Chrome setups than typical Qualcomm setup */
+&remoteproc_mpss {
+	status = "okay";
+	compatible = "qcom,sc7280-mss-pil";
+	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
+	memory-region = <&mba_mem>, <&mpss_mem>;
+};
+
+/* Increase the size from 2.5MB to 8MB */
+&rmtfs_mem {
+	reg = <0x0 0x9c900000 0x0 0x800000>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
index 8676c93590b5..67680a13c234 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
@@ -22,62 +22,15 @@
 #include "pm8350c.dtsi"
 #include "pmk8350.dtsi"
 
+#include "sc7280-chrome-common.dtsi"
+
 / {
 	model = "Google Herobrine (rev0)";
 	compatible = "google,herobrine",
 		     "qcom,sc7280";
 };
 
-/*
- * Reserved memory changes
- *
- * Delete all unused memory nodes and define the peripheral memory regions
- * required by the board dts.
- *
- */
-
-/delete-node/ &hyp_mem;
-/delete-node/ &xbl_mem;
-/delete-node/ &sec_apps_mem;
-
-/* Increase the size from 2MB to 8MB */
-&rmtfs_mem {
-	reg = <0x0 0x83600000 0x0 0x800000>;
-};
-
 / {
-	reserved-memory {
-		adsp_mem: memory@86700000 {
-			reg = <0x0 0x86700000 0x0 0x2800000>;
-			no-map;
-		};
-
-		camera_mem: memory@8ad00000 {
-			reg = <0x0 0x8ad00000 0x0 0x500000>;
-			no-map;
-		};
-
-		venus_mem: memory@8b200000 {
-			reg = <0x0 0x8b200000 0x0 0x500000>;
-			no-map;
-		};
-
-		mpss_mem: memory@8b800000 {
-			reg = <0x0 0x8b800000 0x0 0xf600000>;
-			no-map;
-		};
-
-		wpss_mem: memory@9ae00000 {
-			reg = <0x0 0x9ae00000 0x0 0x1900000>;
-			no-map;
-		};
-
-		mba_mem: memory@9c700000 {
-			reg = <0x0 0x9c700000 0x0 0x200000>;
-			no-map;
-		};
-	};
-
 	aliases {
 		serial0 = &uart5;
 		serial1 = &uart7;
@@ -691,10 +644,6 @@ &pmk8350_gpios {
 	status = "disabled"; /* No GPIOs are connected */
 };
 
-&pmk8350_pon {
-	status = "disabled";
-};
-
 &pmk8350_rtc {
 	status = "disabled";
 };
@@ -717,21 +666,6 @@ &qfprom {
 	vcc-supply = <&vdd_qfprom>;
 };
 
-&qspi {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&qspi_clk>, <&qspi_cs0>, <&qspi_data01>;
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-
-		spi-max-frequency = <37500000>;
-		spi-tx-bus-width = <2>;
-		spi-rx-bus-width = <2>;
-	};
-};
-
 &qupv3_id_0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index d623d71d8bd4..98c8f39ce459 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -13,6 +13,8 @@
 #include "pm8350c.dtsi"
 #include "pmk8350.dtsi"
 
+#include "sc7280-chrome-common.dtsi"
+
 / {
 	gpio-keys {
 		compatible = "gpio-keys";
@@ -45,58 +47,6 @@ nvme_3v3_regulator: nvme-3v3-regulator {
 	};
 };
 
-/*
- * Reserved memory changes
- *
- * Delete all unused memory nodes and define the peripheral memory regions
- * required by the board dts.
- *
- */
-
-/delete-node/ &hyp_mem;
-/delete-node/ &xbl_mem;
-/delete-node/ &reserved_xbl_uefi_log;
-/delete-node/ &sec_apps_mem;
-
-/* Increase the size from 2.5MB to 8MB */
-&rmtfs_mem {
-	reg = <0x0 0x9c900000 0x0 0x800000>;
-};
-
-/ {
-	reserved-memory {
-		adsp_mem: memory@86700000 {
-			reg = <0x0 0x86700000 0x0 0x2800000>;
-			no-map;
-		};
-
-		camera_mem: memory@8ad00000 {
-			reg = <0x0 0x8ad00000 0x0 0x500000>;
-			no-map;
-		};
-
-		venus_mem: memory@8b200000 {
-			reg = <0x0 0x8b200000 0x0 0x500000>;
-			no-map;
-		};
-
-		mpss_mem: memory@8b800000 {
-			reg = <0x0 0x8b800000 0x0 0xf600000>;
-			no-map;
-		};
-
-		wpss_mem: memory@9ae00000 {
-			reg = <0x0 0x9ae00000 0x0 0x1900000>;
-			no-map;
-		};
-
-		mba_mem: memory@9c700000 {
-			reg = <0x0 0x9c700000 0x0 0x200000>;
-			no-map;
-		};
-	};
-};
-
 &apps_rsc {
 	pm7325-regulators {
 		compatible = "qcom,pm7325-rpmh-regulators";
@@ -313,20 +263,6 @@ &qfprom {
 	vcc-supply = <&vreg_l1c_1p8>;
 };
 
-&qspi {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&qspi_clk>, <&qspi_cs0>, <&qspi_data01>;
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <37500000>;
-		spi-tx-bus-width = <2>;
-		spi-rx-bus-width = <2>;
-	};
-};
-
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -335,13 +271,6 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
-&remoteproc_mpss {
-	status = "okay";
-	compatible = "qcom,sc7280-mss-pil";
-	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
-	memory-region = <&mba_mem &mpss_mem>;
-};
-
 &sdhc_1 {
 	status = "okay";
 
-- 
2.35.0.rc0.227.g00780c9af4-goog

