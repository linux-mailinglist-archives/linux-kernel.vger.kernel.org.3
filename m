Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921D95A4E22
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiH2N36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiH2N3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:29:25 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEFF18B3C;
        Mon, 29 Aug 2022 06:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJZGomWPlm9k/Bn1roJWYgeMbSn5MkwTDv6rRrYM4tKmvGMbTCbDW/6w/GON03ZJMeBrUgYWtT6xuRW1on7kh2ykJ8qgQtFubJ0lVmtwDerdBQgm+XQmTasIInNxncloolgGDVsprvwFOI5w9Ayh4P+6V+9iU3FMMg6qzIq/0hj+4zKrlj1DxnUdWtyUtHfef/UfZ3cmHwIgzVDADNfApsovJxKy85w+BniYPeCUz2d0wdU/yzu3g1tJntWg9MAfu07pyfdmVkxXO+lash3a8HgMr5PYtg7ly5us0E54JAhD60CYGlVAtRwBnGqMBg95EnQ4HC5mygYPrFUqologNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnZ/N898WaCzVG9jDcNt0kIKmLu//Xa4CSeyFO1a5j0=;
 b=gZ8vcqqGIICB+wesnMXObm31pLaVw/bSjcFfUVHm/TTZY6FIOhirA6EIFJDSWfA6PUy5lDmqwLs6MR9N8ucoj79+knyI7CEs0EalniQXFl4qyg68CAQLxnfrSN9vMZznoMrQj8mu0U/2BzIGCAVhl5Bjx7DByXVZUOFPqH2M/bgB69Vt7hCFR7Yc0W4vtfVvFh4BtoTu4rYRBIk9dBgLS59dHObjtvfq4PCYUbA5xsSJJ1YnM3IgXbcMH9LLAnl0JmRtmCF1rR55mYt2FVEtVUaPSyTEf15NPr9hFX0EuGPDmffU0VoK774w7O93szpCdmi01Mz/Q2RG7XEs7Vskcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnZ/N898WaCzVG9jDcNt0kIKmLu//Xa4CSeyFO1a5j0=;
 b=y0PvoXRSniIlXd3XfLO5QTNIIKrCOxWIF3iiXFix26BTLibJKz/mCo35bVL9jirBSF8TUvn72otXsaUTia8+2siLVQ/kxxYzrnNfXztvlzGaHCQHIaLWo4vuzRF5nv9SdqFQOGCe83zENdczp40QLEys1w2Jc7IGlduoYwrFM1c=
Received: from MW4PR04CA0358.namprd04.prod.outlook.com (2603:10b6:303:8a::33)
 by BN6PR12MB1921.namprd12.prod.outlook.com (2603:10b6:404:fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 13:29:13 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::ef) by MW4PR04CA0358.outlook.office365.com
 (2603:10b6:303:8a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 13:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 13:29:12 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 08:29:11 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] platform/x86/amd: pmc: Add defines for STB events
Date:   Mon, 29 Aug 2022 08:29:05 -0500
Message-ID: <20220829132908.5254-3-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7df7374d-cf6f-4929-079b-08da89c27674
X-MS-TrafficTypeDiagnostic: BN6PR12MB1921:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNcK8QLsXl5UIcVGsBjTpOke4VTpQwlq4GoDF0lwNyoB7s7GckoTDXML3Zgj856PUFJQ8t6ibZL2IJht98kJa+zB1+7VLNZdRyUDcqFD3cbyRMZ1tS3QhLWMh7N/4H+d4xacze5dqwu9aU5/t12jSGzYECzeQwrnHIP6h2WOM/XipS9q7QCdj22sPC4nuGHuj7VTjtCm6pxsHlaxB8mqSfYHQkP76wJM9EX+rmeKcwChsXXkreHHGucqYg6xiv1vACrLIhxD3CUDKBy9hEW6+3+S2EWZkTwuLcRmhYTRwiM5MV/UKKK7s/9allp+NQe/B8Ne+Xzeif5ZM7aDQF1EqD01DF6//VnLstbeK6jnrlWvXGbcXTb6roYsMUcD5i92X+y+Eq+TxjU1Vv8OXpLHPL5a18rb4ygQ7e0mdRHgVqFURQo7fRL0nBK9Ve05GQ/HhNzDRpmoVnSEweONR3seK42LX8tIksbLX4Wg7BgzRj+R1vXTkhD44CmBHMpZW3r3mJpXupUDatXYKMndngrMBAsTb/ILR/ro2VsSgvNbxamjVJpfMIq1nfdgyQHOreo8EaWiuU+pYiPnySnzm/y28CPcsgiozVoryY8D8gLi5T/DUeDxgQDmHNtQOqxC4UCpVI6DAv4HpiLsipUsnxU6p4cnl6eJmfthZBbqOr1wXFKXzBqXfE1WnZDNU4B1fKcvLL2X0dRRWtaKChpnVM/nccQRXp3QFSfEZ7MUTKsCvS1HzyaWgIk9rqyS8NHD/b1lGxU+Wjqnrli6Kb3r92TyZd87gXFhFWU/Iqb7IFiZMN+IVcspns3av/VsTWnQ8GWH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(40470700004)(36840700001)(46966006)(81166007)(86362001)(356005)(83380400001)(1076003)(426003)(186003)(2616005)(16526019)(47076005)(36860700001)(36756003)(336012)(82740400003)(40460700003)(5660300002)(44832011)(8936002)(8676002)(4326008)(70206006)(40480700001)(2906002)(70586007)(82310400005)(6666004)(26005)(7696005)(478600001)(54906003)(316002)(41300700001)(6636002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 13:29:12.8447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df7374d-cf6f-4929-079b-08da89c27674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1921
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

