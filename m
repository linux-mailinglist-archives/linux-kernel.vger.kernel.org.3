Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A484957C44C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiGUGSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGUGSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:18:21 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C933D4504F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:18:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuY3vDI/gArAVhNu4BdMqrsn2+I98hJ9s+DLDsYuajes8FC5H59mofsLU9cmKpeWCUjQEMyANdCviOBVaaUVZ0kEgUBwbsiM9QjgEWFv7Z4pXmCVwIjEaeKqViO7VB6ROVfuCaTHCmBPt0EOhTpWBiEbPlBMcLmMVkgHx/qHw9ieKsigTeiN8wkgsQ9Nl5ZQjTFCj3tZjy2e5jB/7UxcgYCPyM3m5CUQUTxmQB0AcP46F08Uel8MPDHN+pWEvPpdBNog6Si7gJV+Ji0BFNtc3/HjHXgPKdGxv01+CDkSRSrq4S+sZhwZ/Hhlr1VctKrccw/FB9B4J2smNmoBKX9vdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pv+D49UnsJe1APYUJaIp52MXmIO632MLsALEAe04Ddw=;
 b=hR2ZF8rhxUbPAsPb5WIQKWnVzZByah5JoegT3rCnTRT7928Md/X0VJRgfw0kQA6uZkth3/eqPKIuIxyGzeJzVBB60xniBAyttTlHbij5uyTbOIgenEoLQHxAOdRp/DwkDlPwnKpl7WaEh7syhro0no1WJ45cOjngMl5aue2Y8deXteCr+7nVLl46wItylFtEmuHwtq2c5VeFSNqwHSvq8X86FqtxwWGGhhdHXRDqGPWIAibXVtU9vxVToayndTaRnaI/jUWGvDjPb5vXcUbpqp5xY3bOgkuq0lsAUby1irQpl7qIGKUht/AlFCzuOQG88pppsrVBhNq1jmsnKPWlaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv+D49UnsJe1APYUJaIp52MXmIO632MLsALEAe04Ddw=;
 b=F8517QQE96fpEJMqglvp5lqcO/xMQxOp1pLx/5/4QhkgRGFmRqCnBV9nzbGE03/mYGx072lVvF9qsfigtEtq0MMyX250O3dHY8dWdMvHiBMfNqwqcsWVkHXcDS2TOYJ3oDfZwfLJzbt//QfwOc4/jcwhvk4I9GkWuBcIqc2mzfw=
Received: from BN0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:e7::30)
 by MWHPR1201MB0253.namprd12.prod.outlook.com (2603:10b6:301:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Thu, 21 Jul
 2022 06:18:18 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::ca) by BN0PR03CA0055.outlook.office365.com
 (2603:10b6:408:e7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Thu, 21 Jul 2022 06:18:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 06:18:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 01:18:15 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 21 Jul 2022 01:18:06 -0500
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
        Yang Yingliang <yangyingliang@huawei.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] ASoC: amd: acp: Initialize list to store acp_stream during pcm_open
