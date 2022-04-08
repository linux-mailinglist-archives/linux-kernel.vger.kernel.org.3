Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922664F9109
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiDHIoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiDHIoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:44:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E957220B03;
        Fri,  8 Apr 2022 01:41:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l9-20020a05600c4f0900b0038ccd1b8642so5618122wmq.0;
        Fri, 08 Apr 2022 01:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S5+1UtlGwYKkF7opqY/T3NqGuhDfW8xZhok4zd8KdsM=;
        b=ITBoi9cOPvG3YVC3BNTn6KLguMVBmjaMQeAkXpKE7PI+X6POzR3tYOcoERHugUccnJ
         0vJe0rpTkxTECnMRU+J1eZg0wHG8hOGsZakSdL9wfTFBtX9+VWTnwCGgAvvBHglP+hfl
         Lu2ypLBavTWx3kMEpqgyw1eJppDgeLq88KtnBMRR4adzni+ErT3ZfD34FyqIV7mQ1PoP
         AdWTAtvVfIr6NuTkTv9ThTtllAFjLc+0EXXo8eENivM38+LzC0Ld5PI+PQ9Y/pfXltP3
         SxdZSIWwClVq/Z3YMEd3qqdeJSIX5N1IbXnxDpDWbNEHj/YG4Bi7g40a1qUCjkqGZyj8
         t1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S5+1UtlGwYKkF7opqY/T3NqGuhDfW8xZhok4zd8KdsM=;
        b=fTGa8lXrgl0N1NLIeI9ujCKpbdC/SXUD0N5IQ0cJQqzf3mTBT6qr0rcYS1mDGVHcGR
         aLz//vLUDlc1XJKokSuRt1NFjHA+i4HJ1kmXWTkp21GpaWWv0Q5H1ikR+h8gpPsEoTrX
         FHNu3n6uLLyCeJIUJma/uzMeDuYB2q+xc0WPfaVVVk00PUQJfwNMIxbxnmmC94kkaENw
         G+HdM0m/3l9EzefOke2qZQngryDC/FfC4+zH67bkepNZxBzcUa1hKVAAXVyeqSCaWj21
         mYzmsArpiNAJjGpQuDWDmgaoITZKR1l7g+MFB/cjID+IMpHSsE4RBpyUkGt0QXQRLcLq
         tGPg==
X-Gm-Message-State: AOAM533okIBogah7hZwSvi6MmuTgJ5Q/cUc9kPSPWP0a+OAEKecGf0/H
        J9wSGP/AYVMEnMuiX0zoFYmEgta90IJX9+hpvrscdjsHePA=
X-Google-Smtp-Source: ABdhPJzteP0F4FeuB37n4ePWBpBTPOQDsn99XBM32u7k9FR5x3dN571qljfJwS1XtyftSl+yEsENpx0fnAhcDbotQnM=
X-Received: by 2002:a05:600c:4141:b0:38e:714e:5ca9 with SMTP id
 h1-20020a05600c414100b0038e714e5ca9mr15733089wmm.175.1649407315261; Fri, 08
 Apr 2022 01:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <676075ca-4d5d-7388-61ac-42a0b9f1ed50@intel.com>
 <20220408021428.18009-1-chengdongli@tencent.com> <c4ce0947-e21f-d3b1-96b8-f2778a2e35e6@intel.com>
In-Reply-To: <c4ce0947-e21f-d3b1-96b8-f2778a2e35e6@intel.com>
From:   Bryton Lee <brytonlee01@gmail.com>
Date:   Fri, 8 Apr 2022 16:41:43 +0800
Message-ID: <CAC2pzGdMFmtV8YNR4DszoATjM80uYNwrnW5As6vgBsyXVcWueA@mail.gmail.com>
Subject: Re: [PATCH v3] perf test tsc: Fix error message report when not supported.
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, ak@linux.intel.com,
        likexu@tencent.com, chengdongli@tencent.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 3:58 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 08/04/2022 5.14, Chengdong Li wrote:
