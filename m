Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851B35850AF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbiG2NRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbiG2NR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:17:29 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D82558F6;
        Fri, 29 Jul 2022 06:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0EqnTfz/+71fyDd6q/OME+BIF3cKZtDKWHJj2MOkC+VinS3HWAZB7JLGmbYFxx9Y3Qa6ltu7QwrXeYruJnmDe+cunPQ5JBpJpWciwwqF36Nnq6Fo70mbPun+9IzqBqxkJJGHGTMNxZcBZQ57MFzip3nIi9QL0r0NB1Co0Os08uqGETrCew3Yk07b11f43ttzMoFsd5KeyS96nG8ubrFKsej/bj8iWRmuTp+kKV8zu5a1gTEhtqCtmYnx/c+hpa2tbGAb9bJSnKMmUPrsqAKRQc1CDc/EP11kpB4JE9qpX6hlcz7DSnet8qGjtCkHLbT+FGNiXm1ooJ7ZrEML46C/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S5yubiK5HPrgX0ibgZQ4NY/PTvphXHysnRU6EnDXXk=;
 b=KF5oBB/fcMIf+cbbfum10dUda1bxjd6EdAOff5PMHwZB6CYZg/wzoHohQc1Fb79u1VK94KNZ2UX+xJM1MnUrrBFO2TxMAHLB4FEuw4ardVmUco5WbKCwTjCtEp7UkAVw11VczmUmzCMzW+yFvj9FUQuPu0WNKLPNPLJHquh7bgNIJleLDZZE2kpZCvpnkcxs+1i03tiK+9kNQ346W8h9qdhtFHARh4QldOWH/WrpC0oEpS9ZOuW/JN2BeRgtB0oro4uyB9j/OKHHbLoUvBI1KdzNiUK8r7Vbkk6pjgy1uOz+VsxpjF1WySYHCfeGWSQTc93vO1IovIrwymUi3TzwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S5yubiK5HPrgX0ibgZQ4NY/PTvphXHysnRU6EnDXXk=;
 b=fVqa9j0+hmLL0THPW0tYdyN7QH6xPhP/HvmYlxsnGDokvb+6UhQcnoZWs4CxVxGGdu177kNqChkWej0fBkZYp+DnL6dtsfi/kvLtTFBJ10HVRt38POBne8j86nWSB2MXQbdWExutiy8u50mn9zEf1FQHVj79sAXQiNC+T/s4dRfFhBL0mTyssRSmGwTgNPS6FuLHa2P595jdhnReF3o9AAiy+dddFN48hNlPYgiwGRtRJdxWAD4SQv+5TN9s6xO7xvltsDyvv5W6lPYiU0bipXwT2+DH5lfePPXQx7QlQUAsNnmFLsgeDLDgoc2XN62SAIijBSKkSvSp91Yvv5JroA==
Received: from MW4PR04CA0034.namprd04.prod.outlook.com (2603:10b6:303:6a::9)
 by CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Fri, 29 Jul
 2022 13:17:26 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::eb) by MW4PR04CA0034.outlook.office365.com
 (2603:10b6:303:6a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23 via Frontend
 Transport; Fri, 29 Jul 2022 13:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 13:17:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 29 Jul
 2022 13:17:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 29 Jul
 2022 06:17:25 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.26 via Frontend Transport; Fri, 29 Jul
 2022 06:17:24 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Woods <davwoods@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: add ACPI match data for BlueField-3 SoC
Date:   Fri, 29 Jul 2022 09:17:14 -0400
Message-ID: <3a50873fdbf69f4a95b931a5d05cade04c1dacd0.1659099154.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7c22738-e4f1-4043-d708-08da7164ae9c
X-MS-TrafficTypeDiagnostic: CY5PR12MB6084:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0D64WtlxcZX8Flnbbc/SXYefLN+I5IpEytg5iYseb8ttQVyKCt9kT3s2nDs5rr04uJhmU1ycZE0PaH7tQm30BB85FGVxluOci7euywAfiPAdat8gV9VotYvuB4igvibeScVeHpVlo7rrEa0CYjeW/HgVtZ0oXGij7EgEcmy523++zrszmwB32OliqpVbEIwvWWT7ox0Sj2IyS3Bnrzw+rABIBWoMQpWvd3AjLXejZ6GpjmFb0vyBf5eBQDIh5O3o6Jl5n+zK+mFas13WJYi3BUbj0SxJMZCEgZPfUl8XqiSBSsnzOzJPgr6fPtPOOyz5f0xn/tnHWPJgYvEJjrYVKwdiOA+mO1BWB3sjrii+delN27CMI+opgq55UcvIIan9HsD1hCbip4p008JsjNDM25ZrbTdAJzMCUo2K9LvXI6yhn4+XA8Nb5HUgKoooPzqV+gUtqmPcbZiWDAXQR1Mjp1Bud8bqjCLzBnkeGdiPAcFdIeKr7jb5KemT20CcWNMXmEaj5jd/umXcRR4ZFL2wjIQjvMJfQG4wG7gZ+8mEZrOAopQ1hiCEMMdyVnjTT1APzRp2PwSr/uHJ09yQnBD/edCYnodMATxzeL4wULiBYyvdDUu7fzOejU1d9v4AzdTlKtzFgNTtCLfWfc1CpbT+4aWV25alFVie7rYnJ2etNxqt60o4A43QJwLBbr0E3EzbkwCiAo4FOQs7/tL6bB5onTXa3JxzTHvXI3hCyRpD9WIy+dNDekPKHBTnKC+Wrt5al6GOXgGOkUGuzkzy5mliSyqhvkhKJAt/OtBgdkfc6SBMTDnhDhp7ZzS2Cgx/pHRjzEI3N+QT3txdYZuvk8DWftG5KpEyX4Yb6bzWrjpK+FDQJevxqBaj4mmPcKPjNXVT
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(36840700001)(40470700004)(2616005)(70586007)(2906002)(36756003)(47076005)(82310400005)(4326008)(70206006)(54906003)(8676002)(316002)(8936002)(86362001)(5660300002)(40460700003)(356005)(41300700001)(26005)(6666004)(426003)(186003)(336012)(83380400001)(478600001)(82740400003)(81166007)(110136005)(40480700001)(36860700001)(7696005)(133343001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 13:17:26.5435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c22738-e4f1-4043-d708-08da7164ae9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/mmc/host/sdhci-of-dwcmshc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index bac874ab0b33..173a9167a2f8 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -279,6 +279,13 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
+static const struct sdhci_pltfm_data sdhci_dwcmshc_bf3_pdata = {
+	.ops = &sdhci_dwcmshc_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_ACMD23_BROKEN,
+};
+
 static const struct sdhci_pltfm_data sdhci_dwcmshc_rk3568_pdata = {
 	.ops = &sdhci_dwcmshc_rk3568_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
@@ -336,7 +343,10 @@ MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
 
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
@@ -352,7 +362,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	int err;
 	u32 extra;
 
-	pltfm_data = of_device_get_match_data(&pdev->dev);
+	pltfm_data = device_get_match_data(&pdev->dev);
 	if (!pltfm_data) {
 		dev_err(&pdev->dev, "Error: No device match data found\n");
 		return -ENODEV;
-- 
2.30.1

