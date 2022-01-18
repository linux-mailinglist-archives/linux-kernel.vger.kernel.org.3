Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF860492FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343960AbiARV2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:28:38 -0500
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:48165
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343557AbiARV2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:28:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBJrwtq4ruasYMfeUuOUuNQwGUKwp02NgOSyqhG7ZHK2DGEIGdrkWAJfPFLcMZIlUIaoyASIZqT0mYpV8HJKyRErMyif3seqUuFogwlcO3zUEQNP8OQPADEv+PpKUxPmBSVY23lcmtWwUKN2hMn8vsXzcM31d6wzFC9V9qPwV+ZiDFkhH3AJhrLra+F0cM2hOTGDU8pW8AmPUTNgSGwEKtiY4a8JQR8wXrt2GHG8LAHNC4wzYOw4B5EWXFCrA0gemg2WXyJHrpshfpeflJyWQlhNkC+jeZcHcOCGbERWpiwqG9DrJRpEbQBoq4GgbBja+tnRe2SAglq72zeaeduFWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rioav/ch3hMYZTdHtzzxbAev/OjzxhpqSawCcMRmwp4=;
 b=L9oaejW8529PcwXjmVn7x/MJoQu1Dj0BLGzuloLsSZE+Kc+cepp6xeHzgn2VzGu2DH5Fu3MKhvQg5zWwJ3+pCNaLs5tWYnEEmN6o34GPST+ovIPu7bIBCmVKkHLIzD8C4LeuyJYkyb2/PDH2YYGVzBw0A49TKWmnSsYMpQc+XChWlgTY+5wVdS/+ovFjcOW4XZPpsraSTF7kWb64CkUCYCzZLj5I9tkATLMT6zyJkXrZyJnPGe/o3IIjQOPmsxdxZXD1Q7JGjwInNeZxfEHpowtfxlpvGVfZ9oq3ZugRS5JHgH44pJiuWt29A+S/5VUfuKwQaXR8S24PtYrsIFxqBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rioav/ch3hMYZTdHtzzxbAev/OjzxhpqSawCcMRmwp4=;
 b=ELg2QmjtzLWYfeij9S4Vp4YD/DCeHqcK9tTw8QNk0FlQQAH0Csu2yQXbJF7Y3yDw5z9Itb78D3+cEOGGWGowXYv6xSpSLu+mYlljT0UEXs5r6vWOFZddWJ90bo3WhcbHBadvtIgz86P2TuQHb96CM0hYe7o0DLX+V+E/n6cJQEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by PAXPR04MB8207.eurprd04.prod.outlook.com (2603:10a6:102:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 21:28:33 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::3de6:806c:e71:2a2f]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::3de6:806c:e71:2a2f%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 21:28:32 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
        ranjani.sridharan@linux.intel.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
        paul.olaru@nxp.com
Subject: [PATCH v2 1/2] ASoC: SOF: compr: Add compress ops implementation
Date:   Tue, 18 Jan 2022 23:27:31 +0200
Message-Id: <20220118212732.281657-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220118212732.281657-1-daniel.baluta@oss.nxp.com>
References: <20220118212732.281657-1-daniel.baluta@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR03CA0063.eurprd03.prod.outlook.com
 (2603:10a6:207:5::21) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72d66f26-6791-4a49-9fa1-08d9dac97a47
