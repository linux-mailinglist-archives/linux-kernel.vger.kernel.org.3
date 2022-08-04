Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6597F589841
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbiHDHW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiHDHWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:22:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078D460517
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dT+lQf07dm+IaHryMACcgcWSH+LoXMKh51UJTEAN72wHA9BtT8Ik/sMcbgPd6+8SQXcO6XR64ijgoyS6FWZL3Wy1eccOtohJofHN/W8qajBpyjL36f+G8aouUH/JkbIcsCE8YJf4iGFtj80/QMJDRujjdoWtJV8kjAZ9LKGXob9iy17cozH85222NnHpQmFEtqCtLyAh7MrZznugtP7Z4fM7D4bXjQKqCCWNiWSHENB2O1CIOXCNIzDeIkEu2YKceCq/qBKckkQaKBA5M8qhwcFP4s3GpELfBFZxrm88XYaTu9BGBOeMVtJTCj4Nzzwl3K3JMGcmYtsqHBBinF3nCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q8F3kKdc5m+YkIWrnn+9p/HQv/WaiB8KgctKoh9xZ0=;
 b=Ve7oDbS1DzWE8F01h6xn+iBwsaQkvbnxBBM56Ncaqk3IVFNGfG5wIcag5glahdymnGlOqhgpOsK79NbSycoGJ0bgBGmYIU5C1s6M8oS5FxABOOjoqe4nKTOXU+Edga7UFZtt57MDiLaI1viJFWGPRTxmNJFT+W0fX9PB7eohOoQOcEAY6SVBF1Oy6BkCg/RzIjuwY0X7kfzK4bRMO1m8lyOT9TG2EmU5axrgv/SRvxwiP8Tn1pmZoaczqBVCeh5mqrDCMm7YdjUqOcK/z/v4sosTHHQ0Oj0X/pjpKtTFyFfKkN7t+B429stCHVdoGjrRQxTbTYntuafoOK1Jo0ogwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q8F3kKdc5m+YkIWrnn+9p/HQv/WaiB8KgctKoh9xZ0=;
 b=S6/LgthbkbQAQHkvN4BMKVP8BzVA268l+hfCzmMDhH0XJyvaw/l8BVFkAsMktoFau4RFVA/N513MtJf96bqb3c/swIUGorPa+m64agSdtl+8VfaZQf8Fdobe2JthLgEYnq+qMRtfJrVcsS6ogmSSj3ceS5JMeCQk0AfH+FTxMvw=
Received: from BN0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:408:e6::31)
 by DM6PR12MB4878.namprd12.prod.outlook.com (2603:10b6:5:1b8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 07:22:49 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::c9) by BN0PR03CA0026.outlook.office365.com
 (2603:10b6:408:e6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Thu, 4 Aug 2022 07:22:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Thu, 4 Aug 2022 07:22:49 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 4 Aug
 2022 02:22:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 4 Aug
 2022 00:22:48 -0700
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 4 Aug 2022 02:22:39 -0500
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <ssabakar@amd.com>, Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "Venkata Prasad Potturu" <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        "Charles Keepax" <ckeepax@opensource.cirrus.com>,
        Nathan Chancellor <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] ASoC: amd: acp: Initialize list to store acp_stream during pcm_open
