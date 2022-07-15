Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FFD575D85
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiGOIaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiGOIaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:30:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4C73A49B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:30:10 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6A0B06601A3F;
        Fri, 15 Jul 2022 09:30:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657873809;
        bh=yV+EX0IUwg0zIL0JwslSh38WgL8nzrwNzm1NDjXhZVA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NPw6pWWqRz6rvL3VqqcHhHNCjH4Y9tl2A+101/CFbnBZn4lp3svR7iW7ikOlN8wJz
         4mZSeZKYmiWE1+KnbpNAMSC8l61ztZCbtZZ8b9uDvS2WYv3lFngFOyOjop+aagY6W9
         +hSlgDyJD2d51NXLFw8Ows4j0ogBE8OUsW3N8bj+ojVMugDVvB5+2fnBHZxjfebGXF
         Gyzvzv9lWns3jG8KgVnh81F7Mx3hc/lvoeOBLRRwUdLoS8+d4IzbfEW9xDa4A1qiW/
         h2GYz+eKljD3NXBEYXIkEojVqe0Bm6YnKi0PH9f0UMgOrQcGWD8hSmyOBtNeovWMqn
         3TRH7sDDZFj+g==
Message-ID: <b2dc196f-19d2-4d9a-4feb-ec335249aaad@collabora.com>
Date:   Fri, 15 Jul 2022 10:30:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: mediatek: mt8195: extract SOF common code
Content-Language: en-US
To:     Chunxu Li <chunxu.li@mediatek.com>, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     matthias.bgg@gmail.com, trevor.wu@mediatek.com, tzungbi@google.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220715034223.3897-1-chunxu.li@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220715034223.3897-1-chunxu.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/07/22 05:42, Chunxu Li ha scritto:
> The functions related to SOF can be reused in different machine drivers,
> such as mt8195 or mt8186, so extract the common code to avoid duplication.
> 
> Set mtk_soc_card_data which include machine private data and SOF private
> data as card drvdata, then the difference between machine private can be
> ignored such as mt8195_mt6359_priv or mt8186_mt6366_priv, at the same
> time the SOF related code can be reused in different machine drivers.
> 
> Signed-off-by: Chunxu Li <chunxu.li@mediatek.com>
> ---
>   sound/soc/mediatek/common/Makefile            |   2 +-
>   .../soc/mediatek/common/mtk-dsp-sof-common.c  | 196 +++++++++++++++
>   .../soc/mediatek/common/mtk-dsp-sof-common.h  |  35 +++
>   sound/soc/mediatek/common/mtk-soc-card.h      |  17 ++
>   sound/soc/mediatek/mt8195/mt8195-mt6359.c     | 233 ++++--------------
>   5 files changed, 300 insertions(+), 183 deletions(-)
>   create mode 100644 sound/soc/mediatek/common/mtk-dsp-sof-common.c
>   create mode 100644 sound/soc/mediatek/common/mtk-dsp-sof-common.h
>   create mode 100644 sound/soc/mediatek/common/mtk-soc-card.h
> 
> diff --git a/sound/soc/mediatek/common/Makefile b/sound/soc/mediatek/common/Makefile
> index acbe01e9e928..576deb7f8cce 100644
> --- a/sound/soc/mediatek/common/Makefile
> +++ b/sound/soc/mediatek/common/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   # platform driver
> -snd-soc-mtk-common-objs := mtk-afe-platform-driver.o mtk-afe-fe-dai.o
> +snd-soc-mtk-common-objs := mtk-afe-platform-driver.o mtk-afe-fe-dai.o mtk-dsp-sof-common.o
>   obj-$(CONFIG_SND_SOC_MEDIATEK) += snd-soc-mtk-common.o
>   
>   obj-$(CONFIG_SND_SOC_MTK_BTCVSD) += mtk-btcvsd.o
> diff --git a/sound/soc/mediatek/common/mtk-dsp-sof-common.c b/sound/soc/mediatek/common/mtk-dsp-sof-common.c
> new file mode 100644
> index 000000000000..1098694f4f36
> --- /dev/null
> +++ b/sound/soc/mediatek/common/mtk-dsp-sof-common.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mtk-dsp-sof-common.c  --  MediaTek dsp sof common ctrl
> + *
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Chunxu Li <chunxu.li@mediatek.com>
> + */
> +
> +#include <mtk-dsp-sof-common.h>
> +#include <mtk-soc-card.h>

Did you mean.....

#include "mtk-dsp-sof-common.h"
#include "mtk-soc-card.h"


> +
> +/* fixup the BE DAI link to match any values from topology */
> +int mtk_sof_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
> +			   struct snd_pcm_hw_params *params)
> +{

..snip..

> diff --git a/sound/soc/mediatek/common/mtk-dsp-sof-common.h b/sound/soc/mediatek/common/mtk-dsp-sof-common.h
> new file mode 100644
> index 000000000000..f02ba2ce3718
> --- /dev/null
> +++ b/sound/soc/mediatek/common/mtk-dsp-sof-common.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * mtk-dsp-sof-common.h  --  MediaTek dsp sof common definition
> + *
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Chunxu Li <chunxu.li@mediatek.com>
> + */
> +
> +#ifndef _MTK_DSP_SOF_COMMON_H_
> +#define _MTK_DSP_SOF_COMMON_H_
> +
> +#include <sound/soc.h>

Leave a blank line here.

> +struct sof_conn_stream {
> +	const char *normal_link;
> +	const char *sof_link;
> +	const char *sof_dma;
> +	int stream_dir;
> +};
> +

Thanks,
Angelo