X-MS-TrafficTypeDiagnostic: PAXPR04MB8207:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB82071027F3700060AFC68A60B8589@PAXPR04MB8207.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d91nkhQQBTESgtZNYjIyLsPn+Jy/dQMK4SDG3PerG3rj2a0gP6PE116i8NfRqDuNVz7WJY/Lgy8FJYkLjFWL2pNZKLDhnA0SZZ+cH+aw67Y+EmTDnYfDRxQ5sfTqTtTBO7uozE+cSADx4H5MQSsLOCVC/obBMklkYr6wLkXWjYMw4NbqQRQagDlJUTOVs53vCE3yj9TX6l+dkFtgpVJVva02BlIX8IyxSkKpU/r2n2+k2XkESP4CU1R7TSWuQfC9XUE/zatAQMaaRGu6CJLMQOvlzb+0LLX22AbhgMXIEAQGwYzsxv0bZtdUsOk/NinYpj3BeLBeNQD421MfZh+N5T5YLnxKek8/8MPU8WKAIhGgcdmeRGb6y7v0Xys7atSuzLmUvwPlPIMTs9tjZYh8AzGtNjFh7SPdsUpeDCS+OcKrKts6vowya7xCfWi/RKIo6MMilycc+plQxHnxBn4BzLjNyGfCvectzrv9r84criancKeSPEwbA3Js6KSZ0hqbG7vq4i16Nybx9h86Luze+Tbl/OFOQw+8c8sF4Z5s2cP3Bl3YQ3YHYvUk0ot6qYXlWFnzDDnTK0khco2RbChAx9Yk7hJbncxpR0pP7UUTmvhBTrEVx3cwVD31YSofKJd3V5RRuHgg26C0F1rhChEACw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(38100700002)(5660300002)(86362001)(8936002)(508600001)(6506007)(66946007)(1076003)(2616005)(6512007)(66476007)(316002)(6486002)(186003)(44832011)(66556008)(2906002)(4326008)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VjtVarO/2FqZ/E3KxNosLpupIp54RKa9Ey/vXjS3gna6xp/eF/dFj63cb7BE?=
 =?us-ascii?Q?bYQ0SiY1VgMGPygCwMx80rIx/fm545bBSOaD4YK/iolOJlInMisKv5n1+Q+q?=
 =?us-ascii?Q?tHQGfeaiSbujHL6dWg6NIwePHNxZWIPGbKBMsvKjxxur+VD9upHKCwrzSL1V?=
 =?us-ascii?Q?K1FZAl5azRQuqNGDkfcO2JD9vKJWbv3Vf8Aoa7JXj+ODpEu/R6Gu5BGSEDfw?=
 =?us-ascii?Q?O+I9DGzYjM8/r0m4gJMTGSeFbXT1Qe2M3EHVboh0Z8t8aR9cqslA43qg2Myc?=
 =?us-ascii?Q?3THuPldagAW5m7eY+4WvHnVMiFipu5eVijoVmA+iHuwT0u6sNJOMFD48ATLK?=
 =?us-ascii?Q?8K7BYtfmcnVsQSL2GjVQH4zdzcbJgMPZiJT27AzTDTM1x5tEJ/16JeUVmd/9?=
 =?us-ascii?Q?1iLvIjCppKvaA0Smx3a7kRiCgHLmbSAuMig7QA2TnsbtjnSVwX8SVejfD45V?=
 =?us-ascii?Q?155yK4hZ7bQdbfPfbdt/PAnKUybKvQlHsy6ddU06PimnXKb+R78cU4wAnp4P?=
 =?us-ascii?Q?NWaFhv6O1Co5gGoI/1ATAN1W+wLcN9DVLbsA3H+nU1AOPEvdn5yf5tFGAGlp?=
 =?us-ascii?Q?t+Rs9PtyWK2leK7l2rcdPQmPxVP5OFLJXpBkEbf9zbG8J61NruNQIyRs8rW1?=
 =?us-ascii?Q?YzGo/1dfeuPraYBIwypILPX376BsJ4+R9k5vh50EqRwtBKfxARBSypexKEZk?=
 =?us-ascii?Q?wysvGSJuANJNI0zX9xyLMaI3SQfRwok7BA0fol3gtPTcXvK/Dmnar9kmYIso?=
 =?us-ascii?Q?BYap6c6P0yHv2BsMbj5Lb6a8qxfAZ7U103KXwy1ILCRMy0dli+57MmrDK+TN?=
 =?us-ascii?Q?T2utUBOsVAnIYe9Yjy4l8TJNVFn1bET3S2swsS22HquncYeNvKNj1zjs84OH?=
 =?us-ascii?Q?cCTOLL9HYiO0iN2Ay9eZfcRUOfjEuamZpQ8Ufjh7UOb9V4ydTU9HDrFWQyxe?=
 =?us-ascii?Q?qEzTW+lmmgpTreXT0ldBktZT2GthX8oc3lx3/XTo3/fiQSqWe35KNnYAGASR?=
 =?us-ascii?Q?aWwnu/yE2bDEl4xEk9RIrh0Zk+FbbDProT0KdwjuP9Nu9NNXm7sR/CCCMCyh?=
 =?us-ascii?Q?zMYgQeZkBXcht2VESKcrEOgqqbTNcCYG52p1iU4iuH8gTrFx4J2lVzUMZj/c?=
 =?us-ascii?Q?HOW7uQxmlQXwhAHmFjYcPGjmPBtC4pjdCc2HqDIyzmJSgWtrwg6cQARY+Omc?=
 =?us-ascii?Q?2h5FhUHLOncWORHWKtK7T8goSNDcDR40Eqx5qmnRHwSJ0wbbr0YHVD/0oXrV?=
 =?us-ascii?Q?muXDzzInge395mcLzhn3i4zQkVvs4Kg2+c0i1Tj9ZKcfo0SQb4v8FrdmaGPv?=
 =?us-ascii?Q?gfg8y8az4mYWENlWfYIl6jkUrwX/WnXjWQxtoGSGQWU5cgh1r32IUQRFZkK6?=
 =?us-ascii?Q?frZEfCZWI/6KU2IRSvX+jp7F7oHelGM/ZSbwqnDnslJ5MSnKY9uarSGMJdz4?=
 =?us-ascii?Q?eMv/J1gHctPaLuuMmKM4wE1iUDGWvkHhB+GoAoCUYUy+3sDnnN5ais9w0gxx?=
 =?us-ascii?Q?0aE6YpomxngTULMzxTjVu/6L4pjz320OFAIzi2baARgQnOW3n9Jd3KOncWtt?=
 =?us-ascii?Q?SQ1rIhMSBt5giGH5zOKfXZSV43XsyUqAclNIjopBOnXIMqaECTwST7Apfl+r?=
 =?us-ascii?Q?jSn8ragp5xiLUFRxII5lM9QuiT9hnr1FFvMMMvUz7S7oISz4SebcjQNwrh0J?=
 =?us-ascii?Q?/AvndDws7/BInNoYIU9Wg6kXq0w=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d66f26-6791-4a49-9fa1-08d9dac97a47
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 21:28:32.7260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AFxusAiesp+LtZp3mmBo67Hq/RqPOWHcFYNKlFpwycy5fslvpGqtdaU7T3MweypPIhwSdRcR0UojIKFmx33Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8207
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

