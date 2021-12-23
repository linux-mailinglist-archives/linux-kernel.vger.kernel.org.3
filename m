Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C54147DFD8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347266AbhLWHse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347247AbhLWHrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:51 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AB4C061785
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:37 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d27-20020a25addb000000b005c2355d9052so8658427ybe.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JSu0B8tdHCivMmDl9rVtfSdI8JuN1SLb4661ulsOdOs=;
        b=MuISUn2+IVYi8HnSczfjLUDfV1pxeGKnT55sncC7WyvReipoUdXYVPMvxpwiPDMqU2
         AYJfmx4vLR9RcAyDuu6owRy9tJrDvwVoKz5c4xUKG9YjpN5NJpauNgUb7OqvoFyIwIi/
         NasVWkbfWPGJRjpuGOHNm10Oxtbnfb9Id+Ha4YpxO5wLSBe4wCUPI8zSOyvrGQFp+nyz
         jxIAyTkK5gXOUZeb15/+pDNVx/56JMEvk6A0w3MNT1H9QfcV0y//6f8mh7+jLD6CTbU9
         0K6uYkGy6TfG1SrF8sc3vm45nSfZl4mk4HKWbKKlUWWsQNpQ7GFYMEjZTg1EljASGglN
         RO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JSu0B8tdHCivMmDl9rVtfSdI8JuN1SLb4661ulsOdOs=;
        b=Uf01+Ews95fLRphwRo2bW04I3uVgz2bBdOV+zQfjL+faqPfT7hH89Lx+q56PUY15v9
         Tsx8LkNwSxC2/wj6SOp/UC4dSb2OKED09zccXd+dHe1uGA51Qm5uPHtOvNTjDPngjk1D
         hAflIMplNMhtxx5ZyWd8zVZbu0cMniUXYI4uDhxoYqb0QR0aMSjhBu1ER2n3+eWn+iQQ
         YxkgOT26inLW5cM+GI2RimDF+E+C62vJaLf3VzlQkrw7Vi33x13MPQlZOhQAxV/4wN5b
         L/GXwrZ3c770TBFOnXNaBdy/wjIQEyWteE1m8BIrp1TNnxrbIBBbrY3A4MiphhCNoDHY
         dAjw==
X-Gm-Message-State: AOAM532dst/5N2daB89ZRqXg0tTfUPu3NAh3E1iFBSePR5PkOdf1Lc5x
        ytq3fqe/BrEmZoKHSQAzE/2mZzpg6l4V
X-Google-Smtp-Source: ABdhPJxYbNY0pwl8Fufs0Pid0QbIDU5v4Zuv3xywBYVxR6l5Lyw95aqt3+MnHVp2HyKaLvHGj3YPR0TT1Jox
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a5b:14a:: with SMTP id c10mr1640778ybp.586.1640245656983;
 Wed, 22 Dec 2021 23:47:36 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:28 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-36-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 35/48] perf evsel: Pass cpu not cpu map index to synthesize
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

evsel__write_stat_event was incorrectly passing a cpu map index rather
than a CPU to perf_event__synthesize_stat.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f31bc34bd4cc..ec252579b587 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -327,10 +327,11 @@ static int write_stat_round_event(u64 tm, u64 type)
 
 #define SID(e, x, y) xyarray__entry(e->core.sample_id, x, y)
 
-static int evsel__write_stat_event(struct evsel *counter, u32 cpu, u32 thread,
+static int evsel__write_stat_event(struct evsel *counter, int cpu_map_idx, u32 thread,
 				   struct perf_counts_values *count)
 {
-	struct perf_sample_id *sid = SID(counter, cpu, thread);
+	struct perf_sample_id *sid = SID(counter, cpu_map_idx, thread);
+	int cpu = perf_cpu_map__cpu(evsel__cpus(counter), cpu_map_idx);
 
 	return perf_event__synthesize_stat(NULL, cpu, thread, sid->id, count,
 					   process_synthesized_event, NULL);
-- 
2.34.1.307.g9b7440fafd-goog

