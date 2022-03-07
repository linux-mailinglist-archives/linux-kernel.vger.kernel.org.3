Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD1E4D00C7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbiCGOMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiCGOMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:12:38 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10049.outbound.protection.outlook.com [40.107.1.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FCB8D6AE;
        Mon,  7 Mar 2022 06:11:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU0eSRS9npFkEAefqpd2uL/p+LLr/FlKIT9FStWaY71Cb37GV8dd7XWOYCuDW5lwa2OFUX4ppry0bbbbVx6/qKbl1IfcvkTqETSIK8hZwRu5HHCJ8tChK8+RjF1CpabhovOQNUX0vs1hjzzS5Id99z5maZgs/VpYKGN2tYYxT/OaUwxfoL74kHOgoqul5wNZmboxOimmPacygwFAaxzPGB2HitC0D/9W58HjLHdbPc5AgOOe2PNDtVIdxx+E7MxDhhmveEPZjwq1g8xZU36UXDMgof3Nkv1eGJLkr0HwMp51zuLCUlUsl8dLtt5YGsDQqqZ8dR+GBIQNCD83GRMeYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJKcvPX1vxLV3/2vXoin2aP1kStbyvPLseSjdrxBRaA=;
 b=aQvTaSazFVV6ux3GVcZjJrqwl0B4+oo8rq3wMzGm578+mvmGFm02xCvzo9PYq9Y92iN/hz4P4YAg9rkme+HyUUHyW3jaGr9DTVVkMqDh9ujA5wbbrHwbX1EtvhkXM/2qelSCbrShgLWOGCQM+dWhYawv4nnVfW0zYTde59Xo3SfbU/pzvsuGhLIEgB+F5cXYzK0xJ4dW2VCNwhZK2yPJak4L14kWBEx17pZTi5m5gx8nnApYc/YG+kR2DkTvILqBPL9vXJ3ZWdKiJDFDMR8/NOd5PSDSP04jfntEtyK21ekWpnULNEVISoUm+fWxhN6WTphnBXtlQcxht57kxTAIgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJKcvPX1vxLV3/2vXoin2aP1kStbyvPLseSjdrxBRaA=;
 b=jC/dVlE7I3oZcgEDDfQ9IXoHF5/y2jFviV6NWtIj2K8tEu0FiKgGZzqLuF+cBi8vNbcUQ5yELV3tmnDodew7065HIxur+apgXqHn7BccMKL4A5bdTIb4dbrD0249tdm1OQOn5HIxyDmzyPjr5CYHR2PxmeTv+k92rsrLwM/N7ID/NnlYsJb70Pqe0scFBEEYEeD41FIH/HqzGxdWdnD1thRk5oM9M/+v2oX8fgz6HcT2dMa1rb34Ln1FQgPI3tn3e9qDTlV5XFJZKASoFwFsL/3HFDb7o+g2rysMXj25r1TdHsN1jkGtVDczr4o131NN3yY4lab/98eYfrn0Ta2oWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from AM9PR08MB6999.eurprd08.prod.outlook.com (2603:10a6:20b:41a::7)
 by AM6PR08MB5219.eurprd08.prod.outlook.com (2603:10a6:20b:ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 14:11:40 +0000
Received: from AM9PR08MB6999.eurprd08.prod.outlook.com
 ([fe80::784c:5631:d38f:9a63]) by AM9PR08MB6999.eurprd08.prod.outlook.com
 ([fe80::784c:5631:d38f:9a63%6]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 14:11:40 +0000
From:   Alifer Moraes <alifer.m@variscite.com>
To:     linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, eran.m@variscite.com,
        festevam@gmail.com, lgirdwood@gmail.com,
        linuxppc-dev@lists.ozlabs.org, nicoleotsuka@gmail.com,
        patches@opensource.cirrus.com, perex@perex.cz,
        pierluigi.p@variscite.com, robh+dt@kernel.org,
        shengjiu.wang@gmail.com, tiwai@suse.com, Xiubo.Lee@gmail.com
Subject: [PATCH 1/4] ASoC: fsl-asoc-card: add WM8904 support
Date:   Mon,  7 Mar 2022 11:10:38 -0300
Message-Id: <20220307141041.27538-1-alifer.m@variscite.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CP2PR80CA0081.lamprd80.prod.outlook.com
 (2603:10d6:102:14::19) To AM9PR08MB6999.eurprd08.prod.outlook.com
 (2603:10a6:20b:41a::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07c29b99-d0cd-41f5-cd66-08da00446592
X-MS-TrafficTypeDiagnostic: AM6PR08MB5219:EE_
X-Microsoft-Antispam-PRVS: <AM6PR08MB52194D01F3F2BC5700C612A987089@AM6PR08MB5219.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0HWUA13GiEk122TQTmR94aZ1cC0m9UnJwbktceC7TpeNSERBpPuW2wvbQwuA2054gAmUrrS2XGBl9Vx0t1nSfm5AqVurW3/xMDgUur2wp2ZjBwI7XMMwj8MaZfUa21JhzinLaFpTEKmcTlRlavV/XKZC3P3AR/F0WxV3vQZgF+iU3V2gAMdiM+Vq/f2CTiJf4ksPgExxFm7OIVnykVQQ9QILCMeq73O0R8X7YwRYvqJpwez26KL42EkmvB8i6njoTuicebePv93WFjNCdFnmufYAhLSpXT60rCiTOPi59oRm3DaWObR22EofjynBlFg/c8BDGbuVdDqrnCpRAaHpJCqytPn/01vg6IRodOLEoJPowc4iEOPjTPiSmjPUYfI3rOQMxnWHOHLt9Wk2Lhi+5yxxTZaH0z5b6W9p9DaG55OmpMbR+DatIbIeQMjnIHYKzWUQ46R9lsBDmELz2FBjQ2Z3NJRprO6vTW28rOJm5GCbQLaWP9uUjXbs8nnujbNBFXBsuHeYPGcSoIHdKmDsgk7QmjIEczaatcJhems0uOJLbK4z6XjQq8oIC9roIl3EMKatJsg5y3faxVXQjrH8sqOjLY6kKBRk/U7Ep+922SzftafZ4hV8h8dP12TWCHueyoNreG6ka40CcA++771ZL6SAxGZiL1tHd/qhcnnP7E/UVXNn3l5JDu6oQUavZeJl4YjQH5sLmUSSDxjZAcVDyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6999.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(346002)(6916009)(186003)(26005)(2616005)(1076003)(508600001)(6486002)(52116002)(6512007)(6506007)(86362001)(38100700002)(83380400001)(38350700002)(36756003)(2906002)(66946007)(66476007)(8936002)(8676002)(66556008)(7416002)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h8Or8JY94yJFSXMeO+HXPw+EgHJr96WhVhHaG/PXRhO94D7nyxUfEaquYfVk?=
 =?us-ascii?Q?zWrtbIwfKf3am7k+5Ud845NWjFXRrtwrJd+E0mb74oXMsX/J8HCsT/KTpBeu?=
 =?us-ascii?Q?VJIXB9+CPNMZaURWgR9WP0YZF9pY33Lxj1lEfpEbRvA/ZYKlwfy6Vd2PmWLz?=
 =?us-ascii?Q?jsj/AZo+9XbHtU/CcdPBm6M2cGCzS+9WPXirZG0+YBw//nNwqVYtrHePEpcb?=
 =?us-ascii?Q?vNlrGTvuA1hxH2wHoQScvJDDU5Xs/6kETzdERWcZTi5rBWyr7E3nP1rL1KcN?=
 =?us-ascii?Q?r7Soc0gyNUKNyViN9lfhR4tnsrHGjBfEJUfDGZgxU50fSGlJo12ZgD5w0JWe?=
 =?us-ascii?Q?k49V9cLPPsmvwzf0lMYvrjiLvNHpun5U1R4Ng/iOS2lwgzbJg+TtMh+KRR4u?=
 =?us-ascii?Q?WchqrkEExgAuTSL8xx6Xfi2dn2obBlwjGRHFRtlEMgrugaQj6PXydxwV8enC?=
 =?us-ascii?Q?aUjRX7kprBgXNHDHAD7lonEKi4U8GDWfIr2Xk4cf6VOwQ30MAq4IiPj5cdEV?=
 =?us-ascii?Q?xOgedIz9uRsDMpseY0zdN/RklA64LWxNxbM3/CSthvKaFvFhHzeVuQ82rlEt?=
 =?us-ascii?Q?YyVdK97HUqJMtxWm7JBrParG/Lg5qZ2GssZVmjj5Rsb26y7FeptIUXLBS/1i?=
 =?us-ascii?Q?SQMnT4oMctSClPTTQSHOevEOvDogAsnx3KtQnh/9idIItbfeelOkVoBYgaJf?=
 =?us-ascii?Q?CNd1KiMEhHSmXPmzJU9YD7tDVa0wr70IARW6xU21jDZNPEOFzC/23IG+iL7e?=
 =?us-ascii?Q?GXohr8E9DW0fRD6Z2pWwe8NtTKXcwFT/6G60NMVvFnpVQgkc0bUxVRrZChyj?=
 =?us-ascii?Q?e9YLiZ3jvjg9uZTu14D7ZHnwTYAHzYNhB1os6aVqEfO6LwiqTz063iqIQlkN?=
 =?us-ascii?Q?balbfDpiB/EPpk+b911bgjuLPDrinmQ1hq+4sRp0Mh71US/wHuWMG3YHhkZb?=
 =?us-ascii?Q?FJasQFMRy5+PHSoOJnS8GkB0Izza5akR74UWT4ElRDt2K3cvOumTFmEq8Yc6?=
 =?us-ascii?Q?cnw1rRqrOs3fICtAzJs7DcKnOdQ0mJlUCuwYNAYMv3JFaF619GLw6zacbzH0?=
 =?us-ascii?Q?2osmsBLnZug+Wl5aEgu8sagQmcSO1CDCr2VXFhFQasK1qfRR0v3wEBK8HXQL?=
 =?us-ascii?Q?2E+Ngg1yLCkU8PwfG3nW3NamRxa78M4EMI9CtEWuzuvsOp49t1LbXXFebQYr?=
 =?us-ascii?Q?EFupx5OOjrXyr0gCvbJhPcDYgcRIlsU5IVGiq8LBTj1nA252GJY2ChY/0hQO?=
 =?us-ascii?Q?ebGWh2TCAgU8NCgqbiONaJanwQwNez3mfeyM86nBczHnGAWb4MnveLWylgdr?=
 =?us-ascii?Q?hE0vm1wDUtUtQsltBCM+6zAjf/zH2OZtGAvVbAQuo5sKeKeYeHsfeJywdNYg?=
 =?us-ascii?Q?8IwDwfo8uuOhKp6QRIRfjaQZHoRbkW/NlWzGRMX56Asb9it79CooTcC4cjrM?=
 =?us-ascii?Q?sAyPEjLMdxgd8z1F0eHO4zf1Vg/naU3WlUAO00yFt4sx7ElF8QmXKRE6dUHn?=
 =?us-ascii?Q?aaPW2VB6oiYCGoVu5ZMtDOfM4TkuM2OlH2rVJDFykvb2soMIIXoUDZbSS5Dk?=
 =?us-ascii?Q?YxQQyTHaeFRN+9R6i4+9bWQrUXk+LN7qw+hn8pNaz8A+jfNZtne4Za5Egp3i?=
 =?us-ascii?Q?iM+7+5whyYmBhuUJh5a/6tk=3D?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c29b99-d0cd-41f5-cd66-08da00446592
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6999.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 14:11:40.4009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/ZYZcmUQgOJpi0qxJxqmMoN6joE+ZtE0mn6QiKjyohOHpjOMsKvWTNAQN9nwNqYQwerQd8w4M5ghP0ecs2ecA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5219
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierluigi Passaro <pierluigi.p@variscite.com>

The codec WM8904 can use internal FLL as PLL source.
Whenever the PLL source is not an external MCLK, this source
must be setup during hw_params callback otherwise the BCLK
could be wrongly evaluated.
The SND_SOC_BIAS_PREPARE event is raised after the hw_params
callback, so there is no need to set again PLL and SYSCLK and
actually there's no need at all the set_bias_level function.
Also, when esai is used, a dedicated snd_soc_dai_set_tdm_slot
call is required.

Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>
Signed-off by: Alifer Moraes <alifer.m@variscite.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 47 +++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 5ee945505281..817dbc1ec635 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -23,6 +23,7 @@
 #include "imx-audmux.h"
 
 #include "../codecs/sgtl5000.h"
+#include "../codecs/wm8904.h"
 #include "../codecs/wm8962.h"
 #include "../codecs/wm8960.h"
 #include "../codecs/wm8994.h"
@@ -257,6 +258,38 @@ static int fsl_asoc_card_hw_free(struct snd_pcm_substream *substream)
 		}
 	}
 
+	if (of_device_is_compatible(dev->of_node, "fsl,imx-audio-wm8904")) {
+		struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+		unsigned int pll_out;
+
+		ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0, 0, 2,
+					       params_physical_width(params));
+		if (ret) {
+			dev_err(dev, "failed to set TDM slot for cpu dai\n");
+			return ret;
+		}
+
+		if (priv->sample_format == SNDRV_PCM_FORMAT_S24_LE)
+			pll_out = priv->sample_rate * 384;
+		else
+			pll_out = priv->sample_rate * 256;
+
+		ret = snd_soc_dai_set_pll(codec_dai, codec_priv->pll_id,
+					  codec_priv->pll_id,
+					  codec_priv->mclk_freq, pll_out);
+		if (ret) {
+			dev_err(dev, "failed to start FLL: %d\n", ret);
+			return ret;
+		}
+
+		ret = snd_soc_dai_set_sysclk(codec_dai, codec_priv->fll_id,
+					     pll_out, SND_SOC_CLOCK_IN);
+		if (ret) {
+			dev_err(dev, "failed to set SYSCLK: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -651,6 +684,19 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->codec_priv.fll_id = WM8960_SYSCLK_AUTO;
 		priv->codec_priv.pll_id = WM8960_SYSCLK_AUTO;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBP_CFP;
+	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8904")) {
+		codec_dai_name = "wm8904-hifi";
+		priv->card.set_bias_level = NULL;
+		priv->codec_priv.mclk_id = WM8904_CLK_FLL;
+		priv->codec_priv.fll_id = WM8904_CLK_FLL;
+		priv->codec_priv.pll_id = WM8904_FLL_MCLK;
+		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
+		if (strstr(cpu_np->name, "esai")) {
+			priv->cpu_priv.sysclk_freq[TX] = priv->codec_priv.mclk_freq;
+			priv->cpu_priv.sysclk_freq[RX] = priv->codec_priv.mclk_freq;
+			priv->cpu_priv.sysclk_dir[TX] = SND_SOC_CLOCK_OUT;
+			priv->cpu_priv.sysclk_dir[RX] = SND_SOC_CLOCK_OUT;
+		}
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-ac97")) {
 		codec_dai_name = "ac97-hifi";
 		priv->dai_fmt = SND_SOC_DAIFMT_AC97;
@@ -900,6 +946,7 @@ static const struct of_device_id fsl_asoc_card_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-tlv320aic32x4", },
 	{ .compatible = "fsl,imx-audio-tlv320aic31xx", },
 	{ .compatible = "fsl,imx-audio-sgtl5000", },
+	{ .compatible = "fsl,imx-audio-wm8904", },
 	{ .compatible = "fsl,imx-audio-wm8962", },
 	{ .compatible = "fsl,imx-audio-wm8960", },
 	{ .compatible = "fsl,imx-audio-mqs", },
-- 
2.25.1

