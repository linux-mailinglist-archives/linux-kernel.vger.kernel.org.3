Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2D3529908
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 07:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbiEQF1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 01:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbiEQF1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 01:27:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955651EEC5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 22:27:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a144-20020a25ca96000000b0064d6e10dd6aso5995144ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 22:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fhyPdQWeqDloOKkKqTz1ZyQ6igO44pea09Y6oXJ4klY=;
        b=oMRiADXfrP4QBwGawTd1L5SwFNv8CHzhSSsJDawBVeWwP1hjzKwNSdHcMag0nDJJ/n
         GXv5QsF//jdR0Q7QbSm9UWgt06i36tZIkrb7AZwSm9jEfm6GQhUElKUb7fojaDVaNfVk
         1gOJzZgeRgUI8Nn2fl2bn8nwPJZIS4W2RcjOaXWTshcGeKtNnPQK6bi7zUuE3h81/ef+
         /0/T2pb7TSSYTtCIuUwrSkqUkkPyIX0rJmsukU8PG7GnmlGTysFxlRwmJ432VFWk7hIS
         36zP+bKKG+ksXei8Fb9P26HV7Mu0sIIjdvpKd8rJRd7hWUiyjDn5IiK7w1qx5HdUMQrt
         kugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fhyPdQWeqDloOKkKqTz1ZyQ6igO44pea09Y6oXJ4klY=;
        b=YKVhaZS7L8eEjC4rolZfNxqP9DdatSooAVXhbIYfEpc5xZzbwltiYMwa5GPLPwWjme
         NDcGvB8qv2DPUymJWsCCHbPXR0Fxn44rkF98BbY1nk4hvPootxMpsk7MMwltzcHiD5lO
         hAtRfwSas2eoQ9fnPNd8bg8JC3+fJ5LSnxcCfFGQAq8ZJDrE/1WVI3Vnttk25dAtk5uB
         zzKkvVOZzuN2UZVZJ554iQHBG+QDSc9UR/wN2RKdUblAIFJB5CsGd4t+d1Qq7P7ENvoS
         Em0QBqS+/5udB0mL3Avaq924BoTQYWGBXIsURkgmtDtnXIvn1RGKpbLI+oJerimLU+dM
         s5pw==
X-Gm-Message-State: AOAM533kvlnLOKxnpqkI9s4HMzlNejfGCJiqXBQHVnNrV89q1UdZqsA0
        gFHGs2IjkM6pA5OEHzdl4hMUOyZdxlBn
X-Google-Smtp-Source: ABdhPJzK5gioy2Ufu8Nvw+w5uXCwY7XPZoxsENMWp8krL0HptQF/mdYlJn+xPergrvZ8ZFgsEtAxEMrD/+Xs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d585:282c:3f88:36e3])
 (user=irogers job=sendgmr) by 2002:a81:9d5:0:b0:2f4:dd93:4513 with SMTP id
 204-20020a8109d5000000b002f4dd934513mr23671440ywj.54.1652765247839; Mon, 16
 May 2022 22:27:27 -0700 (PDT)
Date:   Mon, 16 May 2022 22:27:22 -0700
Message-Id: <20220517052724.283874-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 0/2] Fix topdown event weak grouping
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

v3. Fix computation of number of events in leader's group.
    Adds reviewed-by: Liang, Kan <kan.liang@linux.intel.com
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
2.36.0.550.gb090851708-goog

