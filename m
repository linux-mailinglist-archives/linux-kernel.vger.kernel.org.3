Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B8C482AFA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 12:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiABLyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 06:54:22 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39994
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233027AbiABLyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 06:54:12 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DD6BC3FFDF
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 11:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641124450;
        bh=KIxBSAYY9IqHDkOmzn3EFzKfJVtsFPivkGmJz7iSA7I=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=npMF+Mzo6U9au5VQcKOQvLytCOcewJvHvmRzuaZ/tm1rsi7eTIo5bLTQ3pkNSroF8
         1vS1IBcw92FoJ0ibewyllq2O8flgk2aeCEXvKvTabJ1WTwKVcjACbJ3KZZc0iRRArD
         lHCNPeC0FNtew+4SuRGUuarPyq1VGPZdZKP6XHXah1hiN8+NdApIwXdOfsHGfixSjH
         dIfwB1rBvvXmmIj/ixWLKGgLuOeu82dCVff3UWMZVIEvU9rbr8IkIqZ5yWshG4TN85
         p5GJhx4JqzwnGJMOHuYqdiM7K7KNQegrZq1+CUIzhf0DvGoy2b0UhQJt8FXzly+lqI
         9AUlYTPpfq9mQ==
Received: by mail-lf1-f70.google.com with SMTP id b19-20020ac24113000000b004297f324073so3350884lfi.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 03:54:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KIxBSAYY9IqHDkOmzn3EFzKfJVtsFPivkGmJz7iSA7I=;
        b=jHATVxrltczSR33KR753LyTH/DptsjHFx0hxpk/Cb+nCTWlbCmQs/ypIZKV3qMLTUW
         Gll7HMgdqHx3YZYKX3MKdwLb11OdkbLk/EIYH4pIAYmJ028XFAhQKl5LzG8ZD9luH7YL
         vot/xG+d9vxVzl/RNigSGnDCWV+/wPMt0LJgmaJsShwz7HbSFKT8/M3QWhqVLSnr30gA
         FsfNl9yrjgaOi6to+ysZ0+BQb0SkqW7SL4XnNhnQIpFmJKJr1Jt5yeaFuptOC6V0W+AF
         8YETM9G5fcZA3kEhmhIcCDtBk0Ob0XQV5EyB5qXyOZatKn42XYU0WxJS2jPPxg/xnGrj
         XHmA==
X-Gm-Message-State: AOAM533ZX7Xv7tXUdCIoD8dEsPEday/I3Edkkgb9hCrj7IMmwfD0yN/a
        YTj/78ECxEM8szhioQ3bdGg4myqROT2uREfxwY8SY6dohZRzDLTwi2SSlavH4M/zjVinS1wmCTw
        ZuMBz8WZTtI1Rnhbtatu7KaWEgtWnzA2md5D8Y/H1eg==
X-Received: by 2002:ac2:5fcd:: with SMTP id q13mr36839878lfg.621.1641124449334;
        Sun, 02 Jan 2022 03:54:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpFCU5rwJi7xsFey45le1mAfkA3wRrJGD2HDoKzfwvWT66Jbcr71hp0La6/clqGGilJxcwLg==
X-Received: by 2002:ac2:5fcd:: with SMTP id q13mr36839853lfg.621.1641124449020;
        Sun, 02 Jan 2022 03:54:09 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id l2sm2368014lja.51.2022.01.02.03.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 03:54:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] dt-bindings: clock: samsung: convert Exynos5260 to dtschema
Date:   Sun,  2 Jan 2022 12:53:54 +0100
Message-Id: <20220102115356.75796-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
References: <20220102115356.75796-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung Exynos5260 SoC clock controller bindings to DT schema
format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/clock/exynos5260-clock.txt       | 190 ---------
 .../clock/samsung,exynos5260-clock.yaml       | 382 ++++++++++++++++++
 2 files changed, 382 insertions(+), 190 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos5260-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos5260-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/exynos5260-clock.txt b/Documentation/devicetree/bindings/clock/exynos5260-clock.txt
