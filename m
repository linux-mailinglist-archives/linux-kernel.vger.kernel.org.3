Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AB558E937
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiHJJAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiHJJAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:00:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF061AF06;
        Wed, 10 Aug 2022 02:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660122019; x=1691658019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c2PE8iAmkH1Oin6CAU5HGkAjPeE646cGNzdZY+RUVJE=;
  b=Fvs1ad2/F30RaGRq+xTBsaILfwopkHMilluA7w/4fav6NBXoVer+ry9G
   RPx5AsXT/sLkJpd4p02VUJyKF7aVT1oZHXk1AXfm1jLeuu0bFHB6N0WMj
   RjI2t8NRNnGvf4JF1Oyksp23xCpKUPR4bMEglCaWMuisW846kWfPOhlyX
   SsXm8CjSFzKZ7V2uyf0y+S8NdFVGAbptQxdTBwc5kaB0G6FpWNis0dAKW
   66OB1jul6hIbeNF/W3KN1CBKLXzARmh1YKPtMUcaDSboZ23JdBdT0KAYL
   ZGV2k1ZkgS3R1siSZFOXcPBWA4NkbrUAqF0b4vNusJXMpsF4esRCgCKhQ
   A==;
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="108383200"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Aug 2022 02:00:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 10 Aug 2022 02:00:13 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 10 Aug 2022 02:00:11 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
CC:     <nagasuresh.relli@microchip.com>,
        <valentina.fernandezalanis@microchip.com>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH] riscv: dts: microchip: add qspi compatible fallback
Date:   Wed, 10 Aug 2022 09:59:15 +0100
Message-ID: <20220810085914.801170-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "hard" QSPI peripheral on PolarFire SoC is derived from version 2
of the FPGA IP core. The original binding had no fallback etc, so this
device tree is valid as is. There was also no functional driver for the
QSPI IP, so no device with a devicetree from a previous mainline
release will regress.

Link: https://lore.kernel.org/linux-spi/7c9f0d96-2882-964a-cd1f-916ddb3f0410@linaro.org/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
See the link for binding discussion. I'll apply this at some point once
the driver makes it upstream.

CC: nagasuresh.relli@microchip.com
CC: valentina.fernandezalanis@microchip.com
CC: broonie@kernel.org
CC: devicetree@vger.kernel.org
CC: krzysztof.kozlowski+dt@linaro.org
CC: robh+dt@kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-spi@vger.kernel.org
CC: linux-riscv@lists.infradead.org
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 499c2e63ad35..45e3cc659882 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -330,7 +330,7 @@ spi1: spi@20109000 {
 		};
 
 		qspi: spi@21000000 {
-			compatible = "microchip,mpfs-qspi";
+			compatible = "microchip,mpfs-qspi", "microchip,coreqspi-rtl-v2";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x21000000 0x0 0x1000>;
-- 
2.36.1

