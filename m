Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE1B488500
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiAHRlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiAHRlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:41:49 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8823BC06173F;
        Sat,  8 Jan 2022 09:41:48 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l4so6033334wmq.3;
        Sat, 08 Jan 2022 09:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/unm4dEq29U+9A9+H2q9l5M3g8YNwwQHL3sl9HPMEOc=;
        b=A56B2+9idZXB4ljHp4MA6vbbshXMYE3jxMDTKvEJG8H006EDYL8WTBaZWKOfdYz4o6
         WAS/3d2ve6G3WYLiSQ2p9Af+FWc/+UJAh1NCSP8cDyIXNzBqGyXLTDQIO3USgtrMLhS8
         b24XIxZ79yYi/btgogT2xIbEgkaHj8/pjYQmHnAn/7HLcUJ/X3mq7wNVix73mmlO6JWJ
         tCynh2II4X5LLMdOFpymqw3Zw8mznKJ5212z0LoMyO0k1iKloTJkMvd3m6lhDMXZxfVf
         Bu1sYheCznaW6JvLKSepgp/UDHx/Jzf30JjTMDICkLs0mc0dcKR8fylLxM3IAGElm/Uk
         6ThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/unm4dEq29U+9A9+H2q9l5M3g8YNwwQHL3sl9HPMEOc=;
        b=sM1r6VxNBj45w/6eoO5yAatc12Ju0Jc3sgTELVtXZPPMQOUzoKP+iU8yW7mBPgH2/7
         Yy5l47WtzC7Yj0SFaP/OR/wFdJvlsBgX5aZ3WehrvJtHmbu4D8IFeVuI7CtD9w8YeK3W
         G+mrt/W/98BWhyZDdK/qTEnPhs2kt6lvnkVnP8fFJmZdMwnLd5aK8ew9IJrpkgHLJlYT
         sp6DEGQou6lR/HWH3AioVBDHBT2Rvtwn6zfACRSiDDEEwqndJuKXEkRLK9zwi3WTcV7r
         rUdDbskeo+C4SqTOiKOrZUM3aVe7gvIXEW/lGMze5Te44Pn8wm1v2RmKoIXWyFrDtitZ
         7S1Q==
X-Gm-Message-State: AOAM5314H9gdEIF41/FKI1PDradr2EYuotQYpC37FwNin+yKJesNhd8D
        MDOmSXpC2jJJKB/YduXC9D52F8pwuAg5K4Yjmd1b9tCb
X-Google-Smtp-Source: ABdhPJwd0wOlFffJMGuuMGPsuIzurCxyjNc7dAwFocxE2vZTcOuLbPq7fXcRJisaNMg1TR0EEwgzo8+Wew8pQPOOrAg=
X-Received: by 2002:a7b:c3c5:: with SMTP id t5mr15181606wmj.168.1641663706920;
 Sat, 08 Jan 2022 09:41:46 -0800 (PST)
MIME-Version: 1.0
References: <20220106181449.696988-1-robdclark@gmail.com> <20220106181449.696988-2-robdclark@gmail.com>
 <CAE-0n53N0GQ2UXYNpDOf_WVvvUa3cu95ePGYfYk7jZwPTqJ-XA@mail.gmail.com>
In-Reply-To: <CAE-0n53N0GQ2UXYNpDOf_WVvvUa3cu95ePGYfYk7jZwPTqJ-XA@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sat, 8 Jan 2022 09:41:35 -0800
Message-ID: <CAF6AEGsO1f5DC8AWjjA+9XLne3CRMGsLfLwWbv3iQVZW3wUTiw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm/gpu: Wait for idle before suspending
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 4:27 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rob Clark (2022-01-06 10:14:46)
> > From: Rob Clark <robdclark@chromium.org>
> >
> > System suspend uses pm_runtime_force_suspend(), which cheekily bypasses
> > the runpm reference counts.  This doesn't actually work so well when the
> > GPU is active.  So add a reasonable delay waiting for the GPU to become
> > idle.
>
> Maybe also say:
>
> Failure to wait during system wide suspend leads to GPU hangs seen on
> resume.

The fallout can actually be a lot more than just GPU hangs.. that is
just the case that is easy (for us) to observe because the crash
logging captures them.  But sync/async external aborts are also
possible.. and I think even just undefined behavior (ie. I think if
the timing works out right, it can survive but just "lose" rendering
that hadn't completed yet)

> >
> > Alternatively we could just return -EBUSY in this case, but that has the
> > disadvantage of causing system suspend to fail.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/msm/adreno/adreno_device.c | 9 +++++++++
> >  drivers/gpu/drm/msm/msm_gpu.c              | 3 +++
> >  drivers/gpu/drm/msm/msm_gpu.h              | 3 +++
> >  3 files changed, 15 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > index 93005839b5da..b677ca3fd75e 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > @@ -611,6 +611,15 @@ static int adreno_resume(struct device *dev)
> >  static int adreno_suspend(struct device *dev)
> >  {
> >         struct msm_gpu *gpu = dev_to_gpu(dev);
> > +       int ret = 0;
>
> Please don't assign and then immediately overwrite.
>
> > +
> > +       ret = wait_event_timeout(gpu->retire_event,
> > +                                !msm_gpu_active(gpu),
> > +                                msecs_to_jiffies(1000));
> > +       if (ret == 0) {
>
> The usual pattern is
>
>         long timeleft;
>
>         timeleft = wait_event_timeout(...)
>         if (!timeleft) {
>                 /* no time left; timed out */
>
> Can it be the same pattern here? It helps because people sometimes
> forget that wait_event_timeout() returns the time that is left and not
> an error code when it times out.

ok, I'll update in v2..

BR,
-R

> > +               dev_err(dev, "Timeout waiting for GPU to suspend\n");
> > +               return -EBUSY;
> > +       }
> >
> >         return gpu->funcs->pm_suspend(gpu);
> >  }
