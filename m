Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A904BF845
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiBVMou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiBVMot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:44:49 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5197B122F69
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:44:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRIIkFH+AX+JuSgdDoDcLAUYRzqZM7QDYLmvrMrQv4hsAJJ02DMHziPkQRA7NRj+ZHgWKWoUS+lpXbrc7uVAmRxvaunbGFVaosoJe1B7vEpsau6vAaZJCel1Y7Zxkim8FiF2EUpPaoZQczDw9Ecbufk4KBCoBlykTglT/zJs3MoyYYQg53jditR2L0/isl4uwdz8F48aXx30zDznPRjGNDN6qqL/YRmk7ZCUz+nHs8TNbGSTfn3+9Sef+wKua4Kdt4NOw/duxNdZ9IKDC9PkSUtYWA2N4H+A5v3KPq/LXvT/RyeQxVKNxhhLNu2vclNu9qTPzi+IUHYa9NnKnXdpOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0e5Yf/l7KLhk03Q8tqx3awfxFgaYY9GQxqf0QmqNpU=;
 b=nxXHxT2K0N6a3FzIyWa3mSVY7r5phLU6yOaHa3dwvRGif3dZ8GP2xypVtsecp8U8pHn3Boy3oVmCo5Gjq2c7Qmy2ILtz0UbYkAepGNw+IisJ7kqJpl9D+Lo4BgRtSFp0zqQnFD33nCGJt49m76JW0j1TBxHRJ3rzxxz3jijthgnH4vuevCLeWZnB+n8pNczPL15Ye5taRHpWtq9qNlw63yTxBCMeuzv9WsyraXZTCWVxuLStQCs+VfoPZhojj0x8J4VVtqkJDiJYvheKrv2mwnqDmnECuRgkDKLXEvN2JI0aqMrAQePwjyUbzPkqwAt8gnYnoca7rCVqCqyZwIVtrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0e5Yf/l7KLhk03Q8tqx3awfxFgaYY9GQxqf0QmqNpU=;
 b=1LMR1zpIBiaVEYZ9jug2JpLDTzunnWChWTZE0Z4GbucK8BMXmgiYoTGCKHjMNd5gQGZiD4g+EdJ1dEOP/sGe+o+55g9MpwfGI0xNerd0Cqt/wQ0FNsBRv/WK3T9xvzCk3bjOidryQG7VeJwBD37vstMf+bIk1BegO07aET4RKd8=
Received: from MW4PR03CA0303.namprd03.prod.outlook.com (2603:10b6:303:dd::8)
 by MWHPR12MB1440.namprd12.prod.outlook.com (2603:10b6:300:13::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 12:44:17 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::9d) by MW4PR03CA0303.outlook.office365.com
 (2603:10b6:303:dd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Tue, 22 Feb 2022 12:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.20 via Frontend Transport; Tue, 22 Feb 2022 12:44:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 06:44:16 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 06:44:15 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 22 Feb 2022 06:44:12 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "V sujith kumar Reddy" <vsujithkumar.reddy@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH  v2 1/3] ASoC: amd: acp: Change card name for Guybrush Machine
Date:   Tue, 22 Feb 2022 18:12:11 +0530
Message-ID: <20220222124213.721224-2-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222124213.721224-1-AjitKumar.Pandey@amd.com>
References: <20220222124213.721224-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da29e6cd-4c3b-4c71-2df0-08d9f60109fc
X-MS-TrafficTypeDiagnostic: MWHPR12MB1440:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB14408617708A725713C005FC823B9@MWHPR12MB1440.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBfYqE47hInlycM2x5y0zGYJcPBMGFfVS7frEdsLtTZDfMc5nMZ5sjVyqq4ofQYN4E5FUAkI2t6wzO9sMgWMUUqyBhgDzBz4/achDOXXAd+2bYpXqFvG22un9lsuTvWkDmty6mYusi4dXHaL8GL1Jt2Uz0VR7xn4ptuvA14VpdkW3ajxid91SUZXCimjYvdM7FjoSbT1/M2GZ4vMtqxYjOIlxv691yekfj59jRelL4m0GnexuP/r4ikW0/0RT5+1zgAaF5XmaOsEd+2i+FkxjZEvFAFj7kXdXYLY7q7rLzBlC76hkjwS4pbnzfluI0HU+OSu8MlwvjiQvUyS3hk79dU32Jto4towHa3ZmOGb5cfae4M93kdlpIBuH/kM1QjdxULagQtfKAEQwoBEsFEBgOHLJiVeyroIEVg7FYY4+MLZ0WspNS/Gez25vJFmNj1ri+y9PD14RDQmsdWi671JdLITFITrNLne6n2fqJPA4ptcPOSucV/Cv03E/bP4dcQbxs33xMZjZyh8XP5RID4wGeiorWfxbNX9Qa1G4MyZmNoIa154Esqy+3KHfgFddW3jmbZcnlE3jjYm0Yq9s7IVGfw56vv0cvJVLVvcJel6xH0483Qrims8z5NeHzBAmQ1OCj9Ap/OjQB9Uy7EU0fOrp/5c6/V+gL+B4sP+9hbeZ9l1nssJh1yL50lPESy5wiH+7zJxJfVUCe1RtUGk59t0ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8676002)(4326008)(70586007)(70206006)(83380400001)(110136005)(54906003)(316002)(508600001)(426003)(82310400004)(1076003)(8936002)(5660300002)(336012)(2616005)(2906002)(81166007)(356005)(36756003)(40460700003)(7696005)(26005)(86362001)(186003)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 12:44:17.0839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da29e6cd-4c3b-4c71-2df0-08d9f60109fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1440
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change sound card name for guybrush machine with rt5682 as primary
codec and rt1019 amp to align with names given in UCM config.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/acp-legacy-mach.c | 4 ++--
 sound/soc/amd/acp/acp-renoir.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
index 91140d15691b..50a5aa4d6da9 100644
--- a/sound/soc/amd/acp/acp-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-legacy-mach.c
@@ -96,7 +96,7 @@ static int acp_asoc_probe(struct platform_device *pdev)
 
 static const struct platform_device_id board_ids[] = {
 	{
-		.name = "rn_rt5682_rt1019",
+		.name = "acp3xalc56821019",
 		.driver_data = (kernel_ulong_t)&rt5682_rt1019_data,
 	},
 	{ }
@@ -113,5 +113,5 @@ module_platform_driver(acp_asoc_audio);
 
 MODULE_IMPORT_NS(SND_SOC_AMD_MACH);
 MODULE_DESCRIPTION("ACP chrome audio support");
-MODULE_ALIAS("platform:rn_rt5682_rt1019");
+MODULE_ALIAS("platform:acp3xalc56821019");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index d06ad5ce7fec..b8dc25a1d31d 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -47,7 +47,7 @@ static struct snd_soc_acpi_codecs amp_rt1019 = {
 static struct snd_soc_acpi_mach snd_soc_acpi_amd_acp_machines[] = {
 	{
 		.id = "10EC5682",
-		.drv_name = "rn_rt5682_rt1019",
+		.drv_name = "acp3xalc56821019",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &amp_rt1019,
 	},
-- 
2.25.1

