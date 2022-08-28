Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BF25A4001
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 00:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiH1WVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 18:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiH1WVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 18:21:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F1112091;
        Sun, 28 Aug 2022 15:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKwmpI6LZmTkQnXINSRUX1V7hDFUc86G3nnObNdZZslAdTdtUoVQXElRMHb+lNxcW6oGcQculXcl1daHefjc4bcHWt++19j1Wic8AR1aDphNM2h2eGRAiPtU+tOcBNHrf9atpvJ6td1WjtoFnBXL5jqMWXhbELKT0KZbTj+xQxYLvhfYOeu5dlL2s/2hl7hKLhloLQ2bYhYIcUydL0VB6pEpNzy13rhwiuV8kIbu8BtXlmm6EKFbxWdxjok8/y3RHr69KNxH+gIlzeeRxtY0HQOu9ui3/6giK8RFShUg9bWOoPheCTEmP2RmjWbhaXGb7Khbt2hD7fDTYauK8FkYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilsrEfqeQeGNIwJPwlMXeq9QSa2qNQJ8jTqOJs0TQOw=;
 b=N3GV/8dnI7+oe65ZKPktLG7tTXM9oBO6jXPHnTkph1ybcS0Cq33f80ahnLnVOkXwkHCScItiD2tv05dYIFkolN1Dfhib3AhCrGk0GLuZok3Z+S9Q8MtMxJoGEuEfVrRSTJa1ms6mUXzFScYIDsEbUATwGNbIB/jJ4NpKO2c5LqbNbhWj9KIOVj5wdhMKwiRs0jqn/3VIj+N4UUsV8f2TEp9Jb6qTfSQkt80N8et0kiQo2akkY3OYyez1/0C06qEO9WyhDsoYOuCT7fQJ5gp8k107GJHo+HVBggQjtzT/Pc3OJ6Gu9FRSHYjzTb9OiWw9537Gxcs4b14jc3RR0xAztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilsrEfqeQeGNIwJPwlMXeq9QSa2qNQJ8jTqOJs0TQOw=;
 b=VVbk6fqr6hl2RVt4W9fSmaFIq/JWSzy2XtGdudb50DqUGptoKgup5UvGfITbgzTWn7AG59iibNGTV/QaSkp3o1bjwjqQ5IyYglZnsIVcREkngVeZYvw0cVT7hMA2YKnwGcXdv3VQ7oEiewC97fnih8RclvviVHBxAxjV7IOthfE=
Received: from DM6PR18CA0031.namprd18.prod.outlook.com (2603:10b6:5:15b::44)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Sun, 28 Aug
 2022 22:21:24 +0000
Received: from DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::73) by DM6PR18CA0031.outlook.office365.com
 (2603:10b6:5:15b::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21 via Frontend
 Transport; Sun, 28 Aug 2022 22:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT092.mail.protection.outlook.com (10.13.173.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sun, 28 Aug 2022 22:21:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 28 Aug
 2022 17:21:23 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] platform/x86/amd: pmc: Always write to the STB
Date:   Sun, 28 Aug 2022 17:21:20 -0500
Message-ID: <20220828222121.4951-4-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1ef8f347-e97f-4de7-a405-08da8943a47a
X-MS-TrafficTypeDiagnostic: PH7PR12MB5710:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGpCMlWzWkTTZg3R3HC9yIHya5qRNKxsXDUiD7hQ/IB3T/NkTig199AWVk2/XSdOyTOR4sZPehxvCAV/fPl5+1EZ/Bz42Kdxg2JaDWhgsEEWNKPWmyhCIdWhnkiSp1VGapktGPTVqWHYfuyJQkO04HKA4Y1RazDm50xEp4TJsjpA12Mx3liWY7C39/amvv0AyR0ZUxyLp2A7GsNy85NaKDSSV6gQBpymInfuugX6ICuJkLQTn28lo6kJSLSKFPW4a98dyftAJNl7b8vSD03NMbYFJjEVXyvIcdnQsDLF6krpdAB3u8UeXQ7u/4btVIeH2amquZYGS76SkctqJCyoEHPiv5ayNN2V7LcNe5T0NU4YE5eS0E3+7Mw3LwwsOkepS6Jj7H0+ZKIYqZmqCcNl/wMSL00jFVGcXaCkvR0HzLuHO6uBL+mSu93XSwHdJgXuE9Y86enfRccxJ2z/AftGxGP9JuhSHOEZ52W+bnztZs4vdGzaJH1zvjCBjgWBXoeVOvDYKX3KTOexzUUbq5cBjtNa2VW7WU0GYm6CgjzNKS/UbNQ3mJ7w1v0dARQQPlmtASdyyPDY/VPQeKfsMwoQt1hIKwb5/tAIyM4gCVCqlDyrnclVtXRXmJM31Fu4SP3qRNG7RDeq0/h60Xhn3FTgwARZVyoLrQQk1lPUr44RPzZd2KhM2IU9rO5343FrZxjnSP38IRwS/32ioAN2Fkk0RfC30lONC0af0KG7u0mj23MgGB8Ke+muuwPDxOb5fzrNMN248/AUP4UKo/YUUXsuN+xTznvnGBtFYp4x328o2HbwACkIDUpM+V+j4T6mhjXG
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(40470700004)(46966006)(36840700001)(70206006)(110136005)(6636002)(54906003)(8936002)(5660300002)(8676002)(4326008)(36860700001)(426003)(1076003)(2616005)(47076005)(44832011)(70586007)(316002)(36756003)(2906002)(478600001)(41300700001)(7696005)(26005)(86362001)(82310400005)(356005)(81166007)(16526019)(83380400001)(336012)(40480700001)(186003)(82740400003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2022 22:21:24.0723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef8f347-e97f-4de7-a405-08da8943a47a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel parameter `enable_stb` currently gates the access to the STB
from debugfs and also controls whether the kernel writes events to the
STB.

Even if not accessing STB data from the kernel it's useful to have this
data stored to review the STB. So in suspend/resume always write it.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 39e6ab88861d..fba42036682d 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -701,11 +701,9 @@ static void amd_pmc_s2idle_prepare(void)
 		return;
 	}
 
-	if (enable_stb) {
-		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_S2IDLE_PREPARE);
-		if (rc)
-			dev_err(pdev->dev, "error writing to STB: %d\n", rc);
-	}
+	rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_S2IDLE_PREPARE);
+	if (rc)
+		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
 }
 
 static void amd_pmc_s2idle_restore(void)
@@ -725,11 +723,9 @@ static void amd_pmc_s2idle_restore(void)
 	/* Dump the IdleMask to see the blockers */
 	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
 
-	if (enable_stb) {
-		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_S2IDLE_RESTORE);
-		if (rc)
-			dev_err(pdev->dev, "error writing to STB: %d\n", rc);
-	}
+	rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_S2IDLE_RESTORE);
+	if (rc)
+		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
 
 	/* Notify on failed entry */
 	amd_pmc_validate_deepest(pdev);
-- 
2.34.1

