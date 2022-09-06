Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490A85AF820
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 00:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiIFWwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 18:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIFWwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 18:52:17 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F1385FB7;
        Tue,  6 Sep 2022 15:52:16 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id v2-20020a056830090200b006397457afecso9045411ott.13;
        Tue, 06 Sep 2022 15:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=m9lRH378v02nM3+uAQbjodYmGXDtyYl3efgPvWYoaJw=;
        b=14imkXoi7XDyFpktufeVwBmKfFrNjUutP8v1ss7qquaM7rHvlz0XztYtbXd2ECj5Ui
         pAT1teSMzauLCb/cZ9RUKULDT/Q9MNCFHX6/V9nkk5qQiruf9m7xAN2gjBLo5v3oL3A5
         hKoaNOp3cpmLL54eVAwUKuD09JCwHlJPbuWXabjOmdSLbEuKlrrxeIsvRGOqcPRGZ0rL
         ub+fERHLwP/wbaj370qqv4WNZSLUuqmqw+LSfEQpeXlepwZHumWATuhmrvDitn7qrU/M
         0I8usP3CirfVML0iG+2mCEr4a23Mf88ZAIYIvLnfzJJDg7YrAkedynb9FlZHjCDrP0q5
         9ETg==
X-Gm-Message-State: ACgBeo2mJqIg3J+QfyCVJM/suR0jeURGPuyoC7FCsPwtK7hPu27eTFOY
        Qw0AVhUQwgZlOd/C5ErbRStfo9tP8ou7zA6pRaE=
X-Google-Smtp-Source: AA6agR7oKSSizgcg1FnRj1qVpnPwVmnQkqBreO7IGDIbBbkLWNlhj4aN8o7718CX5YjQm6uzJAVGEj8ataDGJSbnyiE=
X-Received: by 2002:a9d:6a59:0:b0:638:92fd:d5b4 with SMTP id
 h25-20020a9d6a59000000b0063892fdd5b4mr311940otn.247.1662504735143; Tue, 06
 Sep 2022 15:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220903000210.1112014-1-namhyung@kernel.org> <CANpmjNMPh5QjdxXtrCc5FApjgzV=81CNNiwbeg_rE3NxN_WCZw@mail.gmail.com>
 <YxdA1CVzy9hzE3i1@kernel.org> <CAM9d7ci2ZujdY75DUtZA+f=fru7yh8VJrj8-r2RgZetu57u61A@mail.gmail.com>
 <CANpmjNMHX2S-29Tyw+zKyaWT7saAiEegxbJapQFs7duJTTncdw@mail.gmail.com> <F172EC4B-1CFC-46A5-9DC3-146EDF8F5BDF@gmail.com>
In-Reply-To: <F172EC4B-1CFC-46A5-9DC3-146EDF8F5BDF@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 6 Sep 2022 15:52:04 -0700
Message-ID: <CAM9d7chkXTtuzc+5eHq7vvTcw05RS6MqYK-WTVrfZxPaC_ppjQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip sigtrap test on old kernels
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 1:56 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On September 6, 2022 5:50:05 PM GMT-03:00, Marco Elver <elver@google.com> wrote:
> >On Tue, 6 Sept 2022 at 20:31, Namhyung Kim <namhyung@kernel.org> wrote:
> >>
> >> On Tue, Sep 6, 2022 at 5:45 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >> >
> >> > Em Sat, Sep 03, 2022 at 08:52:01AM +0200, Marco Elver escreveu:
> >> > > On Sat, 3 Sept 2022 at 02:02, Namhyung Kim <namhyung@kernel.org> wrote:
> >> > > >
> >> > > > If it runs on an old kernel, perf_event_open would fail because of the
> >> > > > new fields sigtrap and sig_data.  Just skip the test if it failed.
> >> > > >
> >> > > > Cc: Marco Elver <elver@google.com>
> >> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >> > > > ---
> >> > > >  tools/perf/tests/sigtrap.c | 1 +
> >> > > >  1 file changed, 1 insertion(+)
> >> > > >
> >> > > > diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> >> > > > index e32ece90e164..7057566e6ae4 100644
> >> > > > --- a/tools/perf/tests/sigtrap.c
> >> > > > +++ b/tools/perf/tests/sigtrap.c
> >> > > > @@ -140,6 +140,7 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
> >> > > >         fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
> >> > > >         if (fd < 0) {
> >> > > >                 pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
> >> > > > +               ret = TEST_SKIP;
> >> > >
> >> > > Wouldn't we be interested if perf_event_open() fails because it could
> >> > > actually be a bug? By skipping we'll be more likely to miss the fact
> >> > > there's a real problem.
> >> > >
> >> > > That's my naive thinking at least - what do other perf tests usually
> >> > > do in this case?
> >> >
> >> > Yeah, I was going to try and check if this is the only way that, with
> >> > the given arguments, perf_event_open would fail, but its better to at
> >> > least check errno against -EINVAL or something?
> >>
> >> EINVAL would be too generic and the kernel returns it in many places.
> >> I really wish we could have a better error reporting mechanism.
> >>
> >> Maybe we could retry perf_event_open with sigtrap and sig_data cleared.
> >> If it succeeded, then we can skip the test.  If it still failed, then report
> >> the error.  But it still couldn't find a bug in the sigtrap code.
> >> What do you think?
> >
> >Yes, that's what I meant, that it could point out an issue with
> >sigtrap perf_event_open().
> >
> >If there's no clear way to determine if it's just not supported or a
> >bug, it'd be better to leave it as-is.
>
> perf could go fancy and try to add a probe using a source file+line where older kernels would fail 8-)
>
> Anyway, perf already does all sorts of kernel capability checks, perhaps this is one of can for sure detect it's something available :-/
>
> One new way could be to look at BTF?

Yeah, we could check BTF if it had the attr.sigtrap field and skip if not.
Let me see how I can do that. :)

Thanks,
Namhyung
