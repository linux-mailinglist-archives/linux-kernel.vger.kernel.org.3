Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660FB4DCFE7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiCQVIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiCQVIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:08:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC662184B67;
        Thu, 17 Mar 2022 14:07:05 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r64so3809163wmr.4;
        Thu, 17 Mar 2022 14:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a2ti8g/ld+9idqGBypq+3jGDET4QNV1EIOi7rZI8SYg=;
        b=pUelORlA+hm0f6QAqGhfMd+zAAK4W9I/TgVm7PB9Md7nIvrbt3PcHoNvZUCXiD/Of4
         IzZGDAe8mOXsZrX/H4Ga4rd05sI1XXryJZUIDZYZTf+M2lQLEABbwXjwzlGwb888J744
         WwFMOQt6RN/TSkhfA+C8zoeBPLM4s7U9WynBrp5kSeKfvZ1Xnt/ktBSn0BZM4sd9u/Tg
         YdBOTPRMNsbe5tBoAk3Pru5qV1EGo10C5my5vr/baLjU21gOA1FBLyIJDxnAL4bn+HD6
         7ZQfrMOc8YGRPXnb7Wb8xm2H61WjsJ/uxsEtJZfUUzm7UgdqHS6r6a0Z+cXVZ89njTiU
         Itvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a2ti8g/ld+9idqGBypq+3jGDET4QNV1EIOi7rZI8SYg=;
        b=L1uPHyMlpHRBoYdEibaBwgvo0ZGvHZyVX7ndP/EDbYsQb+ePkrgN34LElKcYNjJmzu
         KfPfapYDb7OqSxJ2MoypthZPwI6s0Dq/iQM4mdQEJ8/o5u8mMjilSvy0WS6FTNHOvvZE
         I5xtGZHYbvmwC5KHIoQ90lE1G9DxM7oNBbs8WnS4YPCNw57xN2oVnzOd93tOpUq1Xoiy
         RwAmyaHhbK6hdDYLsjdG2EHNPo/EL1ocfGY87vsVxvkRIxAF+6EuWjSTDDj3LVJt4QJr
         pv1gGzQOmHeBKF3xlkf6T/MXa4wysSqCYlRxGwQVmGdAzC0ZZNyUIKCYPXvc9s91vxgT
         kwTg==
X-Gm-Message-State: AOAM532qmI0hxPGOik35T+ja18ENu7LicDnqxlv+/O/3G3VLkduG8Pbh
        tem1BG0VFJr9uNrE8JSE3JRe/6n9Ztz5wpGjxWY=
X-Google-Smtp-Source: ABdhPJxOIk1wL4Vo+j9cGqh9IoH3jz1NeAYIk35hsGWG/uAcKPsisCn2g9s4mStQ0P3jsnqMJhiPuaRMurP+IHPAqi8=
X-Received: by 2002:a05:600c:600a:b0:38c:6c9e:f9c7 with SMTP id
 az10-20020a05600c600a00b0038c6c9ef9c7mr9210334wmb.26.1647551224066; Thu, 17
 Mar 2022 14:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220310234611.424743-1-robdclark@gmail.com> <20220310234611.424743-4-robdclark@gmail.com>
 <3b066b63-c180-09c6-e39f-b408464b5bc1@quicinc.com>
In-Reply-To: <3b066b63-c180-09c6-e39f-b408464b5bc1@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 17 Mar 2022 14:07:45 -0700
Message-ID: <CAF6AEGvF7rJ2iK+roGTA1BEthwCLMguMHrG-45dyxfk=b-acug@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH 3/3] drm/msm/gpu: Remove mutex from wait_event condition
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        freedreno <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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

On Thu, Mar 17, 2022 at 1:45 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> On 3/11/2022 5:16 AM, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > The mutex wasn't really protecting anything before.  Before the previous
> > patch we could still be racing with the scheduler's kthread, as that is
> > not necessarily frozen yet.  Now that we've parked the sched threads,
> > the only race is with jobs retiring, and that is harmless, ie.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/adreno/adreno_device.c | 11 +----------
> >   1 file changed, 1 insertion(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > index 0440a98988fc..661dfa7681fb 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > @@ -607,15 +607,6 @@ static int adreno_runtime_resume(struct device *dev)
> >       return gpu->funcs->pm_resume(gpu);
> >   }
> >
> > -static int active_submits(struct msm_gpu *gpu)
> > -{
> > -     int active_submits;
> > -     mutex_lock(&gpu->active_lock);
> > -     active_submits = gpu->active_submits;
> > -     mutex_unlock(&gpu->active_lock);
> I assumed that this lock here was to ensure proper barriers while
> reading active_submits. Is that not required?

There is a spinlock in prepare_to_wait_event() ahead of checking the
condition, which AFAIU is a sufficient barrier

BR,
-R

>
> -Akhil.
> > -     return active_submits;
> > -}
> > -
> >   static int adreno_runtime_suspend(struct device *dev)
> >   {
> >       struct msm_gpu *gpu = dev_to_gpu(dev);
> > @@ -669,7 +660,7 @@ static int adreno_system_suspend(struct device *dev)
> >       suspend_scheduler(gpu);
> >
> >       remaining = wait_event_timeout(gpu->retire_event,
> > -                                    active_submits(gpu) == 0,
> > +                                    gpu->active_submits == 0,
> >                                      msecs_to_jiffies(1000));
> >       if (remaining == 0) {
> >               dev_err(dev, "Timeout waiting for GPU to suspend\n");
>
