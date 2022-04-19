Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78450664E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243050AbiDSHy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiDSHyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:54:55 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B185617C;
        Tue, 19 Apr 2022 00:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1650354733; x=1681890733;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7yEGglKynMcyHWuUSkM7xE+cnhYCihGyLD9i03cdWOI=;
  b=QwbEcQxv+ojfx8bpAeSwztuiSM4FX3+3v+J7sM6L3+jck9iGrU6QuHor
   E+c5YTOm7z4WtS47EVTtbSAJgewcBiYY3vX/3n7nKgFEIBaFJkcol431S
   JnmWvsQLoTIPGOtreVeyr4nOPuiNuQB4xtsyqGBPbjzHcLiYdUrxHHK+y
   4ISv8NEWp7KBEBV/dhML9jtyuZ7FF39ln4tkSXU5bhr3+Zef5w1PPh8Mj
   vyNz+KDC82ZURbCE2qyUnkE0qnEqnfzXcZnRbCh/xt13lU00BovPSI6B1
   bAndvbKjc/F5iKuS/hv2cPRPwqVQJ0YOkYmoeZ8Q99LiYUx0DY1d87uiN
   g==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643670000"; 
   d="scan'208";a="23348530"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 19 Apr 2022 09:52:11 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 19 Apr 2022 09:52:11 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 19 Apr 2022 09:52:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1650354731; x=1681890731;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7yEGglKynMcyHWuUSkM7xE+cnhYCihGyLD9i03cdWOI=;
  b=C923aVZHazZt1VbmGDV5zXNljBqwXpHb9nCbdY/HmyPTgdMTjNtgiOSe
   yL9zja1nC20qls+SUZ42tnLXT+peRj79bVTu10eqZ+XMW1JiNYWJFEEbu
   t/mduc+jGImdtwGxziEc7slR/8ICh5t0cOBXIXgCISXdwZuWeL0Tf0fAG
   obtdE7NDoC1OzqCNpZLicjnyLAkt2ktyLAt0h+pxyrh+sfpPi4nRAWD6C
   cJjNmx38s8/pK4WZsT5dlhpvxafVyed9QfyNASpAj+A2AOAlOMlOOrlMi
   UTRIGsSGL7ck4Afh99q/3ltXDsTpsNQ8XNQY5SOkZXw8WMaMl9Eevvxxv
   w==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643670000"; 
   d="scan'208";a="23348527"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 19 Apr 2022 09:52:10 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 8CCFE280070;
        Tue, 19 Apr 2022 09:52:10 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2] arm64: dts: ti: k3-am64-mcu: remove incorrect UART base clock rates
Date:   Tue, 19 Apr 2022 09:51:57 +0200
Message-Id: <20220419075157.189347-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found that (at least some versions of) the sci-fw set the base clock
rate for UARTs in the MCU domain to 96 MHz instead of the expected 48 MHz,
leading to incorrect baud rates when used from Linux.

As the 8250_omap driver will query the actual clock rate from the clk
driver when clock-frequency is unset, removing the incorrect property is
sufficient to fix the baud rate.

Fixes: 8abae9389bdb ("arm64: dts: ti: Add support for AM642 SoC")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: remove incorrect clock-frequency instead of using
    assigned-clock-rates to modify the base clock

 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
index 2bb5c9ff172c..02d4285acbb8 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
@@ -10,7 +10,6 @@ mcu_uart0: serial@4a00000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x04a00000 0x00 0x100>;
 		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
-		clock-frequency = <48000000>;
 		current-speed = <115200>;
 		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 149 0>;
@@ -21,7 +20,6 @@ mcu_uart1: serial@4a10000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x04a10000 0x00 0x100>;
 		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
-		clock-frequency = <48000000>;
 		current-speed = <115200>;
 		power-domains = <&k3_pds 160 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 160 0>;
-- 
2.25.1

