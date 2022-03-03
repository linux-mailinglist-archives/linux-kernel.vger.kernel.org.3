Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0924CB773
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiCCHHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiCCHHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:07:22 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86077D1083
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 23:06:37 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id jr3so3426587qvb.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 23:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8HcPSO5J8NY98uQ2bWJs7uIQP8jHLYwpTbsEfnFQ6Kc=;
        b=gTke+FKomJbgtcblPcwsyJWe1O1L6dpL9xC4RB6BmIQnJe61/Dn8IPPfiaiEFr3pzf
         cwte0nVrO20l0utome+glbq+FWdU8ecw/C9Y7YDd4Wkdq9iKIGbFinT2OC/yS8LFpBu9
         7L/5SFrcap2IzLDmsBnp4TI+7PXWQM34ZWKhdG/ZPSdSyJLh/cGYduiAwJG8qtjSIPyk
         Ur3JoeO5XqWfcJbtg6nqKuuahdnRmHZZPuPcPeQl/MYyuK66DakMDDQMVcvmxbPUOpL8
         ToNc5/wke8v8P7RhoZym3z027YVlaIZIb+Rf3qNOZPX2zKW66lgI8mxh+SI1XK4NXyqZ
         0qWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8HcPSO5J8NY98uQ2bWJs7uIQP8jHLYwpTbsEfnFQ6Kc=;
        b=V0xMEz04F9be/kfovPCkq2fFIkYrLg86nQ35udtaCRuBCl8fPZnfljQGQDoPYZGVqO
         VadaUbaPrvKTSBU1bHZ3iGs405K9HDGSO7mEBgULYKNqy7jruGZ9SVkPpUVzsBdT9SSd
         91Z2THWCOYDUpkX3YqzCKSR1tssjFxy1E0shjTq0JChaE35i7Uq1JYk20vUEjaHJ3yQv
         UqV0eXGpqsNtcrM7Iv08cHZvznivswwHVCqWf/Dw6cGZsnHdSrCQGYf0g0Z+jsNbffqJ
         /8iZij7vYYEOouLSuYpZcfvtL/2czwvilCF4sZVq2WLzJr3aSRggEDdfIsJmdZl4qJhV
         ILRA==
X-Gm-Message-State: AOAM530bn7HZVv5MYKTErGy23gqRu/Oi9b1mJ+QG18pL/x6zzwcCICkC
        vFqRSuyhtvjaRqaZnl84s8i3Q7N68c06NsqzJYHgpQ==
X-Google-Smtp-Source: ABdhPJxgEHrGjaehZwVCMpI1VHaONVhbr10R7pT9rBRPyCyU3TXHNAzER80GICpogrsLdSBT1uwAn0te9XkwhuBPnWU=
X-Received: by 2002:ad4:5883:0:b0:432:b007:962b with SMTP id
 dz3-20020ad45883000000b00432b007962bmr22084284qvb.55.1646291196714; Wed, 02
 Mar 2022 23:06:36 -0800 (PST)
MIME-Version: 1.0
References: <20220219183310.557435-1-robdclark@gmail.com> <6f1225ea-d889-9cf8-3a3d-181e319bd453@linaro.org>
 <CAF6AEGut-75ri+U=B2eBtNeYQu5ECKPmk51b2_pCgu91uKy1ow@mail.gmail.com>
