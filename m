Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87612589FE6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 19:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbiHDRcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 13:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiHDRcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 13:32:51 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B581D109;
        Thu,  4 Aug 2022 10:32:50 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id s7so260843ioa.0;
        Thu, 04 Aug 2022 10:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZQf4XnBOCJB+vfAUnlzSwte/cUU8bNUatf6/Q8jOgEg=;
        b=jpJNn4uLeRXOgYq2sOuJhfouM6NXGvrYP/ciqu+C1dEv8Ch9RTeh8d36GTYbPmery4
         YPHeKo3EBsBL8wYh6OU1klWoV6E2JHKHqkj9MY32X4tnZjm9yDPqYpcl/bm9XTxH/RKY
         9H+1RyOckouKnvkStdM+hA8mVWt6KY8oFYHH5lOMoLg8V8eSFtBIv1i5ntmYfKKD6Kif
         ctmsJpuoPRiS5GnZnO7uil5A32DiFAWEUN1DRp5TyaSInoFyDT68uz2TpPtEfFub8wqn
         qCovJNGdPNUPHJN1zvaEB+vRABBMQr7pQXhXW+iKugKjiPfiYAoF1k+IxBInGDKboBZm
         Exxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZQf4XnBOCJB+vfAUnlzSwte/cUU8bNUatf6/Q8jOgEg=;
        b=VtOprNe/J4aOrJ4hltM6NRKePgXM5HBOsMFJ6wm2mm7bVkTd1W4srq5hBfFYItRX/X
         2r4u2Qm0N+hv+I11KpaqNsRWML1Vjl0HLiPQrwU3TKmhZQYSb2KtXuwMc7FNtAVThs21
         aUT+JoCwbXntbmHO9cE0ItVfQXJvLSUb+nOqoOCvbGXL4o5Snw5tvO6JI99Cqklv6C2c
         4NHlxCpIO71F5+ejNxpzgi8bAs+zxnd9CvVn694ybnQxoIB8rJekqAw2AkEPYS2Jz4cC
         EJhUyQMg7sICUN/mtknpJCeN+gT3xC74lH7tiKnOKwoKWexMpTVk6OIjiTsFRSfT/SPh
         z7mQ==
X-Gm-Message-State: ACgBeo267crFPidAtwFBFl6UnRB5M/6ZOARfAb9JaXP51U9wNuFbZXa1
        MF5d56VtBH27vMLsLiw8AY4zDzY82w+q/7Iuy4IKnO7B
X-Google-Smtp-Source: AA6agR7l+0CbFrUgBA7wD4UHjdEAojTPkkSEOy0SRKRZdOZG7J7o6ZyxuIxXmVlYDjjCoFMxBCQ95tMMlKSldAZtRrE=
X-Received: by 2002:a02:9622:0:b0:342:86af:7506 with SMTP id
 c31-20020a029622000000b0034286af7506mr1287121jai.311.1659634369569; Thu, 04
 Aug 2022 10:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220803172302.1976981-1-robdclark@gmail.com> <c80d70b6-a7ad-5900-ea7a-f0f2157e4a40@quicinc.com>
 <CAF6AEGuDajmv=bnQ9hNgCbkB8ubpFhhoFZVL4881O=2B9xh+_Q@mail.gmail.com> <7f7bd85a-2444-1939-4ac8-dbf2685eaf24@quicinc.com>
In-Reply-To: <7f7bd85a-2444-1939-4ac8-dbf2685eaf24@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 4 Aug 2022 10:33:16 -0700
Message-ID: <CAF6AEGv8sYG=72ne4wMx_OQwWOUkx88fYdKM2EEszdmYzOrg1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm: Move hangcheck timer restart
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 12:53 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> On 8/4/2022 1:59 AM, Rob Clark wrote:
> > On Wed, Aug 3, 2022 at 12:52 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
> >> On 8/3/2022 10:53 PM, Rob Clark wrote:
> >>> From: Rob Clark <robdclark@chromium.org>
> >>>
> >>> Don't directly restart the hangcheck timer from the timer handler, but
> >>> instead start it after the recover_worker replays remaining jobs.
> >>>
> >>> If the kthread is blocked for other reasons, there is no point to
> >>> immediately restart the timer.  Fixes a random symptom of the problem
> >>> fixed in the next patch.
> >>>
> >>> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >>> ---
> >>>    drivers/gpu/drm/msm/msm_gpu.c | 14 +++++++++-----
> >>>    1 file changed, 9 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> >>> index fba85f894314..8f9c48eabf7d 100644
> >>> --- a/drivers/gpu/drm/msm/msm_gpu.c
> >>> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> >>> @@ -328,6 +328,7 @@ find_submit(struct msm_ringbuffer *ring, uint32_t fence)
> >>>    }
> >>>
> >>>    static void retire_submits(struct msm_gpu *gpu);
> >>> +static void hangcheck_timer_reset(struct msm_gpu *gpu);
> >>>
> >>>    static void get_comm_cmdline(struct msm_gem_submit *submit, char **comm, char **cmd)
> >>>    {
> >>> @@ -420,6 +421,8 @@ static void recover_worker(struct kthread_work *work)
> >>>        }
> >>>
> >>>        if (msm_gpu_active(gpu)) {
> >>> +             bool restart_hangcheck = false;
> >>> +
> >>>                /* retire completed submits, plus the one that hung: */
> >>>                retire_submits(gpu);
> >>>
> >>> @@ -436,10 +439,15 @@ static void recover_worker(struct kthread_work *work)
> >>>                        unsigned long flags;
> >>>
> >>>                        spin_lock_irqsave(&ring->submit_lock, flags);
> >>> -                     list_for_each_entry(submit, &ring->submits, node)
> >>> +                     list_for_each_entry(submit, &ring->submits, node) {
> >>>                                gpu->funcs->submit(gpu, submit);
> >>> +                             restart_hangcheck = true;
> >>> +                     }
> >>>                        spin_unlock_irqrestore(&ring->submit_lock, flags);
> >>>                }
> >>> +
> >>> +             if (restart_hangcheck)
> >>> +                     hangcheck_timer_reset(gpu);
> >>>        }
> >>>
> >>>        mutex_unlock(&gpu->lock);
> >>> @@ -515,10 +523,6 @@ static void hangcheck_handler(struct timer_list *t)
> >>>                kthread_queue_work(gpu->worker, &gpu->recover_work);
> >>>        }
> >>>
> >>> -     /* if still more pending work, reset the hangcheck timer: */
> >> In the scenario mentioned here, shouldn't we restart the timer?
> > yeah, actually the case where we don't want to restart the timer is
> > *only* when we schedule recover_work..
> >
> > BR,
> > -R
> Not sure if your codebase is different but based on msm-next branch,
> when "if (fence != ring->hangcheck_fence)" is true, we now skip
> rescheduling the timer. I don't think that is what we want. There should
> be a hangcheck timer running as long as there is an active submit,
> unless we have scheduled a recover_work here.
>

right, v2 will change that to only skip rescheduling the timer in the
recover path

BR,
-R

> -Akhil.
> >
> >> -Akhil.
> >>> -     if (fence_after(ring->fctx->last_fence, ring->hangcheck_fence))
> >>> -             hangcheck_timer_reset(gpu);
> >>> -
> >>>        /* workaround for missing irq: */
> >>>        msm_gpu_retire(gpu);
> >>>    }
> >>>
>
