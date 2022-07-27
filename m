Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688B658235C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiG0Jky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiG0Jku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:40:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD729402C1;
        Wed, 27 Jul 2022 02:40:49 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 10CA36601B25;
        Wed, 27 Jul 2022 10:40:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658914848;
        bh=/tSZBVIuOPVrLZ+Pv9GixCN2b9o+Bbox7JHQmveYKn8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CnEUNxM6sH6Za9eS1dGCEiIZSFE/trQz92dIdRmswdczzZpDwPMWmdd82JkLXKQg9
         d8f1SHZUhha6hjj+c8J9uN97ZVzKs4nxdHNhIfA3m0lDqb1FCpKhADcsO5NK0zWFqE
         Ko2FK6RAi31qvCOZ7keaareHRzTGqP/+Pl/Lk6SSvCbeFplKoNWh1D9auuQ0IFBWnw
         OldnTeHWmkfh0MEk6WaS3oPRH4rtP8ev+uvGXd/6kBXOgMVku/rSKQVZTW0TGa8hKd
         TWI3y1DXPAjxBmzAeVhPfHXyC2Er4retswk8r2bkOWDG9bVQ+i3WSAw42Wk5oFy+Mm
         g/BZP4RD41UkA==
Message-ID: <ce46e9b2-8e34-b6cd-d802-35b3ae66e02d@collabora.com>
Date:   Wed, 27 Jul 2022 11:40:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v15 07/11] drm/mediatek: Add retry to prevent misjudgment
 for sink devices
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com, deller@gmx.de,
        airlied@linux.ie
Cc:     msp@baylibre.com, granquet@baylibre.com, jitao.shi@mediatek.com,
        wenst@chromium.org, ck.hu@mediatek.com, liangxu.xu@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fbdev@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220727045035.32225-1-rex-bc.chen@mediatek.com>
 <20220727045035.32225-8-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220727045035.32225-8-rex-bc.chen@mediatek.com>
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

Il 27/07/22 06:50, Bo-Chen Chen ha scritto:
> For some DP dungles, we need to train more than onece to confirm that we
> don't misjudge the status of sink device.

Please fix the typos in your commit title and description.
title: misjudgment -> misjudgement
desc: dungles->dongles; onece->once

> 
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_dp.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
> index ce817cb59445..80d7d6488105 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -42,6 +42,7 @@
>   #define MTK_DP_CHECK_SINK_CAP_TIMEOUT_COUNT 3
>   #define MTK_DP_TBC_BUF_READ_START_ADDR 0x08
>   #define MTK_DP_TRAIN_DOWNSCALE_RETRY 8
> +#define MTK_DP_TRAIN_CLEAR_RETRY 50
>   
>   struct mtk_dp_train_info {
>   	bool tps3;
> @@ -1431,11 +1432,25 @@ static int mtk_dp_video_config(struct mtk_dp *mtk_dp)
>   
>   static int mtk_dp_training(struct mtk_dp *mtk_dp)
>   {
> +	short max_retry = MTK_DP_TRAIN_CLEAR_RETRY;
>   	int ret;
>   
> -	ret = mtk_dp_train_start(mtk_dp);
> -	if (ret)
> -		return ret;
> +	/*
> +	 * We do retry to confirm that we don't misjudge the sink status.
> +	 * If it is still failed, we can confirm there are some issues for the
> +	 * sink device.
> +	 */
> +	do {
> +		ret = mtk_dp_train_start(mtk_dp);
> +		if (!ret)
> +			break;
> +	} while (--max_retry);
> +
> +	dev_info(mtk_dp->dev, "dp training clear retry times: %d\n",
> +		 MTK_DP_TRAIN_CLEAR_RETRY - max_retry);

dev_dbg() here.

...after which,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> +
> +	if (!max_retry)
> +		return -ETIMEDOUT;
>   
>   	ret = mtk_dp_video_config(mtk_dp);
>   	if (ret)

