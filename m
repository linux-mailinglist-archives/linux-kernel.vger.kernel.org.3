Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356BB48DB6E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiAMQOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:14:05 -0500
Received: from mail-eopbgr20074.outbound.protection.outlook.com ([40.107.2.74]:1287
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229483AbiAMQOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:14:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNY3Gs3jKBLrxUWZU40EAgSnZxhs6Ox3+BbZQD/GPAPpC8vaC8xDNFTN9syLuZXSS1vHR/cjOBiGC92PbNeXU37Ci+N92Qn+s45uWvVBHsUrbHyWuED21Eht5UHNPd5G/J6ER8i/mdP0u7nNI3qPN1uEW68GaVTuAQIz47sYNuUUtn30cbo+s0s4ilKY/V2nll08vtNBxuzJffO/wOCkkQiYpr2TQX8FTbuigE8POxAu2n6cW2JNox1Ef3BdKKSl6TqAKcl9987E6S7Aj+t2us1eB/TDEqDyAQco5pXlC7gnmAnI7M75JhFLcKtWVfs+2mXcdhSk6JUu7buhfs9EQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCBVL+J+uTXE9MseF/pV3QbT9OHKFD/SKLEGfeEyjbk=;
 b=LDU2myeuW0P7PTNcfD6vHevbBuUHBR4l6vr97OCiBrLP2RKZfKvHAVj8dAYe1tM5MB/vv2nkCkdnru/69JCsyr1dV/38Vp9sPgnkAotT8TfQJCjduUZpiX1Kc9wMem/Dnt69o4phWmFhQNLOYymLYcYHOz0xuabTaPF/Q1FxEHH0VHUeWqvujXggEils0ipY91Jh+T14u6yNCehnicGee+XsV3OyzqisRnBnErtZDX6raIqkO2Sp8oqnyDxPxNN2qbrZMwEIx54WwWumJtGF/hxOlvQnhka0rdoVSrF9JmjI8SZdL/ay6LNJzaVDvFEd4LJvHvp4BibM2nMVwDQTzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCBVL+J+uTXE9MseF/pV3QbT9OHKFD/SKLEGfeEyjbk=;
 b=W6qxx00kcEUOxVO2Y03bdVRWkL6u/upRBJm5ylyD/bZ3OyniWS8oyDCHGZOKTdelmHzRnXbfmOKxYt9UAbCM9XruA+BvXBl7OUomXmlWwpOxwpw8A/p86Gpw3eAJTiiECfhRtzP62KNh7wASz9Jn3eMMLct7TotwcmcrOR+We+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by VI1PR04MB4830.eurprd04.prod.outlook.com (2603:10a6:803:62::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 16:13:58 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::3de6:806c:e71:2a2f]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::3de6:806c:e71:2a2f%5]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 16:13:58 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: compr: Add compress ops implementation