deleted file mode 100644
index c79d31f7f66e..000000000000
--- a/Documentation/devicetree/bindings/clock/exynos5260-clock.txt
+++ /dev/null
@@ -1,190 +0,0 @@
-* Samsung Exynos5260 Clock Controller
-
-Exynos5260 has 13 clock controllers which are instantiated
-independently from the device-tree. These clock controllers
-generate and supply clocks to various hardware blocks within
-the SoC.
-
-Each clock is assigned an identifier and client nodes can use
-this identifier to specify the clock which they consume. All
-available clocks are defined as preprocessor macros in
-dt-bindings/clock/exynos5260-clk.h header and can be used in
-device tree sources.
-
-External clocks:
-
-There are several clocks that are generated outside the SoC. It
-is expected that they are defined using standard clock bindings
-with following clock-output-names:
-
- - "fin_pll" - PLL input clock from XXTI
- - "xrtcxti" - input clock from XRTCXTI
- - "ioclk_pcm_extclk" - pcm external operation clock
- - "ioclk_spdif_extclk" - spdif external operation clock
- - "ioclk_i2s_cdclk" - i2s0 codec clock
-
-Phy clocks:
-
-There are several clocks which are generated by specific PHYs.
-These clocks are fed into the clock controller and then routed to
-the hardware blocks. These clocks are defined as fixed clocks in the
-driver with following names:
-
- - "phyclk_dptx_phy_ch3_txd_clk" - dp phy clock for channel 3
- - "phyclk_dptx_phy_ch2_txd_clk" - dp phy clock for channel 2
- - "phyclk_dptx_phy_ch1_txd_clk" - dp phy clock for channel 1
- - "phyclk_dptx_phy_ch0_txd_clk" - dp phy clock for channel 0
- - "phyclk_hdmi_phy_tmds_clko" - hdmi phy tmds clock
- - "phyclk_hdmi_phy_pixel_clko" - hdmi phy pixel clock
- - "phyclk_hdmi_link_o_tmds_clkhi" - hdmi phy for hdmi link
- - "phyclk_dptx_phy_o_ref_clk_24m" - dp phy reference clock
- - "phyclk_dptx_phy_clk_div2"
- - "phyclk_mipi_dphy_4l_m_rxclkesc0"
- - "phyclk_usbhost20_phy_phyclock" - usb 2.0 phy clock
- - "phyclk_usbhost20_phy_freeclk"
- - "phyclk_usbhost20_phy_clk48mohci"
- - "phyclk_usbdrd30_udrd30_pipe_pclk"
- - "phyclk_usbdrd30_udrd30_phyclock" - usb 3.0 phy clock
-
-Required Properties for Clock Controller:
-
- - compatible: should be one of the following.
-	1) "samsung,exynos5260-clock-top"
-	2) "samsung,exynos5260-clock-peri"
-	3) "samsung,exynos5260-clock-egl"
-	4) "samsung,exynos5260-clock-kfc"
-	5) "samsung,exynos5260-clock-g2d"
-	6) "samsung,exynos5260-clock-mif"
-	7) "samsung,exynos5260-clock-mfc"
-	8) "samsung,exynos5260-clock-g3d"
-	9) "samsung,exynos5260-clock-fsys"
-	10) "samsung,exynos5260-clock-aud"
-	11) "samsung,exynos5260-clock-isp"
-	12) "samsung,exynos5260-clock-gscl"
-	13) "samsung,exynos5260-clock-disp"
-
- - reg: physical base address of the controller and the length of
-	memory mapped region.
-
- - #clock-cells: should be 1.
-
- - clocks: list of clock identifiers which are fed as the input to
-	the given clock controller. Please refer the next section to find
-	the input clocks for a given controller.
-
- - clock-names: list of names of clocks which are fed as the input
-	to the given clock controller.
-
-Input clocks for top clock controller:
-	- fin_pll
-	- dout_mem_pll
-	- dout_bus_pll
-	- dout_media_pll
-
-Input clocks for peri clock controller:
-	- fin_pll
-	- ioclk_pcm_extclk
-	- ioclk_i2s_cdclk
-	- ioclk_spdif_extclk
-	- phyclk_hdmi_phy_ref_cko
-	- dout_aclk_peri_66
-	- dout_sclk_peri_uart0
-	- dout_sclk_peri_uart1
-	- dout_sclk_peri_uart2
-	- dout_sclk_peri_spi0_b
-	- dout_sclk_peri_spi1_b
-	- dout_sclk_peri_spi2_b
-	- dout_aclk_peri_aud
-	- dout_sclk_peri_spi0_b
-
-Input clocks for egl clock controller:
-	- fin_pll
-	- dout_bus_pll
-
-Input clocks for kfc clock controller:
-	- fin_pll
-	- dout_media_pll
-
-Input clocks for g2d clock controller:
-	- fin_pll
-	- dout_aclk_g2d_333
-
-Input clocks for mif clock controller:
-	- fin_pll
-
-Input clocks for mfc clock controller:
-	- fin_pll
-	- dout_aclk_mfc_333
-
-Input clocks for g3d clock controller:
-	- fin_pll
-
-Input clocks for fsys clock controller:
-	- fin_pll
-	- phyclk_usbhost20_phy_phyclock
-	- phyclk_usbhost20_phy_freeclk
-	- phyclk_usbhost20_phy_clk48mohci
-	- phyclk_usbdrd30_udrd30_pipe_pclk
-	- phyclk_usbdrd30_udrd30_phyclock
-	- dout_aclk_fsys_200
-
-Input clocks for aud clock controller:
-	- fin_pll
-	- fout_aud_pll
-	- ioclk_i2s_cdclk
-	- ioclk_pcm_extclk
-
-Input clocks for isp clock controller:
-	- fin_pll
-	- dout_aclk_isp1_266
-	- dout_aclk_isp1_400
-	- mout_aclk_isp1_266
-
-Input clocks for gscl clock controller:
-	- fin_pll
-	- dout_aclk_gscl_400
-	- dout_aclk_gscl_333
-
-Input clocks for disp clock controller:
-	- fin_pll
-	- phyclk_dptx_phy_ch3_txd_clk
-	- phyclk_dptx_phy_ch2_txd_clk
-	- phyclk_dptx_phy_ch1_txd_clk
-	- phyclk_dptx_phy_ch0_txd_clk
-	- phyclk_hdmi_phy_tmds_clko
-	- phyclk_hdmi_phy_ref_clko
-	- phyclk_hdmi_phy_pixel_clko
-	- phyclk_hdmi_link_o_tmds_clkhi
-	- phyclk_mipi_dphy_4l_m_txbyte_clkhs
-	- phyclk_dptx_phy_o_ref_clk_24m
-	- phyclk_dptx_phy_clk_div2
-	- phyclk_mipi_dphy_4l_m_rxclkesc0
-	- phyclk_hdmi_phy_ref_cko
-	- ioclk_spdif_extclk
-	- dout_aclk_peri_aud
-	- dout_aclk_disp_222
-	- dout_sclk_disp_pixel
-	- dout_aclk_disp_333
-
-Example 1: An example of a clock controller node is listed below.
-
-	clock_mfc: clock-controller@11090000 {
-		compatible = "samsung,exynos5260-clock-mfc";
-		clock = <&fin_pll>, <&clock_top TOP_DOUT_ACLK_MFC_333>;
-		clock-names = "fin_pll", "dout_aclk_mfc_333";
-		reg = <0x11090000 0x10000>;
-		#clock-cells = <1>;
-	};
-
-Example 2: UART controller node that consumes the clock generated by the
-		peri clock controller. Refer to the standard clock bindings for
-		information about 'clocks' and 'clock-names' property.
-
-	serial@12c00000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0x12C00000 0x100>;
-		interrupts = <0 146 0>;
-		clocks = <&clock_peri PERI_PCLK_UART0>, <&clock_peri PERI_SCLK_UART0>;
-		clock-names = "uart", "clk_uart_baud0";
-	};
-
diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos5260-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos5260-clock.yaml
new file mode 100644
index 000000000000..a3fac5c6809d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos5260-clock.yaml
@@ -0,0 +1,382 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/samsung,exynos5260-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos5260 SoC clock controller
+
+maintainers:
+  - Chanwoo Choi <cw00.choi@samsung.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+  - Tomasz Figa <tomasz.figa@gmail.com>
+
+description: |
+  Expected external clocks, defined in DTS as fixed-rate clocks with a matching
+  name::
+    - "fin_pll" - PLL input clock from XXTI
+    - "xrtcxti" - input clock from XRTCXTI
+    - "ioclk_pcm_extclk" - pcm external operation clock
+    - "ioclk_spdif_extclk" - spdif external operation clock
+    - "ioclk_i2s_cdclk" - i2s0 codec clock
+
+  Phy clocks::
+  There are several clocks which are generated by specific PHYs.  These clocks
+  are fed into the clock controller and then routed to the hardware blocks.
+  These clocks are defined as fixed clocks in the driver with following names::
+    - "phyclk_dptx_phy_ch3_txd_clk" - dp phy clock for channel 3
+    - "phyclk_dptx_phy_ch2_txd_clk" - dp phy clock for channel 2
+    - "phyclk_dptx_phy_ch1_txd_clk" - dp phy clock for channel 1
+    - "phyclk_dptx_phy_ch0_txd_clk" - dp phy clock for channel 0
+    - "phyclk_hdmi_phy_tmds_clko" - hdmi phy tmds clock
+    - "phyclk_hdmi_phy_pixel_clko" - hdmi phy pixel clock
+    - "phyclk_hdmi_link_o_tmds_clkhi" - hdmi phy for hdmi link
+    - "phyclk_dptx_phy_o_ref_clk_24m" - dp phy reference clock
+    - "phyclk_dptx_phy_clk_div2"
+    - "phyclk_mipi_dphy_4l_m_rxclkesc0"
+    - "phyclk_usbhost20_phy_phyclock" - usb 2.0 phy clock
+    - "phyclk_usbhost20_phy_freeclk"
+    - "phyclk_usbhost20_phy_clk48mohci"
+    - "phyclk_usbdrd30_udrd30_pipe_pclk"
+    - "phyclk_usbdrd30_udrd30_phyclock" - usb 3.0 phy clock
+
+  All available clocks are defined as preprocessor macros in
+  include/dt-bindings/clock/exynos5260-clk.h header.
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos5260-clock-top
+      - samsung,exynos5260-clock-peri
+      - samsung,exynos5260-clock-egl
+      - samsung,exynos5260-clock-kfc
+      - samsung,exynos5260-clock-g2d
+      - samsung,exynos5260-clock-mif
+      - samsung,exynos5260-clock-mfc
+      - samsung,exynos5260-clock-g3d
+      - samsung,exynos5260-clock-fsys
+      - samsung,exynos5260-clock-aud
+      - samsung,exynos5260-clock-isp
+      - samsung,exynos5260-clock-gscl
+      - samsung,exynos5260-clock-disp
+
+  clocks:
+    minItems: 1
+    maxItems: 19
+
+  clock-names:
+    minItems: 1
+    maxItems: 19
+
+  "#clock-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#clock-cells"
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5260-clock-top
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_mem_pll
+            - const: dout_bus_pll
+            - const: dout_media_pll
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5260-clock-peri
+    then:
+      properties:
+        clocks:
+          minItems: 13
+          maxItems: 13
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: ioclk_pcm_extclk
+            - const: ioclk_i2s_cdclk
+            - const: ioclk_spdif_extclk
+            - const: phyclk_hdmi_phy_ref_cko
+            - const: dout_aclk_peri_66
+            - const: dout_sclk_peri_uart0
+            - const: dout_sclk_peri_uart1
+            - const: dout_sclk_peri_uart2
+            - const: dout_sclk_peri_spi0_b
+            - const: dout_sclk_peri_spi1_b
+            - const: dout_sclk_peri_spi2_b
+            - const: dout_aclk_peri_aud
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5260-clock-egl
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_bus_pll
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5260-clock-kfc
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_media_pll
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5260-clock-g2d
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_aclk_g2d_333
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5260-clock-mif
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 1
+        clock-names:
+          items:
+            - const: fin_pll
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5260-clock-mfc
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_aclk_mfc_333
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5260-clock-g3d
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 1
+        clock-names:
+          items:
+            - const: fin_pll
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5260-clock-fsys
+    then:
+      properties:
+        clocks:
+          minItems: 7
+          maxItems: 7
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: phyclk_usbhost20_phy_phyclock
+            - const: phyclk_usbhost20_phy_freeclk
+            - const: phyclk_usbhost20_phy_clk48mohci
+            - const: phyclk_usbdrd30_udrd30_pipe_pclk
+            - const: phyclk_usbdrd30_udrd30_phyclock
+            - const: dout_aclk_fsys_200
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5260-clock-aud
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: fout_aud_pll
+            - const: ioclk_i2s_cdclk
+            - const: ioclk_pcm_extclk
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5260-clock-isp
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_aclk_isp1_266
+            - const: dout_aclk_isp1_400
+            - const: mout_aclk_isp1_266
+
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5260-clock-gscl
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_aclk_gscl_400
+            - const: dout_aclk_gscl_333
+      required:
+        - clock-names
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5260-clock-disp
+    then:
+      properties:
+        clocks:
+          minItems: 19
+          maxItems: 19
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: phyclk_dptx_phy_ch3_txd_clk
+            - const: phyclk_dptx_phy_ch2_txd_clk
+            - const: phyclk_dptx_phy_ch1_txd_clk
+            - const: phyclk_dptx_phy_ch0_txd_clk
+            - const: phyclk_hdmi_phy_tmds_clko
+            - const: phyclk_hdmi_phy_ref_clko
+            - const: phyclk_hdmi_phy_pixel_clko
+            - const: phyclk_hdmi_link_o_tmds_clkhi
+            - const: phyclk_mipi_dphy_4l_m_txbyte_clkhs
+            - const: phyclk_dptx_phy_o_ref_clk_24m
+            - const: phyclk_dptx_phy_clk_div2
+            - const: phyclk_mipi_dphy_4l_m_rxclkesc0
+            - const: phyclk_hdmi_phy_ref_cko
+            - const: ioclk_spdif_extclk
+            - const: dout_aclk_peri_aud
+            - const: dout_aclk_disp_222
+            - const: dout_sclk_disp_pixel
+            - const: dout_aclk_disp_333
+      required:
+        - clock-names
+        - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5260-clk.h>
+
+    fin_pll: clock {
+        compatible = "fixed-clock";
+        clock-output-names = "fin_pll";
+        #clock-cells = <0>;
+        clock-frequency = <24000000>;
+    };
+
+    clock-controller@10010000 {
+        compatible = "samsung,exynos5260-clock-top";
+        reg = <0x10010000 0x10000>;
+        #clock-cells = <1>;
+        clocks = <&fin_pll>,
+                 <&clock_mif MIF_DOUT_MEM_PLL>,
+                 <&clock_mif MIF_DOUT_BUS_PLL>,
+                 <&clock_mif MIF_DOUT_MEDIA_PLL>;
+        clock-names = "fin_pll",
+                      "dout_mem_pll",
+                      "dout_bus_pll",
+                      "dout_media_pll";
+    };
-- 
2.32.0

