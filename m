Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A61B472BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbhLMMFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:05:21 -0500
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:35308
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231585AbhLMMFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:05:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktEu+kj3OM22b99O2mgZ8WV3rL8Z/olQhF3mxtzSEUQtLlfBYvLNyq5raGx/5PywGCMyWx8JPphae0RUiRsMVkL+tD0hK5ZDxJgm3ef8Qu8NJTCYWLKI/st5g9oKepy/SrrIEue1TWxwdVwa/CY+AnGnHx0t4pLGN3aIWtPvq47BlxpEhKnJrKpfrgRjNc0jiLnn7Sn79D7VnW83C5/+KRBtciBxGDvG6B8kd4GKMO3aJJMVed3aGE/geF8irNskkIdEJcxFb7w5DN0LvcnLTxSGLh4329JEnBJOwYfakXdbmYViUU9blXAqUGis/ACtN1tXjNNmU4J7uQqGrokauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MMImjCflvRWW0qQ8q9+2d2EpYqtxf/o51w1lYHVRW0=;
 b=bTEMiZzFKhVRq7cq+goYaQDBmVSUPWTDGqCt4FBngXsKSDPLj3DfCmHLiczCQEk1ZqXB4s/s/OTypnm8tRWTXjEjXdn+7Vm/aursr4gh67uZ53ouRaH//j1pdj/zvhkz3wEu3UTAIun7uBxJNTUZidM+YaCWwdZ0YdjnPaepbcp3mXptQV7t8wP+OV5X6Cyr+B9ZS+KG7ET6vioinoFUP76yE0mhuE98L2gw6yHjBLCvP8dHHHgGgpHIcO2WEPk9af0nFk6EIxXAApbCpCkEIgTAEs4DbAQvIpFMHvuHiORvtYAuR6Pn53Tcm0v8S8R0MWUHv4bhHTlGmR3h/e5mGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MMImjCflvRWW0qQ8q9+2d2EpYqtxf/o51w1lYHVRW0=;
 b=Y++kqUBXQVSPlFpR73RUbWWGfTXAqN//DzuMSpOXtrwQ67GzSf5KVZBcKLDqYmA0KPJOb9eIVVznw9ep625aDrYJnRcK7yYs6fPVCwGzvOh9EFf9uwh73os/u+HntfkCnOK+FGPRfo47QTQ/rQE/p2oRL5yTDl4MRiOBqmudIFVZDrfkCElEoKvj38BfWfLkl7h0A61+Y+9hQ0oddD3c8sbzqdux40R3RE53G5y/tIr/WcvvLLdF1nzNHx46dmwjuaWY7jDKjc/nj4Im4bvAxYTpKz7bjiOcKnoTWi6MDGBUM/3E/W+ZcVrBorNndGWr7e/76ZAKybSO9BuGW4tY1Q==
Received: from DB6PR0501CA0046.eurprd05.prod.outlook.com (2603:10a6:4:67::32)
 by DB9PR10MB5233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 12:05:14 +0000
