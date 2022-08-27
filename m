Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CF05A3905
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiH0RAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiH0RA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:00:26 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C1D140AA
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNqTZd0AJoPQ1JGFEtHtCIdITjs9Qs0oP4bnZYFdmE8/T327JVVTN3Eehl523XeD9z7abHXigzcLYz/JfLjJN1H/nERjJbkzog/oDMDZ/MYV7g/qdbFMoNksfxkA/aVxoZdafu71ZQIH5ygQ43fEzj59cYlIjKV0FRa/6hGALef3H9QyMuEA3328SWOE7lW3N33hnwf2Qy2p9KcdNUxyhF1qWPYjOzMlekuravy5VOTeIkb9WoBf2Kf9KOpyPuEvE2F37kDMR1ZPHp6KEdTAb5owOgxkGJNPfj5oFKVHHX4YPzlFmkoMuEH27yhayA4bvSERIWq99z239LJS+EQc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mK2hOgeN7vclhULylIgWyEs3QJOWRqEDOULg4OqfuKQ=;
 b=mTCT/uup2BXi5BDCpLNVzJAOIagkCyHVjiVxhTAwPmVOrXDwRWBB3gQnnm358ySb+F6nfcMh77NYJJBwC430sN10JW1ZSbMadALlDnSjlglGML/ATjGowmyLtTz/2D1JvoEw+Kvb2E7QRCIx48jZkIEdFJJ5Jpkoh2LtcJhxatw/zh/DLxfsDZGdH56WMXyfWrrcOD/zAOTPGDojvhjj4cSJCcM/ovmqtvEkDkYeqQyWOjsSw+c+e6mGubpgffGRlyI053rXo05lMIQqHJp+6Oa+tG++1sHntl+w0Zf2WJvWqxfa1g88SgQ4aU1RZEDQW+bldGKJKUa5ltmc/Ev16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mK2hOgeN7vclhULylIgWyEs3QJOWRqEDOULg4OqfuKQ=;
 b=vm+leOwNhVeDu5TYx5YXaWU2fj89lzAiAIH8vzs6RGL39lUecp4FjNPxR1FygpywJarejeTLTzkStt+UUuh2DSpW2P9BuW+dQpoZ9khRgG/aktkCcYInGR6fqjevabrIf2nryWBY/Cw+rBqNNHxj5rP9LP7eJuLVFVZiAY6JZmk=
Received: from DM6PR02CA0154.namprd02.prod.outlook.com (2603:10b6:5:332::21)
 by PH7PR12MB7113.namprd12.prod.outlook.com (2603:10b6:510:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 17:00:14 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::1d) by DM6PR02CA0154.outlook.office365.com
 (2603:10b6:5:332::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 17:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 17:00:13 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 27 Aug
 2022 12:00:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 27 Aug
 2022 10:00:13 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Sat, 27 Aug 2022 12:00:09 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <alexander.deucher@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/13] ASoC: amd: add acp6.2 pdm driver dma ops