> > By default `perf test tsc` does not return the error message
> > when the child process detected kernel does not support. Instead,
> > the child process print error message to stderr, unfortunately
> > the stderr is redirected to /dev/null when verbose <= 0.
> >
> > This patch did three things:
> > - returns TEST_SKIP to the parent process instead of TEST_OK when
> >   perf_read_tsc_conversion() is not supported.
> > - add a new subtest of testing if TSC is supported on current
> >   architecture by moving exist code to a separate function.
> >   It avoids two places in test__perf_time_to_tsc() that return
> >   TEST_SKIP by doing this.
> > - extended test suite definition to contain above two subtests.
> >   Current test_suite and test_case structs do not support printing
> >   skip reason when the number of subtest less than 1. To print skip
> >   reason, it is necessary to extend current test suite definition.
> >
> > Changes since v2:
> > - refine error message format.
> > - refine commit log message according to Adrian's review comments.
> >
> > Changes since v1 (thanks for the feedback from Adrian Hunter):
> > - rebase commit to current source.
> >
> > Signed-off-by: Chengdong Li <chengdongli@tencent.com>
>
> It is better to try to consistently use the same email address
> for the same person for git logs, unless you have a sensible
> reason not to.
>

Sorry for the inconvenience. I can not use my company email account to send
patches via `git send-email` due to lack of email protocol support in
our email system.

> So in this case it looks like you should use the same email
> address for the "From:" and "Signed-off-by:".  Note you can
> optionally put the "From:" line before the commit message e.g.
>
> From: Chengdong Li <chengdongli@tencent.com>
>
> By default `perf test tsc` does not return the error message
> ...

Thanks for your guidance, I will resend this patch again.

>
> Otherwise you can add:
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
>
>
> > ---
> >  tools/perf/tests/perf-time-to-tsc.c | 36 +++++++++++++++++++++--------
> >  1 file changed, 27 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
> > index d12d0ad81801..cc6df49a65a1 100644
> > --- a/tools/perf/tests/perf-time-to-tsc.c
> > +++ b/tools/perf/tests/perf-time-to-tsc.c
> > @@ -47,6 +47,17 @@
> >       }                                       \
> >  }
> >
> > +static int test__tsc_is_supported(struct test_suite *test __maybe_unused,
> > +                               int subtest __maybe_unused)
> > +{
> > +     if (!TSC_IS_SUPPORTED) {
> > +             pr_debug("Test not supported on this architecture\n");
> > +             return TEST_SKIP;
> > +     }
> > +
> > +     return TEST_OK;
> > +}
> > +
> >  /**
> >   * test__perf_time_to_tsc - test converting perf time to TSC.
> >   *
> > @@ -70,7 +81,7 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
> >       struct perf_cpu_map *cpus = NULL;
> >       struct evlist *evlist = NULL;
> >       struct evsel *evsel = NULL;
> > -     int err = -1, ret, i;
> > +     int err = TEST_FAIL, ret, i;
> >       const char *comm1, *comm2;
> >       struct perf_tsc_conversion tc;
> >       struct perf_event_mmap_page *pc;
> > @@ -79,10 +90,6 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
> >       u64 test_time, comm1_time = 0, comm2_time = 0;
> >       struct mmap *md;
> >
> > -     if (!TSC_IS_SUPPORTED) {
> > -             pr_debug("Test not supported on this architecture");
> > -             return TEST_SKIP;
> > -     }
> >
> >       threads = thread_map__new(-1, getpid(), UINT_MAX);
> >       CHECK_NOT_NULL__(threads);
> > @@ -124,8 +131,8 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
> >       ret = perf_read_tsc_conversion(pc, &tc);
> >       if (ret) {
> >               if (ret == -EOPNOTSUPP) {
> > -                     fprintf(stderr, " (not supported)");
> > -                     return 0;
> > +                     pr_debug("perf_read_tsc_conversion is not supported in current kernel\n");
> > +                     err = TEST_SKIP;
> >               }
> >               goto out_err;
> >       }
> > @@ -191,7 +198,7 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
> >           test_tsc >= comm2_tsc)
> >               goto out_err;
> >
> > -     err = 0;
> > +     err = TEST_OK;
> >
> >  out_err:
> >       evlist__delete(evlist);
> > @@ -200,4 +207,15 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
> >       return err;
> >  }
> >
> > -DEFINE_SUITE("Convert perf time to TSC", perf_time_to_tsc);
> > +static struct test_case time_to_tsc_tests[] = {
> > +     TEST_CASE_REASON("TSC support", tsc_is_supported,
> > +                      "This architecture does not support"),
> > +     TEST_CASE_REASON("Perf time to TSC", perf_time_to_tsc,
> > +                      "perf_read_tsc_conversion is not supported"),
> > +     { .name = NULL, }
> > +};
> > +
> > +struct test_suite suite__perf_time_to_tsc = {
> > +     .desc = "Convert perf time to TSC",
> > +     .test_cases = time_to_tsc_tests,
> > +};
>


-- 
Best Regards

Bryton.Lee
