Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B311B518423
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiECMXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiECMXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:23:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD3D37ABC;
        Tue,  3 May 2022 05:19:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8D50F1F440F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651580367;
        bh=7dmHQ4KerR5qmz8szAHhl2RdSUpC3IqMde/web4SJVI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oLDe2oHiRbT3NMQHsqrGQgkM2j77gKaebdcIESyJ/PQhseVGHXB4mY9UB/4UBsWv4
         8+abIYy7l0uvL4bcAAPg5TmyFkNfAIYMOy1/EUnkY6HrsuXb+J4k8UrCiavBaPZOva
         tbqKdR3n1N3hN3xzZAi6/Wyk4FOxSYgvr7jMzbcB06NbgP/2q9jXHUyoyO9HG6aqbw
         jVBxXJXa5+oPiYw9N+r2SfEcgHV+jQx5QA2V3pFyZAKyUjzXy/M/iB90kE0Gz1L08n
         fYAreCLdIPP7aqo5Nw1Qj4vUkWv1DkpHytOhb23qoypyPBP5t9o8b9XWOIpb1Mty26
         oc7sbOVhGOeIg==
Message-ID: <c6be6d95-35f0-fb62-2d10-53f974ba67e4@collabora.com>
Date:   Tue, 3 May 2022 14:19:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v19 06/25] soc: mediatek: add mtk_mmsys_write_reg API
Content-Language: en-US
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, llvm@lists.linux.dev,
        singo.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220503102345.22817-1-nancy.lin@mediatek.com>
 <20220503102345.22817-7-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220503102345.22817-7-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/05/22 12:23, Nancy.Lin ha scritto:
> Add mtk_mmsys_write_reg API. Simplify code for writing mmsys reg.
> It is a preparation for adding support for mmsys config API.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-mmsys.c | 35 ++++++++++++++------------------
>   1 file changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index ab3c5cbb0175..3e2e5e3f721d 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -191,22 +191,26 @@ static int mtk_mmsys_find_match_drvdata(struct mtk_mmsys *mmsys,
>   	return -EINVAL;
>   }
>   
> +static void mtk_mmsys_write_reg(struct mtk_mmsys *mmsys, u32 offset, u32 mask, u32 val)
> +{
> +	u32 tmp;
> +
> +	tmp = readl_relaxed(mmsys->regs + offset);
> +	tmp = (tmp & ~mask) | val;
> +	writel_relaxed(tmp, mmsys->regs + offset);
> +}
> +

Uhm... this is the equivalent of regmap_update_bits(): I fear that calling this
mtk_mmsys_write_reg() may lead to confusion.

I think that a more appropriate name would be mtk_mmsys_update_bits() or
something similar, recalling that this is not just a register write, but
a RMW.

Regards,
Angelo
