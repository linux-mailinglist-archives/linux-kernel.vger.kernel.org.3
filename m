Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F10750281C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352200AbiDOKV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352189AbiDOKVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:21:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6899FBB090;
        Fri, 15 Apr 2022 03:18:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 36DC41F47D6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650017933;
        bh=7VVEclTxMCm4KiyIwNVph4lsHbE022T2X31UOnYwr0g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kZgoHNYbBgXd0vEWlo7ZDDNGW3+nC1Qn/Dk31ndJgkwkJSXOWKZ3nq+sG2uzcB1m0
         FEWUQONrT5TQFYgnVHimMpzf/K7wUEZ3ZUIeubKqQdmDnVr2bJYGgeqmpsL4adJ+qP
         diFXWw+fvZFLpHckXrQjyH5st0q6C4jbUR928w1IIWgM+u5y6rqB7V+sYwU9llL6bG
         FmH1FI7Ww5epaoh+b47Haizza2x6YVNbg9HcPxodL4iTqE5FrqSx7WWqjK0F/rs/2y
         twjhqcX7U1324hmBYUglBH3wH1f/PiDpcpfVcsWpcCqNh4Y0kYrLBPM16zr1OIqXwb
         Ylg83v8ZVDCxw==
Message-ID: <8dc9928b-3e8c-bfcc-8424-ab577c97eb03@collabora.com>
Date:   Fri, 15 Apr 2022 12:18:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v19 07/10] drm/mediatek: add mediatek-drm of vdosys0
 support for mt8195
Content-Language: en-US
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     CK Hu <ck.hu@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220415083911.5186-1-jason-jh.lin@mediatek.com>
 <20220415083911.5186-8-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220415083911.5186-8-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/04/22 10:39, jason-jh.lin ha scritto:
> 1. Add driver data of mt8195 vdosys0 to mediatek-drm and the sub driver.
> 2. Add get driver data function to identify which vdosys by io_start.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_disp_rdma.c |   6 +
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c   | 141 +++++++++++++++++++++--
>   drivers/gpu/drm/mediatek/mtk_drm_drv.h   |   6 +
>   3 files changed, 145 insertions(+), 8 deletions(-)
> 

..snip..

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index a58cebd01d35..e1a37ca091f3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -21,6 +21,7 @@ struct drm_property;
>   struct regmap;
>   
>   struct mtk_mmsys_driver_data {
> +	const unsigned int io_start;

As mentioned in patch 03/10, this has to be

	const resource_size_t io_start;

Thanks!

