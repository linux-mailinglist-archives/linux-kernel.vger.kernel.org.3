Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBE452986F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiEQDxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiEQDx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:53:26 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB3D2E0B5;
        Mon, 16 May 2022 20:53:25 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-e93bbb54f9so22711301fac.12;
        Mon, 16 May 2022 20:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nD103x5fG+vRGXoi7A4nPbMr2Eg2Wxzgpc5qUXVp5jI=;
        b=RRpgskJCNxhqaARNCxhStVb+aI0xR+VZMvRpA8Nw68C3SwMOKSp4keJ3fs0/erXMpM
         tYX2r5DDNZvuSWCPK/bfOAzgAWBGOoQBzQy7n4lIM910aGUkNeS91j0yQv+LKokbDvsr
         lIZhOZrHa9LysAQPhjFCBqHYiWPKkwA9gXcVKDyGf29zozemnyZEvYLrIQcGXJr/KI6+
         rkNJCIeTFSMe42jZlnqRgZEoT06CfhGeVhXS9OZs1vB7h4XiYiS0cxwPj3X+NgAX+cqs
         /mN8++gU6di0N8GOq5H6VAf9NAR7CrEAjCXDrRHFSlZBBpX1ijgHJfkLDoK6SrkYKjPw
         0FQQ==
X-Gm-Message-State: AOAM532gIr9uOEDmbRNXUc1xgOXYX5YK3iq1WRdbqCwfIWDZ5cNKnB9O
        r7oRShZ+tjjtRgut5r1mIOpzXZNz2qGyxXszrSUyx6wL
X-Google-Smtp-Source: ABdhPJxz9J36HewhEH+fLy18JPu2xXLtQpHjd2qWD7qMIeXAWkkGIq8Jh338fRYZeHSZiT3ccS1kfIGpg5DzOmcCAtA=
X-Received: by 2002:a05:6870:d1cd:b0:e1:e7ee:faa0 with SMTP id
 b13-20020a056870d1cd00b000e1e7eefaa0mr17153127oac.5.1652759605259; Mon, 16
 May 2022 20:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220513040519.1499333-1-irogers@google.com> <20220513040519.1499333-2-irogers@google.com>
In-Reply-To: <20220513040519.1499333-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 16 May 2022 20:53:14 -0700
Message-ID: <CAM9d7cjfCF+9SUGrO-WQ_OSAyq0U+idS8SCNFv+CoL6A+0RKGQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf test: Skip reason for suites with 1 test
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
> When a suite has just 1 subtest, the subtest number is given as -1 to
> avoid indented printing. When this subtest number is seen for the skip
> reason, use the reason of the first test.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/tests/builtin-test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index fac3717d9ba1..33fcafa0fa79 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -137,10 +137,10 @@ static bool has_subtests(const struct test_suite *t)
>
>  static const char *skip_reason(const struct test_suite *t, int subtest)
>  {
> -       if (t->test_cases && subtest >= 0)
> -               return t->test_cases[subtest].skip_reason;
> +       if (!t->test_cases)
> +               return NULL;
>
> -       return NULL;
> +       return t->test_cases[subtest >= 0 ? subtest : 0].skip_reason;
>  }
>
>  static const char *test_description(const struct test_suite *t, int subtest)
> --
> 2.36.0.550.gb090851708-goog
>
