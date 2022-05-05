Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA1A51CC08
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386287AbiEEWYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiEEWY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:24:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D0A275CF;
        Thu,  5 May 2022 15:20:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 795391F40EB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651789245;
        bh=IqgWrsQ7M1kiyWJK+KEWncQxxmyl40O17cMv2BeJAZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WINl7o4+WequxxSytUZt4txWZtOiVzMn8Oe/yw0ywq6gSVx8l6UxrDz3v0PpGlt6h
         UDitxFADuW19fZXUk/LzhWjSZwChusaokfIOVdXRSsgUprvXqPj9+sN1EJwgxueAdc
         OukGQCfmhJINyB7ZUJpneAtEaNF4dvpH2QC+lL3rXrSsUBosL08zBz6cPUdHd8p4xd
         cT2/UstKbK9OqDqqMn0QtVP/CaD8SkagtmZzuD+Mb1LTLangCsE9DGEfHyxdj/TD2+
         5x5tU/6u3gd7b7E/O12Lbkbb8xJmSvT4QwhrRHN8g7lusGir0xHHUoKh6HMYy/9lO4
         kOrFUb8fajxWQ==
Date:   Thu, 5 May 2022 18:20:34 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v10, 16/17] media: mediatek: vcodec: support stateless
 VP9 decoding
Message-ID: <20220505222034.fxw6y7wdf7wy3qi4@notapiano>
References: <20220426100828.13429-1-yunfei.dong@mediatek.com>
 <20220426100828.13429-17-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220426100828.13429-17-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:08:27PM +0800, Yunfei Dong wrote:
> Add support for VP9 decoding using the stateless API,
> as supported by MT8192. And the drivers is lat and core architecture.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Signed-off-by: George Sun <george.sun@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../media/platform/mediatek/vcodec/Makefile   |    1 +
>  .../vcodec/mtk_vcodec_dec_stateless.c         |   26 +-
>  .../platform/mediatek/vcodec/mtk_vcodec_drv.h |    1 +
>  .../vcodec/vdec/vdec_vp9_req_lat_if.c         | 2031 +++++++++++++++++
>  .../platform/mediatek/vcodec/vdec_drv_if.c    |    4 +
>  .../platform/mediatek/vcodec/vdec_drv_if.h    |    1 +
>  6 files changed, 2061 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> 

...

> +		use_128 = !frame_is_intra && !vsi->frame.uh.last_frame_type;
> +		v4l2_vp9_adapt_coef_probs(pre_frame_ctx_helper,
> +					  counts_helper,
> +					  use_128,
> +					  frame_is_intra);

Hi Yunfei,

I'm getting

ERROR: modpost: "v4l2_vp9_adapt_noncoef_probs" [drivers/media/platform/mediatek/vcodec/mtk-vcodec-dec.ko] undefined!
ERROR: modpost: "v4l2_vp9_adapt_coef_probs" [drivers/media/platform/mediatek/vcodec/mtk-vcodec-dec.ko] undefined!

when building this series.

Adding
	select V4L2_VP9
to
	config VIDEO_MEDIATEK_VCODEC
solved the issue.

Thanks,
Nícolas
