Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6FE5AC065
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 19:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiICRoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 13:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiICRnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:43:10 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9325853C;
        Sat,  3 Sep 2022 10:42:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a36so6518102edf.5;
        Sat, 03 Sep 2022 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=iH08URkzH4PtN0w43A4FqUIwqdPE7r8cstz4jRBcSF4=;
        b=CGZ4Kkycta6UgmTIkPkwdhqi4+T8LPWomiIYGeinaXG1B7ToAuSZdQ+dEk9JV29Laj
         Pc4E9mhKuZynp+PQRcU1kQJ6sUTM+rFMfh49WXMZNYQ5zCvbvbhEKwVBvwfgnDjtps4R
         cb1VZd5S1BXtdct+AO3R93u6hKu6Bj+v9CI6Y3lzxEKA8w4xeIKtnvI1t9hYJHvVK/iB
         POzGgE9vnPnvNmtrZVwKr2VU2XaXi7RHqHZhXTvyDDfivy4oVsIvWumfYRHYV13t7O8c
         cCd5cHXEpUAr/dOSVKL+N2SX3a3VvthBvMMbsrW7clYGCwlZT926jriw81Gt18O9plTj
         5MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iH08URkzH4PtN0w43A4FqUIwqdPE7r8cstz4jRBcSF4=;
        b=6pA1+WyX2KbhEozng//9qwK833Z1JPeGPF81CeZKfScDqQWoJ4NhkOnhtrjY35vwIy
         uJg+JU68XClqFtN8ixtpNhAws+O2XotCbixUZCmBXNEpAZInk8bZX/ftOWzXQ+JxsxOw
         +K+vST1Zla2IqcAEv2gF0t6v19J02JJguDGhK4YXRTV2OAqG2a9vF+OMz8bVe9zprRI8
         xAMgsQ5a13ooCBVDmTU9fKpXeAGpsKGsE3H8TD/3O3IGRe4kozCtWkJeK+/uzMplagio
         FIopwsgNXQxpw7vQmayTNdOf3fQ6vq6A3xJ+XySi+w6A3pPmUkUnMubLm+I0PJFXaT2w
         xkmQ==
X-Gm-Message-State: ACgBeo3ra4VnROHMZSF6z2BVFezEJy2fMcr9VXDKPDiQVHu7ukk8eNI3
        lBzb6csoGs4vT11CtunMUyE=
X-Google-Smtp-Source: AA6agR4w9F1P+PSx9hSsZ7PRT7u1y6nV6ps0sq/JULWDegbUAMDq407bTbnPekP06P9DO191AK75Qw==
X-Received: by 2002:a50:baa1:0:b0:43e:5e95:3eda with SMTP id x30-20020a50baa1000000b0043e5e953edamr38020237ede.340.1662226969180;
        Sat, 03 Sep 2022 10:42:49 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7d40b000000b00445b5874249sm3493955edq.62.2022.09.03.10.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 10:42:48 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] arm64: dts: qcom: sm4250: Add support for oneplus-billie2
Date:   Sat,  3 Sep 2022 20:41:50 +0300
Message-Id: <20220903174150.3566935-10-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220903174150.3566935-1-iskren.chernev@gmail.com>
References: <20220903174150.3566935-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for OnePlus Nord N100, based on SM4250. Currently
working:
- boots
- usb
- buildin flash storage (UFS)
- SD card reader

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
Remaining issues from make dtbs_check:
- rpm-requests: it doesn't like the pm6125-regulators subnode. Every other
  DTS I checked is written in this way.

 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  | 243 ++++++++++++++++++
 2 files changed, 244 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 1d86a33de528..b8c2de2932a6 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -133,6 +133,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
