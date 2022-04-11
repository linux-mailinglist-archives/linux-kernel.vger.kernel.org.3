Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10924FBABD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345723AbiDKLVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344825AbiDKLUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:20:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D58427E7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649675918; x=1681211918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZJ3NYfvfU4RQ71JNkt3WWRh7gCKoNfIdhEj5D3xMH9E=;
  b=l80lEBVyQ9b1bBTVvGulmdZCrNdbNdmLqUIRoQanspnELuHqJI8z6h3s
   XgICxfsjItFkMMHgNOFZ8nAoISnwm15hq/od+ptpcjaKOGBpiyJ2pe0ms
   eiqDUmogKFjH7uLUT2VG973lLqi82vTeuFrDCoT7nXHwZCY0PI9ltX8vr
   kQlAQRdW0X0ZSLh+kc9Wqb33hhG1dVvx7eBpOTtoqMnt5UtYIKhimnRpn
   PD35S7Sz2Bq3vfbuty2CSFnFdR6keykqYpTzNvTP08Z/NoMpVCva5gJ3R
   o58CZ0hHDSH/bX/xtp6LHVd8NerJT4T69zU82KlUWRc/pFYvKrNrggDwO
   w==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643698800"; 
   d="scan'208";a="159637090"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2022 04:18:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Apr 2022 04:18:36 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 11 Apr 2022 04:18:34 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/4] ARM: at91: pm: add quirks for pm
Date:   Mon, 11 Apr 2022 14:20:56 +0300
Message-ID: <20220411112057.35369-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220411112057.35369-1-claudiu.beznea@microchip.com>
References: <20220411112057.35369-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoCs supporting ULP0 or ULP1 modes and variants of Cadence Ethernet IP
(controlled by macb driver) may behave buggy when Wake-on-Lan (WoL) is
configured and WoL packet is received while in ULP0/ULP1. On some SoCs
Ethernet interface is not working after resume. On other SoCs the CPU
goes to abort on resume path when switching execution from internal SRAM
to DRAM. For ULP1 + WoL the issue is related a particular restart
sequence of the internal clocks when resuming. These clocks are
automatically managed by PMC and may happen that GMAC peripheral clock
is restarted few clock cycles before internal clocks causing blocking
of Ethernet's DMA. As a consequence Ethernet TX transactions are stopped
and RX transactions are partially stopped (packets are received by MAC,
RX counters incremented but the data is not transferred to DRAM). The
workaround for this is to disable Ethernet's peripheral clock when
going to ULP1. Same behavior has been reproduced on ULP0 for some
platforms (SAMA5D2, SAMA5D3) and the same workaround solves the issue.

The problem has been solved on pm.c as quirk to avoid polluting the
MACB driver with AT91 specific issues as this driver is generic to
multiple vendors.

At probe pointers to struct device_node are retrieved and on the
at91_pm_enter() the quirk specifics are applied: for all Ethernet
interfaces that were parsed the peripheral clocks are disabled. A
special handling is done for modes in dns_modes mask as these are
considered modes that blocks the system if WoL packet are received
but for which applying quirk will lead to not waking up on WoL
packets: in situation where Ethernet interface(s) has suspend mode
in dns_modes mask and Ethernet interface(s) is the only available
wakeup source the suspend is canceled.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 276 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 274 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 2a52ddac7692..239339bf6f79 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -15,6 +15,7 @@
 #include <linux/parser.h>
 #include <linux/suspend.h>
 
+#include <linux/clk.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/platform_data/atmel.h>
 
@@ -60,12 +61,61 @@ struct at91_pm_sfrbu_regs {
 	} pswbu;
 };
 
