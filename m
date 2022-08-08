Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEEE58CFF4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244459AbiHHVzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbiHHVzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:55:51 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986AF264E;
        Mon,  8 Aug 2022 14:55:50 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-10ec41637b3so12043832fac.4;
        Mon, 08 Aug 2022 14:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YMM16MbCFLtKN+/DJnf0CX9M13gA/YQhzSl0zvJPDe4=;
        b=qLSn7nKuSF+OMpDBFof6q/rYWu88ZtHpDSeKPgW7VdGUc4uTUWzNy57OHLbKBtVp8U
         lvPCnMM1zEgpjwNgdJgFPwLQD/JHExC0OeIu/zu9jgcVxiRmOquDvqBc5oYmcTJKRwTs
         FgFJ0bs4oc06GI9+VXEGG2H3ccGKukpXK0Ulm9ENybljuBTShyePUd4OM7u4QMlE5rtK
         +jpXjEKVNJoSlsnUvNcSpAVbDIOlQBQlzdmP0UyqZ1vIlAy/SccUwi9WXC+XO51YKNXy
         tJErX5uQ8BtmJho3UHk0NPPrwcrlb+lQiYMTlWnQTW0Lbo1P7ky40Go0EixVLZpCyMeE
         7Zkg==
X-Gm-Message-State: ACgBeo0fUxrjjUOLpgknTpT+qI2QT7NsFhWNw7YXRy96y3npCN39t/pI
        4WA3DhN/BZsrAmMf0+6Fo1JsWi35fa/Ct4qGRVQ=
X-Google-Smtp-Source: AA6agR7axXUFueNjegLyLSeyiAPEMqpegVipvTDZ1g/rWbmH0x8Ux7rC5CeehG+IvbK+WQ+f3D+39eT7/8lvRIEX76g=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr9573010oab.92.1659995749780; Mon, 08
 Aug 2022 14:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220805200105.2020995-1-irogers@google.com>
In-Reply-To: <20220805200105.2020995-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 8 Aug 2022 14:55:38 -0700
Message-ID: <CAM9d7chPmvnjUicvjVpaHjpiNXvQLPjfx+ZasENxbg1+s54j+Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] JSON output for perf stat
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Claire Jensen <clairej735@gmail.com>,
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

Hi Ian,

On Fri, Aug 5, 2022 at 1:01 PM Ian Rogers <irogers@google.com> wrote:
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
>
> v7. Weakens a test and adds a Makefile.perf change Suggested-by:
>     Arnaldo Carvalho de Melo <acme@kernel.org>.
>
> v6. Is a rebase.
>
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

I'd really like to clean up the perf stat output code as it's already hard
to deal with..  Let me do that after adding this.  So,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
>  tools/perf/Documentation/perf-stat.txt        |  21 +
>  tools/perf/Makefile.perf                      |   3 +-
>  tools/perf/builtin-stat.c                     |   6 +
>  .../tests/shell/lib/perf_json_output_lint.py  |  96 +++++
>  tools/perf/tests/shell/stat+json_output.sh    | 147 +++++++
>  tools/perf/util/stat-display.c                | 383 +++++++++++++-----
>  tools/perf/util/stat.c                        |   1 +
>  tools/perf/util/stat.h                        |   2 +
>  8 files changed, 552 insertions(+), 107 deletions(-)
>  create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
>  create mode 100755 tools/perf/tests/shell/stat+json_output.sh
>
> --
> 2.37.1.559.g78731f0fdb-goog
>
