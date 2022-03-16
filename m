Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A244DB06E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356034AbiCPNLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356030AbiCPNLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:11:06 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF2151336
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:09:47 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BAADA3F798
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647436182;
        bh=6buNgqXKuTIK0OEEUZmjCOdqOJvc51crYNUQ2Eoq2ss=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=bMLTJOSmNbQO/rG/SNMR5QUKJKKPeYAs7l+jkoDses6lIPD3kTZnGOqNOiXfrpp0O
         IgETsr2ptg3u4XCmbcCbtOfuvsxhg8iQa/TZ1Wl64bUL5yr6dOokmhKWtPpDjsTFob
         ikbig8IRC144cdbRnlB4BLypJcm+6YbYB2Gjy4zeTOeCbJvYhhOAPTFD1HB4ybauCj
         2Y0cChCp0bnCWTQDeZpqWMG8XxLAKUue3Q6rpmlLmVxyHKByDE+awk1TqGDF9P00Uu
         10jZ7NkbIWqbHs7sDw85mHC/U3qAGvIGAOuM5S5vAZGjGoAg4kuAkS8PdLzhxZo8QO
         jiW2BKjivQ6NA==
Received: by mail-ej1-f71.google.com with SMTP id hr26-20020a1709073f9a00b006d6d1ee8cf8so1110933ejc.19
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6buNgqXKuTIK0OEEUZmjCOdqOJvc51crYNUQ2Eoq2ss=;
        b=U13NdlGHy2/4jSuHHvxeftyNJeBNPO4sBUJm/mqUCUihpHn+oX5lHMNKIw+MH0LsNg
         mZPjQYl8y46K+JF7ibV/tjXJvmy6NmdH/VkjLzzAVOICAo+Tmboi32Y7wBm36lYgq3zy
         8uno3MLsL27+r3GVOcXS0GjGbBR8JMk9BfN/Ta1pZqjnzfCIFRkY/AqmiWI5cXt3bouW
         OQxO6+s1mu9PM1ub+1DPcEP+wvuJ8D1dntbmYZfMdKzrY0X7a3lya2IKKihfyX0aezbH
         emF9/GIYVUPOO47Lz3twcW4kIxXetUYd8jpbl2L+NntIBaKZpTRvF8uIcyasrQOYQHZQ
         dNbg==
X-Gm-Message-State: AOAM5306hRSrPUXRYUeIociPSjt1WxggXA5n+U+aVm63Y+H8xcgT7Er0
        06eXezMx+UWu2g2od3fepOxqyT9Kw0OlF4QBvXhpnp4WQqi6delwfoZt6B0F595OaAbbsGjHkB8
        ahAtTX6Rn4WB20tKcA99GvvuihlKdZL5sVdzEg37lsg==
X-Received: by 2002:aa7:cc0a:0:b0:413:a674:7d33 with SMTP id q10-20020aa7cc0a000000b00413a6747d33mr29723855edt.369.1647436180088;
        Wed, 16 Mar 2022 06:09:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyim8NETeRi+Zvp+kpoVLjCmRXFOsByWKIpY1XFTnmnuldn3SdJfreUnBA33hXos4Aihh+D3w==
X-Received: by 2002:aa7:cc0a:0:b0:413:a674:7d33 with SMTP id q10-20020aa7cc0a000000b00413a6747d33mr29723811edt.369.1647436179759;
        Wed, 16 Mar 2022 06:09:39 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id mp33-20020a1709071b2100b006db6dea7f9dsm861597ejc.168.2022.03.16.06.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 06:09:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexander Shiyan <shc_work@mail.ru>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/2] dt-bindings: clock: drop useless consumer example
