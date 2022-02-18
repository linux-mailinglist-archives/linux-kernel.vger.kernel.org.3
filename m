Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855174BBAFF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbiBROyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:54:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiBROyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:54:33 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7E454FB2;
        Fri, 18 Feb 2022 06:54:17 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6DC611F46B9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645196056;
        bh=vszf1mxLCqbidpRVRQR/8NqjOMQR9G4uyJxNzOwk5/U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MMTU2098qGRMayEFfduZx/jPWm/f+3QmzqTmb5DrZoMDiIWoXwS/pMsPnS9gHjrFK
         OJUyno+tT3OFo4fuinglRWna4mx2B5/0Q2EeukA7rDpB0w9lSthKttTOCDHvQHrQlB
         JcnSZtOpe7l/eWFc4bSFh4yMtJNIqsPSFXqqwh0CBEf7FQ4KL3xbSZ5MjMPtER7a+n
         Cgt2foHA6HnpOlxMcUX0BVTzhf0CjhUGx+vJnb1vvnJjaHo7+65ynVzzZb9Hb5mzjc
         k3+YwpDT9mRrmQRoGeMaH6m0SkjTXyhEOdK7H6QouBZET2w2yPdxGVqgWnwBYU6Pd2
         8iTl+AqO+rAxg==
Message-ID: <b8ada898-9374-72be-6c1d-a99706388a2a@collabora.com>
Date:   Fri, 18 Feb 2022 15:54:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v2 04/17] ASoC: mediatek: mt8186: support hostless in platform
 driver
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, p.zabel@pengutronix.de,
        geert+renesas@glider.be, trevor.wu@mediatek.com,
        tzungbi@google.com, aaronyu@google.com, zhangqilong3@huawei.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220217134205.15400-1-jiaxin.yu@mediatek.com>
 <20220217134205.15400-5-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220217134205.15400-5-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/02/22 14:41, Jiaxin Yu ha scritto:
