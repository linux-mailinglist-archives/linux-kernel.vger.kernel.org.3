Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B1546DBA7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhLHTAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:00:06 -0500
Received: from mail-dm6nam08on2075.outbound.protection.outlook.com ([40.107.102.75]:63289
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230039AbhLHTAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:00:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuhOc9H7UwyIVZOHzK2GaNeb7VKRHNeRHYxV6euGggOAgM0846t/Zsh+hq38uWi0H1quzpRQ7mDQ/IH6+KZqC8bae1vdJebmwJP0ZxUxqqFQbvNhSVEDthczFAtchcweN8CcUFIHTuRjgtRk3M5+6y1azPYL5ddeqwP9/KaXnGNq5C5L0er557eJLH9Lij/7+UdNWbPj+0xwJ54bZysZ4q1qyMSh14Ee4iTbTtMuVQgMOObMG6r5HFquBhzsPafagFtTP3SzgE3gNivZ1ivFRrUi97DuztdXTLBcXaF6tbs0zg87AJaWhmWLR1C3uoNfgYSAhZeHAEFNldD0VkA3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5nPzHM1/nukEIVaKSZ68yoifQS8weoc7N28yU2xQdM=;
 b=aMTGC0rUcCGFgOgR0m1mlAY7ofGoIBDVuRsR/pADlL8cym3EZmxP744riBKL6ZxukEMJazkIbIh+20WK0MJoRWfMP06ccJJq3gbdZGS7Le76zMG9IL3QqO1JmHzw61GUPO15vMQfKa+yPRlar7WHdYpZWhMjFj8M39s086A7v5XiU1wxAFaV7su0/XZER3thV2Jbvprh7mwmDiUU+oLrS7mp2L+Du/X8F0HC6ownAnWUdLp9xibMHe9cu78F7NdACoAE644aJJEinOL7AArfNarZHqFhLxbFGF6iuTv4LLHXihmAF4ag1naDHUpLui2ImiUGROtkUaqxQyzEnUerFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5nPzHM1/nukEIVaKSZ68yoifQS8weoc7N28yU2xQdM=;
 b=4DNK9pKsY0qHA4rvrVEhwxqbaFwxhgkE8qFFsRZlFds80aOQw/p1o6ZAMFCIO/jaz8R1/lqy5czEujpic3u+Fv6WxGhw5hIYtp+rwIZUSMb5PLov6HoJsDsfaIEDO88zuHoOe3uc6T6mRMU6YK/J3ilugLhi6KJsS2B4mOYSJ2I=
Received: from DM5PR06CA0044.namprd06.prod.outlook.com (2603:10b6:3:5d::30) by
 DM5PR12MB1131.namprd12.prod.outlook.com (2603:10b6:3:73::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.13; Wed, 8 Dec 2021 18:56:25 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::18) by DM5PR06CA0044.outlook.office365.com
 (2603:10b6:3:5d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Wed, 8 Dec 2021 18:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 18:56:25 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 12:56:24 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 10:56:24 -0800
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 8 Dec 2021 12:56:21 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] ASoC: rt5682s: Add dapm switch to mute/unmute HP playback output
Date:   Thu, 9 Dec 2021 00:25:17 +0530
Message-ID: <20211208185517.1555884-2-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208185517.1555884-1-AjitKumar.Pandey@amd.com>
References: <20211208185517.1555884-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76a64bb3-3dde-43d8-0ea0-08d9ba7c6f28
X-MS-TrafficTypeDiagnostic: DM5PR12MB1131:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB11311E565F7C595B5C867A45826F9@DM5PR12MB1131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3fVi5msHPvFZMhpHgUt5eCMCfK7XQRNSnV8JOdXAlJubXa7SQZ+csLt5ovRNkl3gV9fLW5ATC2YjPjVSvVcxxsK2SCOyrz+NtrLlA/6mhGvOVjkEQ0fA1fmRw2483dlDu2kFt1bw951jHW2aMKqD3LlJymdyB0BgTkmHtvdee+KZUdzRczKm/2CwtRUZv6IumJPM2LFl5rS/9jsK8T/DA33wUL3YwEInt4d5AtUZRO2wmy7K7QyTtPc14Fy2AyycVUYXcOAxIQZfFC0sUkqO1/dzBu4tOFNfuGMRPYHfWpG40odUT+SK4HGh6lUlpU35RtAw9Teb1moGoVHYCak9bZ4Y3k3mOhMFGEbLswlZVguKSmVmp2dJYrDAVknx82OD1YTWQzoJiFe1Hrdqb+WeNNHi2S9A/xzhL4hExZ3Bq0IWp5ErLyNyMZXntxhkClwwkapB3GsayByNV7w8vG3sbrLWmcYcJaid6H5Z3G0N8php6KX35QBJ7H/gDDMufieDWjB/DWK7EtT/dF3/YrW5Jppwqm3sluA27cVXvrDRHp8lXICzF6KGK7CfqCqFJXDKMkIbzM4ERWA8w/ioaCkyUsZmpyhAOFH03NNIhfK9vuiBU3cwiweSoWN4QL1YkQFLiBSnmwuNH0jf13h9rkqnGh55MFv7Y8qh7L+sZ+68cFNK1uOkBHtDh50O0W64JibU+MuFIttkhq+MxAVx1HjYunXrDYt5ygjNppyQs9hTvOCnXQZtU5eh3tl9CnM+NQV7YvHofzqXKsxyNPf+T8NU07oNFbW4t3XMd1CIupUDdQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(81166007)(6666004)(356005)(82310400004)(54906003)(5660300002)(2906002)(47076005)(83380400001)(7696005)(1076003)(70206006)(316002)(40460700001)(36756003)(4326008)(508600001)(110136005)(86362001)(186003)(8936002)(8676002)(36860700001)(336012)(2616005)(426003)(70586007)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 18:56:25.2305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a64bb3-3dde-43d8-0ea0-08d9ba7c6f28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dapm switch in playback path to mute or unmute HP output data.
We will set and reset MUTE_SFT bit in RT5682S_HP_CTRL_1 register
based on switch value to mute or unmute respective channel.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/codecs/rt5682s.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index d49a4f68566d..21ab5f7df422 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -1573,6 +1573,14 @@ static const char * const rt5682s_adcdat_pin_select[] = {
 	"ADCDAT1", "ADCDAT2",
 };
 
+/* Out Switch */
+static const struct snd_kcontrol_new hpol_switch =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5682S_HP_CTRL_1,
+		RT5682S_L_MUTE_SFT, 1, 1);
+static const struct snd_kcontrol_new hpor_switch =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5682S_HP_CTRL_1,
+		RT5682S_R_MUTE_SFT, 1, 1);
+
 static SOC_VALUE_ENUM_SINGLE_DECL(rt5682s_adcdat_pin_enum,
 	RT5682S_GPIO_CTRL_1, RT5682S_GP4_PIN_SFT, RT5682S_GP4_PIN_MASK,
 	rt5682s_adcdat_pin_select, rt5682s_adcdat_pin_values);
