Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C0849B907
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbiAYQn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1584373AbiAYQio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:38:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C79C061776
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:37:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E65CB818C4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58BDC36AE3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643128667;
        bh=0SbnCeCphRYqlsxXfeUWz/qWyG7bTyCBGzOjbuAH5Dc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kas93vxnomB9K/mg8TyNMZBdnWE9JvAlLbUL8hFQcRMAj7o3cLGdcgCkIbeB+jaKB
         go6AyfxNQshDfsuQs6d5ADtxp3NOI73ejOYZIRgI85jY/JZyPKo9WRXLnxft0LOBJb
         ioHbT13aDkONdbxaDyYFYOhtvGpnwCuSRfyljQvv1jUzo7uBIFsIEyG/NZVNPeNS5J
         cbhU9VJTHvFPxtqmNRqFReSnScVKgr6dNftPn2iunNDv8G3+AjZPaFeWs9VBOhetnS
         oiV6BkrB8p5KxHXfVl0gQiDnNud16x675MTAYaJ0FvuGcrxi9qDyza9R1PsCpLjHIw
         0nF0HVIiuENag==
Received: by mail-ej1-f52.google.com with SMTP id m4so31740746ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:37:47 -0800 (PST)
X-Gm-Message-State: AOAM533+/CCqMt2sPhpwQWidvoiDV5L7EZIGwAjqJlKcvsAKuBNZVh5w
        gQpnjXKXgPB/DW5glYWXiUiVEamwvjCgMShhbQ==
X-Google-Smtp-Source: ABdhPJxyyAYvHJMTL8SDODd9IBTgr3px6W8UcKYtqPJCptQLpuAelZlyNXECnWKkBdpovGOEJAhz1LMK0H+6WpZ6lAM=
X-Received: by 2002:a17:906:6c1:: with SMTP id v1mr16523116ejb.638.1643128666268;
 Tue, 25 Jan 2022 08:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20220118133759.112458-1-angelogioacchino.delregno@collabora.com> <20220118133759.112458-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220118133759.112458-2-angelogioacchino.delregno@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 26 Jan 2022 00:37:35 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9PTK1HoHruvX_6n010aADA5_Rd72TFTMsn4hrH8dts=A@mail.gmail.com>
Message-ID: <CAAOTY_9PTK1HoHruvX_6n010aADA5_Rd72TFTMsn4hrH8dts=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm: mediatek: mtk_drm_crtc: Use kmalloc in mtk_drm_crtc_duplicate_state
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, AngeloGioacchino:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2022=E5=B9=B41=E6=9C=8818=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:4=
1=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Optimize mtk_drm_crtc_duplicate_state() by switching from kzalloc() to
> kmalloc(): the only variable of this struct that gets checked in other
> functions is `pending_config`, but if that's set to false, then all of
> the remaining variables will only ever be set, but not read - so, also
> set `pending_config` to false.
> This saves us some small overhead.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index 09fc9ad02c7a..f536a0a927e4 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -185,7 +185,7 @@ static struct drm_crtc_state *mtk_drm_crtc_duplicate_=
state(struct drm_crtc *crtc
>  {
>         struct mtk_crtc_state *state;
>
> -       state =3D kzalloc(sizeof(*state), GFP_KERNEL);
> +       state =3D kmalloc(sizeof(*state), GFP_KERNEL);
>         if (!state)
>                 return NULL;
>
> @@ -193,6 +193,7 @@ static struct drm_crtc_state *mtk_drm_crtc_duplicate_=
state(struct drm_crtc *crtc
>
>         WARN_ON(state->base.crtc !=3D crtc);
>         state->base.crtc =3D crtc;
> +       state->pending_config =3D false;
>
>         return &state->base;
>  }
> --
> 2.33.1
>
