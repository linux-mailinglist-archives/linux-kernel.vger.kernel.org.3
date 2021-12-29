Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FBC481077
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 07:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbhL2GhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 01:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhL2GhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 01:37:00 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2747C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 22:37:00 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id h1so11991820pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 22:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p7zVEyegDmuj+6n30KCO1S5If0BRlYsdYfkjtOazVTk=;
        b=US3E/hqHlmnyPzOy/HskFnqIw6YITYtB3SecYzBz/TvRFRiaQ5DNALRLAG1KPwoX4J
         sdBQ2c6Fm0s8nGLH1iLRLu6FUqFDXjmD5E5kgs1rUOuHC+aCdtwY5dqh2Ev41kZOMVMb
         JT/44yXGfpcDJ/kOLKnYQIqs7HAjYlSLDIVP98i5KxF2HWCRbPPlFuiGAGcRbPQoTNpq
         pKVNacwTs8+fmivZ1QHilorH76JfKWLYlHAR+j1FcZCE4uG8HNOHvJyki9/G9qHZ9doc
         w3+mIdcw/VCRHpkDbNyJyPBV0iBAIkpoMwfbDuFPZgJmId3BIzA0/bGe1/XouW9QehRg
         3+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p7zVEyegDmuj+6n30KCO1S5If0BRlYsdYfkjtOazVTk=;
        b=ucgE7GyRBWgj83SwEyo7vjdHjTNgwusW9J3/zb56QyLFSfN+AlmOudyOhVPD5PCwzM
         0jJQMJ3Zqw6XxRnGAvLzwOKZMcaoB+pGGIs/cS5R4nGAsfQxGmDGnVNxpQtvPCZUumav
         5sK8HKKe4brjVJM06dyDoOsh2/URZDFSGXXLVtIh7kUlzFA5pi4C9SE9UATiUq4rk2rm
         w9xv9HI1ZhJfdMEp0FTC0arWMqF1qR8EYE9rnDVBVhulCD76T/LsDhiLrId7UqLnzR8M
         6KAc7W56H1xmnY04XiHPa7P3LrTGbevYZyfXUynbrNLePX6tgqTfzoBy4EpAlLGs9QBd
         9Q9g==
X-Gm-Message-State: AOAM53077SNyhGUL55E4Ccx/VRbMhWJze+O4q3a6ht5AIUamkvFAZy0P
        V4QB3HQzlD4dB3yUU1ycOoT09A==
X-Google-Smtp-Source: ABdhPJzbQgs3ZiPyG3g68c9CE72l8nXqFUBGdfo2PobHZ4oRqfWUj1AoQFmLtN/bznm5cjXVREY+kQ==
X-Received: by 2002:a17:902:6a82:b0:148:a2e7:fb5c with SMTP id n2-20020a1709026a8200b00148a2e7fb5cmr25308794plk.157.1640759819836;
        Tue, 28 Dec 2021 22:36:59 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:4dea:2b20:ea89:724b])
        by smtp.gmail.com with ESMTPSA id p37sm18097039pfh.97.2021.12.28.22.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 22:36:59 -0800 (PST)
Date:   Wed, 29 Dec 2021 14:36:54 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2, 05/12] media: mtk-vcodec: Call
 v4l2_m2m_set_dst_buffered() set capture buffer buffered
Message-ID: <YcwCBgw6ZjYwBLFf@google.com>
References: <20211228094146.20505-1-yunfei.dong@mediatek.com>
 <20211228094146.20505-6-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228094146.20505-6-yunfei.dong@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 05:41:39PM +0800, Yunfei Dong wrote:
> From: Yunfei Dong <yunfei.dong@mediatek.corp-partner.google.com>

Same as 4th patch.  Please fix it.

> For lat and core architecture, just need to get output buffer for lat
> decode. For core hardware need to get lat's message and capture buffer.
> In order to let lat and core decode in parallel, need to set capture
> buffer buffered.

I think the description should be rephrased.

I may misunderstand but something like the template:
"""
OUTPUT -> lat -> core -> CAPTURE.  Lat and core can work in parallel.

Sets capture buffer buffered to ...
"""

> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c
> index 5aebf88f997b..23a154c4e321 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c
> @@ -314,6 +314,9 @@ static void mtk_init_vdec_params(struct mtk_vcodec_ctx *ctx)
>  	src_vq = v4l2_m2m_get_vq(ctx->m2m_ctx,
>  				 V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
>  
> +	if (ctx->dev->vdec_pdata->hw_arch != MTK_VDEC_PURE_SINGLE_CORE)
> +		v4l2_m2m_set_dst_buffered(ctx->m2m_ctx, 1);

s/1/true/ helps readability.
