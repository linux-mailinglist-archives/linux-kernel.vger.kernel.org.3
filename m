Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5740E525D6A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378403AbiEMIhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378276AbiEMIhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:37:07 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495E426273E;
        Fri, 13 May 2022 01:37:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EA5e4SKJxkEgam/g/N7xtfQUZuiWPlLQOwO1SEIBMml8hrWXlqcQxNsW+jQNEGtBwuCTL88cFwgnr1Wy/rTASwbOnT8ZYD0Z8Um4IOcs5NwVlEV56w4PcY8He32PPaCSYAH2WzGPrRuoySVmc0aE2e8RgFSlVMQkAOsEh8P+gcgG+fOP07SbowmD5mVdAQPhwckfgLdHakf12+zbPZ5/Jhf55+bn9f0mR8Y46qcGUgl9Kf/UTDP9Gqkm7qNIlPjwm6SlctL7WvWKXNJ1N7dEnk0q8dVH9HhqZu/nXeT2sHV7rR2XK2kHijpDG/bGafa38IyyT6Kl76vYEJ8Eqbsv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/bvzut7vDPs6Qu42tMSsNBM1KLXMXM7ArXnJxh9Qi4=;
 b=Jl5VFKN6j5JnGzVypZQ5mXs/CtgQl4ofFdRy7va+iWhHDY9isv1u89OQNrWiAhLtavQwcA8xwfHsPQqNr7iS3J/jQO95BYM6uK3Sku7GI4jLvOmFlZWQYCuMRiaarbiUXrobgg3PkvsU4kdThRTbWhwfDecfZPRV48/ih5ZhPNl57ptERSJXW2X767TvgWTeeKNqtyL6kP6uedLdox+6BfFpJDEKVQMskMMCP00qgpIRUKcTkoAef3NOaFr4izbPFmYToY/s03JYbilo2eZ+DMmmZsuPsD3452OcI8sRNJbr02QNitDKkZ2KU5TtO/dyozYZpYgHH7Cm/lWjfi8O5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/bvzut7vDPs6Qu42tMSsNBM1KLXMXM7ArXnJxh9Qi4=;
 b=z/t8LAziRB251j2aq8EtSohVI4kdC2RKaNo0j6uIDZbki26HikS0kQIlp7LyGHkBEaVtVGqU3kt80DQzL0me3daVpWXQ+9PNNaoqODTIho6X5eFSkhW3IJ+2nzjeqpf4a1E3lJjS15jGXk8vHY/JUP7ssbm08EEl5lerCvC9MtHXx/6FfDwLMv7cmnIroY5ebaXNAlJejA7CADdEXdHsgu4BNi1DwifybiG28NfZh7v0iXSTx5TypAVaHqVr024X+RDlYbqFTg/pLNqJGjvZOoKAG7zh6xOx3dkdlktBGf/NnCLsHqp0WfgOu8c/u0sU2+S8Xxw8Pak63qubE1NHtg==
Received: from DBBPR09CA0004.eurprd09.prod.outlook.com (2603:10a6:10:c0::16)
 by GVXPR10MB5792.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Fri, 13 May
 2022 08:37:03 +0000
Received: from DB5EUR01FT039.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:c0:cafe::6a) by DBBPR09CA0004.outlook.office365.com
 (2603:10a6:10:c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Fri, 13 May 2022 08:37:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT039.mail.protection.outlook.com (10.152.5.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 08:37:03 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 10:37:02 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.210) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 10:37:02 +0200
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
Subject: [PATCH v3 2/4] watchdog: simatic-ipc-wdt: convert to use P2SB accessor
Date:   Fri, 13 May 2022 10:36:50 +0200
Message-ID: <20220513083652.974-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513083652.974-1-henning.schild@siemens.com>
References: <20220513083652.974-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.210]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a434ec37-4ade-4c53-c2aa-08da34bbc167
X-MS-TrafficTypeDiagnostic: GVXPR10MB5792:EE_
X-Microsoft-Antispam-PRVS: <GVXPR10MB579289AD2B1D002D1318577985CA9@GVXPR10MB5792.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HM8HVcro9pWg/W8xmDX1W9SAUYVfOQmgZ8QtpR1UEkZZx6pgXRL13x6SUV0Y9sheFy8jr0WKtzUPXJpxOePx03GxFbWCLhGmwluYGEfNojlARpYNFBPd4ggB+sEAqjzMcpZRw1wzhE512fxOjfaPnfuJVhH+9/xA5Y3QL0zgd/G4XYMVMI6iKbfsOipIELeTOXWoDa/3l57r2Zmv1Yals5UAi18gAOKfVm5/w5GNhB7QNPmaSu2p4E5FmJRpNV2HW37uip8HxG+qSH4hTNMPSZ0mP/3aFrdZvQHMMSXkuoV4cHYtpTsUXPLlvv7Gy4+N95IxgJ7z0uh/e/bO3ZYRwd69UazUAPU5AfjCJOKQp5KMn0w8+Wvr3RQl27kHFf8kOvyBylQ+jvCzAx+eB3zCY5bwFpZF2NDtsY8X2WG/XIstVm1oY7GA3xMz11mj+t5ttPI/8bn4jmUxtMyF+qIuYd/zxUVEFPDjXDulwZuc3/N6uv1nE6jb8XxRf2mVmr6YnTeWdYj3XEZHBK+pc6FRJcEEngbIr5cqeTtmcywCN81FGOmnev53AmB94yeBBFqFMAd3p2+Pw9eDEyaW64yQVtR2ha1tEmZq4q9k8FY/4P4WpbciGKeaM8Q59qBcduIcgMVLh1gQLDxkpojTMt5UikBu4zFZDQVyeoBMUPsZh7b+6ZCFBQJ3/9AMS2F5GpcCwBHJGpvJTXdMHzPCIPd2UQ==
X-Forefront-Antispam-Report: CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(70586007)(54906003)(4326008)(70206006)(81166007)(107886003)(6916009)(8676002)(336012)(47076005)(2616005)(82310400005)(16526019)(186003)(36860700001)(956004)(356005)(82960400001)(40460700003)(36756003)(83380400001)(6666004)(8936002)(1076003)(508600001)(316002)(5660300002)(26005)(86362001)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 08:37:03.4052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a434ec37-4ade-4c53-c2aa-08da34bbc167
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT039.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5792
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
 drivers/watchdog/Kconfig           |  1 +
 drivers/watchdog/simatic-ipc-wdt.c | 15 ++++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index a7cd3ef5b3d8..0097fbb455ab 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1639,6 +1639,7 @@ config SIEMENS_SIMATIC_IPC_WDT
 	tristate "Siemens Simatic IPC Watchdog"
 	depends on SIEMENS_SIMATIC_IPC
 	select WATCHDOG_CORE
+	select P2SB
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
-- 
2.35.1