Received: from DB5EUR01FT043.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:67:cafe::44) by DB6PR0501CA0046.outlook.office365.com
 (2603:10a6:4:67::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Mon, 13 Dec 2021 12:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT043.mail.protection.outlook.com (10.152.5.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Mon, 13 Dec 2021 12:05:14 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 13:05:13 +0100
Received: from md1za8fc.ad001.siemens.net (139.25.69.80) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 13:05:13 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>
CC:     Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Henning Schild <henning.schild@siemens.com>,
        "Gerd Haeussler" <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Weigelt <lkml@metux.net>,
        Michael Haener <michael.haener@siemens.com>
Subject: [PATCH v5 4/4] platform/x86: pmc_atom: improve critclk_systems matching for Siemens PCs
Date:   Mon, 13 Dec 2021 13:05:02 +0100
Message-ID: <20211213120502.20661-5-henning.schild@siemens.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211213120502.20661-1-henning.schild@siemens.com>
References: <20211213120502.20661-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.80]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4888c9a-a9be-4f8a-abd6-08d9be30d22c
X-MS-TrafficTypeDiagnostic: DB9PR10MB5233:EE_
X-Microsoft-Antispam-PRVS: <DB9PR10MB5233A8AA849D60CDF0DFB98E85749@DB9PR10MB5233.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qHF/x6fU4nE70XGgTCEhuMldbUPpESJ/rVhSkaiqrshejM3fJwBWjZmB2cBjkm2YrEaTynSAa2FUdqJsKidjVXyfCcYRzrQDednOtO0Ux4hj4tuuo33jaQcIVTgg3tWWgZELVxzalovbyjfvBT/NQ3wii1sj9Dx9jBgWEShT1eq3etOD1H04LD4VfRrHZEbe0SDORtbcaVsR/zg6jQmzAnUYNQVVmELU6a8mnnSmk9j7A7RvXybqbkNl9KFv3LV2SHViOci4/30JXcZ9JV4Z1z4dVoCUrXzJQMDkOPEeu4NtErr78bmEoBTSD3dExtpPDCEEpO4uRcRAqAK2m01e6gNe3pax+QIZzKMgf7CDQ6RxFc8+n00/pHFMcJyX5QizFgRet0HG3EvcfbjqCvPli+S06YPdtt48lcSvZLYJA2Z+BScy1dQqIH/lLxs3iOoT1UBpR8DD7p8dxRsqd6+NkKpPCh4Hhqbppznjg0yoN8IR1oxZzjo2o/olIMEbhFErfy4dlJCeeEHVt0HOj1Ag6v985Ghe8b2oUi+X+lXuv9oQLh7J9u2BHP5WuOHZNrcICmedoygyqRevgjcrWNZcdYx7o5W7rwF4xFnwZ5LPKDZe6sIjHmV9IhaUOPDrZePUs1PMQ5DXpFGjObAHiXPlS8Cna3DWlsgBslgOSl3D/E+YpAd7lsUC+9E8Phlys/TrkWExmrfRQGRiG2BswORkR/kHsuvqYnjucxX3Qo2LAPw=
X-Forefront-Antispam-Report: CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(1076003)(36756003)(26005)(316002)(82960400001)(8676002)(336012)(956004)(186003)(508600001)(8936002)(16526019)(4326008)(54906003)(107886003)(44832011)(6666004)(70586007)(82310400004)(70206006)(110136005)(81166007)(5660300002)(47076005)(2616005)(36860700001)(7416002)(86362001)(2906002)(83380400001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 12:05:14.2782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4888c9a-a9be-4f8a-abd6-08d9be30d22c
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT043.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5233
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Siemens industrial PCs unfortunately can not always be properly
identified the way we used to. An earlier commit introduced code that
allows proper identification without looking at DMI strings that could
differ based on product branding.
Switch over to that proper way and revert commits that used to collect
the machines based on unstable strings.

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Fixes: e8796c6c69d1 ("platform/x86: pmc_atom: Add Siemens CONNECT ...")
Fixes: f110d252ae79 ("platform/x86: pmc_atom: Add Siemens SIMATIC ...")
Fixes: ad0d315b4d4e ("platform/x86: pmc_atom: Add Siemens SIMATIC ...")
Tested-by: Michael Haener <michael.haener@siemens.com>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/pmc_atom.c | 54 ++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index a9d2a4b98e57..a40fae6edc84 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/platform_data/x86/clk-pmc-atom.h>
 #include <linux/platform_data/x86/pmc_atom.h>
+#include <linux/platform_data/x86/simatic-ipc.h>
 #include <linux/platform_device.h>
 #include <linux/pci.h>
 #include <linux/seq_file.h>
@@ -362,6 +363,30 @@ static void pmc_dbgfs_register(struct pmc_dev *pmc)
 }
 #endif /* CONFIG_DEBUG_FS */
 
+static bool pmc_clk_is_critical = true;
+
+static int dmi_callback(const struct dmi_system_id *d)
+{
+	pr_info("%s critclks quirk enabled\n", d->ident);
+
+	return 1;
+}
+
+static int dmi_callback_siemens(const struct dmi_system_id *d)
+{
+	u32 st_id;
+
+	if (dmi_walk(simatic_ipc_find_dmi_entry_helper, &st_id))
+		goto out;
+
+	if (st_id == SIMATIC_IPC_IPC227E || st_id == SIMATIC_IPC_IPC277E)
+		return dmi_callback(d);
+
+out:
+	pmc_clk_is_critical = false;
+	return 1;
+}
+
 /*
  * Some systems need one or more of their pmc_plt_clks to be
  * marked as critical.
@@ -370,6 +395,7 @@ static const struct dmi_system_id critclk_systems[] = {
 	{
 		/* pmc_plt_clk0 is used for an external HSIC USB HUB */
 		.ident = "MPL CEC1x",
+		.callback = dmi_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "MPL AG"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "CEC10 Family"),
@@ -378,6 +404,7 @@ static const struct dmi_system_id critclk_systems[] = {
 	{
 		/* pmc_plt_clk0 - 3 are used for the 4 ethernet controllers */
 		.ident = "Lex 3I380D",
+		.callback = dmi_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Lex BayTrail"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "3I380D"),
@@ -386,6 +413,7 @@ static const struct dmi_system_id critclk_systems[] = {
 	{
 		/* pmc_plt_clk* - are used for ethernet controllers */
 		.ident = "Lex 2I385SW",
+		.callback = dmi_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Lex BayTrail"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "2I385SW"),
@@ -394,30 +422,17 @@ static const struct dmi_system_id critclk_systems[] = {
 	{
 		/* pmc_plt_clk* - are used for ethernet controllers */
 		.ident = "Beckhoff Baytrail",
+		.callback = dmi_callback,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "CBxx63"),
 		},
 	},
 	{
-		.ident = "SIMATIC IPC227E",
+		.ident = "SIEMENS AG",
+		.callback = dmi_callback_siemens,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "6ES7647-8B"),
-		},
-	},
-	{
-		.ident = "SIMATIC IPC277E",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "6AV7882-0"),
-		},
-	},
-	{
-		.ident = "CONNECT X300",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "A5E45074588"),
 		},
 	},
 
@@ -429,7 +444,6 @@ static int pmc_setup_clks(struct pci_dev *pdev, void __iomem *pmc_regmap,
 {
 	struct platform_device *clkdev;
 	struct pmc_clk_data *clk_data;
-	const struct dmi_system_id *d = dmi_first_match(critclk_systems);
 
 	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
 	if (!clk_data)
@@ -437,10 +451,8 @@ static int pmc_setup_clks(struct pci_dev *pdev, void __iomem *pmc_regmap,
 
 	clk_data->base = pmc_regmap; /* offset is added by client */
 	clk_data->clks = pmc_data->clks;
-	if (d) {
-		clk_data->critical = true;
-		pr_info("%s critclks quirk enabled\n", d->ident);
-	}
+	if (dmi_check_system(critclk_systems))
+		clk_data->critical = pmc_clk_is_critical;
 
 	clkdev = platform_device_register_data(&pdev->dev, "clk-pmc-atom",
 					       PLATFORM_DEVID_NONE,
-- 
2.32.0