new file mode 100644
index 000000000000..ea5f626a6749
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, Iskren Chernev <iskren.chernev@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "sm4250.dtsi"
+
+/ {
+	model = "OnePlus Nord N100";
+	compatible = "oneplus,billie2", "qcom,sm4250";
+
+	/* required for bootloader to select correct board */
+	qcom,msm-id = <0x1a1 0x10000 0x1bc 0x10000>;
+	qcom,board-id = <0x1000b 0x00>;
+
+	aliases {
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "framebuffer0";
+
+		framebuffer0: framebuffer@9d400000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x5c000000 0 (1600 * 720 * 4)>;
+			width = <720>;
+			height = <1600>;
+			stride = <(720 * 4)>;
+			format = "a8r8g8b8";
+		};
+	};
+
+	clocks {
+		xo-board {
+			clock-frequency = <19200000>;
+		};
+
+		sleep-clk {
+			clock-frequency = <32764>;
+		};
+	};
+
+	reserved-memory {
+		mtp_mem: memory@cc300000 {
+			reg = <0x00 0xcc300000 0x00 0xb00000>;
+			no-map;
+		};
+
+		param_mem: memory@cc200000 {
+			reg = <0x00 0xcc200000 0x00 0x100000>;
+			no-map;
+		};
+
+		bootloader_log_mem: memory@5fff7000 {
+			reg = <0x00 0x5fff7000 0x00 0x8000>;
+			no-map;
+		};
+
+		ramoops@cbe00000 {
+			compatible = "ramoops";
+			reg = <0x0 0xcbe00000 0x0 0x400000>;
+			record-size = <0x40000>;
+			pmsg-size = <0x200000>;
+			console-size = <0x40000>;
+			ftrace-size = <0x40000>;
+		};
+	};
+};
+
+&usb3 {
+	status = "okay";
+};
+
+&hsusb_phy {
+	vdd-supply = <&vreg_l4a>;
+	vdda-pll-supply = <&vreg_l12a>;
+	vdda-phy-dpdm-supply = <&vreg_l15a>;
+	status = "okay";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <14 4>;
+};
+
+&sdhc_2 {
+	vmmc-supply = <&vreg_l22a>;
+	vqmmc-supply = <&vreg_l5a>;
+
+	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+
+	status = "okay";
+};
+
+&ufs_mem_hc {
+	vcc-supply = <&vreg_l24a>;
+	vcc-max-microamp = <600000>;
+	vccq2-supply = <&vreg_l11a>;
+	vccq2-max-microamp = <600000>;
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l4a>;
+	vdda-pll-supply = <&vreg_l12a>;
+	vddp-ref-clk-supply = <&vreg_l18a>;
+	status = "okay";
+};
+
+&rpm_requests {
+	pm6125-regulators {
+		compatible = "qcom,rpm-pm6125-regulators";
+
+		vreg_s6a: s6 {
+			regulator-min-microvolt = <320000>;
+			regulator-max-microvolt = <1456000>;
+		};
+
+		vreg_s7a: s7 {
+			regulator-min-microvolt = <1280000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		vreg_s8a: s8 {
+			regulator-min-microvolt = <1064000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l1a: l1 {
+			regulator-min-microvolt = <952000>;
+			regulator-max-microvolt = <1152000>;
+		};
+
+		vreg_l4a: l4 {
+			regulator-min-microvolt = <488000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		vreg_l5a: l5 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <3056000>;
+		};
+
+		vreg_l6a: l6 {
+			regulator-min-microvolt = <576000>;
+			regulator-max-microvolt = <656000>;
+		};
+
+		vreg_l7a: l7 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l8a: l8 {
+			regulator-min-microvolt = <400000>;
+			regulator-max-microvolt = <728000>;
+		};
+
+		vreg_l9a: l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_l10a: l10 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l11a: l11 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		vreg_l12a: l12 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <1984000>;
+		};
+
+		vreg_l13a: l13 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		vreg_l14a: l14 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l15a: l15 {
+			regulator-min-microvolt = <2920000>;
+			regulator-max-microvolt = <3232000>;
+		};
+
+		vreg_l16a: l16 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l17a: l17 {
+			regulator-min-microvolt = <1152000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l18a: l18 {
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l19a: l19 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l20a: l20 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l21a: l21 {
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		vreg_l22a: l22 {
+			regulator-min-microvolt = <2952000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l23a: l23 {
+			regulator-min-microvolt = <3296000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l24a: l24 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <3544000>;
+		};
+	};
+};
-- 
2.37.2

