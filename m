Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A31657E256
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiGVNcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVNcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:32:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FD982FAA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:32:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwRjXa7gxLxUiLImhBo1aUM9dcX17IerMD7a2iGixMOUnyGD1ISnK6dwjPtdrBqQPPEbCuKpqAeUF1EccbswjTIJVZybkF9wNO8x7wQyUL8Lw3eJHrQ1/7lCToXOpcouA8+Nvp0J/cI+9zZe8LNriqay5O2mH9jfS1YEOfXrZ32Ayy52VvwgXroiyzGQ1uuYFiDWjH46JLQmh9YOsfPNIVXodmP2dwtH+COZk2XSLmbH0GiQZZqARdqBsnY/6ieaCg44tdQqSlUFeed4hKv60xz3Rwydr+W7ltJaoxhsgs1s9csA3Sdg+iCjJmspPkP+b/JzPRO6fyYuXjfjIGVLDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHRs7SgkJJGo9NXenf4Mkqj3eh7PeXg7U1GrJunKlvM=;
 b=LRtF+91Ir/ZXDAYKrqEF99hoYLTkuPBHmk1SxqNWU1PyXNmjT/VH95NVykr48ESyo1g9JKdVIlrFuZA8X2GsSlxCkIYZmC1ZE8fJ4VRJvNz0/GjhEoPc+NOFsAp6r0S0m2zof9C1uqclQZYhplvNU1yGhjRRvRUy9ZDsxFBJ+73rUEwLm3H3nHGf/xbBf3Wl6EJ/wQ8/TRqkYHrFYGrX+Nn3sGf3yonFyJPxbodQTH70QzOm+4dlivW5SMBWZdAq49BolfCJQ9PiEuHN2TL30qJII6k4IkG39EbIU8E75v/fV144+W5dP5+uaZBCrc68n11cVTtrpyAX0qmZWPwNSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHRs7SgkJJGo9NXenf4Mkqj3eh7PeXg7U1GrJunKlvM=;
 b=rOYjEc12eH8JVwU0bkFqyIZ/gJ7EpyBBbY2iRIbJjYNye7xk5buSuVdYJgMerS2+mTPlk33AndqAnVibeSLep9CDgbORHJjxMCjnQgQCOj/YM0dGFP1ckFnJvwyHSLpYi0rCwlFJZ662Ld39lzfurg2BQkyGVQPTxlNwVl0wnek=
Received: from BN0PR10CA0006.namprd10.prod.outlook.com (2603:10b6:408:143::32)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 13:32:35 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::21) by BN0PR10CA0006.outlook.office365.com
 (2603:10b6:408:143::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Fri, 22 Jul 2022 13:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 13:32:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 08:32:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 08:32:34 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Fri, 22 Jul 2022 08:32:25 -0500
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
Subject: [PATCH v2] ASoC: amd: acp: Initialize list to store acp_stream during pcm_open
Date:   Fri, 22 Jul 2022 19:05:22 +0530
Message-ID: <20220722133530.3314087-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8352e530-199a-411c-9f2e-08da6be6a391
X-MS-TrafficTypeDiagnostic: IA1PR12MB6628:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /v7K73ReRtHB1n9gTe5n8WeJlmxb21yPboqLuwLkflaiNh9dLEOddqeyNmqwsmcJJys4bQdg/T/1WQilUH8juf9zTRgjAJp9XIx6nWaZb7NlaJy+rAsYRBEGDXxY/zVdrcEZ5dcmvdgf9WTPqJxU10Stl1WrIamMeWwzOpc+l9Hy+gldSXBkiPLqLX4HgZOQGmq9gdBUHGCR32Cgf7GcYMYowkqK2DtrcQa3TpfW+h91hGFbjdgmxqsFSP4nBFC2ts4ozMXoAg3AQPn319OzutnaH+vZLbEJpX5gBBrsE6YhXZIjhr84fhgCGl3Xb97MDOlINvbi/XOKBO8hqiJmf6a9wsVw686b/FBSOXgmn3hScSzp7xpgmISiODl8OHVyAeTsHa029bSliQ2ExL1kUPi2pHxeTgl3LZKrBMeJAWkMwcKiVTmHq7EX6dgnlgE2tLjLrWcW5kN2U5oJflpGeS1XguAyHMOGMEyO+SluriPI8JHiAPryLTsu3xdapgxcCeY1N1wi6WPui0IvoBx6/1HjrRGbJi4W6sXc6odKNp8k2H5fCJQMrFOJeMpSQoChXP+qfLXnCmfhiZMK+eWKJLhuXvkC18Us0edDccxDUfqnXlzQYk+surjN3JU2fjOSX5/mpybiWMD0lb55UQlsVmXva0vQ7XD2siemGK7RqMgUxjoX3gCUstpIF3f/9vCW1PysckEPt8mmuvy8OghI/Vty+5TmyICVvIqjUtG8hW4Ow+9XO/vq2bGb7PWZH3ce6WNMtwaWzA/izBkkWQ7SQwCam5etKmld7kWqLK17mRJcQu+PRprDfDQfjY7/bUM2hc3Zk4G+SKbQ/n9hJBxeqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(39860400002)(36840700001)(40470700004)(46966006)(7696005)(82310400005)(2906002)(6666004)(41300700001)(83380400001)(2616005)(40480700001)(336012)(47076005)(426003)(186003)(1076003)(36860700001)(26005)(86362001)(4326008)(70586007)(8676002)(70206006)(36756003)(54906003)(40460700003)(110136005)(316002)(5660300002)(8936002)(82740400003)(356005)(478600001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 13:32:35.6445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8352e530-199a-411c-9f2e-08da6be6a391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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

Changes since v1:
    -- Fix compile error and remove unused variable.

 sound/soc/amd/acp/acp-platform.c | 33 ++++++++++++--------------------
 sound/soc/amd/acp/amd.h          |  3 ++-
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index 10730d33c3b0..20c0f75f7c97 100644
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
@@ -104,8 +104,7 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
 
 	ext_intr_stat = readl(ACP_EXTERNAL_INTR_STAT(adata, rsrc->irqp_used));
 
-	for (i = 0; i < ACP_MAX_STREAM; i++) {
-		stream = adata->stream[i];
+	list_for_each_entry(stream, &adata->stream_list, list) {
 		if (stream && (ext_intr_stat & stream->irq_bit)) {
 			writel(stream->irq_bit,
 			       ACP_EXTERNAL_INTR_STAT(adata, rsrc->irqp_used));
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
@@ -188,7 +183,8 @@ static int acp_dma_open(struct snd_soc_component *component, struct snd_pcm_subs
 		return -ENOMEM;
 
 	stream->substream = substream;
-	adata->stream[stream_id] = stream;
+
+	list_add_tail(&stream->list, &adata->stream_list);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		runtime->hw = acp_pcm_hardware_playback;
@@ -212,16 +208,13 @@ static int acp_dma_hw_params(struct snd_soc_component *component,
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
@@ -261,16 +254,11 @@ static int acp_dma_new(struct snd_soc_component *component,
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
@@ -305,6 +293,9 @@ int acp_platform_register(struct device *dev)
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

