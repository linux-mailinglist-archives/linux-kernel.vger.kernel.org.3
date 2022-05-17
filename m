Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4CD52ADBB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiEQV72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiEQV7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:59:23 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B66D50E33
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:59:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb7d137101so4236617b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=87brBgMZyYr2KZM5gqgOZ1FKoktrRC3RtBsl96TyHFk=;
        b=OWZ1xxTAzR+DWRYf1pCTH/HydXSZArPwWEXY2qmEPGNHV4KEvfWQONU/80zcaaMoQT
         UxIQd5HwISoRC1LniAQjieSp5FjKdd321vE7mx1xHK6ameQFtpXLHzcENSi6qXlvN+zI
         SLtUWnjDn5hPEiQ+jNsY2Baj5rsbvSq1Z4BF4AY8H6pyHdBTJOF6wiimFd4x3T5QFBm9
         wcVinFed7dxUOKfUcLy/8iy+/adRfOdwTprKzMntkMJA67QbD9olRsPqwnxYhVqGtkez
         HxixWrlGWMqQsvO3N9pMov6EcTUmbxfa/YbDearvZO9bwRXgHu2Iow6t6c9C7/uwNpFT
         XhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=87brBgMZyYr2KZM5gqgOZ1FKoktrRC3RtBsl96TyHFk=;
        b=eSVQPJRI/VGDxsF7jA7GTvN6bsbtNI7Ex36ziJCZQmNYF3rAb7ira3MUDn/J4YrnP1
         JdBRhOQab1k+tm0rojqjV/prSL86pNyM+Rkr2seE/hZEy2nA9yN0xmFxnw6eTUaxMPdK
         LbFgQaBEaYs1IB1ua20zRiC9mVJxpYMJm5g6fip5XGQfSJ4567VBl/MFfiH56tAcoJSh
         b/d+0kFAp9qZx5YAvbqF5hZ9WYpLlcclLRs1TfeV4VQCT/w37wkRLV6LsmMh7vceRyOT
         7f4xBSXv8syXlY1ZyC3KSuuqiNeqWyRqVHs7oUXRmT9UOu84mjSEhQbP+iGqd9VyPuib
         jhIw==
X-Gm-Message-State: AOAM531pe66xCCsL5UV+knx9JLNywupRThATqcjsUZkEwdUXXZqVYm19
        ysp10gnncocbRfFfevo/O0l4Kjb2nBIU
X-Google-Smtp-Source: ABdhPJyxEk2HSbePnkp7Cg+Zed5QyldoSY6BiLKeR0+bUCh9h22z7R6MWypZH/tO2eEHsxTwuCUlguFzn2Su
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a25:4091:0:b0:64d:6dd1:db7d with SMTP id
 n139-20020a254091000000b0064d6dd1db7dmr16261350yba.191.1652824761121; Tue, 17
 May 2022 14:59:21 -0700 (PDT)
Date:   Tue, 17 May 2022 14:59:14 -0700
Message-Id: <20220517215917.692906-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 0/3] JSON output for perf stat
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

The CSV test/linter is also added to ensure that CSV output doesn't regress:
https://lore.kernel.org/lkml/20210813192108.2087512-1-cjense@google.com/

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
 .../tests/shell/lib/perf_json_output_lint.py  |  91 +++++
 tools/perf/tests/shell/stat+csv_output.sh     | 147 +++++++
 tools/perf/tests/shell/stat+json_output.sh    | 147 +++++++
 tools/perf/util/stat-display.c                | 384 +++++++++++++-----
 tools/perf/util/stat.c                        |   1 +
 tools/perf/util/stat.h                        |   2 +
 9 files changed, 741 insertions(+), 106 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_csv_output_lint.py
 create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
 create mode 100755 tools/perf/tests/shell/stat+csv_output.sh
 create mode 100755 tools/perf/tests/shell/stat+json_output.sh

-- 
2.36.0.550.gb090851708-goog

