Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089F44CC7CB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbiCCVRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbiCCVRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:17:40 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264954F9D6;
        Thu,  3 Mar 2022 13:16:54 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso4011483wmr.1;
        Thu, 03 Mar 2022 13:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3qmkkje0cVWH6MFI3VHClM1bFsyW82VNALPE7/dweA=;
        b=md9Z0gIn1/qwklw+eS9LcPeNITwhy7ew4+7YsoGOzhs4ZtKY5DVkGyrpquvvfr6Pix
         d0MswLPm3oPbafQen6cTJ1B3gtHfw6U+AJyxRfAAxTcctb55UgUfOUIJdVV556A4K6sB
         OAFCbaPBirlmDJru7xdsZD9hRhwftxrRw1/Fy+fGRRNOJzbJHIF4YoLMSbSw/lV4I9VI
         HdP/7vCMcPWlNHXAZtg55MIlgkXpVR7eJ6hMN0Ilndj0Ln6nWC0nyHTm1Ph1x7al6FV3
         fmpvbQb8HlcqgvwGtO6iHWC+qYHNjkOgDrr5Hi/IZWqk20tF9uzL9bht5ac6+nY+/0E9
         aN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3qmkkje0cVWH6MFI3VHClM1bFsyW82VNALPE7/dweA=;
        b=Es/TZV4TrPKtPgDvZKpfaJvGKeJMihFmf5kfAUaHeipyBCl1YInRUo4k3R2uAtEqdJ
         JOgUznUVl7ustBReD6kawpEQAYPo+cnnRXhM+P+utYexU0MyS8qm6hBsI8ch1AkzEuje
         zZDvJ4DkwyJlxhthLpNnTmR2mRj0AOIDxIF/h0srMMqfXDpcmPPpcvCaYZrr5YbM0A2l
         Lyu/PF7xdb7EKNTFcgwQdR4riQxWqLHYYWBgaWjCmWtxv0VxNX54yHVbiUC0QrgjO0Hj
         2MaBnrRHDOiu+qduhlcUHheyvg7z2uwRaWvv45SQDFCwVNCeOo22SUlnr0zP1AuRkcbw
         84Pw==
X-Gm-Message-State: AOAM5328pC0vjZf3FPr4yoslNxD5SzGipN+jvCC1AvyyAGfjLxGEqIs6
        2M8Ycg19BXvZNd2vFZsit8OoC7U9M22ILbQfXGg=
X-Google-Smtp-Source: ABdhPJz3S/4vOjZfTiBAT5OCzG9I0JxE5mXa2XLfGzGKorHTlTtryDDoXU2qdnGYzj1iEBUMbDro79YHtjv+uAjMTiw=
X-Received: by 2002:a05:600c:35cc:b0:382:441f:897e with SMTP id
 r12-20020a05600c35cc00b00382441f897emr5345910wmq.127.1646342212637; Thu, 03
 Mar 2022 13:16:52 -0800 (PST)
MIME-Version: 1.0
References: <20220303194758.710358-1-robdclark@gmail.com> <20220303194758.710358-4-robdclark@gmail.com>
 <CAE-0n532ZX=qXTBKSFyRYAmkqFN7oqKyPvJHBuVMmr2eHY+O4A@mail.gmail.com>
In-Reply-To: <CAE-0n532ZX=qXTBKSFyRYAmkqFN7oqKyPvJHBuVMmr2eHY+O4A@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 3 Mar 2022 13:17:20 -0800
Message-ID: <CAF6AEGstzPaLFf-9z9Gf+S4G8n6twxExLvKaqLZk9ML2tUWiLw@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/msm: Add SYSPROF param
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Emma Anholt <emma@anholt.net>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Mar 3, 2022 at 12:47 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rob Clark (2022-03-03 11:46:47)
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> > index fde9a29f884e..0ba1dbd4e50f 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.h
> > +++ b/drivers/gpu/drm/msm/msm_gpu.h
> > @@ -330,6 +337,24 @@ struct msm_file_private {
> >         struct kref ref;
> >         int seqno;
> >
> > +       /**
> > +        * sysprof:
> > +        *
> > +        * The value of MSM_PARAM_SYSPROF set by userspace.  This is
> > +        * intended to be used by system profiling tools like Mesa's
> > +        * pps-producer (perfetto), and restricted to CAP_SYS_ADMIN.
> > +        *
> > +        * Setting a value of 1 will preserve performance counters across
> > +        * context switches.  Setting a value of 2 will in addition
> > +        * suppress suspend.  (Performance counters loose  state across
>
> s/loose  /lose/

fixed locally

> > +        * power collapse, which is undesirable for profiling in some
> > +        * cases.)
> > +        *
> > +        * The value automatically reverts to zero when the drm device
> > +        * file is closed.
> > +        */
> > +       int sysprof;
> > +
> >         /**
> >          * elapsed:
> >          *
> > diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
> > index 7cb158bcbcf6..4179db54ac93 100644
> > --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> > +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> > @@ -7,6 +7,40 @@
> >
> >  #include "msm_gpu.h"
> >
> > +int msm_file_private_set_sysprof(struct msm_file_private *ctx,
> > +                                struct msm_gpu *gpu, int sysprof)
> > +{
> > +       /* unwind old value first: */
> > +       switch (ctx->sysprof) {
> > +       case 2:
> > +               pm_runtime_put_autosuspend(&gpu->pdev->dev);
> > +               fallthrough;
> > +       case 1:
> > +               refcount_dec(&gpu->sysprof_active);
> > +               fallthrough;
> > +       case 0:
> > +               break;
> > +       }
> > +
> > +       /* then apply new value: */
>
> It would be safer to swap this. Otherwise a set when the values are at
> "1" would drop to "zero" here and potentially trigger some glitch,
> whereas incrementing one more time and then dropping the previous state
> would avoid that short blip.
>
> > +       switch (sysprof) {
> > +       default:
> > +               return -EINVAL;
>
> This will become more complicated though.

Right, that is why I took the "unwind first and then re-apply"
approach.. in practice I expect userspace to set the value before it
starts sampling counter values, so I wasn't too concerned about this
racing with a submit and clearing the counters.  (Plus any glitch if
userspace did decide to change it dynamically would just be transient
and not really a big deal.)

BR,
-R

> > +       case 2:
> > +               pm_runtime_get_sync(&gpu->pdev->dev);
> > +               fallthrough;
> > +       case 1:
> > +               refcount_inc(&gpu->sysprof_active);
> > +               fallthrough;
> > +       case 0:
> > +               break;
> > +       }
> > +
> > +       ctx->sysprof = sysprof;
> > +
> > +       return 0;
> > +}