> This patch adds mt8186 hostless dai driver.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>   .../soc/mediatek/mt8186/mt8186-dai-hostless.c | 295 ++++++++++++++++++
>   1 file changed, 295 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-hostless.c
> 
> diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-hostless.c b/sound/soc/mediatek/mt8186/mt8186-dai-hostless.c
> new file mode 100644
> index 000000000000..37460a3acc93
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8186/mt8186-dai-hostless.c
> @@ -0,0 +1,295 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// MediaTek ALSA SoC Audio DAI Hostless Control
> +//
> +// Copyright (c) 2022 MediaTek Inc.
> +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> +
> +#include "mt8186-afe-common.h"
> +
> +static const struct snd_pcm_hardware mt8186_hostless_hardware = {
> +	.info = (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
> +		 SNDRV_PCM_INFO_MMAP_VALID),
> +	.period_bytes_min = 256,
> +	.period_bytes_max = 4 * 48 * 1024,
> +	.periods_min = 2,
> +	.periods_max = 256,
> +	.buffer_bytes_max = 4 * 48 * 1024,
> +	.fifo_size = 0,
> +};
> +
> +/* dai component */
> +static const struct snd_soc_dapm_route mtk_dai_hostless_routes[] = {
> +	/* Hostless ADDA Loopback */
> +	{"ADDA_DL_CH1", "ADDA_UL_CH1 Switch", "Hostless LPBK DL"},
> +	{"ADDA_DL_CH1", "ADDA_UL_CH2 Switch", "Hostless LPBK DL"},
> +	{"ADDA_DL_CH2", "ADDA_UL_CH1 Switch", "Hostless LPBK DL"},
> +	{"ADDA_DL_CH2", "ADDA_UL_CH2 Switch", "Hostless LPBK DL"},
> +	{"I2S1_CH1", "ADDA_UL_CH1 Switch", "Hostless LPBK DL"},
> +	{"I2S1_CH2", "ADDA_UL_CH2 Switch", "Hostless LPBK DL"},
> +	{"I2S3_CH1", "ADDA_UL_CH1 Switch", "Hostless LPBK DL"},
> +	{"I2S3_CH1", "ADDA_UL_CH2 Switch", "Hostless LPBK DL"},
> +	{"I2S3_CH2", "ADDA_UL_CH1 Switch", "Hostless LPBK DL"},
> +	{"I2S3_CH2", "ADDA_UL_CH2 Switch", "Hostless LPBK DL"},
> +	{"Hostless LPBK UL", NULL, "ADDA_UL_Mux"},
> +
> +	/* Hostelss FM */
> +	/* connsys_i2s to hw gain 1*/
> +	{"Hostless FM UL", NULL, "Connsys I2S"},
> +
> +	{"HW_GAIN1_IN_CH1", "CONNSYS_I2S_CH1 Switch", "Hostless FM DL"},
> +	{"HW_GAIN1_IN_CH2", "CONNSYS_I2S_CH2 Switch", "Hostless FM DL"},
> +	/* hw gain to adda dl */
> +	{"Hostless FM UL", NULL, "HW Gain 1 Out"},
> +
> +	{"ADDA_DL_CH1", "GAIN1_OUT_CH1 Switch", "Hostless FM DL"},
> +	{"ADDA_DL_CH2", "GAIN1_OUT_CH2 Switch", "Hostless FM DL"},
> +	/* hw gain to i2s3 */
> +	{"I2S3_CH1", "GAIN1_OUT_CH1 Switch", "Hostless FM DL"},
> +	{"I2S3_CH2", "GAIN1_OUT_CH2 Switch", "Hostless FM DL"},
> +	/* hw gain to i2s1 */
> +	{"I2S1_CH1", "GAIN1_OUT_CH1 Switch", "Hostless FM DL"},
> +	{"I2S1_CH2", "GAIN1_OUT_CH2 Switch", "Hostless FM DL"},
> +
> +	/* Hostless_SRC */
> +	{"ADDA_DL_CH1", "SRC_1_OUT_CH1 Switch", "Hostless_SRC_1_DL"},
> +	{"ADDA_DL_CH2", "SRC_1_OUT_CH2 Switch", "Hostless_SRC_1_DL"},
> +	{"I2S1_CH1", "SRC_1_OUT_CH1 Switch", "Hostless_SRC_1_DL"},
> +	{"I2S1_CH2", "SRC_1_OUT_CH2 Switch", "Hostless_SRC_1_DL"},
> +	{"I2S3_CH1", "SRC_1_OUT_CH1 Switch", "Hostless_SRC_1_DL"},
> +	{"I2S3_CH2", "SRC_1_OUT_CH2 Switch", "Hostless_SRC_1_DL"},
> +	{"Hostless_SRC_1_UL", NULL, "HW_SRC_1_Out"},
> +
> +	/* Hostless_SRC_bargein */
> +	{"HW_SRC_1_IN_CH1", "I2S0_CH1 Switch", "Hostless_SRC_Bargein_DL"},
> +	{"HW_SRC_1_IN_CH2", "I2S0_CH2 Switch", "Hostless_SRC_Bargein_DL"},
> +	{"Hostless_SRC_Bargein_UL", NULL, "I2S0"},
> +
> +	/* Hostless AAudio */
> +	{"Hostless HW Gain AAudio In", NULL, "HW Gain 2 In"},
> +	{"Hostless SRC AAudio UL", NULL, "HW Gain 2 Out"},
> +	{"HW_SRC_2_IN_CH1", "HW_GAIN2_OUT_CH1 Switch", "Hostless SRC AAudio DL"},
> +	{"HW_SRC_2_IN_CH2", "HW_GAIN2_OUT_CH2 Switch", "Hostless SRC AAudio DL"},
> +};
> +
> +/* dai ops */
> +static int mtk_dai_hostless_startup(struct snd_pcm_substream *substream,
> +				    struct snd_soc_dai *dai)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	int ret;
> +
> +	snd_soc_set_runtime_hwparams(substream, &mt8186_hostless_hardware);
> +
> +	ret = snd_pcm_hw_constraint_integer(runtime,
> +					    SNDRV_PCM_HW_PARAM_PERIODS);
> +	if (ret < 0)
> +		dev_info(afe->dev, "snd_pcm_hw_constraint_integer failed\n");

	if (ret < 0) {
		dev_err(afe->dev, "setting constraints failed: %d\n", ret);
		return ret;
	}

	return 0;


Thanks,
Angelo


