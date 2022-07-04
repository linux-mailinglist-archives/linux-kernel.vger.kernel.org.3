Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF9456584C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiGDOJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbiGDOI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:08:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ED35FA7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGBcmB8H6DIXDya0Lf9GBN0MhfRodWneh3tAcHTYt+2DNzTkqpAZDk0fdv/AkLGuHl96MqKQkBOqqBrM+466vQ1648vu2knD0GwvEWOaBZhd0BfD11f6nCUbFrolVIN/Zt2tiGpzF4Jk5fbpev/xOGEWVK5/4WvoOw2CY6sgH+EHyxAGAijHeDUMedUv+u49S2xQVdKPfTm2YrgbM5kjRUtq/u5tvmMgHy53vjQU+XesbzLy7BvmLAUVcbVWAt/hWPzoI46sv4/6xATJpw1J5bCKl6Ot1+RVLmz0nfM87UAWoAXPEUq4v9aHqBeKgR+c3hj+KWUdU2SL4LBrDK4YGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICABZwNdVzUwLSlk+XuVEOv6wxXrM9NPNXp6PnCGyT0=;
 b=ZpKm8rREQgpOoy+/KTsAngROu5c0MT01fO+CC4bTc8Mqy68T6YClWbgFhdWTSz4AhmKYqlL83d0BcR3tCk/XjXbO3s8UiWixHrE4KNcHGdwtUsHeZKrqQHjb4/gpr+AWINCEoBsVMT4dzpufYB2MEiIVm+b/Uy4WIuhwNszeeA3epz2AlgFVm97pPCAUY0UhLpuvOFsA3HlnzaP033KHwcH86t8T3tlXX+4i1vy445e5YsdVS+Xb7jzs/O8XJAMIxuVKAlMIkMi9WkEeSXckpM6KpEJ7OXmwQuboUH7ynUyLW/c2oVwb/0H+RrU0m8Q2JnJf6itFOEkhB8Ej1Io27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICABZwNdVzUwLSlk+XuVEOv6wxXrM9NPNXp6PnCGyT0=;
 b=ajiTRRyLKr72i87OoHMJb8xg58YwSukLc59F07P4Lzx5mjRZqZSVixS/dVGa5MCGfgjMVrztPh9crmCF57n2oAwyNMFVhKXuRV5asKQ9oLJt/HWoBT0XkO0/cOClosdG/g+I0dHHxM7cArfoQlxfpS37To1K+aYYb7GrJTRHj3I=
Received: from MWH0EPF00056D16.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1d) by DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 14:08:54 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by MWH0EPF00056D16.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.2 via Frontend
 Transport; Mon, 4 Jul 2022 14:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Mon, 4 Jul 2022 14:08:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 4 Jul
 2022 09:08:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 4 Jul
 2022 09:08:52 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Mon, 4 Jul 2022 09:08:48 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <zhuning@everest-semi.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Gu Shengxian <gushengxian@yulong.com>,
        Meng Tang <tangmeng@uniontech.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 1/3] ASoC: amd: add I2S MICSP instance support
Date:   Mon, 4 Jul 2022 19:38:33 +0530
Message-ID: <20220704140837.1215534-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e277add-27ca-46f3-b1cb-08da5dc6ba79
X-MS-TrafficTypeDiagnostic: DM6PR12MB2844:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zb99rCbMIuNfaWKC8pEA6weIr8OtRJ28XlB8pAw/r251i178CM9ajvTISLZnKhfnyin8EZqNFQvzM7DAYfslGyFdiaNeqTMLfiCjDr3TW7r+7LNeGhNkyBf8dT+IbtWMVbb+ZJkUfn32JOl1lBUWWyqVV9Q424tDDHZJQA3VTpFIstpfGPAiz+xXIm0X66izQIKs5dVs9Y33Oc+lpbptTSaNSJ7GlUlVbpD+CyX5Sftg97k7w0EcH0nSPuaA2+kAZTYyV3oy/uDzqeFqSTcp/lMMPlnp4EZgjt1GNShtv5zIKNMsUMjKgd/7mS6L3sWmPgRF3koqx/y4vPatMQH12BO6SP0rFYcFw+AM2zxHYXjmsb+3KUIdR4Ui6NHlQHTcODgwZV9O7Ph30RZzE8FXGt+KcoSk3IOidEwHumRX6UjHd9FF9ijrHvIRaALr4Ugh/HLPHp76v2IraWeFiMZ/T7Hw6tDKyFCeGHWEDSxcUn4nZMoqGu8KiAYwwHOqfF7D57hiTJxiV5wI6kQ7NGKO/B5CSxgMASOEzXNJsN/N4DQDtJKe4i42VI9rRa9rn+k4H3iu7IHrUr1YyKz5xrRbCQ9s9x28N54s0qRRZnjBC8nSPCD4CVm1DV7BkH94HGfTgWhzEA8gNAZtSqqHlKAeSiU+JHSUMN3Ul4BAAsHySlZqZZqddnQawtlGAk+uMbLXiNvMXX2B+w7blR3Hb/x299wyCI4ZKMIVPrqdJSEjB17aVr+9HOp+wAG5ZV8VsVgqtFFscbOVC8v9xGtBECt3gma7Wj8LlqGzCFwE8VM7hGzicrmX6HsFf95wM1cqfTvcE/vTPo8DNNEYI4AZDPA5yNJvpX6IFvoN6VjfcRQ4mg3VBmwGduPEQp2YOkOowa/G
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(39860400002)(346002)(36840700001)(40470700004)(46966006)(336012)(47076005)(26005)(82310400005)(186003)(36756003)(2906002)(7416002)(40460700003)(426003)(36860700001)(83380400001)(34020700004)(40480700001)(8936002)(70206006)(5660300002)(8676002)(316002)(4326008)(70586007)(7696005)(478600001)(86362001)(356005)(54906003)(6666004)(81166007)(2616005)(110136005)(1076003)(41300700001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 14:08:53.7916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e277add-27ca-46f3-b1cb-08da5dc6ba79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2844
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2S MICSP instance support for Stoney variant.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 50 +++++++++++++++++++++++++++++++++++--
 sound/soc/amd/acp.h         | 13 ++++++++++
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 1cd2e70a57df..198358d28ea9 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -433,6 +433,7 @@ static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num, bool is_circular)
 	case I2S_TO_ACP_DMA_CH_NUM:
 	case ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM:
 	case I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM:
