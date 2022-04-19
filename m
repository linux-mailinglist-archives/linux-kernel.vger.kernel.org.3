Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A2F507BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357951AbiDSVVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240664AbiDSVVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:21:15 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D46F381AB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:18:31 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id v133so13368110vsv.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYMQrJatxv+ymWWVnT4mFSHb3fDjJ92SZBZYGIm/cFg=;
        b=LPDQdpVf05m8GyTpA6fFr1g32B4J76C3vOWOorBkGk1nar/zDTlLRXC5WYR5iFLb+c
         wFcebErih28bmiMyt6TiDI+oQ2VZ/Qmc+IO1CH5GMmcyEb43+bCMf5eQBN3zimFLiRC4
         gAB5IJl9MOCqEJuqzUfnRuxicZoRCJ4C5wGnAmOb2+T7IZQysH3EEpgZYWudN4JQ025p
         EjTwpnv/lUXQzOz2t+IEnaDWcTUPAKkpEE5EIkfUIwonFjxu92gTuAhxwu7wyjbOp/X/
         xfhTmHD0jxuS7+s1wCHQPd5YL+qT/Xs6S40P0VducbRlUILhDCm/FV1yPhL7CWgH4aev
         bKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYMQrJatxv+ymWWVnT4mFSHb3fDjJ92SZBZYGIm/cFg=;
        b=TMLX6LziavU7qGvaLwtEZ9ArzbOUGGtrCwxQ6eR2qpWmuE98np9C2qAy3WraIEaD1k
         L0RuFckE+c8lzSONte64cX4zvp+NLYxFx2I4yL/9oYo1lwSWIzpEPDb4u0E5zg8Vlsqv
         83LXiJC18Xp5Re5ZL6LaYe3eidOA9uM+MJH5ibzL4PGXHnQzdB2Zg68Jr6sMWGj1t465
         QKn4Eb5k7Lm8am2gKIS5qsQs1noLx0jaKWmoTo6hYXT30bprtnP89DnnXFTWhfQqeMJb
         DMZPhaabDdGsYHhZHIG2Q4dHMeuAH8nTkm2uIX8VQkDKzX5UOB/8t+791jOorgAvllTS
         2IpA==
X-Gm-Message-State: AOAM531blcdZ66yqBzrNUqmWbwiWpwKxtIWqeqJbV40/ImyWfKoPhtEf
        Mfwnm4OlSReI5E4HbTXd/a4kL7X/B/wsJ4RKNkHXDg==
X-Google-Smtp-Source: ABdhPJw2RLuxOaVIo0nZFbFyHcZiPjKxLRlSTp/Qm+7gqVR9tFsx2zVK8dgQAUXucgB8+yFhqsqvD5RjwCCiJTI8JMc=
X-Received: by 2002:a05:6102:3107:b0:32a:e37:4544 with SMTP id
 e7-20020a056102310700b0032a0e374544mr5442087vsh.14.1650403110152; Tue, 19 Apr
 2022 14:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220304110351.47731-1-simon.wy@alibaba-inc.com>
 <20220304110351.47731-2-simon.wy@alibaba-inc.com> <YiIyrFn7upPEouVt@hirez.programming.kicks-ass.net>
 <0c119da1-053b-a2d6-1579-8fb09dbe8e63@linux.alibaba.com> <YidREXNn2AtI3V1c@hirez.programming.kicks-ass.net>
 <271bc186-7ffb-33c8-4934-cda2beb94816@linux.alibaba.com> <Yi8fELo+k9gmkJIa@hirez.programming.kicks-ass.net>
 <05861b8c-2c7c-ae89-613a-41fcace6a174@linux.alibaba.com> <e50c5307-8b2d-9338-0acc-9375b76c211d@linux.alibaba.com>
 <c33fd91c-8f8f-c82f-4e03-8799f3b8cd28@linux.alibaba.com> <20220419205738.GZ2731@worktop.programming.kicks-ass.net>
In-Reply-To: <20220419205738.GZ2731@worktop.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 19 Apr 2022 14:18:18 -0700
Message-ID: <CABPqkBSnJcioAeppPXtURu9+qSFpompWMrs-A=FdD76a6-+S8A@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] perf/x86: improve the event scheduling to
 avoid unnecessary pmu_stop/start
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Wen Yang <simon.wy@alibaba-inc.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        mark rutland <mark.rutland@arm.com>,
        jiri olsa <jolsa@redhat.com>,
        namhyung kim <namhyung@kernel.org>,
        borislav petkov <bp@alien8.de>, x86@kernel.org,
        "h. peter anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Going back to the original description of this patch 2/2, it seems the
problem was that you expected PINNED events to always remain in
the same counters. This is NOT what the interface guarantees. A pinned
event is guaranteed to either be on a counter or in error state if active.
But while active the event can change counters because of event scheduling
and this is fine. The kernel only computes deltas of the raw counter. If you
are using the read() syscall to extract a value, then this is totally
transparent
and you will see no jumps. If you are instead using RDPMC, then you cannot
assume the counter index of a pinned event remains the same. If you do, then
yes, you will see discrepancies in the count returned by RDPMC.  You cannot
just use RDPMC to read a counter from user space. You need kernel help.
The info you need is in the page you must mmap on the fd of the event. It
shows the current counter index of the event along with sequence number and
timing to help scale the count if necessary. This proper loop for
RDPMC is documented
in include/uapi/linux/perf_event.h inside the perf_event_mmap_page definition.

As for TFA, it is not clear to me why this is a problem unless you
have the RDPMC problem
I described above.


On Tue, Apr 19, 2022 at 1:57 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Apr 19, 2022 at 10:16:12PM +0800, Wen Yang wrote:
> > We finally found that TFA (TSX Force Abort) may affect PMC3's behavior,
> > refer to the following patch:
> >
> > 400816f60c54 perf/x86/intel:  ("Implement support for TSX Force Abort")
> >
> > When the MSR gets set; the microcode will no longer use PMC3 but will
> > Force Abort every TSX transaction (upon executing COMMIT).
> >
> > When TSX Force Abort (TFA) is allowed (default); the MSR gets set when
> > PMC3 gets scheduled and cleared when, after scheduling, PMC3 is
> > unused.
> >
> > When TFA is not allowed; clear PMC3 from all constraints such that it
> > will not get used.
> >
> >
> > >
> > > However, this patch attempts to avoid the switching of the pmu counters
> > > in various perf_events, so the special behavior of a single pmu counter
> > > will not be propagated to other events.
> > >
> >
> > Since PMC3 may have special behaviors, the continuous switching of PMU
> > counters may not only affects the performance, but also may lead to abnormal
> > data, please consider this patch again.
>
> I'm not following. How do you get abnormal data?
>
> Are you using RDPMC from userspace? If so, are you following the
> prescribed logic using the self-monitoring interface?
