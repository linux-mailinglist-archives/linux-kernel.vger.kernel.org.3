Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB98453367E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244017AbiEYFiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243946AbiEYFiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:38:22 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4991B5EDE1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:38:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f4dfd09d7fso170775677b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=J6AIzYxM94WLDE1VTUM2GvuHGVMYhOjSoUyQI5esYvY=;
        b=fP6HOquRnsc+5BXSr+ruSg9nh2sJZ+tLEvHFpqfWI3Ce0PRPIgnMN4HTatj309I8mK
         np2TV1REkwreC5pLx8Ms1vWtAsun+KHEkCo/zuY3CT8BwQ656GwvV4R2MsWTiBtXG7BK
         NdZUdgU0P9G1pGPyw6PYU+iflcZpLKqFZvoL3uWWY0LztFQQ2MBxuOAJa3nyLVy4+5+Q
         W/dYWcjdENu15m0VmnfOgMqyY1cH4HSdb0InDw0fyQfUu0zZg4HVsUfzenDbLt14P3Qi
         MczvjGoEmVjeg2RxYaUMjOwohhSP4jIRHBsYWmIv6SLtXRRfvqRcvOW3sgOwj8h8UTyn
         KTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=J6AIzYxM94WLDE1VTUM2GvuHGVMYhOjSoUyQI5esYvY=;
        b=rzEJj+5k9YV41h9mU87EepuI+Z6edekAh2LMQRSRf4d77aIvB2/WaAKECG0j+NFeMi
         FAQN2vRSKOwx0ySoiaQ1ok4acUdSxVWLVeW4t1EFYHDwRj9Oo80HNamUiYoDzxtaKZlU
         p/n7yC6hnoq4ad1zw/QnO8jLDf7wpvaOXtiQqY6ynv+h+MKS321bAhdCUihku+tHKzEP
         XXefswO2Pp5WLFFihoUY+0qYPPT0a8/CajwBWun22gjXjTiSasRjoZgkFLDJSGlGMMaJ
         0dO09lhQH7zjD/R2+T9nmdxTZIJtG6IjQZ0jaiitIPnlHYqk4Ap3O6oV6qIADGykZLtH
         Hsng==
X-Gm-Message-State: AOAM531oFqaXlJsQNGEoIsoHGWt6XvTWxwy9ZMOFGF9mtmaHNEA/avSL
        32p77w6vuRTMLsUAca8gGrZhx3Hal2rq
X-Google-Smtp-Source: ABdhPJxXM4PFYMGr/65uoJQnUDAKa7kF4Mf+9D6qvNvXHP9FCJ3g/oucUObTbbJnfqUoFIGYPUbzXwZdTPJM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1ab1:de5:7b7f:3844])
 (user=irogers job=sendgmr) by 2002:a25:4045:0:b0:64e:a6ae:23b7 with SMTP id
 n66-20020a254045000000b0064ea6ae23b7mr31701321yba.296.1653457100526; Tue, 24
 May 2022 22:38:20 -0700 (PDT)
Date:   Tue, 24 May 2022 22:38:11 -0700
Message-Id: <20220525053814.3265216-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v4 0/3] JSON output for perf stat
From:   Ian Rogers <irogers@google.com>
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
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parsing the CSV or text output of perf stat can be problematic when
new output is added (columns in CSV format). JSON names values and
simplifies the job of parsing. Add a JSON output option to perf-stat
then add unit test that parses and validates the output.

This is a resend of two v2 patches:
https://lore.kernel.org/lkml/20210813220754.2104922-1-cjense@google.com/
https://lore.kernel.org/lkml/20210813220936.2105426-1-cjense@google.com/
with a few formatting changes and improvements to the linter.

The CSV test/linter is also added to ensure that CSV output doesn't regress:
https://lore.kernel.org/lkml/20210813192108.2087512-1-cjense@google.com/

v4. Does some minor fixes to the json linter.

v3. There is some tidy up of CSV code including a potential memory
    over run in the os.nfields set up caught by sanitizers. To
    facilitate this an AGGR_MAX value is added. v3 also adds the CSV
    testing.

v2. Fixes the system wide no aggregation test to not run if the
    paranoia is wrong. It also makes the counter-value check handle
    the "<not counted>" and "<not supported>" cases.

Claire Jensen (3):
  perf test: Add checking for perf stat CSV output.
  perf stat: Add JSON output option
  perf test: Json format checking

 tools/perf/Documentation/perf-stat.txt        |  21 +
 tools/perf/builtin-stat.c                     |   6 +
 .../tests/shell/lib/perf_csv_output_lint.py   |  48 +++
 .../tests/shell/lib/perf_json_output_lint.py  |  94 +++++
 tools/perf/tests/shell/stat+csv_output.sh     | 147 +++++++
 tools/perf/tests/shell/stat+json_output.sh    | 147 +++++++
 tools/perf/util/stat-display.c                | 384 +++++++++++++-----
 tools/perf/util/stat.c                        |   1 +
 tools/perf/util/stat.h                        |   2 +
 9 files changed, 744 insertions(+), 106 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_csv_output_lint.py
 create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
 create mode 100755 tools/perf/tests/shell/stat+csv_output.sh
 create mode 100755 tools/perf/tests/shell/stat+json_output.sh

-- 
2.36.1.124.g0e6072fb45-goog

