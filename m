Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D295848667A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbiAFPGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:06:07 -0500
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:45920
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240267AbiAFPGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:06:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXV7/TJoEZJAWkJOJvuOmf1aTS+gYknepqcpBXfuTbBps6jpy7kWNPp3F+RZcUdEqAFjNV637MLDw8Sv08o9YFrSMG7yM1VrQCcivd+FA0huQtKo8Hv5WNyFoiOm82wt5FkonD51K6yUMSXeWLH/Q0GP3nLPhokaorA+DyPydO3y66j8TaeVbbd4x7OQ4+R6JnX//MAgpy/qKs/kwgUueUT1jgQQg+3T/e48IOMV83F3eHPifIgKNXM1j5Uw8oVFIcRhIB3WUk1hu10b6LNhz9W5wH2D38n4RpagH85kqaAbEI7VVUiuNxy1dvo6hcZ+UrbuoH0syjVpTXqMpsw7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgbXUvkW1my0JlGCc0AMuwQ7JGF0uA5gvyJXy7uQtk8=;
 b=Vi9WqDiXbxPHa7tF986+4QKQuQ4KGlIZnd2e+s2sAjH2OAKkEzwGfrxGGR03S/qgCXP1gEZp6DuVy2IrZV0XHlYGVT3odI/81NH7fvTz2jIIrz0rchR1720lm7Wg6WvsN3CSdXu3Brdux8tufixMptxinvWca/aZj06F6pAPulbg6VA69GPHvFh6DfXuUjN/684LRPsqxsG6ngJ4aA9kvGcxAW+sXtk54vBEMYDyoPWqM1gl51ykAka5Bee4CoGFTlKjdTHW849f8BAKTcylbtNnGKKCAGk0s4ZQDSIRBghh1RNkheLR8DQZeAQMlMwjyC65us7rg6xN808VZEhaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgbXUvkW1my0JlGCc0AMuwQ7JGF0uA5gvyJXy7uQtk8=;
 b=oX41+FedZmyD6Uvf04EPfu9Uc0D7jz4ACYVooWzpLmoRWdLxG5ponqLkHH5pxUjE0uF62PBT535zj6gvZBRdjOXR9tGTB0uHAfgQezb5Ou30n6ryCdMw8XJBzZ4z4x+7s/d9GF4r+RExBFt6wJ4JhJY1XJ72W9XI30qO1WNmfoU=
Received: from BN9PR03CA0490.namprd03.prod.outlook.com (2603:10b6:408:130::15)
 by BN6PR12MB1490.namprd12.prod.outlook.com (2603:10b6:405:f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 15:06:02 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::d7) by BN9PR03CA0490.outlook.office365.com
 (2603:10b6:408:130::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 15:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Thu, 6 Jan 2022 15:06:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 6 Jan
 2022 09:06:01 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 6 Jan 2022 09:05:58 -0600
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
Subject: [PATCH] ASoC: amd: acp: acp-mach: Change default RT1019 amp dev id
Date:   Thu, 6 Jan 2022 20:35:21 +0530
Message-ID: <20220106150525.396170-1-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50eb99a9-f349-492a-311a-08d9d1260e45
X-MS-TrafficTypeDiagnostic: BN6PR12MB1490:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB14906E4ED5BCFE0A8C3B364E824C9@BN6PR12MB1490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/62NpEz4w+8HsWwsWjVXFgsW7+fVka+qWXoe2YHSg95znr+RmNsyp3WGJV24iYSUvVAp026MvMgQpiHUjid/5ZunxsTt1q3uR+0W9vmWEozZFhwhvMyJZaY+C8QG7ycDTM9AZuK6XVb5YAVlRVStwXyMHTz+mea4SanFJM8ehVQGX3lpPLyS3d+qCF8Z9ynv3ifz7tfbKlE5HW9j1+XFWIiWGDK9p2mUNFD/SsKDqgg/uVHJiDfbJ7skoSiSZBrMiDFmrHFGRJyuC/deEWpRh7TeS8YDumd6XsT3q17EDv5WMRlrWpHdadkFX7vh+wM24IUzA3WqyJBiIoWCk/M1q89XeqJYrpe0pcGjEa9RrdK9I+/7alkHrVIz5UNTclPHmOTKij5tOFGLSJIE/oUL8YPNpH6iCncoFuvAXhiYnske68yvARBz41wVlSJxZ03LHeKTxBdu0KYPfKNUwd/iJGkm2kf9IaJHUUVbMgAmG/IG+KMQvqZh07IkjeBuHBlZ3q9BAjrJ8EiASR0YvUGWE1TtDp+r5mdrpQYh1IUrM8MJPCQXGT8+DtDgIPM0rl03lQ5brw2z9ZZ27la3aKg2ECtjEg/m2+2ZEZGm9QjKF5XvER+HAGz9kStDM1RWLVvTJb8t0YdiICuFs/yOGsdPMPfqBBp841aA9mlKgynLMJoNcYSgrk5YIkPN5KvJRHNolPj2l0bI7UKoZBid4+8WGTgX4GldFs7YKPvvpGe8mBDFBd/9vCX22XPLH2Bc4orMX0xIkK7zTvDXKyaW7yIKJbYkN/Ic1i2owRYk7i3VWU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(7696005)(8676002)(86362001)(508600001)(8936002)(54906003)(2906002)(36756003)(110136005)(82310400004)(47076005)(83380400001)(40460700001)(356005)(81166007)(4326008)(186003)(26005)(2616005)(336012)(70206006)(426003)(1076003)(5660300002)(70586007)(316002)(6666004)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 15:06:02.7545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50eb99a9-f349-492a-311a-08d9d1260e45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1490
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RT1019 components was initially registered with i2c1 and i2c2 but
now changed to i2c0 and i2c1 in most of our AMD platforms. Change
default rt1019 components to 10EC1019:00 and 10EC1019:01 which is
aligned with most of AMD machines.

Any exception to rt1019 device ids in near future board design can
be handled using dmi based quirk for that machine.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 03d8d1af14b3..c9caade5cb74 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -293,8 +293,8 @@ static const struct snd_soc_ops acp_card_rt5682s_ops = {
 
 /* Declare RT1019 codec components */
 SND_SOC_DAILINK_DEF(rt1019,
-	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC1019:01", "rt1019-aif"),
-			  COMP_CODEC("i2c-10EC1019:02", "rt1019-aif")));
+	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC1019:00", "rt1019-aif"),
+			  COMP_CODEC("i2c-10EC1019:01", "rt1019-aif")));
 
 static const struct snd_soc_dapm_route rt1019_map_lr[] = {
 	{ "Left Spk", NULL, "Left SPO" },
@@ -303,11 +303,11 @@ static const struct snd_soc_dapm_route rt1019_map_lr[] = {
 
 static struct snd_soc_codec_conf rt1019_conf[] = {
 	{
-		 .dlc = COMP_CODEC_CONF("i2c-10EC1019:01"),
+		 .dlc = COMP_CODEC_CONF("i2c-10EC1019:00"),
 		 .name_prefix = "Left",
 	},
 	{
-		 .dlc = COMP_CODEC_CONF("i2c-10EC1019:02"),
+		 .dlc = COMP_CODEC_CONF("i2c-10EC1019:01"),
 		 .name_prefix = "Right",
 	},
 };
-- 
2.25.1

