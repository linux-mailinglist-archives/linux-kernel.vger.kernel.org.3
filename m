Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A886D4DC9A1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbiCQPLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiCQPLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:11:31 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D5D204C95;
        Thu, 17 Mar 2022 08:10:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u10so7775062wra.9;
        Thu, 17 Mar 2022 08:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xd1I1jaOVhvAcR6vHw7kkzUfWncYai5tD7e0XVSca6g=;
        b=Ek55yHKFJhKiBY0RJxOjQb8P//I2US4VCkgJqkC2M4HuBchLBe//aAGH1H1lHQ+BTH
         C5qv7sw3uS026m4EdLToha6mj6PIfyRoKvI4IVYTbSYPw3rlXCzwZAfro53E121CE59H
         1MaJpf+VjTZO/IEo7BSIaqfeXjiju8Upldpq1nCr5gQkdGX0+WuoQHDopI01EwM5G3Oe
         JAo2op1qd30PRQgAGe7u2tmwTl0siSFPM0y0izAm+gwOkXO7YiFK2K3b4dXDjcHP3RV4
         3A+9oyCI00EVBE+dDq2AYK4N/QLr0DQ9zSW4lNfc5TUOo5gUD5KBts8HFdkay2p98tZ1
         8IRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xd1I1jaOVhvAcR6vHw7kkzUfWncYai5tD7e0XVSca6g=;
        b=YpOcGq8P6K9VVAcB/Q8MJaJZtB9N7pohM5Zn+oWWByaB1g9PxY2y9ajkrsHlMbxicx
         CJg5/yRoFV76nvZoatbzr5xmPMWQEFdUkq9WsJj/iJUXwo3ZX9PULEjJT74yAugq/OoK
         rdSN5bjVAAvNmhF8GhiPHY6CF/69T8nFGiT+GJFPe6ERx1u7Zq2YuEHJL1BrmODO01ux
         Y0gX6b67J8lOQR/M2hxJeltmVQp8qy0TuG2FsGwYSs/IkixqFWiXYdvmHVKYhJtTZ2dN
         E64sH2s4mMFslocRLC6UMdvQSBQ3yF4Y2homid1/dpkDwOdN5K5/ivXwdETF7dW3fP6u
         TSFA==
X-Gm-Message-State: AOAM531+/wMJ8l0FCTsx75QRaCeqowFcD5Ic0s+20RIMXWwPn4SkTj1p
        3xtAsojSHkdaiiX6+W5gfaB4ch8mGWMlQlPog1I=
X-Google-Smtp-Source: ABdhPJx/+OGZy/GONTI2VpT4DsS4zAwTerZUy7fUgcFu8OS87j3P2i+ZFRW+iMdtfays2J6Gyr627uCkQ5RJvaZ6fQo=
X-Received: by 2002:adf:dd4d:0:b0:203:f178:b78b with SMTP id
 u13-20020adfdd4d000000b00203f178b78bmr1048798wrm.93.1647529812714; Thu, 17
 Mar 2022 08:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220310234611.424743-1-robdclark@gmail.com> <20220310234611.424743-3-robdclark@gmail.com>
 <YjMGac4Hnjmg1wE8@phenom.ffwll.local> <3945551d-47d2-1974-f637-1dbc61e14702@amd.com>
