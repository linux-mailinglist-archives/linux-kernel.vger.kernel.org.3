Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE51471BFD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhLLSGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:06:45 -0500
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com ([40.107.94.84]:40463
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230468AbhLLSGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:06:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKCCdywSRCh+Cxc9KG4abZmap5T+uLtxFacGCF+ZHegmdmtjqgPDbeD7Tepc6p/SxCE4FJDQhqSk7yt34hUXBqhPwIFscZKisUUvsno4Tb4xSxVIV/OHvW23Srn4JNUpXlDcjMzL4hS+vCYtPXJhI/L9dKnHkT1zwZd30k9Co9uXNIfR41WlFNIAgfvliZw5TP6TxBP4W0cU1l1llRu8Osbb188O/P8FDviRc/WDx2opVagtQvaGfCjE4Q6r9kUuZk7LcQxsjD5TvIfNAAgufGsbh8QxXTaVsu4wkxAyBQmRx7P0tMq2U4L51Z8pXG52a/XfTN6NpKnMsgi/i45S9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWq6klXQhrGE/ZzPxVIc7MNkVPPUeivvtAty96eHqhM=;
 b=jg4WzBUtIda11sEOzH6d33GXK1tllGrQGfdv7eWa+6xwvLd0rJtqbD6AZDI343KLvnxmW0Pig/RjCXyF7fB/mmvEkGvjT7BPDQmRJJFW0mggs2BUpWNtb8Ym+Si4Yxd5ScVcUustfqpwmjGA6OwUY4zLC7GMR4HK8ikBz1SQByoHllCOCYl1SnqNCvjEQlO3jpqEV+VBLtZGV9fwBTgQfHOPYseVQwJOlq4l4VYGVKhNm56Fg9gijDLFJ/LKv+Nxb13C+Q9J+5eFEWbsyy0C+P2YmAc4E8MCVkiJNQWSL9wbRD/yQNhzz1r2qUIC1gEGVirwO+O6yXxItHRKBTo5DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWq6klXQhrGE/ZzPxVIc7MNkVPPUeivvtAty96eHqhM=;
 b=3gPkZoGckFE3YT4B7ix2AOCrsjahSo8sg7fCEuqsFnV1vnH5RYkXtAVdiGtoNKBSV5vneo602QEdU0sdgKEcjg3pRFm8k5JfK9HOKWfphoV8XMrl/rQKwmdODz5G0eRTbenz3VVP0X66eFnfcBMT3j0Z5AqRCeXAxfPqaiz3dEU=
Received: from BN0PR04CA0141.namprd04.prod.outlook.com (2603:10b6:408:ed::26)
 by MW2PR12MB2444.namprd12.prod.outlook.com (2603:10b6:907:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Sun, 12 Dec
 2021 18:06:40 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::d) by BN0PR04CA0141.outlook.office365.com
 (2603:10b6:408:ed::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Sun, 12 Dec 2021 18:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.16 via Frontend Transport; Sun, 12 Dec 2021 18:06:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 12:06:39 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 12:06:38 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Sun, 12 Dec 2021 12:06:36 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/5] x86: clk: clk-fch: Add support for newer family of AMD's SOC
Date:   Sun, 12 Dec 2021 23:35:23 +0530
Message-ID: <20211212180527.1641362-2-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211212180527.1641362-1-AjitKumar.Pandey@amd.com>
References: <20211212180527.1641362-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3656d841-b748-4f94-c93e-08d9bd9a252d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2444:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2444B47E98E4A6498BC0444182739@MW2PR12MB2444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXJJvJ9tsIWWWSCNnBzpMSQLZkfxkg2Cgid9HGKBVcn+w2davqsliotRFZh7Tl2AwtdN/3SGtNOlwwxazPn6v9/h8Vqe0iyt6kY75TXSfnManshj1z7qE1EjF1XeVpB+nMYqgYj7UrHG2O1nAgafeefyjbXcKqjycNpgeH5hgm6DU/EwwMc1SCKmodEgbxhu+UlnNhUSAf+w6LIGSeLSY4y7DAVsE/KFMoCqlpBPVjV+prv9vfS5Q9NZu8/VhIwtLhAAefl3w5ZlVcA9ftIoVsLIG3jyTiWYFylYqxo2rPw5o9Eb8G32p98lWf//V1IksK7WqewzykK1oE56XSRnBuL14cb+Ti1axVcXZXEkyoDfOdNPXBK8Wlbqa+g6xkWJk/r0t9WBt/4vNcYStfqSVNtO8mtUJX6+ECaa0qvJl1V4rlH1cIevTYxOhMIpnJCVm8K+PTGVRxNu7UHq6DUtzEEJIy+8xokyhZcsjCsax1ed6YsfZl/Krt9p4ZANd+HWMqRag1u0JMY5Uv8z7MIgwGtloqYLkjOSSSKjO9DtcF2BBugSXS1rclu2qyY78+xivZrVE0ftgyPewUrnzMBdrZ/dP5g98vvmvlBQeVrV6OT1kMocN+RgRwAoQZPhOFpUonCMaZvRIWDNJdQrFPBUCrYz4qwX77is5Gmkckd28j9Z/Np28AN077EQxh3Smu6eQ/U5ksKIks7ZRf0S/V3ICx9kIMS2gznaa4KApyEETOoJgpIa359/sITulx7+UYXqvmVdrGUDM5nkDWeQOGFy83JETpGC7adSLil4mCq6KzE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(4326008)(508600001)(5660300002)(86362001)(40460700001)(7696005)(36860700001)(82310400004)(110136005)(426003)(356005)(83380400001)(54906003)(70206006)(186003)(26005)(36756003)(81166007)(6666004)(8936002)(47076005)(2906002)(336012)(316002)(8676002)(70586007)(2616005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2021 18:06:39.5537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3656d841-b748-4f94-c93e-08d9bd9a252d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2444
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FCH controller clock configuration slightly differs across AMD's
SOC architectures. Newer family of SOC only support a 48MHz fix
clock while stoney SOC family has a clk_mux to choose 48MHz and
25 MHz clk. At present fixed clk support is only enabled for RV
architecture using "is-rv" device property initialized from boot
loader. This limit 48MHz fixed clock gate support to RV platform
unless we add similar device property in boot loader for other
architectures.

Add pci_device_id table with Stoney platform id and replace "is-rv"
device property check with pci id match to add clk mux support with
25MHz and 48MHz clk support based on clk mux selection. This enable
48Mhz fixed fch clock support by default on all newer SOC's except
stoney. Also replace RV with FIXED as a generic naming conventions
across all platforms and changed module description.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
---
 drivers/clk/x86/clk-fch.c | 42 +++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index 8f7c5142b0f0..6a726420bfcb 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: MIT
 /*
- * clock framework for AMD Stoney based clocks
+ * clock framework for AMD FCH controller block
  *
  * Copyright 2018 Advanced Micro Devices, Inc.
  */
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
+#include <linux/pci.h>
 #include <linux/platform_data/clk-fch.h>
 #include <linux/platform_device.h>
 
@@ -26,22 +27,37 @@
 #define ST_CLK_GATE	3
 #define ST_MAX_CLKS	4
 
-#define RV_CLK_48M	0
-#define RV_CLK_GATE	1
-#define RV_MAX_CLKS	2
+#define CLK_48M_FIXED	0
+#define CLK_GATE_FIXED	1
+#define CLK_MAX_FIXED	2
+
+/* List of supported CPU ids for clk mux with 25Mhz clk support */
+#define AMD_CPU_ID_ST                  0x1576
 
 static const char * const clk_oscout1_parents[] = { "clk48MHz", "clk25MHz" };
 static struct clk_hw *hws[ST_MAX_CLKS];
 
+static const struct pci_device_id fch_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_ST) },
+	{ }
+};
+
 static int fch_clk_probe(struct platform_device *pdev)
 {
 	struct fch_clk_data *fch_data;
+	struct pci_dev *rdev;
 
 	fch_data = dev_get_platdata(&pdev->dev);
 	if (!fch_data || !fch_data->base)
 		return -EINVAL;
 
-	if (!fch_data->is_rv) {
+	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+	if (!rdev) {
+		dev_err(&pdev->dev, "FCH device not found\n");
+		return -ENODEV;
+	}
+
+	if (pci_match_id(fch_pci_ids, rdev)) {
 		hws[ST_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
 			NULL, 0, 48000000);
 		hws[ST_CLK_25M] = clk_hw_register_fixed_rate(NULL, "clk25MHz",
@@ -61,32 +77,36 @@ static int fch_clk_probe(struct platform_device *pdev)
 		devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE],
 			"oscout1", NULL);
 	} else {
-		hws[RV_CLK_48M] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
+		hws[CLK_48M_FIXED] = clk_hw_register_fixed_rate(NULL, "clk48MHz",
 			NULL, 0, 48000000);
 
-		hws[RV_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1",
+		hws[CLK_GATE_FIXED] = clk_hw_register_gate(NULL, "oscout1",
 			"clk48MHz", 0, fch_data->base + MISCCLKCNTL1,
 			OSCCLKENB, CLK_GATE_SET_TO_DISABLE, NULL);
 
-		devm_clk_hw_register_clkdev(&pdev->dev, hws[RV_CLK_GATE],
+		devm_clk_hw_register_clkdev(&pdev->dev, hws[CLK_GATE_FIXED],
 			"oscout1", NULL);
 	}
 
+	pci_dev_put(rdev);
 	return 0;
 }
 
 static int fch_clk_remove(struct platform_device *pdev)
 {
 	int i, clks;
-	struct fch_clk_data *fch_data;
+	struct pci_dev *rdev;
 
-	fch_data = dev_get_platdata(&pdev->dev);
+	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+	if (!rdev)
+		return -ENODEV;
 
-	clks = fch_data->is_rv ? RV_MAX_CLKS : ST_MAX_CLKS;
+	clks = pci_match_id(fch_pci_ids, rdev) ? CLK_MAX_FIXED : ST_MAX_CLKS;
 
 	for (i = 0; i < clks; i++)
 		clk_hw_unregister(hws[i]);
 
+	pci_dev_put(rdev);
 	return 0;
 }
 
-- 
2.25.1

