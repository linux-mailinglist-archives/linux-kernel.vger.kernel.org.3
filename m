Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E1247C44D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbhLUQ6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:58:34 -0500
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:42368
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236459AbhLUQ6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:58:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRArfNDJhXyofGII/J2qJEZrhOwVVjRJlp9hzUMinIQbTR22x9SaIPeM/C7BQWVOINH7is0fHcAnYUqKNNV/0oZGt/Y+enqgFMtVuU8lQqglaliBEU0ogwJczzZ9NjoPfAEjp101WlH0/V/rDQRiVUS3Gj1cDscFosXXVxvfiGxgOI6uoA/LajThQ7mqR346cZncGlbHdgnHwLR1sujSIm3ilTBjJxFXmJqSFooeaLH7PwXPAHqSQznk4XOoqrOMezjnD+C5TMdP0LlZdI3VlAw4fRJTfiKTV/z1dEvKEPnKT2/Kg9Sav8efs9fTE5EJOnRUN/NcqqbM3nvak+8bXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HOPp8SIaCsf8ymzbSkTja/Ct8WQHh4JyKDf7i6huNo=;
 b=PkUakz+IR2kBZ5fgZxrwhNJeHVTqQ34g/F+d5PQKQ49MZa2gah83V+ZO7dgWpnw37uh6/8wmd8rkQr0WCSlHvdsHKZgtABo2emb2G882Wjuwauq58AmVIwRkqKPZ591wYfAajZXSFNWRMk6EeDv/fFckGXKXOcFCRnavFoFV5IUl9nbmuVKvyLjyHIqDid0cnvTi2eRQHXtTrj0QrEUKFS19eACUVRtTpln3kJ5KD52qgWKTikN/SXCOa8innGTwbYroLfxzEnFRjPfHcl66Pxx8Dy+aFdkrFNH3HPF85gxln05qWFPUaxsSFr7k/dsx0GIEGOUdY3+lgph4XmT9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HOPp8SIaCsf8ymzbSkTja/Ct8WQHh4JyKDf7i6huNo=;
 b=HRnziHMFwKkUKXkTd66dSw4ZueDSxuRxCk6lEJnpHsoWSANEHAYPrh9c4XGvqxt7cdYJYEfA2z8Pax1pKTUbiXrglMl/7cGpxH39+VnyBLstf4L+WhrOzk+/MsW9vcfuXX+Jz93Ur/4H0gq3RhsICpEaRFj6hq2ePbY5ysr08Zc=