Date:   Thu, 21 Jul 2022 11:50:35 +0530
Message-ID: <20220721062043.3016985-3-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721062043.3016985-1-venkataprasad.potturu@amd.com>
References: <20220721062043.3016985-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f606bbc1-a3e5-43b3-39e0-08da6ae0cd39
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0253:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0ibHbnv1gfX5fO/u5YFJLDbOGh0AFGw5cEf+3TbBsHpU3vbMV7HwwLlBFKHr/wlwkJF5xzAnCX7a2uimQTzmRej/qsx1EEQWqNJbxwvtzGAcpY4rZ3KubDasTfnxNhv5icG2wB3GJcQSvuslzlUJ1Qy+nLDviC/PX8lizspDhuTox663j4osm/YVoK8bKTKeXyNiv5sdZjQwLKt2JIS9Rl5aANGvg7wRu/UYJWT17n5mx3snLNQgt962f/U2NGJoZeYgOYxqvPPtygoQAtoOLP0xqhRMUnU+jT7jz6g7fHRtIRidwdEcAWCU6qjVNMoYVktZvLQqfClCQeoEhil6YyUYgwNVmBhsYhOYZMRfZI7rDpxvg1qzTJLxmUSEoc+Z3tKQjBF1yc9r2nISRZiBsWccHiWA4ava+Bmcntm+Hx2tEti3jBsRD22lOgemAp4V36/MKcLZIPgbbkyKcRWpVqUNTqIyFAXFKTfZXnRpUekLt0JYQBAM+qR9AlUtt/r9XZJKeDnV9PkyopQTgYbgaKpsax9Z8jKaL7YcauGJOuWFIBxnNwa6iJ5OtbGuNwsUncF8EJurJ8l1YqZ6+LEuJIi3KcZgr19ivDqKr4hxgANjLWDJQebHuQIrg2sjvRhERuSkSMqlSv/zFUNpopuJfQ/UkDEIGqPLkn+o51JqTY2Fkd4xSgIzgi21tLHN6vRqcyyTTUNXy/MCo8+ueHi4tWRqbSgRqMlOzlSVNNrjadVS4i+XsstZ2fKEGfd2PjgxLcGnYsX6gf/qBGDoGK/phL2BaN53CIXtVlLAg/3o9itcEngz1nBBYBupUbg9nVG6pQo7XYJk0kUZqYme3Hb/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(36840700001)(40470700004)(46966006)(82310400005)(70206006)(8936002)(81166007)(5660300002)(478600001)(40480700001)(40460700003)(8676002)(70586007)(4326008)(2906002)(36860700001)(86362001)(83380400001)(336012)(110136005)(186003)(356005)(54906003)(41300700001)(82740400003)(26005)(36756003)(316002)(2616005)(7696005)(1076003)(426003)(47076005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 06:18:17.3863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f606bbc1-a3e5-43b3-39e0-08da6ae0cd39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0253
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
 sound/soc/amd/acp/acp-platform.c | 30 +++++++++++-------------------
 sound/soc/amd/acp/amd.h          |  3 ++-
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index 10730d33c3b0..97198db7000e 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -104,7 +104,7 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
 
 	ext_intr_stat = readl(ACP_EXTERNAL_INTR_STAT(adata, rsrc->irqp_used));
 
-	for (i = 0; i < ACP_MAX_STREAM; i++) {
+	list_for_each_entry(stream, &adata->stream_list, list) {
 		stream = adata->stream[i];
 		if (stream && (ext_intr_stat & stream->irq_bit)) {
 			writel(stream->irq_bit,
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
@@ -174,13 +173,10 @@ static void config_acp_dma(struct acp_dev_data *adata, int cpu_id, int size)
 
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
@@ -188,7 +184,8 @@ static int acp_dma_open(struct snd_soc_component *component, struct snd_pcm_subs
 		return -ENOMEM;
 
 	stream->substream = substream;
-	adata->stream[stream_id] = stream;
+
+	list_add_tail(&stream->list, &adata->stream_list);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		runtime->hw = acp_pcm_hardware_playback;
@@ -212,16 +209,13 @@ static int acp_dma_hw_params(struct snd_soc_component *component,
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
@@ -261,16 +255,11 @@ static int acp_dma_new(struct snd_soc_component *component,
 static int acp_dma_close(struct snd_soc_component *component,
 			 struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
-	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
-	struct device *dev = component->dev;
-	struct acp_dev_data *adata = dev_get_drvdata(dev);
-	struct acp_stream *stream;
-	int stream_id = cpu_dai->driver->id * 2 + substream->stream;
+	struct acp_stream *stream = substream->runtime->private_data;
 
-	stream = adata->stream[stream_id];
+	/* Remove entry from list */
+	list_del(&stream->list);
 	kfree(stream);
-	adata->stream[stream_id] = NULL;
 
 	return 0;
 }
@@ -305,6 +294,9 @@ int acp_platform_register(struct device *dev)
 		dev_err(dev, "Fail to register acp i2s component\n");
 		return status;
 	}
+
+	INIT_LIST_HEAD(&adata->stream_list);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(acp_platform_register, SND_SOC_ACP_COMMON);
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index af9603724a68..148a9ab6206d 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -91,6 +91,7 @@ struct acp_chip_info {
 };
 
 struct acp_stream {
+	struct list_head list;
 	struct snd_pcm_substream *substream;
 	int irq_bit;
 	int dai_id;
@@ -123,7 +124,7 @@ struct acp_dev_data {
 	struct snd_soc_dai_driver *dai_driver;
 	int num_dai;
 
-	struct acp_stream *stream[ACP_MAX_STREAM];
+	struct list_head stream_list;
 
 	struct snd_soc_acpi_mach *machines;
 	struct platform_device *mach_dev;
-- 
2.25.1

