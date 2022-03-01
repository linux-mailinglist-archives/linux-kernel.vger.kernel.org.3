Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35514C9977
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 00:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbiCAXmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 18:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiCAXmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 18:42:43 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B42140EF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 15:42:01 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id u11so24008263lju.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 15:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Je0uRp8727h1TTc3B25vlET4KVfYQCUUi3qPq6QSu/E=;
        b=Mxd3Ju/57STaqFSUcoUHdzkEQamJj8Rs9AVQLfo4UBtN/aEjfV5IoqwLoG8ytsuQJ7
         ir6gM8ycAelCJxTtCKwvyT1dvQxjxijkrqBZPqwyeTS4xaIsln9MhNWrmrkwjW0Txkdf
         UL/AX2mAZIYA5MmxmQmswds1EnKDAxrGAdipYhdFBagPN0kW6vjwwKfYBs9DVjLIohC2
         9sHxfWJE/ZOZe1wibzi0vN6RWPVJY0XBw7AkeB3ccqsGVX932JcE/cMN7XJ+faOwqFpQ
         MERaNl5eAk+8sExq1oTLy7dPZ7+rnAv7QIHCFoKwmw3LR/WJuzf7oFkWUYIaAW0Yf62T
         fNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Je0uRp8727h1TTc3B25vlET4KVfYQCUUi3qPq6QSu/E=;
        b=oi+iIXtEGRsawRhzryu8yfLylXp74lo2XsVwbGD7lPNNzaFnHExkFOKDj3MJcsWRcy
         w7NNJm/Wzj8sgZ6CwEYfWZnxQY2QQ9sU/zL6UUHpfZFRooGUVjZmMQ96YiUaiWFMo1L1
         cgsh8MDTmvyhzv49YroMq+Usvtgi0XFL4UA6pzgev3qB9XAZsbIUKIKwLipURqwivC88
         HQ6nzwRJa3SDdBvuQckfGW+x9VfvbwzWSvJBd8C/Le8ENIKb0k8+JD8lL21X437XJDfu
         +RwyDMZiXoUpfXd/cYhW6IEjcR82UffQVqxwjJqVp+xn0bSW6DjShULv+TwaAcWM0Nys
         zJ7w==
X-Gm-Message-State: AOAM5302El+OKvZSWOUqr7/rBolodlEHNM0MfsoB9CI5k0OrSZ532Qqo
        dO6NAjkp0LJ4/cfH3/GMJlyCgCFMqKPnSA7yDBw=
X-Google-Smtp-Source: ABdhPJyJlHbLYJEDb5Mbb7KgoOho3fUrxx1XNMxfJ/LarHcHy/dmpkhdkY1BYbV68w08GOXobHGfpV1ksL2ZmaL3tAA=
X-Received: by 2002:a05:651c:124d:b0:246:1a54:cc17 with SMTP id
 h13-20020a05651c124d00b002461a54cc17mr19022784ljh.301.1646178119102; Tue, 01
 Mar 2022 15:41:59 -0800 (PST)
MIME-Version: 1.0
References: <20220228181647.3794298-1-mwen@igalia.com> <9e288f3c-3251-f017-3541-d01ae6afe499@amd.com>
In-Reply-To: <9e288f3c-3251-f017-3541-d01ae6afe499@amd.com>
From:   Melissa Wen <melissa.srw@gmail.com>
Date:   Tue, 1 Mar 2022 22:41:47 -0100
Message-ID: <CAJeY4oE82RUc2mit-1Mnfr50pG4mGBqgnPQMGiHDAnsXXNSQDw@mail.gmail.com>
Subject: Re: [PATCH] drm/v3d: centralize error handling when init scheduler fails
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     Melissa Wen <mwen@igalia.com>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jiawei.Gu@amd.com,
        Christian Konig <christian.koenig@amd.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 8:21 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Acked-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>
> Andrey
Thanks. Applied to drm-misc-next.