Date:   Wed, 16 Mar 2022 14:08:58 +0100
Message-Id: <20220316130858.93455-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220316130858.93455-1-krzysztof.kozlowski@canonical.com>
References: <20220316130858.93455-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consumer examples in the bindings of resource providers are trivial,
useless and duplication of code.  Remove the example code for consumer

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/clock/bitmain,bm1880-clk.yaml           | 12 ------------
 .../devicetree/bindings/clock/idt,versaclock5.yaml   |  7 -------
 .../devicetree/bindings/clock/imx1-clock.yaml        |  9 ---------
 .../devicetree/bindings/clock/imx21-clock.yaml       |  9 ---------
 .../devicetree/bindings/clock/imx23-clock.yaml       |  9 ---------
 .../devicetree/bindings/clock/imx25-clock.yaml       |  8 --------
 .../devicetree/bindings/clock/imx27-clock.yaml       |  9 ---------
 .../devicetree/bindings/clock/imx28-clock.yaml       |  9 ---------
 .../devicetree/bindings/clock/imx31-clock.yaml       |  8 --------
 .../devicetree/bindings/clock/imx35-clock.yaml       |  8 --------
 .../devicetree/bindings/clock/imx7ulp-pcc-clock.yaml | 11 -----------
 .../devicetree/bindings/clock/imx7ulp-scg-clock.yaml | 11 -----------
 .../devicetree/bindings/clock/imx8qxp-lpcg.yaml      | 11 -----------
 .../devicetree/bindings/clock/imxrt1050-clock.yaml   |  8 --------
 .../bindings/clock/nvidia,tegra124-car.yaml          |  7 -------
 .../bindings/clock/nvidia,tegra20-car.yaml           |  7 -------
 16 files changed, 143 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
index 228c9313df53..f0f9392470a6 100644
--- a/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
@@ -61,16 +61,4 @@ examples:
         #clock-cells = <1>;
     };
 
-  # Example UART controller node that consumes clock generated by the clock controller:
-  - |
-    uart0: serial@58018000 {
-         compatible = "snps,dw-apb-uart";
-         reg = <0x58018000 0x2000>;
-         clocks = <&clk 45>, <&clk 46>;
-         clock-names = "baudclk", "apb_pclk";
-         interrupts = <0 9 4>;
-         reg-shift = <2>;
-         reg-io-width = <4>;
-    };
-
 ...
diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
index ffd6ae0eed64..be66f1e8b547 100644
--- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
+++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
@@ -191,11 +191,4 @@ examples:
         };
     };
 
-    /* Consumer referencing the 5P49V5923 pin OUT1 */
-    consumer {
-        /* ... */
-        clocks = <&vc5 1>;
-        /* ... */
-    };
-
 ...
diff --git a/Documentation/devicetree/bindings/clock/imx1-clock.yaml b/Documentation/devicetree/bindings/clock/imx1-clock.yaml
index f4833a29b79e..56f524780b1a 100644
--- a/Documentation/devicetree/bindings/clock/imx1-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx1-clock.yaml
@@ -40,12 +40,3 @@ examples:
         compatible = "fsl,imx1-ccm";
         reg = <0x0021b000 0x1000>;
     };
-
-    pwm@208000 {
-        #pwm-cells = <2>;
-        compatible = "fsl,imx1-pwm";
-        reg = <0x00208000 0x1000>;
-        interrupts = <34>;
-        clocks = <&clks IMX1_CLK_DUMMY>, <&clks IMX1_CLK_PER1>;
-        clock-names = "ipg", "per";
-    };
diff --git a/Documentation/devicetree/bindings/clock/imx21-clock.yaml b/Documentation/devicetree/bindings/clock/imx21-clock.yaml
index 518ad9a4733c..e2d50544700a 100644
--- a/Documentation/devicetree/bindings/clock/imx21-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx21-clock.yaml
@@ -40,12 +40,3 @@ examples:
         reg = <0x10027000 0x800>;
         #clock-cells = <1>;
     };
-
-    serial@1000a000 {
-        compatible = "fsl,imx21-uart";
-        reg = <0x1000a000 0x1000>;
-        interrupts = <20>;
-        clocks = <&clks IMX21_CLK_UART1_IPG_GATE>,
-                 <&clks IMX21_CLK_PER1>;
-        clock-names = "ipg", "per";
-    };
diff --git a/Documentation/devicetree/bindings/clock/imx23-clock.yaml b/Documentation/devicetree/bindings/clock/imx23-clock.yaml
index 5e296a00e14f..7e890ab9c77d 100644
--- a/Documentation/devicetree/bindings/clock/imx23-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx23-clock.yaml
@@ -83,12 +83,3 @@ examples:
         reg = <0x80040000 0x2000>;
         #clock-cells = <1>;
     };
