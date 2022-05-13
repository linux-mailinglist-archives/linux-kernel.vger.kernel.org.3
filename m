Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7CF526663
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382182AbiEMPmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbiEMPm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:42:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D849F3121C
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:42:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t6so11975026wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5/uoQI8/5f91IWn7HyX+VbvfqchZrWzzvoEosENEnw=;
        b=TMh1gbWYvFcu4PyqxycGL+5ZJihf+935oScy1aDp44PO6uDK/f1Mcbp8ELoJO5Q+2z
         NO/bvDwGsdVCEl3u8pioB/pVA/sZIoVbSwmZD/PQ2Z/Nov73hYo4/irGTpE26R+kJY/e
         6sNnSTAIGfmCuaqwkyGAKf969LrASgS+BUXts1SUyh4TYdWscvLAS9iNChlMyYm3ZYmO
         S7dQL3Qnhhb/Jk/eABywE17OMn7/mRXAdKwJ6Fnh2IetHkCSBTnsanXGTfjbhbYtpwBS
         yFZ13bcNTCWq/lg5sxvMUnHmf7h5B9qKFcX0ZbA9EUOhbOvHTEDWsy95cMJWzSzEgt79
         PEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5/uoQI8/5f91IWn7HyX+VbvfqchZrWzzvoEosENEnw=;
        b=g4glcm17cFn1nu3cxkvS4nsUSp9uMP+eiZ7AlRnijLeMWZTrI5XyB95/hXhPtvamTZ
         BzLHIiIcHqh2yWeM9EOmpFxBrEC8K2y+U3o8HP3NC3K4YYekXY97jRwh5oU9eJY1pOdU
         KxybeVn+HPJHvUUe0RE2kJ1dqCPIrYvCFGRouy9l0cnb6j5CHlUMe2zt2iXPx8tXxaRl
         XJnkC35D2QRR52qYbT4cmXsytUp/a3c6C3HPgPcGovmVJSntLByMhUHjCZxbAseXKX4b
         XFAEIey5ZUgEUReb/BM9SACheD4XQtRMJznHdWr6o1o7XfqkspKkLlelthibM9Fd2LFC
         J2Jg==
X-Gm-Message-State: AOAM532KajRMIMRUkoyHeXf0D1AluK1BK35QSilse37rpH70hWDqD0Eg
        dlSw5kLfNwa02aYQbsjx9sigjGM1Dc5GQeoCNcBS4g==
X-Google-Smtp-Source: ABdhPJzszfA1XvQWtTBZcFgsXr9ZUTHASL4KfmRbzxaiIZmS0P3iO9wEA7gsX7fBDbKX/UcnyuA06xQ129+Br36Q9+w=
X-Received: by 2002:adf:dd0e:0:b0:20a:c689:f44a with SMTP id
 a14-20020adfdd0e000000b0020ac689f44amr4538143wrm.40.1652456537266; Fri, 13
 May 2022 08:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220513040519.1499333-1-irogers@google.com> <20220513040519.1499333-2-irogers@google.com>
 <6341384c-b3e6-fbe5-f29f-e0db114bd439@huawei.com>
In-Reply-To: <6341384c-b3e6-fbe5-f29f-e0db114bd439@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 13 May 2022 08:42:04 -0700
Message-ID: <CAP-5=fX+PfnyHRc=-sQMo1_mGLzCJ77pSfzXXHVUEOHtVFGwxA@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf test: Skip reason for suites with 1 test
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Fri, May 13, 2022 at 8:29 AM John Garry <john.garry@huawei.com> wrote:
>
> On 13/05/2022 05:05, Ian Rogers wrote:
> > When a suite has just 1 subtest, the subtest number is given as -1 to
> > avoid indented printing. When this subtest number is seen for the skip
> > reason, use the reason of the first test.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/tests/builtin-test.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index fac3717d9ba1..33fcafa0fa79 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -137,10 +137,10 @@ static bool has_subtests(const struct test_suite *t)
> >
> >   static const char *skip_reason(const struct test_suite *t, int subtest)
> >   {
> > -     if (t->test_cases && subtest >= 0)
> > -             return t->test_cases[subtest].skip_reason;
> > +     if (!t->test_cases)
> > +             return NULL;
> >
> > -     return NULL;
> > +     return t->test_cases[subtest >= 0 ? subtest : 0].skip_reason;
> >   }
>
> I was not sure which suite has a single tastcase, so I experimented for
> libpfm4 by deleting a testcase so it has only 1x remaining, I get:
>
> before your change:
> john@localhost:~/acme/tools/perf> sudo ./perf test 63
> 63: Test libpfm4 support : Skip
>
> after:
>
> john@localhost:~/acme/tools/perf> sudo ./perf test 63
> 63: Test libpfm4 support : Skip (not compiled in)
>
> Although it is odd to have a single sub-test, is there a reason for
> which we don't print its name? We print the name when there are multiple
> sub-tests.

The reason was to replicate the existing "perf test" behavior before
the kunit style transition. The main place we get tests with a single
sub-test is from the DEFINE_SUITE macro:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/tests/tests.h?h=perf/core#n67
I agree it looks kind of weird and was inheriting the data structures
from kunit and the format of the output from perf test.

Thanks,
Ian

> Thanks,
> John