Date:   Thu, 13 Jan 2022 18:13:41 +0200
Message-Id: <20220113161341.371345-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0024.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::29) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e59a5ef7-b627-4bf1-305f-08d9d6afb407
X-MS-TrafficTypeDiagnostic: VI1PR04MB4830:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4830C9EEB9941CA6AEDC31D9B8539@VI1PR04MB4830.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcDgUOYbbn3jVm5XW5ibUgEZO8x6ywFxYnk97MR8s9WVTEuMIWjtk+wZPbnDL9PwMvNfgkXU3cVsxcQD8yCXLTyY6zvuLR4ctJeQxPMNBHIIe3bpJ9mHuyi/RmBZI7xZicw7t/g7JPMhvHA5w+vFV5iPV5/ay+ks3CUwZCc2xlPDGoswUILuoieoZWB6TJ8MaKLUy0ij8Ry2jS1DAQ3DBPDeLqUQFEiJA54D2LRCJfq5IOgAJWpTgGI0lFQu+BTujZRqgU3iAm8GS7R3xXPu2ppDd+9RO+H02I7Lth1jH4IqlMZktXO20fakwa0WILoCKJZQ/Cn2hnTfCvuzvOnY+bNMHOZl0XDseehM9g1LZaaecbJYmStXGfkSbwqxwoJJ4kmeYy2szqL3w5B6eOfAGg58Jd8WkDo+JRQ5Q66nwvILRwbfTg/3cYfZhskUZg0GYi3DCHAu+WwtIEmxetnTPdcSYKHHM7kfk4G7GhS0uel0Vx0WpEaz9dubil+5dxmb7xvn8Q3zsd0h8UmhL38v8nYNFh+9yOsyxDyqhEchwMGAuIXezZ8zSolApysEsMG/fypj86KWFp5ndLB/BD2fHj4tm1Tpl6dOL+Fj8r/eHqD/TBeoiVpdX5eMw9WIcMzjwJ3fRWpzD6VJieE3AF9HOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(186003)(52116002)(6506007)(66946007)(44832011)(4326008)(66556008)(1076003)(86362001)(6512007)(5660300002)(66476007)(316002)(8936002)(508600001)(2616005)(6486002)(2906002)(8676002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hDamaOdpY/XL2LlbRFTwJK+PR7vRTiYdNVGhM1qziosTHZvGRPqMPSLPCrbx?=
 =?us-ascii?Q?+YNmjybXrWf3oHSIoRm7aT5bvbD1A/NYEc/baHiaR3awodfyVYLZDLbVZ3Mx?=
 =?us-ascii?Q?6BxRcyctW5JdCpYS5iZSrYRM/Z8SDq4Q86106el1vC8Tq1DosGaK/T16KmB1?=
 =?us-ascii?Q?HAwlauXS2esr85udrSZJ3t2t4OTGdxR7Z11rHGwsvdSi2uytoxoByRi3JOlr?=
 =?us-ascii?Q?XeoFEIn5+Ap/8zqUxWuaratNE2gpv0Ugj6LfsvezpeA4/OyMTFndw/jjodci?=
 =?us-ascii?Q?iz3YrxZ2B58zvxt1MDPzoYvnm1qEteriFFO9Tqjr556DZ97eKoaFa4Fm7tN9?=
 =?us-ascii?Q?MAV0lLPVyeeYUSMoKe2f/IaP9HzWXXPBnWfzLK6Rjcjr3A8WYhXrVqRbxfJQ?=
 =?us-ascii?Q?3Qg6TkvB7BlcnIXccfpqtdQ3TN20zun4I4RXC3oFYXtylsmC5dH0O/SHahdT?=
 =?us-ascii?Q?omD6Ue/j38J3YBoIcbN9N0L8F196y8QvXOGPYxWKpmIaqCWIW6ZCtNDSCe0r?=
 =?us-ascii?Q?1ZhRZrvlwg19n6Pcn96oKufJHaEQyFOqeXBNtzz+HAb6h3ivnrJLuaUqSSsk?=
 =?us-ascii?Q?ji6ghiBNLnlpiBmGEGyAyhG0fMWcyOkoUbfy+1AKObtPtlxCghxAlY3tJ8ec?=
 =?us-ascii?Q?M+fm4ajBlXnHOJfLjXW/Nf1qLw07lnDQlXgmIN3RPRXQk5za6hlb/sWFmZl7?=
 =?us-ascii?Q?OVMkpm3/DSZyOyBFbhb29uDoqLN/ZOg7G+Dhf3GLJ10YUcVOPDIqxzycaEut?=
 =?us-ascii?Q?HkRvoAnOAYCF9sIn93Vq6E2/WxKyUbHByjv3ThT42QLnsD4ap9ci398/sfZM?=
 =?us-ascii?Q?TbTeBxzS1MzEBrvVm5AUIQra3qaKDUmi5oN1YFRhK7wkiDSKC96tgdE2fJZ0?=
 =?us-ascii?Q?qWODk8/8hyTY0Y3/1Leo02SxNRcMZZ5Zcv3ZEkRs04kXNTAB9pDfUH4b3BMa?=
 =?us-ascii?Q?64wDB2bZNhwllWD7FDdEVTO5ew+4sgR8i9fPsnVaBxYrLZmE8D0cEzSUHhrj?=
 =?us-ascii?Q?TjoGEw/pt6eOKN2aUTc6pDY4ttXIJcSrDufh/3uRtTuF22WIhRnFKzfuPhAK?=
 =?us-ascii?Q?r9Ik0BBuuEOyyz+jnsEBhdN6jxeJ4u/vBOxgPbyM3LNufITNqibvMfUlWFCs?=
 =?us-ascii?Q?JTxEFxcidSytiGYabve0Efmk9xfadaDqR3vJoSVFbZnk0HaBMjXDhG/hHHML?=
 =?us-ascii?Q?9Iz1/OfJmhW4GBsS13pU5kfqNzE5Y+iFwk3My9ok4nWuCoytMn5hIMnaW4pd?=
 =?us-ascii?Q?vWcFlmw15yb4EtcizG1wUBRYeyvHqgAed7OxlH1NNIVyWdtCEFUOwNsAG82C?=
 =?us-ascii?Q?ayBJLtuSXuGhKR21Zv+SE9MeecEaTG8SLz5NlQIwEsvBNE9GAploRhZf1zKq?=
 =?us-ascii?Q?YiD6vBhKX10Bkd/25JWoPTaXY3RyPmZN9PUTVQuveo6fVAzVod4q7xk1jPgX?=
 =?us-ascii?Q?xJLPqmC05fmUKvhHIwpz5BCJ6wpt5W5oMPueZMXTwsQE5BUA4MW8P7RcLZDM?=
 =?us-ascii?Q?/r0nNCGos84KCIpwl4hGks2AhheZVDs3VPsyTaJRzlIXmKDaHbS0QZaZAcTc?=
 =?us-ascii?Q?zmQnYKG4a9ObLVGk3vWT88VqYyiI0zAkO17+DCnRQxvVkErEJ1GIILCWoRTQ?=
 =?us-ascii?Q?A2zH5Jum+JhrC0lEPAUQpRFUxhSl1UDNz8DQSmx+gxGN1rssI0fPj+Nz+H43?=
 =?us-ascii?Q?LUMeTLijlGsr297I5jw1jOOUd0k=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59a5ef7-b627-4bf1-305f-08d9d6afb407
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 16:13:58.3713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZA9GhwxUqlI/LkQYfIrVtoUVm8CAXaflDMCm/M3Om+nRWCrB98ZUjDHUv1PPLWSwxwUXwMsDzU2QgH0I72bslQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4830
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
 sound/soc/sof/compress.c | 270 ++++++++++++++++++++++++++++++++++++++-
 sound/soc/sof/sof-priv.h |   6 +
 2 files changed, 271 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 01ca85f0b87f..2db1517d906d 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -10,6 +10,22 @@
 #include "sof-audio.h"
 #include "sof-priv.h"
 
+static void sof_set_transferred_bytes(struct sof_compr_stream *sstream,
+				      u64 host_pos, u64 buffer_size)
+{
+	u64 prev_pos;
+	unsigned int copied;
+
+	div64_u64_rem(sstream->copied_total, buffer_size, &prev_pos);
+
+	if (host_pos < prev_pos)
+		copied = (buffer_size - prev_pos) + host_pos;
+	else
+		copied = host_pos - prev_pos;
+
+	sstream->copied_total += copied;
+}
+
 static void snd_sof_compr_fragment_elapsed_work(struct work_struct *work)
 {
 	struct snd_sof_pcm_stream *sps =
@@ -29,16 +45,16 @@ void snd_sof_compr_init_elapsed_work(struct work_struct *work)
  */
 void snd_sof_compr_fragment_elapsed(struct snd_compr_stream *cstream)
 {
-	struct snd_soc_component *component;
-	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_compr_runtime *runtime = cstream->runtime;
+	struct sof_compr_stream *sstream = runtime->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, SOF_AUDIO_PCM_DRV_NAME);
 	struct snd_sof_pcm *spcm;
 
 	if (!cstream)
 		return;
 
-	rtd = cstream->private_data;
-	component = snd_soc_rtdcom_lookup(rtd, SOF_AUDIO_PCM_DRV_NAME);
-
 	spcm = snd_sof_find_spcm_dai(component, rtd);
 	if (!spcm) {
 		dev_err(component->dev,
@@ -46,6 +62,250 @@ void snd_sof_compr_fragment_elapsed(struct snd_compr_stream *cstream)
 		return;
 	}
 
+	sof_set_transferred_bytes(sstream, spcm->stream[cstream->direction].posn.host_posn,
+				  runtime->buffer_size);
+
 	/* use the same workqueue-based solution as for PCM, cf. snd_sof_pcm_elapsed */
 	schedule_work(&spcm->stream[cstream->direction].period_elapsed_work);
 }
+
+static int create_page_table(struct snd_soc_component *component,
+			     struct snd_compr_stream *cstream,
+			     unsigned char *dma_area, size_t size)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_dma_buffer *dmab = cstream->runtime->dma_buffer_p;
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
+	struct snd_compr_runtime *runtime = cstream->runtime;
+	struct sof_compr_stream *sstream;
+	struct snd_sof_pcm *spcm;
+	int dir;
+
+	sstream = kzalloc(sizeof(*sstream), GFP_KERNEL);
+	if (!sstream)
+		return -ENOMEM;
+
+	spcm = snd_sof_find_spcm_dai(component, rtd);
+	if (!spcm) {
+		kfree(sstream);
+		return -EINVAL;
+	}
+
+	dir = cstream->direction;
+
+	if (spcm->stream[dir].cstream) {
+		kfree(sstream);
+		return -EBUSY;
+	}
+
+	spcm->stream[dir].cstream = cstream;
+	spcm->stream[dir].posn.host_posn = 0;
+	spcm->stream[dir].posn.dai_posn = 0;
+	spcm->prepared[dir] = false;
+
+	runtime->private_data = sstream;
+
+	return 0;
+}
+
+int sof_compr_free(struct snd_soc_component *component,
+		   struct snd_compr_stream *cstream)
+{
+	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_compr_runtime *runtime = cstream->runtime;
+	struct sof_compr_stream *sstream = runtime->private_data;
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
+	kfree(sstream);
+
+	return ret;
+}
+
+int sof_compr_set_params(struct snd_soc_component *component,
+			 struct snd_compr_stream *cstream, struct snd_compr_params *params)
+{
+	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
+	struct snd_soc_pcm_runtime *rtd_pcm = cstream->private_data;
+	struct snd_compr_runtime *rtd = cstream->runtime;
+	struct sof_compr_stream *sstream = rtd->private_data;
+	struct sof_ipc_pcm_params_reply ipc_params_reply;
+	struct sof_ipc_pcm_params pcm;
+	struct snd_sof_pcm *spcm;
+	int ret;
+
+	spcm = snd_sof_find_spcm_dai(component, rtd_pcm);
+	if (!spcm)
+		return -EINVAL;
+
+	cstream->dma_buffer.dev.type = SNDRV_DMA_TYPE_DEV_SG;
+	cstream->dma_buffer.dev.dev = sdev->dev;
+	ret = snd_compr_malloc_pages(cstream, rtd->buffer_size);
+	if (ret < 0)
+		return ret;
+
+	create_page_table(component, cstream, rtd->dma_area, rtd->dma_bytes);
+
+	memset(&pcm, 0, sizeof(pcm));
+
+	pcm.params.buffer.pages = PFN_UP(rtd->dma_bytes);
+	pcm.hdr.size = sizeof(pcm);
+	pcm.hdr.cmd = SOF_IPC_GLB_STREAM_MSG | SOF_IPC_STREAM_PCM_PARAMS;
+
+	pcm.comp_id = spcm->stream[cstream->direction].comp_id;
+	pcm.params.hdr.size = sizeof(pcm.params);
+	pcm.params.buffer.phy_addr = spcm->stream[cstream->direction].page_table.addr;
+	pcm.params.buffer.size = rtd->dma_bytes;
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
+	sstream->posn_offset = sdev->stream_box.offset + ipc_params_reply.posn_offset;
+	sstream->sample_rate = params->codec.sample_rate;
+	spcm->prepared[cstream->direction] = true;
+
+	return 0;
+}
+
+int sof_compr_get_params(struct snd_soc_component *component,
+			 struct snd_compr_stream *cstream, struct snd_codec *params)
+{
+	return 0;
+}
+
+int sof_compr_trigger(struct snd_soc_component *component,
+		      struct snd_compr_stream *cstream, int cmd)
+{
+	struct sof_ipc_stream stream;
+	struct sof_ipc_reply reply;
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
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
+	struct snd_compr_runtime *runtime = cstream->runtime;
+	struct sof_compr_stream *sstream = runtime->private_data;
+
+	tstamp->sampling_rate = sstream->sample_rate;
+	tstamp->copied_total = sstream->copied_total;
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
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 087935192ce8..d001a762a866 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -108,6 +108,12 @@ enum sof_debugfs_access_type {
 	SOF_DEBUGFS_ACCESS_D0_ONLY,
 };
 
+struct sof_compr_stream {
+	unsigned int copied_total;
+	unsigned int sample_rate;
+	size_t posn_offset;
+};
+
 struct snd_sof_dev;
 struct snd_sof_ipc_msg;
 struct snd_sof_ipc;
-- 
2.27.0

