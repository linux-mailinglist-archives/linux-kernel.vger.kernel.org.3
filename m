Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08F54D8518
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241484AbiCNMfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245593AbiCNMdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:33:16 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78697260
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 05:32:06 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2dbd8777564so161519867b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 05:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SWYiVcad4lyN3MTMCVaEe/kHD8SmjlJLnSNDNu5hEV8=;
        b=dx89DPmQPGELKQ9URRMTc+sGTgkEbGOiXMkgouXNqdU6gaEGEWf9ADvH/onhhTn9A0
         i07Y+WDeSjXLEPXUwnNBLIzyoHrmbu+PIZZ56LGMx0d0FQ9XDJHHqdg5B425iKHO0uhY
         GeVnLJBk8jVDLd84298P3HM89dWltpY/eLhQZkpS27sg45OBX42hMGTtXK8ehdreVn/P
         jnIg+ChqnI+V8gxqyI8KZRxkMBzg/c6/lt79dm2zyzpe8FjryvOPjxeQhM723GIDLkDr
         rhNtFsEBSDzig95iZNJVTyfMhKMlVfXY81af0BTKizXB5c2HxE0fmzOMBfUq1Hw/6N38
         KXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWYiVcad4lyN3MTMCVaEe/kHD8SmjlJLnSNDNu5hEV8=;
        b=IrACiiqRTZjH2s3elUFBhtHtlyWQalcRAtWczw4oaJpEm9LfGo8PTSyKxuTw3LgHPs
         y0ds0eVDe9I+5JPbblpztfZwvYOfE/G0lAPSj13gzSb1yp6mtE5P8sClLZrs+45qJ41+
         cP3JKGoAKyR2+TeTTkmFSlg2SEMTTYL0G+hvLbRDx4lLic7CUdX9C0SOtRmEtuMHTkWN
         Sk9xnneb3Ce1fiOmfSmQylhDSb2p61fZzvFngr5irTVIgPzFjDV15AWz359boMP5lNkb
         5HqmEElxSPM9ga6+DXSHb3N662cLmg+G/hqzHymwpZPl210gkNNP6tKx1+O++x2Zq6zC
         Bllg==
X-Gm-Message-State: AOAM531Wi/rb8xECnCsOC1Mqnaz7ACSWRkNJQf2fM6GkPaexkfOx8W73
        GdgQe1eE4tNZM9XImfdub1fabubVga+s0+m4qUTRfQ==
X-Google-Smtp-Source: ABdhPJw9ptK7cXWIyB+pXX4gxaG81OIr8G6j/SFNJ1dr+spjkllZx+dgElnNqGpEHU1scqv+d/HKw9nNDEh76Lq5I60=
X-Received: by 2002:a0d:d187:0:b0:2dc:5d83:217d with SMTP id
 t129-20020a0dd187000000b002dc5d83217dmr18485669ywd.189.1647261125395; Mon, 14
 Mar 2022 05:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220219183310.557435-1-robdclark@gmail.com> <CA+G9fYv6dPUsPzbFLr9PxJoe4eRAUdQyD4xT4hh4-xw=n9r=Bw@mail.gmail.com>
In-Reply-To: <CA+G9fYv6dPUsPzbFLr9PxJoe4eRAUdQyD4xT4hh4-xw=n9r=Bw@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 14 Mar 2022 18:01:53 +0530
Message-ID: <CA+G9fYsipiN2-+g9CGmvf1WVQe22ehnkRuwa45D4rsTa6+Wk=w@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/gpu: Fix crash on devices without devfreq support
To:     Rob Clark <robdclark@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
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

Hi Rob and Linus,