-
-    serial@8006c000 {
-        compatible = "fsl,imx23-auart";
-        reg = <0x8006c000 0x2000>;
-        interrupts = <24>;
-        clocks = <&clks 32>;
-        dmas = <&dma_apbx 6>, <&dma_apbx 7>;
-        dma-names = "rx", "tx";
-    };
diff --git a/Documentation/devicetree/bindings/clock/imx25-clock.yaml b/Documentation/devicetree/bindings/clock/imx25-clock.yaml
index 2a2b10778e72..1792e138984b 100644
--- a/Documentation/devicetree/bindings/clock/imx25-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx25-clock.yaml
@@ -176,11 +176,3 @@ examples:
         interrupts = <31>;
         #clock-cells = <1>;
     };
-
-    serial@43f90000 {
-        compatible = "fsl,imx25-uart", "fsl,imx21-uart";
-        reg = <0x43f90000 0x4000>;
-        interrupts = <45>;
-        clocks = <&clks 79>, <&clks 50>;
-        clock-names = "ipg", "per";
-    };
diff --git a/Documentation/devicetree/bindings/clock/imx27-clock.yaml b/Documentation/devicetree/bindings/clock/imx27-clock.yaml
index 160268f24487..99925aa22a4c 100644
--- a/Documentation/devicetree/bindings/clock/imx27-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx27-clock.yaml
@@ -44,12 +44,3 @@ examples:
         interrupts = <31>;
         #clock-cells = <1>;
     };
-
-    serial@1000a000 {
-        compatible = "fsl,imx27-uart", "fsl,imx21-uart";
-        reg = <0x1000a000 0x1000>;
-        interrupts = <20>;
-        clocks = <&clks IMX27_CLK_UART1_IPG_GATE>,
-                 <&clks IMX27_CLK_PER1_GATE>;
-        clock-names = "ipg", "per";
-    };
diff --git a/Documentation/devicetree/bindings/clock/imx28-clock.yaml b/Documentation/devicetree/bindings/clock/imx28-clock.yaml
index f831b780f951..a542d680b1ca 100644
--- a/Documentation/devicetree/bindings/clock/imx28-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx28-clock.yaml
@@ -106,12 +106,3 @@ examples:
         reg = <0x80040000 0x2000>;
         #clock-cells = <1>;
     };
-
-    serial@8006a000 {
-        compatible = "fsl,imx28-auart";
-        reg = <0x8006a000 0x2000>;
-        interrupts = <112>;
-        dmas = <&dma_apbx 8>, <&dma_apbx 9>;
-        dma-names = "rx", "tx";
-        clocks = <&clks 45>;
-    };
diff --git a/Documentation/devicetree/bindings/clock/imx31-clock.yaml b/Documentation/devicetree/bindings/clock/imx31-clock.yaml
index d2336261c922..168c8ada5e81 100644
--- a/Documentation/devicetree/bindings/clock/imx31-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx31-clock.yaml
@@ -110,11 +110,3 @@ examples:
         interrupts = <31>, <53>;
         #clock-cells = <1>;
     };
-
-    serial@43f90000 {
-        compatible = "fsl,imx31-uart", "fsl,imx21-uart";
-        reg = <0x43f90000 0x4000>;
-        interrupts = <45>;
-        clocks = <&clks 10>, <&clks 30>;
-        clock-names = "ipg", "per";
-    };
diff --git a/Documentation/devicetree/bindings/clock/imx35-clock.yaml b/Documentation/devicetree/bindings/clock/imx35-clock.yaml
index 3e20ccaf8131..6415bb6a8d04 100644
--- a/Documentation/devicetree/bindings/clock/imx35-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx35-clock.yaml
@@ -129,11 +129,3 @@ examples:
         interrupts = <31>;
         #clock-cells = <1>;
     };
