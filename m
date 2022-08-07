Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095A558BCF5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 22:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiHGU5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 16:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiHGU5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 16:57:04 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183E3657D;
        Sun,  7 Aug 2022 13:57:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jw7w8Y2v3C7k3ayVP1lvAMgsMzr5p0/HP9AzebvpQHdQfxpnYl6xX6T0x/B3J8q7G/Jxhmqmao8HZHUNPyrSulVlCDs1VY3+bacLbYBU4S/vmiCrgZQtdfNCyb0He5B2Iu0+ls7ek4QRJ5lPUBexKZCcs7JwsxMgRMioAdvop8kWpYjEvfDpATE2VV5sL37EWXz02fLJQ6SXqw4WUB8+k3wP1SoEXmSUXfRdC0/LK0ra/RnMXyW1ly8xgf/ByUAsqkCeL5qWfYJmlgKN5U5WnIe94jSU1uT4zo/myme/gy6yffITPXh+Rrrhq7k0SMjKxGsligupg5D4S5qlEBQF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qF33V4t36Pcyjw2xSuKm41nklYu2TZP7Wz4vgPrH1Gk=;
 b=VsRoYsovTTetwLfbFXJNsHY6Ds/4gXWm80GZd34n1mdIcMkCCqmVC9TTXbPBXsL5QGv3pH6Lyrx6AJ59tAJImHP+Z1hozdDIEeK5SePVd7nxOOZNkVaYjydJ7PguQreemnkfH6NtzcEhdFyqcJUz249GiK6BiQ68soXoCu5WjysvbDzZ1uQk+tBoVX0jB7cs9b12dSTY8bC9K3N+O/WIvtPfi8uvhmClGWTAW61ASqyXMlz21IlH3kS4AvnY09foVNkZOwfF3TEBwxzIOeTWUQuBqWup1HZ5oTyO33EGAuDx4QcAAuqu9xUX4M81RoTf1OJKnK+qflxQuKLuoc+ZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qF33V4t36Pcyjw2xSuKm41nklYu2TZP7Wz4vgPrH1Gk=;
 b=tdawFQoB8KG4cIG1WmRwsv2TzHYKcpI2N6rLtvL+hxqp2NicAevAs/oyGaNJOsRbbG2SqMrka7UzwszQ9/MxRNvHuQki9mblBuKdS1WjF/q5ax9p73MB1Q64lXVzTXLwACXT55qySKcxh3vIO4TIqTwnzptna11CCW1aLYMx/bMqd0NBK5Tgr1jt+GC3PCnig01SScZIpINW8S/Y+cgY5fC889h66XLxUPbbzcdUt6Oh8UD41Ia9zKho8B79dDeh484bph9dhQqgrTxoTnf0xHhqHRwLW9ut9RiCmxNQqsmOhJBkuMHQIheoN+pAzoJroNuyE4rlvyScDz0JP6HXLA==
