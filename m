Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44F0478A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbhLQLxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhLQLxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:53:12 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CF4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 03:53:12 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j18so3584544wrd.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 03:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fmSFeBMdoKB6nNlLBhYwLQX9VUtS9B/Ded0JWBpXr30=;
        b=KaW7fnSq7/x6dnLqp7/ORQGvsGjd3ampuFNmmeWWbAOrumsqS6e707B9ZAuNyh4Lnh
         pXyp26r3Q5+4n+AY11NBgF2rCel6tsO9MOH258wNNRn/JYrp0JVOUOZBa2WuQh+0tddk
         a4Y8VlFRjZLB05kXNofdLdEPYGxMNQFZsWJ3fKrj7CX02lHxvMbSF8NtvU2nf6etiFig
         afh+WfDies3nKkvMm/yWRT2ll4WawCGa8jDL/ylTaUSMwKb1h4faUzSiJhE2GOk8biFI
         xNzTsO9+bbZus3OP88+KzAdYRSuM1zIgkplMzoTA54A59oz8n+RDLJFXcsqlbMa9XSmo
         3g5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fmSFeBMdoKB6nNlLBhYwLQX9VUtS9B/Ded0JWBpXr30=;
        b=QgAGxcQPrwYiS7bxPkthNrPDeh+JJ3qr30bagFeLsK66gc8A2DaC283M788NQjWWTc
         v2Lbt0lZm/kvAJoekgVGHiNBwe9ASE39+QZjDguqkkl7UWHQvqRWmjhe2AYcUqpj9aeL
         UnVSmtACem9WeG6W4NZOsDmaCOJLz5qfNcYPHQqVUl41qspbTvlhu5CUIQ989KclCRJz
         4LFFz5a27wTQBejO7nA/KB5/oxihEUPB2NB7bwgJmB5YCuv7jEuyc5Pl/UXwcUs4ZcWI
         LW4SUTklRyvQ5J9WMYlkOt/yi6YB+xNoOGWeLe1bxdY8XqzUnVjOUVMSB44bDgXzGZgE
         WKfA==
X-Gm-Message-State: AOAM532BUOEjfGMFhChXplJlhaktyJ0kKI92v3UijsD+pZtVh1H+kapi
        Rguw5h3ckRMtNz9pM2YJ4Rcqdxoqgs0uuR0s0Ltc+Q==
X-Google-Smtp-Source: ABdhPJwuyp3x8ZyunFVNbTsrTBCxHBA9wfNE70ycAmi6k2MDX934plSAKdwEC81FvMD32uuoPa53cbVLOZjLzB2jF6M=
X-Received: by 2002:adf:ec09:: with SMTP id x9mr2295080wrn.111.1639741990497;
 Fri, 17 Dec 2021 03:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20211208160907.749482-1-james.clark@arm.com> <20211208160907.749482-2-james.clark@arm.com>
 <b52ef2f3-9e30-59a6-2aea-e46c93915868@arm.com> <b61ef2e3-e573-4867-af5d-fd5fabece4b1@arm.com>
 <20211210172220.GA1238770@p14s> <CAJ9a7VgBxO0-R4jX6+-Vu10DtcsOeMiq9YrPkEEFQ=6ixNXXVQ@mail.gmail.com>
 <d884f96c-1d4c-119e-5e83-3674260a9694@arm.com>
In-Reply-To: <d884f96c-1d4c-119e-5e83-3674260a9694@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 17 Dec 2021 11:52:59 +0000
Message-ID: <CAJ9a7VgUGhjOq2p5oitnCj9HY=vA8Byfi+-W8OB8949-Q49=oA@mail.gmail.com>
Subject: Re: [PATCH 2/3] coresight: Fail to open with return stacks if they
 are unavailable
To:     James Clark <James.Clark@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James

On Fri, 17 Dec 2021 at 09:41, James Clark <james.clark@arm.com> wrote:
>
>
>
> On 13/12/2021 09:48, Mike Leach wrote:
> > Hi James,
> >
> > A couple of points - relating mainly to docs:
> >
>
> Hi Mike,
>
> Thanks for the feedback. I was in the process of adding some docs and
> ran into this https://lkml.org/lkml/2021/12/16/1087 so I went to fix
> that first. Now I will add some more details and resubmit.
>
> > 1. Activating branch broadcast overrides any setting of return stack.
> > As a minimum there needs to be a documentation update to reflect this
> > -Setting both options is not prohibited in hardware - and in the case
> > where we can use branch broadcast over a range both are then relevant.
> >
>
> Do you mean that if branch broadcast and return stacks are both requested,
> but branch broadcast is limited to a range, return stacks will only be
> available outside that branch broadcast range? But if branch broadcast is
> enabled for all ranges there will be no return stacks at all?
>

Correct - you may want to branch broadcast over a small ranges, but
otherwise use return stack to decrease the amount of trace in other
areas.
Once the complex config sets are accepted upstream then this set-up
will be possible by writing a config to do this.

