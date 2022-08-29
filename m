Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407DC5A51C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiH2QaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiH2Q36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:29:58 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4678863B4;
        Mon, 29 Aug 2022 09:29:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxHEbtntgk/GPwPb9528wkZTaX7kvflJ548VrD5IFC5hX8sUIaug0W4vQbxSys/i4JBCK+ERC8718FzMbfLzazTMtetkMYI4ZKTC7gKIZSVho90Wv3BvGFV+MEXAOnbniKsn6/3g1wNss+fKb9bPoK5Eg6Bl/amE4xBRbZJPdIQmaDe6wcIt69D3phzMzmSGYbquIDrtd5ORhvGnqnVMAZPMKpbPYUaqs8+D/jR4IeqD2TsC1ilBF24ak2ij6cfEF3S37GpiGUsRgbwwD59Gt68UMnn/bxEff+CAaiXB0DqcPbJ7/FVPo+B4+/k332B/0RFV86gdniyIyj/8Lp4G3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilsrEfqeQeGNIwJPwlMXeq9QSa2qNQJ8jTqOJs0TQOw=;
 b=S4lr89OfHa81hNHdGAdDY+/7M7BpuZ6tOuU+nLI8cg5PS8KL+7RPlK7o4+JB9LwXSuCrqa24k+RowV6ci2q/LGVwPuDMpWWRblQikx8LWbkb3S4VrKoDOewAivlfl8r6g6la54mLKky3nhEYuhgnZUM0TrcAdq0XXCcBeeevMTj2H8GMTpjDwKfPfv9764sG+5cbYZEo7uU4Lo5zKfsNaaSR4YXhFlk70T0d6Hr+ag9uxkN+cYTaNrAxbLwdEA1pL+lQ+nGfzrkPnmNIO8yNS5/9pgZDVfcwxxIkc2miig6HUk89m14HqdwGFd1xsph8knnmX+uQX6meZ58opILQwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilsrEfqeQeGNIwJPwlMXeq9QSa2qNQJ8jTqOJs0TQOw=;
 b=W602nvGHVYK9ejT+8qoiGi1c1Lhckl4ij+LjizuBrnM4nVoHpGomT4zAL/oX63PWG1PgU1rAFVip/qQw/dwLd271YrDojmeCyoMRcUUL55NUM4KkgF44og/DdWtPz8vL7YUfVR9BI6kDahRpXzKrwnyH7M4TuqUXY1YQcfvkI9A=
Received: from MW4PR03CA0020.namprd03.prod.outlook.com (2603:10b6:303:8f::25)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 16:29:50 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::75) by MW4PR03CA0020.outlook.office365.com
 (2603:10b6:303:8f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Mon, 29 Aug 2022 16:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 16:29:50 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 11:29:49 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/4] platform/x86/amd: pmc: Always write to the STB
Date:   Mon, 29 Aug 2022 11:29:51 -0500
Message-ID: <20220829162953.5947-4-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6e18b13a-cdc8-4cb4-76ae-08da89dbb237
X-MS-TrafficTypeDiagnostic: MW4PR12MB6802:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71U17kD87FR2HVUfOL5tx3ZVKCiwgsauxFLfCyUDEMQCAcJpM1ftYLYaqnNuZBy7IlBYcksbC+gAc1K2meK4vY+LkIDE4nq1ZFvv5acdUAXnNDS+apoo4DSK8FysEfmBstN9X4TOnEI9IzmFoS+ZiOKFYV+68o2mkAp86WyFVf5q4/b430pwwSft/ec81cGe8BTEwedg5W1LCptYxB/9HgMInvN3KJByUnpGnu/rMW5JwsWCij7vegu8pSoug9t/uJll+tvfeiRZxlh+Q2JegVplUrB/lG+r2yrLXJD1XVszwdZK0Hr5wtRgaObe7EK6FwcsCNP38bsBPJ7hywAM+jHRUulHsHjBqY0nB0Cxc7ZDnLd5meUmz6Q6yfw00n+gvlCY+NM+V7XuccWhdHCaz2o515SoWss35kUORz5A5nNHICnt7lm6xgVTDGBQQuS9Qo2KYp9nMyTbpiJkUfLtY7xnAaLKGXHgmZhV8CD7z1adakq44b1BhjbaXVwftQ8SRnX+xdpsUdpm16R30s1eEF/RJDVFHYPxdvbWukjnx/MHFsk6N3ixJHhzCmSf3UrFvdm1DBcQlHYq4T+PBEu/WXeuqtbko7/A4pfnjjhfocZ8BRJlfvQ4rBSwDXxRqSm31PSeld4bohVUzeBNL4PN0q4T/Pi6nlmozHTaP8/zqg1zfsd/6o2hzCNBw+CgfXpqaxD8WPzHLaLl1dfwG/h5w7cDfeQ6aCB7Lxj9U2/u8GMuPd+SH9VlAOBFWRTYNPYsJYnYaHueAsp0jQSd9c9alICZaCfE74FcMlDBFeqkQdcuyDZJYdPzp5pN5zIB37mL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(346002)(40470700004)(46966006)(36840700001)(8676002)(110136005)(4326008)(54906003)(6636002)(316002)(70586007)(70206006)(356005)(8936002)(86362001)(5660300002)(478600001)(81166007)(41300700001)(36756003)(82310400005)(2616005)(2906002)(44832011)(82740400003)(6666004)(26005)(83380400001)(36860700001)(47076005)(336012)(7696005)(40480700001)(40460700003)(426003)(16526019)(1076003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 16:29:50.5450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e18b13a-cdc8-4cb4-76ae-08da89dbb237
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802
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

