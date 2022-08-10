Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D1858ED20
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiHJN0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiHJN0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:26:25 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2071.outbound.protection.outlook.com [40.107.212.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD2C32BB6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgBvRe6IuRahQxsmnysKdyU/QtjkZnbwjqKIuvcCi+/5awJYcYqC3JzxIdd1IrXykWGk6JDTKnUoHJMs4pCy1E1MNPJLeVLq/Pjm1OCiGIucN0r70pkH6lfBwia3A5Nv+XNSoYL7B8BdU6prIQLbRMDIjHBCbCegwjln9x03wijkz520Ru2Y7ccur4vd+oF8QNtfxY3jCEtxT3HwghAjoYrkRVg1rzV6MQKcFt5X5EsgBRtSkyvyoA/j7G+SQF9cS1K0dnif3NrOVR22umglwMll+tb/D1WYOn3RWCkdAHQsaU0+Tfbn/hE0QYQvS6NX61/+s3b1DDxtd42Xwsavvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FteUpw9UPC6QnEzgQZquD1FS608rwf9T42I5hnTZs0=;
 b=dz6UA5rs/LIXoq9RiCKQxzhgGBMNui3fRKIiRLt8iqUcc+gi0LK/LEP069VAGFKk2o8AjGrI9kZP7eESgBBFbLhnq9uqnvD7hR2cgZmci0DxUr/XX8k3H/SDlheP6URdQitRDjzLwULdfXIuthQeILfNjQkqzg+8UYLHtf+KTU3J2A3DaD53mMpaD2egGPzXIiwMJrv+9FKNVM2ecWieaj1oZ7PhiGH8L8rMzpKja2NRn7dG2ALWRcCRvt0VptwtYY7hp2R44tasJJ8QL0du/X3TyH3+I/APV7RXPIxCJpbuvbs3VS2tgI7xmaAnuzZ/iD/0L5x2cLhNK/nGx/v3Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FteUpw9UPC6QnEzgQZquD1FS608rwf9T42I5hnTZs0=;
 b=UmWshlz7Qg89T2espCj+REgBhEe1IY5dkTrLOA5anaJKFIiyvblBNjqA1gHp7ZnXIgv+i21LgJBODcR7+6Ape6xDgVQDKC3LeYHurvq7b1F1jUx+KAZSW0/FfHOuJQ7mIf1Ddj8wA4Oq78d32yMlhTArg8/SVvdp7XyE5vaBoyc=
Received: from BN0PR04CA0208.namprd04.prod.outlook.com (2603:10b6:408:e9::33)
 by SN7PR12MB6887.namprd12.prod.outlook.com (2603:10b6:806:261::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 10 Aug
 2022 13:26:21 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::65) by BN0PR04CA0208.outlook.office365.com
 (2603:10b6:408:e9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Wed, 10 Aug 2022 13:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Wed, 10 Aug 2022 13:26:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 10 Aug
 2022 08:26:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 10 Aug
 2022 08:26:20 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Wed, 10 Aug 2022 08:26:10 -0500
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
        "Nathan Chancellor" <nathan@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [RESEND v4 1/2] ASoC: amd: acp: Initialize list to store acp_stream during pcm_open
Date:   Wed, 10 Aug 2022 18:59:12 +0530
Message-ID: <20220810132913.1181247-2-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810132913.1181247-1-venkataprasad.potturu@amd.com>
References: <20220810132913.1181247-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43973845-9ebc-4151-f21d-08da7ad3ea4b
X-MS-TrafficTypeDiagnostic: SN7PR12MB6887:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PP3YdD5acFM5zdA/frzvMR4H8C0iJ0IOMXAeKbhWmg0TaIVbAppInfuc0tTPPwhftg/2olT5xM4nWUizpxfPadk9ob1eMIIP8LPs2O5wiZYB90PeJc/2UhTRmseiSevO8CvKOYe++Rg+wG50EK1kKx7Ei7IVJbIpOAygqy1H6Lme79BQBK8Y7MyA0VD+riZg3XXgNq/+glpi3DlTjJgIUaxzLLWB1k0cu/PthZFAgs9HMlynkhMtJOvXuVRTBd479UJSKBVTTNw8J+d2vx8XhhK1g1f5apE4CT8MvuMueuk8V+dMZy47gjd/1844z4JDsv24kPcphRcqkKNAyJFiPztUe4sHP4IrTR8imftCCmgtFzoST8oZPesD+LLQNS6Rw4n+0h+plueazHEIWGOYG7P3iIPwbFmgEg1/offajn5ys1EiR/y226Dh53ZL/8JwSuym8+XAiCz+OuMjKOTlJmx4cewvj2rHpg1syAwgNTXlRC07IMyTSsFKEfRyM9/pR1IKe21d0XvTA22kvdaAIg+x2oUlUC8FjahyTkA+5yebGUtYdp2DLm+IMMTc5+HGK9ihajlY9+fzFdg0RZMq7qAhIbcuaRViSQeBCLbuWUz39r+xkesi/WMPWRGiNefFcgc9w/HOXx7TBYgGD335oHYt11Ezaxbjxf+qNxitxg24Nnwl95DAKxi9OFnYfCmbM3lh8HfVakvyzsWcxEzv1n/re551mo47baAzKzFRxP7/yKpXYTNERva7VQxpmby/gMQ+oOB72JCa9SHB52G3VYDyebG+JiWkfw4clnqsO6rJQMZsOLPxE/qDfOwQ20aEQ/q85dhe1zWyoQBeUG9meA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(36840700001)(40470700004)(46966006)(70586007)(5660300002)(70206006)(40480700001)(40460700003)(82310400005)(4326008)(8676002)(2906002)(316002)(36860700001)(2616005)(41300700001)(8936002)(47076005)(86362001)(36756003)(336012)(81166007)(478600001)(82740400003)(26005)(110136005)(186003)(426003)(356005)(54906003)(83380400001)(1076003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 13:26:21.3255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43973845-9ebc-4151-f21d-08da7ad3ea4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

