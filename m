Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABEE4C5927
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 04:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiB0Dhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 22:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiB0Dho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 22:37:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E93220103
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 19:37:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B213B61029
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 03:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12738C340F3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 03:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645933026;
        bh=PcKncsTOVzlSqaOg7J5qb4pFWYVIbkyTx7Eltn3KWR0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WybKmEHDro4Do1Ozl/xx4voKJbqhoFCAc8+xjBbBcGKQcilCt0xu67G0PgJm8v3RB
         rGLFwxZnOy0QBnLMVXM6TCBEMct5kY2HpnHCfPqlhEaYVAqUxl/0YXhDDd5F+BiunZ
         4FLFs/MAeaOA1XjvAEhjpr+hhJw11dpuCKFAJuPHmTLAw+YiW3H1wdf9mPQ5CH00lo
         fM+9TaOj9KebXMl6INzuCdbMGQv1Qn8BhRZQ9pMhSGkVMcSKOpcNJMigTpmwA5R0UZ
         2eKujb/Vod6QEkHNV9m4cjqV/TI0wSP9oXfk41stvUqkcAWL/+lt4tpswaQHL4cG18
         1U2tRTfscpVvA==
Received: by mail-ej1-f45.google.com with SMTP id a8so18349755ejc.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 19:37:05 -0800 (PST)
X-Gm-Message-State: AOAM5307+cP9H1LaxOUNpzT4ULplecKFs80zvJTd+CaCPuhKdK3MTcan
        EH8EYK5BgARVveu2EZRr8ZLG+u3SXnQ0mgAYvw==
X-Google-Smtp-Source: ABdhPJwFCc00VQOE4B7U57r4RYqycpEQSjTSjBORZsH9Zn55axO5yG7y/xWDdPTKBdIgR1yvQeRdCNTWl4N4jKNihUI=
X-Received: by 2002:a17:907:a06c:b0:6c9:408e:cec with SMTP id
 ia12-20020a170907a06c00b006c9408e0cecmr10813480ejc.510.1645933024264; Sat, 26
 Feb 2022 19:37:04 -0800 (PST)
MIME-Version: 1.0
References: <20211202064039.20797-1-jason-jh.lin@mediatek.com>
 <20211202064039.20797-2-jason-jh.lin@mediatek.com> <CAAOTY_-59wtqprA+fRc6dvQRoVLr7HiNktYgvvt9pi_=CcYrYA@mail.gmail.com>
In-Reply-To: <CAAOTY_-59wtqprA+fRc6dvQRoVLr7HiNktYgvvt9pi_=CcYrYA@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 27 Feb 2022 11:36:52 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9pPtvKSZ0HWHAQZ3o-TE3p67tTKOpNa7Rz_XYG-yDQJA@mail.gmail.com>
Message-ID: <CAAOTY_9pPtvKSZ0HWHAQZ3o-TE3p67tTKOpNa7Rz_XYG-yDQJA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drm/mediatek: add wait_for_event for crtc disable
 by cmdq
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi, Jason:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B412=E6=9C=883=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=887:21=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi, Jason:
>
> jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B412=E6=9C=
=882=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:41=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > mtk_drm_crtc_atomic_disable will send an async cmd to cmdq driver,
> > so it may not finish when cmdq_suspend is called sometimes.
> >
> > Add wait_for_event after sending async disable plane cmd to make
> > sure the lastest cmd is done before cmdq_suspend.
>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Applied to mediatek-drm-next[1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang

>
> >
> > Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/=
mediatek/mtk_drm_crtc.c
> > index 62529a954b62..0b4012335e7a 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -56,6 +56,7 @@ struct mtk_drm_crtc {
> >         struct cmdq_pkt                 cmdq_handle;
> >         u32                             cmdq_event;
> >         u32                             cmdq_vblank_cnt;
> > +       wait_queue_head_t               cb_blocking_queue;
> >  #endif
> >
> >         struct device                   *mmsys_dev;
> > @@ -314,6 +315,7 @@ static void ddp_cmdq_cb(struct mbox_client *cl, voi=
d *mssg)
> >         }
> >
> >         mtk_crtc->cmdq_vblank_cnt =3D 0;
> > +       wake_up(&mtk_crtc->cb_blocking_queue);
> >  }
> >  #endif
> >
> > @@ -700,6 +702,13 @@ static void mtk_drm_crtc_atomic_disable(struct drm=
_crtc *crtc,
> >         mtk_crtc->pending_planes =3D true;
> >
> >         mtk_drm_crtc_update_config(mtk_crtc, false);
> > +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> > +       /* Wait for planes to be disabled by cmdq */
> > +       if (mtk_crtc->cmdq_client.chan)
> > +               wait_event_timeout(mtk_crtc->cb_blocking_queue,
> > +                                  mtk_crtc->cmdq_vblank_cnt =3D=3D 0,
> > +                                  msecs_to_jiffies(500));
> > +#endif
> >         /* Wait for planes to be disabled */
> >         drm_crtc_wait_one_vblank(crtc);
> >
> > @@ -980,6 +989,9 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
> >                                 mtk_crtc->cmdq_client.chan =3D NULL;
> >                         }
> >                 }
> > +
> > +               /* for sending blocking cmd in crtc disable */
> > +               init_waitqueue_head(&mtk_crtc->cb_blocking_queue);
> >         }
> >  #endif
> >         return 0;
> > --
> > 2.18.0
> >
