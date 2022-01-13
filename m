Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B3F48DBDF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiAMQex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:34:53 -0500
Received: from mail-dm6nam12on2075.outbound.protection.outlook.com ([40.107.243.75]:52800
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229474AbiAMQew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:34:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZ5GEwo2JWJUCM1PHM8dzt5Zeg4JKZO18dsil8b5Z9VcmyL9M2ury6yDm+lkmIxf5f22vPTQMt91Zaf0cwP3aJ9wb4vm863eENPu8hOgP8HyQYA55dnwVBEyunLADpvPwL4HArjifnZ6l/IzAP6w/v6hB0ewAIUxmKvWAkhx0p34eLvuhmb5dY3Qaz56eX3//mmEB5c/V/ICYatpXy6Dx89TVenanNCJj2t1Kbd/KpsEQxi3lIpCgrFY7UR1mqlZ4PPXg3U4forbbaxQO5FQ+CxGrjsB4eVhJQd38Ixl+6O1Dz04whWw0NyM+RCCO55lAQi0BAktRnvx6rhOIyCZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLiAmrUjqXbine4/4G+vGheCp7mbn2rY0hch9rU2BXk=;
 b=Sdgqo5rgXrm+e7bJtqjwDZeFCPL0MP2CWjDC49Thb/ufpH08QBsJbWEx+hHfDqmpvxjtdNv1GhK8Iyl/rV/rwm+J9qNCIIVAtpUbvIkvv/Dnd0oRvhfUgyT7Lq+PA5XnCJqQrUg7CEVkKglkvKFLVvbS4q6Bqcq4rBfoeSpXLR1zA/fekEBCv85JoaHEqwRjdiwmLYOqUYe4E5rtv7adpVWXeh2Cn3IPlrJ8AI79Wf2ECvUMRSZfAtF1TGH/eLbdbQ5yEmcYHM/0qFP9xpLZaEssOMAf3qJ0EfUkxs9ktAOBuumWGreaDNUtO2HBw9nhKhpQSveeDz5VYRv6zFpmWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLiAmrUjqXbine4/4G+vGheCp7mbn2rY0hch9rU2BXk=;
 b=HdENYGU2INqF/HE3z2rYObLXanrKDLDm4kckU9IkmYnB4tRs2x4qhmEv9FPpgTRz7ipwj7pH/aGnmazgoXho/G9GYLYE52+1zUwEbCL7XvBCVySf0nO8Y25j635kNvIm9kHui0Wj0Wmu/WXE50On/qnVBWtkOmnUS1F1FdI/9l4=
Received: from CO2PR04CA0124.namprd04.prod.outlook.com (2603:10b6:104:7::26)
 by BL0PR12MB2529.namprd12.prod.outlook.com (2603:10b6:207:4e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 13 Jan
 2022 16:34:50 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::fb) by CO2PR04CA0124.outlook.office365.com
 (2603:10b6:104:7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Thu, 13 Jan 2022 16:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 16:34:49 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 10:34:46 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 08:34:46 -0800
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 13 Jan 2022 10:34:42 -0600
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
Subject: [PATCH v2 1/6] ASoC: amd: acp: Add generic support for PDM controller on ACP
Date:   Thu, 13 Jan 2022 22:03:43 +0530
Message-ID: <20220113163348.434108-2-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113163348.434108-1-AjitKumar.Pandey@amd.com>
References: <20220113163348.434108-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1def48e9-5d5b-4c80-eba8-08d9d6b29e22
X-MS-TrafficTypeDiagnostic: BL0PR12MB2529:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB25290026D675D0D8FCCDC47782539@BL0PR12MB2529.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hcyFLPHNS9bDVGgeymSLWsK+IbIL6mJMvSGXnTCeJRM5zpENfqpEUaB6Ae7Hdl/F4em44xwHDg2+bZ1vbgbXQOKmJ5uIPGGo58FwhWZjbCabJlYkPWug/sb3hYJFT4QqrxUT50ElMLglUUjUbsmjQD9opyMqy2pikyclWvpFpQLCm6jgKrR32QoDj2pMfg2faX1kZNV7h8AZyHisrDzTCPDIywewt/gYee8MKPPSnclgaQwWSsrXaTXnYGaY2Jx0cgEgnz4uyUKa/4ArdULhkJ5Pm9mvukP4TceZVDRRH8aLr0HRVLHidfnBGxAjPKnkmPCuJ56tZ2XRAWQlxMSSGjTepJBJeUOi6xx/AW6CTChFubYKpme/1UOusJZyZEoaAT1xnui8z6hLvO35tVwI9/IJSV792cc4HDyMEMIlr1KH3uAK/RFu895SHhn05epKVQTVo3S0i0x8pyV6mDjYk5LlYHkp1s1JIJUGfuMtbHlmMhIOBjYoWpAsMjYaXK3ZtoEtd5AB79/tOWIq/hC8pJJXjwG+SuohAbic5tzxjic7jPnQYl7WvIWXhfuzLGc2uTiULA2KmevE0bqcDEERkYtterOE8YaiZ8PH0i4FYBPWYeOmZ/AdDENVFT269JsPQpnuZ78c0czwMaQbcjchSFmzJhSoH2eIpFaqIQBKJQt31tih8zelvZmx+Ll2y/kFsqVy6Z6yOJwRuv6DDxmwT2qt8Mq0Z6ex0s2JDMxkuri7WbuShwdFjRkiFg7NmfAmltopzwDfa7xS0sbVtcwisVLS23/QOjCH/VfLjcyMhIylaSehkU8yxFNVYHiJB7fK
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(86362001)(356005)(316002)(1076003)(36756003)(83380400001)(508600001)(54906003)(7696005)(81166007)(4326008)(82310400004)(426003)(2906002)(70586007)(70206006)(110136005)(47076005)(26005)(186003)(40460700001)(36860700001)(336012)(2616005)(5660300002)(8936002)(8676002)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 16:34:49.3684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1def48e9-5d5b-4c80-eba8-08d9d6b29e22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2529
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
 sound/soc/amd/acp/acp-pdm.c          | 181 +++++++++++++++++++++++++++
 sound/soc/amd/acp/amd.h              |   9 +-
 sound/soc/amd/acp/chip_offset_byte.h |  20 +++
 5 files changed, 214 insertions(+), 1 deletion(-)
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
index 000000000000..cb9bbd795eee
--- /dev/null
+++ b/sound/soc/amd/acp/acp-pdm.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2021 Advanced Micro Devices, Inc.
+//
+// Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
+//	    Vijendar Mukunda <Vijendar.Mukunda@amd.com>
+//
+
+/*
+ * Generic Hardware interface for ACP Audio PDM controller
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include <linux/dma-mapping.h>
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
+
+static int acp_dmic_dai_trigger(struct snd_pcm_substream *substream,
+			       int cmd, struct snd_soc_dai *dai)
+{
+	struct acp_stream *stream = substream->runtime->private_data;
+	struct device *dev = dai->component->dev;
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+	u32 physical_addr, size_dmic, period_bytes;
+	unsigned int dma_enable;
+	int ret = 0;
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
+	struct snd_pcm_hw_params *hwparams, struct snd_soc_dai *dai)
+{
+	struct device *dev = dai->component->dev;
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+	unsigned int dmic_ctrl, channels, ch_mask;
+
+	/* Enable default DMIC clk */
+	writel(PDM_CLK_FREQ_MASK, adata->acp_base + ACP_WOV_CLK_CTRL);
+	dmic_ctrl = readl(adata->acp_base + ACP_WOV_MISC_CTRL);
+	dmic_ctrl |= PDM_MISC_CTRL_MASK;
+	writel(dmic_ctrl, adata->acp_base + ACP_WOV_MISC_CTRL);
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
+		struct snd_soc_dai *dai)
+{
+	struct acp_stream *stream = substream->runtime->private_data;
+	struct device *dev = dai->component->dev;
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+	u32 ext_int_ctrl;
+
+	stream->dai_id = DMIC_INSTANCE;
+	stream->irq_bit = BIT(PDM_DMA_STAT);
+	stream->pte_offset = ACP_SRAM_PDM_PTE_OFFSET;
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
+		struct snd_soc_dai *dai)
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
+	.hw_params = acp_dmic_hwparams,
+	.trigger   = acp_dmic_dai_trigger,
+	.startup = acp_dmic_dai_startup,
+	.shutdown = acp_dmic_dai_shutdown,
+};
+EXPORT_SYMBOL_NS_GPL(acp_dmic_dai_ops, SND_SOC_ACP_COMMON);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:"DRV_NAME);
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

