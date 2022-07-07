Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7248656A7BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiGGQMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbiGGQLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:11:42 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79D12725
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sg/9Xf33ZP8p+8UVYxT1cTqG/oblGivI4Ui/m6tRizHsoj3dxZ7wcZX7FcYIPmqR1tzESW+RhUYn/Q4n4Kz4vWXZVvoEY1vgCjsmyg0ch03RYC4SGOUtQ7VjSt62UMRMZRSyy/hGEXhfAKZQy2lm+e79Cz+IiAQIk0tQo18IhzWIXB0Nzi8HLwDqUHZW/4VqBV1GB26el8BqUCEnfhS6m/LOAHbNaTnrM3kI2yUa0NVkWiD9xgPiu9Jeh4pG2PwUzyDgY3UyKuVQFDJ4uakq8GvugABKsgtPbMHggfA9RHR8GmFhU3M06YpCqv8dHJfwyQ4nqsOQY+6H0g1BwMMoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVN2oFVOQJ8vjJNN6T1MdsmxzYyEqvYsGBUboAKD4u8=;
 b=CPXpCit9JJ81Lwu3YvkKMnT+hSPRC/wfKIsOK/rLZscJu8LPtsrI0SE1YnW42lVYUqN00pih2pwu3igyhGj1z0zSvMR+0xhKJMJvFhs5sSF98vBltfXyMBIl/b+A33EcfiMtZb99MKWqhmdyJkdhfZlkEgKJuo/Kp5+f161gr5KAtBSGCHQJ8p2U/e85GBg7xWfOHawuzZf82DzuMQpQGA98yqeaXq7KJquJmN5tqMKOOFf5RsJecTRu7oAGz7pnW2usnd3xWK3q8ibJiazq84XGtUD+UNKtkYWrbVv0ZqtSXZ22s7jFSo23+H51Auaionz/qbeV944d3hlU7iir1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVN2oFVOQJ8vjJNN6T1MdsmxzYyEqvYsGBUboAKD4u8=;
 b=QbtRZ9ieusdfq8Qxy9P9uWMaH9jY9dERjFBHlK6PT64RKTm7tBXe3CCQGT15KZpAYcp8NLoZbq+GtQ9ooI+m3Lku41E6qfAeuESv7g2V7pxzU6l2LdvxKSeAm+N0UWrfTh/U26bx+tQIX7GpofZ/Bm6c/StdtCpPsI861P+LKNA=
