Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B366652A899
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351223AbiEQQvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351207AbiEQQvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:51:42 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDBC4090A
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:51:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2fed274f3fbso75146737b3.17
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=g2f4uvZg1OcpFGX2p8frlvTRX1+Tckj3KS/ktxrHk0U=;
        b=KBtLDSOQDN4CFp4UIghgcQ3ZBvT6TcmYf/vyAAE00IVbD8yOelUIzlITkm2MKrJhVg
         EuQZsVUoCNk/2XD7/A7mN6pUw1Sb5tvJGl10A5Hvodn/A5p5RGqaQGn7epS3fk2/dd8p
         wARMBv0ZqnZIXVGmuv1xOPpbgUozdHYDCNSpzf8FM/nOIqf4m6RDY+YJZr817HfMOI71
         gsqB0p1zGCP+Syyhu66PGxrra2f2/FUTGFHtKMmMQhjJuMiEpluBooZiw4DyPWGaTQXv
         q5bS5VYrVdwFHrDR3DmDEWmpmKdJUffZrdYCPLdxuB0zYeGxTtQl6STIU3QFhmqiXlls
         M7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=g2f4uvZg1OcpFGX2p8frlvTRX1+Tckj3KS/ktxrHk0U=;
        b=LyeQnGqzzmWyrIXOOcqQym8zvE89xtuXHpv9tUQBbh1zDK8fH3TNAgBDhpTbbgjUNC
         UmsjRfvP7tfB0r0B6oGwsuHeKEsGP2tEkk9pNfohjQfIcA9qUVYtAqmP6hpJxEfRwjEP
         08psD1lnWJQVNcMfaIZEtpsDkFESGn/x2ArUtEOzFynp6bvg2M/skiog8Hrtih13BWTG
         pNI5iHm7btU8l+ua20fN5DKlx8XztFnvKs9GweuWTAXyebjcWsM3ke8hGR47X+6+GtqF
         qvm83VJ1EcJ/v4+yk0UVCtpxHKEWw1nQ9hM5vYaVVBRCCjApMHR8s5a6U4Is4X8ZhpUv
         zOGw==
X-Gm-Message-State: AOAM532wOwGD59IpCHMDubLxCpkfAWceobCfc50f18LtXN4XFwqehhOz
        c/advLfWLaRWPWH6jyDxzzKCz6fmCksY
X-Google-Smtp-Source: ABdhPJxnIXgI1cz6JmZ4YxDm1wQ3taF1Gug1SeXiL9AUaVPryKXUYqnzY8V+X518Ny5XwSUKJivzkTnhHYkw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a05:6902:114d:b0:644:ba0d:e95c with SMTP
 id p13-20020a056902114d00b00644ba0de95cmr24868885ybu.516.1652806300551; Tue,
 17 May 2022 09:51:40 -0700 (PDT)
Date:   Tue, 17 May 2022 09:51:34 -0700
Message-Id: <20220517165136.479226-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 0/2] JSON output for perf stat
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

v2. Fixes the system wide no aggregation test to not run if the
    paranoia is wrong. It also makes the counter-value check handle
    the "<not counted>" and "<not supported>" cases.

Claire Jensen (2):
  perf stat: Add JSON output option
  perf test: Json format checking

 tools/perf/Documentation/perf-stat.txt        |  21 +
 tools/perf/builtin-stat.c                     |   2 +
 .../tests/shell/lib/perf_json_output_lint.py  |  92 +++++
 tools/perf/tests/shell/stat+json_output.sh    | 147 +++++++
 tools/perf/util/stat-display.c                | 365 +++++++++++++-----
 tools/perf/util/stat.h                        |   1 +
 6 files changed, 542 insertions(+), 86 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
 create mode 100755 tools/perf/tests/shell/stat+json_output.sh

-- 
2.36.0.550.gb090851708-goog