Melissa
>
> On 2022-02-28 13:16, Melissa Wen wrote:
> > Remove redundant error message (since now it is very similar to what
> > we do in drm_sched_init) and centralize all error handling in a
> > unique place, as we follow the same steps in any case of failure.
> >
> > Signed-off-by: Melissa Wen <mwen@igalia.com>
> > ---
> >   drivers/gpu/drm/v3d/v3d_sched.c | 40 +++++++++++----------------------
> >   1 file changed, 13 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> > index 39459ae96f30..06238e6d7f5c 100644
> > --- a/drivers/gpu/drm/v3d/v3d_sched.c
> > +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> > @@ -392,34 +392,24 @@ v3d_sched_init(struct v3d_dev *v3d)
> >                            hw_jobs_limit, job_hang_limit,
> >                            msecs_to_jiffies(hang_limit_ms), NULL,
> >                            NULL, "v3d_bin", v3d->drm.dev);
> > -     if (ret) {
> > -             dev_err(v3d->drm.dev, "Failed to create bin scheduler: %d.", ret);
> > +     if (ret)
> >               return ret;
> > -     }
> >
> >       ret = drm_sched_init(&v3d->queue[V3D_RENDER].sched,
> >                            &v3d_render_sched_ops,
> >                            hw_jobs_limit, job_hang_limit,
> >                            msecs_to_jiffies(hang_limit_ms), NULL,
> >                            NULL, "v3d_render", v3d->drm.dev);
> > -     if (ret) {
> > -             dev_err(v3d->drm.dev, "Failed to create render scheduler: %d.",
> > -                     ret);
> > -             v3d_sched_fini(v3d);
> > -             return ret;
> > -     }
> > +     if (ret)
> > +             goto fail;
> >
> >       ret = drm_sched_init(&v3d->queue[V3D_TFU].sched,
> >                            &v3d_tfu_sched_ops,
> >                            hw_jobs_limit, job_hang_limit,
> >                            msecs_to_jiffies(hang_limit_ms), NULL,
> >                            NULL, "v3d_tfu", v3d->drm.dev);
> > -     if (ret) {
> > -             dev_err(v3d->drm.dev, "Failed to create TFU scheduler: %d.",
> > -                     ret);
> > -             v3d_sched_fini(v3d);
> > -             return ret;
> > -     }
> > +     if (ret)
> > +             goto fail;
> >
> >       if (v3d_has_csd(v3d)) {
> >               ret = drm_sched_init(&v3d->queue[V3D_CSD].sched,
> > @@ -427,27 +417,23 @@ v3d_sched_init(struct v3d_dev *v3d)
> >                                    hw_jobs_limit, job_hang_limit,
> >                                    msecs_to_jiffies(hang_limit_ms), NULL,
> >                                    NULL, "v3d_csd", v3d->drm.dev);
> > -             if (ret) {
> > -                     dev_err(v3d->drm.dev, "Failed to create CSD scheduler: %d.",
> > -                             ret);
> > -                     v3d_sched_fini(v3d);
> > -                     return ret;
> > -             }
> > +             if (ret)
> > +                     goto fail;
> >
> >               ret = drm_sched_init(&v3d->queue[V3D_CACHE_CLEAN].sched,
> >                                    &v3d_cache_clean_sched_ops,
> >                                    hw_jobs_limit, job_hang_limit,
> >                                    msecs_to_jiffies(hang_limit_ms), NULL,
> >                                    NULL, "v3d_cache_clean", v3d->drm.dev);
> > -             if (ret) {
> > -                     dev_err(v3d->drm.dev, "Failed to create CACHE_CLEAN scheduler: %d.",
> > -                             ret);
> > -                     v3d_sched_fini(v3d);
> > -                     return ret;
> > -             }
> > +             if (ret)
> > +                     goto fail;
> >       }
> >
> >       return 0;
> > +
> > +fail:
> > +     v3d_sched_fini(v3d);
> > +     return ret;
> >   }
> >
> >   void
