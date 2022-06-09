Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903B954432A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbiFIFae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiFIFac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:30:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFB5227CD6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:30:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n185so11876198wmn.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 22:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqVxPTyMN5LSk5+AeVkxx+W87CD161pDvzbwjFm6+gQ=;
        b=ppfX5cL9GJVYrxGHnfjXRVJ07D6rTaIh988wnDEoyi6c5Ox34r0eWU/UBDtEIU0ZuZ
         p/ODifY6UvgRrGPpvrnG4hT+W9mQHF7OEapC4RQqObUxbNYz4JRXui6JQ0KTenlgJpgt
         GNTW9/8r5K0Qsh35abiBd4trapkZK81bnXoH/PlI6AcGDCOxB2jENnq48GI4pcTTzsz0
         K51lyN5dhq0Rv6ZjPqS6XhUtN5tKBzqftrATAVfH+5o735FpkWM87uwSh3tZ38OxPjWb
         T5SgRHO6SwQJWZ+Y2moVO/o0HG7r1yen+bxSMZgoGg2XwZ7QgQoxHP5UDHcOsxol/ljt
         bDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqVxPTyMN5LSk5+AeVkxx+W87CD161pDvzbwjFm6+gQ=;
        b=kERLbcWIeyIir6nEi4MRE0qj5cG9+kpbnK3ftszdyansNwY9JDH5xgtki4UnRr/W09
         moasnLAX6wlc3j3so0MpsHI6BfUDZr7J0FIieAhuhE7lo99FyI5NcHNpDiqdRMB6+Mgw
         Lvaj80/4muhmEyZjGapN2ASc3y+76bIk6ESiHljCLLxL4w7sKMOsa7Zim26T9JiwKZAQ
         ZmrMvbtPsszzFaFExIEzgDq1dtwbcYYvFZk72FkOiPp2iTMqYPEkAvQfzEcnZkkcbE/b
         gr/MFxHoZC08+fVJALRyxF78mli9S+spaSP9BY8KJ6IcAil40yUClB9YI3bREjfpbP44
         3YAw==
X-Gm-Message-State: AOAM533a2+tOrGA5TPXWdIYC2pXwemtfhQYV2ApynsEr9AvONItkjI2Z
        6Zv/JMGNGrFPnSAa9QftMHiTOPZmF8TeUU/xGc1swQ==
X-Google-Smtp-Source: ABdhPJy+P7056WQ8engnYC1mHTb9UsiXlHIixlBMPvMOgpTq+KmQ2uox3NULMOxAH6LXfVKDgLQEOlLlMRqr4ZBxD4k=
X-Received: by 2002:a05:600c:19cb:b0:397:51db:446f with SMTP id
 u11-20020a05600c19cb00b0039751db446fmr1434807wmq.182.1654752629440; Wed, 08
 Jun 2022 22:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220527020653.4160884-1-irogers@google.com>
In-Reply-To: <20220527020653.4160884-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 8 Jun 2022 22:30:17 -0700
Message-ID: <CAP-5=fUqBaoDwJB4-rizoP6tYnZAw6YW+wROVYqiNzj7iG+G-Q@mail.gmail.com>
Subject: Re: [PATCH] perf expr: Allow exponents on floating point values
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
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

On Thu, May 26, 2022 at 7:06 PM Ian Rogers <irogers@google.com> wrote:
>
> Pass the optional exponent component through to strtod that already
> supports it. We already have exponents in ScaleUnit and so this adds
> uniformity.
>
> Reported-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping. Simple fix with tests, PTAL. Thanks,
Ian

> ---
>  tools/perf/tests/expr.c | 2 ++
>  tools/perf/util/expr.l  | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index d54c5371c6a6..5c0032fe93ae 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -97,6 +97,8 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
>         ret |= test(ctx, "2.2 > 2.2", 0);
>         ret |= test(ctx, "2.2 < 1.1", 0);
>         ret |= test(ctx, "1.1 > 2.2", 0);
> +       ret |= test(ctx, "1.1e10 < 1.1e100", 1);
> +       ret |= test(ctx, "1.1e2 > 1.1e-2", 1);
>
>         if (ret) {
>                 expr__ctx_free(ctx);
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index 0a13eb20c814..4dc8edbfd9ce 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -91,7 +91,7 @@ static int literal(yyscan_t scanner)
>  }
>  %}
>
> -number         ([0-9]+\.?[0-9]*|[0-9]*\.?[0-9]+)
> +number         ([0-9]+\.?[0-9]*|[0-9]*\.?[0-9]+)(e-?[0-9]+)?
>
>  sch            [-,=]
>  spec           \\{sch}
> --
> 2.36.1.124.g0e6072fb45-goog
>
