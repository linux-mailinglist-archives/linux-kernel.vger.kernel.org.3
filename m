Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE2A583EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbiG1MiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiG1MiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:38:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078EB68DF7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:38:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/Sh7A0FUuYiCUIEseV2b8xwhBMbc42ve2BtqfHzAmnDqc2G8ZcZj2fk8j8GmOHIO+X+8cGWvd0+h25UsAdpUbGA+XiRUOFIy46oK2Z7UiywE7Sg5GXLOZAelc6jH5LVngMSg8G+hauHLBvsm5e+6VLsnIttdp/nXY6XOTP+4d6t9/pEGlCCyBzETWvR6gxxfISvyZ0dSUc7aCV3tAzUT5xoNt5I5QFj/PCmZMJIuxomCPnjLU03htqA2oUDKnl5ItnGMmkCwmTIX83XpzX2fE1RbuN5fkh6yVW3SrJtraq8vfxLn+V+W1cU5IbSlcp6A2uSjhc9BBf04nOo9IWaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTF6rwyI/0jWBfxCWspkyLFtV0P2qNt/AhlZTQ6yoZw=;
 b=JJ1zrRSh5RLX562QVJRgqwHzLQAYf56TCj0pYfMsMdp5Zvaua+rBvslL5S+oa92DBlCZ7i/IiDhm0YzQ/loKAfCwQEkFm+BsQ9y/zK1IlSOnY5ucPG5Wwhw1B9PZRMK/BUgfOOr+Y4zGiDcp1NrFbjU1tkcMN4NkHdht83jaLugOYjR2kJ7TRntW9OnF+8D0wstJfgtK4S7xpMBzdpq9v+wzV5DHVZqkSB01F5CIH2RCH5qRn6Tzw9zPgfBwXY77OFo9W1CHYFj1EKJcfQUQ2cmPfdxOFUoSDjPfIBifXia48ZwKfoecZGZM0mVaeD3Di+TuWr4jL+EMlUQJbAiEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTF6rwyI/0jWBfxCWspkyLFtV0P2qNt/AhlZTQ6yoZw=;
 b=llw3AN9O711PRWR5xJwk6I3eIBRqSn3Vq0scOH9i5mg0ZN9VnTGAld6bUow5WMF3+iTT0lA2GKr17NDaa6UcxC02cnAOYZdmr+k4PdxhgRHgqM31MJ2zFESIARvuVj+KNgTkSlCJZoQWbi0tVuzHt3o7Dgu0jcFSANMM32ZeTRs=
Received: from MW4PR03CA0204.namprd03.prod.outlook.com (2603:10b6:303:b8::29)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 12:37:54 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::e0) by MW4PR03CA0204.outlook.office365.com
 (2603:10b6:303:b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.7 via Frontend
 Transport; Thu, 28 Jul 2022 12:37:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 12:37:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 07:37:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 05:37:51 -0700
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 28 Jul 2022 07:37:41 -0500
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
        "Yang Yingliang" <yangyingliang@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] ASoC: amd: acp: Initialize list to store acp_stream during pcm_open