Implement snd_compress_ops. There are a lot of similarities with
PCM implementation.

For now we use sof_ipc_pcm_params to transfer compress parameters to SOF
firmware.

This will be changed in the future once we either add new compress
parameters to SOF or enhance existing sof_ipc_pcm_params structure
to support all native compress params.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/compress.c | 273 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 271 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 01ca85f0b87f..91a9c95929cd 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -10,6 +10,22 @@
 #include "sof-audio.h"
 #include "sof-priv.h"
 
+static void sof_set_transferred_bytes(struct snd_compr_tstamp *tstamp,
+				      u64 host_pos, u64 buffer_size)
+{
+	u64 prev_pos;
+	unsigned int copied;
+
+	div64_u64_rem(tstamp->copied_total, buffer_size, &prev_pos);
+
+	if (host_pos < prev_pos)
+		copied = (buffer_size - prev_pos) + host_pos;
+	else
+		copied = host_pos - prev_pos;
+
+	tstamp->copied_total += copied;
+}
+
 static void snd_sof_compr_fragment_elapsed_work(struct work_struct *work)
 {
 	struct snd_sof_pcm_stream *sps =
@@ -29,14 +45,16 @@ void snd_sof_compr_init_elapsed_work(struct work_struct *work)
  */
 void snd_sof_compr_fragment_elapsed(struct snd_compr_stream *cstream)
 {
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_compr_runtime *crtd = cstream->runtime;
 	struct snd_soc_component *component;
-	struct snd_soc_pcm_runtime *rtd;
+	struct snd_compr_tstamp *tstamp;
 	struct snd_sof_pcm *spcm;
 
 	if (!cstream)
 		return;
 
-	rtd = cstream->private_data;
+	tstamp = crtd->private_data;
 	component = snd_soc_rtdcom_lookup(rtd, SOF_AUDIO_PCM_DRV_NAME);
 
 	spcm = snd_sof_find_spcm_dai(component, rtd);
@@ -46,6 +64,257 @@ void snd_sof_compr_fragment_elapsed(struct snd_compr_stream *cstream)
 		return;
 	}
 
+	sof_set_transferred_bytes(tstamp, spcm->stream[cstream->direction].posn.host_posn,
+				  crtd->buffer_size);
+
 	/* use the same workqueue-based solution as for PCM, cf. snd_sof_pcm_elapsed */
 	schedule_work(&spcm->stream[cstream->direction].period_elapsed_work);
 }