-
-    mmc@53fb4000 {
-        compatible = "fsl,imx35-esdhc";
-        reg = <0x53fb4000 0x4000>;
-        interrupts = <7>;
-        clocks = <&clks 9>, <&clks 8>, <&clks 43>;
-        clock-names = "ipg", "ahb", "per";
-    };
diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-pcc-clock.yaml b/Documentation/devicetree/bindings/clock/imx7ulp-pcc-clock.yaml
index 7caf5cee9199..739c3378f8c8 100644
--- a/Documentation/devicetree/bindings/clock/imx7ulp-pcc-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx7ulp-pcc-clock.yaml
@@ -108,14 +108,3 @@ examples:
                        "upll", "sosc_bus_clk", "firc_bus_clk",
                        "rosc", "spll_bus_clk";
     };
-
-    mmc@40380000 {
-        compatible = "fsl,imx7ulp-usdhc";
-        reg = <0x40380000 0x10000>;
-        interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-        clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
-                 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
-                 <&pcc2 IMX7ULP_CLK_USDHC1>;
-        clock-names ="ipg", "ahb", "per";
-        bus-width = <4>;
-    };
diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-scg-clock.yaml b/Documentation/devicetree/bindings/clock/imx7ulp-scg-clock.yaml
index ee8efb4ed599..d06344d7e34f 100644
--- a/Documentation/devicetree/bindings/clock/imx7ulp-scg-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx7ulp-scg-clock.yaml
@@ -86,14 +86,3 @@ examples:
                       "firc", "upll";
         #clock-cells = <1>;
     };
-
-    mmc@40380000 {
-        compatible = "fsl,imx7ulp-usdhc";
-        reg = <0x40380000 0x10000>;
-        interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-        clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
-                 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
-                 <&pcc2 IMX7ULP_CLK_USDHC1>;
-        clock-names ="ipg", "ahb", "per";
-        bus-width = <4>;
-    };
diff --git a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
index 0f6fe365ebf3..cb80105b3c70 100644
--- a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
@@ -101,14 +101,3 @@ examples:
                              "sdhc0_lpcg_ahb_clk";
         power-domains = <&pd IMX_SC_R_SDHC_0>;
     };
-
-    mmc@5b010000 {
-        compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
-        interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
-        reg = <0x5b010000 0x10000>;
-        clocks = <&sdhc0_lpcg IMX_LPCG_CLK_4>,
-                 <&sdhc0_lpcg IMX_LPCG_CLK_5>,
-                 <&sdhc0_lpcg IMX_LPCG_CLK_0>;
-        clock-names = "ipg", "ahb", "per";
-        power-domains = <&pd IMX_SC_R_SDHC_0>;
-    };
diff --git a/Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml b/Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml
index 35fd08c143f4..03fc5c1a2939 100644
--- a/Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml
@@ -57,11 +57,3 @@ examples:
         clock-names = "osc";
         #clock-cells = <1>;
     };
-
-    lpuart1: serial@40184000 {
-        compatible = "fsl,imxrt1050-lpuart";
-        reg = <0x40184000 0x4000>;
-        interrupts = <20>;
-        clocks = <&clks IMXRT1050_CLK_LPUART1>;
-        clock-names = "ipg";
-    };
diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml
index ec7ab1483652..1b2181f6d440 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml
@@ -106,10 +106,3 @@ examples:
         #clock-cells = <1>;
         #reset-cells = <1>;
     };
-
-    usb-controller@c5004000 {
-        compatible = "nvidia,tegra20-ehci";
-        reg = <0xc5004000 0x4000>;
-        clocks = <&car TEGRA124_CLK_USB2>;
-        resets = <&car TEGRA124_CLK_USB2>;
-    };
diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
index f832abb7f11a..bee2dd4b29bf 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
@@ -97,10 +97,3 @@ examples:
             power-domains = <&domain>;
         };
     };
-
-    usb-controller@c5004000 {
-        compatible = "nvidia,tegra20-ehci";
-        reg = <0xc5004000 0x4000>;
-        clocks = <&car TEGRA20_CLK_USB2>;
-        resets = <&car TEGRA20_CLK_USB2>;
-    };
-- 
2.32.0

