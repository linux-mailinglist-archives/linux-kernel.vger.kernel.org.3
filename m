Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A1C4C178F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbiBWPqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbiBWPqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:46:31 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5999C114B;
        Wed, 23 Feb 2022 07:46:03 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j22so14229181wrb.13;
        Wed, 23 Feb 2022 07:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSfHBOu4v5+uNUdMQr8U/N7yggvNFIAnsnuq86CDDN8=;
        b=fbSjZORrBhhHrOCnk7S6YM3Zgzp9jGKaOTrH8ZsFi5jfiwjUcFu0MuHrtjOPxu+gs7
         Y+mCisYdpElaLEUtLaAjsRd7peyj017FJk05vLUo8er05hHuNjVK1YKynFp4YRqwEUuR
         1fmvddyZjGTXvLzE0MGil9SQG/CYtr6b34brfpE+xAS5Vwuu17htp9yTLmD/crR2nLSM
         IiB8DsDCctlx0FzteoDu8FzHbhR7cAmK0HOEG11kRS10z8F/wzxEqlWWhHxFZeUQnvn1
         gDqTQ5DoJrtjLe94YeNpNhK+uTWC+VEdRrgNYVMGcP7vWXQz1SOtOZjVtGDTKJXn/C7Y
         O3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSfHBOu4v5+uNUdMQr8U/N7yggvNFIAnsnuq86CDDN8=;
        b=JAfwy/J3ryIOZoJ5u2bIm1m1b2oMdzJPdMcolJ+pDQrJkWOIO2KxDEYDIaia1fVuzy
         EijlZmktd2AZIE4/52wke2FoMujxv/rVdyokKkopkstZrvLFejdch/x43z7a9/X2V63h
         0YJDdpJFmIZ3PEk7ay5XIGSWAye+gbIYrHU/ZHzrH5XgI1P3AMhsAEp9ikkM5TJ9mN05
         AtM4DjY7fjTTlh1DRrZ1RGJYznl8rBAVUgCaq+466KRE6+RCZMGa33O/Q6jhH0RT+A6Y
         7oUZIcXreT+cD3KN2pOMB4Ql3+oKXNNURHnC0YKqBm3n9pe+wSpC0agjY/AGQswSjWcU
         kkoQ==
X-Gm-Message-State: AOAM530nDqd1T4aBqrEBwAH51LHxH56pFzxQQr7qU4XwjtleyhhV+00P
        3wKLhnIBlSQXR5kwgzZyZwu9coFmCUaPoaCQlZBuWMOeH8w=
X-Google-Smtp-Source: ABdhPJyosEjfWY4mjWeCmJhqIR2Tgf0/QybyKJGd2Qa9zYQaZY/M3wuO912/5weuamaNpFuLr3U9YbFz3d8lNVyzudc=
X-Received: by 2002:a05:6000:1a8b:b0:1ea:bc4:e52e with SMTP id
 f11-20020a0560001a8b00b001ea0bc4e52emr176951wry.574.1645631162104; Wed, 23
 Feb 2022 07:46:02 -0800 (PST)
