Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B52652456C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350170AbiELGNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349200AbiELGNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:13:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0D571D91
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:13:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f7ee6bc6ddso37716157b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=k2mrwNMnDRDtKU4GgM7wzGIZDxmWj/S0FET83F74pgg=;
        b=Pn5/YRZEdz4bLQyrZFlg+WTrDF1ez3jNuU3oeeYtBPOfI5LbGlFTaJfwufzjmSUY0V
         hsMopSSrrhIMQ9tMydE/FdeV78QAtkeahrMuNxv53QreiyxNamrOK/BuL3+EhnIqBi/Z
         F8fcCVwiJPR8TYY4LThQSjVlQ0z4/qoNCP8V38dKAikPu2Ol3b8SFyRtFfUvwvw4GSKk
         3CAYqZjRDIx8pGR0ADieFNK9hHZfOVmewF65P1wtD+mGuAtlGQbUF/KqagrGCye0E3kS
         d7o2Twa7snYiyV9H4hMQGrbEgrolqc2F/i9MH466tgVdYt9/47HhLs+MJhSx6Ivx6+EW
         GeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=k2mrwNMnDRDtKU4GgM7wzGIZDxmWj/S0FET83F74pgg=;
        b=GHWOHTCb5teb6gVs3slo1YAKfDba1gmyzCNwGmGsecnnkBfzb4iUkCA10A7Lf7tVy5
         bbI1YLEo68RxCXoUeenSyGqoNWXW+4n3itqG8u7K/LHtYH7UhMcf04Pgow6r/KGfEjdA
         ZyWnGQp2A6zK3zoqYVoTp8M3fB5fpJPKj8aR4XHmKYmAQWWWj11Uuga2OliqoJz6UGgt
         tRcS941APHCjHmr5qOG+3p8TdFtorrgdWnlThuYV+0lENVUFVd3n+rtkqD7K0UXhiQ0/
         B0YYelm7xe1jXj0E3lt/No4Gp+8gW6R8f20Yp1RcRJQkd8wvI1dYCRv2oHJDQOZ0bBOn
         IA9g==
X-Gm-Message-State: AOAM531F5kg5Mv8TlI5QxP6g9dYwrQHGmshf45aSNgrx6qQLc2Q4fkEd
        /IroGwX/nK66P8QnIwF75hPPL3BKBVIo
X-Google-Smtp-Source: ABdhPJwbvviNfoKin2ClLu67Q4c9Lr6aurmjWUX+jvvCQpLwrsh4JwVF6ENzbLc6q1jbFTQcQUbiXHqgYecC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5993:294b:7b62:54cb])
 (user=irogers job=sendgmr) by 2002:a25:c1c3:0:b0:648:e9af:111f with SMTP id
 r186-20020a25c1c3000000b00648e9af111fmr29222012ybf.168.1652335991609; Wed, 11
 May 2022 23:13:11 -0700 (PDT)
Date:   Wed, 11 May 2022 23:13:06 -0700
Message-Id: <20220512061308.1152233-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v2 0/2] Fix topdown event weak grouping
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Keep topdown events within a group when a weak group is broken. This
is a requirement as topdown events must form a group.

Add perf stat testing including for required topdown event group
behaviors.

Note: as with existing topdown evsel/evlist code topdown events are
assumed to be on the PMU "cpu". On Alderlake the PMU "cpu_core" should
also be tested. Future changes can fix Alderlake.

v2. Correct behavior wrt pmu prefixed events and avoid the test using
    deprecated events: Suggested-by: Liang, Kan <kan.liang@linux.intel.com>

Ian Rogers (2):
  perf evlist: Keep topdown counters in weak group
  perf test: Add basic stat and topdown group test

 tools/perf/arch/x86/util/evsel.c | 12 ++++++
 tools/perf/tests/shell/stat.sh   | 67 ++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.c         | 16 +++++++-
 tools/perf/util/evsel.c          | 10 +++++
 tools/perf/util/evsel.h          |  3 ++
 5 files changed, 106 insertions(+), 2 deletions(-)
 create mode 100755 tools/perf/tests/shell/stat.sh

-- 
2.36.0.512.ge40c2bad7a-goog

