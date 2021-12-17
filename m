Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B38847888C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhLQKNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbhLQKM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:12:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83252C061401;
        Fri, 17 Dec 2021 02:12:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DC9DB82784;
        Fri, 17 Dec 2021 10:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70951C36AEF;
        Fri, 17 Dec 2021 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639735975;
        bh=C2307qGVcQra+sGbtc3mGL9UeC8p+us/HaJ7iZdqqUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iU0vsHlcveq4k1QDFDa/ZL/M4qrzUiwKW5X52LSxv9OJOLknQY9Ifk+LKoz0WTnyL
         UZkdUQm9QACj1fkXOxEDC46jEkffKliVDubYjCuNWw7uDzizCmdy5veP9cX648m7YE
         tpa3FXOViM9ukKDm5ceQtvaf+g+mnnhCyxW/arcIitx193TBQ+YR6QbsaXCqAfegxR
         jgW4dnN013yOAihMjPsE+olmmUKoP7Ghg4IFQ2xaZOPG9ZyncGfsFGIXQUTsttfQq8
         YGfythb2oylQWeQkpNzPJ7Qc367pEFCkmnWG/0CL+DwUjpJpOwyU7MoGedstdyuinb
         xT9vnlFGzXIGA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1myAEP-000g6O-Br; Fri, 17 Dec 2021 11:12:53 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 5/7] arm64: dts: HiSilicon: Add support for HiKey 970 PCIe controller hardware
Date:   Fri, 17 Dec 2021 11:12:49 +0100
Message-Id: <20c72e7a82a4fe6080136fbee5c73d9c9d477b7d.1639735742.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639735742.git.mchehab@kernel.org>
References: <cover.1639735742.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Add DTS bindings for the HiKey 970 board's PCIe hardware.

Co-developed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v2 0/7] at: https://lore.kernel.org/all/cover.1639735742.git.mchehab@kernel.org/

 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 107 ++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 782e1487666d..b47654b50139 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -177,6 +177,12 @@ sctrl: sctrl@fff0a000 {
 			#clock-cells = <1>;
 		};
 
+		pmctrl: pmctrl@fff31000 {
+			compatible = "hisilicon,hi3670-pmctrl", "syscon";
+			reg = <0x0 0xfff31000 0x0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		iomcu: iomcu@ffd7e000 {
 			compatible = "hisilicon,hi3670-iomcu", "syscon";
 			reg = <0x0 0xffd7e000 0x0 0x1000>;
@@ -660,6 +666,107 @@ gpio28: gpio@fff1d000 {
 			clock-names = "apb_pclk";
 		};
 
+		pcie_phy: pcie-phy@fc000000 {
+			compatible = "hisilicon,hi970-pcie-phy";
+			reg = <0x0 0xfc000000 0x0 0x80000>;
+
+			phy-supply = <&ldo33>;
+
+			clocks = <&crg_ctrl HI3670_CLK_GATE_PCIEPHY_REF>,
+				 <&crg_ctrl HI3670_CLK_GATE_PCIEAUX>,
+				 <&crg_ctrl HI3670_PCLK_GATE_PCIE_PHY>,
+				 <&crg_ctrl HI3670_PCLK_GATE_PCIE_SYS>,
+				 <&crg_ctrl HI3670_ACLK_GATE_PCIE>;
+			clock-names = "phy_ref", "aux",
+				      "apb_phy", "apb_sys",
+				      "aclk";
+
+			/* vboost iboost pre post main */
+			hisilicon,eye-diagram-param = <0xffffffff 0xffffffff
+						       0xffffffff 0xffffffff
+						       0xffffffff>;
+
+			#phy-cells = <0>;
+		};
+
+		pcie@f4000000 {
+			compatible = "hisilicon,kirin970-pcie";
+			reg = <0x0 0xf4000000 0x0 0x1000000>,
+			      <0x0 0xfc180000 0x0 0x1000>,
+			      <0x0 0xf5000000 0x0 0x2000>;
+			reg-names = "dbi", "apb", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			phys = <&pcie_phy>;
+			ranges = <0x02000000 0x0 0x00000000
+				  0x0 0xf6000000
+				  0x0 0x02000000>;
+			num-lanes = <1>;
+			#interrupt-cells = <1>;
+			interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0x0 0 0 1
+					 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0 0 0 2
+					 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0 0 0 3
+					 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0 0 0 4
+					 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
+			reset-gpios = <&gpio7 0 0>;
+			hisilicon,clken-gpios = <&gpio27 3 0>, <&gpio17 0 0>,
+						<&gpio20 6 0>;
+			pcie@0,0 { // Lane 0: PCIe switch: Bus 1, Device 0
+				reg = <0 0 0 0 0>;
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+
+				pcie@0,0 { // Lane 0: upstream
+					reg = <0 0 0 0 0>;
+					compatible = "pciclass,0604";
+					device_type = "pci";
+					#address-cells = <3>;
+					#size-cells = <2>;
+					ranges;
+
+					pcie@1,0 { // Lane 4: M.2
+						reg = <0x0800 0 0 0 0>;
+						compatible = "pciclass,0604";
+						device_type = "pci";
+						reset-gpios = <&gpio3 1 0>;
+						#address-cells = <3>;
+						#size-cells = <2>;
+						ranges;
+					};
+
+					pcie@5,0 { // Lane 5: Mini PCIe
+						reg = <0x2800 0 0 0 0>;
+						compatible = "pciclass,0604";
+						device_type = "pci";
+						reset-gpios = <&gpio27 4 0 >;
+						#address-cells = <3>;
+						#size-cells = <2>;
+						ranges;
+					};
+
+					pcie@7,0 { // Lane 6: Ethernet
+						reg = <0x3800 0 0 0 0>;
+						compatible = "pciclass,0604";
+						device_type = "pci";
+						reset-gpios = <&gpio25 2 0 >;
+						#address-cells = <3>;
+						#size-cells = <2>;
+						ranges;
+					};
+				};
+			};
+		};
+
 		/* UFS */
 		ufs: ufs@ff3c0000 {
 			compatible = "hisilicon,hi3670-ufs", "jedec,ufs-2.1";
-- 
2.33.1

