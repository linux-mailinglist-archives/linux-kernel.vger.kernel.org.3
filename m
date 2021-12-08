Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A29D46CB2F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243738AbhLHCut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243737AbhLHCue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:50:34 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA103C0698C5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 18:47:03 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t184-20020a2546c1000000b006008b13c80bso2178237yba.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 18:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=46qIhN6ZqruQ98+Z98KkhW+wGjl47Soa5Hi+10XVymU=;
        b=UNBl+7JloiQCD/xY168iKERSuflr+R4yFQza5Bf06jEFOezLH1Yrf6a5cQ8eVt73jG
         Zr5SQOyUhZdZBKa2ZFqGRZTtVBoNAV4QDUTanqFNh3X7wBOBclG/gnrUEVwwX2VEYFP3
         Sl2s25eThz+5A5ev8rAsrR4XsgDk3bSnUwmEtk1D28E7j6o6ikNWoHdi5cWok0R45k60
         tuqpQk3CoAKDwCL1Usb+kCsVapTKGSEgDz2WRVT0UBRPfnjCGSST/+w77S6+pF9qu8U8
         x77ik5TZlYimrHbwsfk8s6I+14JFm//MC/nFcFZODfQ6UGTe+vcfbCRX8btUNC3SdwIo
         557Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=46qIhN6ZqruQ98+Z98KkhW+wGjl47Soa5Hi+10XVymU=;
        b=Za1CwTUjdj5If7fx/UrRsEUBlADE+ULZl/szQnvSLGLE6sFElPcOS3k6PTrLx+ikh6
         12GlQFrWb6CIi5lb4ooVzhh+gS60MJ9Qs9bmkXsV2qhKJI3nmU1Uvw66vLO6OL/3D7NZ
         CPUq0xIKznaVQPZMOhb+RT/c8Ml0nivJURmJ5tSazdCqoBgNXgefbfytIBLHFDrQEoi3
         cvTWEOEi08Xl4GH7NE5nbYSjse/afsYwnO8oi1uvqUl99HfM5nw/G3pg5ihYBKdV6qqc
         GkLwHE98uNKbJzHyLaIz//LGo2XqAVv0G/QrbAkdITtIcQw1KGKZwrU53lnaE+shjdq0
         gnBQ==
X-Gm-Message-State: AOAM531GCdXlyvnOMMIPt17i8HwHbsuDQ8+dPRyuG3h3tkwJLTVXtxLk
        LkxynqJf/g9LT8DCaPE3z24IyUEFTHip
X-Google-Smtp-Source: ABdhPJw+iR3JlVEnsW7c3j3ZLWwqusNogstWlTTEa9OX98HSXE9uZ96oIOZqJLqAA7iSwdxoAzljOXPBwwGG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:d003:: with SMTP id
 h3mr55705481ybg.184.1638931623022; Tue, 07 Dec 2021 18:47:03 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:46:06 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-22-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 21/22] perf cpumap: Trim the cpu_aggr_map
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_aggr_map__new removes duplicates, when this happens shrink the
array.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 8a72ee996722..985c87f1f1ca 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -185,7 +185,12 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 			c->nr++;
 		}
 	}
-
+	/* Trim. */
+	if (c->nr != cpus->nr) {
+		c = realloc(c, sizeof(struct cpu_aggr_map) + sizeof(struct aggr_cpu_id) * c->nr);
+		if (!c)
+			return NULL;
+	}
 	/* ensure we process id in increasing order */
 	qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), aggr_cpu_id__cmp);
 
-- 
2.34.1.400.ga245620fadb-goog

