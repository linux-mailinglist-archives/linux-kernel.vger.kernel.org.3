Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EAC59CC0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbiHVXVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238553AbiHVXVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:21:05 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA56B4C611;
        Mon, 22 Aug 2022 16:21:03 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27MNKlD1095371;
        Mon, 22 Aug 2022 18:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661210447;
        bh=C0FWmK5NWDetoYxTMdBSgA+aZlJ6uevaafIo09ZQuZU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yuhUBge02UEvwbeSkVrCFb4nJ2jpTUKB/569BGKiY1uPpbGPJ2mO5gL3UT8ZjDiUY
         gWTfpbsFEnQz3vHtvY29fkTtsflyAfi9B5wqbM+0EOqWOo/d91E9CTW6rD2mrgalUo
         G2iiUrDVvM7z8uUyDeAyi1zz7EyNZEGP90iLGbDU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27MNKlMe019768
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Aug 2022 18:20:47 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 22
 Aug 2022 18:20:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 22 Aug 2022 18:20:47 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27MNKkkR122207;
        Mon, 22 Aug 2022 18:20:46 -0500
From:   Andrew Davis <afd@ti.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 1/2] ARM: nspire: Use syscon-reboot to handle restart
Date:   Mon, 22 Aug 2022 18:20:45 -0500
Message-ID: <20220822232046.1230-2-afd@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220822232046.1230-1-afd@ti.com>
References: <20220822232046.1230-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writing this bit can be handled by the syscon-reboot driver. Add the
info to DT and remove the machine_desc version.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/boot/dts/nspire.dtsi |  7 +++++++
 arch/arm/mach-nspire/Kconfig  |  2 ++
 arch/arm/mach-nspire/mmio.h   |  3 ---
 arch/arm/mach-nspire/nspire.c | 10 ----------
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
index bb240e6a3a6f..6357b803521e 100644
--- a/arch/arm/boot/dts/nspire.dtsi
+++ b/arch/arm/boot/dts/nspire.dtsi
@@ -172,7 +172,14 @@ rtc: rtc@90090000 {
 			};
 
 			misc: misc@900a0000 {
+				compatible = "syscon", "simple-mfd";
 				reg = <0x900a0000 0x1000>;
+
+				reboot {
+					compatible = "syscon-reboot";
+					offset = <0x08>;
+					value = <0x02>;
+				};
 			};
 
 			pwr: pwr@900b0000 {
diff --git a/arch/arm/mach-nspire/Kconfig b/arch/arm/mach-nspire/Kconfig
index eb9916233dea..37e2dae60c2b 100644
--- a/arch/arm/mach-nspire/Kconfig
+++ b/arch/arm/mach-nspire/Kconfig
@@ -9,5 +9,7 @@ config ARCH_NSPIRE
 	select ARM_VIC
 	select ARM_TIMER_SP804
 	select NSPIRE_TIMER
+	select POWER_RESET
+	select POWER_RESET_SYSCON
 	help
 	  This enables support for systems using the TI-NSPIRE CPU
diff --git a/arch/arm/mach-nspire/mmio.h b/arch/arm/mach-nspire/mmio.h
index 48e32f13f311..2ce0656139ec 100644
--- a/arch/arm/mach-nspire/mmio.h
+++ b/arch/arm/mach-nspire/mmio.h
@@ -5,9 +5,6 @@
  *	Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
  */
 
-#define NSPIRE_MISC_PHYS_BASE		0x900A0000
-#define NSPIRE_MISC_HWRESET		0x08
-
 #define NSPIRE_PWR_PHYS_BASE		0x900B0000
 #define NSPIRE_PWR_VIRT_BASE		0xFEEB0000
 #define NSPIRE_PWR_BUS_DISABLE1		0x18
diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
index 2d4abb0288b9..1e13337972dd 100644
--- a/arch/arm/mach-nspire/nspire.c
+++ b/arch/arm/mach-nspire/nspire.c
@@ -27,16 +27,6 @@ static const char *const nspire_dt_match[] __initconst = {
 	NULL,
 };
 
-static void nspire_restart(enum reboot_mode mode, const char *cmd)
-{
-	void __iomem *base = ioremap(NSPIRE_MISC_PHYS_BASE, SZ_4K);
-	if (!base)
-		return;
-
-	writel(2, base + NSPIRE_MISC_HWRESET);
-}
-
 DT_MACHINE_START(NSPIRE, "TI-NSPIRE")
 	.dt_compat	= nspire_dt_match,
-	.restart	= nspire_restart,
 MACHINE_END
-- 
2.36.1

