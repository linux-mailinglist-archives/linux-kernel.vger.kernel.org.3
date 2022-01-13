Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5516748D506
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiAMJay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:30:54 -0500
Received: from mail-co1nam11on2062.outbound.protection.outlook.com ([40.107.220.62]:43191
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232064AbiAMJau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:30:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxSpay3bsoQ2YtNZEC1QiuiEsDXxAQ+y2C/EK246NCFCSOJbHGTqbNdhAdHWEOvUNjklou/td/yY/FOl8lplSo9p41lCw7J7D+H3IwMqjj8M2zs2LJntX9tFcPihmE+rG2QXLfzriaOMNkFqAfmSXzOyst5FavYji8/lSDwMktjLuCofOwQcTYlgfV7GP4MEd12W976sPcC6O3E4ItqAg+jsdOSkQlDC+pPQQ+AVtM1f3gOhYlWsWq4gawpt/u+85NjuFH3Lexga20L0rf+JhzJguOPZfwLDud4u27kmZrS0fJ1a+o/5/KE9WZXzycYkB9a28cgk0BQiWmBGHFFh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0zrcuPd4mY9R/L4Zs9eqA5JLpYh4Qq+f12LdA0fmIE=;
 b=MrgLUipivhxuY50yBGWqhTr3tvzPMBx2SkP1+X5Gobpva5VW48AlQX76BbR99kjdvR7K70gShDrvFJTy1o5vE38Y73v8TnxUNJSQVqtK4PPWpaXnzd8krqPJ9Jvli0UTjsEwuasH2Q+yvlDRQEDLh4DrZvdkLI1JTZJqbTogqv2SfmOLD5Clk2Prlr90v9lDiNMUS0peKJzlDum3wMC3/rrvFDKbfUXeLlljowyQMzuE8ZLEJYi8LXhYUwY5Fmr3xE2ovLoe+QQ4VGw/xlkXW7vvXRC+/4EJzBXtytQSJMTJELG8wGs2Y8/P/iDxL+s4YmBqg/Isfu536uevQHK/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0zrcuPd4mY9R/L4Zs9eqA5JLpYh4Qq+f12LdA0fmIE=;
 b=PlFx4Zq74emP1dDJmUuWyxlkjwtfo90yN45Dn+6PvYK0TbsCris51UWWvjwBDBu3GoS71rWrzJi8xEUn2LLYKEoXwCdqFVnhAaZ7/cco9brqpgcIv/wI4npnKnmzQ0Np+sOWEAMS1qQnF97V5PVn5Tx/2suxiDNKu3QznCqxZUg=
Received: from BN0PR04CA0016.namprd04.prod.outlook.com (2603:10b6:408:ee::21)
 by BN6PR12MB1665.namprd12.prod.outlook.com (2603:10b6:405:7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 09:30:46 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::7b) by BN0PR04CA0016.outlook.office365.com
 (2603:10b6:408:ee::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Thu, 13 Jan 2022 09:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 09:30:45 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 03:30:45 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 01:30:45 -0800
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 13 Jan 2022 03:30:41 -0600
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
Subject: [PATCH 5/6] ASoC: amd: acp: acp-legacy: Add DMIC dai link support for Renoir
Date:   Thu, 13 Jan 2022 14:58:41 +0530
Message-ID: <20220113092842.432101-6-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113092842.432101-1-AjitKumar.Pandey@amd.com>
References: <20220113092842.432101-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da5e626d-ea74-4117-50f8-08d9d677609f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1665:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB16656AA062F31FA13096B1E982539@BN6PR12MB1665.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRSXf2cjgTDhMiP6lMJtHhooeTK3IOTem526zIJloCHiad10yyCa6IGKWJ+DuAeDkDCFijldzOpbJuIah7paCpyYOQvPR6hIVwspntbKxBvDPO+sKnkSCU35WoY87QFRyqRClo5tZC9Xm3Db9BZ2a1S8Af5jposYFxbF89BA/O7erO/8SPiRcIxejvU4ZBfuSH3z4QZlJLzy5gLgsu7qRGvSvRuMLHAtXkdhApfLSrEpsBvPdUv1mZvy1aK62tJiSCNHIfV3nd6e5+lMsBgZaLzh3jqwNmtqtE2SYJEZeh73wbrXGxKFxs+oRaDMR7bOuON5eREivSOvfRBIz5g97Pmm+UgKQjZmr8YUs+huZTcWV3d3eRMwsRHixjYUIdQJLdAV90smBaJbAE+pximcDL4iw3AoiF2KOPsFeSdjqDJ7YBWePPpu661nUxHuABAk0bN/DefiKr37AQUMNt0T/Or2f5+wnhbsX0h2fHPViIiYlQoPHxtlFQ4xC6DurMft84WY4K2IpmJ6sXo6jzD7EmDrqid67rMfsCbUwF2cMGpQMoXZgXr4UbLP6UOdJUGPX/xpXriz5IngAvUP1fVLXhYw/BEaROdXqWXSw8nTTPyM01jpMF7LoHDSkiTQ3JlJGRFJ8HPKGmL7j49TDKo2FI+TsKOayuyy8H8npDd/Da56nYLs+nJQ4hylhUQJldbI25D2t/RIxdYeE7NlDuitbo7gh7u3VeIcooyp+PqkirREZ+AkBnbvS64ubt/cGbcX6WBwN67mPjOqg5fNdAg4UDAwJAOQdlwGjUN96Uy9c6w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(1076003)(8936002)(316002)(81166007)(356005)(110136005)(86362001)(26005)(40460700001)(36860700001)(54906003)(82310400004)(186003)(7696005)(8676002)(426003)(2616005)(336012)(5660300002)(83380400001)(508600001)(2906002)(70206006)(4326008)(70586007)(47076005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 09:30:45.9204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da5e626d-ea74-4117-50f8-08d9d677609f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1665
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

