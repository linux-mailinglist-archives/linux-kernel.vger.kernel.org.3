Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD47854E2DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377440AbiFPOEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiFPOEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:04:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4DC369EF;
        Thu, 16 Jun 2022 07:04:10 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso2889860wms.2;
        Thu, 16 Jun 2022 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=slC185Ob3bqwRbXUouHuTugpdNeQm0iZ+NbyQh6gPTc=;
        b=BjTvft9fFPRIzJq1i2BdE+Ngl7Lnwas+O5i3jS01WgAIwobhoFJwDsfz+t5rUAkEK4
         8PvZYeBrFNhXVIDPC6oRttEjtOFIF2qSVsdcZAy4lwLb4ZKPfIq6ZgJxN4cDzvfoxrhv
         Eli6czrFILNMmzqSWwheVkrEoq6D72f2Af1wSzkHCtFlioENSWN+0/qWT9V8W8VqDy3J
         TJP8DLFHr/P0/nqeZeDXo96GEgnIreXeODLg8xijl/1UrXE8Hou0JQguVP/wB2gYxJNI
         tHPxOb3tuGJQmQEVDdkSXrJubExIU7an2AMNUFCEXQ2HgaMSv6w/7A+7+ppDssY3r/fU
         HMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slC185Ob3bqwRbXUouHuTugpdNeQm0iZ+NbyQh6gPTc=;
        b=PKdgd3qNvmP7MfdJsIh+bqZP3eynB7WG0wdpY+4YnaPnrbRcDdNvo5EftrDIFoubpR
         dB+dAvwZOeH1t2CWY5qET1uVO58YUEsuZ4EvOf7lHlcc0yd7aR9xRO8sF+aeB3aQ/Zij
         q76GyViKHvJqSCZCLT9nZVRCLv5I4w97Bhj9Rwpg0SnEfHk2jxZEZQvuCFzN/DP16oEa
         rbFHvEFAX+J/1nLPDp+Yb6k29ujwdRHlji0DgKUwN7rjXno1VgM1TJmvUUUVzhsBoq3E
         Hy5MUaNbo7Hg450XEoEX9GGeJ4Re45o+zSuGNL7F1lYyxQKUNwpmLIZCFDsTSVaJeylf
         pMRw==
X-Gm-Message-State: AJIora94+joAxPfpkh28qeq6sTt3Uh34pE4WEa2tTBA4yfy2FdZITlxM
        KZ3pB985INZG0ZSXqMa2raIYI3Od7F2ogfy1oXYOJjN+
X-Google-Smtp-Source: AGRyM1vS5uY/KayIVVnAafrvhMLqkQv0X/+RZJiaVU0H2MFh34eE7xgk+0K7uZmYowMiafmu//6OgSqoUg5erP+u2uY=
X-Received: by 2002:a05:600c:4f96:b0:39c:951e:66b7 with SMTP id
 n22-20020a05600c4f9600b0039c951e66b7mr5296884wmq.84.1655388249063; Thu, 16
 Jun 2022 07:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220615162435.3011793-1-robdclark@gmail.com> <991331d8-ddda-a816-d279-fdaed90b43c1@linaro.org>
In-Reply-To: <991331d8-ddda-a816-d279-fdaed90b43c1@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 16 Jun 2022 07:04:14 -0700
Message-ID: <CAF6AEGvqoOOcNTrBEFxnROY-M8PazbaZb4zDw4gJFLC7jCR8CA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Fix fence rollover issue
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
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

On Thu, Jun 16, 2022 at 1:27 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 15/06/2022 19:24, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > And while we are at it, let's start the fence counter close to the
> > rollover point so that if issues slip in, they are more obvious.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> Should it also have
>
> Fixes: fde5de6cb461 ("drm/msm: move fence code to it's own file")
>
> Or maybe
>
> Fixes: 5f3aee4ceb5b ("drm/msm: Handle fence rollover")

arguably it fixes the first commit that added GPU support (and
finishes up a couple spots that the above commit missed)

I guess I could use the fixes tag just to indicate how far back it
would be reasonable to backport to stable branches.

> Otherwise:
>
> Reviewed: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
>
> > ---
> >   drivers/gpu/drm/msm/msm_fence.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
> > index 3df255402a33..a35a6746c7cd 100644
> > --- a/drivers/gpu/drm/msm/msm_fence.c
> > +++ b/drivers/gpu/drm/msm/msm_fence.c
> > @@ -28,6 +28,14 @@ msm_fence_context_alloc(struct drm_device *dev, volatile uint32_t *fenceptr,
> >       fctx->fenceptr = fenceptr;
> >       spin_lock_init(&fctx->spinlock);
> >
> > +     /*
> > +      * Start out close to the 32b fence rollover point, so we can
> > +      * catch bugs with fence comparisons.
> > +      */
> > +     fctx->last_fence = 0xffffff00;
> > +     fctx->completed_fence = fctx->last_fence;
> > +     *fctx->fenceptr = fctx->last_fence;
>
> This looks like a debugging hack. But probably it's fine to have it, as
> it wouldn't cause any side effects.

I was originally going to add a modparam or kconfig to enable this..
but then thought, if there is a bug and thing are to go wrong, it's
best for that to happen ASAP rather than after 200-400 days of
uptime.. the latter case can be rather hard to reproduce bugs ;-)

IIRC the kernel does something similar with jiffies to ensure the
rollover point is hit quickly

BR,
-R

> > +
> >       return fctx;
> >   }
> >
> > @@ -46,11 +54,12 @@ bool msm_fence_completed(struct msm_fence_context *fctx, uint32_t fence)
> >               (int32_t)(*fctx->fenceptr - fence) >= 0;
> >   }
> >
> > -/* called from workqueue */
> > +/* called from irq handler */
> >   void msm_update_fence(struct msm_fence_context *fctx, uint32_t fence)
> >   {
> >       spin_lock(&fctx->spinlock);
> > -     fctx->completed_fence = max(fence, fctx->completed_fence);
> > +     if (fence_after(fence, fctx->completed_fence))
> > +             fctx->completed_fence = fence;
> >       spin_unlock(&fctx->spinlock);
> >   }
> >
>
>
> --
> With best wishes
> Dmitry