Received: from MWHPR19CA0004.namprd19.prod.outlook.com (2603:10b6:300:d4::14)
 by BY5PR12MB4965.namprd12.prod.outlook.com (2603:10b6:a03:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.16; Tue, 21 Dec
 2021 16:58:28 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::21) by MWHPR19CA0004.outlook.office365.com
 (2603:10b6:300:d4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15 via Frontend
 Transport; Tue, 21 Dec 2021 16:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Tue, 21 Dec 2021 16:58:28 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 21 Dec
 2021 10:58:27 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 21 Dec
 2021 08:58:27 -0800
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 21 Dec 2021 10:58:23 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] ASoC: amd: acp-config: Enable SOF audio for Google chrome boards.
Date:   Tue, 21 Dec 2021 22:27:58 +0530
Message-ID: <20211221165802.236843-2-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221165802.236843-1-AjitKumar.Pandey@amd.com>
References: <20211221165802.236843-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc63b9a6-cd7e-4850-9889-08d9c4a31c81
X-MS-TrafficTypeDiagnostic: BY5PR12MB4965:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4965A91C507064B87EFE0A3A827C9@BY5PR12MB4965.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbUEhH8/y/uGDgZ3h4pBQBRrweNAsHnA4gbXOiYRDr5PXva4ITkGpvjYdVHZC7avwKbiaSRdz5rZP2e0lKKA46FDW7NwCzWZll/KbcWD9x6Du1VPw6jgTAi5iuJ0vI+2OdMAzHKNDOvS3UFBcnVvf139KXEj8FrOJZspXEo6Ur3vE++tDQsSpDLpKLvyqoX1fZ1rXdQQSsRRiJmY0ecjlmL+Ocsxb+t4cvXWHEXoBHwAfk7Q3tQ3VomLt7odD9o/Nk62qZlIka6JKYIIL0EvDI+wZ27M232U438p2cNV0Oo2h6PnsFx/55XJHHq41+ZJ8g1KD5t7KBfSD6tgvHULn13WVHOBHAzxur/E2AWKoZWN5GKBwjmFfNI9T1RjNV4trNnhYgBcENIcNvJkmJceimOalmmfeUVSpBjMk/xTcnwXH//qZeYk+TB1GKp6JYrqn2Q6FMbuVW35g7WikBYv3Pz+O7gAqe1Wkezghj2iScNpgkjLf0F3BkhHL9TreRFGT306FdTJ4nMx7RNyqhj2ri+TqiZ//HPNLCrm8jXqHkca7zk9Z5eoFXN/686tuUuTDjrwxo/qghDtPHcTAT3mEuygDp8kcRW4jEwDnpXXdxPKuj8ANbxbTC5bS1Eu37D58XAVDavsxRVWkh84Mab8nKXPL7J7bEfpSOq97vdXUerYHvg+WlDvDgRCOb/UYbE99B/esqMyxGqfQiuZe/p2P5mUYDp0VaeCeKyJy6T/ed35U7pITCPT658RAxcg5VOz+pHymoiGibKAgpwxhOaP/YNDs1HhY/pPvHh3jIK/Lsw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(426003)(70206006)(2616005)(1076003)(4326008)(5660300002)(36860700001)(336012)(86362001)(508600001)(40460700001)(6666004)(82310400004)(356005)(81166007)(47076005)(36756003)(316002)(70586007)(26005)(54906003)(8936002)(110136005)(7696005)(8676002)(186003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 16:58:28.4885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc63b9a6-cd7e-4850-9889-08d9c4a31c81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4965
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to support sof audio on different variants of Google boards.
Add new entry in dmi table to enable SOF flag on Google chrome boards.
Also add newer machines to sof_machines list with codecs and amps acpi
id check to register sof sound cards on different variants.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@intel.com>
---
 sound/soc/amd/acp-config.c | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index 1493d52c9290..c0bbcdb1761d 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -35,6 +35,18 @@ static const struct config_entry config_table[] = {
 			{}
 		},
 	},
+	{
+		.flags = FLAG_AMD_SOF,
+		.device = ACP_PCI_DEV_ID,
+		.dmi_table = (const struct dmi_system_id []) {
+			{
+				.matches = {
+					DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+				},
+			},
+			{}
+		},
+	},
 };
 
 int snd_amd_acp_find_config(struct pci_dev *pci)
@@ -43,6 +55,10 @@ int snd_amd_acp_find_config(struct pci_dev *pci)
 	u16 device = pci->device;
 	int i;
 
+	/* Do not enable FLAGS on older platforms with Rev id zero */
+	if (!pci->revision)
+		return 0;
+
 	for (i = 0; i < ARRAY_SIZE(config_table); i++, table++) {
 		if (table->device != device)
 			continue;
@@ -56,7 +72,44 @@ int snd_amd_acp_find_config(struct pci_dev *pci)
 }
 EXPORT_SYMBOL(snd_amd_acp_find_config);
 
+static struct snd_soc_acpi_codecs amp_rt1019 = {
+	.num_codecs = 1,
+	.codecs = {"10EC1019"}
+};
+
+static struct snd_soc_acpi_codecs amp_max = {
+	.num_codecs = 1,
+	.codecs = {"MX98360A"}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_amd_sof_machines[] = {
+	{
+		.id = "10EC5682",
+		.drv_name = "rt5682-rt1019",
+		.pdata = (void *)&acp_quirk_data,
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &amp_rt1019,
+		.fw_filename = "sof-rn.ri",
+		.sof_tplg_filename = "sof-acp.tplg",
+	},
+	{
+		.id = "10EC5682",
+		.drv_name = "rt5682-max",
+		.pdata = (void *)&acp_quirk_data,
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &amp_max,
+		.fw_filename = "sof-rn.ri",
+		.sof_tplg_filename = "sof-acp.tplg",
+	},
+	{
+		.id = "RTL5682",
+		.drv_name = "rt5682s-max",
+		.pdata = (void *)&acp_quirk_data,
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &amp_max,
+		.fw_filename = "sof-rn.ri",
+		.sof_tplg_filename = "sof-acp.tplg",
+	},
 	{
 		.id = "AMDI1019",
 		.drv_name = "renoir-dsp",
-- 
2.25.1

