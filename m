Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893925A51C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiH2QaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiH2QaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:30:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1026E1275D;
        Mon, 29 Aug 2022 09:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbXsAQXBmn4XvZA1TelTttIXr7MhN6nzzNn/JBy3cQqq9wd2ZA9INCEAjADBQEcePw6KPN6MTiI0pLss8wUo10HauYnG6GeFY5eMDcqbPY04nqQX6zTGMzaMrUNNgCXSimXZKKDJI1diTBysqIWrdgs4A541TGG7B+t1Js7MyN54jeWChQ/n1ko5epSe/RU8tztnVTD+nEn/YPkD1DDXWpM27Ioxnxheav0pH8HtES+pPsYEPh6ajQGWfTq3jW7W12R9Rn6mWnfL3MuAHGyHpCCVlelhSngH4aoWR6fnmMhy35lvWuGllcSZCf0yddym/NvNxVfj1TrDWtZvw0FnvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfXiFbTGb1mzgC7Zy/gE2k2b7jylUR+qD4FfYjlHBVg=;
 b=XUTZg2tOM1B78d4oMwf7SB+yOJytNl9evmUAI4G+u+KTZdiE01K3XklE2wFJmaeHFNTVjW+3nQIauUcn0dWBGycBOWK7MmQVAO0CTmbCk7EZugN2aYFEbj0bsZTQPAdulRP4r0ORdPsig3ixR1brzs5j5fIbHAErRtsCDVCL34k54z+6XwTD7D/TAVMEEqwSjedXm59O84ASWEdEQTV0GZzQ5MO/FEtPVLzwpjhYY8lxZakWN00SZaHdYVockLd29CfEn7XhXQGG2iZmJnJP58o31/Jd53NHe1g/NWKSVpM3s1XMVXBcMfBv6c0c0+0SNUm17eWVpezl/sr2w33Kag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfXiFbTGb1mzgC7Zy/gE2k2b7jylUR+qD4FfYjlHBVg=;
 b=rqqPwaJDAV3YoOxO20j216rfLv3ob6AiCbpIC3eTKlA6Qs/SSclp9OdlTH6BFi63wq7HT4768aIQkHDQx8fIcGYtxp5A8lmr2vZz/PmCSHCxHoPR7N4+VgjWkoIK2OiaJKMM6EKUZz/o+QqWLO4QsZiv+ou+JDjBOaAh5g9YEr0=
Received: from MW4PR03CA0003.namprd03.prod.outlook.com (2603:10b6:303:8f::8)
 by MN2PR12MB3326.namprd12.prod.outlook.com (2603:10b6:208:cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 16:29:53 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::82) by MW4PR03CA0003.outlook.office365.com
 (2603:10b6:303:8f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Mon, 29 Aug 2022 16:29:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 16:29:53 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 11:29:50 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/4] platform/x86/amd: pmc: Add an extra STB message for checking s2idle entry
Date:   Mon, 29 Aug 2022 11:29:52 -0500
Message-ID: <20220829162953.5947-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829162953.5947-1-mario.limonciello@amd.com>
References: <20220829162953.5947-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7160cd53-f773-46b6-ad3f-08da89dbb3d8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3326:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYuLKc3KuiQukfEwsvMRFiKiMVywKb+Ik+WnKM0r56Bflp1uHIfhnHAiZnU1FBE5uFYy/9BX+dBLzrg4lf/l4pBQHMA356mDkjSFHDNdOUc+lTfirgNO3UviWsFOUBgXTRRmuXZu5h8+D0s98rM4IHILWLBb7/O8Tqit/CX9gxA8iUZ6Wp9mcAJiFbrmyhEfkmWmnc25RWIhYpeY8xzwuVRCtgvzxczDmy0G7WHQ/lgLKVsViP8pVHtuk6JvkVpDuwW3IORRLTIIUVp5v34pY9TJDWYQfwHytBFvgiYTx3BejTovD6jy3mqJcfaw9Syj+jOHgEdVwVqTDo0CJoWwR/MOHrfFUi9FmIGBIpE97IAJtUejDeGHq1o2GdvROBPbfAErnVSo7+uD2ob0Y61n+sg4SkZSuXKORULTP2QxOrPlnvO3erqMZjONY0m+gSpMelXagf70PD12YZ5dcDZSN+4TjaCyCjsFnY0CmdH+LWr98mCJ5r4Thq78X848oFt6gaqkOwKr/C1MJKTa/ALIwEeAjk+moJrN2g81gMbG880XcNfaBi9jwvaoJpTwPmion+i5Cy/jVDquUIEKQsFkyM01Ca4JA5wiERfR99HDQ3hjMndYiyLXtpZ3rCBrBujkYkpA2rahEPUISWz1+eCW58TbX74WMYEHiVVSIaaE6MTymw6Ms0bNoqCtbY58sVL5II+h4NyCtC/cMwebyFPmtVJQ76KIAb97z5gank77leDs+GSI9zBc079z7ivejZbNeT2Umt8Ri4xTKoRka/7ARDZ+waKJTIuaHEPrv6F3sMU5Pgt/BuZVmNqhcYZZQBIT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(40470700004)(46966006)(36840700001)(4326008)(82310400005)(40480700001)(36860700001)(356005)(86362001)(82740400003)(54906003)(110136005)(81166007)(8676002)(70586007)(41300700001)(478600001)(5660300002)(8936002)(40460700003)(70206006)(47076005)(16526019)(316002)(6636002)(186003)(1076003)(2616005)(83380400001)(2906002)(44832011)(7696005)(426003)(15650500001)(336012)(26005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 16:29:53.2636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7160cd53-f773-46b6-ad3f-08da89dbb3d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3326
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `check` callback is run right before the cores are put into HLT.
This will allow checking synchronization problems with other software
that writes into the STB.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Update for changes in patch 1/4.

 drivers/platform/x86/amd/pmc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index fba42036682d..32887687f888 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -41,6 +41,7 @@
 #define AMD_PMC_STB_PMI_0		0x03E30600
 #define AMD_PMC_STB_S2IDLE_PREPARE	0xC6000001
 #define AMD_PMC_STB_S2IDLE_RESTORE	0xC6000002
+#define AMD_PMC_STB_S2IDLE_CHECK	0xC6000003
 
 /* STB S2D(Spill to DRAM) has different message port offset */
 #define STB_SPILL_TO_DRAM		0xBE
@@ -706,6 +707,16 @@ static void amd_pmc_s2idle_prepare(void)
 		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
 }
 
+static void amd_pmc_s2idle_check(void)
+{
+	struct amd_pmc_dev *pdev = &pmc;
+	int rc;
+
+	rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_S2IDLE_CHECK);
+	if (rc)
+		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
+}
+
 static void amd_pmc_s2idle_restore(void)
 {
 	struct amd_pmc_dev *pdev = &pmc;
@@ -733,6 +744,7 @@ static void amd_pmc_s2idle_restore(void)
 
 static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops = {
 	.prepare = amd_pmc_s2idle_prepare,
+	.check = amd_pmc_s2idle_check,
 	.restore = amd_pmc_s2idle_restore,
 };
 #endif
-- 
2.34.1

