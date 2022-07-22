Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3657D57E286
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiGVNrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVNrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:47:37 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2055.outbound.protection.outlook.com [40.107.212.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057E35C971
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOmwkCaLgkRIlnsCwGZXZXP+/yUs5siMPqc1MGszwGZtYQU5cuaLL6lR0wDaI5g0MDubvCrugbnteRVnJVWK0yoqTD0vHoQ9bGvvqDTb5gtUHDScgxlfA8tibpUoWRhANuggN5DwHagYtn3gUPg/YAPkNBn0ToC09GAcITxHeTcGuGFSvn6MhRpaTLWfkLvi0OFR2Dp5qMcxkMDoCySwWKlx7YAiy2xG33wFFZEyPzm2nW5qq/V5zaoXzu4mWYorAgwrvz8tmV91zJD6mS6um05/mcL9osMkPPvUpFuZ6aCTdihFr2YD2+TV4Y/yxs/Gt6jdetyqMsQy4GJynx3UJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dsIJHubxKZ8ZQ4nA2CZ2XhKyMiQBtrgcYeJM4PMVGc=;
 b=g5ZBknzXr0uRD+BeflGUG/QYdLQeHqIswVsDTVq2maYyDHnkaLoLZn6D8j9ATObDVBG2Zu2COGHtWsFyN7YHBJEXfg/ZiRo6T932jv3DOnj5NLye7O3Jy3XCGuxTpPrXZggxp+mmbp+EiAK0LNhu9wfxB77Y7n2NqxHPsqsxRXczszh6H3+jsJqhbR+EPpB9Oj1PdnpRZf3DsokKNooXyfTtNy8FtAszCZJwTL7D2O+mldYhdusNDJ5n39YZInKUMHkxECXe14l7hlsnuTZlVTVd+SxxrO/KlSQd+tW3Z+tx4z8jW/xxS+RLim0hTj2UFWnJNZ+GiX3uVyaKE1SLrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dsIJHubxKZ8ZQ4nA2CZ2XhKyMiQBtrgcYeJM4PMVGc=;
 b=EsYxcl/dlQLgvk0pMWT9JLKjUC0fFKahuyRFrDsYKai2wj5yn11Af64rgn5Q5z0k0/bqPHeRQPHmJuFl6D8KZc5iCDOgGLpV2wcrIRHFfi44g2LLyGGE/mz6mL7FGQlAfbHd+5D3k/EW4sv2g7KS36vMloukP7fpdTwuAtnDDd0=
Received: from DM6PR04CA0008.namprd04.prod.outlook.com (2603:10b6:5:334::13)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 13:47:34 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::1f) by DM6PR04CA0008.outlook.office365.com
 (2603:10b6:5:334::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Fri, 22 Jul 2022 13:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 13:47:34 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 08:47:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 06:47:33 -0700
Received: from amd-Z97X-UD7-TH.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 22 Jul 2022 08:47:24 -0500
From:   syed sabakareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vijendar.mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <markpearson@lenovo.com>, <mario.limonciello@amd.com>,
        syed sabakareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: yc: Update DMI table entries
Date:   Fri, 22 Jul 2022 19:15:32 +0530
Message-ID: <20220722134603.316668-1-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e5377e2-eb76-41bb-6b8f-08da6be8bb5c
X-MS-TrafficTypeDiagnostic: BL3PR12MB6618:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCGz2db2sXGOhd5KqmmezpAMoD/oQ7zb7K0JGPejw2mX+Mf7x88HtPfuOTSN9sxkEt3BIHM0+Fyrom96ljfSNcAzxxpwmd0zFdsK2e5drzugsf2SIN2OOe0w2cjnEZe2LQX5rfXGFVMAle5L1wqsM3kp0lq4Eh7D8F9WFn/gCbsH+BQLJ1CvnTjxdnfp6byVso0wymbAXrDhQml7S+drFjPQPiCbLvgGBhz40O+Li21bLkICwDblbfnas9qQQSiAz+Nj4OeP2fYzkHXIEf1XUlOG2wV+3MfmG8SQRmVjjicntfFIbBCvgnf9vXKkdFJsW1h1lz3jTPdOsDj5YtmmRK6tcDCAKQnnnbapODAUmEinppAdX347MqWeqBpPtHd5SOdW782S4F/ZAJCQIPfgELoBURJCJGLZh76oj+nggFXQMFpbcStcOZ0SxFCBTdQHEoXerv5dRE0pCdKLDtkF0BN8S9Y41e51xCOyBQYd3LtguLCpAiK3VR9Ps31eFvsZTiW2fhBaUsck0eVcyV7oRmsJj+0RAUNboZYfC5WoZzPIt+LYzPzpD/HB/ETonBsVus7/YJtyGKS9ONI7aDNHEuRTOZnAg57EbQdmM2ZNr6BRbBTZUH1qzw/vSD3kNH7pv+IOuYV16tAQFCZcGlY//HmzLmMK9WINKdqq6DeW+0TwYRVugq6wqGMobmAD1dhsWFv4Y7AJaRG0ZRb48S+QGGjCkTGITGlcPFQN1aiUSUIVFeFAiqRRo1tuR1r/xniTf6ADr1n9y1RwXVLrewk3MCgj7BEcYp2Iy2EYkWn4XKCFayNSvtYOOM9fQSeQcdyjbqO5uT2GTCn9oUHhcfNJ8AJUO3ts8cRVQ3+vMnq6L1RGSFmQFDWNEHbzOYnzPFQG
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(36840700001)(40470700004)(46966006)(356005)(8676002)(82740400003)(5660300002)(40460700003)(4326008)(36756003)(47076005)(8936002)(70206006)(70586007)(2906002)(36860700001)(7696005)(83380400001)(966005)(26005)(110136005)(316002)(54906003)(186003)(2616005)(1076003)(82310400005)(81166007)(15650500001)(426003)(336012)(6666004)(478600001)(86362001)(40480700001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 13:47:34.3827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5377e2-eb76-41bb-6b8f-08da6be8bb5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed intel DMI product id's 21AW/21AX/21D8/21D9/21BN/21BQ
in DMI table and updated DMI entry for AMD platform X13 Gen 3
platform 21CM/21CN.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216267

Signed-off-by: syed sabakareem <Syed.SabaKareem@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index f06e6c1a7799..ecfe7a790790 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -105,28 +105,14 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "21AW"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21CM"),
 		}
 	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "21AX"),
-		}
-	},
-	{
-		.driver_data = &acp6x_card,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "21BN"),
-		}
-	},
-	{
-		.driver_data = &acp6x_card,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "21BQ"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21CN"),
 		}
 	},
 	{
@@ -157,20 +143,6 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CL"),
 		}
 	},
-	{
-		.driver_data = &acp6x_card,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "21D8"),
-		}
-	},
-	{
-		.driver_data = &acp6x_card,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "21D9"),
-		}
-	},
 	{}
 };
 
-- 
2.25.1

