Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260825A9043
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiIAH11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbiIAH0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:26:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D733A48A;
        Thu,  1 Sep 2022 00:25:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id s7so6196020wro.2;
        Thu, 01 Sep 2022 00:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pdN11kKr9DTuNrqt+uSFhl8YF8zaR8pTHZ/yU4266Jk=;
        b=cSYph95jYIpU6saUzJZimP3GqJpctQqbEEWcuKk3CadJ4nu5NO9tRafg91fA7HUhWR
         ozXUOz9SINk9ywQWYV8pOqJQR9tGfKJv/SV+TxTujMjD9dcGfbsU8vikmQI8qBN9hVbx
         vhfyEDwoDZs0h+BMlWFaDbCwpTofSyf1aJuxg6u1yb8zDMzoAFuznKsNr7fLkS1jDpoa
         CZxS9dfhW5xvrarS6u+9Zf4XwspCa+vMfgCMZO0ToZZdgeuMBLK6Ygg+TRMfWiQ46gvB
         IJU4VCybFCkCX2aAggM7+73phTb2On4uX94wW0OTcea86VeJsonopsqNLyH6mCO0g474
         csTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pdN11kKr9DTuNrqt+uSFhl8YF8zaR8pTHZ/yU4266Jk=;
        b=eP6zAcABmZ4Hz9HPz38z8o7rzsOb7aTv5bsYw6kPIJ4XcgjMyT3KxTooH0k9HvvIVW
         N5xPg9VBojbC3Go5+aeGQpt8StrPxEX6Ya4ZYBlvIWbsqOVom8rNF6sKojFVpS1y3MMe
         PYS4NNhSQENbWI+bBvbM0LRPtLkIPzVz27Gy0hbw4biFoTnSUkx8iti0J7R+g2zHZn4j
         y2f0F/sqGwB9ChK9PJQk4RcMU2V2gmj4UWofiUzdnK6ZEg1pg9h16k6zhx8ikJ4DpGQd
         66yBGSvKcTHpnNV5e/L50S02NS4DCcYX8aAAara2bRsyTvNmw6wHGVBbVuPV84lLg4uO
         J8aQ==
X-Gm-Message-State: ACgBeo1tawd35Qb+gzdHrOISRUBmqBSd5ZaCneWCKHReZE0WLzYk7zv2
        B+g8iAIpyaqw5sENlEFoQlA=
X-Google-Smtp-Source: AA6agR6jlX1xBDGQeFhUWZ6UsVCxgM+7DmJ0awkNafVT5DIyUFh0vpz9e8LMJM9ScDBMwGb+uVXUag==
X-Received: by 2002:a5d:6488:0:b0:225:f99:338b with SMTP id o8-20020a5d6488000000b002250f99338bmr14118047wri.638.1662017109100;
        Thu, 01 Sep 2022 00:25:09 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id o14-20020adfcf0e000000b0022063e5228bsm13854762wrj.93.2022.09.01.00.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:25:08 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Subject: [PATCH 14/14] arm64: dts: qcom: sm4250: Add support for oneplus-billie2
Date:   Thu,  1 Sep 2022 10:24:13 +0300
Message-Id: <20220901072414.1923075-15-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901072414.1923075-1-iskren.chernev@gmail.com>
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
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
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  | 240 ++++++++++++++++++
 1 file changed, 240 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts

diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
new file mode 100644
index 000000000000..c1cf0288aa5f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -0,0 +1,240 @@
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
+		bootargs = "earlycon=tty0 console=tty0 clk_ignore_unused pd_ignore_unused";
+
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
+			status= "okay";
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
+	status = "okay";
+	vdd-supply = <&vreg_l4a>;
+	vdda-pll-supply = <&vreg_l12a>;
+	vdda-phy-dpdm-supply = <&vreg_l15a>;
+
+};
+
+&tlmm {
+	gpio-reserved-ranges = <14 4>;
+};
+
+&sdhc_2 {
+	status = "okay";
+	vmmc-supply = <&vreg_l22a>;
+	vqmmc-supply = <&vreg_l5a>;
+
+	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_state_on>;
+	pinctrl-1 = <&sdc2_state_off>;
+};
+
+&ufs_mem_hc {
+	status = "okay";
+	vcc-supply = <&vreg_l24a>;
+	vcc-max-microamp = <600000>;
+	vccq2-supply = <&vreg_l11a>;
+	vccq2-max-microamp = <600000>;
+};
+
+&ufs_mem_phy {
+	status = "okay";
+	vdda-phy-supply = <&vreg_l4a>;
+	vdda-pll-supply = <&vreg_l12a>;
+	vddp-ref-clk-supply = <&vreg_l18a>;
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

