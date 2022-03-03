Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C84A4CC858
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbiCCVsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiCCVsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:48:18 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95D11FA76;
        Thu,  3 Mar 2022 13:47:28 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so4023134wmb.3;
        Thu, 03 Mar 2022 13:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XY3rEMgnaHo7kvIwqwRgN3QxydUq02k88+0c5ZSrCNI=;
        b=qTU8k58q4Oxz+S1GlKmr+UZf0k57Rmc2UWQTTJowUvKPv28CY8skoOIvw55GfUqvGk
         zg4DZtHFs4I+Z5owPyK/q3U0wVF5x+2FpOxaVanwt3k3BRXovLqNgEAJBoaE8k3QNkOJ
         OfO1JeMOhFvCSTVeeaWErSrakxpVBUtuji3W6y8PwZ1ZVIcO+opE5P8NRxDn6AOZRP0B
         Ofz0e2UaFGQMauBj7XJROWpOA/z4PGb6BbWE9Sh6jeaZwxbPzJVwbC+o7B1D5C6lq1rf
         5GazNKcUTsLKGURYh1RAKhvmBPXEr/K/tMrOBqkIcq5e89o/q5rTW7670WCE0yB4wSg8
         Fc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XY3rEMgnaHo7kvIwqwRgN3QxydUq02k88+0c5ZSrCNI=;
        b=lVkUzHUGawzu9TPDbc222VPIddWnz8DbLTkenNqDIjkwmWpC5F2Bdu/tamsfmzdJKH
         5J1PIceD7BTiI64foByNE4iAr5+J+gwCUjFcJ5Zby+QIY5b/GRW9BRknFLt5a/lCL+nm
         NJ9jx6fraD4dX4on2t/KncxS13D58UahC7nBiNDlZUdIHIB8//HWhGqqD61YqsImOGt+
         9v4zOS+97/8VCZCUxLceX/3TfEACb8gt5L3HqghsPNP81xvAFHZmubUnaCG1YtrCnDtD
         +tcJdn3rFWjThNxBDu/w4TNbYgPULz9kcN9v3mv0j86QmbseaWmTQarTleMR0VwRvQJy
         v49g==
X-Gm-Message-State: AOAM532wuxPI/sHXKAx7x8AjRyNxsZkE7kglZHDsgHyuHA8zCHN2uTA7
        dqgJRCLXPQwYasexrhTGWUHeG70n+GIf1ZO5DAU=
X-Google-Smtp-Source: ABdhPJyjiLusxqxe19OkyKf3cnF+lFS2omHJmBV1wzLbSnMFtR61PhGiM2IabT8BUEIcrcD5a//etCtAJehiSxHBpV0=
X-Received: by 2002:a05:600c:25cd:b0:381:4f09:a4b6 with SMTP id
 13-20020a05600c25cd00b003814f09a4b6mr5405089wml.44.1646344047011; Thu, 03 Mar
 2022 13:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20220303194758.710358-1-robdclark@gmail.com> <20220303194758.710358-4-robdclark@gmail.com>
 <CAE-0n532ZX=qXTBKSFyRYAmkqFN7oqKyPvJHBuVMmr2eHY+O4A@mail.gmail.com> <CAF6AEGstzPaLFf-9z9Gf+S4G8n6twxExLvKaqLZk9ML2tUWiLw@mail.gmail.com>
In-Reply-To: <CAF6AEGstzPaLFf-9z9Gf+S4G8n6twxExLvKaqLZk9ML2tUWiLw@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 3 Mar 2022 13:47:14 -0800
Message-ID: <CAF6AEGuaYEC2rYxi1uU0S_Hkx-DbjT6wO4zz6sKSRON=eX10ng@mail.gmail.com>
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

On Thu, Mar 3, 2022 at 1:17 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Thu, Mar 3, 2022 at 12:47 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Rob Clark (2022-03-03 11:46:47)
> > > diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> > > index fde9a29f884e..0ba1dbd4e50f 100644
> > > --- a/drivers/gpu/drm/msm/msm_gpu.h
> > > +++ b/drivers/gpu/drm/msm/msm_gpu.h
> > > @@ -330,6 +337,24 @@ struct msm_file_private {
> > >         struct kref ref;
> > >         int seqno;
> > >
> > > +       /**
> > > +        * sysprof:
> > > +        *
> > > +        * The value of MSM_PARAM_SYSPROF set by userspace.  This is
> > > +        * intended to be used by system profiling tools like Mesa's
> > > +        * pps-producer (perfetto), and restricted to CAP_SYS_ADMIN.
> > > +        *
> > > +        * Setting a value of 1 will preserve performance counters across
> > > +        * context switches.  Setting a value of 2 will in addition
> > > +        * suppress suspend.  (Performance counters loose  state across
> >
> > s/loose  /lose/
>
> fixed locally
>
> > > +        * power collapse, which is undesirable for profiling in some
> > > +        * cases.)
> > > +        *
> > > +        * The value automatically reverts to zero when the drm device
> > > +        * file is closed.
> > > +        */
> > > +       int sysprof;
> > > +
> > >         /**
> > >          * elapsed:
> > >          *
> > > diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
> > > index 7cb158bcbcf6..4179db54ac93 100644
> > > --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> > > +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> > > @@ -7,6 +7,40 @@
> > >
> > >  #include "msm_gpu.h"
> > >
> > > +int msm_file_private_set_sysprof(struct msm_file_private *ctx,
> > > +                                struct msm_gpu *gpu, int sysprof)
> > > +{
> > > +       /* unwind old value first: */
> > > +       switch (ctx->sysprof) {
> > > +       case 2:
> > > +               pm_runtime_put_autosuspend(&gpu->pdev->dev);
> > > +               fallthrough;
> > > +       case 1:
> > > +               refcount_dec(&gpu->sysprof_active);
> > > +               fallthrough;
> > > +       case 0:
> > > +               break;
> > > +       }
> > > +
> > > +       /* then apply new value: */
> >
> > It would be safer to swap this. Otherwise a set when the values are at
> > "1" would drop to "zero" here and potentially trigger some glitch,
> > whereas incrementing one more time and then dropping the previous state
> > would avoid that short blip.
> >
> > > +       switch (sysprof) {
> > > +       default:
> > > +               return -EINVAL;
> >
> > This will become more complicated though.
>
> Right, that is why I took the "unwind first and then re-apply"
> approach.. in practice I expect userspace to set the value before it
> starts sampling counter values, so I wasn't too concerned about this
> racing with a submit and clearing the counters.  (Plus any glitch if
> userspace did decide to change it dynamically would just be transient
> and not really a big deal.)

Actually I could just swap the two switch's.. the result would be that
an EINVAL would not change the state instead of dropping the state to
zero.  Maybe that is better anyways

BR,
-R


> BR,
> -R
>
> > > +       case 2:
> > > +               pm_runtime_get_sync(&gpu->pdev->dev);
> > > +               fallthrough;
> > > +       case 1:
> > > +               refcount_inc(&gpu->sysprof_active);
> > > +               fallthrough;
> > > +       case 0:
> > > +               break;
> > > +       }
> > > +
> > > +       ctx->sysprof = sysprof;
> > > +
> > > +       return 0;
> > > +}
