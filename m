Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E4748DA07
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbiAMOsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:48:15 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31589 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbiAMOsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642085288; x=1673621288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cpKxdtwy7Ox5Jspj12nGljBMXStsy5iD5Lt1+j43mkI=;
  b=M2XdIhHByRrPM9DLlgfgGH3FpCAcKqYNmZSAeanB0+ZAWkjxhqAJSjgD
   7fuiRCKh51T7QxNVh8NGIPUqhQf+LmEl/c5UFpqYq7xu/w3tEOotDUB6w
   O5l7wYu4k2L9UOkmESE3Wse3tpRnp/6czx4EppxMZVKCkRDTVDEUcxFk0
   Nn9VX8N3gZsUqDE09Do/CgDErehgNo+cPPnzIHyJXEefLiQlaPD9uV7Fm
   RAFa+ojCXnFq5yTEnkaY+PWO0VhLzGquiRd3Za6xP5IqdWOoJ/40ENJeq
   zSQ2kbTBtAiUnjxwJroXeQDUzzgFd90E6onm42+gGA4hkaibg/XVQLQwH
   g==;
IronPort-SDR: l25eMLLmgkkG50NGqSakJ+63kGv8LZzXzzZ5yAaC9psEOjUcqRV8asD51bVC2J/cZlbPxL076U
 N7yz6ifnfauTQGaXkD1Zz5li6ybwQR0PPWnhHdnlgrmiM1/N7zmo1agrwFW2hJ5g45yjolVVJ1
 9Mv1BxMGXJZvdVYfsrf9/stGM0DvJFBvzf9K2BLLS4Vffs4YrQHWZ6O9ecFILAklFEOPQfK00O
 9fW5IeksDKMBDTGDY2o/U1mSuw5usuEB+zQpFesEeoYKz0t4rzA/LJlnwKHVYHF7atGnUwLl5D
 OfUV6z/Nwp+DZdZoLecV308A
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="158557517"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2022 07:48:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 07:48:07 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 13 Jan 2022 07:48:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 04/10] ARM: at91: PM: add cpu idle support for sama7g5
Date:   Thu, 13 Jan 2022 16:48:54 +0200
Message-ID: <20220113144900.906370-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220113144900.906370-1-claudiu.beznea@microchip.com>
References: <20220113144900.906370-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPU idle support for SAMA7G5. Support will make use of PMC_CPU_RATIO
register to divide the CPU clock by 16 before switching it to idle and
use automatic self-refresh option of DDR controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/arm/mach-at91/pm.c      | 27 ++++++++++++++++++++++++++-
 include/linux/clk/at91_pmc.h |  4 ++++
 include/soc/at91/sama7-ddr.h |  1 +
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index dd6f4ce3f766..0fd609e26615 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -605,6 +605,30 @@ static void at91sam9_sdram_standby(void)
 		at91_ramc_write(1, AT91_SDRAMC_LPR, saved_lpr1);
 }
 
+static void sama7g5_standby(void)
+{
+	int pwrtmg, ratio;
+
+	pwrtmg = readl(soc_pm.data.ramc[0] + UDDRC_PWRCTL);
+	ratio = readl(soc_pm.data.pmc + AT91_PMC_RATIO);
+
+	/*
+	 * Place RAM into self-refresh after a maximum idle clocks. The maximum
+	 * idle clocks is configured by bootloader in
+	 * UDDRC_PWRMGT.SELFREF_TO_X32.
+	 */
+	writel(pwrtmg | UDDRC_PWRCTL_SELFREF_EN,
+	       soc_pm.data.ramc[0] + UDDRC_PWRCTL);
+	/* Divide CPU clock by 16. */
+	writel(ratio & ~AT91_PMC_RATIO_RATIO, soc_pm.data.pmc + AT91_PMC_RATIO);
+
+	cpu_do_idle();
+
+	/* Restore previous configuration. */
+	writel(ratio, soc_pm.data.pmc + AT91_PMC_RATIO);
+	writel(pwrtmg, soc_pm.data.ramc[0] + UDDRC_PWRCTL);
+}
+
 struct ramc_info {
 	void (*idle)(void);
 	unsigned int memctrl;
@@ -615,6 +639,7 @@ static const struct ramc_info ramc_infos[] __initconst = {
 	{ .idle = at91sam9_sdram_standby, .memctrl = AT91_MEMCTRL_SDRAMC},
 	{ .idle = at91_ddr_standby, .memctrl = AT91_MEMCTRL_DDRSDR},
 	{ .idle = sama5d3_ddr_standby, .memctrl = AT91_MEMCTRL_DDRSDR},
+	{ .idle = sama7g5_standby, },
 };
 
 static const struct of_device_id ramc_ids[] __initconst = {
@@ -622,7 +647,7 @@ static const struct of_device_id ramc_ids[] __initconst = {
 	{ .compatible = "atmel,at91sam9260-sdramc", .data = &ramc_infos[1] },
 	{ .compatible = "atmel,at91sam9g45-ddramc", .data = &ramc_infos[2] },
 	{ .compatible = "atmel,sama5d3-ddramc", .data = &ramc_infos[3] },
-	{ .compatible = "microchip,sama7g5-uddrc", },
+	{ .compatible = "microchip,sama7g5-uddrc", .data = &ramc_infos[4], },
 	{ /*sentinel*/ }
 };
 
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index ccb3f034bfa9..3484309b59bf 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -78,6 +78,10 @@
 #define		AT91_PMC_MAINRDY	(1	<< 16)		/* Main Clock Ready */
 
 #define	AT91_CKGR_PLLAR		0x28			/* PLL A Register */
+
+#define	AT91_PMC_RATIO		0x2c			/* Processor clock ratio register [SAMA7G5 only] */
+#define		AT91_PMC_RATIO_RATIO	(0xf)		/* CPU clock ratio. */
+
 #define	AT91_CKGR_PLLBR		0x2c			/* PLL B Register */
 #define		AT91_PMC_DIV		(0xff  <<  0)		/* Divider */
 #define		AT91_PMC_PLLCOUNT	(0x3f  <<  8)		/* PLL Counter */
diff --git a/include/soc/at91/sama7-ddr.h b/include/soc/at91/sama7-ddr.h
index fee1b11bddca..9e17247474fa 100644
--- a/include/soc/at91/sama7-ddr.h
+++ b/include/soc/at91/sama7-ddr.h
@@ -53,6 +53,7 @@
 #define		UDDRC_STAT_OPMODE_MSK		(0x7 << 0)	/* Operating mode mask */
 
 #define UDDRC_PWRCTL				(0x30)		/* UDDRC Low Power Control Register */
+#define		UDDRC_PWRCTL_SELFREF_EN		(1 << 0)	/* Automatic self-refresh */
 #define		UDDRC_PWRCTL_SELFREF_SW		(1 << 5)	/* Software self-refresh */
 
 #define UDDRC_DFIMISC				(0x1B0)		/* UDDRC DFI Miscellaneous Control Register */
-- 
2.32.0

