Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6E4589334
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbiHCU2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238612AbiHCU2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:28:38 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6135059262;
        Wed,  3 Aug 2022 13:28:37 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id q124so829521iod.3;
        Wed, 03 Aug 2022 13:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qns3k2bMfWZ5++no4JhoINAIs2Mgvwk2maknIEZXZGA=;
        b=aEWJqLOnfAJre5C81Ylqs5yMywTkNY2DxE1pRS3Qa06+/3s5LtLaxsW7WkgO6B5/iM
         +6BWdNFChgc7bTjv3aUJZwTqbv0KgFnZFwS9WTQkvR4yi7GsiYdyQ3hplToWzIpt1xLl
         nKqSRu0Q+G1bONulaZMWnTzrfCqKqm1bjsfuB7HmTit/6A7yOCNnFyNCLWg9y07ZO4/J
         w7bMXsP5oQFM+/Jnwk7rvdi0mWNboq0GB1SXVeG5uMJ89rUXo9zV1ai9KmXDcQnc4P2J
         quCXLPa5enl2sXd9VRyx9l7hS16EtrjKd18Yvn92oBfx25bdm6+CG6rczOBbCrvgZb2e
         REZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qns3k2bMfWZ5++no4JhoINAIs2Mgvwk2maknIEZXZGA=;
        b=H4QTyPdOnWwrzB56yipgzOmbk/uDfzHeQ9FZtIgVGQ+KJzbpQhOyYz0Ld169K6xfi2
         YHIQnKeLgTf6MCGhJqoxdK/J08Inh7CJgQe7H55AKVrOUWg4sp92jZYOrfXtIzfbcFcs
         8KTiWy0XeNAdk7h20bwXCICi29eQ0Vf5WXB6EHW0g5sQW+EjBnLDC/swjveA8rT0BC10
         yLAqLQigCW2SMAzXGqk5gucK5V4L7HhJjMDXgMxJzXjY6a66a1PnC+BGti+Y/8dWhOz4
         HmjhMqNoeH/I+vjVwlo4NYnX/GD1GFvJTswtJOW9bNeAI2vzkehS/Pm8f4P46uHdJlEX
         d0tA==
X-Gm-Message-State: AJIora8AHo6BfNGlhVP6y1gHZn5GvloIsxUPL3CG+ajotlonpmIgz7qP
        4S310S8kE78VpAOVfZ9Y7wVmkqUoUagP5G5DPWkDbrzP
X-Google-Smtp-Source: AGRyM1uH9w+FBi6w0iZfzdHO3chJWDFvIKlbdmizYyLuuwR3oEBqq5s53/WwKRKL0zGMjQBFej7UhPKp3nXHYVah3Eg=
X-Received: by 2002:a05:6638:4883:b0:33f:7948:e685 with SMTP id
 ct3-20020a056638488300b0033f7948e685mr11202421jab.138.1659558516113; Wed, 03
 Aug 2022 13:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220803172302.1976981-1-robdclark@gmail.com> <c80d70b6-a7ad-5900-ea7a-f0f2157e4a40@quicinc.com>
In-Reply-To: <c80d70b6-a7ad-5900-ea7a-f0f2157e4a40@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 3 Aug 2022 13:29:02 -0700
Message-ID: <CAF6AEGuDajmv=bnQ9hNgCbkB8ubpFhhoFZVL4881O=2B9xh+_Q@mail.gmail.com>
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

On Wed, Aug 3, 2022 at 12:52 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> On 8/3/2022 10:53 PM, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Don't directly restart the hangcheck timer from the timer handler, but
> > instead start it after the recover_worker replays remaining jobs.
> >
> > If the kthread is blocked for other reasons, there is no point to
> > immediately restart the timer.  Fixes a random symptom of the problem
> > fixed in the next patch.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/msm_gpu.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> > index fba85f894314..8f9c48eabf7d 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.c
> > +++ b/drivers/gpu/drm/msm/msm_gpu.c
> > @@ -328,6 +328,7 @@ find_submit(struct msm_ringbuffer *ring, uint32_t fence)
> >   }
> >
> >   static void retire_submits(struct msm_gpu *gpu);
> > +static void hangcheck_timer_reset(struct msm_gpu *gpu);
> >
> >   static void get_comm_cmdline(struct msm_gem_submit *submit, char **comm, char **cmd)
> >   {
> > @@ -420,6 +421,8 @@ static void recover_worker(struct kthread_work *work)
> >       }
> >
> >       if (msm_gpu_active(gpu)) {
> > +             bool restart_hangcheck = false;
> > +
> >               /* retire completed submits, plus the one that hung: */
> >               retire_submits(gpu);
> >
> > @@ -436,10 +439,15 @@ static void recover_worker(struct kthread_work *work)
> >                       unsigned long flags;
> >
> >                       spin_lock_irqsave(&ring->submit_lock, flags);
> > -                     list_for_each_entry(submit, &ring->submits, node)
> > +                     list_for_each_entry(submit, &ring->submits, node) {
> >                               gpu->funcs->submit(gpu, submit);
> > +                             restart_hangcheck = true;
> > +                     }
> >                       spin_unlock_irqrestore(&ring->submit_lock, flags);
> >               }
> > +
> > +             if (restart_hangcheck)
> > +                     hangcheck_timer_reset(gpu);
> >       }
> >
> >       mutex_unlock(&gpu->lock);
> > @@ -515,10 +523,6 @@ static void hangcheck_handler(struct timer_list *t)
> >               kthread_queue_work(gpu->worker, &gpu->recover_work);
> >       }
> >
> > -     /* if still more pending work, reset the hangcheck timer: */
> In the scenario mentioned here, shouldn't we restart the timer?

yeah, actually the case where we don't want to restart the timer is
*only* when we schedule recover_work..

BR,
-R

>
> -Akhil.
> > -     if (fence_after(ring->fctx->last_fence, ring->hangcheck_fence))
> > -             hangcheck_timer_reset(gpu);
> > -
> >       /* workaround for missing irq: */
> >       msm_gpu_retire(gpu);
> >   }
> >
>
