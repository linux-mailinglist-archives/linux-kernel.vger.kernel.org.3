Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1379B569262
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 21:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiGFTIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 15:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiGFTIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 15:08:50 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF3221839;
        Wed,  6 Jul 2022 12:08:49 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 266J8fAW022362;
        Wed, 6 Jul 2022 14:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657134521;
        bh=WIzKw+aiDnah+6g7Qkj9tB3V5hr3AN7/V/fJCf0qS2Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EuZwJoKJKI2W8LZYWV1Xm+eoYsGE36u9jDoV3Hopv+bW0l7S1L5eBI4vEV2uX4WOc
         /15qBfA/6+Oa1pWjQlSd0N8FSwlo1fy6gADSDSAFd2U6QYf8su1DSkrgvmtzrICBnv
         BDgX8aaA6UdFO4jyK2wzM1R7JAfTv/NtI5ndVM6w=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 266J8fJI114670
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Jul 2022 14:08:41 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 6
 Jul 2022 14:08:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 6 Jul 2022 14:08:40 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 266J8c70010468;
        Wed, 6 Jul 2022 14:08:40 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH v2 4/4] arm64: dts: ti: k3-j7200-mcu-wakeup: Add SA2UL node
Date:   Wed, 6 Jul 2022 14:08:38 -0500
Message-ID: <20220706190838.26074-4-afd@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220706190838.26074-1-afd@ti.com>
References: <20220706190838.26074-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J7200 has an instance of SA2UL in the MCU domain.
Add DT node for the same.

The device is marked TI_SCI_PD_SHARED as parts of this IP are also
shared with the security co-processor and OP-TEE.

The RNG node is added but marked disabled as it is firewalled off for
exclusive use by OP-TEE. Any access to this device from Linux will
result in firewall errors. We add the node for completeness of the
hardware description.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes from v1:
 - Added comment in dtsi file
 - Added extra context to commit message

 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 1044ec6c4b0d4..a37280200c401 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -375,4 +375,24 @@ mcu_r5fss0_core1: r5f@41400000 {
 			ti,loczrama = <1>;
 		};
 	};
+
+	mcu_crypto: crypto@40900000 {
+		compatible = "ti,j721e-sa2ul";
+		reg = <0x00 0x40900000 0x00 0x1200>;
+		power-domains = <&k3_pds 265 TI_SCI_PD_SHARED>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
+		dmas = <&mcu_udmap 0xf501>, <&mcu_udmap 0x7502>,
+		       <&mcu_udmap 0x7503>;
+		dma-names = "tx", "rx1", "rx2";
+		dma-coherent;
+
+		rng: rng@40910000 {
+			compatible = "inside-secure,safexcel-eip76";
+			reg = <0x00 0x40910000 0x00 0x7d>;
+			interrupts = <GIC_SPI 945 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled"; /* Used by OP-TEE */
+		};
+	};
 };
-- 
2.36.1