+/**
+ * enum at91_pm_eth_clk - Ethernet clock indexes
+ * @AT91_PM_ETH_PCLK: pclk index
+ * @AT91_PM_ETH_HCLK: hclk index
+ * @AT91_PM_ETH_MAX_CLK: max index
+ */
+enum at91_pm_eth_clk {
+	AT91_PM_ETH_PCLK,
+	AT91_PM_ETH_HCLK,
+	AT91_PM_ETH_MAX_CLK,
+};
+
+/**
+ * enum at91_pm_eth - Ethernet controller indexes
+ * @AT91_PM_G_ETH: gigabit Ethernet controller index
+ * @AT91_PM_E_ETH: megabit Ethernet controller index
+ * @AT91_PM_MAX_ETH: max index
+ */
+enum at91_pm_eth {
+	AT91_PM_G_ETH,
+	AT91_PM_E_ETH,
+	AT91_PM_MAX_ETH,
+};
+
+/**
+ * struct at91_pm_quirk_eth - AT91 PM Ethernet quirks
+ * @np: Ethernet device node
+ * @clks: Ethernet clocks
+ * @modes: power management mode that this quirk applies to
+ * @dns_modes: do not suspend modes: stop suspending if Ethernet is configured
+ *	       as wakeup source but buggy and no other wakeup source is
+ *	       available
+ */
+struct at91_pm_quirk_eth {
+	struct device_node *np;
+	struct clk_bulk_data clks[AT91_PM_ETH_MAX_CLK];
+	u32 modes;
+	u32 dns_modes;
+};
+
+/**
+ * struct at91_pm_quirks - AT91 PM quirks
+ * @eth: Ethernet quirks
+ */
+struct at91_pm_quirks {
+	struct at91_pm_quirk_eth eth[AT91_PM_MAX_ETH];
+};
+
 /**
  * struct at91_soc_pm - AT91 SoC power management data structure
  * @config_shdwc_ws: wakeup sources configuration function for SHDWC
  * @config_pmc_ws: wakeup srouces configuration function for PMC
  * @ws_ids: wakup sources of_device_id array
  * @bu: backup unit mapped data (for backup mode)
+ * @quirks: PM quirks
  * @data: PM data to be used on last phase of suspend
  * @sfrbu_regs: SFRBU registers mapping
  * @memcs: memory chip select
@@ -75,6 +125,7 @@ struct at91_soc_pm {
 	int (*config_pmc_ws)(void __iomem *pmc, u32 mode, u32 polarity);
 	const struct of_device_id *ws_ids;
 	struct at91_pm_bu *bu;
+	struct at91_pm_quirks quirks;
 	struct at91_pm_data data;
 	struct at91_pm_sfrbu_regs sfrbu_regs;
 	void *memcs;
@@ -84,10 +135,12 @@ struct at91_soc_pm {
  * enum at91_pm_iomaps:	IOs that needs to be mapped for different PM modes
  * @AT91_PM_IOMAP_SHDWC:	SHDWC controller
  * @AT91_PM_IOMAP_SFRBU:	SFRBU controller
+ * @AT91_PM_IOMAP_ETHC:		Ethernet controller
  */
 enum at91_pm_iomaps {
 	AT91_PM_IOMAP_SHDWC,
 	AT91_PM_IOMAP_SFRBU,
+	AT91_PM_IOMAP_ETHC,
 };
 
 #define AT91_PM_IOMAP(name)	BIT(AT91_PM_IOMAP_##name)
@@ -263,6 +316,115 @@ static int at91_sam9x60_config_pmc_ws(void __iomem *pmc, u32 mode, u32 polarity)
 	return 0;
 }
 
