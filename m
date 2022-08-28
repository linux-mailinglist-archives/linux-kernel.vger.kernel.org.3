Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D8A5A3FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 00:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiH1WVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 18:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiH1WVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 18:21:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738922F3B8;
        Sun, 28 Aug 2022 15:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fC07m0fKYy6Y2lW8lVh40ItOrt53vyRscnbmRQ0MCh8+6wr6lCBSrMaY54ED6x5HKjWLg4iA+scaHm1vrfJVfYmrGorKjJuoJn6pOuDfmEu57QxacGzCFTynn9imsQT79NNNmXBsKn1dEmWeUKMm5S8xFaKt+6RtwVj5dc5Mc/w9te9AoUexkhRDtdudT6w37jfaJQBPSJR9A4m/cYBM0ubDK6f9PYL4+B3xG25LnwFuQsAxG0OMCdwHwXmxWbX4i3MvgESkwrj0XmGeTcGWKVJIyktk8m8ICWcLS+4JVSoTT0TZ9FNRm72Z1ZO4x3Ahz5jmIg+0vhxKFLedZ5yK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnZ/N898WaCzVG9jDcNt0kIKmLu//Xa4CSeyFO1a5j0=;
 b=hCENVFlkmttologqqRZjt2Z6dkMmh0Ixc2rgxjLOhsfrVYno5tVJVh8q1gaukX32u9KpKLbIqb42eezCzDZ+2RBLdgCOQb7kKqYz6wH7QAeXbXWW/XiogLfKgldi9cOV2jkfhLeLjGJpF9cfJO9ZOvFuMNTZ1VbNHcLws7e0Ev7/wNVieWvPW04dN07QmuZ4jKtgL7u6mMasf7MYsbPySrEHwbH9TrLbV4yDy7rnV5SbrhFQBk6wf7XgIqNznUdSfixK8MCeHewm0Z2RtD6lfcePfNJ9MS3fefjUy2xyKmHv43pJtJOUCt5HjeTmu3Ed/a7qD5Mr4ceuNEgesBUk/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnZ/N898WaCzVG9jDcNt0kIKmLu//Xa4CSeyFO1a5j0=;
 b=GLY4GA5ys77/7/Ga0zijg1CeQz3OUOncs0C0YqgMcD78Qyjp992ybgi5mkMXnxkdYSj4VMScbg+gbeXQlpoJ5GiHXN3YM1VDpy6QWL/pxRCWKY+EZjJCD/QbpMqNHv5NNBQHo22cpa/4BKmxdj5dTLDLh6cie1Klc4rHUCX15i0=
Received: from DM6PR18CA0035.namprd18.prod.outlook.com (2603:10b6:5:15b::48)
 by MN2PR12MB4990.namprd12.prod.outlook.com (2603:10b6:208:fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Sun, 28 Aug
 2022 22:21:23 +0000
Received: from DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::75) by DM6PR18CA0035.outlook.office365.com
 (2603:10b6:5:15b::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21 via Frontend
 Transport; Sun, 28 Aug 2022 22:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT092.mail.protection.outlook.com (10.13.173.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sun, 28 Aug 2022 22:21:23 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 28 Aug
 2022 17:21:22 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     <rafael@kernel.org>, <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] platform/x86/amd: pmc: Add defines for STB events
Date:   Sun, 28 Aug 2022 17:21:19 -0500
Message-ID: <20220828222121.4951-3-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 521673e0-03e9-45a7-be18-08da8943a411
X-MS-TrafficTypeDiagnostic: MN2PR12MB4990:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eh8duTQblkBhAMSZeS1/Sh42x6gNI+vio8VZa2g3DKlJr0sLQMSJMNrdbVh18R5yoSyzIasl91+C0yQ/ZgxfbNdh4Fev6q4GKsxxCjtgfC+br7v3hdfR+1GPx+dL/cpa/UorlHtPxOU7a3XXXW3a4kHizfGvhSMiLdSka3sk73n/8a/3N72pMx302KUdC6qRpVnqoYPcyKUxsbSlcpfQO9OnfYDUwgjcANPy+VPJ+hM6vrDHi07RXIT3riO8gmePfjJqikpWI55pm1fiBG+tBT0iz01wHwqePjAyj/62LIbFFgpXpULuIEEHXBj+Bzb0h4yBvDDikdsxu2CBxJ19Ygsys/rLO8mwyVkuCvBKr32tZWD3QBaPHwHv+LHLQggSVk8pN45QyYw6RmHHgWg21Cwtd+WmuHpX8Gj7fx4d0Sci7M0c0wqNG5Yh3lmIeCbjdV+vBRCW2cGwht1ZovQl7u6D2rNtC5D0GEwsaoVKcuEmYE4ZaSyO6Xy8VLk64hxAGkE2oPEkoCfa7FpWSTzzHWpAPTvKNBjMK0P/do9CiGaParlGxRc7jFpmdCKA9zrPgUvT/N2XA7e2cWWDvY3AlGmqY+8TVlkPxvB0kNGD6ru4VFc9S4AWGLMLkJZDVuDaoD2FppzSFkBX5cbCqkAtWdgG/ZeqEowPM/1zJXrCPogLc4zGU0TJ1syHaExxm9u97/d+9K7V6Lhgo7XV3/i8LlbnqyHRcm2TX4GyMz5Pj8TGC7BuE1ahOd5/BjF4vFAEQHJ8UmSpgJUcsCubBuGeXbwwqOMjaVl2Hg186HKzxrUjyntJ70aFq5S/ynITTmAp
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(376002)(40470700004)(46966006)(36840700001)(82310400005)(40480700001)(36860700001)(356005)(82740400003)(86362001)(40460700003)(70206006)(81166007)(110136005)(4326008)(8676002)(478600001)(41300700001)(8936002)(5660300002)(70586007)(54906003)(316002)(6636002)(426003)(16526019)(47076005)(1076003)(2616005)(186003)(83380400001)(2906002)(7696005)(44832011)(6666004)(26005)(336012)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2022 22:21:23.3849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 521673e0-03e9-45a7-be18-08da8943a411
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4990
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

