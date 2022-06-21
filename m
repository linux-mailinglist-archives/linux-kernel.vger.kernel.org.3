Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1892553467
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351342AbiFUOUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351268AbiFUOUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:20:33 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526E422529
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:20:32 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id q4so8449307qvq.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=UOS/5sDSVRe9xVqmGwkJ+5vo/Q8jcVNLwgNXYg2yOQs=;
        b=emm3jY9/JB9YVRuSwlSR8EcjujcyeZKFNlGFlog4esm4Si4/kvzFI1gJg63VkiPZhB
         j1MD+u4stqQGd14DMP+5dGamJdmbnT8IRhcJlTCGmLO4gEe4gE75g1qpPvYU4xE0DjLK
         X9o58/A+0Okx+crl4PLFuhdJWbAoMYgot+WskVbop1eKghHgpf60Ivw0AytMdCkJuzu+
         Z7ygkU1RWLYv/BsTwh/Hbex0EJNa0nBsSvQXwEWbMPCjea7gy3fLmHChFTvdaQJSIWKT
         cG9xaN+pvF3AH3SdCd2MEjhqwzb8q0MQGx+4aZ+zT+fnkZXfOSqfBqtCr7P6DBBdaFRT
         6jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=UOS/5sDSVRe9xVqmGwkJ+5vo/Q8jcVNLwgNXYg2yOQs=;
        b=cDJie3x5yeuPayeY5bEGyHHiFdY/u40/F13kwcFf6zMaf2JNMiyusZKQQfr0DgWHS/
         /1cYYLTBpn2bznF8Clb/eYlhE59DrdTWQuuk6uecZCMfb1Cv+fld4uYrdXn/OGcmjn8+
         rOm80L3DGbHLmQCEwisydlPV805SQ5KCsnm3R7TnmSoLz0iHYSP7SUw9rM1nsGCdMvSD
         /U1945vscxmNIyyR24N0nD15d/IKOXvHsN1K9+nkFyPyjR2331nh4zyRfDwCPWppoRlr
         LRC5b9aLZtsI11ZAcOhwVUDAEsGI/2Ip+2n6/vFBRgqTx8P9m8yyIS2eohfZcJfmA4TY
         T3lg==
X-Gm-Message-State: AJIora9amN1C/A155IGGvKR72UVfjPehK9WCAygIITu4yVoRavDjsWAS
        ZJRQh6CbxyEtc8ZWElDEl/Ciow==
X-Google-Smtp-Source: AGRyM1unod+k/GpXpVkEZFF0eq7NoRNvCJhHEKKaSOn4oEAAdqMDidqv29b7ax0pQkDjCORmBmQDAg==
X-Received: by 2002:ad4:5c8d:0:b0:470:4649:e3c9 with SMTP id o13-20020ad45c8d000000b004704649e3c9mr6914682qvh.43.1655821230749;
        Tue, 21 Jun 2022 07:20:30 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id d84-20020a376857000000b006a77e6df09asm13286497qkc.24.2022.06.21.07.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 07:20:30 -0700 (PDT)
Message-ID: <320bf3dd2bef0afec794d610b446d0085dcfe362.camel@ndufresne.ca>
Subject: Re: [PATCH] media: mediatek: vcodec: Initialize decoder parameters
 after getting dec_capability
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     George Sun <george.sun@mediatek.com>,
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
Date:   Tue, 21 Jun 2022 10:20:28 -0400
In-Reply-To: <20220618072929.28783-1-yunfei.dong@mediatek.com>
References: <20220618072929.28783-1-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunfei,

Le samedi 18 juin 2022 =C3=A0 15:29 +0800, Yunfei Dong a =C3=A9crit=C2=A0:
> Need to get dec_capability from scp first, then initialize decoder
> supported format and other parameters according to dec_capability value.

Perhaps something to improve in the future. On top of describing the fix, i=
t
could be useful to describe what issues is being fixed, and which platform =
will
benefit.

>=20
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

To add to this, this looks like a bug fix, can you relate it to an original
commit and add a Fixes: tag here ?

regards,
Nicolas

> ---
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c     | 2 --
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/dr=
ivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> index 1465ddff1c6b..41589470da32 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> @@ -112,8 +112,6 @@ void mtk_vcodec_dec_set_default_params(struct mtk_vco=
dec_ctx *ctx)
>  {
>  	struct mtk_q_data *q_data;
> =20
> -	ctx->dev->vdec_pdata->init_vdec_params(ctx);
> -
>  	ctx->m2m_ctx->q_lock =3D &ctx->dev->dev_mutex;
>  	ctx->fh.m2m_ctx =3D ctx->m2m_ctx;
>  	ctx->fh.ctrl_handler =3D &ctx->ctrl_hdl;
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c =
b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> index 4103d7c1b638..99d7b15f2b9d 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> @@ -208,6 +208,8 @@ static int fops_vcodec_open(struct file *file)
> =20
>  		dev->dec_capability =3D
>  			mtk_vcodec_fw_get_vdec_capa(dev->fw_handler);
> +		ctx->dev->vdec_pdata->init_vdec_params(ctx);
> +
>  		mtk_v4l2_debug(0, "decoder capability %x", dev->dec_capability);
>  	}
> =20

