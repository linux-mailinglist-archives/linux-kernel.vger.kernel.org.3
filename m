Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39C1466D9F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 00:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357831AbhLBXZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 18:25:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54126 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356451AbhLBXZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 18:25:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12ACA628B3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 23:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760DFC53FD2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 23:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638487303;
        bh=Z/jGQpnQw3oofLGE8VWrIcjp8qGhDD1OVv0BpGn7Qgg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mlYHgMKec+DhMMXhHU1g0cDORzZcX7nj5KqnMZNaNWmF7xi9pjFZI8yBQcpZxWMsb
         Qdu9Q7PoKtrtbtC9LoHmy3xeIRJL3TzzmcVBjv50y0oaGGF4OsgdNL0ursrUG6B1iq
         M8mz3RvBfsbvXbO3Uiv9fWxdzdFWJriWGq5K5mXhZsAqY6hFMNCmgcG9AdMcjImxGF
         rTmAy/kJrCgzg11ffalhjhrb1nyyFU4RoXSwBrC0CDfK13+vXVI5dYYX9PmTwq+R6h
         ctZsigXk/rBsRKreV/5bSdrX/IHQ+AiuCMx36pM0POjjMtMXVkoGzFjQrps9rh53zi
         YEgw1WQeuC+lw==
Received: by mail-ed1-f47.google.com with SMTP id l25so4107796eda.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 15:21:43 -0800 (PST)
X-Gm-Message-State: AOAM531nyyzlNepq8U3DCvYks+I3FG3+mXTmDHuQgfudGwebJlFiwMk8
        mZ9T/AJkhiNSAOfal94Y2r8GLMxfuHdfelSBqw==
X-Google-Smtp-Source: ABdhPJyFOGRgjggt/MCtPqpiPE8ypTDbLIj9hicoONLcDCjRcwAqVaW2ilRFZht6FsdbQPlGHYiK+3BWBezOz8iUxvs=
X-Received: by 2002:a05:6402:5110:: with SMTP id m16mr21955080edd.15.1638487301695;
 Thu, 02 Dec 2021 15:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20211202064039.20797-1-jason-jh.lin@mediatek.com> <20211202064039.20797-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20211202064039.20797-2-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 3 Dec 2021 07:21:30 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-59wtqprA+fRc6dvQRoVLr7HiNktYgvvt9pi_=CcYrYA@mail.gmail.com>
Message-ID: <CAAOTY_-59wtqprA+fRc6dvQRoVLr7HiNktYgvvt9pi_=CcYrYA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drm/mediatek: add wait_for_event for crtc disable
 by cmdq
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
> mtk_drm_crtc_atomic_disable will send an async cmd to cmdq driver,
> so it may not finish when cmdq_suspend is called sometimes.
>
> Add wait_for_event after sending async disable plane cmd to make
> sure the lastest cmd is done before cmdq_suspend.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index 62529a954b62..0b4012335e7a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -56,6 +56,7 @@ struct mtk_drm_crtc {
>         struct cmdq_pkt                 cmdq_handle;
>         u32                             cmdq_event;
>         u32                             cmdq_vblank_cnt;
> +       wait_queue_head_t               cb_blocking_queue;
>  #endif
>
>         struct device                   *mmsys_dev;
> @@ -314,6 +315,7 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void =
*mssg)
>         }
>
>         mtk_crtc->cmdq_vblank_cnt =3D 0;
> +       wake_up(&mtk_crtc->cb_blocking_queue);
>  }
>  #endif
>
> @@ -700,6 +702,13 @@ static void mtk_drm_crtc_atomic_disable(struct drm_c=
rtc *crtc,
>         mtk_crtc->pending_planes =3D true;
>
>         mtk_drm_crtc_update_config(mtk_crtc, false);
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +       /* Wait for planes to be disabled by cmdq */
> +       if (mtk_crtc->cmdq_client.chan)
> +               wait_event_timeout(mtk_crtc->cb_blocking_queue,
> +                                  mtk_crtc->cmdq_vblank_cnt =3D=3D 0,
> +                                  msecs_to_jiffies(500));
> +#endif
>         /* Wait for planes to be disabled */
>         drm_crtc_wait_one_vblank(crtc);
>
> @@ -980,6 +989,9 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>                                 mtk_crtc->cmdq_client.chan =3D NULL;
>                         }
>                 }
> +
> +               /* for sending blocking cmd in crtc disable */
> +               init_waitqueue_head(&mtk_crtc->cb_blocking_queue);
>         }
>  #endif
>         return 0;
> --
> 2.18.0
>