+	case ACP_TO_I2S_DMA_MICSP_INSTANCE_CH_NUM:
 		dma_ctrl |= ACP_DMA_CNTL_0__DMAChIOCEn_MASK;
 		break;
 	default:
@@ -710,6 +711,13 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
+	if ((intr_flag & BIT(ACP_TO_I2S_DMA_MICSP_INSTANCE_CH_NUM)) != 0) {
+		valid_irq = true;
+		snd_pcm_period_elapsed(irq_data->play_i2s_micsp_stream);
+		acp_reg_write((intr_flag & BIT(ACP_TO_I2S_DMA_MICSP_INSTANCE_CH_NUM)) << 16,
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
+
 	if ((intr_flag & BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->play_i2sbt_stream);
@@ -807,7 +815,8 @@ static int acp_dma_open(struct snd_soc_component *component,
 	 * stream is not closed
 	 */
 	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream &&
-	    !intr_data->play_i2sbt_stream && !intr_data->capture_i2sbt_stream)
+	    !intr_data->play_i2sbt_stream && !intr_data->capture_i2sbt_stream &&
+	    !intr_data->play_i2s_micsp_stream)
 		acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -867,6 +876,9 @@ static int acp_dma_hw_params(struct snd_soc_component *component,
 			case I2S_BT_INSTANCE:
 				val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
 				break;
+			case I2S_MICSP_INSTANCE:
+				val |= ACP_I2S_MICSP_16BIT_RESOLUTION_EN;
+				break;
 			case I2S_SP_INSTANCE:
 			default:
 				val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
@@ -876,6 +888,7 @@ static int acp_dma_hw_params(struct snd_soc_component *component,
 			case I2S_BT_INSTANCE:
 				val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
 				break;
+			case I2S_MICSP_INSTANCE:
 			case I2S_SP_INSTANCE:
 			default:
 				val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
@@ -901,6 +914,27 @@ static int acp_dma_hw_params(struct snd_soc_component *component,
 					mmACP_I2S_BT_TRANSMIT_BYTE_CNT_LOW;
 			adata->play_i2sbt_stream = substream;
 			break;
+		case I2S_MICSP_INSTANCE:
+			switch (adata->asic_type) {
+			case CHIP_STONEY:
+				rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
+				break;
+			default:
+				rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
+			}
+			rtd->ch1 = SYSRAM_TO_ACP_MICSP_INSTANCE_CH_NUM;
+			rtd->ch2 = ACP_TO_I2S_DMA_MICSP_INSTANCE_CH_NUM;
+			rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
+			rtd->destination = TO_ACP_I2S_2;
+			rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH4;
+			rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH5;
+			rtd->byte_cnt_high_reg_offset =
+					mmACP_I2S_MICSP_TRANSMIT_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_MICSP_TRANSMIT_BYTE_CNT_LOW;
+
+			adata->play_i2s_micsp_stream = substream;
+			break;
 		case I2S_SP_INSTANCE:
 		default:
 			switch (adata->asic_type) {
@@ -939,6 +973,7 @@ static int acp_dma_hw_params(struct snd_soc_component *component,
 			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_11;
 			adata->capture_i2sbt_stream = substream;
 			break;
+		case I2S_MICSP_INSTANCE:
 		case I2S_SP_INSTANCE:
 		default:
 			rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
@@ -1160,6 +1195,9 @@ static int acp_dma_close(struct snd_soc_component *component,
 		case I2S_BT_INSTANCE:
 			adata->play_i2sbt_stream = NULL;
 			break;
+		case I2S_MICSP_INSTANCE:
+			adata->play_i2s_micsp_stream = NULL;
+			break;
 		case I2S_SP_INSTANCE:
 		default:
 			adata->play_i2ssp_stream = NULL;
@@ -1181,6 +1219,7 @@ static int acp_dma_close(struct snd_soc_component *component,
 		case I2S_BT_INSTANCE:
 			adata->capture_i2sbt_stream = NULL;
 			break;
+		case I2S_MICSP_INSTANCE:
 		case I2S_SP_INSTANCE:
 		default:
 			adata->capture_i2ssp_stream = NULL;
@@ -1197,7 +1236,8 @@ static int acp_dma_close(struct snd_soc_component *component,
 	 * another stream is also not active.
 	 */
 	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream &&
-	    !adata->play_i2sbt_stream && !adata->capture_i2sbt_stream)
+	    !adata->play_i2sbt_stream && !adata->capture_i2sbt_stream &&
+	    !adata->play_i2s_micsp_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 	kfree(rtd);
 	return 0;
@@ -1245,6 +1285,7 @@ static int acp_audio_probe(struct platform_device *pdev)
 	audio_drv_data->capture_i2ssp_stream = NULL;
 	audio_drv_data->play_i2sbt_stream = NULL;
 	audio_drv_data->capture_i2sbt_stream = NULL;
+	audio_drv_data->play_i2s_micsp_stream = NULL;
 
 	audio_drv_data->asic_type =  *pdata;
 
@@ -1333,6 +1374,11 @@ static int acp_pcm_resume(struct device *dev)
 		config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
 	}
 	if (adata->asic_type != CHIP_CARRIZO) {
+		if (adata->play_i2s_micsp_stream &&
+		    adata->play_i2s_micsp_stream->runtime) {
+			rtd = adata->play_i2s_micsp_stream->runtime->private_data;
+			config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
+		}
 		if (adata->play_i2sbt_stream &&
 		    adata->play_i2sbt_stream->runtime) {
 			rtd = adata->play_i2sbt_stream->runtime->private_data;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index db80a73aa593..b29bef90f886 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -55,6 +55,7 @@
 
 #define I2S_SP_INSTANCE                 0x01
 #define I2S_BT_INSTANCE                 0x02
+#define I2S_MICSP_INSTANCE		0x03
 #define CAP_CHANNEL0			0x00
 #define CAP_CHANNEL1			0x01
 
@@ -85,6 +86,10 @@
 #define I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM 10
 #define ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM 11
 
+/* Playback DMA channels for I2S MICSP instance */
+#define SYSRAM_TO_ACP_MICSP_INSTANCE_CH_NUM  4
+#define ACP_TO_I2S_DMA_MICSP_INSTANCE_CH_NUM 5
+
 #define NUM_DSCRS_PER_CHANNEL 2
 
 #define PLAYBACK_START_DMA_DESCR_CH12 0
@@ -108,8 +113,15 @@
 #define CAPTURE_START_DMA_DESCR_CH11 14
 #define CAPTURE_END_DMA_DESCR_CH11 15
 
+/* I2S MICSP Instance DMA Descriptors */
+#define PLAYBACK_START_DMA_DESCR_CH4 0
+#define PLAYBACK_END_DMA_DESCR_CH4 1
+#define PLAYBACK_START_DMA_DESCR_CH5 2
+#define PLAYBACK_END_DMA_DESCR_CH5 3
+
 #define mmACP_I2S_16BIT_RESOLUTION_EN       0x5209
 #define ACP_I2S_MIC_16BIT_RESOLUTION_EN 0x01
+#define ACP_I2S_MICSP_16BIT_RESOLUTION_EN 0x01
 #define ACP_I2S_SP_16BIT_RESOLUTION_EN	0x02
 #define ACP_I2S_BT_16BIT_RESOLUTION_EN	0x04
 #define ACP_BT_UART_PAD_SELECT_MASK	0x1
@@ -149,6 +161,7 @@ struct audio_drv_data {
 	struct snd_pcm_substream *capture_i2ssp_stream;
 	struct snd_pcm_substream *play_i2sbt_stream;
 	struct snd_pcm_substream *capture_i2sbt_stream;
+	struct snd_pcm_substream *play_i2s_micsp_stream;
 	void __iomem *acp_mmio;
 	u32 asic_type;
 	snd_pcm_sframes_t delay;
-- 
2.25.1