+
+static int create_page_table(struct snd_soc_component *component,
+			     struct snd_compr_stream *cstream,
+			     unsigned char *dma_area, size_t size)
+{
+	struct snd_dma_buffer *dmab = cstream->runtime->dma_buffer_p;
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	int dir = cstream->direction;
+	struct snd_sof_pcm *spcm;
+
+	spcm = snd_sof_find_spcm_dai(component, rtd);
+	if (!spcm)
+		return -EINVAL;
+
+	return snd_sof_create_page_table(component->dev, dmab,
+					 spcm->stream[dir].page_table.area, size);
+}
+
+int sof_compr_open(struct snd_soc_component *component,
+		   struct snd_compr_stream *cstream)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_compr_runtime *crtd = cstream->runtime;
+	struct snd_compr_tstamp *tstamp;
+	struct snd_sof_pcm *spcm;
+	int dir;
+
+	tstamp = kzalloc(sizeof(*tstamp), GFP_KERNEL);
+	if (!tstamp)
+		return -ENOMEM;
+
+	spcm = snd_sof_find_spcm_dai(component, rtd);
+	if (!spcm) {
+		kfree(tstamp);
+		return -EINVAL;
+	}
+
+	dir = cstream->direction;
+
+	if (spcm->stream[dir].cstream) {
+		kfree(tstamp);
+		return -EBUSY;
+	}
+
+	spcm->stream[dir].cstream = cstream;
+	spcm->stream[dir].posn.host_posn = 0;
+	spcm->stream[dir].posn.dai_posn = 0;
+	spcm->prepared[dir] = false;
+
+	crtd->private_data = tstamp;
+
+	return 0;
+}
+
+int sof_compr_free(struct snd_soc_component *component,
+		   struct snd_compr_stream *cstream)
+{
+	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
+	struct snd_compr_tstamp *tstamp = cstream->runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct sof_ipc_stream stream;
+	struct sof_ipc_reply reply;
+	struct snd_sof_pcm *spcm;
+	int ret = 0;
+
+	spcm = snd_sof_find_spcm_dai(component, rtd);
+	if (!spcm)
+		return -EINVAL;
+
+	stream.hdr.size = sizeof(stream);
+	stream.hdr.cmd = SOF_IPC_GLB_STREAM_MSG | SOF_IPC_STREAM_PCM_FREE;
+	stream.comp_id = spcm->stream[cstream->direction].comp_id;
+
+	if (spcm->prepared[cstream->direction]) {
+		ret = sof_ipc_tx_message(sdev->ipc, stream.hdr.cmd,
+					 &stream, sizeof(stream),
+					 &reply, sizeof(reply));
+		if (!ret)
+			spcm->prepared[cstream->direction] = false;
+	}
+
+	cancel_work_sync(&spcm->stream[cstream->direction].period_elapsed_work);
+	spcm->stream[cstream->direction].cstream = NULL;
+	kfree(tstamp);
+
+	return ret;
+}
+
+int sof_compr_set_params(struct snd_soc_component *component,
+			 struct snd_compr_stream *cstream, struct snd_compr_params *params)
+{
+	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_compr_runtime *crtd = cstream->runtime;
+	struct sof_ipc_pcm_params_reply ipc_params_reply;
+	struct snd_compr_tstamp *tstamp;
+	struct sof_ipc_pcm_params pcm;
+	struct snd_sof_pcm *spcm;
+	int ret;
+
+	tstamp = crtd->private_data;
+
+	spcm = snd_sof_find_spcm_dai(component, rtd);
+
+	if (!spcm)
+		return -EINVAL;
+
+	cstream->dma_buffer.dev.type = SNDRV_DMA_TYPE_DEV_SG;
+	cstream->dma_buffer.dev.dev = sdev->dev;
+	ret = snd_compr_malloc_pages(cstream, crtd->buffer_size);
+	if (ret < 0)
+		return ret;
+
+	ret = create_page_table(component, cstream, crtd->dma_area, crtd->dma_bytes);
+	if (ret < 0)
+		return ret;
+
+	memset(&pcm, 0, sizeof(pcm));
+
+	pcm.params.buffer.pages = PFN_UP(crtd->dma_bytes);
+	pcm.hdr.size = sizeof(pcm);
+	pcm.hdr.cmd = SOF_IPC_GLB_STREAM_MSG | SOF_IPC_STREAM_PCM_PARAMS;
+
+	pcm.comp_id = spcm->stream[cstream->direction].comp_id;
+	pcm.params.hdr.size = sizeof(pcm.params);
+	pcm.params.buffer.phy_addr = spcm->stream[cstream->direction].page_table.addr;
+	pcm.params.buffer.size = crtd->dma_bytes;
+	pcm.params.direction = cstream->direction;
+	pcm.params.channels = params->codec.ch_out;
+	pcm.params.rate = params->codec.sample_rate;
+	pcm.params.buffer_fmt = SOF_IPC_BUFFER_INTERLEAVED;
+	pcm.params.frame_fmt = SOF_IPC_FRAME_S32_LE;
+	pcm.params.sample_container_bytes =
+		snd_pcm_format_physical_width(SNDRV_PCM_FORMAT_S32) >> 3;
+	pcm.params.host_period_bytes = params->buffer.fragment_size;
+
+	ret = sof_ipc_tx_message(sdev->ipc, pcm.hdr.cmd, &pcm, sizeof(pcm),
+				 &ipc_params_reply, sizeof(ipc_params_reply));
+	if (ret < 0) {
+		dev_err(component->dev, "error ipc failed\n");
+		return ret;
+	}
+
+	tstamp->byte_offset = sdev->stream_box.offset + ipc_params_reply.posn_offset;
+	tstamp->sampling_rate = params->codec.sample_rate;
+
+	spcm->prepared[cstream->direction] = true;
+
+	return 0;
+}
+
+int sof_compr_get_params(struct snd_soc_component *component,
+			 struct snd_compr_stream *cstream, struct snd_codec *params)
+{
+	/* TODO: we don't query the supported codecs for now, if the
+	 * application asks for an unsupported codec the set_params() will fail.
+	 */
+	return 0;
+}
+
+int sof_compr_trigger(struct snd_soc_component *component,
+		      struct snd_compr_stream *cstream, int cmd)
+{
+	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct sof_ipc_stream stream;
+	struct sof_ipc_reply reply;
+	struct snd_sof_pcm *spcm;
+
+	spcm = snd_sof_find_spcm_dai(component, rtd);
+	if (!spcm)
+		return -EINVAL;
+
+	stream.hdr.size = sizeof(stream);
+	stream.hdr.cmd = SOF_IPC_GLB_STREAM_MSG;
+	stream.comp_id = spcm->stream[cstream->direction].comp_id;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		stream.hdr.cmd |= SOF_IPC_STREAM_TRIG_START;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		stream.hdr.cmd |= SOF_IPC_STREAM_TRIG_STOP;
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		stream.hdr.cmd |= SOF_IPC_STREAM_TRIG_PAUSE;
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		stream.hdr.cmd |= SOF_IPC_STREAM_TRIG_RELEASE;
+		break;
+	default:
+		dev_err(component->dev, "error: unhandled trigger cmd %d\n", cmd);
+		break;
+	}
+
+	return sof_ipc_tx_message(sdev->ipc, stream.hdr.cmd,
+				  &stream, sizeof(stream),
+				  &reply, sizeof(reply));
+}
+
+int sof_compr_copy(struct snd_soc_component *component,
+		   struct snd_compr_stream *cstream,
+		   char __user *buf, size_t count)
+{
+	struct snd_compr_runtime *rtd = cstream->runtime;
+	unsigned int offset, n;
+	void *ptr;
+	int ret;
+
+	if (count > rtd->buffer_size)
+		count = rtd->buffer_size;
+
+	div_u64_rem(rtd->total_bytes_available, rtd->buffer_size, &offset);
+	ptr = rtd->dma_area + offset;
+	n = rtd->buffer_size - offset;
+
+	if (count < n) {
+		ret = copy_from_user(ptr, buf, count);
+	} else {
+		ret = copy_from_user(ptr, buf, n);
+		ret += copy_from_user(rtd->dma_area, buf + n, count - n);
+	}
+
+	return count - ret;
+}
+
+static int sof_compr_pointer(struct snd_soc_component *component,
+			     struct snd_compr_stream *cstream,
+			     struct snd_compr_tstamp *tstamp)
+{
+	struct snd_compr_tstamp *pstamp = cstream->runtime->private_data;
+
+	tstamp->sampling_rate = pstamp->sampling_rate;
+	tstamp->copied_total = pstamp->copied_total;
+
+	return 0;
+}
+
+struct snd_compress_ops sof_compressed_ops = {
+	.open		= sof_compr_open,
+	.free		= sof_compr_free,
+	.set_params	= sof_compr_set_params,
+	.get_params	= sof_compr_get_params,
+	.trigger	= sof_compr_trigger,
+	.pointer	= sof_compr_pointer,
+	.copy		= sof_compr_copy,
+};
+EXPORT_SYMBOL(sof_compressed_ops);
-- 
2.27.0

