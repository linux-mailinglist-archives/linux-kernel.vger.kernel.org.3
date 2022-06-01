Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8966753AF21
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiFAVjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiFAVjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:39:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DD680211;
        Wed,  1 Jun 2022 14:39:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h19so3953304edj.0;
        Wed, 01 Jun 2022 14:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXG8iLTreEU+J/lVUamzhi0tH1NJB4Nk+ekloWw8ey0=;
        b=q4sLaUb6C9WHlwr+BGtYiNab+Z/9DFTw/uTcExKbl2Bd5TMyKEB6byulmZruXYeFpm
         NO9nA8ViBmJToeHcrKcupIiudItTFnvrD0V/o8eqdLkD6zec5d4wOZnERcm5HwbRurkx
         B+6Ys3bd/cKLqEm4Nl02GPOixnGr5Qhow8FsrxPirFfdjV1YJIKAPO4Jdhiu9W+YJgrH
         n31bu4o639UaItJX6wM+Omwp+7Yzri2z2b/Oksbzr0x2a+1a3JFHvaj0k35gKa4ChHBU
         hFtBaS6IHbRybJ6mC/2y65pSUaHsY2a3gZ837gc8yVQFeQeDOCHyDFWD7BxWChTdOqRX
         xSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXG8iLTreEU+J/lVUamzhi0tH1NJB4Nk+ekloWw8ey0=;
        b=O41fltqj1n0KfCmvqqbsVuac6M82ulvrY8MpDVbQnXfX9M3NkhCxFtA+AL4GpXIK7C
         E7+QWkYTRUpK+sRbOTr6G8MdkEahnpngjskHeuNvSGwqlhXCabS4k+QZ6tbtD3jzM9dU
         ZKSYzjsUU/IKRMEltkPYF1PWAb8x0IVUJ2UTd6yKwKIKrdRNASk/c24O8ajvbCM06hk4
         wScaGjPDsvRg1oal1O5sN7StduIai0ZlLjUEA9AlfRti7LBBCROerrJTchFDDV4PxCBC
         7RryNvgEAa4+Pc6XdFkb4fxtrIL7miQitM+IktfMHl/NJ5n1KXECR+aswn2SnjIcfvqi
         23tg==
X-Gm-Message-State: AOAM533P19BbeM1RSTApTbCZBRhHJpEUNQJIv4SPvcJS03HuZUVCREXu
        CrqaWrEkurL4ggTR1cwP4OC19fFOB/6SBiOu
X-Google-Smtp-Source: ABdhPJx7ZQtrU+VcWljrrDnZU8bM4jUcwzK304gsvVGDEH11myXnse8gaqCiSBfikc3zZNHZ/lfpLA==
X-Received: by 2002:aa7:c306:0:b0:42d:d4cc:c606 with SMTP id l6-20020aa7c306000000b0042dd4ccc606mr1947344edq.341.1654119573200;
        Wed, 01 Jun 2022 14:39:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
        by smtp.googlemail.com with ESMTPSA id a14-20020a170906368e00b006fec5cef701sm1099080ejc.197.2022.06.01.14.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:39:32 -0700 (PDT)
From:   David Virag <virag.david003@gmail.com>
Cc:     phone-devel@vger.kernel.org,
        David Virag <virag.david003@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: exynos: Add internal eMMC support to jackpotlte
Date:   Thu,  2 Jun 2022 01:37:43 +0200
Message-Id: <20220601233743.56317-6-virag.david003@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601233743.56317-1-virag.david003@gmail.com>
References: <20220601233743.56317-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the nodes relevant to provide clocks for Exynos7885 eMMC and to
support eMMC. eMMC is the internal storage used in the Samsung Galaxy A8
(2018) (jackpotlte), and all other known devices using the Exynos7885
SoC.

Signed-off-by: David Virag <virag.david003@gmail.com>
---
 .../boot/dts/exynos/exynos7885-jackpotlte.dts | 20 ++++++++++++
 arch/arm64/boot/dts/exynos/exynos7885.dtsi    | 32 +++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
index 4cf9aa25f618..5db9a81ac7bb 100644
--- a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
@@ -60,6 +60,26 @@ power-key {
 	};
 };
 
+&mmc_0 {
+	status = "okay";
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	cap-mmc-highspeed;
+	non-removable;
+	mmc-hs400-enhanced-strobe;
+	card-detect-delay = <200>;
+	clock-frequency = <800000000>;
+	bus-width = <8>;
+	samsung,dw-mshc-ciu-div = <3>;
+	samsung,dw-mshc-sdr-timing = <0 4>;
+	samsung,dw-mshc-ddr-timing = <2 4>;
+	samsung,dw-mshc-hs400-timing = <0 2>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd0_clk_fast_slew_rate_3x &sd0_cmd &sd0_rdqs
+		     &sd0_bus1 &sd0_bus4 &sd0_bus8>;
+};
+
 &oscclk {
 	clock-frequency = <26000000>;
 };
diff --git a/arch/arm64/boot/dts/exynos/exynos7885.dtsi b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
index 9c233c56558c..23c2e0bb0a2c 100644
--- a/arch/arm64/boot/dts/exynos/exynos7885.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
@@ -240,6 +240,25 @@ cmu_top: clock-controller@12060000 {
 			clock-names = "oscclk";
 		};
 
+		cmu_fsys: clock-controller@13400000 {
+			compatible = "samsung,exynos7885-cmu-fsys";
+			reg = <0x13400000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>,
+				 <&cmu_top CLK_DOUT_FSYS_BUS>,
+				 <&cmu_top CLK_DOUT_FSYS_MMC_CARD>,
+				 <&cmu_top CLK_DOUT_FSYS_MMC_EMBD>,
+				 <&cmu_top CLK_DOUT_FSYS_MMC_SDIO>,
+				 <&cmu_top CLK_DOUT_FSYS_USB30DRD>;
+			clock-names = "oscclk",
+				      "dout_fsys_bus",
+				      "dout_fsys_mmc_card",
+				      "dout_fsys_mmc_embd",
+				      "dout_fsys_mmc_sdio",
+				      "dout_fsys_usb30drd";
+		};
+
 		pinctrl_alive: pinctrl@11cb0000 {
 			compatible = "samsung,exynos7885-pinctrl";
 			reg = <0x11cb0000 0x1000>;
@@ -274,6 +293,19 @@ pmu_system_controller: system-controller@11c80000 {
 			reg = <0x11c80000 0x10000>;
 		};
 
+		mmc_0: mmc@13500000 {
+			compatible = "samsung,exynos7-dw-mshc-smu";
+			reg = <0x13500000 0x2000>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cmu_fsys CLK_GOUT_MMC_EMBD_ACLK>,
+				 <&cmu_fsys CLK_GOUT_MMC_EMBD_SDCLKIN>;
+			clock-names = "biu", "ciu";
+			fifo-depth = <0x40>;
+			status = "disabled";
+		};
+
 		serial_0: serial@13800000 {
 			compatible = "samsung,exynos5433-uart";
 			reg = <0x13800000 0x100>;
-- 
2.36.1

