Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1540648D502
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiAMJaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:30:08 -0500
Received: from mail-dm3nam07on2070.outbound.protection.outlook.com ([40.107.95.70]:30113
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233424AbiAMJaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:30:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKPZDaHWLbKwQ3BSHvDRVeMXeKF+VqsQu+D9JgIu/2v+mG0EXuLmmbdF+/l+8j145RSruIcsmt2bA1AP5FXVNdyTvCYzymoHjoKqCwI+p/aF8Jby95TNZaV9JqHw8n9Rx8ynLhoZAiGaD4SDASuGrHRvgSvf/RpkRtjUlewjJtYC///50fd/HEbO/y0Op2irUbRdp9XCrwyPnhRU6XXtnUi5Fnj2Kn8JFhdOtXUn9mTxKoVZh2FEnON192nBYbFv+6gk6bTvTNAPY5zXQEBVGLWL3qd6PAG8xk+A5B85awBK1mE3ig8BSbwEupx7xyXv4LzCdEkjyFq4BIb8NIZhkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2m1RzSnqEB7lEjWdke8awBRfdhrc7YeH/cC/s43plRo=;
 b=QwX9jhRvrdfw8WJQn1Fey0T6y+Bbv6yNIyu5k2+mjcIMghdllvhQje1GJWBKVIkv51Pf/HGgqAE2Qvlw8KXUFdNkYOOTF4kTjhjH5A78l7o/ZmoHnygNhaawApBeQ7LzJJubgphtVy5XPUz0+SV7f41z3glxX/UEyaAZ7iLDVsX+N9VP9wBYPYcr9QZa6Lk2MXQwhtrihLENgd++xxhZXn2Kc570+z3//536W2Ak6oBc3Xr9RYdpF6lIlsuhwrn6cDsgNwQRiWVBH+IrwExQ3DzssXY8IZNCTQeAmsF2/sR0M2rjbqEY0wm//eVZloV1kIJrBw+Z5ZzHU3tjQd9XtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m1RzSnqEB7lEjWdke8awBRfdhrc7YeH/cC/s43plRo=;
 b=yAHJfNUP0LCQEVNZdh56EUTdJB4YhwKQESToUjjTjDqus8LrurLMIli5zXf7BUOp81TagWSo3GXVAGS+QkE2KUTAkPKTAIDI1DKZaNvfkrDtlJucLUB9i7k1ebvvQLnNsXotPWRs92w7Xkt68IXIA74MZoi/jvtH6+akOO4fSvw=
Received: from MWHPR14CA0061.namprd14.prod.outlook.com (2603:10b6:300:81::23)
 by MN2PR12MB3229.namprd12.prod.outlook.com (2603:10b6:208:102::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 09:30:01 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::df) by MWHPR14CA0061.outlook.office365.com
 (2603:10b6:300:81::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Thu, 13 Jan 2022 09:30:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 09:30:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 03:29:59 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 13 Jan 2022 03:29:56 -0600
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
Subject: [PATCH 2/6] ASoC: amd: acp: Add PDM controller based dmic dai for Renoir
Date:   Thu, 13 Jan 2022 14:58:38 +0530
Message-ID: <20220113092842.432101-3-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113092842.432101-1-AjitKumar.Pandey@amd.com>
References: <20220113092842.432101-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2936710b-5673-4b4e-f42e-08d9d67745ec
X-MS-TrafficTypeDiagnostic: MN2PR12MB3229:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB322944CC40DC56AFAB47465782539@MN2PR12MB3229.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4dn0VoQAqMkAaKs7CJ8UJCVVZQlomDQcqbK3xKPbvsrsYyqgv0QatR5o3QAVI9XnTtasDv4AKm2QW8nft8RmPxH4u0Eo9zjZHe3GV1Jf8Qlga7C6mMTVpRGbx9OCj/U/e069733aRqVLgeFm/N42+tfoLCVAPerpLbcmSM4wbrpgsZWulDGaNjIJpe2Et5vPSe6JnvH+k9+uIAzBDcxVFt8e4j3CiLRHbkVmbDeGpVUJAi0vAhmRorHP6Vk10uacvgdfKE7t1W/DHLclsZFVXi3pNoRhsnYcv2UWwmTBY0tKe3sbeWjbLDw41HfxR1jSM7VrBoBeCR5e2UQJoYCDpZ0+dthQjHhJA0o6Kt0lg3eA5yILxVfi/sj/n2Un6vufc7mo0/gCvoV5WhIlvvO6ZJxskLhBdJ3WNleju7PzS6XSK9UlLq7jQ0kgBUZUl4f5C/46AjB8PSnv8ukh/6JC13XImiCFwT6sj3HYQYd574d3wiNfVm++FQ+GcGBpU/Nqq84JA9Qwb9rIOayv63KoSSQX/NxSgyOCj6e8G0IVTRMuYPiLP1fLqriN0VC4yUccNNlbWmJL1T8DW7n9u/eZodPfGw/Crga4tRzykIY4J2hG3TTbD8MIuFTRS6aSefN685HDWOiXR5MHHQgXUpoAusvs9RRAfDYv52/VJO8RJHnaOz4AMoKQsp9CK1V/pwL/4BEs3hJycZR6XSbvUE145dRwqUxN5JOJGN5UMJxy3Bve4f7AyhHPy0XSnz1D6f3hfg9WlU+Wj+6PQCNQTF210ulByhV2eQNPWdHNa1emRA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(83380400001)(36756003)(70586007)(86362001)(70206006)(110136005)(316002)(5660300002)(356005)(186003)(26005)(81166007)(54906003)(8936002)(47076005)(7696005)(6666004)(36860700001)(508600001)(2906002)(1076003)(8676002)(40460700001)(4326008)(336012)(2616005)(426003)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 09:30:01.0682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2936710b-5673-4b4e-f42e-08d9d67745ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3229
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

