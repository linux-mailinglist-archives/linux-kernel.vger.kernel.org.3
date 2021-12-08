Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F052C46DB8A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239386AbhLHSxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:53:38 -0500
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:2528
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229528AbhLHSxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:53:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9YRruANwyQd6qI5ZFxqAj8hrglcCvRLKj5GkheYvALQdCqTA1pqak6yWsjRHvljX5Yo5e5hWrz7DsS9pq8T6j/+tk9UpYJw45LYUvoGYJ2rRCRR1BIa1uJmzSWkR5+o0WYK+W2ETV+l7yNSPRHRQPSdpS2e/pB7MrxkiIKmp/aWE+42yHn09P8HbKCpTL7RnXfIoJh6m6OeWTeT3R9CKDgLgUyYNqnN30eigQatf50bnAO0TjhAEm701TaROYuzHhGAfTXYZid0gWQs2hV/IjkzHo4MqHGKxIwcr2DYiEYBZYlrQYEuuzpR2ddAJk6N+9kCdUh7Im3/z7JwAGrc/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA7KR4GddPQekZKIr2pZTEEx8XUvcN+w61O6jk7OSBo=;
 b=BExApH9X1CnRLf2+FAs+1IHxl39IuJ6UZimbqC5PkY18KxkuyqQnbLFAN1SsxtRYeRJA7nn7fI5LtQoTj2dCbkhVtOhzYYUkhkbtUJPt5n3t0v7glW4aPnFe6qTm7hhdI/oBhWJn5pzZ8/pnJw5aTUXrP3lxdBa+t8xZYt2rkniwNF/j0aLfJuI91gVIF8KZfEEEipeKtiquGu6p4wTMTwzx7lCpAYPW+KWEbsCWIkBziOdZdRS1ykk/MMYxZfeTQexdN5yktAv6pE2fIxYoJMAXMxS2YsR442+xJe2piMZ7Blj5LnQfTFSgfsToz4pFJymC8HMgEH0kj2eYUlT4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SA7KR4GddPQekZKIr2pZTEEx8XUvcN+w61O6jk7OSBo=;
 b=xMNTv7vw+BXJ4B50m4TkuM1mB3sPeB2qciQx86EqsKtFJ4LZGXHp8hJ+GMFgfdR6PiZTNjOLfG/G6GP2ULO0t6m7CX3yNn+BC2CFqPEihhiyxjI2UZjGan7n7M0fkFyhqL71tsJeeq/e0S8hUHNcdaOxHgM9JCnWHhRHLajCix8=
Received: from DM5PR1401CA0001.namprd14.prod.outlook.com (2603:10b6:4:4a::11)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 18:49:57 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::22) by DM5PR1401CA0001.outlook.office365.com
 (2603:10b6:4:4a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Wed, 8 Dec 2021 18:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 18:49:57 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 12:49:57 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 10:49:56 -0800
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 8 Dec 2021 12:49:53 -0600
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
Subject: [PATCH] ASoC: rt5682s: Add dapm switch to mute/unmute HP playback output
Date:   Thu, 9 Dec 2021 00:18:55 +0530
Message-ID: <20211208184855.1555741-1-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e1b6435-18ff-44ea-476a-08d9ba7b880a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB40483B39A6DD58D26685DCD5826F9@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2L72wdxXs3GygvsvfIPEUGQx7MBjVJfEgl3+5shJdJUMW1YUhCGX+Rog5UXelg9s51vEeMq1RTvD489FgquqhCJyOCQrv15V5Y6C4CvF82u7KnyQ1p+vfbvcHXLTHrjPx0HD+dTWkW4eQgSXI5l49cbDhFxVjo+BYE3fb2c23Qtpt+5lAxGv8dgpjnEMojFkDk1aoTIX4T05ShfoV0San0drCb7yOYO5ZhAnvy2y6m25cSpJYKRjxfibYjh8DLafU7d9LJ+KWnRNh3TTW02Mw1nmb9+vgghkKOjR7reKirz1hBFRRJbAM6uQmiAfaMmvQ0lLhpNbaKBsz6oookHjbshO2G7yEYnxAqJCWV6tVEpDRi5NbI+DQXfxf5YHpV1JSgK8x9OF/qJrRT8LDjHfkHMUZcM18Tn+vYPl+T9SLvERohSI5iPNE5mTgdPKyxpaGg7pw/phYyuFPMnWkUkjc9lpOFyJO7GyhEWqxicMF8O372sPBfKJU8dk7RC1c4VFXmSpcIiND8yNmkN6WU79Qy1vMNFrCF9PgGKE+FZK63oAjpmj+L6W+N9lACsHQ7cooNN+wE56y0M1ftLn6GkVEA3/poIJRTnaW/U+H5hejg841VqWka8FUARigZK5nMgWy/TNowriwUp/hmU9K45pJFWDzK44Ke5WLZYjMEFMC713dzQdFDHNWMrYIriMKdIBDPtApP85rZ+r4ef3bZ5GMaL9DmzVBhnx74FEqu7tn5e8q8WX89xFCpDUTVFyOtsPOIi2VGRY/nA9eYBnFZjEgNsQn7UDPakvXtct8+8SwKM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(36860700001)(81166007)(54906003)(356005)(82310400004)(5660300002)(47076005)(2906002)(316002)(110136005)(8676002)(36756003)(426003)(70206006)(86362001)(1076003)(7696005)(83380400001)(70586007)(336012)(2616005)(4326008)(508600001)(8936002)(40460700001)(26005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 18:49:57.4660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1b6435-18ff-44ea-476a-08d9ba7b880a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dapm switch in playback path to mute or unmute HP output data.
We will set and reset MUTE_SFT bit in RT5682S_HP_CTRL_1 register
based on switch value to mute or umute respective channel.

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

