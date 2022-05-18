Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5E252B0E7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 05:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiERDtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 23:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiERDs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 23:48:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECE7A30AF
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 20:48:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j24so848366wrb.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 20:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4JYs9ujmgM+C4dNGsGcuiGQ+uGcv46nKJhVscrSEdyc=;
        b=Ai/cv780zL6Dn+9TTJdlYAlIIqSL/7ILMsKW/TBlPXsB1K9iBO3NddqQvRthwBu0mU
         8XqHkC0tYu7C29VR7QuBzvh/Q10Er2eC2bI5lZOyUZXOoFTOaIOTDrw4LUHwWDNou4h0
         Rnm8jnmx3FtuUsR8nbPTi+mFkiYSej4kNukfFZcPhjOG6dS9BcEKnXxLjfhJIA4J/Uxr
         m39rXywrx/dmnfKr3jSlT39iZrNYBixauiM2l2UrQL+1Fovrhjd5NFzUn+AfxWL+xiBX
         H0RK+840CB2h4Lg9CwgFPLc3e62fh+IMzl8/gJuBYKcJ65jbe3Dm/HZgFWTpmnqE+yKM
         wyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4JYs9ujmgM+C4dNGsGcuiGQ+uGcv46nKJhVscrSEdyc=;
        b=YpBb87nBsd4kO5NrvDs8H4XskXW5o9XMtz+asyT0U8ILXluwKMHdlnOIPqodhXDuJD
         Ja8HATgrr2Ph8aW1h7O85cxrDgYEyXS740rWLcO+wt95Y4zPZZVtH1J9wvjewzH0mFK8
         UIAavLFL2BGVGScSE51hXreQ31DVcWbbeLjOC+sMzdgzosdAI6ZPr6v855+856CgMyqi
         jg2gnT89/Vi7tceUDbYSd9Y2yY2r2jBwuqqplE1gDfifeIE61OZJOx/wtgU0ZFumgUBt
         u2YSHTYm4LsLvdQ/VPTL2XuTMgWQKD3uMr0CCm7SMOEeDtXqL6HLhy0qoVzPAj84d4hr
         qhAw==
X-Gm-Message-State: AOAM533ErH4iixDo10us8V4U1jwBQPNveFNqGmVnTeVhKjA6hQFIwW+K
        GBhD7ZjrbJxqmslcXUmLqr/6TFyjpJNuSostpV3Bnw==
X-Google-Smtp-Source: ABdhPJx1an0zbKi5aCIuzObOxcygx3WowhwJBUcvgNAUe1kM/D6tAZ+En6I1j0F3aNxXM3oiqpY79lHmWl4l+IAYEn4=
X-Received: by 2002:a05:6000:78b:b0:20d:101b:2854 with SMTP id
 bu11-20020a056000078b00b0020d101b2854mr8232457wrb.300.1652845733419; Tue, 17
 May 2022 20:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220513040519.1499333-1-irogers@google.com> <20220513040519.1499333-5-irogers@google.com>
 <CAM9d7ciD=uH7rNSmK5oJEksPYsagwpQA1J-MC3N0RpzLaakscg@mail.gmail.com>
In-Reply-To: <CAM9d7ciD=uH7rNSmK5oJEksPYsagwpQA1J-MC3N0RpzLaakscg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 17 May 2022 20:48:41 -0700
Message-ID: <CAP-5=fWBDBHcsWOkVzC-r51grgTrbqJOHrZCpym6nHEUiFVV8g@mail.gmail.com>
Subject: Re: [PATCH 4/7] perf test: Basic mmap use skip
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 8:43 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Thu, May 12, 2022 at 9:05 PM Ian Rogers <irogers@google.com> wrote:
> >
> > If opening the first event fails for basic mmap it is more likely
> > permission related that a true error. Mark the test as skip in this
> > case and add a skip reason.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/mmap-basic.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> > index c3c17600f29c..32f0a63fa157 100644
> > --- a/tools/perf/tests/mmap-basic.c
> > +++ b/tools/perf/tests/mmap-basic.c
> > @@ -31,7 +31,7 @@
> >   */
> >  static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> >  {
> > -       int err = -1;
> > +       int err = TEST_FAIL;
> >         union perf_event *event;
> >         struct perf_thread_map *threads;
> >         struct perf_cpu_map *cpus;
> > @@ -83,6 +83,14 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
> >                 evsels[i] = evsel__newtp("syscalls", name);
> >                 if (IS_ERR(evsels[i])) {
> >                         pr_debug("evsel__new(%s)\n", name);
> > +                       if (i == 0) {
> > +                               /*
> > +                                * Failure to open first event is more likely
> > +                                * related to permissions so flag the failure as
> > +                                * a skip.
> > +                                */
> > +                               err = TEST_SKIP;
>
> This is not about perf_event_open() but it accesses
> tracefs to get the type number of the trace event.
>
> The evsel__newtp() seems to return the errno in a
> negative number.  It'd be better to check if it's
> -EACCES actually.

Thanks, done in v2.

Ian

> Thanks,
> Namhyung
>
>
> > +                       }
> >                         goto out_delete_evlist;
> >                 }
> >
> > @@ -166,4 +174,14 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
> >         return err;
> >  }
> >
> > -DEFINE_SUITE("Read samples using the mmap interface", basic_mmap);
> > +static struct test_case tests__basic_mmap[] = {
> > +       TEST_CASE_REASON("Read samples using the mmap interface",
> > +                        basic_mmap,
> > +                        "permissions"),
> > +       {       .name = NULL, }
> > +};
> > +
> > +struct test_suite suite__basic_mmap = {
> > +       .desc = "Read samples using the mmap interface",
> > +       .test_cases = tests__basic_mmap,
> > +};
> > --
> > 2.36.0.550.gb090851708-goog
> >