+static bool at91_pm_eth_quirk_is_valid(int index)
+{
+	struct platform_device *pdev;
+	bool ret = true;
+
+	/* Interface NA in DT. */
+	if (!soc_pm.quirks.eth[index].np)
+		return false;
+
+	/* No quirks for this interface and current suspend mode. */
+	if (!(soc_pm.quirks.eth[index].modes & BIT(soc_pm.data.mode)))
+		return false;
+
+	/* Driver not probed. */
+	pdev = of_find_device_by_node(soc_pm.quirks.eth[index].np);
+	if (!pdev)
+		return false;
+
+	/* No quirks if device isn't a wakeup source. */
+	if (!device_may_wakeup(&pdev->dev))
+		ret = false;
+
+	put_device(&pdev->dev);
+	return ret;
+}
+
+static int at91_pm_config_quirks(bool suspend)
+{
+	struct wakeup_source *ws;
+	int i, j, ret, tmp;
+
+	/*
+	 * Ethernet IPs who's device_node pointers are stored into
+	 * soc_pm.quirks.eth[].np cannot handle WoL packets while in ULP0, ULP1
+	 * or both due to a hardware bug. If they receive WoL packets while in
+	 * ULP0 or ULP1 IPs could stop working or the whole system could stop
+	 * working. We cannot handle this scenario in the ethernet driver itself
+	 * as the driver is common to multiple vendors and also we only know
+	 * here, in this file, if we suspend to ULP0 or ULP1 mode. Thus handle
+	 * these scenarios here, as quirks.
+	 */
+	for (i = 0; i < AT91_PM_MAX_ETH; i++) {
+		if (!at91_pm_eth_quirk_is_valid(i))
+			continue;
+
+		/*
+		 * For modes in dns_modes mask the system blocks if quirk is not
+		 * applied but if applied the interface doesn't act at WoL
+		 * events. Thus take care to avoid suspending if this interface
+		 * is the only configured wakeup source.
+		 */
+		if (suspend &&
+		    soc_pm.quirks.eth[i].dns_modes & BIT(soc_pm.data.mode)) {
+			int ws_count = 0;
+
+			for_each_wakeup_source(ws) {
+				ws_count++;
+				if (ws_count > 1)
+					break;
+			}
+
+			/*
+			 * Checking ws == 1 is good for all SAMA5 based platforms
+			 * even when both G_ETH and E_ETH are available as dsn_modes
+			 * is populated only on G_ETH interface.
+			 */
+			if (ws_count == 1) {
+				pr_err("AT91: PM: Ethernet cannot resume from WoL!");
+				ret = -EPERM;
+				goto clk_unconfigure;
+			}
+		}
+
+		if (suspend) {
+			clk_bulk_disable_unprepare(AT91_PM_ETH_MAX_CLK,
+						   soc_pm.quirks.eth[i].clks);
+		} else {
+			ret = clk_bulk_prepare_enable(AT91_PM_ETH_MAX_CLK,
+						      soc_pm.quirks.eth[i].clks);
+			if (ret)
+				goto clk_unconfigure;
+		}
+	}
+
+	return 0;
+
+clk_unconfigure:
+	/*
+	 * In case of resume we reach this point if clk_prepare_enable() failed.
+	 * we don't want to revert the previous clk_prepare_enable() for the
+	 * other IP.
+	 */
+	if (suspend) {
+		for (j = i - 1; j <= 0; j--) {
+			if (!at91_pm_eth_quirk_is_valid(i))
+				continue;
+
+			tmp = clk_bulk_prepare_enable(AT91_PM_ETH_MAX_CLK,
+						      soc_pm.quirks.eth[i].clks);
+			if (tmp) {
+				pr_err("AT91: PM: failed to enable %s clock\n",
+					i == AT91_PM_ETH_PCLK ? "pclk" : "hclk");
+			}
+		}
+	}
+
+	return ret;
+}
+
 /*
  * Called after processes are frozen, but before we shutdown devices.
  */
@@ -427,6 +589,12 @@ static void at91_pm_suspend(suspend_state_t state)
  */
 static int at91_pm_enter(suspend_state_t state)
 {
+	int ret;
+
+	ret = at91_pm_config_quirks(true);
+	if (ret)
+		return ret;
+
 #ifdef CONFIG_PINCTRL_AT91
 	/*
 	 * FIXME: this is needed to communicate between the pinctrl driver and
@@ -464,6 +632,7 @@ static int at91_pm_enter(suspend_state_t state)
 #ifdef CONFIG_PINCTRL_AT91
 	at91_pinctrl_gpio_resume();
 #endif
+	at91_pm_config_quirks(false);
 	return 0;
 }
 
@@ -888,6 +1057,20 @@ static const struct of_device_id atmel_shdwc_ids[] = {
 	{ /* sentinel. */ }
 };
 
