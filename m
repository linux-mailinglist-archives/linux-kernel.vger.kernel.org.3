Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A2356AC94
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiGGUMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiGGUMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:12:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1395A60525
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 13:12:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y4-20020a25b9c4000000b0066e573fb0fcso7763723ybj.21
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 13:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=R39MoO0H4i1puFWmocsrFgtr9MK3/WkIb4geb14BnSE=;
        b=Q/k598i7pvIY73IwAUUaDL6o5KD5RFPeQ1CNdhkbg3b8lniKssp1gzozKJMb/1XPwP
         MWem40hzDD0i7G95dBMEqBqbZR7k5REWqMqEaxFsJF+NlJmhFD/Ovh9J1J/6PIyg0pSQ
         /05bFOFsiIBT4dcEh3YoNuenMDXY48Dx63SkcbOaio+g+ixq5KQy7UL+2/vr9UbOczDC
         rB8YAYoIKFGCFiKUaPxtKJ30J0dKcUoovKVhdGx2wSWS13nB2MXfMKw9SzXTJD8eMZCP
         dy+CTDka0LK8VVineqsxL183/5bH/YFkHxxmtmzev1312mbIp3KmXfTVQacevvwD1e+Z
         cCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=R39MoO0H4i1puFWmocsrFgtr9MK3/WkIb4geb14BnSE=;
        b=w8k5+ZmKu65FoLaS/yZZ8C5BC7wpQew5qfU+yWTj2yqWCS9QmbsgwTaZKXrkSkOe03
         C86RjWDcgQnIQk56yDdtZEtkDwjoFxcSp+6MeLWMF4BCSsNMuSEFlA9i7yrc64H6jShR
         cG444xl9mphdEsVsrGfb4zUxwBr+tRY+y934pZ1AKgwNiHiAkZr6XREANVaW6y8UCOt7
         es7kQdeHQthoEy6upYqrKzhCvfrcK1BJCIMO0BLE7bkr6xRWymEqH42dG6fIAiUFCXjL
         8TvQWXh7Q8HasRrclfhsfR0Bo7lCgTG+ZFUCsMyjaaBwxb6DKS6IANOXjj7+IKXaOPgW
         94Qg==
X-Gm-Message-State: AJIora8UOXhbZkP1G3JL29Rk96f6YiSyx/fQlHKx5Ce8eS8Ldw+WaNm0
        vQCPMVXdFZ+RGwodk88kcxcaCRI2HCab
X-Google-Smtp-Source: AGRyM1vegzrGHxeJIXn4vdSZXtKkNGyhIThba54BjBCbstdGnx5+rLTxfP6LdRW03Y/Ia6KGGkCZGnFA4uW4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf75:f79:d509:a8d1])
 (user=irogers job=sendgmr) by 2002:a25:f50b:0:b0:668:27cd:ed38 with SMTP id
 a11-20020a25f50b000000b0066827cded38mr50880125ybe.606.1657224737360; Thu, 07
 Jul 2022 13:12:17 -0700 (PDT)
Date:   Thu,  7 Jul 2022 13:12:11 -0700
Message-Id: <20220707201213.331663-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v6 0/2] JSON output for perf stat
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

v6. Is a rebase.

v5. Drops the merged CSV check, fixes a json test issue found by
    Arnaldo and a typo.

v4. Does some minor fixes to the json linter.

v3. There is some tidy up of CSV code including a potential memory
    over run in the os.nfields set up caught by sanitizers. To
    facilitate this an AGGR_MAX value is added. v3 also adds the CSV
    testing.

v2. Fixes the system wide no aggregation test to not run if the
    paranoia is wrong. It also makes the counter-value check handle
    the "<not counted>" and "<not supported>" cases.

Claire Jensen (2):
  perf stat: Add JSON output option
  perf test: Json format checking

 tools/perf/Documentation/perf-stat.txt        |  21 +
 tools/perf/builtin-stat.c                     |   6 +
 .../tests/shell/lib/perf_json_output_lint.py  |  95 +++++
 tools/perf/tests/shell/stat+json_output.sh    | 147 +++++++
 tools/perf/util/stat-display.c                | 384 +++++++++++++-----
 tools/perf/util/stat.c                        |   1 +
 tools/perf/util/stat.h                        |   2 +
 7 files changed, 550 insertions(+), 106 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
 create mode 100755 tools/perf/tests/shell/stat+json_output.sh

-- 
2.37.0.rc0.161.g10f37bed90-goog