In-Reply-To: <CAF6AEGut-75ri+U=B2eBtNeYQu5ECKPmk51b2_pCgu91uKy1ow@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 3 Mar 2022 10:06:25 +0300
Message-ID: <CAA8EJpoAnPDefJ9rc6fjF+6oS5EVA7JCbZs7Ui7KDE+dfEbMEA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/gpu: Fix crash on devices without devfreq support
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 at 18:46, Rob Clark <robdclark@gmail.com> wrote:
>
> On Tue, Feb 22, 2022 at 7:11 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On 19/02/2022 21:33, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Avoid going down devfreq paths on devices where devfreq is not
> > > initialized.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >   drivers/gpu/drm/msm/msm_gpu_devfreq.c | 31 +++++++++++++++++++++------
> > >   1 file changed, 25 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> > > index 9bf319be11f6..26a3669a97b3 100644
> > > --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> > > +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> > > @@ -83,12 +83,17 @@ static struct devfreq_dev_profile msm_devfreq_profile = {
> > >   static void msm_devfreq_boost_work(struct kthread_work *work);
> > >   static void msm_devfreq_idle_work(struct kthread_work *work);
> > >
> > > +static bool has_devfreq(struct msm_gpu *gpu)
> > > +{
> > > +     return !!gpu->funcs->gpu_busy;
> >
> > I see that devfreq init will be skipped if gpu_busy is NULL.
> > Can we use gpu->devfreq instead of this condition?
>
> We could, but then we couldn't also use the same has_devfreq() helper
> in msm_devfreq_init().  I thought it was clearer to use the same
> helper everywhere.

Well... It is not clear at first glance how gpu_busy is related to
devfreq. On the other hand, if gpu->devfreq is NULL, it's obvious that
devfreq is not initialized.

I'd propose to use if (gpu->funcs->gpu_busy) to check if we can init
devfreq and after that to check (gpu->devfreq) as a way to know
whether the devfreq is available.

>
> > I noticed that you have replaced some of gpu->devfreq checks with
> > has_devreq() calls. Is there any difference?
>
> It amounts to the same thing because if you don't have gpu_busy, then
> devfreq is never initialized.  I just thought it clearer to use the
> same check in all places.

See my comment above.

>
> BR,
> -R
>
> > > +}
> > > +
> > >   void msm_devfreq_init(struct msm_gpu *gpu)
> > >   {
> > >       struct msm_gpu_devfreq *df = &gpu->devfreq;
> > >
> > >       /* We need target support to do devfreq */
> > > -     if (!gpu->funcs->gpu_busy)
> > > +     if (!has_devfreq(gpu))
> > >               return;
> > >
> > >       dev_pm_qos_add_request(&gpu->pdev->dev, &df->idle_freq,
> > > @@ -149,6 +154,9 @@ void msm_devfreq_cleanup(struct msm_gpu *gpu)
> > >   {
> > >       struct msm_gpu_devfreq *df = &gpu->devfreq;
> > >
> > > +     if (!has_devfreq(gpu))
> > > +             return;
> > > +
> > >       devfreq_cooling_unregister(gpu->cooling);
> > >       dev_pm_qos_remove_request(&df->boost_freq);
> > >       dev_pm_qos_remove_request(&df->idle_freq);
> > > @@ -156,16 +164,24 @@ void msm_devfreq_cleanup(struct msm_gpu *gpu)
> > >
> > >   void msm_devfreq_resume(struct msm_gpu *gpu)
> > >   {
> > > -     gpu->devfreq.busy_cycles = 0;
> > > -     gpu->devfreq.time = ktime_get();
> > > +     struct msm_gpu_devfreq *df = &gpu->devfreq;
> > >
> > > -     devfreq_resume_device(gpu->devfreq.devfreq);
> > > +     if (!has_devfreq(gpu))
> > > +             return;
> > > +
> > > +     df->busy_cycles = 0;
> > > +     df->time = ktime_get();
> > > +
> > > +     devfreq_resume_device(df->devfreq);
> > >   }
> > >
> > >   void msm_devfreq_suspend(struct msm_gpu *gpu)
> > >   {
> > >       struct msm_gpu_devfreq *df = &gpu->devfreq;
> > >
> > > +     if (!has_devfreq(gpu))
> > > +             return;
> > > +
> > >       devfreq_suspend_device(df->devfreq);
> > >
> > >       cancel_idle_work(df);
> > > @@ -185,6 +201,9 @@ void msm_devfreq_boost(struct msm_gpu *gpu, unsigned factor)
> > >       struct msm_gpu_devfreq *df = &gpu->devfreq;
> > >       uint64_t freq;
> > >
> > > +     if (!has_devfreq(gpu))
> > > +             return;
> > > +
> > >       freq = get_freq(gpu);
> > >       freq *= factor;
> > >
> > > @@ -207,7 +226,7 @@ void msm_devfreq_active(struct msm_gpu *gpu)
> > >       struct devfreq_dev_status status;
> > >       unsigned int idle_time;
> > >
> > > -     if (!df->devfreq)
> > > +     if (!has_devfreq(gpu))
> > >               return;
> > >
> > >       /*
> > > @@ -253,7 +272,7 @@ void msm_devfreq_idle(struct msm_gpu *gpu)
> > >   {
> > >       struct msm_gpu_devfreq *df = &gpu->devfreq;
> > >
> > > -     if (!df->devfreq)
> > > +     if (!has_devfreq(gpu))
> > >               return;
> > >
> > >       msm_hrtimer_queue_work(&df->idle_work, ms_to_ktime(1),
> >
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry
