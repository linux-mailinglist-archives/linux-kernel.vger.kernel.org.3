Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349555278EB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 19:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbiEORgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 13:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237901AbiEORgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 13:36:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1210E8D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 10:36:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a144-20020a25ca96000000b0064d6e10dd6aso2524208ybg.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 10:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ig/7vVLo0AsmlPsX6ryTsWGmEx+39MA4mGGhaRA/jSE=;
        b=OkTUyBuz4vs7dODQlOF31KR8BHWTLy0ClLbLecfSyhnezb3HhKUc6vkVLK6A9Ugb0p
         nEsG2fTCAI3sH7LdtDcmXasrMMr2N1aG6701N+8V5zr+dsyM+RQvO/16T1Ht9VTF2xVR
         y5fbOob9SC+ZjYHG4xcVZ8QfwFPecUGIr3JQy1IPPXhxa+MaZGGZeE17Rz0u1IUkROhq
         lqdk0m8cjdlqHtXkE3Lbk3ZFSP0gPZjkg6opv/cN/xcjQI+AASEpf+cO4GbCIWt0oito
         1dpsxBTkRyECYt1Ch+GMwNN3gvGWLLyavx5fKpdnvpaCo3cU00Y7jIJhkUyRCIEm+6W1
         cVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ig/7vVLo0AsmlPsX6ryTsWGmEx+39MA4mGGhaRA/jSE=;
        b=cfvtARAS68F0pMk46HOlJZYelYWy62j298JAcvetRHRUhuTFxQqQ+qvNYtoPtflWZV
         XKSq7rAdaJAXj6PtvRAvkCkiDUr5+9bonFFlKe2fB9d6AXn79OKTes/l6gGk2GbJyL0q
         MYffq6/80GTfZQBNmUB83e5Z+68cLOK2vaqE4zbPlKgz03k/lubV60WT6jwDqWDcLOnL
         bbK9w9cUa8xHAryldv194oRMQo8TGL9pqtXm6Xm8rAPXfiEzZfP0tvYeo/pul21nA5F3
         uRq+pwTCaUffAykdcztIlJgapTJj/85ELssQyLoFXRiyh+qIYgAsd/lxNDzS2Fa0BqL7
         ri8A==
X-Gm-Message-State: AOAM531Wko+LjlRUbLHulZQ7Lm2XnTBjw+zjEqFz6wKyFjUwtFjCdjjP
        L8QBag7dcTXZxPBmEyQU4ZjoEDJtkq3K
X-Google-Smtp-Source: ABdhPJxzJpWa8LjYjZCwVSEt8EJB/Jo+oUcXU4+/9eslIbd+pySXJkrhOfVKTzIdYTIyG+KWDJ5f/Nsc1mA2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2a5e:db66:d206:cbaf])
 (user=irogers job=sendgmr) by 2002:a25:1cc3:0:b0:64d:851a:597b with SMTP id
 c186-20020a251cc3000000b0064d851a597bmr3867731ybc.624.1652636166253; Sun, 15
 May 2022 10:36:06 -0700 (PDT)
Date:   Sun, 15 May 2022 10:35:56 -0700
Message-Id: <20220515173558.2289702-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH 0/2] JSON output for perf stat
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


Claire Jensen (2):
  perf stat: Add JSON output option
  perf test: Json format checking

 tools/perf/Documentation/perf-stat.txt        |  21 +
 tools/perf/builtin-stat.c                     |   2 +
 .../tests/shell/lib/perf_json_output_lint.py  |  90 +++++
 tools/perf/tests/shell/stat+json_output.sh    | 141 +++++++
 tools/perf/util/stat-display.c                | 365 +++++++++++++-----
 tools/perf/util/stat.h                        |   1 +
 6 files changed, 534 insertions(+), 86 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
 create mode 100755 tools/perf/tests/shell/stat+json_output.sh

-- 
2.36.0.550.gb090851708-goog

