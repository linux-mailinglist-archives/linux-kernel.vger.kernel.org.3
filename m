Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB295AF399
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiIFSbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiIFSbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:31:17 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBE232056;
        Tue,  6 Sep 2022 11:31:16 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so8618724otd.12;
        Tue, 06 Sep 2022 11:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KTMC4sgGs4iMTIRHGtHX14ygc35A9XeknD+0EJXhRfs=;
        b=tuB3YEpGuU0bj3K2vM2zYY5zKFkkLbBkhtKfkzXAO8IgevDSoE5OF9CdNAB0Szt71A
         Mv68yu3e/cBo2gkqWQiLg+M2ApFFRvKDjImDOh+zOwqyAvFyJmJ/aXWi5Vv89E/gsS6P
         x/t08t1kOP26ooHXQfGrpY2U2F0yXz8Poyo36ySe1x0PTip9nHKasEmCwFQ8kgykc8Mr
         dSaqlBOr42/cJW+xxlxoO2YLbhxf5L/4n4voJ0q0JOh6uubhWh7dU/dLdRYtX0jckHLA
         wZqSNr20zPGN5X2Fkn+Mu+IiMke1UpWQUG3rFWGSm0ry/ppsbNRNHvGccnffJGPFi8B/
         PGjQ==
X-Gm-Message-State: ACgBeo12Qg6KBeIiXGSTskVNAkSjDyGOhYgrXM6p/D/fEijPXwy/kc/o
        ng0kSFNOjux/y4Mxm+FiItuLp7l9DVHkyGbEYR4ZUdO2
X-Google-Smtp-Source: AA6agR5wIKuqeybuaOjh8IZNxiROzu/OFeaNSVGnVmevPf9aFwUSW1gEMxZT2SMQ83z9S3QPMVk6pFV0NPNc9oeKCmw=
X-Received: by 2002:a9d:6f18:0:b0:638:b4aa:a546 with SMTP id
 n24-20020a9d6f18000000b00638b4aaa546mr21388276otq.124.1662489075965; Tue, 06
 Sep 2022 11:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220903000210.1112014-1-namhyung@kernel.org> <CANpmjNMPh5QjdxXtrCc5FApjgzV=81CNNiwbeg_rE3NxN_WCZw@mail.gmail.com>
 <YxdA1CVzy9hzE3i1@kernel.org>
In-Reply-To: <YxdA1CVzy9hzE3i1@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 6 Sep 2022 11:31:04 -0700
Message-ID: <CAM9d7ci2ZujdY75DUtZA+f=fru7yh8VJrj8-r2RgZetu57u61A@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip sigtrap test on old kernels
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Marco Elver <elver@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
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

On Tue, Sep 6, 2022 at 5:45 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Sat, Sep 03, 2022 at 08:52:01AM +0200, Marco Elver escreveu:
> > On Sat, 3 Sept 2022 at 02:02, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > If it runs on an old kernel, perf_event_open would fail because of the
> > > new fields sigtrap and sig_data.  Just skip the test if it failed.
> > >
> > > Cc: Marco Elver <elver@google.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/tests/sigtrap.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> > > index e32ece90e164..7057566e6ae4 100644
> > > --- a/tools/perf/tests/sigtrap.c
> > > +++ b/tools/perf/tests/sigtrap.c
> > > @@ -140,6 +140,7 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
> > >         fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
> > >         if (fd < 0) {
> > >                 pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
> > > +               ret = TEST_SKIP;
> >
> > Wouldn't we be interested if perf_event_open() fails because it could
> > actually be a bug? By skipping we'll be more likely to miss the fact
> > there's a real problem.
> >
> > That's my naive thinking at least - what do other perf tests usually
> > do in this case?
>
> Yeah, I was going to try and check if this is the only way that, with
> the given arguments, perf_event_open would fail, but its better to at
> least check errno against -EINVAL or something?

EINVAL would be too generic and the kernel returns it in many places.
I really wish we could have a better error reporting mechanism.

Maybe we could retry perf_event_open with sigtrap and sig_data cleared.
If it succeeded, then we can skip the test.  If it still failed, then report
the error.  But it still couldn't find a bug in the sigtrap code.
What do you think?

Thanks,
Namhyung
