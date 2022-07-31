Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A875861A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 00:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbiGaWPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 18:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGaWP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:15:27 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE628B2C;
        Sun, 31 Jul 2022 15:15:26 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq11so9574523lfb.5;
        Sun, 31 Jul 2022 15:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JhTc/o85aa/gNSXM1E2WlhOm4hoCmf8aYbOpvTqzACg=;
        b=IYcyUZylduzwRAWXYDunqrHsrpEt1tyMI6KfAyQj2u1aW7Jxfnw074RjZ9Qmkgdm3N
         9RNJImzPJX4mezXXmy7NYqTkxLev4LQGq4gwOpL4LxjbKTvL5xpwFXGuW3nmAKTZdN96
         7hXJ/isn1PiMCoP00zX+uiqg3sqESxr8CHhcLE/0yN/Cr0RkaK1uN5eQoX/J3pVkJs69
         uMDj87BXk35CXEZ1qI1eb/G9Go4iJ61eNwBj1HEG//jZtfG9sCko1UejSMQ1BbQ1kXv/
         3IBnG8u4PEJxwWklKhY4vEBZ8xRjuWwTC6QTwYH6/82yuqkV1rK83iA8RXDn186T1/cX
         lOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JhTc/o85aa/gNSXM1E2WlhOm4hoCmf8aYbOpvTqzACg=;
        b=LDqq9bLuGJiWgsVHz/sYnLA+QCTickheA9adZ0Jhay+ILbrGWgKMFYYJMa6cpoF0VY
         hZzMPY9aulbylADa2R7uX1oftQgoZVKebN39di9OTOLcMEqRffeVWdlAtqkJzTUdU4vO
         wK0QmpuG7c/EYpTNEAxl+jO3dfnnIp4ptpBvLWfH4cEV9+34RpUPjifN89e5TU5n689M
         Hups69LOBZ2LTapX4GhcwYk1Mi24u3A7KK5ArHr/ZsfuCstC6mNEDJirfcKxxHRY0QP2
         ahGldPSXxLynhwbC6yY2LhQVRTCFIwpy7E4K7zPk7IfDdsEhP6xM5uKQVfNjj+97jSnm
         5ceA==
X-Gm-Message-State: AJIora8pBwL2CRzSHh2S8iXVwWWi+Wkx+AI2RbmsxEnVVOlOzdRETAL2
        M5gl9sbc0hhuztW/MMYnX3ESJc1ocze4HpaqlJlPVcn1
X-Google-Smtp-Source: AGRyM1tdLlKik2XqGE1EF+tHF1IzVO89f4sSViGTihMdIqiZb/1V9J01GjK3tML6KEdslkqSQ7uCw8J3NkhPN0aTXfU=
X-Received: by 2002:a05:6512:1307:b0:47f:baa4:52c5 with SMTP id
 x7-20020a056512130700b0047fbaa452c5mr4437991lfu.103.1659305724920; Sun, 31
 Jul 2022 15:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <1659174051-27816-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220730150952.v3.2.Ifee853f6d8217a0fdacc459092bbc9e81a8a7ac7@changeid>
 <CAF6AEGs7zKDoRY=ijxFQvaZig=UiSPgWkJFA-PY2MTxKWr5bpw@mail.gmail.com> <d7f95663-c0f7-8227-dbc0-fac43bdf6faa@quicinc.com>
In-Reply-To: <d7f95663-c0f7-8227-dbc0-fac43bdf6faa@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 31 Jul 2022 15:15:49 -0700
Message-ID: <CAF6AEGt5H=T_0HOLrNqRHZOYNicfk74bgZrQH56k2bYpi5JsRA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] drm/msm: Take single rpm refcount on behalf of all submits
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
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

On Sun, Jul 31, 2022 at 9:33 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> On 7/31/2022 9:26 PM, Rob Clark wrote:
> > On Sat, Jul 30, 2022 at 2:41 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
> >> Instead of separate refcount for each submit, take single rpm refcount
> >> on behalf of all the submits. This makes it easier to drop the rpm
> >> refcount during recovery in an upcoming patch.
> >>
> >> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> >> ---
> >>
> >> (no changes since v1)
> > I see no earlier version of this patch?
> >
> >>   drivers/gpu/drm/msm/msm_gpu.c | 12 ++++++++----
> >>   1 file changed, 8 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> >> index c8cd9bf..e1dd3cc 100644
> >> --- a/drivers/gpu/drm/msm/msm_gpu.c
> >> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> >> @@ -663,11 +663,12 @@ static void retire_submit(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
> >>          mutex_lock(&gpu->active_lock);
> >>          gpu->active_submits--;
> >>          WARN_ON(gpu->active_submits < 0);
> >> -       if (!gpu->active_submits)
> >> +       if (!gpu->active_submits) {
> >>                  msm_devfreq_idle(gpu);
> >> -       mutex_unlock(&gpu->active_lock);
> >> +               pm_runtime_put_autosuspend(&gpu->pdev->dev);
> >> +       }
> >>
> >> -       pm_runtime_put_autosuspend(&gpu->pdev->dev);
> >> +       mutex_unlock(&gpu->active_lock);
> >>
> >>          msm_gem_submit_put(submit);
> >>   }
> >> @@ -756,14 +757,17 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
> >>
> >>          /* Update devfreq on transition from idle->active: */
> >>          mutex_lock(&gpu->active_lock);
> >> -       if (!gpu->active_submits)
> >> +       if (!gpu->active_submits) {
> >> +               pm_runtime_get(&gpu->pdev->dev);
> >>                  msm_devfreq_active(gpu);
> >> +       }
> >>          gpu->active_submits++;
> >>          mutex_unlock(&gpu->active_lock);
> >>
> >>          gpu->funcs->submit(gpu, submit);
> >>          gpu->cur_ctx_seqno = submit->queue->ctx->seqno;
> >>
> >> +       pm_runtime_put(&gpu->pdev->dev);
> > this looks unbalanced?
> There is another pm_runtime_get_sync at the top of this function. Just
> before hw_init().
> https://elixir.bootlin.com/linux/v5.19-rc8/source/drivers/gpu/drm/msm/msm_gpu.c#L737

oh, right.. sorry, I was looking at my local stack of WIP patches
which went the opposite direction and moved the runpm into just
msm_job_run().. I'll drop that one

BR,
-R

>
> -Akhil.
> >
> > BR,
> > -R
> >
> >>          hangcheck_timer_reset(gpu);
> >>   }
> >>
> >> --
> >> 2.7.4
> >>
>
