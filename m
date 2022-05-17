Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A59052985F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiEQDnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiEQDnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:43:05 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654CB23BCE;
        Mon, 16 May 2022 20:43:01 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id v65so20931448oig.10;
        Mon, 16 May 2022 20:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfCcbYh50CkyfYSUX07YnV+CadQTQKAbHumUgKo7SVY=;
        b=8AgL+Yn5KK4F3OBDEv3/9cujAWYiuhkqLMmWQztrvkMjjB8ogDmdykhFRBjO2SxWhC
         cslC1rSwIM5wGHleNQZQl6A3Ywns/i4sDNK+pUX/OgwE+qo32z8DyVRf8uAsGDpQEIK0
         5h7/3RE+r9GRcMyFuhyo1Vofpd8JPbjGjm8zQiYFleRQHYn0sjFZrRRlDsJPwaHCUc5L
         ET6KvNX2O6XazHdLL+/RbkAB00MxoLBfbdlLJ+r64ZJ22d0Lq6jqknJqSoNxgsOJilBu
         eNzQjiQNEsK1n+ORJTGxtpLRPdJn/HcIeNyghiJlawz847aImlqdoaaakeuI4bR/Dg6x
         F0Ww==
X-Gm-Message-State: AOAM533CVyan4S47jfejSk8hFv/o1wIrVI6JLJFPMrrLA46dngnmyriy
        avf4Dw5xB25lUkz7oVFh7PHvbMirIOUlynNMca8=
X-Google-Smtp-Source: ABdhPJzPxl7PLeTa0zBb28kzCLiPRofRnTZ7ipEja5DIYHSk9s5VA51aEmUHdDYoLRr3+bHtCPTr9trfpKN1nQW+siQ=
X-Received: by 2002:a05:6808:16ac:b0:2f9:52e5:da90 with SMTP id
 bb44-20020a05680816ac00b002f952e5da90mr14951433oib.5.1652758980720; Mon, 16
 May 2022 20:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220513040519.1499333-1-irogers@google.com> <20220513040519.1499333-5-irogers@google.com>
In-Reply-To: <20220513040519.1499333-5-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 16 May 2022 20:42:49 -0700
Message-ID: <CAM9d7ciD=uH7rNSmK5oJEksPYsagwpQA1J-MC3N0RpzLaakscg@mail.gmail.com>
Subject: Re: [PATCH 4/7] perf test: Basic mmap use skip
To:     Ian Rogers <irogers@google.com>
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 9:05 PM Ian Rogers <irogers@google.com> wrote:
>
> If opening the first event fails for basic mmap it is more likely
> permission related that a true error. Mark the test as skip in this
> case and add a skip reason.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/mmap-basic.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index c3c17600f29c..32f0a63fa157 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -31,7 +31,7 @@
>   */
>  static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>  {
> -       int err = -1;
> +       int err = TEST_FAIL;
>         union perf_event *event;
>         struct perf_thread_map *threads;
>         struct perf_cpu_map *cpus;
> @@ -83,6 +83,14 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
>                 evsels[i] = evsel__newtp("syscalls", name);
>                 if (IS_ERR(evsels[i])) {
>                         pr_debug("evsel__new(%s)\n", name);
> +                       if (i == 0) {
> +                               /*
> +                                * Failure to open first event is more likely
> +                                * related to permissions so flag the failure as
> +                                * a skip.
> +                                */
> +                               err = TEST_SKIP;

This is not about perf_event_open() but it accesses
tracefs to get the type number of the trace event.

The evsel__newtp() seems to return the errno in a
negative number.  It'd be better to check if it's
-EACCES actually.

Thanks,
Namhyung


> +                       }
>                         goto out_delete_evlist;
>                 }
>
> @@ -166,4 +174,14 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
>         return err;
>  }
>
> -DEFINE_SUITE("Read samples using the mmap interface", basic_mmap);
> +static struct test_case tests__basic_mmap[] = {
> +       TEST_CASE_REASON("Read samples using the mmap interface",
> +                        basic_mmap,
> +                        "permissions"),
> +       {       .name = NULL, }
> +};
> +
> +struct test_suite suite__basic_mmap = {
> +       .desc = "Read samples using the mmap interface",
> +       .test_cases = tests__basic_mmap,
> +};
> --
> 2.36.0.550.gb090851708-goog
>
