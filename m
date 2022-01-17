Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82820490815
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbiAQMA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:00:56 -0500
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com ([40.107.223.53]:28769
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239387AbiAQMAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:00:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxsgAyRp+T1xQ6yqWO87wEWesHQGh9AkdmfuL9Dy4D9BdnFVFPZKQG74uakauUiIge+1KVdH5InhHCHOD3AzIG++1pWmxuKqTzkdxMUmBMXqRJTcdHAc3Gycl8eqJ08Kvt8r0cZGkw9sR1zHoT2fI4TdVAsM0dNcHdHHF/pm8G7VjGtRkJCvCZOuC+nm/n4zGrkGxetnlx6wnXsmozZy0Q1RJBMcxR1bvKWC/d1+JD8y0BQci6QYpYAAJCyzRPkpLd3dDDh7irAiy5wxxd9e+HnCEaCmTJnbVOpF02HLnmSLZqpzqJ8N0jC3czrZwMqTQNDblpNXgqF+0lnuZcnbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXDcSj3NhHz8Yy5J8tGL976lb9dugtbIoOjOGzrwwTU=;
 b=aXikpEWaX7OoBLmiozMTKZCOmCjWfpBFXywvhrTnBjxeLz4t19hg1Fm8OF02Ot0aPkOXmBP198D/0KlYIT2LYoJkePWtIfP+uuXgq2/1uc8yGXVqxUGVFJh2IzU1uf3NuGK5BU46SMkFlqpCpEsWAAu/YE7q1Tk44qHqAPUhM0J95x++CwJa8koPO7HRomamUMxfOpJiIqrvQMWVVcY3TXIgyOSUZQliIRCk6KYpC9inI6GXgDSXb+hfNR/3G3w325bmw2QCu9RwMuEtSmE1x4aXGm72agSpqTbcz7EWOadBpNZybpLhxkTAF+lqjyt+EFxfs4TgZRzh9mNGmLc7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXDcSj3NhHz8Yy5J8tGL976lb9dugtbIoOjOGzrwwTU=;
 b=DZnitXcnH14FuT1mQF1ICHagqM/3Izazsi6Ti3qKQoMzqT4ZSWgoBwFhVQUbOVi6eCN3+Of1sLNmCgqngoenkA5AKPt85UT/+j6e8uoUZ8C8au/nhbCAmyuZ41lT50yEx4CXK94aNfqObft1W74iSh5JjtsdRrCoRCAK0lNurRU=
Received: from MWHPR11CA0026.namprd11.prod.outlook.com (2603:10b6:300:115::12)
 by MN2PR12MB3007.namprd12.prod.outlook.com (2603:10b6:208:d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Mon, 17 Jan
 2022 12:00:52 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::e1) by MWHPR11CA0026.outlook.office365.com
 (2603:10b6:300:115::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Mon, 17 Jan 2022 12:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 12:00:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 06:00:49 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 17 Jan 2022 06:00:46 -0600
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
Subject: [PATCH v3 5/6] ASoC: amd: acp: acp-legacy: Add DMIC dai link support for Renoir
Date:   Mon, 17 Jan 2022 17:28:53 +0530
Message-ID: <20220117115854.455995-6-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117115854.455995-1-AjitKumar.Pandey@amd.com>
References: <20220117115854.455995-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb7f2f2b-b68b-47a4-0491-08d9d9b1027e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3007:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3007D69A6785248E71AB3D8782579@MN2PR12MB3007.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zo3e8W1WHaMS7TGfS3EX/LM9FUlrP3ZXdiXhLL9wlaEzgp5X+etn/GZOlHJmLB14D9XG6BwBVtOHPrwIGkCS5xvgM0xpIeq8Rs7YcDFWa2ykKzTTSBwRtoOdT/cKy9TQl/bz95aBFPlx8olnmZzwXI1d4yj0EQ8Q1fk5Dz4jayBiSKjEnXfnunigDrjajLFV8bL1JWTm3Iqx53aHDKtCDHv9PEmr97LFxWDxLwj+v7qtzYfGpQYgin9MKPO9QC3r8+K90eImuQ+uzpGRpJFaXepWKBTT3akicrGQnw2wBWkaw0AF4ICzPXdvGWMK+ktJZ19avfyU4kci0IhpxydXCpGUqw8Y0lxAB5uuhVGPCdwEvBVP/jOXFuJs2Mgh0emSsePZc4GoaQn2ALIOGcZRhz1b3muF12dNZFDo9eHwEo3CQrInOkLX4ESE6fXwEE9zyPqGTBKV9CUG02vmURxFz+M3fPi/J05p2SFfFFB2TXcnQIOPB6NlsMLGo8ESuMwnfcVYYDe8jfz04fkbIZMGlonG2AK5I0UJTMZWO8TzZiurQo383ouenaY/bX/CNUV+NZdAwewxKCr4qTVaQjr2koLJyp8X9K8erfGAd558OP8t4dTTabCCl8olV4ItfBuLhQOfK98PuY2lfW8PpajHL8dVIVE0A+iZH0J03MFMeEN/B1TmEH/dSqzyA/4HizwwFyv2QAJrDz9mgUo2A+viRRcybYooNCG23t/Bcc6T9gpUy0KpURwSVh3kDjUUfZazUkG+mpbXgML1FSiP05lds7GKNcXvr2tGfem6RiXaHz0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(2616005)(110136005)(336012)(186003)(426003)(36860700001)(508600001)(70206006)(70586007)(316002)(8676002)(54906003)(40460700001)(82310400004)(8936002)(1076003)(47076005)(81166007)(4326008)(6666004)(86362001)(5660300002)(7696005)(83380400001)(356005)(2906002)(26005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 12:00:52.2169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7f2f2b-b68b-47a4-0491-08d9d9b1027e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3007
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DMIC related dai link for pdm-dmic dai on Renoir platform with
generic dmic codec dai.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/acp-legacy-mach.c |  4 ++--
 sound/soc/amd/acp/acp-mach-common.c | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
index 0ad1cf41b308..91140d15691b 100644
--- a/sound/soc/amd/acp/acp-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-legacy-mach.c
@@ -23,10 +23,10 @@
 static struct acp_card_drvdata rt5682_rt1019_data = {
 	.hs_cpu_id = I2S_SP,
 	.amp_cpu_id = I2S_SP,
-	.dmic_cpu_id = NONE,
+	.dmic_cpu_id = DMIC,
 	.hs_codec_id = RT5682,
 	.amp_codec_id = RT1019,
-	.dmic_codec_id = NONE,
+	.dmic_codec_id = DMIC,
 	.gpio_spkr_en = EN_SPKR_GPIO_GB,
 };
 
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index c9caade5cb74..b45442a56c40 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -438,6 +438,8 @@ SND_SOC_DAILINK_DEF(sof_sp,
 	DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-sp")));
 SND_SOC_DAILINK_DEF(sof_dmic,
 	DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-dmic")));
+SND_SOC_DAILINK_DEF(pdm_dmic,
+	DAILINK_COMP_ARRAY(COMP_CPU("acp-pdm-dmic")));
 
 int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 {
@@ -613,6 +615,25 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 			links[i].ops = &acp_card_maxim_ops;
 			links[i].init = acp_card_maxim_init;
 		}
+		i++;
+	}
+
+	if (drv_data->dmic_cpu_id == DMIC) {
+		links[i].name = "acp-dmic-codec";
+		links[i].id = DMIC_BE_ID;
+		if (drv_data->dmic_codec_id == DMIC) {
+			links[i].codecs = dmic_codec;
+			links[i].num_codecs = ARRAY_SIZE(dmic_codec);
+		} else {
+			/* Use dummy codec if codec id not specified */
+			links[i].codecs = dummy_codec;
+			links[i].num_codecs = ARRAY_SIZE(dummy_codec);
+		}
+		links[i].cpus = pdm_dmic;
+		links[i].num_cpus = ARRAY_SIZE(pdm_dmic);
+		links[i].platforms = platform_component;
+		links[i].num_platforms = ARRAY_SIZE(platform_component);
+		links[i].dpcm_capture = 1;
 	}
 
 	card->dai_link = links;
-- 
2.25.1

