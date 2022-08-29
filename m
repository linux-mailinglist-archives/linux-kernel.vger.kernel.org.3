Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4D75A51C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiH2QaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiH2Q34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:29:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E6410EC;
        Mon, 29 Aug 2022 09:29:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuyGtbTL1Jie724JAIBnSJgsV2ZK3QbFE0NptWAQhpIN1DPKsJ2+iz6Ndt2k0a7S+9T5Ly3P8Knfkqnpk8uAi5iVx2UolEnHiPZhMElhJmUzn1SXvAA+9OoDAMqzLjdG7I0L6lgaplR3L6Ana+uPiso/9Yr1yg3aR3/DBMYQVnymDKDmshfmKmRgFJtC5jThMJLh4YSzp4fBdd7zJC//DDyWFFcRd3XV1KLIpGDZNoGDKZj55HMPKbblyPIOVgqyALzMAk9JjK5cY/8bwbjOOAmiUGe5so+4xAU68o9Iy2dESFjl1q0LwS6FEugNzCEyMPOX8btjV6+C3ns2o/r6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnZ/N898WaCzVG9jDcNt0kIKmLu//Xa4CSeyFO1a5j0=;
 b=VrYUGA5m4Boro3JP7Ucrwc5xAtgo2+RBbc72cse9HB6uSXR+FEanxMxYpRSyewFFw/mEKtt0l3bXBS1jca0Ko3i5Y0ltN8ub0dT5C8oCa1DD2emuGYUD+pQ9jDHnzLmKqAEkVn2TShV7u6oeW2dljeuI2HUJyPXIKJXQQOoE5yKoLRoDRaEus/Yp9iEmEQcy/gbudZH+Nu1IgQrk3embQACAgP1x+VhcJyOUZ5yCnV4CZ28X91G90Hgm8Eqa2YlIFTi5UX9o7XSJVW7DEQvavy23M7+UjeS5whJey09FglA+YtUQ4XKVlEGMbZvF7vT50FQ9Kcdl3jcAjDHvJAZUSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnZ/N898WaCzVG9jDcNt0kIKmLu//Xa4CSeyFO1a5j0=;
 b=CE1i65ncXuyXhSPrTX+RCye5odvwqKAYqpYJnN9ZAd3lVeZF/41CI4pBrAhcoVLpjsYYO/IxVe1nBwRd54zwyMHPO/LqKPsmJrxSUVinqFfcp3WnAottZWQ9HUaPO2InKOHUlTm7x91KLf2aMh4SdD5d0MXqw5GKD8Oi6y2PKvs=
Received: from MW4PR03CA0023.namprd03.prod.outlook.com (2603:10b6:303:8f::28)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 16:29:50 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::b0) by MW4PR03CA0023.outlook.office365.com
 (2603:10b6:303:8f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Mon, 29 Aug 2022 16:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 16:29:49 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 11:29:48 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/4] platform/x86/amd: pmc: Add defines for STB events
Date:   Mon, 29 Aug 2022 11:29:50 -0500
Message-ID: <20220829162953.5947-3-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0bbc982b-2253-403b-56e9-08da89dbb1b4
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WwQkCNMrtCadaHE9UH6+ElNIa6e3iiTaCjJv10X8OD73EFZmL8WUEIXDpJ07RUDu/vc8FWT9de/hxA32DyS7WfvDMME5DnZkJGCY7+c1hy4jyI1uOfpk9evREddZ435gFa+HerMxCXA1cMNMptsJ2qCjFg/9QlVvcNEE1p3bBV3aXT3ixutnUsG9emoBVFKbsq3MavaOpIDdtoruPGoFTXhbi80gHZit3U2X3k2o7Ha2y4ymRNDZG+aKcpFarfjDQawCpwlv1XXa9xDgejo90fGJP4YBGys12ZydmaxTCyNDM0XpLexHOjDZymwcQfmO4Y0iD5UnFl7uPSr32Fgbc0cdX39+FvsoLqB4bYUfxyi72ahpJMIKhedNoXOCLXO2X6BWZeAF8T2BKJnysUmLV9PHyOWsOWnd8McVV6EPzK4RMZuqOV8nl3ltsdPm+nKe5VN4D1nyrMXEXhQBhmQQ7/pMYo3Y5tFvXiAn+3TrKfF/j9RZZeY4TFkRRE/llIxpYdLcmRbqvzrGLVc3GoFx7Po8yg70LKt18J9v59OthH48Y/YgjWFVo1TPGV9pqZvL/+bDb87HD9T8ft9lc49ZNdKIbg5sB5QYe44u5q+GWb7YId922xBNKLVLeSm7fJIqVYJKh0IS1rGEQrcwwq7GdNvUAbnhrqBxrYIu5Y8yBDHO5K5TPfgPG2SA68MFUuyNVMbhYORS0P9GdRJoTL89blWr8l84Xym/GBAzMxhRpTD91TdYB8JR5H113ds/d8gamqKeeHGgMI2IZLpEJVxS9+V1rj2XKHNruK1jVZILGINk0ypczjFV0cmJTbU0/zL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(39860400002)(36840700001)(46966006)(40470700004)(316002)(54906003)(81166007)(110136005)(8676002)(86362001)(4326008)(70586007)(6636002)(40460700003)(70206006)(478600001)(5660300002)(36756003)(356005)(8936002)(41300700001)(44832011)(2616005)(6666004)(82740400003)(1076003)(7696005)(82310400005)(2906002)(426003)(16526019)(36860700001)(40480700001)(47076005)(336012)(83380400001)(26005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 16:29:49.6700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbc982b-2253-403b-56e9-08da89dbb1b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently `amd-pmc` has two events, but just adds one to the first to
distinguish the second.  Add a clear definition what these events mean.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 700eb19e8450..39e6ab88861d 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -39,7 +39,8 @@
 #define AMD_PMC_STB_INDEX_ADDRESS	0xF8
 #define AMD_PMC_STB_INDEX_DATA		0xFC
 #define AMD_PMC_STB_PMI_0		0x03E30600
-#define AMD_PMC_STB_PREDEF		0xC6000001
+#define AMD_PMC_STB_S2IDLE_PREPARE	0xC6000001
+#define AMD_PMC_STB_S2IDLE_RESTORE	0xC6000002
 
 /* STB S2D(Spill to DRAM) has different message port offset */
 #define STB_SPILL_TO_DRAM		0xBE
@@ -701,7 +702,7 @@ static void amd_pmc_s2idle_prepare(void)
 	}
 
 	if (enable_stb) {
-		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF);
+		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_S2IDLE_PREPARE);
 		if (rc)
 			dev_err(pdev->dev, "error writing to STB: %d\n", rc);
 	}
@@ -724,9 +725,8 @@ static void amd_pmc_s2idle_restore(void)
 	/* Dump the IdleMask to see the blockers */
 	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
 
-	/* Write data incremented by 1 to distinguish in stb_read */
 	if (enable_stb) {
-		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF + 1);
+		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_S2IDLE_RESTORE);
 		if (rc)
 			dev_err(pdev->dev, "error writing to STB: %d\n", rc);
 	}
-- 
2.34.1

