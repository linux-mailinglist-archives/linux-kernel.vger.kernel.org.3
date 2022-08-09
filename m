Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1662458DD52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244949AbiHIRiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245171AbiHIRhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:37:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA7725C44;
        Tue,  9 Aug 2022 10:37:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PR1GgLLBqEtPwuPdIU1pf/Cvy/4gFfKGBgE5z7O7XcraN7oB+uSiKdeMgMmzWQp7sDYJeNjLZrzD+1eUzgYVggtR/XjNaJivQVDdg29NZfevVvbxs8PBgmJ+h1anLvZyOeyWUx5WAtrSXF20Z2cIEJ4fTGaeX/nPgXwVQSj8msoS+V4JBwRjmFcm/41ROtFbTHMqUzVO50clu7mxNfHGOXhPnaOQuutLlKDPYO0YHm+6IhOghTXPCD2kZJl6AvnhWXCgvd3IdgstkGDZgNCJow7/M8O6xNjsl0+AVxEkuAZ2Ag7ByQeFkUrD0VQSnBIksK8qVK2wr9A7XFSXU6gR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzJRFMG/I3e/ij1SDpeRLB4+GX90SrNyO1YYpWiN3fk=;
 b=T8sFdjy7eRvtAD+S3DUmjvyWUhkqEhOEKpRrizmZXLzQEVozu3MALsPYQOGL91xV2fKtO0+6QuJavnsdyyBko4DjHjc+XjUIfUjuICWgJJyDF11N+IMZ6jaw4bSllYbWqlZzSihAb4iAXz0tW0whX/xjXxIpaIbKdb/Gsf82V2HBZW09x9nsSXlJ22aKmHCG04m+sAF0SN3kOOhuBU+aAWCPufCtnDwwZfxo5f/oMqX+70l5XHvRbx7SRFiTMOzUq3ZjiUeXPR7YT2bGl+ZpZPTcqVoE6hCsJ3OUDHfuF7l73B9V1SwSs66O8wFgW96BNJ/kBsERd1yZDB4rwnH2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzJRFMG/I3e/ij1SDpeRLB4+GX90SrNyO1YYpWiN3fk=;
 b=ks4LwVa7OHkjcmRgRMBTS3i1QuvNEAv6Zz5uMRah6JXZdWg9N9GxjJg8Ohnmqutu+jc8bmzhPC92lUDFJAyy94YbCvLPQS+vOLrI7X2dz8O3wuydMrUMPwsyiD/w5VBcpHx2gbxXsE9FuKfZ0SWPO9eq+Z5PLvmfaQG6dsXHdz5+CE9eAuE1hi9UxOjoGivxiw5zT9J/irr3qIkidyssp0rFjvzxmxBekNJgwlS91ATHRqj44NUwk/CtLz1V1Mr9zZmls5zWsg1JwX3UKZvTSooUBuXLWPTd14+ObM0f6k4Fc9KwIxOlGjb4k+FwL1niUEBCCrREsKCPvsiEkapiMA==
Received: from MW4PR04CA0034.namprd04.prod.outlook.com (2603:10b6:303:6a::9)
 by DM6PR12MB3195.namprd12.prod.outlook.com (2603:10b6:5:183::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 9 Aug
 2022 17:37:51 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::7a) by MW4PR04CA0034.outlook.office365.com
 (2603:10b6:303:6a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20 via Frontend
 Transport; Tue, 9 Aug 2022 17:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 17:37:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 9 Aug
 2022 17:37:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 9 Aug 2022
 10:37:49 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.26 via Frontend Transport; Tue, 9 Aug
 2022 10:37:48 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Woods <davwoods@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] mmc: sdhci-of-dwcmshc: add ACPI match data for BlueField-3 SoC
Date:   Tue, 9 Aug 2022 13:37:42 -0400
Message-ID: <20220809173742.178440-1-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <3a50873fdbf69f4a95b931a5d05cade04c1dacd0.1659099154.git.limings@nvidia.com>
References: <3a50873fdbf69f4a95b931a5d05cade04c1dacd0.1659099154.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ec609a5-908c-48e4-0ead-08da7a2de1e3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3195:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTANLFlib9vOpbbI4GnQxdM4eexQE0IbPSk2fOQnUT5sVcHQfh9K++QpcO6AWvoFd5FvP1prZ6FKUZdQHi7eh7xpYXOaRg8UhES89ljblZV3gMEY3wvZUJ9uXYiTJj8HO6UHDAA/bRuidp839HTqSrRoClMDsy0ha+9YzIg0kCO3RljzBoFifBH3lT/+CcaQD5cOn30nwvmXAWcfFskmW6ENPUMyEau5Sf7jaTFkaDFxDaV+6MyAhHbB5PFFU3NzotkAyTy49KLw4xJ3ZSsKBTGrBRaK4Dc7NHvSF7CWUM0ci5W2lzlNl73vs7kMmEOHhZXL40MuFXfNWcspur8q7pNbzPaII9XeDKC87f8nxFNVOg1JXwaDtg6ElCinqI7k42sMjZn7x7yv7GW+dswUXFy/LnOnRVBOoJn7gfQ//LrlsAAXkosAT9PH7sAwpZkf4bcQarJtLSSnbFSfL7gCYaUeE4irHA3n1iAen7wmUN6KLSs5uELHUpsC/PszKrDs6ik//CU0/qc/bFnD9wyr+f+zIZJScqDjptmqtTZjaaX95WnD/KGO5IqKIg8ukMDFaWUXyTZl809mWZlZgN8k5hHRxl+2M8hEh7X/2rSclXPWrGMet2t9hMpALatiFU1aSLGqVvhvhYEL24911kNltMOzNQV/qZpnjWsFI2B3zlbgAnqRzA+zV09K3tjjmyqgWaDepXqRWOcKQ5i/qq2uFyJQz6uwXeL3fY+AFNvBiNkrHJHbnxpGQkjR7xeL5h7HMJ2Gc4V8IU3gzfG03/vt3UWMfqDVO/ArgmRe8GcABFvMnUsLeLAq6V3fYV5WCDsJWf/PrSoiuvDbUSPViKvE/LBkYoyU3KG9kemAA9GsQYB5guW0JLRTm64FJ0K6DRVz
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(40470700004)(36840700001)(81166007)(356005)(82740400003)(186003)(2616005)(1076003)(426003)(336012)(26005)(47076005)(6666004)(41300700001)(7696005)(110136005)(82310400005)(40480700001)(478600001)(86362001)(36756003)(40460700003)(4326008)(316002)(5660300002)(70206006)(8676002)(54906003)(36860700001)(2906002)(83380400001)(70586007)(8936002)(133343001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 17:37:50.7123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec609a5-908c-48e4-0ead-08da7a2de1e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3195
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
v2->v3:
    Rebase to mmc next
v1->v2:
    Fixes an acpi warning
    Reported-by: kernel test robot <lkp@intel.com>
v1: Initial version.
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 4e904850973c..a7343d4bc50e 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -349,6 +349,15 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
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
 static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
 	.ops = &sdhci_dwcmshc_rk35xx_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
@@ -431,7 +440,10 @@ MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
 
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
@@ -447,7 +459,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	int err;
 	u32 extra;
 
-	pltfm_data = of_device_get_match_data(&pdev->dev);
+	pltfm_data = device_get_match_data(&pdev->dev);
 	if (!pltfm_data) {
 		dev_err(&pdev->dev, "Error: No device match data found\n");
 		return -ENODEV;
-- 
2.30.1

