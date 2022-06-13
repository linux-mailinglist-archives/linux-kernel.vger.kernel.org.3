Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901E054A1A6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiFMVkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348713AbiFMVke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:40:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46577265C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:40:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o16so8701303wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=rf94aztMu8q6rJgTVG04OMc6+8p9+/WQev0gF3cZvlM=;
        b=Pl0LzCNNO1w/frcAU/VtV4pRni7lpWufyksBYg0ZjtOrKos8OdbiT+BoNYZhqWB6vb
         DqwWQvTKHu6DZxoUX/MgPfuu/UcM1oInkCc+GJkXtYbQEHZPQB31n+lkNgWYZlY0V7Xm
         6YTPGTM14U3I+EPmnPxEdEfs/HYpaWNRnT7DLvQwj/GwZCx4o9QpkDebYbKzz93BBi6F
         zNJT2tIXpjY2ANM2FYpdibtmasHlDk7qyrTK3LCud9iClK4ulKXDwRaXO7WBUumzg5r+
         8kM/NHKyFFypCRWcrJgOG8xcJdrJ0hg8hk3wg31N+WhEL57L6LodHQjNV1rDXdiNAUtQ
         BVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rf94aztMu8q6rJgTVG04OMc6+8p9+/WQev0gF3cZvlM=;
        b=6FEjO/H+VrTI05ZI7Tld6MhqS+EXuWAIR5rrXjP9CUm3LTxc+CtanNnD0IGVM7vX7v
         tHVHF9b2sgraigUbLQsC94T+b2uI7k2OHCy4c8L3qENL/qsAJZQ1hRBZnnncddGWWZ1w
         BTF9VQr02yIm4H1DJ4UC7E/s6MilsGlJWqgBza21VVF+b3+BxEoaS7rc4NrHICYKTUF+
         mIhnlfHV9P/uX46PaSWMDn+yvBNcLiuGhjVTXvUnpVWWcB3woR/9bsSRVnTjxC3L1Yka
         fmb5x2KZ5TgvOGSu5idKx7dmUuhO5yEX7p33LQamshLcmaeCW1DllahxMbw7jgP4d8WL
         MkFA==
X-Gm-Message-State: AJIora8bfEuWpaTuEsyrHgLvbmVjdXsIE1zkeEBVY8IBNf/ynU4nOXW1
        tPTBTrhAepSipqaPWr5enf/UbUvPjaYXr8nenLi2pg==
X-Google-Smtp-Source: AGRyM1v2CFKS3VbNIYRjIRPm7XoBld31D8Xpf3SH96B8OY0SShLb01jlm5GHh/K4lKLv/PUop92YuIMJdNNl1gEXkdo=
X-Received: by 2002:a05:6000:1a8d:b0:219:e3f2:c092 with SMTP id
 f13-20020a0560001a8d00b00219e3f2c092mr1696458wry.375.1655156431586; Mon, 13
 Jun 2022 14:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220526224515.4088240-1-irogers@google.com>
In-Reply-To: <20220526224515.4088240-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Jun 2022 14:40:19 -0700
Message-ID: <CAP-5=fUQZgA_aaiv2t2Y8DMfU90LvgSrKpc3wn9EQW0m-2N=ww@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] JSON output for perf stat
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Claire Jensen <clairej735@gmail.com>
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

On Thu, May 26, 2022 at 3:45 PM Ian Rogers <irogers@google.com> wrote:
>
> Parsing the CSV or text output of perf stat can be problematic when
> new output is added (columns in CSV format). JSON names values and
> simplifies the job of parsing. Add a JSON output option to perf-stat
> then add unit test that parses and validates the output.
>
> This is a resend of two v2 patches:
> https://lore.kernel.org/lkml/20210813220754.2104922-1-cjense@google.com/
> https://lore.kernel.org/lkml/20210813220936.2105426-1-cjense@google.com/
> with a few formatting changes and improvements to the linter.

Still looking for reviews for these 2 changes. Thanks!
Ian

> v5. Drops the merged CSV check, fixes a json test issue found by
>     Arnaldo and a typo.
>
> v4. Does some minor fixes to the json linter.
>
> v3. There is some tidy up of CSV code including a potential memory
>     over run in the os.nfields set up caught by sanitizers. To
>     facilitate this an AGGR_MAX value is added. v3 also adds the CSV
>     testing.
>
> v2. Fixes the system wide no aggregation test to not run if the
>     paranoia is wrong. It also makes the counter-value check handle
>     the "<not counted>" and "<not supported>" cases.
>
> Claire Jensen (2):
>   perf stat: Add JSON output option
>   perf test: Json format checking
>
>  tools/perf/Documentation/perf-stat.txt        |  21 +
>  tools/perf/builtin-stat.c                     |   6 +
>  .../tests/shell/lib/perf_json_output_lint.py  |  95 +++++
>  tools/perf/tests/shell/stat+json_output.sh    | 147 +++++++
>  tools/perf/util/stat-display.c                | 384 +++++++++++++-----
>  tools/perf/util/stat.c                        |   1 +
>  tools/perf/util/stat.h                        |   2 +
>  7 files changed, 550 insertions(+), 106 deletions(-)
>  create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
>  create mode 100755 tools/perf/tests/shell/stat+json_output.sh
>
> --
> 2.36.1.124.g0e6072fb45-goog
>