Date:   Thu, 4 Aug 2022 12:55:49 +0530
Message-ID: <20220804072556.601396-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 652231fd-dd2b-420f-7164-08da75ea22e8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4878:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jVZP+Jw1thH0jZyi5l+AJGQRbwrfFO75h6KuXDCJ01HKF8yAkkc4g6kEWYMijDipzDoftl4u8Xbm28M4pNOYW5Q3yIay6sKJgev+uwjnDHVucNx32q52YsCHeYXJU+pzLdi3HaPPm0jEW9nVZ/oWzY4q9/TozMw7+pkfm5F56gFjXRJDW2i9DTdqxq5Bdt5HaClLScsz8VdPMYTRI9jU5LpoEKTyXCV+yR000bYI8pWnBiuMmrAsClTJXVV1BFOzKEXFtzTlSLP8MD+9msXzFo1dwzCTyy4sKcqdFuABjSLIiMyBvmga8K4ka/fcbKNcaVFxXwM4k6kNAj781s8mSws+U9MOrOuGQMP0UHHlr6Flner1gVdq2nFy0eCXIg4XeBcF2TMHaVFpzPAMfMFwizS8mLd8AWVOsGEdoHyoLn2BuCUsnjr6T5nONguJs2E20C5woblnTFEihJu3TjCxQUqI7tMBkh+HFGZyq43fYJCQS+iVXe8zhJts0kvUfVejUyrVQpHgw0YtBs8A8EI05M/sz1ZoaNTNJAg0qGke+8TkS8I1bQmbb6gYh7ZRsNfJ6xw4FBsBwVXXo78W7SzWdCGK8zmp70DQnBjFH63hIMVvocFs7hM/oWemGMaac7CC9pu5zqfmI4HDLMJySp0yy8eOgxPI2+cX2p/fIhZkcy4xtBUiK1eM7Z37Sa0zPqhbqFAqU28fMEElwhtXcUqQrLF3PVC/QSfqdbLPu5pUMV/1rgGFJJ5koURPJPGjuRzHuycFfkK9w48RYx5ZNwAP60WxHX6/fcaojpWSxdpSd1l0uB8rl67l4Gzd9eGa0Gyfq2PjFBfT1/aAiRsUo8No9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(39860400002)(346002)(36840700001)(40470700004)(46966006)(426003)(336012)(47076005)(1076003)(2616005)(186003)(82740400003)(356005)(81166007)(40460700003)(83380400001)(36860700001)(8936002)(5660300002)(8676002)(4326008)(70206006)(70586007)(82310400005)(40480700001)(2906002)(6666004)(41300700001)(478600001)(7696005)(26005)(54906003)(316002)(110136005)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 07:22:49.4177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 652231fd-dd2b-420f-7164-08da75ea22e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4878
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>

We are currently allocating acp_stream during pcm_open and saving
it in static array corresponds to array index calculated based on
cpu dai->driver id. This approach will fail if we have single dai
linked to multiple pcm device as we will have same dai->driver id
or array index for multiple pcm open. Initialize new linked list
stream_list to store opened pcm stream info dynamically.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
Changes since v3:
    -- Modify to spin_lock() in irq handler and spin_lock_irq() in dma open and close
       functions instead of spin_lock_irqsave().
Changes since v2:
    -- Add locking mechanism in irq handler, linked list updatation and deletion.
Changes since v1:
    -- Fix compile error and remove unused variable.
 sound/soc/amd/acp/acp-platform.c | 40 +++++++++++++++-----------------
 sound/soc/amd/acp/amd.h          |  4 +++-
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index f561d39b33e2..beee53aedeaf 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -94,7 +94,7 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
 	struct acp_resource *rsrc = adata->rsrc;
 	struct acp_stream *stream;
 	u16 i2s_flag = 0;
-	u32 ext_intr_stat, ext_intr_stat1, i;
+	u32 ext_intr_stat, ext_intr_stat1;
 
 	if (!adata)
 		return IRQ_NONE;
@@ -104,14 +104,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
 
 	ext_intr_stat = readl(ACP_EXTERNAL_INTR_STAT(adata, rsrc->irqp_used));
 
-	for (i = 0; i < ACP_MAX_STREAM; i++) {
-		stream = adata->stream[i];
+	spin_lock(&adata->acp_lock);
+	list_for_each_entry(stream, &adata->stream_list, list) {
 		if (stream && (ext_intr_stat & stream->irq_bit)) {
 			writel(stream->irq_bit,
 			       ACP_EXTERNAL_INTR_STAT(adata, rsrc->irqp_used));
 			snd_pcm_period_elapsed(stream->substream);
 			i2s_flag = 1;
-			break;
 		}
 		if (adata->rsrc->no_of_ctrls == 2) {
 			if (stream && (ext_intr_stat1 & stream->irq_bit)) {
@@ -119,10 +118,10 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
 				       (rsrc->irqp_used - 1)));
 				snd_pcm_period_elapsed(stream->substream);
 				i2s_flag = 1;
-				break;
 			}
 		}
 	}
