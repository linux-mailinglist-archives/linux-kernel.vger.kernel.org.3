Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BCC49BB11
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiAYSQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiAYSQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:16:34 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFDFC06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:16:33 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b15so5576805plg.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWi/VzmHnEk2/VtWXzNTzI6tNMuksJ3FgOnDItF6gHE=;
        b=Q3tDZoDFFIbhLfDZzBvZ0S5DOiksvrkBEYh7dQDmQIWbV1Q1uB59IguVOIm01TYQG7
         lfRZ0/5SSuDtRD51nesMx9/e3kRtXvjYoVyvYVnJqtPFv9+DPa+oIDrmhswNvrNCe52c
         be+CGWlHDXVoFrFdly3rvZLQsFR6U+jpv1iIrkjPrwWuuc/dDRKZInai4xrwN4qQLyMO
         eLTSQex6ptCXF3kd4l3D19Ncy30vHzGGaoyI/woU97d96+0xsQLSRwf2TkBaD7XXu8mA
         IteB04ettGTZ73ulOY7L/1B7MASI8jOsn+RY9CF6uxmQssHB8kJnVg8bWBoHbZeNR1hY
         NU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWi/VzmHnEk2/VtWXzNTzI6tNMuksJ3FgOnDItF6gHE=;
        b=Ol+cTsFbQtW2hS3Y2RvRe0gYR2hEykDo8BAj8fr2+98WG7Ug+C0Y/9mAAcHIHmeQiw
         nprCNoT+pJdGDlxPL8NA/EqmqgZDyGp5PUsTmjlaJUnds8PLKdvVyvWXeLPCGHs4Pwen
         A3rRe4GP353TxXr7sFEGmObK1dkpn55+khag13LONUxJP5YQ64eEN1pa1lYkGg62bzGi
         TPZPSrWwo+fcOzjZXbEYcjZzof7R+NstTlWEidKOZkpb4zmAS0P05yKsMv8PCP22TfTO
         n/unwH8rZuaLumZKQJntntramqlE5V6Nz3Q/y+1ZPQGUMHMZmw6ZhiK5TLTTE9/5yKxV
         hrSQ==
X-Gm-Message-State: AOAM533gdtSdIFEFN+S92Rhhy/NhlMdY+l15xWxaOq9SY+TSDTYQRBxy
        w3Ord2sWlEPSJ+7QCSJr2YYtv+V2PfTwO96Ow+A=
X-Google-Smtp-Source: ABdhPJwh+xmHmgWWUczLKE9+twP3Ew4lKECg1cszwMOtqaxD+MmnKLr7vIvmnlfRHcTHMZw0tvD2MM6DM+bWzK5rnMY=
X-Received: by 2002:a17:90a:141:: with SMTP id z1mr4768164pje.87.1643134592962;
 Tue, 25 Jan 2022 10:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-18-yury.norov@gmail.com> <bab43c36-a3de-f96a-6530-4ab3a55b8ba0@linux.intel.com>
In-Reply-To: <bab43c36-a3de-f96a-6530-4ab3a55b8ba0@linux.intel.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 25 Jan 2022 10:16:21 -0800
Message-ID: <CAAH8bW8jcNM--D_cUtWNe7cbBjVAENq_SEapDcPjit=BB705JA@mail.gmail.com>
Subject: Re: [PATCH 17/54] gpu: drm: replace cpumask_weight with cpumask_empty
 where appropriate
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 1:28 AM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 23/01/2022 18:38, Yury Norov wrote:
> > i915_pmu_cpu_online() calls cpumask_weight() to check if any bit of a
> > given cpumask is set. We can do it more efficiently with cpumask_empty()
> > because cpumask_empty() stops traversing the cpumask as soon as it finds
> > first set bit, while cpumask_weight() counts all bits unconditionally.
> >
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >   drivers/gpu/drm/i915/i915_pmu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> > index ea655161793e..1894c876b31d 100644
> > --- a/drivers/gpu/drm/i915/i915_pmu.c
> > +++ b/drivers/gpu/drm/i915/i915_pmu.c
> > @@ -1048,7 +1048,7 @@ static int i915_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
> >       GEM_BUG_ON(!pmu->base.event_init);
> >
> >       /* Select the first online CPU as a designated reader. */
> > -     if (!cpumask_weight(&i915_pmu_cpumask))
> > +     if (cpumask_empty(&i915_pmu_cpumask))
> >               cpumask_set_cpu(cpu, &i915_pmu_cpumask);
> >
> >       return 0;
> >
>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>
> I see it's a large series which only partially appeared on our mailing
> lists.

The series is here: https://lkml.org/lkml/2022/1/23/223
The branch: https://github.com/norov/linux/tree/bitmap-20220123

> So for instance it hasn't got tested by our automated CI. (Not
> that I expect any problems in this patch.)

Would be great if you give a test for the whole series, thanks!

> What are the plans in terms of which tree will it get merged through?

For the patches that will not be merged by maintainers of corresponding
subsystems, I'll use my bitmap branch and send it to linux-next.

Thanks,
Yury
