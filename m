Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B1E5A9923
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiIANiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbiIANhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:37:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC232A711;
        Thu,  1 Sep 2022 06:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662039315; x=1693575315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rZMihXhOLlKxYs0tCwQAUj7e9S0faqqljRoP4WeBM6o=;
  b=PVNMjdYFLLN+uzYPkizEFXD2YjRg5t3IoZhZIwxYtSC+d2U0K0NOJkBW
   2XaCLYO9Qksqo80GIANSUEElKHRCh2Q8eopX4SkSRTrw1i9jLiDewabrd
   j+GzeiXEHNBpPAhK+o6a2I/SEvAVRsqrjXzyZtzP+HlPxjhYSonf/efZi
   5pPPIKkCdAP9wZWeRT1O4O7IoE/6SWJW3s1Q92J33/cELg8IX2O9u988N
   s4uh2T1bYb9RTzX+tZ+LAKqpQthk6WXNpByttexn2qoLBH7tUTzQdHczT
   HgQ2NNoVEyfDmkL0fQIAj8PLWfNAqKT5Pk/yt+LevwBQw5+sSomOylpEe
   w==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="178641861"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 06:35:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 06:35:07 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 1 Sep 2022 06:35:04 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        Hugh Breslin <hugh.breslin@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 7/9] riscv: dts: microchip: icicle: re-jig fabric peripheral addresses
Date:   Thu, 1 Sep 2022 14:34:02 +0100
Message-ID: <20220901133403.3392291-8-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901133403.3392291-1-conor.dooley@microchip.com>
References: <20220901133403.3392291-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When users try to add onto the reference design, they find that the
current addresses that peripherals connected to Fabric InterConnect
(FIC) 3 use are restrictive. For the v2022.09 reference design, the
peripherals have been shifted down, leaving more contiguous address
space for their custom IP/peripherals.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
index 32d51c4a5b0c..98f04be0dc6b 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
@@ -6,18 +6,18 @@ / {
 	compatible = "microchip,mpfs-icicle-reference-rtlv2209", "microchip,mpfs-icicle-kit",
 		     "microchip,mpfs";
 
-	core_pwm0: pwm@41000000 {
+	core_pwm0: pwm@40000000 {
 		compatible = "microchip,corepwm-rtl-v4";
-		reg = <0x0 0x41000000 0x0 0xF0>;
+		reg = <0x0 0x40000000 0x0 0xF0>;
 		microchip,sync-update-mask = /bits/ 32 <0>;
 		#pwm-cells = <2>;
 		clocks = <&fabric_clk3>;
 		status = "disabled";
 	};
 
-	i2c2: i2c@44000000 {
+	i2c2: i2c@40000200 {
 		compatible = "microchip,corei2c-rtl-v7";
-		reg = <0x0 0x44000000 0x0 0x1000>;
+		reg = <0x0 0x40000200 0x0 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&fabric_clk3>;
-- 
2.36.1

