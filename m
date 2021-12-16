Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADA147740B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbhLPOLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:11:42 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:10973 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbhLPOLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639663899; x=1671199899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=tdY/B8hRRCxkMeWlkMCdQd3n47eoyj1Pt6q/MH/LGRg=;
  b=CDQn4W+iVHCzGwtRV7JjXY7ebxEJ+KMJsFzsiIiIKw98vCZ5bsV3W0km
   jrM+oD6yNQZSxkcqR7XrzyrJ3O0cDSkcUQU7BYax20LRN7SaSH+/fda5g
   Lq9/vtwdb0MEJEMV6JHGOLU5vZwY8BuU7amYp0B7kAmMQsysyT1Xd5+m6
   zkpbmmkpTmFyb1jCIifJTE6FVFrdGEHj7rVaFdSnIm4Qce/4tr5YL9iT1
   CqiPJFV8z+HTNrpjCa+68tqMkcYlaL0vDG9cWuTVoswIifwdDuLBvvKU5
   M4ENZnsjKmZNHSK4SaL3IbCppUQ1ORFD44QQAE97lrt9YTE1SBiSO1uEp
   g==;
IronPort-SDR: D1+OaanKn564ObLRs5KR4ccJ+quoUtcoMr+IPSWsxCoD8Yhj+DJld1pOPyFs10mBhwh7tJdWEn
 EoCsIkba+L7sGtzr5NhnDqDRnIojo4toK7MM2bvhsIr88wDlT7PPMyAkagkYfvTMx17wqJ6jUy
 6r1rx3LphRXMMCRdN38M11GLFqp20vDVP6YH0bjWZSaLSrE+G/uxtQfFcgM4qesUya99Vv86Kp
 CfrrHHoVpAvhs3nVhGnzz0oc8/JEA7nsiioTUCl6przIt4p+wduxB2x7x+j3boqokEM0WNi2Tu
 PDSuuMwbbA6FoijNYr/Uxx8i
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="147461446"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2021 07:11:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 07:11:36 -0700
Received: from rob-dk-mpu02.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 16 Dec 2021 07:11:34 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/8] ARM: at91: PM: add cpu idle support for sama7g5
Date:   Thu, 16 Dec 2021 16:13:34 +0200
Message-ID: <20211216141338.35144-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216141338.35144-1-claudiu.beznea@microchip.com>
References: <20211216141338.35144-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPU idle support for SAMA7G5. Support will make use of PMC_CPU_RATIO
register to divide the CPU clock by 16 before switching it to idle and
use automatic self-refresh option of DDR controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
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