+	spin_unlock(&adata->acp_lock);
 	if (i2s_flag)
 		return IRQ_HANDLED;
 
@@ -146,9 +145,8 @@ static void config_pte_for_stream(struct acp_dev_data *adata, struct acp_stream
 	writel(0x01, adata->acp_base + ACPAXI2AXI_ATU_CTRL);
 }
 
-static void config_acp_dma(struct acp_dev_data *adata, int cpu_id, int size)
+static void config_acp_dma(struct acp_dev_data *adata, struct acp_stream *stream, int size)
 {
-	struct acp_stream *stream = adata->stream[cpu_id];
 	struct snd_pcm_substream *substream = stream->substream;
 	struct acp_resource *rsrc = adata->rsrc;
 	dma_addr_t addr = substream->dma_buffer.addr;
@@ -174,13 +172,10 @@ static void config_acp_dma(struct acp_dev_data *adata, int cpu_id, int size)
 
 static int acp_dma_open(struct snd_soc_component *component, struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
-	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct device *dev = component->dev;
 	struct acp_dev_data *adata = dev_get_drvdata(dev);
 	struct acp_stream *stream;
-	int stream_id = cpu_dai->driver->id * 2 + substream->stream;
 	int ret;
 
 	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
@@ -188,7 +183,10 @@ static int acp_dma_open(struct snd_soc_component *component, struct snd_pcm_subs
 		return -ENOMEM;
 
 	stream->substream = substream;
-	adata->stream[stream_id] = stream;
+
+	spin_lock_irq(&adata->acp_lock);
+	list_add_tail(&stream->list, &adata->stream_list);
+	spin_unlock_irq(&adata->acp_lock);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		runtime->hw = acp_pcm_hardware_playback;
@@ -212,16 +210,13 @@ static int acp_dma_hw_params(struct snd_soc_component *component,
 			     struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
 	struct acp_dev_data *adata = snd_soc_component_get_drvdata(component);
-	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
 	struct acp_stream *stream = substream->runtime->private_data;
-	int stream_id = cpu_dai->driver->id * 2 + substream->stream;
 	u64 size = params_buffer_bytes(params);
 
 	/* Configure ACP DMA block with params */
 	config_pte_for_stream(adata, stream);
-	config_acp_dma(adata, stream_id, size);
+	config_acp_dma(adata, stream, size);
 
 	return 0;
 }
@@ -261,16 +256,15 @@ static int acp_dma_new(struct snd_soc_component *component,
 static int acp_dma_close(struct snd_soc_component *component,
 			 struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
-	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
 	struct device *dev = component->dev;
 	struct acp_dev_data *adata = dev_get_drvdata(dev);
-	struct acp_stream *stream;
-	int stream_id = cpu_dai->driver->id * 2 + substream->stream;
+	struct acp_stream *stream = substream->runtime->private_data;
 
-	stream = adata->stream[stream_id];
+	/* Remove entry from list */
+	spin_lock_irq(&adata->acp_lock);
+	list_del(&stream->list);
+	spin_unlock_irq(&adata->acp_lock);
 	kfree(stream);
-	adata->stream[stream_id] = NULL;
 
 	return 0;
 }
@@ -305,6 +299,10 @@ int acp_platform_register(struct device *dev)
 		dev_err(dev, "Fail to register acp i2s component\n");
 		return status;
 	}
+
+	INIT_LIST_HEAD(&adata->stream_list);
+	spin_lock_init(&adata->acp_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(acp_platform_register, SND_SOC_ACP_COMMON);
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 60a7c95f134f..be8bb8247c4e 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -91,6 +91,7 @@ struct acp_chip_info {
 };
 
 struct acp_stream {
+	struct list_head list;
 	struct snd_pcm_substream *substream;
 	int irq_bit;
 	int dai_id;
@@ -123,7 +124,8 @@ struct acp_dev_data {
 	struct snd_soc_dai_driver *dai_driver;
 	int num_dai;
 
-	struct acp_stream *stream[ACP_MAX_STREAM];
+	struct list_head stream_list;
+	spinlock_t acp_lock;
 
 	struct snd_soc_acpi_mach *machines;
 	struct platform_device *mach_dev;
-- 
2.25.1

