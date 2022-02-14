Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B874B5370
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355203AbiBNOgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:36:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355191AbiBNOgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:36:42 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCC5129
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:36:34 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id A7D7D1F43ABE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644849393;
        bh=wf2zalaLWrqugtdnfYQlVBuLQAqyoGaCbOOlATCb0jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SlZrULvrjsLlfdwVpA7hx9V7Rx7uDIEctf8kIovI/mrTeCkhQpi3v3M0r7xPiIf88
         Rx9MNAhdCyTF7hvvryM3MTBXzbC/2s1KnXlHc6i2K38hVEjgRVGocwuTuM2UYf8Djt
         dysTtfPYtvMyGcCQzUKrWTn/dMY61QNjj9UVIfr43DirOTrfh5WNUdK9teFwdN5CSG
         86Go8Ge6NMIuuCpVfUPP4FLSaDc5iuT+JLtmWum1Hwlt1dkIOOAwR7gWQiNCAm3y6x
         0zH3GsJqYcaWGGcUXI5koAtagt7c41iofN01svFYyRkwzoVH5Gd8uUzD0eMkZ1ZDBs
         /PVdQTHEBpi1g==
Date:   Mon, 14 Feb 2022 09:36:26 -0500
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, yongqiang.niu@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] soc: mediatek: mt8192-mmsys: Fix dither to dsi0 path's
 input sel
Message-ID: <Ygpo6rB+d9Qd8gY7@maud>
References: <20220128142056.359900-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128142056.359900-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In commit d687e056a18f ("soc: mediatek: mmsys: Add mt8192 mmsys routing table"),
> the mmsys routing table for mt8192 was introduced but the input selector
> for DITHER->DSI0 has no value assigned to it.
> 
> This means that we are clearing bit 0 instead of setting it, blocking
> communication between these two blocks; due to that, any display that
> is connected to DSI0 will not work, as no data will go through.
> The effect of that issue is that, during bootup, the DRM will block for
> some time, while atomically waiting for a vblank that never happens;
> later, the situation doesn't get better, leaving the display in a
> non-functional state.
> 
> To fix this issue, fix the route entry in the table by assigning the
> dither input selector to MT8192_DISP_DSI0_SEL_IN.
> 
> Fixes: d687e056a18f ("soc: mediatek: mmsys: Add mt8192 mmsys routing table")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/soc/mediatek/mt8192-mmsys.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mt8192-mmsys.h b/drivers/soc/mediatek/mt8192-mmsys.h
> index 6f0a57044a7b..6aae0b12b6ff 100644
> --- a/drivers/soc/mediatek/mt8192-mmsys.h
> +++ b/drivers/soc/mediatek/mt8192-mmsys.h
> @@ -53,7 +53,8 @@ static const struct mtk_mmsys_routes mmsys_mt8192_routing_table[] = {
>  		MT8192_AAL0_SEL_IN_CCORR0
>  	}, {
>  		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
> -		MT8192_DISP_DSI0_SEL_IN, MT8192_DSI0_SEL_IN_DITHER0
> +		MT8192_DISP_DSI0_SEL_IN, MT8192_DSI0_SEL_IN_DITHER0,
> +		MT8192_DSI0_SEL_IN_DITHER0
>  	}, {
>  		DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
>  		MT8192_DISP_RDMA0_SOUT_SEL, MT8192_RDMA0_SOUT_COLOR0,

Tested-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
