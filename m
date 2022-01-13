Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AFE48DBE6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbiAMQfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:35:42 -0500
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com ([40.107.94.55]:51040
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236787AbiAMQfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:35:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/HWsp8cmLngxaHlw9HKpjDrDiZix4MLLXSm1UhnP9Itidg1FZ+4TjNgigd99JISsB5j0L6GJcWPsBwgFgtQ2iI/27zQt1ptj5yFwhlDEK3hBFPvFDzw/9Or5dUyAgqNp+edZQrd/eHTVUDTnRfqNsiXx2/i7P1t0ttuxer6IZxbhhmmlIdTy9Lk2eIe3B7uicAcYLfjSJT2DL4ipwzKF1WmwMDGK0kta9XWBk3cbYBNJf+7wg4NriVmJH+P2ZL/Wz3dEm783WS1BhE5P7ucQeeq2YykHATIzCUvurX6pB3uCtPQI2YtQ+6XgcJ0YjKUBmIexMG9D0Qwys/27kaXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0zrcuPd4mY9R/L4Zs9eqA5JLpYh4Qq+f12LdA0fmIE=;
 b=DBaROG2tF+QmzhRCFv3voz3+7HpY7/3nsTVx2FmwXMX4vjjpjJbKhIPjYFPSl43XqETQhf+yh2oLQt8fCddm/om2x7afR6noDtObZzyY8hFOcAwW6V8mVvYij8rdw4wLSMC77n6u3zxekBmbsZjhePwj0LtjKcuW7XqLRc7dSlFhpGbe0rrMtrtzB4V347NEsylVfM06LccPpy+eak/mR13mMPEmldjYVDizQgV4svWImee7hRXRxba82e39+BRC48S1E/nKMaRZvp5uDvLApSGlU3E8M1o61Bcl1SHdsZY+XXElTzYyF5BUXXCvSiX8NIXeouYFtXxE7l/xOTz8MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0zrcuPd4mY9R/L4Zs9eqA5JLpYh4Qq+f12LdA0fmIE=;
 b=hLA8+6RF6m7Lx8NvbZ7mnRpFBI6BQI/Ev4J0g64VwNxPpsPow3TceoQqCHu/TpuQByCLEQC//3g0BzNZwHX3AdqnWqIUBE7lhDWfIBOZZkB1BQVnMzslCRP/Eg8bTiFP8B08kd9kSoDkIGZZ7qRQcBcu8f9LAy1ZR0jxT1Sp1es=
Received: from DM6PR13CA0040.namprd13.prod.outlook.com (2603:10b6:5:134::17)
 by DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 16:35:38 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::c2) by DM6PR13CA0040.outlook.office365.com
 (2603:10b6:5:134::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.2 via Frontend
 Transport; Thu, 13 Jan 2022 16:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 16:35:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 10:35:38 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 10:35:37 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 13 Jan 2022 10:35:34 -0600
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
Subject: [PATCH v2 5/6] ASoC: amd: acp: acp-legacy: Add DMIC dai link support for Renoir
Date:   Thu, 13 Jan 2022 22:03:47 +0530
Message-ID: <20220113163348.434108-6-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113163348.434108-1-AjitKumar.Pandey@amd.com>
References: <20220113163348.434108-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb4d5506-3fc6-4fdf-4c87-08d9d6b2bb75
X-MS-TrafficTypeDiagnostic: DM4PR12MB5181:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB51818E9D288E8A089036F6D082539@DM4PR12MB5181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJow5ApciIzL9vjd8dIJj0xMmZCAbvwiE0RkWnoQhDtsfT4FJ/auJcVV4zZbZKevVYGyyEUo11ED/IZVwc1HLwOfZ0DO93bTlg96r9QHLxeZKnFBzQknumTKMoBU62nK7pij1qao1B+CGFgIwSH+Yfz9kOKcAkjoH7W985V3Ds3bFDnI02Le6cRRPxRN/wwUPGGV7Fc/OcgNPekA3crU7Ik82wEognBTKy0SR7Z9NAvIDehA7sh90s7l0H/twmz89YCQwrdQbF1YNhSRehzvNCioTU+pi0BIbfugEC/9Wa2c57bbz/VT5fPuj/z58pqo2zbe24oZtt/6kUy3gVFPI83UGj9ikgFJCHK2370786mXwkyQPrHFMHhulcYueHLjcwco/9YhVgCxD8WQ6I5dZhb7TtY41Nt+sa0ylPQwDaJKu4ExOEr9TbGPsbH43vxDISIzcH/SlBCiNS9pgbSbzKYXL1U/zfMHXdieCyzlz5/djLg465GNCvZWGHnQIgkVQB17k2Fb4ibCY+wWaK0HBwBf8lZElxPGbbJYK+ovfV9RhrzxlPvd0TSac4vZ0ptDAzZX+OPEld2APAsNePrl2dDOaZ3N8Vqgx39KXHm0jsbOMLjQ1SEbsxawbzQymbwebsW6Wn6gjVJv6ELj68tZx0KsRkPOokDcWPiwRJsjsZowM6xmSHfO69khBlvn/u3+brORRHg/BrlIHBP4Lp3bdQ8i5Njqpg7IarDJtB+pmkyVtUT5rsx7/vOAteGu2YT/+nY6TPwFJC2Fa31P8ApMEEsOOKz4Wj15K2z2JG9o5+0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(36860700001)(5660300002)(508600001)(4326008)(70586007)(36756003)(81166007)(2616005)(6666004)(336012)(47076005)(356005)(426003)(70206006)(110136005)(54906003)(186003)(40460700001)(26005)(83380400001)(2906002)(8936002)(8676002)(7696005)(86362001)(1076003)(316002)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 16:35:38.6560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4d5506-3fc6-4fdf-4c87-08d9d6b2bb75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DMIC related dai link for pdm-dmic dai on Renoir platform with
generic dmic codec dai.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/acp-legacy-mach.c |  4 ++--
 sound/soc/amd/acp/acp-mach-common.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

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
index c9caade5cb74..b163e3a68166 100644
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
@@ -613,6 +615,19 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 			links[i].ops = &acp_card_maxim_ops;
 			links[i].init = acp_card_maxim_init;
 		}
+		i++;
+	}
+
+	if (drv_data->dmic_cpu_id == DMIC) {
+		links[i].name = "acp-dmic-codec";
+		links[i].id = DMIC_BE_ID;
+		links[i].codecs = dmic_codec;
+		links[i].num_codecs = ARRAY_SIZE(dmic_codec);
+		links[i].cpus = pdm_dmic;
+		links[i].num_cpus = ARRAY_SIZE(pdm_dmic);
+		links[i].platforms = platform_component;
+		links[i].num_platforms = ARRAY_SIZE(platform_component);
+		links[i].dpcm_capture = 1;
 	}
 
 	card->dai_link = links;
-- 
2.25.1