Received: from BN6PR20CA0057.namprd20.prod.outlook.com (2603:10b6:404:151::19)
 by DM6PR12MB3258.namprd12.prod.outlook.com (2603:10b6:5:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 16:10:59 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::5f) by BN6PR20CA0057.outlook.office365.com
 (2603:10b6:404:151::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19 via Frontend
 Transport; Thu, 7 Jul 2022 16:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.16 via Frontend Transport; Thu, 7 Jul 2022 16:10:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 11:10:58 -0500
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 7 Jul 2022 11:10:53 -0500
From:   V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
        <ssabakar@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "Julia Lawall" <Julia.Lawall@inria.fr>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Meng Tang" <tangmeng@uniontech.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/3] ASoC: amd: acp: ACP code generic to support newer platforms
Date:   Thu, 7 Jul 2022 21:41:41 +0530
Message-ID: <20220707161142.491034-3-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707161142.491034-1-Vsujithkumar.Reddy@amd.com>
References: <20220707161142.491034-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59016f6c-d239-4d90-7f46-08da60334825
X-MS-TrafficTypeDiagnostic: DM6PR12MB3258:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLBCJXJsA9OYNqFV2+8XsIq/3F4hqJbl6ByHZxNEv5AWZqk9J1AWc23RYmQ173QqVSkG5YkJTuo/yWh29XjJ2j0zb6E1TYMYPhcnUOEmOlD/fCvmN0MMOfjaeinjRGuy8JQ93iYDLwdVVFzbMvnl0oe0bC5SA605VylSzvWkr3Aq28vJ7uB6Eo7BO1EiWoOD4sFBgFSU8BJQp3nLz1JrUqvE/8Qyo5jtMImvBPEvqZNfPjXVHAGUcchwLn9S237B8NsCBuPq/zZ3z2R5PdkoHuioSeNf4DLKkbYTF3AMIm3IQsxAVpk2T7zMPi/NT7zPu6vq5mq6ecNMxrc/K/emO3GEOSjYJdegb8yd9QP06XHv3+NlzRTvh/v6+ORsEJBQ7GCbXEJwScPsZ5zBjk4Rl6MXuHXAiv/LANMXDIOq4kELP19EpKwRDAqSMRJd79qNwEcOT7SHTrv3yMs+jSg8SrwZkHe62U6CXd4wrz+106BOK2w68+O5O1zmMJPMcvs03UZr0CxeuSpXej+ob1LNHfXFuNjsvYTp/paLJQCWR45MGOTIqyPKKSWXwgWPt98qGKXiuJObps1hdKAA04v1a2xDaMdfkJDgmzMaeVpjrPkWJlZB5mD78RhaBbUMxlW3goM5iseCwMSoRD96npwsiPPK82+2MxSFfliUBblDMWTuXKrObRRNrOhnWwvyjWnXwipmm2s2ZV18tWyrYo3NZglVG08TcwIuQhZXRJXMnILc40ViFr5Rf+FY0um7574fY3Y2URpAnKsmkYxv0Pddau+UhbmRqXl8Ts5to7buO4fRYpCcsZ+Jp8XI+RsktWlD+1AtrNlAxalX0/UyCEcnIsAh+A+pGCZbS8F8+cy4lCmgvowaQK6DF5SsxT5Ijo+nFujc17XE5JslVqUs8KnavA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(40470700004)(36840700001)(86362001)(81166007)(478600001)(316002)(6666004)(30864003)(41300700001)(2906002)(34020700004)(1076003)(70206006)(2616005)(8676002)(82740400003)(4326008)(356005)(186003)(36756003)(70586007)(40480700001)(82310400005)(8936002)(83380400001)(26005)(54906003)(110136005)(426003)(336012)(47076005)(7416002)(36860700001)(5660300002)(40460700003)(7696005)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 16:10:59.5580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59016f6c-d239-4d90-7f46-08da60334825
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3258
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADD Generic code to support to newer platforms, add
control threshold, irq control macros ,added structure for register
offset differences.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/amd/acp/acp-i2s.c          | 34 +++++++++++++++----------
 sound/soc/amd/acp/acp-pdm.c          |  8 +++---
 sound/soc/amd/acp/acp-platform.c     | 16 +++++++-----
 sound/soc/amd/acp/acp-renoir.c       | 38 ++++++++++++++++++++--------
 sound/soc/amd/acp/amd.h              | 24 +++++++++++++-----
 sound/soc/amd/acp/chip_offset_byte.h | 12 +++++----
 6 files changed, 86 insertions(+), 46 deletions(-)

diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
index ce9aca8dd6f5..a736c00db86e 100644
--- a/sound/soc/amd/acp/acp-i2s.c
+++ b/sound/soc/amd/acp/acp-i2s.c
@@ -199,6 +199,7 @@ static int acp_i2s_prepare(struct snd_pcm_substream *substream, struct snd_soc_d
 {
 	struct device *dev = dai->component->dev;
 	struct acp_dev_data *adata = dev_get_drvdata(dev);
+	struct acp_resource *rsrc = adata->rsrc;
 	struct acp_stream *stream = substream->runtime->private_data;
 	u32 reg_dma_size = 0, reg_fifo_size = 0, reg_fifo_addr = 0;
 	u32 phy_addr = 0, acp_fifo_addr = 0, ext_int_ctrl;
@@ -208,7 +209,7 @@ static int acp_i2s_prepare(struct snd_pcm_substream *substream, struct snd_soc_d
 	case I2S_SP_INSTANCE:
 		if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
 			reg_dma_size = ACP_I2S_TX_DMA_SIZE;
-			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
+			acp_fifo_addr = rsrc->sram_pte_offset +
 						SP_PB_FIFO_ADDR_OFFSET;
 			reg_fifo_addr =	ACP_I2S_TX_FIFOADDR;
 			reg_fifo_size = ACP_I2S_TX_FIFOSIZE;
@@ -217,7 +218,7 @@ static int acp_i2s_prepare(struct snd_pcm_substream *substream, struct snd_soc_d
 			writel(phy_addr, adata->acp_base + ACP_I2S_TX_RINGBUFADDR);
 		} else {
 			reg_dma_size = ACP_I2S_RX_DMA_SIZE;
-			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
+			acp_fifo_addr = rsrc->sram_pte_offset +
 						SP_CAPT_FIFO_ADDR_OFFSET;
 			reg_fifo_addr = ACP_I2S_RX_FIFOADDR;
 			reg_fifo_size = ACP_I2S_RX_FIFOSIZE;
@@ -228,7 +229,7 @@ static int acp_i2s_prepare(struct snd_pcm_substream *substream, struct snd_soc_d
 	case I2S_BT_INSTANCE:
 		if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
 			reg_dma_size = ACP_BT_TX_DMA_SIZE;
-			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
+			acp_fifo_addr = rsrc->sram_pte_offset +
 						BT_PB_FIFO_ADDR_OFFSET;
 			reg_fifo_addr = ACP_BT_TX_FIFOADDR;
 			reg_fifo_size = ACP_BT_TX_FIFOSIZE;
@@ -237,7 +238,7 @@ static int acp_i2s_prepare(struct snd_pcm_substream *substream, struct snd_soc_d
 			writel(phy_addr, adata->acp_base + ACP_BT_TX_RINGBUFADDR);
 		} else {
 			reg_dma_size = ACP_BT_RX_DMA_SIZE;
-			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
+			acp_fifo_addr = rsrc->sram_pte_offset +
 						BT_CAPT_FIFO_ADDR_OFFSET;
 			reg_fifo_addr = ACP_BT_RX_FIFOADDR;
 			reg_fifo_size = ACP_BT_RX_FIFOSIZE;
@@ -255,11 +256,13 @@ static int acp_i2s_prepare(struct snd_pcm_substream *substream, struct snd_soc_d
 	writel(acp_fifo_addr, adata->acp_base + reg_fifo_addr);
 	writel(FIFO_SIZE, adata->acp_base + reg_fifo_size);
 
-	ext_int_ctrl = readl(adata->acp_base + ACP_EXTERNAL_INTR_CNTL);
-	ext_int_ctrl |= BIT(I2S_RX_THRESHOLD) | BIT(BT_RX_THRESHOLD)
-			| BIT(I2S_TX_THRESHOLD) | BIT(BT_TX_THRESHOLD);
+	ext_int_ctrl = readl(ACP_EXTERNAL_INTR_CNTL(adata, rsrc->irqp_used));
+	ext_int_ctrl |= BIT(I2S_RX_THRESHOLD(rsrc->offset)) |
+			BIT(BT_RX_THRESHOLD(rsrc->offset)) |
+			BIT(I2S_TX_THRESHOLD(rsrc->offset)) |
+			BIT(BT_TX_THRESHOLD(rsrc->offset));
 
-	writel(ext_int_ctrl, adata->acp_base + ACP_EXTERNAL_INTR_CNTL);
+	writel(ext_int_ctrl, ACP_EXTERNAL_INTR_CNTL(adata, rsrc->irqp_used));
 
 	return 0;
 }
@@ -268,28 +271,30 @@ static int acp_i2s_startup(struct snd_pcm_substream *substream, struct snd_soc_d
 {
 	struct acp_stream *stream = substream->runtime->private_data;
 	struct device *dev = dai->component->dev;
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+	struct acp_resource *rsrc = adata->rsrc;
 	unsigned int dir = substream->stream;
 	unsigned int irq_bit = 0;
 
 	switch (dai->driver->id) {
 	case I2S_SP_INSTANCE:
 		if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
-			irq_bit = BIT(I2S_TX_THRESHOLD);
+			irq_bit = BIT(I2S_TX_THRESHOLD(rsrc->offset));
 			stream->pte_offset = ACP_SRAM_SP_PB_PTE_OFFSET;
 			stream->fifo_offset = SP_PB_FIFO_ADDR_OFFSET;
 		} else {
-			irq_bit = BIT(I2S_RX_THRESHOLD);
+			irq_bit = BIT(I2S_RX_THRESHOLD(rsrc->offset));
 			stream->pte_offset = ACP_SRAM_SP_CP_PTE_OFFSET;
 			stream->fifo_offset = SP_CAPT_FIFO_ADDR_OFFSET;
 		}
 		break;
 	case I2S_BT_INSTANCE:
 		if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
-			irq_bit = BIT(BT_TX_THRESHOLD);
+			irq_bit = BIT(BT_TX_THRESHOLD(rsrc->offset));
 			stream->pte_offset = ACP_SRAM_BT_PB_PTE_OFFSET;
 			stream->fifo_offset = BT_PB_FIFO_ADDR_OFFSET;
 		} else {
-			irq_bit = BIT(BT_RX_THRESHOLD);
+			irq_bit = BIT(BT_RX_THRESHOLD(rsrc->offset));
 			stream->pte_offset = ACP_SRAM_BT_CP_PTE_OFFSET;
 			stream->fifo_offset = BT_CAPT_FIFO_ADDR_OFFSET;
 		}
@@ -319,6 +324,7 @@ int asoc_acp_i2s_probe(struct snd_soc_dai *dai)
 {
 	struct device *dev = dai->component->dev;
 	struct acp_dev_data *adata = dev_get_drvdata(dev);
+	struct acp_resource *rsrc = adata->rsrc;
 	unsigned int val;
 
 	if (!adata->acp_base) {
@@ -326,8 +332,8 @@ int asoc_acp_i2s_probe(struct snd_soc_dai *dai)
 		return -EINVAL;
 	}
 
-	val = readl(adata->acp_base + ACP_I2S_PIN_CONFIG);
-	if (val != I2S_MODE) {
+	val = readl(adata->acp_base + rsrc->i2s_pin_cfg_offset);
+	if (val != rsrc->i2s_mode) {
 		dev_err(dev, "I2S Mode not supported val %x\n", val);
 		return -EINVAL;
 	}
diff --git a/sound/soc/amd/acp/acp-pdm.c b/sound/soc/amd/acp/acp-pdm.c
index 7a0b26a30051..66ec6b6a5972 100644
--- a/sound/soc/amd/acp/acp-pdm.c
+++ b/sound/soc/amd/acp/acp-pdm.c
@@ -160,9 +160,9 @@ static int acp_dmic_dai_startup(struct snd_pcm_substream *substream,
 	stream->reg_offset = ACP_REGION2_OFFSET;
 
 	/* Enable DMIC Interrupts */
-	ext_int_ctrl = readl(adata->acp_base + ACP_EXTERNAL_INTR_CNTL);
+	ext_int_ctrl = readl(ACP_EXTERNAL_INTR_CNTL(adata, 0));
 	ext_int_ctrl |= PDM_DMA_INTR_MASK;
-	writel(ext_int_ctrl, adata->acp_base + ACP_EXTERNAL_INTR_CNTL);
+	writel(ext_int_ctrl, ACP_EXTERNAL_INTR_CNTL(adata, 0));
 
 	return 0;
 }
@@ -175,9 +175,9 @@ static void acp_dmic_dai_shutdown(struct snd_pcm_substream *substream,
 	u32 ext_int_ctrl;
 
 	/* Disable DMIC interrupts */
-	ext_int_ctrl = readl(adata->acp_base + ACP_EXTERNAL_INTR_CNTL);
+	ext_int_ctrl = readl(ACP_EXTERNAL_INTR_CNTL(adata, 0));
 	ext_int_ctrl |= ~PDM_DMA_INTR_MASK;
-	writel(ext_int_ctrl, adata->acp_base + ACP_EXTERNAL_INTR_CNTL);
+	writel(ext_int_ctrl, ACP_EXTERNAL_INTR_CNTL(adata, 0));
 }
 
 const struct snd_soc_dai_ops acp_dmic_dai_ops = {
diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index 3c4fd8b80589..e93c9e478cfa 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -91,6 +91,7 @@ EXPORT_SYMBOL_NS_GPL(acp_machine_select, SND_SOC_ACP_COMMON);
 static irqreturn_t i2s_irq_handler(int irq, void *data)
 {
 	struct acp_dev_data *adata = data;
+	struct acp_resource *rsrc = adata->rsrc;
 	struct acp_stream *stream;
 	u16 i2s_flag = 0;
 	u32 val, i;
@@ -98,12 +99,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
 	if (!adata)
 		return IRQ_NONE;
 
-	val = readl(adata->acp_base + ACP_EXTERNAL_INTR_STAT);
+	val = readl(ACP_EXTERNAL_INTR_STAT(adata, rsrc->irqp_used));
 
 	for (i = 0; i < ACP_MAX_STREAM; i++) {
 		stream = adata->stream[i];
 		if (stream && (val & stream->irq_bit)) {
-			writel(stream->irq_bit, adata->acp_base + ACP_EXTERNAL_INTR_STAT);
+			writel(stream->irq_bit,
+			       ACP_EXTERNAL_INTR_STAT(adata, rsrc->irqp_used));
 			snd_pcm_period_elapsed(stream->substream);
 			i2s_flag = 1;
 			break;
@@ -118,6 +120,7 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
 
 static void config_pte_for_stream(struct acp_dev_data *adata, struct acp_stream *stream)
 {
+	struct acp_resource *rsrc = adata->rsrc;
 	u32 pte_reg, pte_size, reg_val;
 
 	/* Use ATU base Group5 */
@@ -126,7 +129,7 @@ static void config_pte_for_stream(struct acp_dev_data *adata, struct acp_stream
 	stream->reg_offset = 0x02000000;
 
 	/* Group Enable */
-	reg_val = ACP_SRAM_PTE_OFFSET;
+	reg_val = rsrc->sram_pte_offset;
 	writel(reg_val | BIT(31), adata->acp_base + pte_reg);
 	writel(PAGE_SIZE_4K_ENABLE,  adata->acp_base + pte_size);
 }
@@ -135,6 +138,7 @@ static void config_acp_dma(struct acp_dev_data *adata, int cpu_id, int size)
 {
 	struct acp_stream *stream = adata->stream[cpu_id];
 	struct snd_pcm_substream *substream = stream->substream;
+	struct acp_resource *rsrc = adata->rsrc;
 	dma_addr_t addr = substream->dma_buffer.addr;
 	int num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
 	u32 low, high, val;
@@ -146,9 +150,9 @@ static void config_acp_dma(struct acp_dev_data *adata, int cpu_id, int size)
 		/* Load the low address of page int ACP SRAM through SRBM */
 		low = lower_32_bits(addr);
 		high = upper_32_bits(addr);
-		writel(low, adata->acp_base + ACP_SCRATCH_REG_0 + val);
+		writel(low, adata->acp_base + rsrc->scratch_reg_offset + val);
 		high |= BIT(31);
-		writel(high, adata->acp_base + ACP_SCRATCH_REG_0 + val + 4);
+		writel(high, adata->acp_base + rsrc->scratch_reg_offset + val + 4);
 
 		/* Move to next physically contiguous page */
 		val += 8;
@@ -187,7 +191,7 @@ static int acp_dma_open(struct snd_soc_component *component, struct snd_pcm_subs
 	}
 	runtime->private_data = stream;
 
-	writel(1, adata->acp_base + ACP_EXTERNAL_INTR_ENB);
+	writel(1, ACP_EXTERNAL_INTR_ENB(adata));
 
 	return ret;
 }
diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index 8375c00ff4c3..2a89a0d2e601 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -39,6 +39,17 @@
 #define ACP_ERROR_MASK 0x20000000
 #define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
 
+static struct acp_resource rsrc = {
+	.offset = 20,
+	.no_of_ctrls = 1,
+	.irqp_used = 0,
+	.irq_reg_offset = 0x1800,
+	.i2s_pin_cfg_offset = 0x1400,
+	.i2s_mode = 0x04,
+	.scratch_reg_offset = 0x12800,
+	.sram_pte_offset = 0x02052800,
+};
+
 static struct snd_soc_acpi_codecs amp_rt1019 = {
 	.num_codecs = 1,
 	.codecs = {"10EC1019"}
@@ -186,20 +197,24 @@ static int acp3x_reset(void __iomem *base)
 	return readl_poll_timeout(base + ACP_SOFT_RESET, val, !val, DELAY_US, ACP_TIMEOUT);
 }
 
-static void acp3x_enable_interrupts(void __iomem *base)
+static void acp3x_enable_interrupts(struct acp_dev_data *adata)
 {
+	struct acp_resource *rsrc = adata->rsrc;
 	u32 ext_intr_ctrl;
 
-	writel(0x01, base + ACP_EXTERNAL_INTR_ENB);
-	ext_intr_ctrl = readl(base + ACP_EXTERNAL_INTR_CNTL);
+	writel(0x01, ACP_EXTERNAL_INTR_ENB(adata));
+	ext_intr_ctrl = readl(ACP_EXTERNAL_INTR_CNTL(adata, rsrc->irqp_used));
 	ext_intr_ctrl |= ACP_ERROR_MASK;
-	writel(ext_intr_ctrl, base + ACP_EXTERNAL_INTR_CNTL);
+	writel(ext_intr_ctrl, ACP_EXTERNAL_INTR_CNTL(adata, rsrc->irqp_used));
 }
 
-static void acp3x_disable_interrupts(void __iomem *base)
+static void acp3x_disable_interrupts(struct acp_dev_data *adata)
 {
-	writel(ACP_EXT_INTR_STAT_CLEAR_MASK, base + ACP_EXTERNAL_INTR_STAT);
-	writel(0x00, base + ACP_EXTERNAL_INTR_ENB);
+	struct acp_resource *rsrc = adata->rsrc;
+
+	writel(ACP_EXT_INTR_STAT_CLEAR_MASK,
+	       ACP_EXTERNAL_INTR_STAT(adata, rsrc->irqp_used));
+	writel(0x00, ACP_EXTERNAL_INTR_ENB(adata));
 }
 
 static int rn_acp_init(void __iomem *base)
@@ -218,8 +233,6 @@ static int rn_acp_init(void __iomem *base)
 	if (ret)
 		return ret;
 
-	acp3x_enable_interrupts(base);
-
 	return 0;
 }
 
@@ -227,8 +240,6 @@ static int rn_acp_deinit(void __iomem *base)
 {
 	int ret = 0;
 
-	acp3x_disable_interrupts(base);
-
 	/* Reset */
 	ret = acp3x_reset(base);
 	if (ret)
@@ -290,11 +301,13 @@ static int renoir_audio_probe(struct platform_device *pdev)
 	adata->dev = dev;
 	adata->dai_driver = acp_renoir_dai;
 	adata->num_dai = ARRAY_SIZE(acp_renoir_dai);
+	adata->rsrc = &rsrc;
 
 	adata->machines = snd_soc_acpi_amd_acp_machines;
 	acp_machine_select(adata);
 
 	dev_set_drvdata(dev, adata);
+	acp3x_enable_interrupts(adata);
 	acp_platform_register(dev);
 
 	return 0;
@@ -303,11 +316,14 @@ static int renoir_audio_probe(struct platform_device *pdev)
 static int renoir_audio_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
 	struct acp_chip_info *chip;
 	int ret;
 
 	chip = dev_get_platdata(&pdev->dev);
 
+	acp3x_disable_interrupts(adata);
+
 	ret = rn_acp_deinit(chip->base);
 	if (ret)
 		dev_err(&pdev->dev, "ACP de-init Failed (%pe)\n", ERR_PTR(ret));
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 8fd38bf4d3bd..186cb8b26175 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -32,13 +32,12 @@
 #define ACP3x_I2STDM_REG_END		0x1242410
 #define ACP3x_BT_TDM_REG_START		0x1242800
 #define ACP3x_BT_TDM_REG_END		0x1242810
-#define I2S_MODE			0x04
-#define I2S_RX_THRESHOLD		27
-#define I2S_TX_THRESHOLD		28
-#define BT_TX_THRESHOLD			26
-#define BT_RX_THRESHOLD			25
 
-#define ACP_SRAM_PTE_OFFSET		0x02052800
+#define THRESHOLD(bit, base)	((bit) + (base))
+#define I2S_RX_THRESHOLD(base)	THRESHOLD(7, base)
+#define I2S_TX_THRESHOLD(base)	THRESHOLD(8, base)
+#define BT_TX_THRESHOLD(base)	THRESHOLD(6, base)
+#define BT_RX_THRESHOLD(base)	THRESHOLD(5, base)
 
 #define ACP_SRAM_SP_PB_PTE_OFFSET	0x0
 #define ACP_SRAM_SP_CP_PTE_OFFSET	0x100
@@ -92,6 +91,17 @@ struct acp_stream {
 	u32 fifo_offset;
 };
 
+struct acp_resource {
+	int offset;
+	int no_of_ctrls;
+	int irqp_used;
+	u32 irq_reg_offset;
+	u32 i2s_pin_cfg_offset;
+	int i2s_mode;
+	u64 scratch_reg_offset;
+	u64 sram_pte_offset;
+};
+
 struct acp_dev_data {
 	char *name;
 	struct device *dev;
@@ -106,6 +116,8 @@ struct acp_dev_data {
 
 	struct snd_soc_acpi_mach *machines;
 	struct platform_device *mach_dev;
+
+	struct acp_resource *rsrc;
 };
 
 extern const struct snd_soc_dai_ops asoc_acp_cpu_dai_ops;
diff --git a/sound/soc/amd/acp/chip_offset_byte.h b/sound/soc/amd/acp/chip_offset_byte.h
index 88f6fa597cd6..fff7e80475ba 100644
--- a/sound/soc/amd/acp/chip_offset_byte.h
+++ b/sound/soc/amd/acp/chip_offset_byte.h
@@ -20,11 +20,13 @@
 #define ACP_SOFT_RESET                          0x1000
 #define ACP_CONTROL                             0x1004
 
-#define ACP_EXTERNAL_INTR_ENB                         0x1800
-#define ACP_EXTERNAL_INTR_CNTL                        0x1804
-#define ACP_EXTERNAL_INTR_STAT                        0x1808
-#define ACP_I2S_PIN_CONFIG                            0x1400
-#define ACP_SCRATCH_REG_0                             0x12800
+#define ACP_EXTERNAL_INTR_REG_ADDR(adata, offset, ctrl) \
+	(adata->acp_base + adata->rsrc->irq_reg_offset + offset + (ctrl * 0x04))
+
+#define ACP_EXTERNAL_INTR_ENB(adata) ACP_EXTERNAL_INTR_REG_ADDR(adata, 0x0, 0x0)
+#define ACP_EXTERNAL_INTR_CNTL(adata, ctrl) ACP_EXTERNAL_INTR_REG_ADDR(adata, 0x4, ctrl)
+#define ACP_EXTERNAL_INTR_STAT(adata, ctrl) ACP_EXTERNAL_INTR_REG_ADDR(adata, \
+	(0x4 + (adata->rsrc->no_of_ctrls * 0x04)), ctrl)
 
 /* Registers from ACP_AUDIO_BUFFERS block */
 
-- 
2.25.1