MIME-Version: 1.0
References: <20220219183310.557435-1-robdclark@gmail.com> <6f1225ea-d889-9cf8-3a3d-181e319bd453@linaro.org>
In-Reply-To: <6f1225ea-d889-9cf8-3a3d-181e319bd453@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 23 Feb 2022 07:46:21 -0800
Message-ID: <CAF6AEGut-75ri+U=B2eBtNeYQu5ECKPmk51b2_pCgu91uKy1ow@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/gpu: Fix crash on devices without devfreq support
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 7:11 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 19/02/2022 21:33, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Avoid going down devfreq paths on devices where devfreq is not
> > initialized.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/msm_gpu_devfreq.c | 31 +++++++++++++++++++++------
> >   1 file changed, 25 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> > index 9bf319be11f6..26a3669a97b3 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> > +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> > @@ -83,12 +83,17 @@ static struct devfreq_dev_profile msm_devfreq_profile = {
> >   static void msm_devfreq_boost_work(struct kthread_work *work);
> >   static void msm_devfreq_idle_work(struct kthread_work *work);
> >
> > +static bool has_devfreq(struct msm_gpu *gpu)
> > +{
> > +     return !!gpu->funcs->gpu_busy;
>
> I see that devfreq init will be skipped if gpu_busy is NULL.
> Can we use gpu->devfreq instead of this condition?

We could, but then we couldn't also use the same has_devfreq() helper
in msm_devfreq_init().  I thought it was clearer to use the same
helper everywhere.

> I noticed that you have replaced some of gpu->devfreq checks with
> has_devreq() calls. Is there any difference?

It amounts to the same thing because if you don't have gpu_busy, then
devfreq is never initialized.  I just thought it clearer to use the
same check in all places.

BR,
-R

> > +}
> > +
> >   void msm_devfreq_init(struct msm_gpu *gpu)
> >   {
> >       struct msm_gpu_devfreq *df = &gpu->devfreq;
> >
> >       /* We need target support to do devfreq */
> > -     if (!gpu->funcs->gpu_busy)
> > +     if (!has_devfreq(gpu))
> >               return;
> >
> >       dev_pm_qos_add_request(&gpu->pdev->dev, &df->idle_freq,
> > @@ -149,6 +154,9 @@ void msm_devfreq_cleanup(struct msm_gpu *gpu)
> >   {
> >       struct msm_gpu_devfreq *df = &gpu->devfreq;
> >
> > +     if (!has_devfreq(gpu))
> > +             return;
> > +
> >       devfreq_cooling_unregister(gpu->cooling);
> >       dev_pm_qos_remove_request(&df->boost_freq);
> >       dev_pm_qos_remove_request(&df->idle_freq);
> > @@ -156,16 +164,24 @@ void msm_devfreq_cleanup(struct msm_gpu *gpu)
> >
> >   void msm_devfreq_resume(struct msm_gpu *gpu)
> >   {
> > -     gpu->devfreq.busy_cycles = 0;
> > -     gpu->devfreq.time = ktime_get();
> > +     struct msm_gpu_devfreq *df = &gpu->devfreq;
> >
> > -     devfreq_resume_device(gpu->devfreq.devfreq);
> > +     if (!has_devfreq(gpu))
> > +             return;
> > +
> > +     df->busy_cycles = 0;
> > +     df->time = ktime_get();
> > +
> > +     devfreq_resume_device(df->devfreq);
> >   }
> >
> >   void msm_devfreq_suspend(struct msm_gpu *gpu)
> >   {
> >       struct msm_gpu_devfreq *df = &gpu->devfreq;
> >
> > +     if (!has_devfreq(gpu))
> > +             return;
> > +
> >       devfreq_suspend_device(df->devfreq);
> >
> >       cancel_idle_work(df);
> > @@ -185,6 +201,9 @@ void msm_devfreq_boost(struct msm_gpu *gpu, unsigned factor)
> >       struct msm_gpu_devfreq *df = &gpu->devfreq;
> >       uint64_t freq;
> >
> > +     if (!has_devfreq(gpu))
> > +             return;
> > +
> >       freq = get_freq(gpu);
> >       freq *= factor;
> >
> > @@ -207,7 +226,7 @@ void msm_devfreq_active(struct msm_gpu *gpu)
> >       struct devfreq_dev_status status;
> >       unsigned int idle_time;
> >
> > -     if (!df->devfreq)
> > +     if (!has_devfreq(gpu))
> >               return;
> >
> >       /*
> > @@ -253,7 +272,7 @@ void msm_devfreq_idle(struct msm_gpu *gpu)
> >   {
> >       struct msm_gpu_devfreq *df = &gpu->devfreq;
> >
> > -     if (!df->devfreq)
> > +     if (!has_devfreq(gpu))
> >               return;
> >
> >       msm_hrtimer_queue_work(&df->idle_work, ms_to_ktime(1),
>
>
> --
> With best wishes
> Dmitry
