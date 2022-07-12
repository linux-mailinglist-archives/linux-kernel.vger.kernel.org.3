Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D97571C10
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiGLOQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiGLOQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:16:13 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30059.outbound.protection.outlook.com [40.107.3.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841BB61118
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMiuOv1Xul05owOGkUajHELcRfr3OJR9kjaeBuPZnQEO6/biN6tQm1Ohr6G7Zf3AeiKlVgTGsR4tJU2G+6Yd+UHhTLGNKHkJrO9jO/lF+lfy2fwTPcsc1x/uHLSh2SNgJ9+L8Y3qvm4K5vZMbyuBfbJplQ1jDSE8h9EIbjJ8L+oXsy1ifO/4kw16uo/Rps0b1ovb18rjhqohurGwDoEDX60LXsk5HM0qKps/kdSyU4Vo1AehqK2zQKf7k6mURYoxRlATE9Ms7qH6caUs5HwhGeL/p6yaOSpE8VUD8Y+QoTTbuF2dsdb3aWBEuXS5Jt/YAvwJFiFdLh/ygjsqBQg2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1Ggc4LYG/lXVmUFwze3fqikKdfR3lu3hYI4t+f3EvI=;
 b=SV42kg7GGSrRlbzt5LtprdlOindju9kmG1h/FNBT4pqkjkuUuqZGSXp/LLMERyZiphHd6Zgg+Q7L50o3MKGW03JxOoqbtEd6a+b+jujRthC8WRI1ap1r3Nvjag1ZBCeI/29OduS0H3hZh+V4wTwKr8fgJz3vqj9dCdZxlquyNBbGGQhiF960X5OjMdjgOuoNlYCFpFwAFPTc5Cd3HHEkrcNWp81pcGxWMAGvLYoHBHie9MgbjIpCL0OlEsufXTmAyBtKmyOSylIur9wmVxGC4HGK1V1aZrNXuNJASn2K0Wt3+4J2DQNUFAMTkqUPjSiqPspo38Z3j2qNpi7+G7Yunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1Ggc4LYG/lXVmUFwze3fqikKdfR3lu3hYI4t+f3EvI=;
 b=StTUnPMq1cIGopC3AF0zIIG2xwMYz0G8RFmotD7iT12VMvD0r7LZ6Cj6axJFfLW4Hj17VRkJ8tgLHgbeKFmu1yw+1tcanc6TDpPnOgc/NFZlpNA0vIoYXBfAdQUIWtEQL+jrODzjIMWgOGK10pHzNonotCh2gy9FnktRwV3A1lc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5140.eurprd04.prod.outlook.com (2603:10a6:208:ca::21)
 by PA4PR04MB7885.eurprd04.prod.outlook.com (2603:10a6:102:ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 14:16:09 +0000
Received: from AM0PR04MB5140.eurprd04.prod.outlook.com
 ([fe80::15ba:4274:2df4:8928]) by AM0PR04MB5140.eurprd04.prod.outlook.com
 ([fe80::15ba:4274:2df4:8928%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 14:16:09 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     daniel.baluta@nxp.com, linux-imx@nxp.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        yc.hung@mediatek.com, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/4] ASoC: SOF: compress: Prevent current kernel running with older FW
Date:   Tue, 12 Jul 2022 17:15:30 +0300
Message-Id: <20220712141531.14599-4-daniel.baluta@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 13d35287-1fe1-4ece-9f9f-08da64111153
X-MS-TrafficTypeDiagnostic: PA4PR04MB7885:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hx9bCDz9wBhuruj2xtuae4ubhe/U1qIG4YNMGWwdDDKX1pxOhrkWvKhuml/r7rFVC1i1tMbyklvUOWdUrPQFrPlxTDksatomQ08hcoz0ShmLCG2Az3iMtc1n6Cp3/5Envdb/21sYZ/2gAtHrjHkdvRj4KAg/S/pR5bZXpHwKf53R/PZgvOeNQ/i7YJdPdgzRuR1aDHkzB5R4fzmhfdWONHFgHgKEhAiEazbNTwNRvPRM/e0+T7P6XNk73Ke+1mizE9n6hrz8WNaoLQhd6galjqnR0cNt2s3wsLAUOhVL4Joq8rOnM5hXLbiKv7cgVjfBBA8AK+SZyAahou2PJJ+HcoPsZBebLNRsvLiMdrWeD8mrgl8Hxv3yfzADcuz5mdCGoNKRyMt6/Gcwx+NomcozuMmogOy/Xj23sg/nxpgY0rLgPjVpZYrE/09c1FbfqDgLXmJvo8EZdHunMVNmrZVQWM+RBZ3ShL/NJDp0jZjoSjM46+of1c/zvvles5Zy7tNuM5wRyWaPLvttLbXP28eThEcimnKnnZeACx74xUvyZQ+9DF16yy0RviuKwZAUHUfeO6Tzkcx+vOKl9ofsx8FSQegiPvS4B9+9kg+Gxdz9/xhK4+1/hTI0JG+hHkf9HsRTqh08KPLJR3utACUxtoZBRdNPsV59W7XAT0/FXdSmDofV4ltCUKu9XHja4AB5MCm5/wmSDLCSutN8K+v3cnkmYwyoTvYSoGQNcwJDC4j1CZeH/u9o/Mua3B2vMOR+ffJSP7ySDHdgGhoiFXB2AvTH1/+Etoy3pNhsAGZ3FC4kXxXjx7A0nlAzuuEINX3stRyi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5140.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(316002)(38100700002)(478600001)(6486002)(8676002)(38350700002)(2616005)(66946007)(4326008)(186003)(66556008)(66476007)(1076003)(26005)(6666004)(86362001)(6506007)(44832011)(41300700001)(5660300002)(8936002)(7416002)(6512007)(52116002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkVVU1UxaThUN2pGQndFWENIMnFPMmtmcDRrTExDYi9Qb2dyTHI4bVFtWXlG?=
 =?utf-8?B?NHIvZGFGQmFFV2hKbXlHZFVYNmxadGY3KzA1ZzFGM2xUUXdkZ0tFVTg4UHIy?=
 =?utf-8?B?NnhxeklXYnh4a3FyczkzeEFaSW9GQmFyOGpLSWlLelFoL1pSQmkwaVNDYW9E?=
 =?utf-8?B?cXhoTmNBdGQ0YlQ1NHRXdjJkMk9hdkNTQS9Cb2JRaGd6Tmt5MHJyTndZc2VX?=
 =?utf-8?B?emZJeW85bTkwcnJhVHdqZjRJYXRUcmYyMWtVdW9PNHhtc2Z3TVQwV1J4THEz?=
 =?utf-8?B?NDJnRjFCNnJVT0dYV25kcFZVM2ExbW5HMXV1YUVpeW0zK3l6SmlqT1JLN2di?=
 =?utf-8?B?enNWOXNNOWc3c0x0LzIwT21FdlZ6NFBTWHhpR0h0TXZKYmd3dlplckZZQTdJ?=
 =?utf-8?B?SEd1RjlwbyszQzVRTzdobFgyU25yTFdkT3ppNjJpbHgvV21MNmVhVWpJOGRM?=
 =?utf-8?B?SzFkL3dnOFdKaTlZdWx0Ung2Z21sYTkvb3lCUlZtbnRmR1VQWS9MemNnQXE2?=
 =?utf-8?B?ZHFEVVdsR0k1ellvaldBeEtHV1RCSHVJUGxQL01CS1JHRmd2bVRCQXlOZzRX?=
 =?utf-8?B?aWtaWHNIZC9Ub1Zncld5N1pSTUxrNUN6K2lYYW9rSTBLdERsbU1ZbHY1VmNj?=
 =?utf-8?B?QjRCQUFhL1kxZklQM1M5ajlyNHphb0xHeDFROVc1Z2dENHRPeEowditaWXNq?=
 =?utf-8?B?WHAzYm4wdlNrVzVxOEc2WWJ3ME5wVkRuenJkblIrRjhiTWlIaXJ2UnFiVTFO?=
 =?utf-8?B?R1UzMmR0R1RCallrMWgxQTRZb0VqSWkrajdJN2J6OU92eDVLbmdFSmFHQWlr?=
 =?utf-8?B?Z3I1cUpTazVaWEUzZVZyZjI5UHpZcUdTa0ZIM0o2d2RwWWlja1dZZnFDa3Nw?=
 =?utf-8?B?VFFXUmhJM0t5T2g4VGdLTytoamJrMmxLTkp4bTIxUXh3TWtFMWZIcy83NGVE?=
 =?utf-8?B?dy9acEJtanhaM0xJd1BRZnFPaGtkeFJTOG5DSDlTM3JrQk1oRjlEbmhHRXhh?=
 =?utf-8?B?UDR2dzA2cGVpRmludUN2K0xqTjd3MjhpaHhUSXZ0UktxZFdyK3EwbVNGenVF?=
 =?utf-8?B?cWRIemNuN1VyYllCcFA0YUI1UUZ5eXpWeEgzdFYydHJ0YkVaQlFvaHIwS1hV?=
 =?utf-8?B?UEhpQ2ZiRGxUUHhzK2tVNkxENHFJdks3K3E4MW0waUFFc0NMUGZWQjZDYTY4?=
 =?utf-8?B?VnZ0Q0hFMTlWODFEQ1FxMFpkUzEzS1M3N0tKS1BNVEQ2TXZVUXh3SDNSUGlp?=
 =?utf-8?B?c0lQOGFmTEFSMVlhanJjS3pJa0c2M2lIQmEvTE4wYmcvZDhQdHh0bU8vMGJD?=
 =?utf-8?B?ek43SktuYmtzVUNLVXhzcXRYRWNqM282d1U5QmdJQVdJZ1c1cWtsc3Iyb1Fv?=
 =?utf-8?B?eUZhejhqdWk1K3UySFZ0WFh2ZnFSeVEvOWNETnRrMjFvaVh1Y3Z3djg0aVpw?=
 =?utf-8?B?V3pVTnVkMUNhaWw5VUhZZmg3QTNaQVRFV05WR0lzcUg5a0YyYjlyMkc3cXNV?=
 =?utf-8?B?elNoUlpOSEpIWHJwcEJOTjlscVBlNEJ4S2lNd1lOaHpkVU5rRC8wakk0UFd0?=
 =?utf-8?B?SUZLZUVlTDlSQ253MDQzbjRybXE0NHZXUlBsa0tOcmgxaUV2RENkV0dBcnlm?=
 =?utf-8?B?K1gzblU2WE5ZMlJCK2tNTmJsSEZRR3poNDQ0S3krRExYS1MwYWpuREVIK1RI?=
 =?utf-8?B?dUlmN2tnbytXSjJVY2o4N0xJcVA2N2cwaUVCRGdPRlpjNW0yRG1tTk1rNkJo?=
 =?utf-8?B?VFJmU1Qwby9WV1RzUXVicmM4Q3M4V2x5enAzc1RwSU13b241T2srME5iNjYz?=
 =?utf-8?B?Nkk3SFFGNkFEQVBDN0x0WGRGRmtIZ2d2U3lZQUNrWDJxRUx0NmxVVXd1bGFk?=
 =?utf-8?B?OElNbzlNendNS2FYVG42ZHNzU0QyV2p0bXh3c2FjWmVVZjFxU0J2bVM3Nzln?=
 =?utf-8?B?a29BdGRUMnR3aHVvdjhzbmZwM0g1bFhlWUJ5UUVYUlRtMHJsNWdjN3c2ZGJZ?=
 =?utf-8?B?Qm5nVmJDOHA4RzRTdVk1VDNqTk5MQ2s1cjRWY3dOWEY3VG16UXM0LzNsUjNS?=
 =?utf-8?B?WjY2aUo0RmtJSEtqeDl4MTFIMVpoSmgzUDVTbkRHNFN5bWZFV3RYc1FTbmZS?=
 =?utf-8?Q?/B1fYJvQUcRG4zcve9fJF8jcP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d35287-1fe1-4ece-9f9f-08da64111153
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5140.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 14:16:09.6136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dzp9Y0j4puH6gA6DQGBy4vk/CyMTHPAp2F3g+LfcWpKUVyFcyaMKc4ro3bDn3Izvse0KZ4ZP6gUYOlzaxyebkg==
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

After introducing extended parameters we need to forbid older firmware
versions to run with the current and future kernel versions.

Although in theory the communication protocol will still work the
semantics at application level are undefined. So, prevent this by
disallowing older firmwares to run with newer kernels.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/compress.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 1204dce29ef9..67139e15f862 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -167,12 +167,23 @@ static int sof_compr_set_params(struct snd_soc_component *component,
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_compr_runtime *crtd = cstream->runtime;
 	struct sof_ipc_pcm_params_reply ipc_params_reply;
+	struct sof_ipc_fw_ready *ready = &sdev->fw_ready;
+	struct sof_ipc_fw_version *v = &ready->version;
 	struct snd_compr_tstamp *tstamp;
 	struct sof_ipc_pcm_params *pcm;
 	struct snd_sof_pcm *spcm;
 	size_t ext_data_size;
 	int ret;
 
+	if (v->abi_version < SOF_ABI_VER(3, 22, 0)) {
+		dev_err(component->dev,
+			"Compress params not supported with FW ABI version %d:%d:%d\n",
+			SOF_ABI_VERSION_MAJOR(v->abi_version),
+			SOF_ABI_VERSION_MINOR(v->abi_version),
+			SOF_ABI_VERSION_PATCH(v->abi_version));
+		return -EINVAL;
+	}
+
 	tstamp = crtd->private_data;
 
 	spcm = snd_sof_find_spcm_dai(component, rtd);
-- 
2.27.0

