Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E5E48DBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbiAMQfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:35:02 -0500
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:40129
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236743AbiAMQfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:35:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqjPc768St8ex+ETnJ9MfOm8rpF24S6dUXi+f890cSwTtHpWj4qyIZbofkucSlekIcG5yJRgHZl7OfZO7DY1AQzv4YH3PTP52xYdID1V97CmIsdBBkmjor6jzQrMqpLD15sDvIEHROpgmHShCvH9oVsZY7qmex5yy80QlgpzLEuTU6REo3CYUToAm4+V0KHhCZdm3Ivo2gBoGfcg6zlSZF+vlySYuzzyFrJFdgOHXS5uEt0b29DtTKC90AZOpPGqG1AVzIMLhR3Mii6t942076Bgm2xeiZPy6M0sTaz4umLDFja1aXNxOpIAeO8JcLzbAF3unJUCPOu84H2RgM7S1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2m1RzSnqEB7lEjWdke8awBRfdhrc7YeH/cC/s43plRo=;
 b=EMRFZgAn3Z9bEVpSEGkq6pGZj5QIlhcSTncahEaBr4XpP7FgtSW13PpkPEYGmuF1iIjrqQjlWMc5RTwHRCbp05x4QeTVseX8hss8h7WSHQNkyNmJui6Sdxdy7bKRQr5sQNgy0ZeAuWhoQLOQwZr4ZFkFYeqn0LQf84JhLBcPCuLY3sKQWXHuTMG0F6eR/TLw8crdzoTpQE5yu3MpE+asyCQzP/00XBsDfJSy6hS/S5FQlU/Km5La2ZCBsVpMOA9Fule2FMlVzrv3X1IhojAWqFyvNVcvhCydyWYEJesiXFlJMdgCaeTjYiUHHrX//kk1zkQsnQRQrHB2lJROqiVoSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m1RzSnqEB7lEjWdke8awBRfdhrc7YeH/cC/s43plRo=;
 b=ApkoBGBYk7M2ShfpFUMOVrrFgJiOoWLawyKWMohWDjy8hVx/I9L0ye0rpwQ7VvvNWidWrx3I3e3xFTwsdFjfCwgD3Y9zvOGckJPcyRrgwviIrZe4RmbWsmz911XV1nhSvUfmzJKt5SEB4j8Q3o++m+h2o/IjVKQBa+SMa3ehQaE=
Received: from BN8PR07CA0034.namprd07.prod.outlook.com (2603:10b6:408:ac::47)
 by BY5PR12MB3860.namprd12.prod.outlook.com (2603:10b6:a03:1ac::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 16:34:57 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::ae) by BN8PR07CA0034.outlook.office365.com
 (2603:10b6:408:ac::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Thu, 13 Jan 2022 16:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 16:34:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 10:34:56 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 10:34:56 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 13 Jan 2022 10:34:52 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        "V sujith kumar Reddy" <vsujithkumar.reddy@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/6] ASoC: amd: acp: Add PDM controller based dmic dai for Renoir
Date:   Thu, 13 Jan 2022 22:03:44 +0530
Message-ID: <20220113163348.434108-3-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113163348.434108-1-AjitKumar.Pandey@amd.com>
References: <20220113163348.434108-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c9b0a65-cd72-487c-a359-08d9d6b2a2cb
X-MS-TrafficTypeDiagnostic: BY5PR12MB3860:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB38608B68B29E5BFDF3CD244582539@BY5PR12MB3860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oe4MJ+V2PvG0MoKGVisfa5WOe9UxG8T/nbQcULJshiNT3+vzZIouosHiKgJ1MvjQq7vSkoJQP/IZYbMXVCBTVezt406SCTlc+18AKz84PuPA2Y/sCjCgSug+at0p1yHyhFLAiz9DWPAr2LuQmCVotb3ShRT/3NOst5nsBd7ismqTN1F4sxNf6NWZQJ5IpIUm2j9V6cUiWqyAO4ILLm6r1kBR1ZyqMnK0cRm08QMbKY3aE2RDPOGWdVi0nrxZpq683XBNBNq72/EkFI1eOwJx5wbY+ju9xwdwsz0WubPgsnPd/d3CIvadX0b7TwqFjhzCJ+rNR6wJDjXbvNGMMpiTMEdJLUWUkFskXZfHum708xxg7pGygsASKHukgDDfu/Y1WAkPn+gSS/Vanx3shtmn9Em9sNaWI6XPlNVKrSuZCLMvxwUOxMcGnuIMUSsn8MpJRorLc7FZz86E3rrcPieuH48VdT+lBdtPA9haGfGxtWWUnItxLxFjKDE8FEbhtU4XnRh1bA3rX5s70BdFEWhLxjYWM/JmZrNgK4PESbDlJt3Dbjb8L/4RZ0pvs7myooPLOSURiboTbQCnNxUbQ2iskEvaZhAamyqguZH5sUIbAv50CclsHiwbHQ/bjynkCyxU0f65uDb1nkLLMKJ5X5+tNEqyCQ6AXm+cnhisXYXLYqZaEBipZFHM9F8ZMKqyehuc6eXCH/9lPSeAnxifIrSVk+xIylaqwuw4VPHQqZF1g3QNk4+I8+NAaZ7Hg7XKGjO+wgjzjK9OL/Xsmvs2Lh8Gce0kv7VbAZHfkhb7EMf7Y8c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(110136005)(47076005)(40460700001)(336012)(81166007)(426003)(54906003)(4326008)(5660300002)(356005)(316002)(82310400004)(26005)(36860700001)(36756003)(6666004)(1076003)(186003)(7696005)(8676002)(86362001)(8936002)(83380400001)(70586007)(508600001)(70206006)(2906002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 16:34:57.2944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9b0a65-cd72-487c-a359-08d9d6b2a2cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3860
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renoir ACP IP has a PDM controller block. Add DMIC dai instance in
dai_driver struct to enable dmic capture support on Renoir platform.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/Kconfig      |  1 +
 sound/soc/amd/acp/acp-renoir.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 2e6d0259f2e9..f4ca7843391b 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -29,6 +29,7 @@ config SND_AMD_ASOC_RENOIR
 	tristate "AMD ACP ASOC Renoir Support"
 	select SND_SOC_AMD_ACP_PCM
 	select SND_SOC_AMD_ACP_I2S
+	select SND_SOC_AMD_ACP_PDM
 	depends on X86 && PCI
 	help
 	  This option enables Renoir I2S support on AMD platform.
diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index 9b321a055b52..770a57a0677b 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -97,6 +97,19 @@ static struct snd_soc_dai_driver acp_renoir_dai[] = {
 	.ops = &asoc_acp_cpu_dai_ops,
 	.probe = &asoc_acp_i2s_probe,
 },
+{
+	.name = "acp-pdm-dmic",
+	.id = DMIC_INSTANCE,
+	.capture = {
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 2,
+		.rate_min = 8000,
+		.rate_max = 48000,
+	},
+	.ops = &acp_dmic_dai_ops,
+},
 };
 
 static int renoir_audio_probe(struct platform_device *pdev)
-- 
2.25.1