On Mon, 7 Mar 2022 at 14:07, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Hi Rob,
>
> On Sun, 20 Feb 2022 at 00:02, Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Avoid going down devfreq paths on devices where devfreq is not
> > initialized.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> I have tested this patch and the reported kernel crash is fixed [1].
>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> > ---
> >  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 31 +++++++++++++++++++++------
> >  1 file changed, 25 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> > index 9bf319be11f6..26a3669a97b3 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> > +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> > @@ -83,12 +83,17 @@ static struct devfreq_dev_profile msm_devfreq_profile = {
> >  static void msm_devfreq_boost_work(struct kthread_work *work);
> >  static void msm_devfreq_idle_work(struct kthread_work *work);
> >
> > +static bool has_devfreq(struct msm_gpu *gpu)
> > +{
> > +       return !!gpu->funcs->gpu_busy;
> > +}
> > +
> >  void msm_devfreq_init(struct msm_gpu *gpu)
> >  {
> >         struct msm_gpu_devfreq *df = &gpu->devfreq;
> >
> >         /* We need target support to do devfreq */
> > -       if (!gpu->funcs->gpu_busy)
> > +       if (!has_devfreq(gpu))
> >                 return;
> >
> >         dev_pm_qos_add_request(&gpu->pdev->dev, &df->idle_freq,
> > @@ -149,6 +154,9 @@ void msm_devfreq_cleanup(struct msm_gpu *gpu)
> >  {
> >         struct msm_gpu_devfreq *df = &gpu->devfreq;
> >
> > +       if (!has_devfreq(gpu))
> > +               return;
> > +
> >         devfreq_cooling_unregister(gpu->cooling);
> >         dev_pm_qos_remove_request(&df->boost_freq);
> >         dev_pm_qos_remove_request(&df->idle_freq);
> > @@ -156,16 +164,24 @@ void msm_devfreq_cleanup(struct msm_gpu *gpu)
> >
> >  void msm_devfreq_resume(struct msm_gpu *gpu)
> >  {
> > -       gpu->devfreq.busy_cycles = 0;
> > -       gpu->devfreq.time = ktime_get();
> > +       struct msm_gpu_devfreq *df = &gpu->devfreq;
> >
> > -       devfreq_resume_device(gpu->devfreq.devfreq);
> > +       if (!has_devfreq(gpu))
> > +               return;
> > +
> > +       df->busy_cycles = 0;
> > +       df->time = ktime_get();
> > +
> > +       devfreq_resume_device(df->devfreq);
> >  }
> >
> >  void msm_devfreq_suspend(struct msm_gpu *gpu)
> >  {
> >         struct msm_gpu_devfreq *df = &gpu->devfreq;
> >
> > +       if (!has_devfreq(gpu))
> > +               return;
> > +
> >         devfreq_suspend_device(df->devfreq);
> >
> >         cancel_idle_work(df);
> > @@ -185,6 +201,9 @@ void msm_devfreq_boost(struct msm_gpu *gpu, unsigned factor)
> >         struct msm_gpu_devfreq *df = &gpu->devfreq;
> >         uint64_t freq;
> >
> > +       if (!has_devfreq(gpu))
> > +               return;
> > +
> >         freq = get_freq(gpu);
> >         freq *= factor;
> >
> > @@ -207,7 +226,7 @@ void msm_devfreq_active(struct msm_gpu *gpu)
> >         struct devfreq_dev_status status;
> >         unsigned int idle_time;
> >
> > -       if (!df->devfreq)
> > +       if (!has_devfreq(gpu))
> >                 return;
> >
> >         /*
> > @@ -253,7 +272,7 @@ void msm_devfreq_idle(struct msm_gpu *gpu)
> >  {
> >         struct msm_gpu_devfreq *df = &gpu->devfreq;
> >
> > -       if (!df->devfreq)
> > +       if (!has_devfreq(gpu))
> >                 return;
> >
> >         msm_hrtimer_queue_work(&df->idle_work, ms_to_ktime(1),

FYI,
This patch is missing on Linux 5.17-rc8 [1].
kernel crash log on arm64 db410c device [2] and details [3].

metadata:
  git_describe: v5.17-rc8
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: 09688c0166e76ce2fb85e86b9d99be8b0084cdf9
  kernel-config: https://builds.tuxbuild.com/26LbbVLHqxjh5w5ZtjBMjGmh92P/config
  build: https://builds.tuxbuild.com/26LbbVLHqxjh5w5ZtjBMjGmh92P

- Naresh
[1] https://lore.kernel.org/dri-devel/20220219183310.557435-1-robdclark@gmail.com/
[2]  https://lkft.validation.linaro.org/scheduler/job/4714905#L2795
[3] https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.17-rc8/testrun/8446224/suite/linux-log-parser/test/check-kernel-oops-4714905/details/

>
> --
> Linaro LKFT
> https://lkft.linaro.org
>
> [1] https://lkft.validation.linaro.org/scheduler/job/4664600#L1894
