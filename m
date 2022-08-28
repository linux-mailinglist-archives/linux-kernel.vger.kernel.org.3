Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B5C5A3FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 00:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiH1WVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 18:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiH1WVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 18:21:33 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2073.outbound.protection.outlook.com [40.107.212.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB022285;
        Sun, 28 Aug 2022 15:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBhYOhVXykvTecvZQlgmjZlRk3xkdwvYPEa2DEDHy4MfmSBOlA3Cpkb0oySOu7ocnjmrclax9ePnsPKFfGDNcYGDfwIr1S4Rp5mQCJL5sKOPL76698/JnvnnD8kWlIp2kcApqfw+tfmCKBJxRcvzQtKXucP6c8SVpkIh0kIyiBGDG6ZHF8lhPUmJkm8BAw9RBHgAOahap7FZko9USYfILBHjDA83D8krCCNBekTliGyIO5CmGLgtH3AqhcLJlwbIhJJSeO8pV3Z6/N8hX7E/hRFXHgutOYUa1oQq74f8cOFifHJYh5zfCY9/KLB+lJfzmbflmAxD7Ez1p4FZd31lwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qi9ZUfTpmVduCRIEpa+V80hUGZgU4eRFRZeo55K2zzo=;
 b=agsGblNUGETVzV+nd3v1bo7f2V7gHakDJ8BzZ19hKoLO8JEsLBCvFwNsrszt8E2fWhvMQY0/ScEWVOKNaO1J0lU9kSWFRtHpFf5wrVmbfpn1o4rPeg56wsPd52NPmoL9SEq2W9dtTL6/9zOXUi1xk/dl7P7FpaDFDh5VlxiRf8QqZd99lQH8VqxCPS2oTSqQydDq+Eoqbv8VSAIumay9mWiAgmTxS7IQaWKCfgNIfKwW9ERxSpWBRtv6tj9Tk04EGBb+Rm3Nz5AIKDkzxx5aAhVloRLqmvfZaPlUF5kQuH0yAP078wPAMFd9deoYoDOXlWOGMEp97SH0nmg82MN4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qi9ZUfTpmVduCRIEpa+V80hUGZgU4eRFRZeo55K2zzo=;
 b=NXX9wBAldhb4Kfqcr2ht7pu56kjyPpe4N/NAG7LLZbC0afQGGUG5nML2vRxxHY/UEGI+7Yo50Q+2mTjhDgaGYtoV0M9Zzv+5+VCjzO+S0/QJ1FXEhslFSZfbRAwWBO2j49ZPhCqogsNqrUriPVrsILX6XdWQHaXh6dY9R4wW6vI=
Received: from DS7PR05CA0009.namprd05.prod.outlook.com (2603:10b6:5:3b9::14)
 by DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sun, 28 Aug
 2022 22:21:25 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::e5) by DS7PR05CA0009.outlook.office365.com
 (2603:10b6:5:3b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Sun, 28 Aug 2022 22:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sun, 28 Aug 2022 22:21:25 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 28 Aug
 2022 17:21:24 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] platform/x86/amd: pmc: Add an extra STB message for entering s2idle
