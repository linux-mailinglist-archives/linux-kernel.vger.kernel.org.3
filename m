Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3539A4AA53F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 02:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378840AbiBEBJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 20:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiBEBJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 20:09:55 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CAFC0364AC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 17:09:53 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e81-20020a25d354000000b0061b1a807047so8238258ybf.14
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 17:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=X+MdotQVqzVb5iXMvO6xGd1RHiGCWDiHkvIyMF2FOY0=;
        b=C8R5oslCrSyXVPbUJZjth0sKEh7ZqhfDRMqOEJhmB02X3vddsEJLOQbhl8t4S8d1r9
         KKTVSgutxJuB44dnY9Gt+a/I1DrkjN3bqXvZffpy9V/Xl+h2GcR0H0BHrA/jU7L/SxKx
         7F363Jl98FxssQoT+V65ntuNIv0CCHCZ1icMj1O7gfO4bJPzrY540bGb+V1ZguJrQvq/
         uXxtgcQb5xQlI7O4FBymQk0uM5VQRz8zuggG8fQ8jSIOdFc1zfomWC0xdliPvdTvZfLW
         DbH74Y3G5A6Rj9CkGAQ1rdXHp28lx9floyf2Mxyh6pSltNy7MR71apDUCgmryZp8PGDq
         APdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=X+MdotQVqzVb5iXMvO6xGd1RHiGCWDiHkvIyMF2FOY0=;
        b=E9ED9P2G6Rsf6FAy21mbv1YRpq7S26Wvggei+L6GYNPMsqYVMcZKD5pABNF2nO4Bb6
         ImytwU0NfMFqQUU7sbs03YB7h/FaqxPMJXcgCBftD+zmOMlVeEujaMPaWpypKi5Nc5yr
         lHSAdJ4TJ3Eyjxs0yodbS0kV4giYagB35RZmImqwyGj6FjA7n9h5Mgjui0JujqVFBq6q
         MbumatNlgz/ierdVVwts07fX1338WTK5wG4qnv2XholJYYvzl/Iss2lc08A9xWfL5cE1
         zGuMRE2qE4rtNi1A96jp34We1uexwTIxB1Xo6ItEMWJrHY3r/3dgxjKWfpdd1r8nzOiQ
         DsHw==
X-Gm-Message-State: AOAM531tnozRQkIfB4AYbfb6kbclqj6p48W9ZlXdXe4WFY6Pe3hTKfwU
        C2VqMKlhv1reCrqUh7fwTKT6SS+hvjns
X-Google-Smtp-Source: ABdhPJxvEV6msjvuMrQPnotYMSgN0sAIhlm7DqvPYrkUtsSGf9X+KNhx3pWhCEcM8TskdJ09CyZx5cAJ4gI0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2e3f:a36f:e557:9b6d])
 (user=irogers job=sendgmr) by 2002:a05:690c:309:: with SMTP id
 bg9mr1783100ywb.135.1644023393029; Fri, 04 Feb 2022 17:09:53 -0800 (PST)
Date:   Fri,  4 Feb 2022 17:09:41 -0800
Message-Id: <20220205010941.1065469-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH] perf stat: Fix display of grouped aliased events.
From:   Ian Rogers <irogers@google.com>
To:     vineet.singh@intel.com, perry.taylor@intel.com,
        caleb.biggers@intel.com, asaf.yaffe@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_40,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An event may have a number of uncore aliases that when added to
the evlist are consecutive. If there are multiple uncore events
in a group then parse_events__set_leader_for_uncore_aliase will
reorder the evlist so that events on the same PMU are
adjacent. collect_all_aliases assumes that aliases are in blocks
so that only the first counter is printed and all others are
marked merged. The reordering for groups breaks the assumption
and so all counts are printed. This change removes the assumption
from collect_all_aliases that the events are in blocks and
instead processes the entire evlist.

Before:
```
$ perf stat -e '{UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE,UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE},duration_time' -a -A -- sleep 1

 Performance counter stats for 'system wide':

CPU0                  256,866      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 494,413      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                      967      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,738      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  285,161      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 429,920      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                      955      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,443      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  310,753      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 416,657      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,231      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,573      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  416,067      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 405,966      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,481      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,447      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  312,911      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 408,154      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,086      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,380      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  333,994      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 370,349      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,287      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,335      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  188,107      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 302,423      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                      701      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,070      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  307,221      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 383,642      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,036      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,158      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  318,479      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 821,545      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,028      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   2,550      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  227,618      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 372,272      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                      903      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,456      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  376,783      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 419,827      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,406      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,453      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  286,583      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 429,956      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                      999      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,436      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  313,867      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 370,159      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,114      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,291      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  342,083      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 409,111      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,399      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,684      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  365,828      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 376,037      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,378      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,411      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  382,456      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 621,743      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,232      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,955      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  342,316      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 385,067      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,176      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,268      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  373,588      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 386,163      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,394      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,464      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  381,206      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 546,891      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,266      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,712      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  221,176      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 392,069      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                      831      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,456      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  355,401      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 705,595      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,235      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   2,216      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  371,436      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 428,103      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,306      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,442      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  384,352      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 504,200      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,468      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,860      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  228,856      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 287,976      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                      832      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,060      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  215,121      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 334,162      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                      681      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,026      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  296,179      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 436,083      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,084      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,525      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  262,296      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 416,573      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                      986      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,533      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  285,852      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 359,842      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,073      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,326      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  303,379      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 367,222      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,008      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,156      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  273,487      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 425,449      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                      932      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,367      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  297,596      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 414,793      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,140      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,601      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  342,365      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 360,422      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,291      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,342      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  327,196      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 580,858      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,122      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   2,014      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  296,564      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 452,817      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,087      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,694      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  375,002      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 389,393      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,478      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   1,540      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0                  365,213      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36                 594,685      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                    1,401      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                   2,222      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0            1,000,749,060 ns   duration_time

       1.000749060 seconds time elapsed
```

After:

```
 Performance counter stats for 'system wide':

CPU0               20,547,434      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU36              45,202,862      UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE
CPU0                   82,001      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU36                 159,688      UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE
CPU0            1,000,464,828 ns   duration_time

       1.000464828 seconds time elapsed
```

Fixes: 3cdc5c2cb924 ("perf parse-events: Handle uncore event aliases in small groups properly")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 5db83e51ceef..9cbe351b141f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -585,15 +585,16 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
 
 	alias = list_prepare_entry(counter, &(evlist->core.entries), core.node);
 	list_for_each_entry_continue (alias, &evlist->core.entries, core.node) {
-		if (strcmp(evsel__name(alias), evsel__name(counter)) ||
-		    alias->scale != counter->scale ||
-		    alias->cgrp != counter->cgrp ||
-		    strcmp(alias->unit, counter->unit) ||
-		    evsel__is_clock(alias) != evsel__is_clock(counter) ||
-		    !strcmp(alias->pmu_name, counter->pmu_name))
-			break;
-		alias->merged_stat = true;
-		cb(config, alias, data, false);
+		/* Merge events with the same name, etc. but on different PMUs. */
+		if (!strcmp(evsel__name(alias), evsel__name(counter)) &&
+			alias->scale == counter->scale &&
+			alias->cgrp == counter->cgrp &&
+			!strcmp(alias->unit, counter->unit) &&
+			evsel__is_clock(alias) == evsel__is_clock(counter) &&
+			strcmp(alias->pmu_name, counter->pmu_name)) {
+			alias->merged_stat = true;
+			cb(config, alias, data, false);
+		}
 	}
 }
 
-- 
2.35.0.263.gb82422642f-goog

