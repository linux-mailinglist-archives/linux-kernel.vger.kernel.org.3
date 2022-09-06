Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4E45AF65A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiIFUus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiIFUup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:50:45 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83D1642B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:50:42 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3378303138bso108887067b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2h+TR+OM3EYWoBqpTcjOAGgQzsk2TDQnX5OQcnEmOAY=;
        b=Ho5zZG/uahZESDKa+F0uVzl1DcPMJs3pBR3YTFdsYd4TVgIAnglmMYKw7IsipePhlI
         f7MIPmCHSDpWgsuQZra63QsDQjqJJnh8BiLDuylcwrCVHBAjbq7YZ/6Yj6rT0CGMxjsP
         TKGfuGHYqcgRA9iHZhCxEFybEyib41uQeH64arO0bB6zhYjQJAVYRfp1UYq4QNLwESMc
         wCK9YUYbpFIAUePlYovxsNMuvoYbVZp0fdnRP/JD7TInueuN77OD9n3yXUiJ4vIbmeW5
         7uJjMlqhUVQgEMCU5sa7tDyC6wSHMUKBQ7Qw9e1J8IME6qq4+frCPoAWPSPVvD/W2PVG
         U97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2h+TR+OM3EYWoBqpTcjOAGgQzsk2TDQnX5OQcnEmOAY=;
        b=TcRn3VTwzlTD4Y0P3tDWCXxqipHAnQ3TDXPmi93eVK6rPEncPPnDs/HifEcUVkhxEV
         ln5MBLe42tMIBWEcinJD2d7ILBExKBd4Fb8jjq54I8WkYbHxbj4bu/AcpOlspf42dvW9
         MyqdRbyB42PYJb/M/rkkaoHVuPMbJwLIohJX/wlpL/DQit1at1SC2DgVIrtGvdWgDRTY
         iRRaJh9PwKmAio2yydom23QPwKujrfLxnQn7qOf9cKJbN+DUELZDH60SXtLEw7Xi5xBp
         C5htFjuQy+RWCKkRL1SXJFh/Wgiqc6IRULlioWWXPAgrUWaPMmCKIhG99vUNxPhX4ZT1
         57Rg==
X-Gm-Message-State: ACgBeo1er28ZuITuoOPNqr0z93Gu1/ifmOXmb5lfjEUQ3/6fX5xNergU
        8+Heh6IiwacuXMgOJETSrRglPs3Ok3+lzUdfKAAUiw==
X-Google-Smtp-Source: AA6agR5vGOqK/tsrCshfD4rzlsnoeZHiXp1Rv7xMZmLNFZ1B8DFvAgMN1jNF83x8JwtdB984sjtsTSl8Fi2D/gbT/jw=
X-Received: by 2002:a81:9c2:0:b0:345:4830:1943 with SMTP id
 185-20020a8109c2000000b0034548301943mr446551ywj.86.1662497442006; Tue, 06 Sep
 2022 13:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220903000210.1112014-1-namhyung@kernel.org> <CANpmjNMPh5QjdxXtrCc5FApjgzV=81CNNiwbeg_rE3NxN_WCZw@mail.gmail.com>
 <YxdA1CVzy9hzE3i1@kernel.org> <CAM9d7ci2ZujdY75DUtZA+f=fru7yh8VJrj8-r2RgZetu57u61A@mail.gmail.com>
In-Reply-To: <CAM9d7ci2ZujdY75DUtZA+f=fru7yh8VJrj8-r2RgZetu57u61A@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 6 Sep 2022 22:50:05 +0200
Message-ID: <CANpmjNMHX2S-29Tyw+zKyaWT7saAiEegxbJapQFs7duJTTncdw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip sigtrap test on old kernels
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
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

On Tue, 6 Sept 2022 at 20:31, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Sep 6, 2022 at 5:45 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Sat, Sep 03, 2022 at 08:52:01AM +0200, Marco Elver escreveu:
> > > On Sat, 3 Sept 2022 at 02:02, Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > If it runs on an old kernel, perf_event_open would fail because of the
> > > > new fields sigtrap and sig_data.  Just skip the test if it failed.
> > > >
> > > > Cc: Marco Elver <elver@google.com>
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/tests/sigtrap.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> > > > index e32ece90e164..7057566e6ae4 100644
> > > > --- a/tools/perf/tests/sigtrap.c
> > > > +++ b/tools/perf/tests/sigtrap.c
> > > > @@ -140,6 +140,7 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
> > > >         fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
> > > >         if (fd < 0) {
> > > >                 pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
> > > > +               ret = TEST_SKIP;
> > >
> > > Wouldn't we be interested if perf_event_open() fails because it could
> > > actually be a bug? By skipping we'll be more likely to miss the fact
> > > there's a real problem.
> > >
> > > That's my naive thinking at least - what do other perf tests usually
> > > do in this case?
> >
> > Yeah, I was going to try and check if this is the only way that, with
> > the given arguments, perf_event_open would fail, but its better to at
> > least check errno against -EINVAL or something?
>
> EINVAL would be too generic and the kernel returns it in many places.
> I really wish we could have a better error reporting mechanism.
>
> Maybe we could retry perf_event_open with sigtrap and sig_data cleared.
> If it succeeded, then we can skip the test.  If it still failed, then report
> the error.  But it still couldn't find a bug in the sigtrap code.
> What do you think?

Yes, that's what I meant, that it could point out an issue with
sigtrap perf_event_open().

If there's no clear way to determine if it's just not supported or a
bug, it'd be better to leave it as-is.

Some other options:

1. Provide a way to disable certain tests, if it's known they will
fail for otherwise benign reasons i.e. no support.

2. Provide a command line option to skip instead of fail tests where
perf_event_open() returns some particular errnos. The default will be
fail, but you can then choose to trust that failure of
perf_event_open() means no support, and pass the option.
