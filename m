Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B645A4E21
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiH2NaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiH2N3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:29:25 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436B860F6;
        Mon, 29 Aug 2022 06:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPt3mBSEQRzUMdWn20FIWuHbHeoDE5nhB0ntQipKwcgJtZMrRBMsPAJUTijdlH1fU47MeQg/ln6Kd0DlhL5SbXUZuLpMAo7/NmPHnOXeJsLxzWq/v56ivX24EwIsicpu7k3re9O98XXOQcywg/Thc4YVyu3clTgV0y4lhEregNjtGk0+9tD+jYucFTm7ucU6z5SzAeA8QyYQIgpnkqRLnoMsp0soeW36GT9/8h102eB0cGQI0bQKz9NslfnFpbVPsJ2zWD8ZRRq82wTC3KzJ0Gn6v0wqrOHJuv0yDsPmQs4tcgKiN5zEA+VFyL5kxjqseZOCq/dc5o4uDsNtb+ebGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/Rdy/fUX8nm8LLBBiCBCHCG1rG+TE5gzSZBBNS11I0=;
 b=J04HHZ+vRZFsInr+TZ8bUhidGLhsTfXYSRkj8CN/xL14u92WUFLQVwls8aktOdLASo4at38EynCS6S9/j+eLa/GigP/O4ExdBiOO2DtXQDLyJtmSyozfO4yXLdhhsq3L6tT1lFUuTGUsREMjVsO9VYwPK6LgD1OsjIC/341Y11BUr1J+A4GPDcHhhZEfvckR9xg4cyOJ8ZmrVc+NIjKxL1tRkFvh/5aCmo3wjH47A3Rf0Xe9DmHpvmpI7qOUsswc8A6O1oA/oWoLDg7lFoTfuqUCn6+P19eJdM2udML7vt+JJf3yp6NmHoVcZMtNqTrPMmR8vec3ihTsffu5KGU+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/Rdy/fUX8nm8LLBBiCBCHCG1rG+TE5gzSZBBNS11I0=;
 b=3G38VH+f/9GP+mnhWzZ3z6pmmJqdKnd5rfUmOLo2uKtZtK+pRGytZoUoJpU1eN1DTaU0amwdkJCzF9+cgFRhjiPmn+YEz8gZ+rJdUnnsXimR/mBd1TWGLOVKmz0Yz8IijWchBSjGpG6zxeBEqh8t5EekkC/yYcpxDOvpXQUUZPI=
Received: from MW4PR04CA0353.namprd04.prod.outlook.com (2603:10b6:303:8a::28)
 by DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 13:29:15 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::bc) by MW4PR04CA0353.outlook.office365.com
 (2603:10b6:303:8a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 13:29:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 13:29:15 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 08:29:13 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] platform/x86/amd: pmc: Add an extra STB message for entering s2idle
Date:   Mon, 29 Aug 2022 08:29:07 -0500
Message-ID: <20220829132908.5254-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829132908.5254-1-mario.limonciello@amd.com>
References: <20220829132908.5254-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47080e07-acaf-4f7a-675f-08da89c277de
X-MS-TrafficTypeDiagnostic: DM4PR12MB5119:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5cl3OfYhxyGwvjwlvEi5Re1OSAGyeIrT3jDhk4N9K+JVpUJVn/ab7BOywgzGInNteSrmBCKBqroJHImsc5M7SokAIc6VtF2PfyAF9SnfOCJCcywswgex3KbDyqxS58od9ZI36Q+f6eD9lk87XIFwpVyGglZ6sXELAOdKpgl/CNc6X4BmqqTO4keDmc2luR9sHvOlhtPkx/Jekxv7drPHZ1KpAXjdfL5fD+fCZ7rTPPDTbPbec92cjgRRTXnQRG9IxoTXeYcZdpVKwtBuNKTIZVt/M6Qnm9/v+kvLqNHnsdRgWVTLqZsEWNcUGPxVsJa5nJAa/G3dIE9kjT8SmAMJzjacwknyBcBp02+VdhE8SnWW26ff7mWl/n5yTihUpFsoqfCF3l7mxwlkhyj+dkjQ11qCfT+HtI1ICmah+jorNIR0M91DnGe5gwj8N8qaDmPoTW2moFAZDEYQTB0l9mUSsv6wRD6c9MdI37Ii6VzPCh20NefvPkKaP1gvJaJ0XPfJIj7T8S8VgxT4eg8ZzJyFvefYmBNOkox3LY0mfRjJu90s99C5xg6G0ll15Zg0LhkZi2HTVTBNOY5YJfl69937AIimHXHBKj3SqmDUCL6RmKjEqwMGTZq7+QuiH+AKxBnKUNiA2UNU4ZXfFykt7sHZ5pVY02eiJv5IhHOMp7LNx4Q+h9ecooocnISVbhHF2aFV2aZAs2eV9wdkKTXpVWvxoWRWZBuQ6sPba3f9lTLOs4jL82LcR/V47SCcjCtc0q3Evr0J0ccPtJX9YxulS1ihl6lJ+39rD1ccI/YtH13IdBbq8cVv2AFACHR+NU4MgQ1
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(396003)(36840700001)(46966006)(40470700004)(82310400005)(81166007)(1076003)(26005)(356005)(36756003)(54906003)(110136005)(6636002)(82740400003)(316002)(8936002)(7696005)(8676002)(41300700001)(40460700003)(44832011)(70206006)(70586007)(15650500001)(2906002)(186003)(83380400001)(36860700001)(478600001)(4326008)(426003)(6666004)(16526019)(47076005)(336012)(5660300002)(86362001)(40480700001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 13:29:15.2196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47080e07-acaf-4f7a-675f-08da89c277de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5119
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
 drivers/platform/x86/amd/pmc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index fba42036682d..33300db461d1 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -41,6 +41,7 @@
 #define AMD_PMC_STB_PMI_0		0x03E30600
 #define AMD_PMC_STB_S2IDLE_PREPARE	0xC6000001
 #define AMD_PMC_STB_S2IDLE_RESTORE	0xC6000002
+#define AMD_PMC_STB_S2IDLE_ENTER	0xC6000003
 
 /* STB S2D(Spill to DRAM) has different message port offset */
 #define STB_SPILL_TO_DRAM		0xBE
@@ -706,6 +707,16 @@ static void amd_pmc_s2idle_prepare(void)
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
+}
+
 static void amd_pmc_s2idle_restore(void)
 {
 	struct amd_pmc_dev *pdev = &pmc;
@@ -733,6 +744,7 @@ static void amd_pmc_s2idle_restore(void)
 
 static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops = {
 	.prepare = amd_pmc_s2idle_prepare,
+	.enter = amd_pmc_s2idle_enter,
 	.restore = amd_pmc_s2idle_restore,
 };
 #endif
-- 
2.34.1

