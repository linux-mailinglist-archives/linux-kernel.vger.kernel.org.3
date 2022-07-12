Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C9571C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiGLOQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiGLOQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:16:12 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30059.outbound.protection.outlook.com [40.107.3.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E0660538
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:16:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBl2bwnY+ryfqhDAPfrI+ryf5i091R9xXCk2lUeJPbl6fNG11nhc3f1GU6Jga2SfzAbqbGzqL8miA7GqcDd3wLbRxqKDDf4HJRsLoijQpZv7d5+Gmk5KVPeKzlP+2eSb1Rm1nlYxjoDWNuYXc0REi/RPYQ6vikUFUs0FVRDfBxcGZLKSoI2U73H/F4OKWIsT8Y13veerdgmO/9E6jbRpmRBKTaCACe3brjWfP0zOvPGKexVt5ZNHrbeHqpesf0lMExDTm6853QLfs+aTQGqxv8KvTrwpFmJbMO8v/0v44OkrHZ+FRf9iX/GPY4hv/XFVFlkadg3zw/0SmT9+lUsZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljJ8R4UZpSUlNFr6izu1KajiNuWYLjhJ5tqf1YnozFw=;
 b=a1vC5iQWxqPnYxsIBZYHVgZyXdSRIFCH06HhHnNU+fNxaNfvncRuN9UxcKXEyq9ZbvIRWIIye+EQChTRg8uEnsaiFodUhgROHoIxX9Px8xOuK7Nm4ue5rZ7wybWmAwmC8dANJKA+nafN02QzgJ5qV0tNamymil0VGWyh0p4ZxX9f7zaBmrB3txP3zqNKVA0iHzyJiQKGyAEQLJaYHGJZsqrKuUWDodsxsrzQ3ZnG2lQ4In1l/typcG9coCfANLS+Fo0jOzoJ5R7k8ddBolDuKAZxbHhAUKPNQ8cje+fzeFru2nLBpPQEtydHbp5XbBizB5uBha8fiUnOH7VMhJeSFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljJ8R4UZpSUlNFr6izu1KajiNuWYLjhJ5tqf1YnozFw=;
 b=cqSXTPKBqxt2DapFWiszVEhebhr8UlBM2ERT+FyywSV3D6tnajSH8nrMovOiTfKIUctWVHL7g0Eug5qTPS74OSCgASFb+5c0NHnbWDNIDIJXfkLw0B9RjLYyrlv5G6/Nfg1u6j+nZxkJcszSziZmUg+xFAU6nabttl8Aw6fVUNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5140.eurprd04.prod.outlook.com (2603:10a6:208:ca::21)
 by PA4PR04MB7885.eurprd04.prod.outlook.com (2603:10a6:102:ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 14:16:07 +0000
Received: from AM0PR04MB5140.eurprd04.prod.outlook.com
 ([fe80::15ba:4274:2df4:8928]) by AM0PR04MB5140.eurprd04.prod.outlook.com
 ([fe80::15ba:4274:2df4:8928%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 14:16:07 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     daniel.baluta@nxp.com, linux-imx@nxp.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        yc.hung@mediatek.com, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/4] ASoC: SOF: compress: Dynamically allocate pcm params struct
Date:   Tue, 12 Jul 2022 17:15:28 +0300
Message-Id: <20220712141531.14599-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220712141531.14599-1-daniel.baluta@oss.nxp.com>
References: <20220712141531.14599-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0141.eurprd07.prod.outlook.com
 (2603:10a6:207:8::27) To AM0PR04MB5140.eurprd04.prod.outlook.com
 (2603:10a6:208:ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a71e4c3f-90ba-4e78-63a8-08da6411102e
X-MS-TrafficTypeDiagnostic: PA4PR04MB7885:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/YEn98yQByB+DBkIBMnmdi1ukGRec4BnvAllyC0ya4BaszYv0CBn66Bp28mm3RkfzPl1KAEr9PgkI6KvvhpNoGRaayLYqVg3SF8WBI3HJ/yvqqAhMJpbgcH+pIZEl6nUM/Jee4p5X8tHbeKNC28FAZNWIDgerdjM/YDk+39dLHbumnStTErVZyuqM8VDjcgda4L1yeR+C9CILslOsvayaQFsDOA4owV2/GCcVUWzy3dO6WV/lVDqX1WeVrqWbd56yeFoftEOP87WX9GQv29eU6JzYn99HB6ya0srWESye2ugK9i/Pi/zxv04Z71IlUnKdCyEzCVv0n637zPshsuoCPn0mjkdgPeUp16D97hv/xUgHQKh8wGn1DkzN1FQQlv0OqDb8X4t3Z/ixI0+pmPopJDxZ+RYmXJZk9tWevtursLG5PidPwOZcOVuxK797ybh86xxjfCcCJWoXykyWKOvW2pU5oQxgMTOMMiyX6hY9agwRvtg7EgfEpZI/uhjtuYUBcbxrjJDYma0Es6g61X/RAA10RDl/mDLIIUCPIFb6a8mS7Dx3lgO6WVBBXyHEv8Jw1I0yhFN0DfunhPSSjzQfHDl1W3eTEm5xVIC92yVMZLloFhseRAlU+t/eXi6UPBmtzaETEbnjQIw5mkH+eJP9giZGLEezHwHfmM2ovw7YziV+nOhtXDITGbBXnTEwKDa8lQYbPh2Tm8bfyCyefIdiDJdbQyIpbtnOxqOMlzyaGgWUrjsRXk23UzdBHKDnIJHmSPK8Am9ucsp/2ra78OK+bVsZEMk2eHnONpQVbyrzvs/kj3nmL1ByKS6iRsvCy6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5140.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(316002)(38100700002)(478600001)(6486002)(8676002)(38350700002)(2616005)(66946007)(4326008)(186003)(66556008)(66476007)(66574015)(1076003)(26005)(6666004)(86362001)(6506007)(44832011)(41300700001)(5660300002)(8936002)(7416002)(6512007)(52116002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTFrUWpUak9xRXpqTnVzK3V6cWc1TGdUbHNEQ1FUVWpuR252T3RQNnVaOEtB?=
 =?utf-8?B?RXVmRGNWVTl6ckNBNncraEhkRVJ5UGgvZ3dHckJPVG9iL0hLN2kyMEJwd3lW?=
 =?utf-8?B?elRpREIrai9zaWhhNmhxZWoyRFRHMUsrc1E0WWZYN01QcUNod05SdENXV2hv?=
 =?utf-8?B?U1BZY0JPZUhKeUMxRHNxbXBlOEtjMjJZRGFucnJ0ckpaR08xd2lKVjR1QzNS?=
 =?utf-8?B?blhOczVXL1BEQ2tnQmJlSGg1djFJS2htNWFyRU9QYnFRTm11elFxcXBFTWdG?=
 =?utf-8?B?dm1MNWZ3NnBUWTExbUxhM0lLN0l0bTNUL1JoWVVqcFo1WUF3SGpMYW14SDFx?=
 =?utf-8?B?QTdhMGFPYnJBSUkxMXRrMTl0Sy9GcitCdXY3WmFXS01yQTdIUDZib2YxbHNn?=
 =?utf-8?B?cHc5eEcwMVoyL1I0b011UHJUQXliRHowWlMxT2ZhYlZzWU9QbVIySktmbW9q?=
 =?utf-8?B?dTIrZmNBS3RMWktHQXpKOU53Sk4ydkVObTFKNkZOb0pidkpsK2hHZC81Yndu?=
 =?utf-8?B?bi9oSUlyYXAvYzduSkFVTDNZZk9taXdGV1lMUmxLRTlTRjIzV1htSjdsdVFQ?=
 =?utf-8?B?WGN3aEFvbzlyYUVZS1NuRjY2TktpQUJNZ0craXVRaFcvRVdXWGJVUnRoMnZ6?=
 =?utf-8?B?eW93YkN2bkdsS2F5a0ZkbUVid3NxZ3M2dDNtdlgvb2g5dnVqVTNqamVPRDI3?=
 =?utf-8?B?OG5TS0tjT0RoVWovRFJDMUlXTmwyS0duSVZiUGhkKzVWS3VKL3lkNnpFRWd3?=
 =?utf-8?B?VFRFSWZ1R3hNSXRFdWluellHdHRLM1czT0tBOFBKUVVrUGpWZ09uNDRwd1Jw?=
 =?utf-8?B?aWMzV2liRysyUHZLd0Y0NXBSSFJmbWgwRE9LQnM4Zmp3Y3A0QzRockhuRklu?=
 =?utf-8?B?ejdUSWpPbno2bWJqVmsyS2NYaDNkN2pEQXRmNDVLY0o5NjdSd3UrU3lRUS9p?=
 =?utf-8?B?OGEwTmN3SnIyaUlsdHdOaUlYazh0SDJDT2J5RjJha1p5QUF0L3NpUXpJS05j?=
 =?utf-8?B?TTU3QjZHMGNHS0JBcmJmZVhwNFhrVDFZZ3EwVzhHRWltTmVPYmlKNnVRME12?=
 =?utf-8?B?b2I2azNRWGo0Mk42Q2QvbG9qVWRjeG1ncFdQaG5jb0pCWUtoQ25YcSs0TXRk?=
 =?utf-8?B?N05NKzV3anIxVlVOTHk2elFRZE5YZnNOd3hCTThYeEJCUXJmdUxkVVgvWW9M?=
 =?utf-8?B?QmlYb3VwUGNpUFlDYjNnT1dyaldncUhvNGNSbzlyY0ovTElOaWljNWxPV2x3?=
 =?utf-8?B?OFlXbkFMSGFwUE5pc2FCazdXdXVKVVlsL0tZaG1jV1Q2Rm1iRHQ0RGVkSjNw?=
 =?utf-8?B?TWJmRDZDd2tNTkx4TlIrZjR5cVd6N3JZT0hCQ3JmSTZkL1RkNzk0N2N6QnZr?=
 =?utf-8?B?TXVBU3lrTjcwWDF6WE9jd1hsQnE1czBENUlBVU9IcFlxVjAxbXZ0M1g5d3R6?=
 =?utf-8?B?emdCeVV2em1OYkM1SVkvbk45ZWs0aWwzSTZ1SzhlazQzSHFUWDZnREVBYllK?=
 =?utf-8?B?ZGNabGRBMVNVRzdLZDBVZVN3aGtkc2IzUWZEV1cxSGFucnhiRFc5N01RYzRn?=
 =?utf-8?B?WjhsVDgyakdqbk9PKy9QV3NRQk1Ed29hTzBaMk4yVWl5c3JYUUh6VVNocGhB?=
 =?utf-8?B?S1k1V0hUcGk4OHpHWCtlWU1GQ2ZVTEtlMUQ4czJIaWpFaUVFMkxDcDhJbURK?=
 =?utf-8?B?a0k1amlWa0NJMkxLb2dQZGdiR01DOWVjQjBrNDhmQnZKNWl5UGdpUmZvMFEz?=
 =?utf-8?B?cCs2KytaVCtpd3Jpamp1cEJlTTJ5ME1ub081NTllTmlTejFzUnVPN1FLQnlk?=
 =?utf-8?B?ek5ENnlOM3FNaHg1cnlJeTRDckdZb0c4aHgvVjZSbjZEaXd6Tit1ZjVBaHF5?=
 =?utf-8?B?bmVGTWJ3RnAyamFWL3ppS0I5VzZldnVaeXNvUU44KzQ4cGRaRE12c05SOUQ1?=
 =?utf-8?B?K3dZOFVjaEMrQTAzNWkxTkd6TGRaYTZoYUhRKzRUa0szY3BXMW5UMzFkWkJ4?=
 =?utf-8?B?ZWtGMExQcWg2QlN5K0R2TEY0OXNYL0cxeWl5dzZKWGZkMXU1cUNzZm9ISHZh?=
 =?utf-8?B?QWwyUS9ONWVqQ1BjZ29vc1c5N3AvQjhBTC9NeDhIVFRFRld6U2pvNXhtTndt?=
 =?utf-8?Q?cd4VRl62V3SSz4P5V/5g90j3R?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71e4c3f-90ba-4e78-63a8-08da6411102e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5140.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 14:16:07.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKfCYkpneExGTtGkDG7u6LkTarm2BZl9RgTH0+i5CKCoj+ZLSyeAaHc2JJGC63XeAiE5Jq/AP2FV9N0nhTPyjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7885
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

We need to extend sof_ipc_pcm_parmas with additional data in order
to send compress_params to SOF FW.

The extensions will be done at runtime so we need to dynamically
allocate pcm object of type struct sof_ipc_pcm_params.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/compress.c | 53 ++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 47639b6344c8..45c2ff61ee4d 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -168,7 +168,7 @@ static int sof_compr_set_params(struct snd_soc_component *component,
 	struct snd_compr_runtime *crtd = cstream->runtime;
 	struct sof_ipc_pcm_params_reply ipc_params_reply;
 	struct snd_compr_tstamp *tstamp;
-	struct sof_ipc_pcm_params pcm;
+	struct sof_ipc_pcm_params *pcm;
 	struct snd_sof_pcm *spcm;
 	int ret;
 
@@ -179,40 +179,42 @@ static int sof_compr_set_params(struct snd_soc_component *component,
 	if (!spcm)
 		return -EINVAL;
 
+	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
+	if (!pcm)
+		return -ENOMEM;
+
 	cstream->dma_buffer.dev.type = SNDRV_DMA_TYPE_DEV_SG;
 	cstream->dma_buffer.dev.dev = sdev->dev;
 	ret = snd_compr_malloc_pages(cstream, crtd->buffer_size);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = create_page_table(component, cstream, crtd->dma_area, crtd->dma_bytes);
 	if (ret < 0)
-		return ret;
-
-	memset(&pcm, 0, sizeof(pcm));
-
-	pcm.params.buffer.pages = PFN_UP(crtd->dma_bytes);
-	pcm.hdr.size = sizeof(pcm);
-	pcm.hdr.cmd = SOF_IPC_GLB_STREAM_MSG | SOF_IPC_STREAM_PCM_PARAMS;
-
-	pcm.comp_id = spcm->stream[cstream->direction].comp_id;
-	pcm.params.hdr.size = sizeof(pcm.params);
-	pcm.params.buffer.phy_addr = spcm->stream[cstream->direction].page_table.addr;
-	pcm.params.buffer.size = crtd->dma_bytes;
-	pcm.params.direction = cstream->direction;
-	pcm.params.channels = params->codec.ch_out;
-	pcm.params.rate = params->codec.sample_rate;
-	pcm.params.buffer_fmt = SOF_IPC_BUFFER_INTERLEAVED;
-	pcm.params.frame_fmt = SOF_IPC_FRAME_S32_LE;
-	pcm.params.sample_container_bytes =
+		goto out;
+
+	pcm->params.buffer.pages = PFN_UP(crtd->dma_bytes);
+	pcm->hdr.size = sizeof(*pcm);
+	pcm->hdr.cmd = SOF_IPC_GLB_STREAM_MSG | SOF_IPC_STREAM_PCM_PARAMS;
+
+	pcm->comp_id = spcm->stream[cstream->direction].comp_id;
+	pcm->params.hdr.size = sizeof(pcm->params);
+	pcm->params.buffer.phy_addr = spcm->stream[cstream->direction].page_table.addr;
+	pcm->params.buffer.size = crtd->dma_bytes;
+	pcm->params.direction = cstream->direction;
+	pcm->params.channels = params->codec.ch_out;
+	pcm->params.rate = params->codec.sample_rate;
+	pcm->params.buffer_fmt = SOF_IPC_BUFFER_INTERLEAVED;
+	pcm->params.frame_fmt = SOF_IPC_FRAME_S32_LE;
+	pcm->params.sample_container_bytes =
 		snd_pcm_format_physical_width(SNDRV_PCM_FORMAT_S32) >> 3;
-	pcm.params.host_period_bytes = params->buffer.fragment_size;
+	pcm->params.host_period_bytes = params->buffer.fragment_size;
 
-	ret = sof_ipc_tx_message(sdev->ipc, &pcm, sizeof(pcm),
+	ret = sof_ipc_tx_message(sdev->ipc, pcm, sizeof(*pcm),
 				 &ipc_params_reply, sizeof(ipc_params_reply));
 	if (ret < 0) {
 		dev_err(component->dev, "error ipc failed\n");
-		return ret;
+		goto out;
 	}
 
 	tstamp->byte_offset = sdev->stream_box.offset + ipc_params_reply.posn_offset;
@@ -220,7 +222,10 @@ static int sof_compr_set_params(struct snd_soc_component *component,
 
 	spcm->prepared[cstream->direction] = true;
 
-	return 0;
+out:
+	kfree(pcm);
+
+	return ret;
 }
 
 static int sof_compr_get_params(struct snd_soc_component *component,
-- 
2.27.0