Date:   Sat, 27 Aug 2022 22:26:51 +0530
Message-ID: <20220827165657.2343818-8-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220827165657.2343818-1-Syed.SabaKareem@amd.com>
References: <20220827165657.2343818-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4330fd6-7d29-46f6-7764-08da884d9c19
X-MS-TrafficTypeDiagnostic: PH7PR12MB7113:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eN2YfAieaf+2R2bqXj0QI6qwCcSJncNmzjn9Ld1/tvIhBVTg26E2BKZgzbSRiC3pAzAOjIixgsxTLZj6m84HkoqgP8Ygc/OmuRtlcP66gM4Oci9/PNpTBNrE9kjNfwqzarya0VLWAQDvAduZc94q69ZDQO7aY/u+uU89iqMZbkgzCMpwvawPyS4pRwVLBG8EZF5Ku4vFL73IUIM0pOj0mBiuspdD7gXcR8MhMQLy7FlMn66g17pq/qpEHKpRZaJsXZJ99Pp/Az9H6y4XD3E6Yyb9n56EKThIo8nq4Aooir4QFsRKAiMdsk8e4iF7r8FM0U4dswZj/maYukM7Kg5rMLACWMZ7F30G69DFhThtYFL+uF7hvBZYfjdjElD+ZynmLvbbolNDA835/oN+wKM1BfWaBofkL/6ZZjEC+yCpicChLIwotmeCDutWTLtNine6OOKNYZyRpzNnrjEhc+OOL/NRXFNZ4SiMYwRXIkSaWLsIVZ1Gaj7PEP79EHsOuRT7GeZ+Vs03WWKvypkm2OtEj+0A1vsFjjphzd5YJ8UZjud3OCc8Ve8ywfuIiaJFMaawE616RiOeHBb/OHmXOlWdjdawzpC25bY4VQjSchUOFonE1tqU0oVSb8nNVjnehDHrWIrkHn+onShZS+Ic0ToiInbXYL/rC9hxI/wrO573EqUfFqfe4J+ToHk5Q9XaUOb63ODXjKmZPMrNajGM+sKPVtugotWv5FEpkyEQHWi6dEthlMFZUKyh3DNymFkG6i9syWnddQwf4xxhHfF+TrDh/W7e3AnpxwNNe/B2duy/11g62ZrI8x5wnYy7mrpl2E+w
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(40470700004)(36840700001)(46966006)(7696005)(36756003)(6666004)(26005)(40460700003)(47076005)(186003)(336012)(1076003)(2616005)(426003)(110136005)(70206006)(70586007)(2906002)(316002)(54906003)(4326008)(8676002)(82310400005)(41300700001)(478600001)(30864003)(5660300002)(36860700001)(86362001)(82740400003)(356005)(81166007)(8936002)(83380400001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 17:00:13.8026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4330fd6-7d29-46f6-7764-08da884d9c19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds PDM driver DMA operations for Pink Sardine Platform.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp62.h      |  33 ++++
 sound/soc/amd/ps/ps-pdm-dma.c | 313 ++++++++++++++++++++++++++++++++++
 2 files changed, 346 insertions(+)

diff --git a/sound/soc/amd/ps/acp62.h b/sound/soc/amd/ps/acp62.h
index 9e359006b06b..589c974f9997 100644
--- a/sound/soc/amd/ps/acp62.h
+++ b/sound/soc/amd/ps/acp62.h
@@ -26,6 +26,31 @@
 #define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
 #define PDM_DMA_STAT 0x10
 
+#define PDM_DMA_INTR_MASK	0x10000
+#define ACP_ERROR_STAT	29
+#define PDM_DECIMATION_FACTOR	2
+#define ACP_PDM_CLK_FREQ_MASK	7
+#define ACP_WOV_MISC_CTRL_MASK	0x10
+#define ACP_PDM_ENABLE		1
+#define ACP_PDM_DISABLE		0
+#define ACP_PDM_DMA_EN_STATUS	2
+#define TWO_CH		2
+#define DELAY_US	5
+#define ACP_COUNTER	20000
+
+#define ACP_SRAM_PTE_OFFSET	0x03800000
+#define PAGE_SIZE_4K_ENABLE	2
+#define PDM_PTE_OFFSET		0
+#define PDM_MEM_WINDOW_START	0x4000000
+
+#define CAPTURE_MIN_NUM_PERIODS     4
+#define CAPTURE_MAX_NUM_PERIODS     4
+#define CAPTURE_MAX_PERIOD_SIZE     8192
+#define CAPTURE_MIN_PERIOD_SIZE     4096
+
+#define MAX_BUFFER (CAPTURE_MAX_PERIOD_SIZE * CAPTURE_MAX_NUM_PERIODS)
+#define MIN_BUFFER MAX_BUFFER
+
 enum acp_config {
 	ACP_CONFIG_0 = 0,
 	ACP_CONFIG_1,
@@ -45,6 +70,14 @@ enum acp_config {
 	ACP_CONFIG_15,
 };
 
+struct pdm_stream_instance {
+	u16 num_pages;
+	u16 channels;
+	dma_addr_t dma_addr;
+	u64 bytescount;
+	void __iomem *acp62_base;
+};
+
 struct pdm_dev_data {
 	u32 pdm_irq;
 	void __iomem *acp62_base;
diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
index 964686b46097..f0ec1a4f3b9d 100644
--- a/sound/soc/amd/ps/ps-pdm-dma.c
+++ b/sound/soc/amd/ps/ps-pdm-dma.c
@@ -17,6 +17,313 @@
 
 #define DRV_NAME "acp_ps_pdm_dma"
 
+static const struct snd_pcm_hardware acp62_pdm_hardware_capture = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME,
+	.formats = SNDRV_PCM_FMTBIT_S32_LE,
+	.channels_min = 2,
+	.channels_max = 2,
+	.rates = SNDRV_PCM_RATE_48000,
+	.rate_min = 48000,
+	.rate_max = 48000,
+	.buffer_bytes_max = CAPTURE_MAX_NUM_PERIODS * CAPTURE_MAX_PERIOD_SIZE,
+	.period_bytes_min = CAPTURE_MIN_PERIOD_SIZE,
+	.period_bytes_max = CAPTURE_MAX_PERIOD_SIZE,
+	.periods_min = CAPTURE_MIN_NUM_PERIODS,
+	.periods_max = CAPTURE_MAX_NUM_PERIODS,
+};
+
+static void acp62_init_pdm_ring_buffer(u32 physical_addr, u32 buffer_size,
+				       u32 watermark_size, void __iomem *acp_base)
+{
+	acp62_writel(physical_addr, acp_base + ACP_WOV_RX_RINGBUFADDR);
+	acp62_writel(buffer_size, acp_base + ACP_WOV_RX_RINGBUFSIZE);
+	acp62_writel(watermark_size, acp_base + ACP_WOV_RX_INTR_WATERMARK_SIZE);
+	acp62_writel(0x01, acp_base + ACPAXI2AXI_ATU_CTRL);
+}
+
+static void acp62_enable_pdm_clock(void __iomem *acp_base)
+{
+	u32 pdm_clk_enable, pdm_ctrl;
+
+	pdm_clk_enable = ACP_PDM_CLK_FREQ_MASK;
+	pdm_ctrl = 0x00;
+
+	acp62_writel(pdm_clk_enable, acp_base + ACP_WOV_CLK_CTRL);
+	pdm_ctrl = acp62_readl(acp_base + ACP_WOV_MISC_CTRL);
+	pdm_ctrl |= ACP_WOV_MISC_CTRL_MASK;
+	acp62_writel(pdm_ctrl, acp_base + ACP_WOV_MISC_CTRL);
+}
+
+static void acp62_enable_pdm_interrupts(void __iomem *acp_base)
+{
+	u32 ext_int_ctrl;
+
+	ext_int_ctrl = acp62_readl(acp_base + ACP_EXTERNAL_INTR_CNTL);
+	ext_int_ctrl |= PDM_DMA_INTR_MASK;
+	acp62_writel(ext_int_ctrl, acp_base + ACP_EXTERNAL_INTR_CNTL);
+}
+
+static void acp62_disable_pdm_interrupts(void __iomem *acp_base)
+{
+	u32 ext_int_ctrl;
+
+	ext_int_ctrl = acp62_readl(acp_base + ACP_EXTERNAL_INTR_CNTL);
+	ext_int_ctrl &= ~PDM_DMA_INTR_MASK;
+	acp62_writel(ext_int_ctrl, acp_base + ACP_EXTERNAL_INTR_CNTL);
+}
+
+static bool acp62_check_pdm_dma_status(void __iomem *acp_base)
+{
+	bool pdm_dma_status;
+	u32 pdm_enable, pdm_dma_enable;
+
+	pdm_dma_status = false;
+	pdm_enable = acp62_readl(acp_base + ACP_WOV_PDM_ENABLE);
+	pdm_dma_enable = acp62_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
+	if ((pdm_enable & ACP_PDM_ENABLE) && (pdm_dma_enable & ACP_PDM_DMA_EN_STATUS))
+		pdm_dma_status = true;
+
+	return pdm_dma_status;
+}
+
+static int acp62_start_pdm_dma(void __iomem *acp_base)
+{
+	u32 pdm_enable;
+	u32 pdm_dma_enable;
+	int timeout;
+
+	pdm_enable = 0x01;
+	pdm_dma_enable  = 0x01;
+
+	acp62_enable_pdm_clock(acp_base);
+	acp62_writel(pdm_enable, acp_base + ACP_WOV_PDM_ENABLE);
+	acp62_writel(pdm_dma_enable, acp_base + ACP_WOV_PDM_DMA_ENABLE);
+	timeout = 0;
+	while (++timeout < ACP_COUNTER) {
+		pdm_dma_enable = acp62_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
+		if ((pdm_dma_enable & 0x02) == ACP_PDM_DMA_EN_STATUS)
+			return 0;
+		udelay(DELAY_US);
+	}
+	return -ETIMEDOUT;
+}
+
+static int acp62_stop_pdm_dma(void __iomem *acp_base)
+{
+	u32 pdm_enable, pdm_dma_enable;
+	int timeout;
+
+	pdm_enable = 0x00;
+	pdm_dma_enable  = 0x00;
+
+	pdm_enable = acp62_readl(acp_base + ACP_WOV_PDM_ENABLE);
+	pdm_dma_enable = acp62_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
+	if (pdm_dma_enable & 0x01) {
+		pdm_dma_enable = 0x02;
+		acp62_writel(pdm_dma_enable, acp_base + ACP_WOV_PDM_DMA_ENABLE);
+		timeout = 0;
+		while (++timeout < ACP_COUNTER) {
+			pdm_dma_enable = acp62_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
+			if ((pdm_dma_enable & 0x02) == 0x00)
+				break;
+			udelay(DELAY_US);
+		}
+		if (timeout == ACP_COUNTER)
+			return -ETIMEDOUT;
+	}
+	if (pdm_enable == ACP_PDM_ENABLE) {
+		pdm_enable = ACP_PDM_DISABLE;
+		acp62_writel(pdm_enable, acp_base + ACP_WOV_PDM_ENABLE);
+	}
+	acp62_writel(0x01, acp_base + ACP_WOV_PDM_FIFO_FLUSH);
+	return 0;
+}
+
+static void acp62_config_dma(struct pdm_stream_instance *rtd, int direction)
+{
+	u16 page_idx;
+	u32 low, high, val;
+	dma_addr_t addr;
+
+	addr = rtd->dma_addr;
+	val = PDM_PTE_OFFSET;
+
+	/* Group Enable */
+	acp62_writel(ACP_SRAM_PTE_OFFSET | BIT(31), rtd->acp62_base +
+		     ACPAXI2AXI_ATU_BASE_ADDR_GRP_1);
+	acp62_writel(PAGE_SIZE_4K_ENABLE, rtd->acp62_base +
+		     ACPAXI2AXI_ATU_PAGE_SIZE_GRP_1);
+	for (page_idx = 0; page_idx < rtd->num_pages; page_idx++) {
+		/* Load the low address of page int ACP SRAM through SRBM */
+		low = lower_32_bits(addr);
+		high = upper_32_bits(addr);
+
+		acp62_writel(low, rtd->acp62_base + ACP_SCRATCH_REG_0 + val);
+		high |= BIT(31);
+		acp62_writel(high, rtd->acp62_base + ACP_SCRATCH_REG_0 + val + 4);
+		val += 8;
+		addr += PAGE_SIZE;
+	}
+}
+
+static int acp62_pdm_dma_open(struct snd_soc_component *component,
+			      struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime;
+	struct pdm_dev_data *adata;
+	struct pdm_stream_instance *pdm_data;
+	int ret;
+
+	runtime = substream->runtime;
+	adata = dev_get_drvdata(component->dev);
+	pdm_data = kzalloc(sizeof(*pdm_data), GFP_KERNEL);
+	if (!pdm_data)
+		return -EINVAL;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		runtime->hw = acp62_pdm_hardware_capture;
+
+	ret = snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0) {
+		dev_err(component->dev, "set integer constraint failed\n");
+		kfree(pdm_data);
+		return ret;
+	}
+
+	acp62_enable_pdm_interrupts(adata->acp62_base);
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		adata->capture_stream = substream;
+
+	pdm_data->acp62_base = adata->acp62_base;
+	runtime->private_data = pdm_data;
+	return ret;
+}
+
+static int acp62_pdm_dma_hw_params(struct snd_soc_component *component,
+				   struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
+{
+	struct pdm_stream_instance *rtd;
+	size_t size, period_bytes;
+
+	rtd = substream->runtime->private_data;
+	if (!rtd)
+		return -EINVAL;
+	size = params_buffer_bytes(params);
+	period_bytes = params_period_bytes(params);
+	rtd->dma_addr = substream->runtime->dma_addr;
+	rtd->num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
+	acp62_config_dma(rtd, substream->stream);
+	acp62_init_pdm_ring_buffer(PDM_MEM_WINDOW_START, size,
+				   period_bytes, rtd->acp62_base);
+	return 0;
+}
+
+static u64 acp62_pdm_get_byte_count(struct pdm_stream_instance *rtd,
+				    int direction)
+{
+	u32 high, low;
+	u64 byte_count;
+
+	high = acp62_readl(rtd->acp62_base + ACP_WOV_RX_LINEARPOSITIONCNTR_HIGH);
+	byte_count = high;
+	low = acp62_readl(rtd->acp62_base + ACP_WOV_RX_LINEARPOSITIONCNTR_LOW);
+	byte_count = (byte_count << 32) | low;
+	return byte_count;
+}
+
+static snd_pcm_uframes_t acp62_pdm_dma_pointer(struct snd_soc_component *comp,
+					       struct snd_pcm_substream *stream)
+{
+	struct pdm_stream_instance *rtd;
+	u32 pos, buffersize;
+	u64 bytescount;
+
+	rtd = stream->runtime->private_data;
+	buffersize = frames_to_bytes(stream->runtime,
+				     stream->runtime->buffer_size);
+	bytescount = acp62_pdm_get_byte_count(rtd, stream->stream);
+	if (bytescount > rtd->bytescount)
+		bytescount -= rtd->bytescount;
+	pos = do_div(bytescount, buffersize);
+	return bytes_to_frames(stream->runtime, pos);
+}
+
+static int acp62_pdm_dma_new(struct snd_soc_component *component,
+			     struct snd_soc_pcm_runtime *rtd)
+{
+	struct device *parent = component->dev->parent;
+
+	snd_pcm_set_managed_buffer_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
+				       parent, MIN_BUFFER, MAX_BUFFER);
+	return 0;
+}
+
+static int acp62_pdm_dma_close(struct snd_soc_component *component,
+			       struct snd_pcm_substream *substream)
+{
+	struct pdm_dev_data *adata = dev_get_drvdata(component->dev);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	acp62_disable_pdm_interrupts(adata->acp62_base);
+	adata->capture_stream = NULL;
+	kfree(runtime->private_data);
+	return 0;
+}
+
+static int acp62_pdm_dai_trigger(struct snd_pcm_substream *substream,
+				 int cmd, struct snd_soc_dai *dai)
+{
+	struct pdm_stream_instance *rtd;
+	int ret;
+	bool pdm_status;
+	unsigned int ch_mask;
+
+	rtd = substream->runtime->private_data;
+	ret = 0;
+	switch (substream->runtime->channels) {
+	case TWO_CH:
+		ch_mask = 0x00;
+		break;
+	default:
+		return -EINVAL;
+	}
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		acp62_writel(ch_mask, rtd->acp62_base + ACP_WOV_PDM_NO_OF_CHANNELS);
+		acp62_writel(PDM_DECIMATION_FACTOR, rtd->acp62_base +
+			     ACP_WOV_PDM_DECIMATION_FACTOR);
+		rtd->bytescount = acp62_pdm_get_byte_count(rtd, substream->stream);
+		pdm_status = acp62_check_pdm_dma_status(rtd->acp62_base);
+		if (!pdm_status)
+			ret = acp62_start_pdm_dma(rtd->acp62_base);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		pdm_status = acp62_check_pdm_dma_status(rtd->acp62_base);
+		if (pdm_status)
+			ret = acp62_stop_pdm_dma(rtd->acp62_base);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static const struct snd_soc_dai_ops acp62_pdm_dai_ops = {
+	.trigger   = acp62_pdm_dai_trigger,
+};
+
 static struct snd_soc_dai_driver acp62_pdm_dai_driver = {
 	.name = "acp_ps_pdm_dma.0",
 	.capture = {
@@ -27,10 +334,16 @@ static struct snd_soc_dai_driver acp62_pdm_dai_driver = {
 		.rate_min = 48000,
 		.rate_max = 48000,
 	},
+	.ops = &acp62_pdm_dai_ops,
 };
 
 static const struct snd_soc_component_driver acp62_pdm_component = {
 	.name		= DRV_NAME,
+	.open		= acp62_pdm_dma_open,
+	.close		= acp62_pdm_dma_close,
+	.hw_params	= acp62_pdm_dma_hw_params,
+	.pointer	= acp62_pdm_dma_pointer,
+	.pcm_construct	= acp62_pdm_dma_new,
 };
 
 static int acp62_pdm_audio_probe(struct platform_device *pdev)
-- 
2.25.1

