Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844294CD8EF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240769AbiCDQQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240711AbiCDQQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:16:23 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39951B8CB2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:15:34 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t11so13429701wrm.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 08:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJskNak95cvJcdUCyQawVbbPcPNz7aQv6i/qtIFC/D0=;
        b=1py/SiRHzXJFbv03+N9Hala6db1fZOCrZVfBakEeZ1XEqEzCNZ68ScYMDGX6fAyeUO
         hYeZgwCDOPK/5etYhM6FF8r9BmtRRtkdHxuM6ptY/4J01I0SZKaL44Od/4tjZVDGnMFj
         REa9Xex5sJEPK0jvhX7ZjrY0JsNUccCEe6WyqWZTYC4U8q+ZiWsj7fVnoA+9zkoj3gjl
         SEMRy8iuTI7qojEl+wDMmPnofqFSIxB2Q7JMb0bwuUUCK+MZfBo5s9I1XyZ5sUVm1++L
         XBxUYl0Pkvq9A2mdS3WgiOtdryfXlaz1zQdLnumxQLuwBiYtfBB8mrsBzW07IQ3I+Cpc
         np3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJskNak95cvJcdUCyQawVbbPcPNz7aQv6i/qtIFC/D0=;
        b=g0GECLVoSl75bWlTLb8H2rlL5H2jU4UsC+3lShOVYBDixEaMjFEtf4RGBKdfCGHIR2
         985bAvx4GzMztcT8wN0LCjaS7LsDDsMCqXN5SjziNSKi5xxkaWJ9lizQ48+dAE5GYKXE
         P+2Y4jRplofUlHt3ACKYu/cop6jMuVv406dyI2p1JDDidf42nEYvze00DFClK6xWMqyx
         sEqZq53/BYJfhr8dJLy8XzIQasMJlmfVJDZt+K0D175gsAh4iauUg+Obd4IzO1O2qV88
         SiFzZvzyklF0h7BQgp53UsR+UxbRIc5KsvaWaK/0k512BF4L+Iolx1em+hjhJAxXSfo2
         /0Eg==
X-Gm-Message-State: AOAM533lwcL+2klPkK6fHL6Nnvsrz3b3H1jUrCTPt59G3eL3FHI64wfm
        MISZ7BScbiX0owlgTTQjoCbjJA==
X-Google-Smtp-Source: ABdhPJwbTnyZIIz3MhW8i2qeaIJqAT8wW1Pa+ypKCSwBrOZfy77WETAvGz5t2zqL46vAdLT4K0tDtw==
X-Received: by 2002:adf:f389:0:b0:1ef:5f0f:cb83 with SMTP id m9-20020adff389000000b001ef5f0fcb83mr26228592wro.26.1646410533312;
        Fri, 04 Mar 2022 08:15:33 -0800 (PST)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm4937307wrv.79.2022.03.04.08.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 08:15:32 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.or
Cc:     matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stephane.leprovost@mediatek.com, khilman@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v4 7/7] ARM64: mt8183: Add support of APU to mt8183
Date:   Fri,  4 Mar 2022 17:15:14 +0100
Message-Id: <20220304161514.994128-8-abailon@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220304161514.994128-1-abailon@baylibre.com>
References: <20220304161514.994128-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the support of APU to mt8183.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 .../boot/dts/mediatek/mt8183-pumpkin.dts      | 50 +++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 40 +++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index ee912825cfc6..155c89c998d3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -37,6 +37,42 @@ scp_mem_reserved: scp_mem_region@50000000 {
 			reg = <0 0x50000000 0 0x2900000>;
 			no-map;
 		};
+
+		vdev0buffer: vdev0buffer@52900000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x52900000 0 0x4000>;
+			no-map;
+		};
+
+		vdev0vring0: vdev0vring0@52904000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x52904000 0 0x2000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@52906000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x52906000 0 0x2000>;
+			no-map;
+		};
+
+		vdev1buffer: vdev1buffer@52908000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x52908000 0 0x4000>;
+			no-map;
+		};
+
+		vdev1vring0: vdev1vring0@5290C000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x5290C000 0 0x2000>;
+			no-map;
+		};
+
+		vdev1vring1: vdev1vring1@5290E000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x5290E000 0 0x2000>;
+			no-map;
+		};
 	};
 
 	leds {
@@ -381,3 +417,17 @@ &scp {
 &dsi0 {
 	status = "disabled";
 };
+
+&apu0 {
+	memory-region = <&vdev0buffer>, <&vdev0vring0>, <&vdev0vring1>;
+	memory-region-names = "vdev0buffer", "vdev0vring0", "vdev0vring1";
+	memory-region-da = <0x6fff8000>, <0x6fffc000>, <0x6fffe000>;
+	status = "okay";
+};
+
+&apu1 {
+	memory-region = <&vdev1buffer>, <&vdev1vring0>, <&vdev1vring1>;
+	memory-region-names = "vdev1buffer", "vdev1vring0", "vdev1vring1";
+	memory-region-da = <0x6fff0000>, <0x6fff4000>, <0x6fff6000>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index ba4584faca5a..cb02f57e000d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1542,12 +1542,52 @@ ipu_adl: syscon@19010000 {
 			#clock-cells = <1>;
 		};
 
+		apu0: apu@0x19100000 {
+			compatible = "mediatek,mt8183-apu";
+			reg = <0 0x19180000 0 0x14000>;
+			interrupts = <GIC_SPI 292 IRQ_TYPE_LEVEL_LOW>;
+
+			iommus = <&iommu M4U_PORT_IMG_IPUO>,
+				 <&iommu M4U_PORT_IMG_IPU3O>,
+				 <&iommu M4U_PORT_IMG_IPUI>;
+
+			clocks = <&ipu_core0 CLK_IPU_CORE0_AXI>,
+				 <&ipu_core0 CLK_IPU_CORE0_IPU>,
+				 <&ipu_core0 CLK_IPU_CORE0_JTAG>;
+
+			clock-names = "axi", "ipu", "jtag";
+
+			power-domains = <&spm MT8183_POWER_DOMAIN_VPU_CORE0>;
+
+			status = "disabled";
+		};
+
 		ipu_core0: syscon@19180000 {
 			compatible = "mediatek,mt8183-ipu_core0", "syscon";
 			reg = <0 0x19180000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		apu1: apu@19200000 {
+			compatible = "mediatek,mt8183-apu";
+			reg = <0 0x19280000 0 0x14000>;
+			interrupts = <GIC_SPI 293 IRQ_TYPE_LEVEL_LOW>;
+
+			iommus = <&iommu M4U_PORT_CAM_IPUO>,
+				 <&iommu M4U_PORT_CAM_IPU2O>,
+				 <&iommu M4U_PORT_CAM_IPU3O>;
+
+			clocks = <&ipu_core0 CLK_IPU_CORE1_AXI>,
+				 <&ipu_core0 CLK_IPU_CORE1_IPU>,
+				 <&ipu_core0 CLK_IPU_CORE1_JTAG>;
+
+			clock-names = "axi", "ipu", "jtag";
+
+			power-domains = <&spm MT8183_POWER_DOMAIN_VPU_CORE1>;
+
+			status = "disabled";
+		};
+
 		ipu_core1: syscon@19280000 {
 			compatible = "mediatek,mt8183-ipu_core1", "syscon";
 			reg = <0 0x19280000 0 0x1000>;
-- 
2.34.1

