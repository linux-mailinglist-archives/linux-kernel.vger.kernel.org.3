Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2D6466DBF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 00:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349388AbhLBXc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 18:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhLBXc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 18:32:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEBEC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 15:29:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A2D2B82563
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 23:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3004AC56747
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 23:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638487740;
        bh=x9+AHUkQCOiqghjiOuxg43GrGaB2yXrjutnjOZ/BKZk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FB38vPcPhJtDAa7gwR7nCg9gVW4IOC4J9u+qm9uo/hDxAlVU+p780+uh2TnJVtymc
         YtNtt/fctp+SCzb5LulUvrJGDUuLHf1BfP1lVlWQAYfrHvvK5HZjnhxEH73Nxm3REg
         4uBQMaEtxHzF9A7YR6mLSWDdt1WM200z2CkXPT7KvPAWVCk5j3355A8/X7HspIdoug
         YNSP0gVU4oahjz+k6sTy4yXcenRX+gax5mJKtye9lv1WUYMaXcJQKJkD9qtEfR1fqw
         2RgmjZjNAXbc2TfZDrO+1lBC58BGEofVsJUfs5AstgogD/zevUo3fkx5F/dVlN2hEd
         2NJYQVfKG7wjQ==
Received: by mail-ed1-f48.google.com with SMTP id v1so4392841edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 15:29:00 -0800 (PST)
X-Gm-Message-State: AOAM5321Z5jJjwuFq+Aa9TLZMpRymsL7b7oYgIZhcHKiLbFM3bmt5Uhd
        7ZyZtf/IXvBajVnowCTQcHjFF2Sjs4bAXzxBfQ==
X-Google-Smtp-Source: ABdhPJzchGTC1yIIjWQs99ltF4+dCQ5spTXhXM3s94zaW+OhpNqLXMKcwrQubvNqWrkA5EisVV/cVqs7ewp8qqNCFKk=
X-Received: by 2002:a05:6402:1e93:: with SMTP id f19mr22106395edf.60.1638487738419;
 Thu, 02 Dec 2021 15:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20211202064039.20797-1-jason-jh.lin@mediatek.com> <20211202064039.20797-3-jason-jh.lin@mediatek.com>
In-Reply-To: <20211202064039.20797-3-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 3 Dec 2021 07:28:46 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8CYuLZbyPWyitVZkc_5C-63seevLP=gCMNkg_+rDJZdw@mail.gmail.com>
Message-ID: <CAAOTY_8CYuLZbyPWyitVZkc_5C-63seevLP=gCMNkg_+rDJZdw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/mediatek: add devlink to cmdq dev
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>, tzungbi@google.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fei Shao <fshao@chromium.org>,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B412=E6=9C=88=
2=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:41=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add devlink to cmdq to make sure the order of suspend and resume
> is correct.
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 43 ++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index 0b4012335e7a..612d1d69c16c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -60,6 +60,7 @@ struct mtk_drm_crtc {
>  #endif
>
>         struct device                   *mmsys_dev;
> +       struct device                   *drm_dev;
>         struct mtk_mutex                *mutex;
>         unsigned int                    ddp_comp_nr;
>         struct mtk_ddp_comp             **ddp_comp;
> @@ -159,6 +160,7 @@ static void mtk_drm_crtc_destroy(struct drm_crtc *crt=
c)
>         mtk_drm_cmdq_pkt_destroy(&mtk_crtc->cmdq_handle);
>
>         if (mtk_crtc->cmdq_client.chan) {
> +               device_link_remove(mtk_crtc->drm_dev, mtk_crtc->cmdq_clie=
nt.chan->mbox->dev);
>                 mbox_free_channel(mtk_crtc->cmdq_client.chan);
>                 mtk_crtc->cmdq_client.chan =3D NULL;
>         }
> @@ -902,6 +904,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>                 return -ENOMEM;
>
>         mtk_crtc->mmsys_dev =3D priv->mmsys_dev;
> +       mtk_crtc->drm_dev =3D priv->dev;
>         mtk_crtc->ddp_comp_nr =3D path_len;
>         mtk_crtc->ddp_comp =3D devm_kmalloc_array(dev, mtk_crtc->ddp_comp=
_nr,
>                                                 sizeof(*mtk_crtc->ddp_com=
p),
> @@ -969,6 +972,18 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>         }
>
>         if (mtk_crtc->cmdq_client.chan) {
> +               struct device_link *link;
> +
> +               /* add devlink to cmdq dev to make sure suspend/resume or=
der is correct */
> +               link =3D device_link_add(priv->dev, mtk_crtc->cmdq_client=
.chan->mbox->dev,
> +                                      DL_FLAG_PM_RUNTIME | DL_FLAG_STATE=
LESS);
> +               if (!link) {
> +                       dev_err(priv->dev, "Unable to link dev=3D%s\n",
> +                               dev_name(mtk_crtc->cmdq_client.chan->mbox=
->dev));
> +                       ret =3D -ENODEV;
> +                       goto cmdq_err;
> +               }
> +
>                 ret =3D of_property_read_u32_index(priv->mutex_node,
>                                                  "mediatek,gce-events",
>                                                  i,
> @@ -976,22 +991,26 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>                 if (ret) {
>                         dev_dbg(dev, "mtk_crtc %d failed to get mediatek,=
gce-events property\n",
>                                 drm_crtc_index(&mtk_crtc->base));
> -                       mbox_free_channel(mtk_crtc->cmdq_client.chan);
> -                       mtk_crtc->cmdq_client.chan =3D NULL;
> -               } else {
> -                       ret =3D mtk_drm_cmdq_pkt_create(&mtk_crtc->cmdq_c=
lient,
> -                                                     &mtk_crtc->cmdq_han=
dle,
> -                                                     PAGE_SIZE);
> -                       if (ret) {
> -                               dev_dbg(dev, "mtk_crtc %d failed to creat=
e cmdq packet\n",
> -                                       drm_crtc_index(&mtk_crtc->base));
> -                               mbox_free_channel(mtk_crtc->cmdq_client.c=
han);
> -                               mtk_crtc->cmdq_client.chan =3D NULL;
> -                       }
> +                       goto cmdq_err;
> +               }
> +
> +               ret =3D mtk_drm_cmdq_pkt_create(&mtk_crtc->cmdq_client,
> +                                             &mtk_crtc->cmdq_handle,
> +                                             PAGE_SIZE);
> +               if (ret) {
> +                       dev_dbg(dev, "mtk_crtc %d failed to create cmdq p=
acket\n",
> +                               drm_crtc_index(&mtk_crtc->base));
> +                       goto cmdq_err;
>                 }
>
>                 /* for sending blocking cmd in crtc disable */
>                 init_waitqueue_head(&mtk_crtc->cb_blocking_queue);
> +
> +cmdq_err:
> +               if (ret) {
> +                       mbox_free_channel(mtk_crtc->cmdq_client.chan);
> +                       mtk_crtc->cmdq_client.chan =3D NULL;
> +               }
>         }
>  #endif
>         return 0;
> --
> 2.18.0
>
