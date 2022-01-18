Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CCC493000
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344123AbiARV2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:28:40 -0500
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:48165
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343671AbiARV2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:28:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAdzRKdONVbvkMDoseVsgWIVgnY2mZiM7jeHxTYO/f//XODbI7kDb7Yz4+CP089tXnqU/uBXsCDXk784COTo5Nx1bLCd+qtCEyFshlyOyGLeHfXcZsLZsoVGsGubtrPWtLa2Lb+ZhfJah3IXre/5zB8rPSQ0fRSccE3cZ0poX8jjtA+p0loazXN53UJ5/CCM5dbIAej3F4pBQajtg0Y1h2XK4onOXJGNodDpLefjy3KHU+IYRCHrOFKbH1NGKvRK1YL5ruceFbexJnFMWG31+zkTZRCdIJc7zBw8Dq2AWXGPzkSDVSdXCI4wBCJtb2ybNZuPTJLl7s73MGS5yz5pyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjbebqrOQnmZ+MAY3xb66wL5WM+ZeR4cUzc6RPgHqbg=;
 b=QY8Dg6keFn/hFp1PU0Td4ZxjEicqdT/kfl6Xu/tMfktI6fB72gsv68ofoB9FYshGDXUfYiNlSZynni3J/zutSibt6L0mcAf4XRp5/eN1OeeD0hEZcYlnAJZNjie0+JF3QLZKBJfVY4IjrS3XBE1hrwb8m046C4BE8ny/8xFHXvllisxAMadRc2Jf3D/7v91OQaSZ1VADIakQBIzoHL60jlNJejDjhIYjf+ElP1fedpROzD3zZKoMGMqNCShJoMmeV3Y0ydEQu3ihNMDLZFH9VmUeDSAXMs4xq7kcVX74imjKNDzta2JjP6n+AKxbutrtEcBN7x265/MUMxEMS1kpSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjbebqrOQnmZ+MAY3xb66wL5WM+ZeR4cUzc6RPgHqbg=;
 b=RE5T1mM93puSlQAwoE65PA2L5BUP6Srmi7f/GzTDnyx1t76zTCc+Sg3iflMbUUeh5MYOJ/8yfFC3ADSsjGSHuwDFZwcuLbpiiqQgGAL6pUVU+fPP/eWELYaYoAiJpjdNC9f7rLxVPbBeimTfaoiMNgxHxFRalb9JNVItnyIUL0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by PAXPR04MB8207.eurprd04.prod.outlook.com (2603:10a6:102:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 21:28:34 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::3de6:806c:e71:2a2f]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::3de6:806c:e71:2a2f%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 21:28:34 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
        ranjani.sridharan@linux.intel.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
        paul.olaru@nxp.com