Date:   Thu, 28 Jul 2022 18:10:50 +0530
Message-ID: <20220728124057.54259-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e76f18b-2bc6-46cd-81ac-08da7095fdee
X-MS-TrafficTypeDiagnostic: CY5PR12MB6083:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUN6CXBxgNbVVkHrJh1tezABNQ7a9I1CQi2d8u5KIHtaerLDWCRsoIhtXg9m9gJgFs2m7g1vJpaA/3MttYnsha8aB+Uh9jvZV2Vx8SqSYjqNto8sNuY+pnn09Ks8IgASRXw1sEOBL/E5LfSymUWKNW+9Wm+ljjVETSb4aUecdReEXqruDWqEKPMM4tkaGysClBQL8yNys3LLViK0iAvFXKwHYnyCGyBoLR/YhCjTNhVH9NLKOO946y3cXGLBUHqXbobZQ8MbBkoIBs2jjktGT/vj8/rYz5R+Qjk0GtacAAJ6ZRtMVhQRvV8RTckdKj9W9rRabTLaZjZMkJ6zEFrDb2RLj+weLgJmsNkjHIPH17bE2064tdUe83DyoD39/qH2tmSrkWc/zoFLChW3dTLdOvw77BSN8dh4M7H2nliserYsSWjN0WRZfa58yimyO0EH7u62W1c3lHURac5lpeaKj8As5oO4DYnUGhQTYDMaZmM4Z6TF+4LfWCYvatVeAJHQbZ/obT1A6hG2pE0H9i7MkxNWiAPcyJSj+kWiWjdJaOYx4kKGx4ouTxCQgGPRPJxTlIUL6Kkz/Zh3/fOiEo6vqecZFjG7RhbMLJQccIDrZOUAd812cyxrsmyH5UF+QJCiwzpGyg0KQS57xjoULx45C+F+K+Zuaq+KonxDAy9jF3xilUeO1nMWdhticZ10RdiPq158xjBZ+32GW0mEJ0wXtoX4H2Z0pR7AglPdyMdvlm3hQf+66+5k2XfkOHzbFxReBpxLj1GsgblLeZLh9WkHIkHxgQIQSVr2HpvgRmb6pu95LEohe3MH9/lA4yxrTju545hB9UFNKmMJ9q3BhqtJvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(336012)(2616005)(5660300002)(41300700001)(8936002)(478600001)(82740400003)(316002)(81166007)(110136005)(1076003)(40460700003)(356005)(7696005)(26005)(54906003)(6666004)(8676002)(4326008)(186003)(47076005)(86362001)(426003)(70586007)(83380400001)(36860700001)(70206006)(2906002)(40480700001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 12:37:53.7332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e76f18b-2bc6-46cd-81ac-08da7095fdee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083
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
Changes since v2:
    -- Add locking mechanism in irq handler, linked list updatation and deletion.
Changes since v1:
    -- Fix compile error and remove unused variable.

 sound/soc/amd/acp/acp-platform.c | 43 ++++++++++++++++----------------
 sound/soc/amd/acp/amd.h          |  4 ++-
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index f561d39b33e2..4d35c75611d3 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -93,8 +93,9 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
 	struct acp_dev_data *adata = data;
 	struct acp_resource *rsrc = adata->rsrc;
 	struct acp_stream *stream;
+	unsigned long flags;
 	u16 i2s_flag = 0;
-	u32 ext_intr_stat, ext_intr_stat1, i;
+	u32 ext_intr_stat, ext_intr_stat1;
 
 	if (!adata)
 		return IRQ_NONE;
@@ -104,14 +105,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
 
 	ext_intr_stat = readl(ACP_EXTERNAL_INTR_STAT(adata, rsrc->irqp_used));
 
-	for (i = 0; i < ACP_MAX_STREAM; i++) {
-		stream = adata->stream[i];
+	spin_lock_irqsave(&adata->acp_lock, flags);
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
@@ -119,10 +119,10 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
 				       (rsrc->irqp_used - 1)));
 				snd_pcm_period_elapsed(stream->substream);
 				i2s_flag = 1;
-				break;
 			}
 		}
 	}
+	spin_unlock_irqrestore(&adata->acp_lock, flags);
 	if (i2s_flag)
 		return IRQ_HANDLED;
 
@@ -146,9 +146,8 @@ static void config_pte_for_stream(struct acp_dev_data *adata, struct acp_stream
 	writel(0x01, adata->acp_base + ACPAXI2AXI_ATU_CTRL);
 }
 
-static void config_acp_dma(struct acp_dev_data *adata, int cpu_id, int size)
+static void config_acp_dma(struct acp_dev_data *adata, struct acp_stream *stream, int size)
 {
-	struct acp_stream *stream = adata->stream[cpu_id];
 	struct snd_pcm_substream *substream = stream->substream;
 	struct acp_resource *rsrc = adata->rsrc;
 	dma_addr_t addr = substream->dma_buffer.addr;
@@ -174,21 +173,22 @@ static void config_acp_dma(struct acp_dev_data *adata, int cpu_id, int size)
 
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
+	unsigned long flags;
 
 	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
 	if (!stream)
 		return -ENOMEM;
 
 	stream->substream = substream;
-	adata->stream[stream_id] = stream;
+
+	spin_lock_irqsave(&adata->acp_lock, flags);
+	list_add_tail(&stream->list, &adata->stream_list);
+	spin_unlock_irqrestore(&adata->acp_lock, flags);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		runtime->hw = acp_pcm_hardware_playback;
@@ -212,16 +212,13 @@ static int acp_dma_hw_params(struct snd_soc_component *component,
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
@@ -261,16 +258,16 @@ static int acp_dma_new(struct snd_soc_component *component,
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
+	unsigned long flags;
 
-	stream = adata->stream[stream_id];
+	/* Remove entry from list */
+	spin_lock_irqsave(&adata->acp_lock, flags);
+	list_del(&stream->list);
+	spin_unlock_irqrestore(&adata->acp_lock, flags);
 	kfree(stream);
-	adata->stream[stream_id] = NULL;
 
 	return 0;
 }
@@ -305,6 +302,10 @@ int acp_platform_register(struct device *dev)
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

