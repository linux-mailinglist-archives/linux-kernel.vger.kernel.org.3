Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400B54D21AF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350054AbiCHTgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350028AbiCHTgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:36:38 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60069.outbound.protection.outlook.com [40.107.6.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29FE54698;
        Tue,  8 Mar 2022 11:35:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSTclyhYYX9Mzg6H0gZPCLeXPMYtM/nH+wZd3Eh7B8LfEHoCxqi2lUaB4ViIPocYIXToEjqzD3caOX86h9pUIOibDKitnMVoGAsyNVi06IgUKEyGZ35jqSuhP2Rvuo4eVtheMbUdFzEr/0IHhkBIsfiiU3GbKDcm3UKNe1ZFrhLHiPms3ubu8o1ochgfz12c4WhhV5HC1CK8r7JxePAu7+4fjrqxuBiaIRryCrqeHjOStnJgTniKdNvZa5ZPiBk7hEwUl8RiRHBJdUWSzVj3SqXV8SCeKyWAvlOz0RrGMIW1MZDj1+Z6xmJYnADl4WX2XuyfbXOtrwo3CB3Csd+TXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irTdWscyl8SdFeXEd9KfomHKqA7LgOYTA5cksaDPDFI=;
 b=eb1tCwCzEaDub0PvC06T/dKcc1tB2pUo6AK8eF6qiiQViM1rUD8Ls/d0+wGmZ3BN2rwOl3l+9jfZYFG8RHfoDB8iqMr53NuhUS6CBF0Fb2aiOqLtMpSEmcK/KnePIm9DYR61YxaTho/1i023iZRbjbq+KGWGcufihMWJFIVMLCTmdFfvLkIWiUEr7tu9CtPXFiopRvntJ247wdmwgIAqkhMZ0tYFsPupyksBIhfe6Xs5Ld9Glw+7IbCG+bwMCOofswcSLNEQir303iFxPIOi7Gw+41RdlShrNzmjpdfV2czBonvpwObW8kZq9Q0Atu5agOb50k7WKrqenO9wodEGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irTdWscyl8SdFeXEd9KfomHKqA7LgOYTA5cksaDPDFI=;
 b=RnPZX+xGHfno5L7RVGeRTuiuZanE/eviVQ3WHmLJuXrKvpHfWLU2cCd1C8Y3m7wbB4KEyBJTnQQcaqma2n4mZQGrn1aXO4eYGANo9ge4JAHpQULQyOzq2XO6pBVpIKo39xdBoqFtAx3rDlflY/I3RN5EANOiekhqxCWigdwmRf8tMc2wF/MNtkbvFQx5smXTw40L3xwSH40CMEF331Zv65eaOxBZMhuGjG++Ai6ItLqn9ujndQJWE9KCo3YY8pGiRFnq4mS9Ra2YEIzMQL5IO327EUbyoAl/D2+O2w1vnNwNttbtuDbjt6837JQyNJZG6OZ+3VzvZfFOeJ11GLb7iw==
Received: from AS9PR06CA0343.eurprd06.prod.outlook.com (2603:10a6:20b:466::26)
 by AM0PR10MB3106.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:12a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Tue, 8 Mar
 2022 19:35:35 +0000
Received: from VE1EUR01FT021.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:466:cafe::39) by AS9PR06CA0343.outlook.office365.com
 (2603:10a6:20b:466::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 19:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT021.mail.protection.outlook.com (10.152.2.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 19:35:35 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Mar 2022 20:35:35 +0100
Received: from localhost.localdomain (167.87.32.5) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Mar 2022 20:35:34 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 1/2] simatic-ipc: convert to use common P2SB accessor
Date:   Tue, 8 Mar 2022 20:35:21 +0100
Message-ID: <20220308193522.26696-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220308193522.26696-1-henning.schild@siemens.com>
References: <20220131151346.45792-1-andriy.shevchenko@linux.intel.com>
 <20220308193522.26696-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [167.87.32.5]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--7.899800-8.000000
X-TMASE-MatchedRID: kX/BPGnY4A0XStyKX9zupNzFDxSn8X5lVByxqzbqctColIr4dI9j766z
        w3UOTZmL31GU/N5W5BCygaZY7yrHznxs7qFZ9FbOSYl00pjSr4qHjikUS3GyEtbgzPjrV+wcL7s
        3UWfpd3Mi7XxKYCm5a6tue8M2sAs7rAxS+N9wrVsnLmQ5uRWv6Oel5KJlNpuVtvnlOJ61K3pTPB
        uNKMG7yh53XUX0iwoUhnOLyflyxrN33TsUNNytfCq75Q09Yd+O6rh4F+X/sTwmZusHWPhfCs6gB
        dMBUo41gl4CchYaNUZth1r0fdARdcG8xStj8ZhZUKYlMBlwOtthjejNb4SeByyKzJY7d2nbm1xh
        XnxxzmKGcPw7dOPCZu6MAMkWcw4i1FxTk7orjNY/doGSNTs/oWk5Fql3Faa76zi8j+r17t2sU/i
        X0A2wj2ww+4tkH8hH5ykFuALiDlsvA+futGwcblSCmfT2v3teGAdnzrnkM48URSScn+QSXt0H8L
        FZNFG7hqz53n/yPnpf97kptCUaFnIgHizbSimKKckHGxmIalxpm+NGYRF8x69mtef9Ph+b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.899800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 78F856E44BC9BE29842C04C5009DEEBB0FB4D755739B1F75F38BD043F06185412000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86c58ac7-dbad-48ef-a694-08da013ad139
X-MS-TrafficTypeDiagnostic: AM0PR10MB3106:EE_
X-Microsoft-Antispam-PRVS: <AM0PR10MB31064F18B4D4588F4EF738EC85099@AM0PR10MB3106.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zuI3B3afFd9AvmvZPgEPrfBbHMr6qRCvLrzl1OQx1geeQn8acCsvJMOMLa88FmMa1/MuWcnlny50uIXTZHOao/pbw9yOOBxo9pEk5JJjF265Xr7IiGxSdQZrC0PWuyxFW90tanfXjRSgnQySqEVd1hkCFvWucSbfY19+StVjAxw3t0WOKzXHO1KNxgdlLee7Cwp7QRUqqtzg7G6zrYI6LFzDqQTo4brWNZr9iSnmK1G3WTDDQ6VsgrSAjXABFYXTnzKh80IYhQL11aLSVrq3i71lmq27ABMS4/D7PZ2LRJ+sUSCLGQwbYWkz5s8gS111BroizwpuYMQL0kZoecDnMt63VM/l4zuZDhgZrAadko+tXJcrcIe/5q8jtiaUf+zW01NJyPhvLeUxUHAiCmDO2HYl+0zRBq3TYgnZbfrRi81Wit5Nj3BoQ5MEJoTSevGCDPVVxhxdLl4x8mHq2zoipon3Yy/3p8lO5ChdWc8ddvfQJRYE+17+T/f+4m/sVY49TXwK1VNBzcJ3sbJKREUWPy67SFu+FEACnTftYToLRv/tCyryAgCXCj3IgKR8nMNRaIoICTAgeg1kzlD+t89XQuqf6wC3xaqEx/hNIZM1Be6gAl1DoKK7Jl78x7EBTJbyxWyn+5gcicl+puzBtRawFUKTU3cV6/Whcd3wWlkB3rycoviOR3NCzg10clkRNaZ
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(956004)(2616005)(5660300002)(2906002)(26005)(316002)(36860700001)(186003)(16526019)(86362001)(6916009)(54906003)(36756003)(336012)(40460700003)(4326008)(44832011)(70586007)(82310400004)(70206006)(83380400001)(8676002)(47076005)(356005)(107886003)(82960400001)(1076003)(8936002)(6666004)(7636003)(7596003)(508600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 19:35:35.5668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c58ac7-dbad-48ef-a694-08da013ad139
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT021.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3106
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have a common P2SB accessor in tree we may use it instead of
open coded variants.

Replace custom code by p2sb_bar() call.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/Kconfig                   |  1 +
 drivers/leds/simple/simatic-ipc-leds.c        | 14 +++----
 drivers/platform/x86/simatic-ipc.c            | 38 -------------------
 drivers/watchdog/Kconfig                      |  1 +
 drivers/watchdog/simatic-ipc-wdt.c            | 15 ++++----
 .../platform_data/x86/simatic-ipc-base.h      |  2 -
 6 files changed, 17 insertions(+), 54 deletions(-)

diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
index 9f6a68336659..9293e6b36c75 100644
--- a/drivers/leds/simple/Kconfig
+++ b/drivers/leds/simple/Kconfig
@@ -3,6 +3,7 @@ config LEDS_SIEMENS_SIMATIC_IPC
 	tristate "LED driver for Siemens Simatic IPCs"
 	depends on LEDS_CLASS
 	depends on SIEMENS_SIMATIC_IPC
+	select P2SB if X86
 	help
 	  This option enables support for the LEDs of several Industrial PCs
 	  from Siemens.
diff --git a/drivers/leds/simple/simatic-ipc-leds.c b/drivers/leds/simple/simatic-ipc-leds.c
index ff2c96e73241..215ef5b74236 100644
--- a/drivers/leds/simple/simatic-ipc-leds.c
+++ b/drivers/leds/simple/simatic-ipc-leds.c
@@ -15,6 +15,7 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_data/x86/p2sb.h>
 #include <linux/platform_data/x86/simatic-ipc-base.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
@@ -38,8 +39,8 @@ static struct simatic_ipc_led simatic_ipc_leds_io[] = {
 	{ }
 };
 
-/* the actual start will be discovered with PCI, 0 is a placeholder */
-struct resource simatic_ipc_led_mem_res = DEFINE_RES_MEM_NAMED(0, SZ_4K, KBUILD_MODNAME);
+/* the actual start will be discovered with p2sb, 0 is a placeholder */
+struct resource simatic_ipc_led_mem_res = DEFINE_RES_MEM_NAMED(0, 0, KBUILD_MODNAME);
 
 static void *simatic_ipc_led_memory;
 
@@ -143,14 +144,13 @@ static int simatic_ipc_leds_probe(struct platform_device *pdev)
 		ipcled = simatic_ipc_leds_mem;
 		type = IORESOURCE_MEM;
 
-		/* get GPIO base from PCI */
-		res->start = simatic_ipc_get_membase0(PCI_DEVFN(13, 0));
-		if (res->start == 0)
-			return -ENODEV;
+		err = p2sb_bar(NULL, 0, res);
+		if (err)
+			return err;
 
 		/* do the final address calculation */
 		res->start = res->start + (0xC5 << 16);
-		res->end += res->start;
+		res->end = res->start + SZ_4K - 1;
 
 		simatic_ipc_led_memory = devm_ioremap_resource(dev, res);
 		if (IS_ERR(simatic_ipc_led_memory))
diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index b599cda5ba3c..26c35e1660cb 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -101,44 +101,6 @@ static int register_platform_devices(u32 station_id)
 	return 0;
 }
 
-/* FIXME: this should eventually be done with generic P2SB discovery code
- * the individual drivers for watchdogs and LEDs access memory that implements
- * GPIO, but pinctrl will not come up because of missing ACPI entries
- *
- * While there is no conflict a cleaner solution would be to somehow bring up
- * pinctrl even with these ACPI entries missing, and base the drivers on pinctrl.
- * After which the following function could be dropped, together with the code
- * poking the memory.
- */
-/*
- * Get membase address from PCI, used in leds and wdt module. Here we read
- * the bar0. The final address calculation is done in the appropriate modules
- */
-u32 simatic_ipc_get_membase0(unsigned int p2sb)
-{
-	struct pci_bus *bus;
-	u32 bar0 = 0;
-	/*
-	 * The GPIO memory is in bar0 of the hidden P2SB device.
-	 * Unhide the device to have a quick look at it, before we hide it
-	 * again.
-	 * Also grab the pci rescan lock so that device does not get discovered
-	 * and remapped while it is visible.
-	 * This code is inspired by drivers/mfd/lpc_ich.c
-	 */
-	bus = pci_find_bus(0, 0);
-	pci_lock_rescan_remove();
-	pci_bus_write_config_byte(bus, p2sb, 0xE1, 0x0);
-	pci_bus_read_config_dword(bus, p2sb, PCI_BASE_ADDRESS_0, &bar0);
-
-	bar0 &= ~0xf;
-	pci_bus_write_config_byte(bus, p2sb, 0xE1, 0x1);
-	pci_unlock_rescan_remove();
-
-	return bar0;
-}
-EXPORT_SYMBOL(simatic_ipc_get_membase0);
-
 static int __init simatic_ipc_init_module(void)
 {
 	const struct dmi_system_id *match;
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c8fa79da23b3..ce44a942fc68 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1628,6 +1628,7 @@ config SIEMENS_SIMATIC_IPC_WDT
 	tristate "Siemens Simatic IPC Watchdog"
 	depends on SIEMENS_SIMATIC_IPC
 	select WATCHDOG_CORE
+	select P2SB if X86
 	help
 	  This driver adds support for several watchdogs found in Industrial
 	  PCs from Siemens.
diff --git a/drivers/watchdog/simatic-ipc-wdt.c b/drivers/watchdog/simatic-ipc-wdt.c
index 8bac793c63fb..6599695dc672 100644
--- a/drivers/watchdog/simatic-ipc-wdt.c
+++ b/drivers/watchdog/simatic-ipc-wdt.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_data/x86/p2sb.h>
 #include <linux/platform_data/x86/simatic-ipc-base.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
@@ -54,9 +55,9 @@ static struct resource io_resource_trigger =
 	DEFINE_RES_IO_NAMED(WD_TRIGGER_IOADR, SZ_1,
 			    KBUILD_MODNAME " WD_TRIGGER_IOADR");
 
-/* the actual start will be discovered with pci, 0 is a placeholder */
+/* the actual start will be discovered with p2sb, 0 is a placeholder */
 static struct resource mem_resource =
-	DEFINE_RES_MEM_NAMED(0, SZ_4, "WD_RESET_BASE_ADR");
+	DEFINE_RES_MEM_NAMED(0, 0, "WD_RESET_BASE_ADR");
 
 static u32 wd_timeout_table[] = {2, 4, 6, 8, 16, 32, 48, 64 };
 static void __iomem *wd_reset_base_addr;
@@ -150,6 +151,7 @@ static int simatic_ipc_wdt_probe(struct platform_device *pdev)
 	struct simatic_ipc_platform *plat = pdev->dev.platform_data;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
+	int ret;
 
 	switch (plat->devmode) {
 	case SIMATIC_IPC_DEVICE_227E:
@@ -190,15 +192,14 @@ static int simatic_ipc_wdt_probe(struct platform_device *pdev)
 	if (plat->devmode == SIMATIC_IPC_DEVICE_427E) {
 		res = &mem_resource;
 
-		/* get GPIO base from PCI */
-		res->start = simatic_ipc_get_membase0(PCI_DEVFN(0x1f, 1));
-		if (res->start == 0)
-			return -ENODEV;
+		ret = p2sb_bar(NULL, 0, res);
+		if (ret)
+			return ret;
 
 		/* do the final address calculation */
 		res->start = res->start + (GPIO_COMMUNITY0_PORT_ID << 16) +
 			     PAD_CFG_DW0_GPP_A_23;
-		res->end += res->start;
+		res->end = res->start + SZ_4 - 1;
 
 		wd_reset_base_addr = devm_ioremap_resource(dev, res);
 		if (IS_ERR(wd_reset_base_addr))
diff --git a/include/linux/platform_data/x86/simatic-ipc-base.h b/include/linux/platform_data/x86/simatic-ipc-base.h
index 62d2bc774067..39fefd48cf4d 100644
--- a/include/linux/platform_data/x86/simatic-ipc-base.h
+++ b/include/linux/platform_data/x86/simatic-ipc-base.h
@@ -24,6 +24,4 @@ struct simatic_ipc_platform {
 	u8	devmode;
 };
 
-u32 simatic_ipc_get_membase0(unsigned int p2sb);
-
 #endif /* __PLATFORM_DATA_X86_SIMATIC_IPC_BASE_H */
-- 
2.34.1