Received: from BN0PR04CA0120.namprd04.prod.outlook.com (2603:10b6:408:ec::35)
 by BYAPR12MB3542.namprd12.prod.outlook.com (2603:10b6:a03:135::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Sun, 7 Aug
 2022 20:56:58 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::bc) by BN0PR04CA0120.outlook.office365.com
 (2603:10b6:408:ec::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15 via Frontend
 Transport; Sun, 7 Aug 2022 20:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5504.14 via Frontend Transport; Sun, 7 Aug 2022 20:56:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Sun, 7 Aug
 2022 20:56:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 7 Aug 2022
 13:56:39 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.26 via Frontend Transport; Sun, 7 Aug
 2022 13:56:38 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Woods <davwoods@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mmc: sdhci-of-dwcmshc: add ACPI match data for BlueField-3 SoC
Date:   Sun, 7 Aug 2022 16:56:30 -0400
Message-ID: <20220807205630.251939-1-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <3a50873fdbf69f4a95b931a5d05cade04c1dacd0.1659099154.git.limings@nvidia.com>
References: <3a50873fdbf69f4a95b931a5d05cade04c1dacd0.1659099154.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1053d98-e3e6-47d4-e5d3-08da78b75dab
X-MS-TrafficTypeDiagnostic: BYAPR12MB3542:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKSJF2/sdQVDA15rWO6eawkPtngWesWjlgzjD6z0MvEMu8Fqnc7ZKaVqVjOIq2QUdoWjb9+o6CIgBvJfg6gLqcq49fG+zvbZA2qYVzACQj9V00v+jXJ5uXH5oZGSz8AmSzcp3EPn5Av4DVTRfZUJiVjrClUYne2PYzDzUceTdbeDr6Arhtj/5CBTmvvGyKGl6QwSP/SzQ6xgEnsGiktFmFyO2zDgZI5CmlsDCSPre7kgEDjRPraoTnpgTAnMzqmLx4no35/Rot4HHju9jmXMc9/zMy1/l+vgmSoNzShTrDXXgDSTTOhujn6EwDNiglJkJ6pPOJhEXfzTSiYfmFVW+Zt3Bnopjwf+M6l0RT+Ll4ZkJn++6rCUB9YVI8Zc8KKvMyP8ANUND2HrJ9nJG81h1f0L3h15gq2E1cUomJmSsddFDsajFHvfIegFAFcgTgTlurpUebB134/0/l5f7g9LGkds+nDoPXjhw5dQ+tQBX0KHsdNJOouA9b0n5pxJzvBS4YjJKwG1yEnBAgW98y3rSV/Pn3xO+ZZrHQ1qo6ERbT4qI8pBMmNDqP4fe/iBdzL8i1uKY0e3JpYcPyfOdgj6/07zgBLBL7i2cb+QMFmsDnKCGJqZEXbVnA0GX/7FNApDvVV+aYx/mE8KOXy4uHi7Okoakl6VE4tjzlR6MIlAHJKRidRjh90+x7lJ6ZHfdB0EXEt7HLveAASFvub+mvGXbOnNiYDHwo9NLoBXYNz8JBAjrC/GYCZl3R5gQ5Jr6WqVsMUpNTbRJgNhBZaQwKcA22rGNdSn4EzaVAr10pQZsLDkreVfRTjBNzMuCjyEmI3C1SiPLlHYb2R4Tb1IFd9I98Jb8eqInY82pqpzi4ak9CYwggvsL2iB+XwK4vPDpo4v
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966006)(36840700001)(40470700004)(2616005)(426003)(1076003)(47076005)(336012)(316002)(54906003)(2906002)(4326008)(110136005)(70586007)(70206006)(5660300002)(8936002)(186003)(8676002)(26005)(86362001)(356005)(478600001)(40480700001)(41300700001)(82740400003)(6666004)(36756003)(81166007)(7696005)(82310400005)(36860700001)(83380400001)(40460700003)(133343001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2022 20:56:57.0522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1053d98-e3e6-47d4-e5d3-08da78b75dab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3542
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 08f3dff799d43 introduces the of_device_get_match_data()
checking for some chip but breaks the BlueField-3 firmware which
uses ACPI instead. This commit adds the ACPI match data and
quirks/quirks2 to re-enable the support of BlueField-3 SoC.

Reviewed-by: David Woods <davwoods@nvidia.com>
Signed-off-by: Liming Sun <limings@nvidia.com>
---
v1->v2:
    Fixes an acpi warning
    Reported-by: kernel test robot <lkp@intel.com>
v1: Initial version.
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index bac874ab0b33..a0c73ddaaaa4 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -279,6 +279,15 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
+#ifdef CONFIG_ACPI
+static const struct sdhci_pltfm_data sdhci_dwcmshc_bf3_pdata = {
+	.ops = &sdhci_dwcmshc_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_ACMD23_BROKEN,
+};
+#endif
+
 static const struct sdhci_pltfm_data sdhci_dwcmshc_rk3568_pdata = {
 	.ops = &sdhci_dwcmshc_rk3568_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
@@ -336,7 +345,10 @@ MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id sdhci_dwcmshc_acpi_ids[] = {
-	{ .id = "MLNXBF30" },
+	{
+		.id = "MLNXBF30",
+		.driver_data = (kernel_ulong_t)&sdhci_dwcmshc_bf3_pdata,
+	},
 	{}
 };
 #endif
@@ -352,7 +364,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	int err;
 	u32 extra;
 
-	pltfm_data = of_device_get_match_data(&pdev->dev);
+	pltfm_data = device_get_match_data(&pdev->dev);
 	if (!pltfm_data) {
 		dev_err(&pdev->dev, "Error: No device match data found\n");
 		return -ENODEV;
-- 
2.30.1

