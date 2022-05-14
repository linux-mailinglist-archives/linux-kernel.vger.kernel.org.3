Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD69D527458
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiENVyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiENVyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:54:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7882D2D1C2
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:37 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x52so10712042pfu.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2DejTEs/G7g9L2HVWAQLqleNJVMCZ79v0p5bSTaL+I=;
        b=bEFJRheZ5CtaK8DaE9zGXXSJQ/B7kTpXgaQEdz3gcqwXAQX6MlqAjOAVlzUQlchnTA
         lb9GLi3Kz8PnLqraIkH/wW8fhTiLX8IMCCA4nMnA+01uGMaLxLGQiFf6WBMBvC+k1DFQ
         w5gM5s3Ojhg37ouCckXlHgp6++k0m5zekizu+ixECdk+aZ99JOtn0BCfNuWe1rDuY2MP
         8LBRxjN4oRxJOyfvdSjR2MyCIKP7T4GeG04rKKpkz1v3FjDpBJf7tdxGKYI+nD5/0gfL
         Y8Jqli7eZ9uJy+LTqxzrR66vzbzpOIpKD/XEwa+oEDbOAJMzPGw6YWWpiuKIiaVWVxmR
         K0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2DejTEs/G7g9L2HVWAQLqleNJVMCZ79v0p5bSTaL+I=;
        b=1ZxOnkWXhvgXghvN9y5kyojYh0oFQOpDAVaMWIvVeJB4CJjVqhLMfIHPeFXKLbeGuF
         rjhESVi5PszG2CxrvETx7J38DH2nokpt0L+9+dkXelN7Cbjpgza2xB5Qlu8osPjNmkWZ
         nL/oOEKEs+N+YRR2K+7mWxtXnI3nifwDAvLUTVPzA4KcQYhvmneNqemwnGZqc+PIx5OJ
         Zt0J9q6+PR4bw1u4Hs3TEDU2lySQMEofiHW/105m5VVXTch+R7OYNL2G0g5dKZz96E5s
         vbFt7SWQGhqTTO3DM+YYWhK54UMnKFQLi5QsSb50GQpnEaxUodWc8NoivrCfC910HPHH
         ZJhg==
X-Gm-Message-State: AOAM530dn5QhIFdwlsW1fSkvFeGctLl2IMomJhzqbBWwKLEht1/YiV4h
        JOtK9aNNYu4GJZyV5y4kW4HaIQ==
X-Google-Smtp-Source: ABdhPJx+o1kUJpsunVsUYsCcgQPJ16ilKAd82HNUSU9Fc2RL1W6eMa9R7hPL/Z8oVOO+6u4Mii4lcw==
X-Received: by 2002:a65:6051:0:b0:39d:1b00:e473 with SMTP id a17-20020a656051000000b0039d1b00e473mr9186783pgp.578.1652565276712;
        Sat, 14 May 2022 14:54:36 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:931c:dd30:fa99:963:d0be])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902db0d00b0015e8d4eb2d2sm4189522plx.284.2022.05.14.14.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:54:36 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        robh@kernel.org
Subject: [PATCH v2 1/6] arm64: dts: qcom: Fix sdhci node names - use 'mmc@'
Date:   Sun, 15 May 2022 03:24:19 +0530
Message-Id: <20220514215424.1007718-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220514215424.1007718-1-bhupesh.sharma@linaro.org>
References: <20220514215424.1007718-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the Qualcomm sdhci-msm device-tree binding has been converted
to yaml format, 'make dtbs_check' reports issues with
inconsistent 'sdhci@' convention used for specifying the
sdhci nodes. The generic mmc bindings expect 'mmc@' format
instead.

