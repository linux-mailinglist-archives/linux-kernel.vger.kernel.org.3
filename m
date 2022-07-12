Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF050571C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiGLOQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbiGLOQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:16:12 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF316069E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:16:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjwM5HnQm3n2Gb8YF3EEZ05vLl64BFCvrMXEcnNlmsYwRdEHEAdwTcez1Ykg0yNzF77yBsWFTlihb3wwvoc6TlyWcOJwMrLUTGSrwomxQbdknTCnC1Cdy+Wx63Hcxe+tUlTN3aoE5do3FsLbLVGqMytHIjCBuIOsg0n/KDouItuQYSTs/NdWtzYu9R4aXkkoZETaQBQW9sZNL64IDuz+AEaS0M7NNMxHCIiGVvMxeDEfnE5QeeTXQsM6lbir/Iikn3b0BMH///SEjXIsxT+MnqQoPDgMi/6hkoGBwnxrWlqX0cOxVHX5CmUKZ84mQXKalQaEUQORa0ltL7vmlUynzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbbl/cv+q2cw9BCYTXHn0REGjMf8Qz2rYqtLgmOKznA=;
 b=nhFcd2zkfFfBdu+NxEHlHHpziEVfFFzG6zvwk8AP/NFRIwYhmxRmD2cwoFh6jcNNUc84kCLPHMHtiUVaT33YfzpNDAPtCfVGr5gW4NpfxMpEoOdIl/8evc2bxX8hpJ0q45AbpMfxEfQii6rSFvMZqIImECQHip2ak5CnQzJ5lnKs5cXR2uH4ccj1hmPSmJ0o9ajT49H6inG+OrLJZ9+qjFOML4hqZVGy+xk0T0S9mguiNH0OPPHoTiWYm7SlxeBo22AzgoF100IZiiyLe/IuYGO5nAT81xPzHYrzFd9bBHWfZbxQSNx6DA3SzgLaW2Y1IGZ0CfcxbcD/y8dxBHV8Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbbl/cv+q2cw9BCYTXHn0REGjMf8Qz2rYqtLgmOKznA=;
 b=joNb5Q/YplZSvmxCRCFnKwmWcjgm4y+jzDwIgvet3Y8m7iZuyyXwFdWKyWBzem4j7OOYOqeIpXj8+Wwl8PMHOj9/JFH7zrP0EYic5e5u6+7kPwzZylSJwvOazfzSAZT1dOYprVnolN5Pp6i9m4NrWaAdfnM4zQvl7boIF9tv4iA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5140.eurprd04.prod.outlook.com (2603:10a6:208:ca::21)
 by PAXPR04MB8559.eurprd04.prod.outlook.com (2603:10a6:102:216::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 14:16:08 +0000
Received: from AM0PR04MB5140.eurprd04.prod.outlook.com
 ([fe80::15ba:4274:2df4:8928]) by AM0PR04MB5140.eurprd04.prod.outlook.com
 ([fe80::15ba:4274:2df4:8928%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 14:16:08 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     daniel.baluta@nxp.com, linux-imx@nxp.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        yc.hung@mediatek.com, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/4] ASoC: SOF: Copy compress parameters into extended data
Date:   Tue, 12 Jul 2022 17:15:29 +0300
Message-Id: <20220712141531.14599-3-daniel.baluta@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 177ee0df-89c5-4ec1-32cf-08da641110c2
X-MS-TrafficTypeDiagnostic: PAXPR04MB8559:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJvVAzbVHGKdy6avCGqUfMj/iYgKM9pyMEM+XC7puC2EbSm0p6SwrfpV6TZPQ4IJgMmqT6xcogPyaDGJHHmwzZxAWzayGCEFysnRVlSLDexq12AQFY8BVmx+VdOr992zYDh6Lri6gR0EZ9dNwh64hOptrELj+Dp6x41FityGd65ig/lQfXRd/EWEa28z6oJ5yQmCAI0DfJhRj75kKtOCuh8ygcU1jCm9RAWqRM2ArthNxYkXQFRKcZ2hb3NEjlGqmCqo9kdCP4TMCiTwvE0TgGk2zvLBrCMYFL4/w6924o1dDVhaEbiYo38KaZd8h+wzFHfVFW1zAlSKKFIAwhalxWG/Nj0kGq+XCg54qGTQkHrVDKupIc+iMqW0/mkWeD6wEiFkIYTfqrtN7z0PW6kKb1TuMkbdzuTTr5EWSw3lSfOtnkIkSscgo8z23/kfVZIqf6jrm9V4UAZUwslHQjfQzh/sglIEU0r8Q8ijDl4Vmo2eTrQKB+trX4MnKDBx3LoJSTI68B/l0hiWEf9Yyxq2gA1taJME0dBevXlf+bnEmMmrBs6R2lhk0xSo47z+dPsU13uADplWAMFuEZz3u+fH+Gb+A8+AGQJvO6N26i2RkFyQWt6lv5FQnu0WeEj2TQ5eCEEHwC0aHUJzvmcfAOxVqdE00bNiHKEobwKDJtpgowqixnqD2ZylGXBfq4QzuIe8ff3+xfJypomBXqa3iDdoYm7aPnpyJcg8AcAcRWuztTPPooP/5KN7L5fBwlabl92H8aDsGC9Afqvuf42fC+Umpbw3IjnzydjBJlSt3OF7ZK1Pfxxc93iykmDXeEZT1QFF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5140.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(478600001)(8676002)(66946007)(66476007)(4326008)(2616005)(66556008)(83380400001)(52116002)(86362001)(2906002)(6666004)(6486002)(186003)(44832011)(6506007)(26005)(5660300002)(7416002)(316002)(41300700001)(8936002)(1076003)(38100700002)(38350700002)(66574015)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0kwUHllVUdLSW1lS2tPcm1rL0VHczVxcUdrQUt3UXJRemo4VVJCVFlSbXFs?=
 =?utf-8?B?cHdubnlzSUhOcERTdmZlUlE2cXYzNWpqUU84RkhiUG9jazFhdGEwRUR6VGN4?=
 =?utf-8?B?L1l4S0M0T25ydm9JYXVnakZPdHJaR0xKbzZSek9sdThhekVtS1kvZ2NjZXdx?=
 =?utf-8?B?dzhGS2ttamZIYWpSSkFRVWV6akx5Mi9QVFZJcElYY2ZtS215RlNHNWJzUWJ5?=
 =?utf-8?B?aEpGT2FxUUVnSkI3OGczNXE1RE9FVldDNEttRGRQOFprN21iSXVNejhXRHRp?=
 =?utf-8?B?TWNkYVU0S0NYQW45K1FZakZQNld4cnJBVlpmTEFsaEdOZjBCaUlxbHdLQjd6?=
 =?utf-8?B?QjFFalVDbFRQUXFBWnZDc213V2p6WCtDZzRjd0ZBK2Q0RmVLOFU4TkVHM0xl?=
 =?utf-8?B?alhNUVREUWRVaU8rWGd2NVpSSmhrUnBGVlpRWHNOMFdKemlHRjhhbFEwUkk0?=
 =?utf-8?B?VFU4QStEb1pUT0llaWZ3biszbXhjZEdOSXVaQTliM0dFbldKNHN1Q0JiUG5L?=
 =?utf-8?B?ZFMvWTZSak1HSmhCa3YzVmpFQ2ZncmdGTFlXb3oxTU42NlRZZ3pGU0Q1L1dL?=
 =?utf-8?B?Q2k0cWRXRktWUXMwZ1dRS2RCY05MODM1WHVZZFdSbTR3cWlDQ0xFS3Y4WHg4?=
 =?utf-8?B?RDgyb1ZkWEcrNHpuc3BtQ3lsOHdSVDM4aUhONnVlUzA4ZElKY2h5TmoxTUxV?=
 =?utf-8?B?OUhManFpa2pkc3JzbVdRWXdPME5NYW82cGozVFhWbWRudUlGaktnZ2VCVEJ1?=
 =?utf-8?B?UWlWbmZ3Tytkd3E5dTdEWUZtejJncHBlOTM0YW8wdW1TdVc4TnkvL2JtaXZK?=
 =?utf-8?B?cEtQS1pOeVdNRDJpd0Zlb1pyOVVxNnk1c3YwWFJwMjNZSVdyY1REdW9McXd3?=
 =?utf-8?B?eFZWWDJFT2JVWDhRZjZSY2dHRlJBUHpmWm5qWDNvUzhkTU0wam1lUExJeUhY?=
 =?utf-8?B?RDF1V2FaT2REdHlSd0xaRng0OFVFYVVWYjNhVnJ6L2JoRExxeDRLSkNnM1l6?=
 =?utf-8?B?MnJoQXJXSC8vWVBHK1ZudHdYbVhhcnUyR2dmMVdMem1YOE5xKzVIUFRIcnJj?=
 =?utf-8?B?dmVaaDV3S1NtTEQzMFlqaG1wR1pJcXZxV2pwVlZ4YnBseW9lTTI0MHEwUFVu?=
 =?utf-8?B?aFd6VHdOM2RzT0x0dCtyWEtMcytlZXJQMXQ2TExKUlpUbndRZ3ZjdkZxT1JV?=
 =?utf-8?B?TTU4K1F4NFVHbFdtRmpZL1Z5dUN1akZHZmNvMGZJNU1iSk5TSXd5ZkxBYmt2?=
 =?utf-8?B?dThtZ1NOM2VPUlNzcEJpYk8wUisraXdwZFR4aFpON1orWVUwRnRtTCsxcnF0?=
 =?utf-8?B?SEpySVlMUnhMSnd0ZXZ0T1FJbmdaK2YyVmw0c0IzY2lMa2gyVGNEdjZTTWhF?=
 =?utf-8?B?RlFhZ2krWHdqZVo1bzM5Y1FtOHVNZVJLc2VMUjFpMTcvOEtjOG1iRWZrNGd1?=
 =?utf-8?B?cnVNY3g2dkxqNkhFNnRYKzVhOXFQbTNoK2F0YVR2MEtNRUpoYUVNNHpkVmFM?=
 =?utf-8?B?bklWa2tQZm5weVdtQ2UyZDJOdHovQ3VqZkM5OFBseGFGaVQ5bmFES1YxUUho?=
 =?utf-8?B?WXN5SEZoWUVhL09YWisxczA0SkwxRHFpcE85YlBCR0UzNGJhTHBLd3YvT25l?=
 =?utf-8?B?d0JvR0swdTd3eHJlV1pZaWpwOXRCeVlkNGF5dkx2bXhGRisxbFBUU05tTmtW?=
 =?utf-8?B?cDNYQTBmZG5UWGJBYzVvUzdqTldEWFpqZTlaSWQwSm54V0UyU0kwNmNRa3Bq?=
 =?utf-8?B?dGRBb2NlNk0wNTljYXNvTVk1Ri9wZndnU2o3UEdCWmhrZU1Dbk5VZU4zNHhG?=
 =?utf-8?B?WW1Da0NRTk4vbDdVZXQ5MmxLcmFnS2dIZ25lMTVWSHFrT2Z2ZUlOT3JrcGV4?=
 =?utf-8?B?ZHR1YzJFRG5qMmYwYXNZVElrWWNjbzIyNUlNbXUyVVRXazhJMEgzSVpwZCtz?=
 =?utf-8?B?SDk1N08vV0tHd2MrdHNWVGozZ2xxM2dHRFRYa1Y2WTRpai9adkZETVJtTERv?=
 =?utf-8?B?Ums4QXpSK0FESG5vMkVTL3ZabEhPVTRpUmJWOFF1ek5UcWNpcy9PVDZ0bHhJ?=
 =?utf-8?B?a1N5ajlHekpPVHFmUWJkaU5ISW1adE5Kc3VuOTVxYVJQYm1SY09meTFmMXRq?=
 =?utf-8?Q?IVyyiKWcEWgWOvRK0hj/n88QY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177ee0df-89c5-4ec1-32cf-08da641110c2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5140.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 14:16:08.6449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5s8DEo80eKNFce6qZN04EvzkLCfpps0r0a/125MTrKwWSWA9BvOJRPDCF/fLgPbzSEKHA7+doiyjTdk7SUW6SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8559
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

Allocate memory at the end of sof_ipc_stream_params to store
snd_compr_params in order to be sent them to SOF firmware.

This will help firmware correctly configure codecs parameters.

Notice, that we use 2 bytes from the reserved pool in order to store
the extended data length. This is compatible with older FWs where
there was no extended data.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 include/sound/sof/stream.h |  6 ++++--
 sound/soc/sof/compress.c   | 17 +++++++++++++----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/sound/sof/stream.h b/include/sound/sof/stream.h
index 1db3bbc3e65d..9377113f13e4 100644
--- a/include/sound/sof/stream.h
+++ b/include/sound/sof/stream.h
@@ -86,9 +86,11 @@ struct sof_ipc_stream_params {
 	uint32_t host_period_bytes;
 	uint16_t no_stream_position; /**< 1 means don't send stream position */
 	uint8_t cont_update_posn; /**< 1 means continuous update stream position */
-
-	uint8_t reserved[5];
+	uint8_t reserved0;
+	int16_t ext_data_length; /**< 0, means no extended data */
+	uint8_t reserved[2];
 	uint16_t chmap[SOF_IPC_MAX_CHANNELS];	/**< channel map - SOF_CHMAP_ */
+	uint8_t ext_data[]; /**< extended data */
 } __packed;
 
 /* PCM params info - SOF_IPC_STREAM_PCM_PARAMS */
diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 45c2ff61ee4d..1204dce29ef9 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -170,6 +170,7 @@ static int sof_compr_set_params(struct snd_soc_component *component,
 	struct snd_compr_tstamp *tstamp;
 	struct sof_ipc_pcm_params *pcm;
 	struct snd_sof_pcm *spcm;
+	size_t ext_data_size;
 	int ret;
 
 	tstamp = crtd->private_data;
@@ -179,7 +180,12 @@ static int sof_compr_set_params(struct snd_soc_component *component,
 	if (!spcm)
 		return -EINVAL;
 
-	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
+	ext_data_size = sizeof(params->codec);
+
+	if (sizeof(*pcm) + ext_data_size > sdev->ipc->max_payload_size)
+		return -EINVAL;
+
+	pcm = kzalloc(sizeof(*pcm) + ext_data_size, GFP_KERNEL);
 	if (!pcm)
 		return -ENOMEM;
 
@@ -194,11 +200,11 @@ static int sof_compr_set_params(struct snd_soc_component *component,
 		goto out;
 
 	pcm->params.buffer.pages = PFN_UP(crtd->dma_bytes);
-	pcm->hdr.size = sizeof(*pcm);
+	pcm->hdr.size = sizeof(*pcm) + ext_data_size;
 	pcm->hdr.cmd = SOF_IPC_GLB_STREAM_MSG | SOF_IPC_STREAM_PCM_PARAMS;
 
 	pcm->comp_id = spcm->stream[cstream->direction].comp_id;
-	pcm->params.hdr.size = sizeof(pcm->params);
+	pcm->params.hdr.size = sizeof(pcm->params) + ext_data_size;
 	pcm->params.buffer.phy_addr = spcm->stream[cstream->direction].page_table.addr;
 	pcm->params.buffer.size = crtd->dma_bytes;
 	pcm->params.direction = cstream->direction;
@@ -209,8 +215,11 @@ static int sof_compr_set_params(struct snd_soc_component *component,
 	pcm->params.sample_container_bytes =
 		snd_pcm_format_physical_width(SNDRV_PCM_FORMAT_S32) >> 3;
 	pcm->params.host_period_bytes = params->buffer.fragment_size;
+	pcm->params.ext_data_length = ext_data_size;
+
+	memcpy((u8 *)pcm->params.ext_data, &params->codec, ext_data_size);
 
-	ret = sof_ipc_tx_message(sdev->ipc, pcm, sizeof(*pcm),
+	ret = sof_ipc_tx_message(sdev->ipc, pcm, sizeof(*pcm) + ext_data_size,
 				 &ipc_params_reply, sizeof(ipc_params_reply));
 	if (ret < 0) {
 		dev_err(component->dev, "error ipc failed\n");
-- 
2.27.0

