Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9955A4E20
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiH2N3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiH2N3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:29:25 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D727917E10;
        Mon, 29 Aug 2022 06:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwB1a0YPAa43QC2T5LbcG1aPW/gSxFW+tmsHngXjDrQROV0tnzXrYdfj509T000Phj6whHyRINpn6c3K9SCoWhWp7S6v4ka1k3EdlH/JpabEPBFEKVWqH9AYTxdAndBC/G+fl3tsStgF1V07JIQAsN4yYpDVk4//yVrX3a3w7ZF3a2M/AKOQtTRZSpPB9O+rtRMxYBzrTVy63qja75mHDm4mxpMFNnphnrAUmIn4WKD/yf0ms4Fw9pSxwwSuFnDuxYDSjnOuPSv81ztZSiQ8qwsHEAtsHLxclDPUZG7Sm0DbH0TjT+73Ww5DzL/MfzXwDnnGBFWkxYY7G5h3zmgYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilsrEfqeQeGNIwJPwlMXeq9QSa2qNQJ8jTqOJs0TQOw=;
 b=OQWPrqzj5O6iS0IvjI4TBvtUqV7PBZdmGpOd7Rkc9IW8Qbhr6q0yFc3pVA0dlVQjgo1g5lnxzesaDCaEWStSfeUhdvCB1IT7X74HgbYQ9r64F7ayXagVA9M635xqqiG7kCIpsr0P705hNEk/vuS/JEY2tD/pp0/FHT8lmyq/fTu996IyO5NCZmxtwnhR1ci07hW5oXNDCazPia/syTQbU9g4YGiWWmE5ajrR/ZEm+PN9um4I86AINcQl7cKBV0DyyXyXxdQZ4lBzvt4EFoc4dVulIjeJPfr4EDPKJY2rM+JAi5BT8tCwexFEvnmRlc5TstkDq/rB3DH9eLFeWVlN7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilsrEfqeQeGNIwJPwlMXeq9QSa2qNQJ8jTqOJs0TQOw=;
 b=ltriAG1c2wUCthC8v5w/MyNBATiLmLeeTqyuztcyZMRzUFl6tWio8tYm2an7FEN6rwN/ZEDKowoiH0BaoyPMsaS441grUCKd3IdAujayZ5JeIupFBKl/xjCYNncnGONPFEMDd15dM+PzmLwe1S76api2hjEn6KhKnWXZa/5UvwQ=
Received: from MW4PR04CA0352.namprd04.prod.outlook.com (2603:10b6:303:8a::27)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 13:29:14 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::7d) by MW4PR04CA0352.outlook.office365.com
 (2603:10b6:303:8a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 13:29:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 13:29:14 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 08:29:12 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] platform/x86/amd: pmc: Always write to the STB
Date:   Mon, 29 Aug 2022 08:29:06 -0500
Message-ID: <20220829132908.5254-4-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 197ac685-a2ca-46f4-c0bf-08da89c27732
X-MS-TrafficTypeDiagnostic: MN2PR12MB4110:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5e7qs4wj+p2wXIewLd44g9Ed/G1pv7PTFRioHddPckWK8DMKS8GOiF622wwIH9cCsFofE9EpfPqYGWvsan6WYZXyCGWf6VaVkkz90lBoAuu9ivPiY4Epu2RaJ8zm6jPstUicnxti6Vb5+j7xMX1qacLsmD1OQBVPQkD6tcPVjWOeAslcAmtwUDxJsrN85LXZEeQ/+2iq8hOiJ9jgY15+/OVuaqXQRBauVfZ1ZiwZvtrARUqcsINr5Rx/0iSPD08XmrMfEoUgOWDcC17rYIoAvVuJT/OBhVM/N+SJ3ekGFDbLT8peSAHKSusbz2osXFpte8xQzGjabUnE9QBJ23nzP+HgC/f5+zHRKa6QQwDyxR/zO4LILqbssGpjS8znabKkoiR2f5c+46dYa+QUzZu78nYrkhuAkrYNQI4XZ9rXSat2HaisIav7qI1+YWU1J2TRogGE7mjRxxehfDEbzSikzUtThTpbXCOk66MpoCwWGo90AjbPUrtDv6Yl+8ZEzNXUq8apgP2x2IVnE62PnPjnZOPvtjo+lRTK3PVsWBDIobO2Ybe+apWKw36p/6ni8xXTehtYARLsQ0dYpMErrKPL+kkVxGXUel0yiXnj+vV7YuPftFAi0p2AmlbKNO+QHlaJMbGCcTNfSVj+L64bb1A+O5SYbKLo4jUGn6y2lFPCLfZWYh6vFLeIqH3PPtd9wjpfa0FQcCGc9xmHNb07v2EaB2kkUa4uhlIdW0zFZvUC3vnKE0RllPl/F+Qr7ZFjkKLLVIIcmZRfOPJ2W9GYnLGSIdXMg0rBhh0xz0Vnxxvon7PmiSMxrdY17x8B47pH0DS
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(40470700004)(46966006)(36840700001)(110136005)(6636002)(5660300002)(8936002)(8676002)(4326008)(36860700001)(47076005)(1076003)(2616005)(426003)(44832011)(70586007)(316002)(54906003)(36756003)(2906002)(478600001)(6666004)(7696005)(41300700001)(26005)(70206006)(86362001)(82310400005)(81166007)(356005)(82740400003)(40480700001)(186003)(336012)(16526019)(40460700003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 13:29:14.0790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 197ac685-a2ca-46f4-c0bf-08da89c27732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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