@@ -1746,6 +1754,11 @@ static const struct snd_soc_dapm_widget rt5682s_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA_S("HP Amp", 1, SND_SOC_NOPM, 0, 0, rt5682s_hp_amp_event,
 		SND_SOC_DAPM_POST_PMD | SND_SOC_DAPM_POST_PMU),
 
+	SND_SOC_DAPM_SWITCH("HPOL Playback", SND_SOC_NOPM, 0, 0,
+		&hpol_switch),
+	SND_SOC_DAPM_SWITCH("HPOR Playback", SND_SOC_NOPM, 0, 0,
+		&hpor_switch),
+
 	/* CLK DET */
 	SND_SOC_DAPM_SUPPLY("CLKDET SYS", RT5682S_CLK_DET,
 		RT5682S_SYS_CLK_DET_SFT, 0, NULL, 0),
@@ -1895,8 +1908,10 @@ static const struct snd_soc_dapm_route rt5682s_dapm_routes[] = {
 	{"HP Amp", NULL, "CLKDET SYS"},
 	{"HP Amp", NULL, "SAR"},
 
-	{"HPOL", NULL, "HP Amp"},
-	{"HPOR", NULL, "HP Amp"},
+	{"HPOL Playback", "Switch", "HP Amp"},
+	{"HPOR Playback", "Switch", "HP Amp"},
+	{"HPOL", NULL, "HPOL Playback"},
+	{"HPOR", NULL, "HPOR Playback"},
 };
 
 static int rt5682s_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
-- 
2.25.1