+static const struct of_device_id gmac_ids[] __initconst = {
+	{ .compatible = "atmel,sama5d3-gem" },
+	{ .compatible = "atmel,sama5d2-gem" },
+	{ .compatible = "atmel,sama5d29-gem" },
+	{ .compatible = "microchip,sama7g5-gem" },
+	{ },
+};
+
+static const struct of_device_id emac_ids[] __initconst = {
+	{ .compatible = "atmel,sama5d3-macb" },
+	{ .compatible = "microchip,sama7g5-emac" },
+	{ },
+};
+
 /*
  * Replaces _mode_to_replace with a supported mode that doesn't depend
  * on controller pointed by _map_bitmask
@@ -941,8 +1124,30 @@ static const struct of_device_id atmel_shdwc_ids[] = {
 				     (soc_pm.data.standby_mode));	\
 	} while (0)
 
+static int __init at91_pm_get_eth_clks(struct device_node *np,
+				       struct clk_bulk_data *clks)
+{
+	clks[AT91_PM_ETH_PCLK].clk = of_clk_get_by_name(np, "pclk");
+	if (IS_ERR(clks[AT91_PM_ETH_PCLK].clk))
+		return PTR_ERR(clks[AT91_PM_ETH_PCLK].clk);
+
+	clks[AT91_PM_ETH_HCLK].clk = of_clk_get_by_name(np, "hclk");
+	if (IS_ERR(clks[AT91_PM_ETH_HCLK].clk))
+		return PTR_ERR(clks[AT91_PM_ETH_HCLK].clk);
+
+	return 0;
+}
+
+static int __init at91_pm_eth_clks_empty(struct clk_bulk_data *clks)
+{
+	return IS_ERR(clks[AT91_PM_ETH_PCLK].clk) ||
+	       IS_ERR(clks[AT91_PM_ETH_HCLK].clk);
+}
+
 static void __init at91_pm_modes_init(const u32 *maps, int len)
 {
+	struct at91_pm_quirk_eth *gmac = &soc_pm.quirks.eth[AT91_PM_G_ETH];
+	struct at91_pm_quirk_eth *emac = &soc_pm.quirks.eth[AT91_PM_E_ETH];
 	struct device_node *np;
 	int ret;
 
@@ -978,6 +1183,41 @@ static void __init at91_pm_modes_init(const u32 *maps, int len)
 		}
 	}
 
+	if ((at91_is_pm_mode_active(AT91_PM_ULP1) ||
+	     at91_is_pm_mode_active(AT91_PM_ULP0) ||
+	     at91_is_pm_mode_active(AT91_PM_ULP0_FAST)) &&
+	    (maps[soc_pm.data.standby_mode] & AT91_PM_IOMAP(ETHC) ||
+	     maps[soc_pm.data.suspend_mode] & AT91_PM_IOMAP(ETHC))) {
+		np = of_find_matching_node(NULL, gmac_ids);
+		if (!np) {
+			np = of_find_matching_node(NULL, emac_ids);
+			if (np)
+				goto get_emac_clks;
+			AT91_PM_REPLACE_MODES(maps, ETHC);
+			goto unmap_unused_nodes;
+		} else {
+			gmac->np = np;
+			at91_pm_get_eth_clks(np, gmac->clks);
+		}
+
+		np = of_find_matching_node(NULL, emac_ids);
+		if (!np) {
+			if (at91_pm_eth_clks_empty(gmac->clks))
+				AT91_PM_REPLACE_MODES(maps, ETHC);
+		} else {
+get_emac_clks:
+			emac->np = np;
+			ret = at91_pm_get_eth_clks(np, emac->clks);
+			if (ret && at91_pm_eth_clks_empty(gmac->clks)) {
+				of_node_put(gmac->np);
+				of_node_put(emac->np);
+				gmac->np = NULL;
+				emac->np = NULL;
+			}
+		}
+	}
+
+unmap_unused_nodes:
 	/* Unmap all unnecessary. */
 	if (soc_pm.data.shdwc &&
 	    !(maps[soc_pm.data.standby_mode] & AT91_PM_IOMAP(SHDWC) ||
@@ -1213,17 +1453,30 @@ void __init sama5_pm_init(void)
 	static const int modes[] __initconst = {
 		AT91_PM_STANDBY, AT91_PM_ULP0, AT91_PM_ULP0_FAST,
 	};
+	static const u32 iomaps[] __initconst = {
+		[AT91_PM_ULP0]		= AT91_PM_IOMAP(ETHC),
+		[AT91_PM_ULP0_FAST]	= AT91_PM_IOMAP(ETHC),
+	};
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_SOC_SAMA5))
 		return;
 
 	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