Fix the same.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi   | 4 ++--
 arch/arm/boot/dts/qcom-ipq4019.dtsi   | 2 +-
 arch/arm/boot/dts/qcom-msm8226.dtsi   | 6 +++---
 arch/arm/boot/dts/qcom-msm8974.dtsi   | 6 +++---
 arch/arm/boot/dts/qcom-sdx55.dtsi     | 2 +-
 arch/arm/boot/dts/qcom-sdx65.dtsi     | 2 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi  | 4 ++--
 arch/arm64/boot/dts/qcom/sc7280.dtsi  | 4 ++--
 arch/arm64/boot/dts/qcom/sdm630.dtsi  | 4 ++--
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sm6125.dtsi  | 4 ++--
 arch/arm64/boot/dts/qcom/sm6350.dtsi  | 4 ++--
 arch/arm64/boot/dts/qcom/sm8150.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi  | 2 +-
 21 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index da50a1a0197f..ca630ca2d9cd 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -419,7 +419,7 @@ blsp2_uart2: serial@f995e000 {
 			status = "disabled";
 		};
 
-		sdhci@f9824900 {
+		mmc@f9824900 {
 			compatible = "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
@@ -432,7 +432,7 @@ sdhci@f9824900 {
 			status = "disabled";
 		};
 
-		sdhci@f98a4900 {
+		mmc@f98a4900 {
 			compatible = "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
 			reg-names = "hc_mem", "core_mem";
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index c5da723f7674..a2632349cec4 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -221,7 +221,7 @@ vqmmc: regulator@1948000 {
 			status = "disabled";
 		};
 
-		sdhci: sdhci@7824900 {
+		sdhci: mmc@7824900 {
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0x7824900 0x11c>, <0x7824000 0x800>;
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index 28eca15b5712..0b5effdb269a 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -134,7 +134,7 @@ apcs: syscon@f9011000 {
 			reg = <0xf9011000 0x1000>;
 		};
 
-		sdhc_1: sdhci@f9824900 {
+		sdhc_1: mmc@f9824900 {
 			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
@@ -150,7 +150,7 @@ sdhc_1: sdhci@f9824900 {
 			status = "disabled";
 		};
 
-		sdhc_2: sdhci@f98a4900 {
+		sdhc_2: mmc@f98a4900 {
 			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
 			reg-names = "hc_mem", "core_mem";
@@ -166,7 +166,7 @@ sdhc_2: sdhci@f98a4900 {
 			status = "disabled";
 		};
 
-		sdhc_3: sdhci@f9864900 {
+		sdhc_3: mmc@f9864900 {
 			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9864900 0x11c>, <0xf9864000 0x800>;
 			reg-names = "hc_mem", "core_mem";
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 814ad0b46232..637877e5c5d8 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -436,7 +436,7 @@ acc3: clock-controller@f90b8000 {
 			reg = <0xf90b8000 0x1000>, <0xf9008000 0x1000>;
 		};
 
-		sdhc_1: sdhci@f9824900 {
+		sdhc_1: mmc@f9824900 {
 			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
@@ -453,7 +453,7 @@ sdhc_1: sdhci@f9824900 {
 			status = "disabled";
 		};
 
-		sdhc_3: sdhci@f9864900 {
+		sdhc_3: mmc@f9864900 {
 			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9864900 0x11c>, <0xf9864000 0x800>;
 			reg-names = "hc_mem", "core_mem";
@@ -472,7 +472,7 @@ sdhc_3: sdhci@f9864900 {
 			status = "disabled";
 		};
 
-		sdhc_2: sdhci@f98a4900 {
+		sdhc_2: mmc@f98a4900 {
 			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
 			reg-names = "hc_mem", "core_mem";
diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 1c2b208a5670..4c76c7758637 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -388,7 +388,7 @@ tcsr: syscon@1fcb000 {
 			reg = <0x01fc0000 0x1000>;
 		};
 
-		sdhc_1: sdhci@8804000 {
+		sdhc_1: mmc@8804000 {
 			compatible = "qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x08804000 0x1000>;
 			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index df6f9d6288fe..5b8e8620a1e1 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -143,7 +143,7 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
-		sdhc_1: sdhci@8804000 {
+		sdhc_1: mmc@8804000 {
 			compatible = "qcom,sdx65-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x08804000 0x1000>;
 			reg-names = "hc_mem";
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 4c38b15c6fd4..9dff30c8fc85 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -375,7 +375,7 @@ spmi_bus: spmi@200f000 {
 			cell-index = <0>;
 		};
 
-		sdhc_1: sdhci@7824900 {
+		sdhc_1: mmc@7824900 {
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0x7824900 0x500>, <0x7824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 05472510e29d..aadefb38a7cf 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1464,7 +1464,7 @@ lpass_codec: audio-codec@771c000 {
 			#sound-dai-cells = <1>;
 		};
 
-		sdhc_1: sdhci@7824000 {
+		sdhc_1: mmc@7824000 {
 			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07824900 0x11c>, <0x07824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
@@ -1482,7 +1482,7 @@ sdhc_1: sdhci@7824000 {
 			status = "disabled";
 		};
 
-		sdhc_2: sdhci@7864000 {
+		sdhc_2: mmc@7864000 {
 			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07864900 0x11c>, <0x07864000 0x800>;
 			reg-names = "hc_mem", "core_mem";
diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index ffc3ec2cd3bc..1bc0ef476cdb 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -795,7 +795,7 @@ usb3_dwc3: usb@7000000 {
 			};
 		};
 
-		sdhc_1: sdhci@7824900 {
+		sdhc_1: mmc@7824900 {
 			compatible = "qcom,msm8953-sdhci", "qcom,sdhci-msm-v4";
 
 			reg = <0x7824900 0x500>, <0x7824000 0x800>;
@@ -855,7 +855,7 @@ opp-384000000 {
 			};
 		};
 
-		sdhc_2: sdhci@7864900 {
+		sdhc_2: mmc@7864900 {
 			compatible = "qcom,msm8953-sdhci", "qcom,sdhci-msm-v4";
 
 			reg = <0x7864900 0x500>, <0x7864000 0x800>;
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 0318d42c5736..99230e8d643f 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -461,7 +461,7 @@ usb@f9200000 {
 			};
 		};
 
-		sdhc1: sdhci@f9824900 {
+		sdhc1: mmc@f9824900 {
 			compatible = "qcom,msm8994-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x1a0>, <0xf9824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
@@ -484,7 +484,7 @@ sdhc1: sdhci@f9824900 {
 			status = "disabled";
 		};
 
-		sdhc2: sdhci@f98a4900 {
+		sdhc2: mmc@f98a4900 {
 			compatible = "qcom,msm8994-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
 			reg-names = "hc_mem", "core_mem";
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 9932186f7ceb..e6fa71f14240 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2804,7 +2804,7 @@ hsusb_phy2: phy@7412000 {
 			status = "disabled";
 		};
 
-		sdhc1: sdhci@7464900 {
+		sdhc1: mmc@7464900 {
 			compatible = "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07464900 0x11c>, <0x07464000 0x800>;
 			reg-names = "hc_mem", "core_mem";
@@ -2827,7 +2827,7 @@ sdhc1: sdhci@7464900 {
 			status = "disabled";
 		};
 
-		sdhc2: sdhci@74a4900 {
+		sdhc2: mmc@74a4900 {
 			compatible = "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x074a4900 0x314>, <0x074a4000 0x800>;
 			reg-names = "hc_mem", "core_mem";
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 758c45bbbe78..a49a13441661 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2102,7 +2102,7 @@ qusb2phy: phy@c012000 {
 			nvmem-cells = <&qusb2_hstx_trim>;
 		};
 
-		sdhc2: sdhci@c0a4900 {
+		sdhc2: mmc@c0a4900 {
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0x0c0a4900 0x314>, <0x0c0a4000 0x800>;
 			reg-names = "hc_mem", "core_mem";
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index d912166b7552..97c4e6c6f6c8 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -789,7 +789,7 @@ pcie_phy: phy@7786000 {
 			status = "disabled";
 		};
 
-		sdcc1: sdcc@7804000 {
+		sdcc1: mmc@7804000 {
 			compatible = "qcom,qcs404-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x7805000 0x1000>;
 			reg-names = "hc", "cqhci";
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 5dcaac23a138..4a316c50484d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -693,7 +693,7 @@ gpu_speed_bin: gpu_speed_bin@1d2 {
 			};
 		};
 
-		sdhc_1: sdhci@7c4000 {
+		sdhc_1: mmc@7c4000 {
 			compatible = "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x7c4000 0 0x1000>,
 				<0 0x07c5000 0 0x1000>;
@@ -2578,7 +2578,7 @@ apss_merge_funnel_in: endpoint {
 			};
 		};
 
-		sdhc_2: sdhci@8804000 {
+		sdhc_2: mmc@8804000 {
 			compatible = "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x08804000 0 0x1000>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index e66fc67de206..f1e86effa063 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -857,7 +857,7 @@ gpu_speed_bin: gpu_speed_bin@1e9 {
 			};
 		};
 
-		sdhc_1: sdhci@7c4000 {
+		sdhc_1: mmc@7c4000 {
 			compatible = "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdc1_clk>, <&sdc1_cmd>, <&sdc1_data>, <&sdc1_rclk>;
@@ -2936,7 +2936,7 @@ apss_merge_funnel_in: endpoint {
 			};
 		};
 
-		sdhc_2: sdhci@8804000 {
+		sdhc_2: mmc@8804000 {
 			compatible = "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdc2_clk>, <&sdc2_cmd>, <&sdc2_data>;
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index b72e8e6c52f3..cadc920bcd9c 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1272,7 +1272,7 @@ qusb2phy: phy@c012000 {
 			status = "disabled";
 		};
 
-		sdhc_2: sdhci@c084000 {
+		sdhc_2: mmc@c084000 {
 			compatible = "qcom,sdm630-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x0c084000 0x1000>;
 			reg-names = "hc";
@@ -1322,7 +1322,7 @@ opp-200000000 {
 			};
 		};
 
-		sdhc_1: sdhci@c0c4000 {
+		sdhc_1: mmc@c0c4000 {
 			compatible = "qcom,sdm630-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x0c0c4000 0x1000>,
 			      <0x0c0c5000 0x1000>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0692ae0e60a4..85baec57b993 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3551,7 +3551,7 @@ apss_merge_funnel_in: endpoint {
 			};
 		};
 
-		sdhc_2: sdhci@8804000 {
+		sdhc_2: mmc@8804000 {
 			compatible = "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x08804000 0 0x1000>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 135e6e0da27a..77bff81af433 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -435,7 +435,7 @@ rpm_msg_ram: sram@45f0000 {
 			reg = <0x045f0000 0x7000>;
 		};
 
-		sdhc_1: sdhci@4744000 {
+		sdhc_1: mmc@4744000 {
 			compatible = "qcom,sm6125-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x04744000 0x1000>, <0x04745000 0x1000>;
 			reg-names = "hc", "core";
@@ -456,7 +456,7 @@ sdhc_1: sdhci@4744000 {
 			status = "disabled";
 		};
 
-		sdhc_2: sdhci@4784000 {
+		sdhc_2: mmc@4784000 {
 			compatible = "qcom,sm6125-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x04784000 0x1000>;
 			reg-names = "hc";
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index d4f8f33f3f0c..13c7ae2e379e 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -472,7 +472,7 @@ rng: rng@793000 {
 			clock-names = "core";
 		};
 
-		sdhc_1: sdhci@7c4000 {
+		sdhc_1: mmc@7c4000 {
 			compatible = "qcom,sm6350-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x007c4000 0 0x1000>,
 				<0 0x007c5000 0 0x1000>,
@@ -921,7 +921,7 @@ compute-cb@8 {
 			};
 		};
 
-		sdhc_2: sdhci@8804000 {
+		sdhc_2: mmc@8804000 {
 			compatible = "qcom,sm6350-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x08804000 0 0x1000>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 8ea44c4b56b4..a2a1c77c0428 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3543,7 +3543,7 @@ usb_2_ssphy: phy@88eb200 {
 			};
 		};
 
-		sdhc_2: sdhci@8804000 {
+		sdhc_2: mmc@8804000 {
 			compatible = "qcom,sm8150-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x08804000 0 0x1000>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index cf0c97bd5ad3..6c06e3b2ad2d 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2917,7 +2917,7 @@ usb_2_ssphy: phy@88eb200 {
 			};
 		};
 
-		sdhc_2: sdhci@8804000 {
+		sdhc_2: mmc@8804000 {
 			compatible = "qcom,sm8250-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x08804000 0 0x1000>;
 
-- 
2.35.3