In-Reply-To: <3945551d-47d2-1974-f637-1dbc61e14702@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 17 Mar 2022 08:10:52 -0700
Message-ID: <CAF6AEGv36V8bLoDn5O1SW3iTUtzd3O1XeuT5gJxyLMxd1E-o3Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/msm/gpu: Park scheduler threads for system suspend
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 3:06 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 17.03.22 um 10:59 schrieb Daniel Vetter:
> > On Thu, Mar 10, 2022 at 03:46:05PM -0800, Rob Clark wrote:
> >> From: Rob Clark <robdclark@chromium.org>
> >>
> >> In the system suspend path, we don't want to be racing with the
> >> scheduler kthreads pushing additional queued up jobs to the hw
> >> queue (ringbuffer).  So park them first.  While we are at it,
> >> move the wait for active jobs to complete into the new system-
> >> suspend path.
> >>
> >> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >> ---
> >>   drivers/gpu/drm/msm/adreno/adreno_device.c | 68 ++++++++++++++++++++=
--
> >>   1 file changed, 64 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/=
drm/msm/adreno/adreno_device.c
> >> index 8859834b51b8..0440a98988fc 100644
> >> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> >> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> >> @@ -619,22 +619,82 @@ static int active_submits(struct msm_gpu *gpu)
> >>   static int adreno_runtime_suspend(struct device *dev)
> >>   {
> >>      struct msm_gpu *gpu =3D dev_to_gpu(dev);
> >> -    int remaining;
> >> +
> >> +    /*
> >> +     * We should be holding a runpm ref, which will prevent
> >> +     * runtime suspend.  In the system suspend path, we've
> >> +     * already waited for active jobs to complete.
> >> +     */
> >> +    WARN_ON_ONCE(gpu->active_submits);
> >> +
> >> +    return gpu->funcs->pm_suspend(gpu);
> >> +}
> >> +
> >> +static void suspend_scheduler(struct msm_gpu *gpu)
> >> +{
> >> +    int i;
> >> +
> >> +    /*
> >> +     * Shut down the scheduler before we force suspend, so that
> >> +     * suspend isn't racing with scheduler kthread feeding us
> >> +     * more work.
> >> +     *
> >> +     * Note, we just want to park the thread, and let any jobs
> >> +     * that are already on the hw queue complete normally, as
> >> +     * opposed to the drm_sched_stop() path used for handling
> >> +     * faulting/timed-out jobs.  We can't really cancel any jobs
> >> +     * already on the hw queue without racing with the GPU.
> >> +     */
> >> +    for (i =3D 0; i < gpu->nr_rings; i++) {
> >> +            struct drm_gpu_scheduler *sched =3D &gpu->rb[i]->sched;
> >> +            kthread_park(sched->thread);
> > Shouldn't we have some proper interfaces for this?
>
> If I'm not completely mistaken we already should have one, yes.

drm_sched_stop() was my first thought, but it carries extra baggage.
Really I *just* want to park the kthread.

Note that amdgpu does (for afaict different reasons) park the kthread
directly as well.

> > Also I'm kinda wondering how other drivers do this, feels like we shoul=
d have a standard
> > way.

As far as other drivers, it seems like they largely ignore it.  I
suspect other drivers also have problems in this area.

Fwiw, I have a piglit test to try to exercise this path if you want to
try it on other drivers.. might need some futzing around to make sure
enough work is queued up that there is some on hw ring and some queued
up in the scheduler when you try to suspend.

https://gitlab.freedesktop.org/mesa/piglit/-/merge_requests/643

> >
> > Finally not flushing out all in-flight requests sounds a bit like a bad
> > idea for system suspend/resume since that's also the hibernation path, =
and
> > that would mean your shrinker/page reclaim stops working. At least in f=
ull
> > generality. Which ain't good for hibernation.
>
> Completely agree, that looks like an incorrect workaround to me.
>
> During suspend all userspace applications should be frozen and all f
> their hardware activity flushed out and waited for completion.
>
> I do remember that our internal guys came up with pretty much the same
> idea and it sounded broken to me back then as well.

userspace frozen !=3D kthread frozen .. that is what this patch is
trying to address, so we aren't racing between shutting down the hw
and the scheduler shoveling more jobs at us.

BR,
-R

> Regards,
> Christian.
>
> >
> > Adding Christian and Andrey.
> > -Daniel
> >
> >> +    }
> >> +}
> >> +
> >> +static void resume_scheduler(struct msm_gpu *gpu)
> >> +{
> >> +    int i;
> >> +
> >> +    for (i =3D 0; i < gpu->nr_rings; i++) {
> >> +            struct drm_gpu_scheduler *sched =3D &gpu->rb[i]->sched;
> >> +            kthread_unpark(sched->thread);
> >> +    }
> >> +}
> >> +
> >> +static int adreno_system_suspend(struct device *dev)
> >> +{
> >> +    struct msm_gpu *gpu =3D dev_to_gpu(dev);
> >> +    int remaining, ret;
> >> +
> >> +    suspend_scheduler(gpu);
> >>
> >>      remaining =3D wait_event_timeout(gpu->retire_event,
> >>                                     active_submits(gpu) =3D=3D 0,
> >>                                     msecs_to_jiffies(1000));
> >>      if (remaining =3D=3D 0) {
> >>              dev_err(dev, "Timeout waiting for GPU to suspend\n");
> >> -            return -EBUSY;
> >> +            ret =3D -EBUSY;
> >> +            goto out;
> >>      }
> >>
> >> -    return gpu->funcs->pm_suspend(gpu);
> >> +    ret =3D pm_runtime_force_suspend(dev);
> >> +out:
> >> +    if (ret)
> >> +            resume_scheduler(gpu);
> >> +
> >> +    return ret;
> >>   }
> >> +
> >> +static int adreno_system_resume(struct device *dev)
> >> +{
> >> +    resume_scheduler(dev_to_gpu(dev));
> >> +    return pm_runtime_force_resume(dev);
> >> +}
> >> +
> >>   #endif
> >>
> >>   static const struct dev_pm_ops adreno_pm_ops =3D {
> >> -    SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_forc=
e_resume)
> >> +    SET_SYSTEM_SLEEP_PM_OPS(adreno_system_suspend, adreno_system_resu=
me)
> >>      SET_RUNTIME_PM_OPS(adreno_runtime_suspend, adreno_runtime_resume,=
 NULL)
> >>   };
> >>
> >> --
> >> 2.35.1
> >>
>