Date:   Sun, 28 Aug 2022 17:21:21 -0500
Message-ID: <20220828222121.4951-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220828222121.4951-1-mario.limonciello@amd.com>
References: <20220828222121.4951-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 505c66b0-ffaa-4dc4-8c56-08da8943a561
X-MS-TrafficTypeDiagnostic: DM4PR12MB5101:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwP8BBP1FhLCzbLJCFvtG6ExQvT4Egi+VwIR4B9bKv4sCHqeJuHkXAF4ilSfXquPxPcO15onlcDd6gahuSK+CbKe5OrHIPFSpBbMclaWGFz3cYagZiuKlIxbntcxtw0CfTqG8oS6+klNPQiWD0G2z/kbozF0JC7p7SqrQ2mFWvhPsBYeZPklUMMWLR9aUEftGtJA71UuntjP2GSYem1TsCyyBosiorUuC+Tlm7ov9cVkivsiWlZtC4TAfc16A+2xFFCIFTmvmldkSXmKct91dev3hCoqj4r1E1iGmnJAxwreVWr5+fvyElE2LSs+MX1K9X1VFfbIfKgi89K67LljLnC71J8jfZU9m6ifwgNJhpmRpQo6xTqZutEd7Skf1U/FyRkmm2w8Hs6SMWA9Ro2qGupmLmjBJOf7lPzLdiTMhBP//CyB5XPppcfwk1Zzr9cxC6JR7VI/wigJj4VD0UllBLGl4Nl2YS4zday3x3M0Z9EQTcWeoTdlIIsLEIBSQ5PYuwZ91/oDMnupwsSrwfm+rClPFfmIQrbnZ3d9HxDWD85wEsg6uXxjKAzC0O+lqtBxpBleoeRqLMy6zHjWfgnWIMcFfGp4Iy8mUCVIxy7Qy4UcjTJUHx15u1Eo1/Ru9tTJZQ1Y+hLdEkZl0AMOHY4pMcxsGjVs345nosuN5DzUz5uK20VJnFcyelkBu17MDCFxtx78RnYjcYpRX8MPbRVYDR+cSTc5xa+JA/iDWSd2ofT95c2jhrVIe1X8AY5ASseJ3a32odSmxh/L6QqJog+j6sGpm+jJ30ixRr+t11KYvZrI0JGS+XJ3YL2cGNsqLYMq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(40470700004)(46966006)(36840700001)(8936002)(44832011)(8676002)(4326008)(36756003)(82310400005)(70206006)(70586007)(40460700003)(5660300002)(40480700001)(2906002)(15650500001)(86362001)(36860700001)(83380400001)(356005)(82740400003)(110136005)(54906003)(478600001)(316002)(6636002)(336012)(16526019)(426003)(1076003)(2616005)(81166007)(186003)(47076005)(7696005)(6666004)(41300700001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2022 22:21:25.5856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 505c66b0-ffaa-4dc4-8c56-08da8943a561
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `enter` callback is run right before the cores are put into HLT.
This will allow checking synchronization problems with other software
that writes into the STB.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
In this patch it's intentional that `int rc` isn't directly set to
`amd_pmc_write_stb()` so that if a workaround is added related to this
in the future it can come before the STB message about entering s2idle
without having to change either of those lines.

 drivers/platform/x86/amd/pmc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index fba42036682d..0f1b5b1a0bb8 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -41,6 +41,7 @@
 #define AMD_PMC_STB_PMI_0		0x03E30600
 #define AMD_PMC_STB_S2IDLE_PREPARE	0xC6000001
 #define AMD_PMC_STB_S2IDLE_RESTORE	0xC6000002
+#define AMD_PMC_STB_S2IDLE_ENTER	0xC6000003
 
 /* STB S2D(Spill to DRAM) has different message port offset */
 #define STB_SPILL_TO_DRAM		0xBE
@@ -706,6 +707,17 @@ static void amd_pmc_s2idle_prepare(void)
 		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
 }
 
+static void amd_pmc_s2idle_enter(void)
+{
+	struct amd_pmc_dev *pdev = &pmc;
+	int rc;
+
+	rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_S2IDLE_ENTER);
+	if (rc)
+		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
+
+}
+
 static void amd_pmc_s2idle_restore(void)
 {
 	struct amd_pmc_dev *pdev = &pmc;
@@ -733,6 +745,7 @@ static void amd_pmc_s2idle_restore(void)
 
 static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops = {
 	.prepare = amd_pmc_s2idle_prepare,
+	.enter = amd_pmc_s2idle_enter,
 	.restore = amd_pmc_s2idle_restore,
 };
 #endif
-- 
2.34.1

