Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B470E4F7E1C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244826AbiDGLhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244808AbiDGLhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:37:04 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA62939AD;
        Thu,  7 Apr 2022 04:35:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r7so3333698wmq.2;
        Thu, 07 Apr 2022 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BTjjsMviqQQ88WLrJjMAv2kpQcRNOPqMaJdVZGNwFqw=;
        b=R6uglBK6TpnMEoqoBNx8c29PkXVIkYZqL8zEmxAyDQOx4Qfhz0/VqW93CLzJ4ukVFk
         KKYL0xJNUJd23pXJPKzve/Idy2GbwLG6yto0nsijOBIBu1ZzQDHOokt2ow43HPy5HQ+P
         +cGlEFYVBjXA/MFM8YTIcJFnvmfHxeEgxLrDizQaEfJU+zLI5RnXOfRzBJnMxt6nySQA
         n+znckYRlJ2Ez5W7Mr6adfZFqxH1YnKa0sfngh5WvBQJbNGHPZiIZ7Fpx6Egr9rjKZ9x
         VaFuRaRDguJygRF/SDEbNRDS6IzEFv4ScjRwxfyWLfAU+OYqNisWeCDFl1Z6FerMdCbH
         TBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BTjjsMviqQQ88WLrJjMAv2kpQcRNOPqMaJdVZGNwFqw=;
        b=1obR7RqvGDKltHJKXmV0f2mITAD7XnyiaU7DNeR49DMHR7SXqJNYJ/lYiqqvx4SYiE
         5smupt0/5/dsG8t3WRbBlM0Xegg2w+KLUGF88edbL1LS1HwoCe2/hh8JNNJ0/L/sUfYJ
         tYc71brVJRtPyUR5VMbL6Rb3UUKINMYF80HpGBHwotOOv1ue3LpNZ2t5S3HoWveveMFt
         kMb7j/9+q5ArU7zi4fagerFsx+XeMb+y9fRRC71PJLqjTE6g+SCkoTDLQYSLRTVuBxKc
         L8mYAaaRydA73J4gTO6/bH0Nw9ubD/LvsCkdju/p/qK8860RlSJo0P/kmoZ0Q8OEl2cv
         +q/A==
X-Gm-Message-State: AOAM533TCR8D1sVUaHTsWKXV3MeMWsWFq7RNi7XVlM10TnS8pVpDMaX0
        8nWO829+KcsPeNqP3pFzvi5Px3csrjgr4Irdzzw=
X-Google-Smtp-Source: ABdhPJzR0oB2jVEk4x7pHKQdNCVRye2ERWW24d237Jq4XXJE7we9+a25pneCqZG5kOqKJUIfBhzIGCSgRC7/SRTwXko=
X-Received: by 2002:a05:600c:4fce:b0:38d:a58:6d16 with SMTP id
 o14-20020a05600c4fce00b0038d0a586d16mr12035867wmq.11.1649331303159; Thu, 07
 Apr 2022 04:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220406100609.65239-1-chengdongli@tencent.com> <ce2c3c4f-3751-312a-5fa6-0f98330067fe@intel.com>
In-Reply-To: <ce2c3c4f-3751-312a-5fa6-0f98330067fe@intel.com>
From:   Bryton Lee <brytonlee01@gmail.com>
Date:   Thu, 7 Apr 2022 19:34:51 +0800
Message-ID: <CAC2pzGe0Kn9Vzyx7S5_5A338shYG-DXgY=CS38zpJYk3m3_N7A@mail.gmail.com>
Subject: Re: [PATCH v2] perf test tsc: Fix error message report when not supported.
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

On Thu, Apr 7, 2022 at 2:59 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 06/04/2022 13.06, Chengdong Li wrote:
> > By default `perf test tsc` does not return the error message
> > when child process detected kernel does not support. Instead, child
> > process print error message to stderr, unfortunately the stderr is
> > redirected to /dev/null when verbose <= 0.
> >
> > This patch did three things:
> > - returns TEST_SKIP to parent process instead of TEST_OK when
> >   perf_read_tsc_conversion() is not supported.
> > - add a new subtest of testing if TSC is supported on current
> >   architecture by moving exist code to a separate function.
> > - extended test suite definition to contain above two subtests.
> >
> > Changes since v1 (thanks for the feedback from Adrian Hunter):
> > - rebase commit to current source.
> >
> > Signed-off-by: Chengdong Li <chengdongli@tencent.com>
> > ---
> >  tools/perf/tests/perf-time-to-tsc.c | 36 +++++++++++++++++++++--------
> >  1 file changed, 27 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
> > index d12d0ad81801..fc7c380af5a0 100644
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
> > +             pr_debug("Test not supported on this architecture");
>
> Message better ending with "\n" I think
OK, I will fix it.
>
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
> > +                     pr_debug("perf_read_tsc_conversion is not supported in current kernel");
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
>
> The 2nd test case runs anyway, so I am not sure another
> test case is needed?

Yes. But, I think there are two reasons to add two subtests: 1).
Original TSC support test is embedded in test__perf_time_to_tsc(), and
returns TEST_SKIP
if current architecture doesn't support it.  Thus there are two places
that return TEST_SKIP in test__perf_time_to_tsc() if we don't move TSC
support
to another subtest. 2). Current test_suite and test_case structs don't
support printing skip_reason if there is no subtest. To print skip
reason we need more than 1 subtests.

>
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
