Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78A449080D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiAQMAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:00:10 -0500
Received: from mail-bn8nam12on2073.outbound.protection.outlook.com ([40.107.237.73]:45153
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236894AbiAQMAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:00:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LE9jGOqiuq6CHp/UiZzGmvO/n8wCWLO8FXf6HLac5BYNFhrIcH2kakwASr6262eRg+lqeEr/tLjujToPnljXB9QEwPF2AXuiDOg3FyXWHunqxkpQ6ZfH0W9Hm7io8Hg8bFZR9jZpLzNq7uVa7jAJn1/eJSXJEciw9TvXWm3ujANH3al9vl+NCjLU8LHNfzRyfZ+fFW7x/7wBp5XpEOjwPmEyM6FVkVZAsu2z3hXDHSXEd9Ixw6BDVpTR9S0S+dSGN9Dilz8eZ1BHzzgWy/dObvPrMkXx/qMuDI3UFkJPYhXjXjvci7s5Hw83zYM+CvCo3uf15WVfY8AaeMmcdRFo9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvlHiRQL+8FDbFBTeRUsx7PYZCf4wLPQL0b6Nn8KidY=;
 b=bamTVBPe5Z1K1/zg4PBp0Hj9TjGisowkbldhn9TzWSYwgZ2A00cFRynqG6niE46jXC9OC3hi5EGIjNdPyhCoCoATM1GcDgiwbD8qXcCu3CxV47whc8kT4Ebh369EYlINROxpR/LeJAeYF1B6L4GOSUSqtqhdepF4sYL2/K26/U4//BUBPPNefpd62uXENCJkZ7VW2ZlWHMOM0+VHnpUGkpK+b3VDgXFrcEVy1xxvh4h/8gmXT5/blWvQHU6FaNF4wyDquAfv9+bvUk6NPOaGjCRGadhMPiv8X/yJQ6vaVolROx8hb6UKpdKxqBoe4wp/zsHSXpKhXa2B77pGyt2YEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvlHiRQL+8FDbFBTeRUsx7PYZCf4wLPQL0b6Nn8KidY=;
 b=UvjXaNDnrMAzo2GNICr8LxJX8+HPs9X3Epv4NlIAuvx32A7aQXM8EUuko81S2i3R5bHY9j7rcUIBaTXV6nPUShwh1ROuTEyf17cMu2EMMTYhfA8yjS7xNpFWNbHDXSPlP6kdLu/piw8mDGbHh8Kjl7r1H9xtC1MRsVPLYt8ekmU=
Received: from MWHPR1601CA0012.namprd16.prod.outlook.com
 (2603:10b6:300:da::22) by BN6PR12MB1442.namprd12.prod.outlook.com
 (2603:10b6:405:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Mon, 17 Jan
 2022 12:00:00 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::ae) by MWHPR1601CA0012.outlook.office365.com
 (2603:10b6:300:da::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Mon, 17 Jan 2022 11:59:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 11:59:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 05:59:58 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 05:59:58 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 17 Jan 2022 05:59:54 -0600
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
Subject: [PATCH v3 1/6] ASoC: amd: acp: Add generic support for PDM controller on ACP
Date:   Mon, 17 Jan 2022 17:28:49 +0530
Message-ID: <20220117115854.455995-2-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117115854.455995-1-AjitKumar.Pandey@amd.com>
References: <20220117115854.455995-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c559f3a-dc94-4199-395d-08d9d9b0e313
X-MS-TrafficTypeDiagnostic: BN6PR12MB1442:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1442E34F40BB12B76FAB97E182579@BN6PR12MB1442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nincPhbjzzLXXTY5lYu6xMf3qd9jJbzAVwrMnZ6J0T+1dnah8zfBI+9fAAgvJrjjjb4UYXRBUyi/Pt4kdqbhOiJXaaTbXEPbkNQmabBM2RuexsRXwaHX8rQvKUGrXfji68V0sjGeADo5McAwxb4LzWdAbsCl31EZNzzC0TWAst0voAtM4uPVJP4YUcQSgrqPLoC8lGcikEkdsgsKdNx9o9k86CC5oAIXQu3pKC1is6c+lkwP4k19q4Ok+JoV5Vh4xE8wx7o4U6XsOXYcHiWvF6iNs6Lp7lQKle1zrpUlsQovJm0FF7iFynzh2nTWWwmFbTl0oUhe+13MeN4uRTjULhoI9HLZYGCUtwdM5a7m+bYlpc9TId2FT/IUSDEGN2tdNW2sKEkWAdqmgrQqIW5QxgX3s9odGsYL9phSa0LMc4D4b8IqG0yaWPEgE/5sdevbscHDJS6FSCsVUbS4xIze/rXWWk0JqFFw5H6crZHrUv8bMHrlFD+LAT+Oofh1/SiZ71EM4Nu6mnGLCPPtReI8vFuMlw5nq8XUAW1zePy3bWiZZ8FMo2sZgZeSubIyufn6YrY86Y4KZMYdXAjFtq4UCLTFULqc2n871rTQ+7kbtK8fbz68ZLfTfe7LlGcwlaIU6USRkTnur+RXWO+Wa0nz0pOVZsX/20qYe9ECSLXFBy5iANuGQLAOKjtn0ERYwZP2RtXSoasvSlkNZ6DwhzLfYy8XvPTwHOib6pw24hTOwQs3xGUApFxdpG9LpknFrQeV3wl14PJ5weB9jTdDfDEBaF4V2oosf0FfYy2WQUQe9KUHygjYWeTmdtabwflcN4mu
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(7696005)(47076005)(70206006)(86362001)(186003)(6666004)(110136005)(26005)(40460700001)(316002)(82310400004)(54906003)(83380400001)(70586007)(5660300002)(36756003)(508600001)(81166007)(426003)(356005)(1076003)(2616005)(8676002)(2906002)(4326008)(36860700001)(8936002)(336012)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 11:59:59.5076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c559f3a-dc94-4199-395d-08d9d9b0e313
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1442
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver module for PDM controller on ACP IP block. Expose dai
ops to configure ACP_WOV_PDM_BLOCK registers on ACP. Such dai ops
will be used by platform specific driver module to register dmic
related dai with ASoC.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/Kconfig            |   3 +
 sound/soc/amd/acp/Makefile           |   2 +
 sound/soc/amd/acp/acp-pdm.c          | 193 +++++++++++++++++++++++++++
 sound/soc/amd/acp/amd.h              |   9 +-
 sound/soc/amd/acp/chip_offset_byte.h |  20 +++
 5 files changed, 226 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/amd/acp/acp-pdm.c

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index d5838df3064b..2e6d0259f2e9 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -15,6 +15,9 @@ config SND_SOC_AMD_ACP_COMMON
 
 if SND_SOC_AMD_ACP_COMMON
 
+config SND_SOC_AMD_ACP_PDM
+	tristate
+
 config SND_SOC_AMD_ACP_I2S
 	tristate
 
diff --git a/sound/soc/amd/acp/Makefile b/sound/soc/amd/acp/Makefile
index 16c144c2965c..66cac95432f6 100644
--- a/sound/soc/amd/acp/Makefile
+++ b/sound/soc/amd/acp/Makefile
@@ -7,6 +7,7 @@
 #common acp driver
 snd-acp-pcm-objs     := acp-platform.o
 snd-acp-i2s-objs     := acp-i2s.o
+snd-acp-pdm-objs     := acp-pdm.o
 
 #platform specific driver
 snd-acp-renoir-objs     := acp-renoir.o
@@ -18,6 +19,7 @@ snd-acp-sof-mach-objs     := acp-sof-mach.o
 
 obj-$(CONFIG_SND_SOC_AMD_ACP_PCM) += snd-acp-pcm.o
 obj-$(CONFIG_SND_SOC_AMD_ACP_I2S) += snd-acp-i2s.o
+obj-$(CONFIG_SND_SOC_AMD_ACP_PDM) += snd-acp-pdm.o
 
 obj-$(CONFIG_SND_AMD_ASOC_RENOIR) += snd-acp-renoir.o
 
diff --git a/sound/soc/amd/acp/acp-pdm.c b/sound/soc/amd/acp/acp-pdm.c
new file mode 100644
index 000000000000..424c6e0bb9d6
--- /dev/null
+++ b/sound/soc/amd/acp/acp-pdm.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2022 Advanced Micro Devices, Inc.
+//
+// Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
+//	    Vijendar Mukunda <Vijendar.Mukunda@amd.com>
+//
+
+/*
+ * Generic Hardware interface for ACP Audio PDM controller
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "amd.h"
+
+#define DRV_NAME "acp-pdm"
+
+#define PDM_DMA_STAT		0x10
+#define PDM_DMA_INTR_MASK	0x10000
+#define PDM_DEC_64		0x2
+#define PDM_CLK_FREQ_MASK	0x07
+#define PDM_MISC_CTRL_MASK	0x10
+#define PDM_ENABLE		0x01
+#define PDM_DISABLE		0x00
+#define DMA_EN_MASK		0x02
+#define DELAY_US		5
+#define PDM_TIMEOUT		1000
+#define ACP_REGION2_OFFSET	0x02000000
+
+static int acp_dmic_prepare(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	struct acp_stream *stream = substream->runtime->private_data;
+	struct device *dev = dai->component->dev;
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+	u32 physical_addr, size_dmic, period_bytes;
+	unsigned int dmic_ctrl;
+
+	/* Enable default DMIC clk */
+	writel(PDM_CLK_FREQ_MASK, adata->acp_base + ACP_WOV_CLK_CTRL);
+	dmic_ctrl = readl(adata->acp_base + ACP_WOV_MISC_CTRL);
+	dmic_ctrl |= PDM_MISC_CTRL_MASK;
+	writel(dmic_ctrl, adata->acp_base + ACP_WOV_MISC_CTRL);
+
+	period_bytes = frames_to_bytes(substream->runtime,
+			substream->runtime->period_size);
+	size_dmic = frames_to_bytes(substream->runtime,
+			substream->runtime->buffer_size);
+
+	physical_addr = stream->reg_offset + MEM_WINDOW_START;
+
+	/* Init DMIC Ring buffer */
+	writel(physical_addr, adata->acp_base + ACP_WOV_RX_RINGBUFADDR);
+	writel(size_dmic, adata->acp_base + ACP_WOV_RX_RINGBUFSIZE);
+	writel(period_bytes, adata->acp_base + ACP_WOV_RX_INTR_WATERMARK_SIZE);
+	writel(0x01, adata->acp_base + ACPAXI2AXI_ATU_CTRL);
+
+	return 0;
+}
+
+static int acp_dmic_dai_trigger(struct snd_pcm_substream *substream,
+				int cmd, struct snd_soc_dai *dai)
+{
+	struct device *dev = dai->component->dev;
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+	unsigned int dma_enable;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		dma_enable = readl(adata->acp_base + ACP_WOV_PDM_DMA_ENABLE);
+		if (!(dma_enable & DMA_EN_MASK)) {
+			writel(PDM_ENABLE, adata->acp_base + ACP_WOV_PDM_ENABLE);
+			writel(PDM_ENABLE, adata->acp_base + ACP_WOV_PDM_DMA_ENABLE);
+		}
+
+		ret = readl_poll_timeout_atomic(adata->acp_base + ACP_WOV_PDM_DMA_ENABLE,
+						dma_enable, (dma_enable & DMA_EN_MASK),
+						DELAY_US, PDM_TIMEOUT);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		dma_enable = readl(adata->acp_base + ACP_WOV_PDM_DMA_ENABLE);
+		if ((dma_enable & DMA_EN_MASK)) {
+			writel(PDM_DISABLE, adata->acp_base + ACP_WOV_PDM_ENABLE);
+			writel(PDM_DISABLE, adata->acp_base + ACP_WOV_PDM_DMA_ENABLE);
+
+		}
+
+		ret = readl_poll_timeout_atomic(adata->acp_base + ACP_WOV_PDM_DMA_ENABLE,
+						dma_enable, !(dma_enable & DMA_EN_MASK),
+						DELAY_US, PDM_TIMEOUT);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int acp_dmic_hwparams(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *hwparams, struct snd_soc_dai *dai)
+{
+	struct device *dev = dai->component->dev;
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+	unsigned int channels, ch_mask;
+
+	channels = params_channels(hwparams);
+	switch (channels) {
+	case 2:
+		ch_mask = 0;
+		break;
+	case 4:
+		ch_mask = 1;
+		break;
+	case 6:
+		ch_mask = 2;
+		break;
+	default:
+		dev_err(dev, "Invalid channels %d\n", channels);
+		return -EINVAL;
+	}
+
+	if (params_format(hwparams) != SNDRV_PCM_FORMAT_S32_LE) {
+		dev_err(dai->dev, "Invalid format:%d\n", params_format(hwparams));
+		return -EINVAL;
+	}
+
+	writel(ch_mask, adata->acp_base + ACP_WOV_PDM_NO_OF_CHANNELS);
+	writel(PDM_DEC_64, adata->acp_base + ACP_WOV_PDM_DECIMATION_FACTOR);
+
+	return 0;
+}
+
+static int acp_dmic_dai_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct acp_stream *stream = substream->runtime->private_data;
+	struct device *dev = dai->component->dev;
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+	u32 ext_int_ctrl;
+
+	stream->dai_id = DMIC_INSTANCE;
+	stream->irq_bit = BIT(PDM_DMA_STAT);
+	stream->pte_offset = ACP_SRAM_PDM_PTE_OFFSET;
+	stream->reg_offset = ACP_REGION2_OFFSET;
+
+	/* Enable DMIC Interrupts */
+	ext_int_ctrl = readl(adata->acp_base + ACP_EXTERNAL_INTR_CNTL);
+	ext_int_ctrl |= PDM_DMA_INTR_MASK;
+	writel(ext_int_ctrl, adata->acp_base + ACP_EXTERNAL_INTR_CNTL);
+
+	return 0;
+}
+
+static void acp_dmic_dai_shutdown(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct device *dev = dai->component->dev;
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+	u32 ext_int_ctrl;
+
+	/* Disable DMIC interrrupts */
+	ext_int_ctrl = readl(adata->acp_base + ACP_EXTERNAL_INTR_CNTL);
+	ext_int_ctrl |= ~PDM_DMA_INTR_MASK;
+	writel(ext_int_ctrl, adata->acp_base + ACP_EXTERNAL_INTR_CNTL);
+}
+
+const struct snd_soc_dai_ops acp_dmic_dai_ops = {
+	.prepare	= acp_dmic_prepare,
+	.hw_params	= acp_dmic_hwparams,
+	.trigger	= acp_dmic_dai_trigger,
+	.startup	= acp_dmic_dai_startup,
+	.shutdown	= acp_dmic_dai_shutdown,
+};
+EXPORT_SYMBOL_NS_GPL(acp_dmic_dai_ops, SND_SOC_ACP_COMMON);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS(DRV_NAME);
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 8eee3d34774b..567355209a5c 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -17,8 +17,9 @@
 
 #define I2S_SP_INSTANCE			0x00
 #define I2S_BT_INSTANCE			0x01
+#define DMIC_INSTANCE			0x02
 
-#define MEM_WINDOW_START		0x4000000
+#define MEM_WINDOW_START		0x4080000
 
 #define ACP_I2S_REG_START		0x1242400
 #define ACP_I2S_REG_END			0x1242810
@@ -38,6 +39,7 @@
 #define ACP_SRAM_SP_CP_PTE_OFFSET	0x100
 #define ACP_SRAM_BT_PB_PTE_OFFSET	0x200
 #define ACP_SRAM_BT_CP_PTE_OFFSET	0x300
+#define ACP_SRAM_PDM_PTE_OFFSET		0x400
 #define PAGE_SIZE_4K_ENABLE		0x2
 
 #define I2S_SP_TX_MEM_WINDOW_START	0x4000000
@@ -96,6 +98,7 @@ struct acp_dev_data {
 };
 
 extern const struct snd_soc_dai_ops asoc_acp_cpu_dai_ops;
+extern const struct snd_soc_dai_ops acp_dmic_dai_ops;
 
 int asoc_acp_i2s_probe(struct snd_soc_dai *dai);
 int acp_platform_register(struct device *dev);
@@ -131,6 +134,10 @@ static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int
 			high = readl(adata->acp_base + ACP_I2S_RX_LINEARPOSITIONCNTR_HIGH);
 			low = readl(adata->acp_base + ACP_I2S_RX_LINEARPOSITIONCNTR_LOW);
 			break;
+		case DMIC_INSTANCE:
+			high = readl(adata->acp_base + ACP_WOV_RX_LINEARPOSITIONCNTR_HIGH);
+			low = readl(adata->acp_base + ACP_WOV_RX_LINEARPOSITIONCNTR_LOW);
+			break;
 		default:
 			dev_err(adata->dev, "Invalid dai id %x\n", dai_id);
 			return -EINVAL;
diff --git a/sound/soc/amd/acp/chip_offset_byte.h b/sound/soc/amd/acp/chip_offset_byte.h
index c7f77e975dc7..e38589a142e9 100644
--- a/sound/soc/amd/acp/chip_offset_byte.h
+++ b/sound/soc/amd/acp/chip_offset_byte.h
@@ -73,4 +73,24 @@
 #define ACP_BTTDM_ITER                                0x280C
 #define ACP_BTTDM_TXFRMT                              0x2810
 
+/* Registers from ACP_WOV_PDM block */
+
+#define ACP_WOV_PDM_ENABLE                            0x2C04
+#define ACP_WOV_PDM_DMA_ENABLE                        0x2C08
+#define ACP_WOV_RX_RINGBUFADDR                        0x2C0C
+#define ACP_WOV_RX_RINGBUFSIZE                        0x2C10
+#define ACP_WOV_RX_LINKPOSITIONCNTR                   0x2C14
+#define ACP_WOV_RX_LINEARPOSITIONCNTR_HIGH            0x2C18
+#define ACP_WOV_RX_LINEARPOSITIONCNTR_LOW             0x2C1C
+#define ACP_WOV_RX_INTR_WATERMARK_SIZE                0x2C20
+#define ACP_WOV_PDM_FIFO_FLUSH                        0x2C24
+#define ACP_WOV_PDM_NO_OF_CHANNELS                    0x2C28
+#define ACP_WOV_PDM_DECIMATION_FACTOR                 0x2C2C
+#define ACP_WOV_PDM_VAD_CTRL                          0x2C30
+#define ACP_WOV_BUFFER_STATUS                         0x2C58
+#define ACP_WOV_MISC_CTRL                             0x2C5C
+#define ACP_WOV_CLK_CTRL                              0x2C60
+#define ACP_PDM_VAD_DYNAMIC_CLK_GATING_EN             0x2C64
+#define ACP_WOV_ERROR_STATUS_REGISTER                 0x2C68
+
 #endif
-- 
2.25.1