+	at91_pm_modes_init(iomaps, ARRAY_SIZE(iomaps));
 	ret = at91_dt_ramc(false);
 	if (ret)
 		return;
 
 	at91_pm_init(NULL);
+
+	/* Quirks applies to ULP0, ULP0 fast and ULP1 modes. */
+	soc_pm.quirks.eth[AT91_PM_G_ETH].modes = BIT(AT91_PM_ULP0) |
+						 BIT(AT91_PM_ULP0_FAST) |
+						 BIT(AT91_PM_ULP1);
+	/* Do not suspend in ULP0 if GETH is the only wakeup source. */
+	soc_pm.quirks.eth[AT91_PM_G_ETH].dns_modes = BIT(AT91_PM_ULP0) |
+						     BIT(AT91_PM_ULP0_FAST);
 }
 
 void __init sama5d2_pm_init(void)
@@ -1233,7 +1486,10 @@ void __init sama5d2_pm_init(void)
 		AT91_PM_BACKUP,
 	};
 	static const u32 iomaps[] __initconst = {
-		[AT91_PM_ULP1]		= AT91_PM_IOMAP(SHDWC),
+		[AT91_PM_ULP0]		= AT91_PM_IOMAP(ETHC),
+		[AT91_PM_ULP0_FAST]	= AT91_PM_IOMAP(ETHC),
+		[AT91_PM_ULP1]		= AT91_PM_IOMAP(SHDWC) |
+					  AT91_PM_IOMAP(ETHC),
 		[AT91_PM_BACKUP]	= AT91_PM_IOMAP(SHDWC) |
 					  AT91_PM_IOMAP(SFRBU),
 	};
@@ -1258,6 +1514,17 @@ void __init sama5d2_pm_init(void)
 	soc_pm.sfrbu_regs.pswbu.ctrl = BIT(0);
 	soc_pm.sfrbu_regs.pswbu.softsw = BIT(1);
 	soc_pm.sfrbu_regs.pswbu.state = BIT(3);
+
+	/* Quirk applies to ULP0, ULP0 fast and ULP1 modes. */
+	soc_pm.quirks.eth[AT91_PM_G_ETH].modes = BIT(AT91_PM_ULP0) |
+						 BIT(AT91_PM_ULP0_FAST) |
+						 BIT(AT91_PM_ULP1);
+	/*
+	 * Do not suspend in ULP0, ULP0 fast if GETH is the only wakeup
+	 * source.
+	 */
+	soc_pm.quirks.eth[AT91_PM_G_ETH].dns_modes = BIT(AT91_PM_ULP0) |
+						     BIT(AT91_PM_ULP0_FAST);
 }
 
 void __init sama7_pm_init(void)
@@ -1268,7 +1535,8 @@ void __init sama7_pm_init(void)
 	static const u32 iomaps[] __initconst = {
 		[AT91_PM_ULP0]		= AT91_PM_IOMAP(SFRBU),
 		[AT91_PM_ULP1]		= AT91_PM_IOMAP(SFRBU) |
-					  AT91_PM_IOMAP(SHDWC),
+					  AT91_PM_IOMAP(SHDWC) |
+					  AT91_PM_IOMAP(ETHC),
 		[AT91_PM_BACKUP]	= AT91_PM_IOMAP(SFRBU) |
 					  AT91_PM_IOMAP(SHDWC),
 	};
@@ -1293,6 +1561,10 @@ void __init sama7_pm_init(void)
 	soc_pm.sfrbu_regs.pswbu.ctrl = BIT(0);
 	soc_pm.sfrbu_regs.pswbu.softsw = BIT(1);
 	soc_pm.sfrbu_regs.pswbu.state = BIT(2);
+
+	/* Quirks applies to ULP1 for both Ethernet interfaces. */
+	soc_pm.quirks.eth[AT91_PM_E_ETH].modes = BIT(AT91_PM_ULP1);
+	soc_pm.quirks.eth[AT91_PM_G_ETH].modes = BIT(AT91_PM_ULP1);
 }
 
 static int __init at91_pm_modes_select(char *str)
-- 
2.32.0