> > 2. A documented note to reflect that choosing this option will result
> > in a significant increase in the amount of trace generated - possible
> > danger of overflows, or less actual instructions covered. In addition
> > perhaps documents could reflect the intended use-case for this option,
> > given the disadvantages.
> >
>
> Will do.
>
> > 3. Has this been tested in a situation where it will be of use?
> > Testing against static code images will show the same decoded trace
> > output as not using branch broadcast. (although the packet dumps will
> > show additional output)>
> > Given a primary use is for situations where code is patched or
> > dynamically altered at runtime - then this can affect the full decode
> > output. If the code is being patched to only alter the branch
> > addresses then decode should work against static images.
> > If, however, we are tracing code that adds in new branches, on top of
> > NOPs for example, then the decoding against the original static image
> > will be wrong, as the image will have the NOPs, rather than the branch
> > instructions so the apparent location of E atoms will be in a
> > different position to the actual code. Is there anything in perf that
> > will ensure that the patched code is presented to the decoder?
> >
> > If there are potential decode issues - these too need documenting.
> >
>
> I'm not sure this should be a blocking issue for this set. Branch broadcast
> could already be enabled by setting the mode via sysfs. And the perf decode
> part isn't necessarily a step in the workflow, maybe someone wants to gather
> data for another tool.
>

Someone could set this in sysfs - when collecting data via sysfs.  In
this case they would not be using perf for decode anyway as you say.

What you have added here is a new method for perf to set this feature
and perf always starts off with a clean configuration - then adds
according to command line options.
Therefore this will be the first time anyone will have been able to
set this for a perf session.

It there are potential limitations, then we need to be clear about
them - then users of perf, and other hypothetical tools can make a
good choice about if this option is appropriate - and we avoid mailing
list complaints (or at least can point to the docs) if users find
issues that they were warned about!

> I will do some testing after this change though, but I imagine we would have
> had issues reported it it wasn't working already which lowers the priority.
>

really depends on what was tested! If it is being used over static
code then the subsequent decode will be fine,

Regards

Mike

> James
>
> > Other than the documents and testing,  I cannot see any issues with
> > this patch set in terms of setting and enabling the option.
> >
> > Regards
> >
> > Mike
> >
> >
> > On Fri, 10 Dec 2021 at 17:22, Mathieu Poirier
> > <mathieu.poirier@linaro.org> wrote:
> >>
> >> Hi James,
> >>
> >> On Thu, Dec 09, 2021 at 11:13:55AM +0000, James Clark wrote:
> >>>
> >>>
> >>> On 09/12/2021 11:00, Suzuki K Poulose wrote:
> >>>> On 08/12/2021 16:09, James Clark wrote:
> >>>>> Maintain consistency with the other options by failing to open when they
> >>>>> aren't supported. For example ETM_OPT_TS, ETM_OPT_CTXTID2 and the newly
> >>>>> added ETM_OPT_BRANCH_BROADCAST all return with -EINVAL if they are
> >>>>> requested but not supported by hardware.
> >>>>>
> >>>>> The consequence of not doing this is that the user may not be
> >>>>> aware that they are not enabling the feature as it is silently disabled.
> >>>>>
> >>>>> Signed-off-by: James Clark <james.clark@arm.com>
> >>>>> ---
> >>>>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++----
> >>>>>   1 file changed, 9 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >>>>> index d2bafb50c66a..0a9bb943a5e5 100644
> >>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >>>>> @@ -674,10 +674,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
> >>>>>       }
> >>>>>         /* return stack - enable if selected and supported */
> >>>>> -    if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
> >>>>> -        /* bit[12], Return stack enable bit */
> >>>>> -        config->cfg |= BIT(12);
> >>>>> -
> >>>>> +    if (attr->config & BIT(ETM_OPT_RETSTK)) {
> >>>>> +        if (!drvdata->retstack) {
> >>>>> +            ret = -EINVAL;
> >>>>> +            goto out;
> >>>>> +        } else {
> >>>>> +            /* bit[12], Return stack enable bit */
> >>>>> +            config->cfg |= BIT(12);
> >>>>> +        }
> >>>>
> >>>> nit: While at this, please could you change the hard coded value
> >>>> to ETM4_CFG_BIT_RETSTK ?
> >>>>
> >>> I started changing them all because I had trouble searching for bits by name but then
> >>> I thought it would snowball into a bigger change so I undid it.
> >>>
> >>> I think I'll just go and do it now if it's an issue here.
> >>
> >> I can apply this set right away and you send another patch to fix all hard coded
> >> bitfields or you can send another revision with all 4 patches included in it
> >> (bitfields fix plus these 3).  Just let me know what you want to do.  And next
> >> time please add a cover letter.
> >>
> >> Thanks,
> >> Mathieu
> >>
> >>>
> >>>> Otherwise, looks good to me
> >>>>
> >>>> Suzuki
> >
> >
> >



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