Subject: [PATCH v2 2/2] ASoC: SOF: compress: Implement get_caps and get_codec_caps
Date:   Tue, 18 Jan 2022 23:27:32 +0200
Message-Id: <20220118212732.281657-3-daniel.baluta@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 698cb43f-2d22-4069-a093-08d9dac97b32
X-MS-TrafficTypeDiagnostic: PAXPR04MB8207:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB8207D39DC5DE858F2110D514B8589@PAXPR04MB8207.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9otbZeVlBbcD+P8BrfyXmij18E2W9uJD7EWzqxqxuhjna0ZeSUIdFqLHUIO3O2PfhPAfZXQiR2d0s/Js70zgt4TDPoFFmS3NnQO+8uAfdURgELZ42t4S9AfgSkQz/4p8PIQazy+FNFcPOVIxqIBUwGj2++mNaZ8k0l0ktPhjCNotBQCCjn5f1rWcVbJ4/xsv6lAQ5uTnQRDqG1EdeGfW08pCvl/RnI5BYJiv1081toXn3z7qvCThY1/ckYgtgvbGzb0997SdLxIP5wG7cDQjeyLG2djUjU7SjGSV1vOaaHUUgzHE2voQYih69waXLeMPJdydMU6T8bn+SMODMQtDy5kvHbqym1cknmDYhKVvTFA2X1544TenFjDJD2plo29xRdQ/1RvluKSHKmiwJ5KhkSyBjyKlOztbTzQx5h1quvkJgdUEoB6Y6hqpVjvCb6lfnMUHIB556I5yjRaOpX9Ld7S1EFyt69rCN39SVyKrFd3aPgTVyqKZFp9Tk1rDRndJeK5JD1aL45ukSob1ZIEyaCn6wHhZx2q1KKsb1pSN0a6kNDpaLSRb5+VhV+kf5inEFy814sFEuVaWf7B352YLyWdBOTFsL76zhSeCVeOcs0yrBrQ2ogF3G5bAfltSYFDcSpQDmcvhy54R8q+oSrAdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(38100700002)(5660300002)(86362001)(8936002)(508600001)(6506007)(66946007)(1076003)(2616005)(6512007)(66476007)(316002)(6486002)(186003)(44832011)(66556008)(2906002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ZuwW2qfiHWUrFDzXJKWTm6tfz+MQxRdoACHcbTnZ5ZmlutBhGHpA7vQMmbm?=
 =?us-ascii?Q?WRm7Rz7uLFnlcNzKZ6QuKJjf/ufyIeJeY+5PSkaCjkH7uOrq0dXL9gm8gxDB?=
 =?us-ascii?Q?GOuEhULuFHnno5oOCQasfMjQi2ITagaU86T+U2DX1HU7mxBuQmWtS1ax+xif?=
 =?us-ascii?Q?yFjQgemcjCPUmHQEm+BIGQIcD1bkVGlpMI7XI0zI7CW5vBIOL7zCTTKvlTb5?=
 =?us-ascii?Q?m7uv0zvJr+JXmexXp21If+J4sLOkIkW+pkpM+W8k3gZ/7ySCMzErXOlTKuta?=
 =?us-ascii?Q?a17GzjSKufTvchufDEkeo6QqgbC84HXYOO3Vp+pejMMxqPdBpP6OpR8+XOFE?=
 =?us-ascii?Q?5TUELzLgHbcwkN7G6H+MD7AIqEQ9xoOPPFsT+m/MxlPKXtAOLmo58LdEFbaw?=
 =?us-ascii?Q?CGUghfe7M/8Ca3JGglGnbEqvhx6KmvkoPm1ilpAxdGeMmDwyrbnHhy6mQ+ka?=
 =?us-ascii?Q?qN4RENg1Da1v4dAJxn+dKDmt9Rm4ZIMLp1Djv07M9+L5QOdJmPpVaCFhvMn9?=
 =?us-ascii?Q?4iWs+Q4Zj8PfQO/NAmD5guXS4htWOavNZnkwaX/yAaPVfPG7PEozqnK3X/bF?=
 =?us-ascii?Q?s1YCtle4qzOHGmiU1oXjX2vArZnYnjYxlxf3h0zkKWaGDEP2JE3LmQ/TvVs3?=
 =?us-ascii?Q?3nMqu0XEbbbN3KJ0W5DtZrDtI87aUdDN2muivAPNcI9O/irhtsd2iOGxh5BZ?=
 =?us-ascii?Q?agyToF+B0+SZBA5aiswN1bGAEs/xuMlVE+snYp5CvR0p3bdUejDEeXSN5lgX?=
 =?us-ascii?Q?qyJGAp7yQ/g7kf0ZFwXBHH4NHfHa/dVZ4AoO+kcC7eHt0j/84f2RqEoH7Bty?=
 =?us-ascii?Q?lwAzd8kNpVuG1tAYxyHl4bsBDZRJgwicl3iktmbot4uYaWued7v1ZgpEOdQ7?=
 =?us-ascii?Q?MNovxffPvDTo076Quk77jGCLke2pK31C83tkufYqu3eMTvHvb9kc2KtNBy72?=
 =?us-ascii?Q?TKKwyYPcVpvRKctMhtheQxnKUgXxphNpYk/lBATo/B7Wp3pillzh7+O+H7Ea?=
 =?us-ascii?Q?au1HBKIAVDlMmpPT9+QnxsuIYaJ6InD5AJjrsgehg9na4FEJQgnchLF6bbbx?=
 =?us-ascii?Q?AnRdXF0mg9UvYqUWFVJIjZI9x0aR/VhmkBMTfXTaIVAubww2uEzqbqqX0B6+?=
 =?us-ascii?Q?PpPSfNqD1FzhPY/Gyt7zlvmS+SOyidcAKVsYmaV+e4IlL/rFwnxYd07e2V8T?=
 =?us-ascii?Q?fEHClX2KPAvrlA6H8zIhyJGojy5Y9fRj/oO7ZaZSTm1aAyyx53iVE61We+qV?=
 =?us-ascii?Q?LFDvIjpslNIBMwrpD/qmvZj/DzNuMWCrNfK8wmsY+yGg3vvizUNH9tK857lS?=
 =?us-ascii?Q?747S5M4VIeVpa0ZXbsVuwqPvGk4s1QHlCxkYG3hpePCUWeGqZNJp0DBG5llo?=
 =?us-ascii?Q?jVOu3Ifd7IsrLzAjbmwryvr/aaHYo8WL6ahbKLoKNT0BpoMHubEiH1bUgoa+?=
 =?us-ascii?Q?5T3R6yFzWd8uZ+YurzqoK5bYvFJh3QS6zFhyEVicCGY4jAzViX7ZtQljGKkY?=
 =?us-ascii?Q?rOn9VJ74uPsEsQ4hfMqd8m9A6AKDIZWL9BKLKxSWIvIC/uzTTe3fqDPtfmmm?=
 =?us-ascii?Q?GeF9nZ8bHAxZdOQb7xr+VkGzuhOknnJSAqxcnGbH5Vr/vfjBD4V23ON5r9LC?=
 =?us-ascii?Q?F6rcDSsiKf2zaxIUhWFGUHJ4chEDFcjj4OnHUB8ZPLBTqS2lwZQqx4Cjhezj?=
 =?us-ascii?Q?dzkUiPn6hMx4c/yZjp6EoDDGvTs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698cb43f-2d22-4069-a093-08d9dac97b32
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 21:28:34.1542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oR9i9/DV8FMD1mhIWAVnQoWP+s3ytypVfsb/lLLCJtaWkIc8ViQmPCEmRZA/dyqq726k57HybpVbtxbAo73XmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8207
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Olaru <paul.olaru@nxp.com>

These functions are used by the userspace to determine what the firmware
supports and tools like cplay should use in terms of sample rate, bit
rate, buffer size and channel count.

The current implementation uses i.MX8 tested scenarios!

Signed-off-by: Paul Olaru <paul.olaru@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/compress.c | 74 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 91a9c95929cd..e3f3f309f312 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -308,6 +308,78 @@ static int sof_compr_pointer(struct snd_soc_component *component,
 	return 0;
 }
 
+static int sof_compr_get_caps(struct snd_soc_component *component,
+			      struct snd_compr_stream *cstream,
+			      struct snd_compr_caps *caps)
+{
+	caps->num_codecs = 3;
+	caps->min_fragment_size = 3840;
+	caps->max_fragment_size = 3840;
+	caps->min_fragments = 2;
+	caps->max_fragments = 2;
+	caps->codecs[0] = SND_AUDIOCODEC_MP3;
+	caps->codecs[1] = SND_AUDIOCODEC_AAC;
+	caps->codecs[2] = SND_AUDIOCODEC_PCM;
+
+	return 0;
+}
+
+static struct snd_compr_codec_caps caps_pcm = {
+	.num_descriptors = 1,
+	.descriptor[0].max_ch = 2,
+	.descriptor[0].sample_rates[0] = 48000,
+	.descriptor[0].num_sample_rates = 1,
+	.descriptor[0].bit_rate = {1536, 3072},
+	.descriptor[0].num_bitrates = 2,
+	.descriptor[0].profiles = SND_AUDIOPROFILE_PCM,
+	.descriptor[0].modes = 0,
+	.descriptor[0].formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
+};
+
+static struct snd_compr_codec_caps caps_mp3 = {
+	.num_descriptors = 1,
+	.descriptor[0].max_ch = 2,
+	.descriptor[0].sample_rates[0] = 48000,
+	.descriptor[0].num_sample_rates = 1,
+	.descriptor[0].bit_rate = {32, 40, 48, 56, 64, 80, 96, 112, 224, 256, 320},
+	.descriptor[0].num_bitrates = 11,
+	.descriptor[0].profiles = 0,
+	.descriptor[0].modes = SND_AUDIOCHANMODE_MP3_STEREO,
+	.descriptor[0].formats = 0,
+};
+
+static struct snd_compr_codec_caps caps_aac = {
+	.num_descriptors = 1,
+	.descriptor[0].max_ch = 2,
+	.descriptor[0].sample_rates[0] = 48000,
+	.descriptor[0].num_sample_rates = 1,
+	.descriptor[0].bit_rate = {128, 192},
+	.descriptor[0].num_bitrates = 2,
+	.descriptor[0].profiles = 0,
+	.descriptor[0].modes = 0,
+	.descriptor[0].formats = SND_AUDIOSTREAMFORMAT_MP4ADTS | SND_AUDIOSTREAMFORMAT_MP2ADTS,
+};
+
+static int sof_compr_get_codec_caps(struct snd_soc_component *component,
+				    struct snd_compr_stream *cstream,
+				    struct snd_compr_codec_caps *codec)
+{
+	switch (codec->codec) {
+	case SND_AUDIOCODEC_MP3:
+		*codec = caps_mp3;
+		break;
+	case SND_AUDIOCODEC_AAC:
+		*codec = caps_aac;
+		break;
+	case SND_AUDIOCODEC_PCM:
+		*codec = caps_pcm;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 struct snd_compress_ops sof_compressed_ops = {
 	.open		= sof_compr_open,
 	.free		= sof_compr_free,
@@ -316,5 +388,7 @@ struct snd_compress_ops sof_compressed_ops = {
 	.trigger	= sof_compr_trigger,
 	.pointer	= sof_compr_pointer,
 	.copy		= sof_compr_copy,
+	.get_caps	= sof_compr_get_caps,
+	.get_codec_caps	= sof_compr_get_codec_caps,
 };
 EXPORT_SYMBOL(sof_compressed_ops);
-- 
2.27.0

