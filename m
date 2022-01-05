Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF53484E22
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237950AbiAEGPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbiAEGOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:54 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBB3C061375
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:14:50 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id g16-20020ac85810000000b002b212f2662aso30022548qtg.20
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dJyDU+u/GJKBsmxifkeZSF2d3RNx4NXgNE9GZmNvqGo=;
        b=mfQ93GOFFQWwD1/V9zuwhoc7hdP1dIU+1SS/UsaRXnOZEXp2o3lSvg/Qq6XwyRZV46
         rcwK19RHfa10XGoRSwXyV+KG5Z2jEUOCPUWgJmP+vpN3PcDAGL7f7IsqOMWbq4JbKOUD
         HnlaPQHyk2HvZCsZ58MRV/wmsoxxSX0b8eeVlfvC5PRo0fOyGptmSsKr3MumTDoDNday
         JztogXJ0rf/hx4FBZeA1jPgbe7y24crpHiSHMK6Nwk20J121VoTQh68U2Sf8EuJ5D/Kg
         2XWCl05liCE/bBZsWfBj+eFE2yZAjyqkthV5ETu8UKPc4vCvtHg3MHy2oM2yYw1fLyPc
         8wcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dJyDU+u/GJKBsmxifkeZSF2d3RNx4NXgNE9GZmNvqGo=;
        b=d837DlyneOZgNObnppijLRVFejkso62q8GIp5DhxTuNRMO3Bzu2aSOFxV6s9f91Tkg
         tn6FbwKRqgJe+2iQSb5hg3eWW9vTfzkC3y0YyAuzkuoM2HU/ZUXhX9qldi4ORf5ejPR4
         3gxU32pkEdjsQLC+Skh040P7qC+SGUc3c16Zg3esEsqcUYfZiGlkux86o4Xe7+1zUcO1
         CZfnxbgsPhU5jnKnxsaKZ5xAfiAcOfWNlwTv0B7AauJ/3mNd1gHziZG4AkpH8zsLS0pJ
         U6Mj7Nd/FSA7dqAclh9niWlPFUhWfWBB/RJkKJlGDljHdLii2wKk9PziwsBhRuwPCIAK
         H/LA==
X-Gm-Message-State: AOAM530W1qVuTFF9TRspRBpvNh+3KkUfZW8hdU0Akw08KyMG4yA0nPxQ
        yCCko05IgySFAPImlgHwMu+1MLSMnGfE
X-Google-Smtp-Source: ABdhPJx5WDAPqLbwXmPGrLlPvWLCgrymybmT0k5DF0hFbjzwUl/a129iO3FIhWM9PkkwuRxHgk1U/xqVl43b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a05:622a:144:: with SMTP id
 v4mr46433782qtw.191.1641363290011; Tue, 04 Jan 2022 22:14:50 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:24 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-22-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 21/48] perf cpumap: Add some comments to cpu_aggr_map
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
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move cpu_aggr_map__empty_new to be with other cpu_aggr_map function.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 32b8b5178f01..25a08d640d81 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -24,16 +24,18 @@ struct aggr_cpu_id {
 	int core;
 };
 
+/** A collection of aggr_cpu_id values, the "built" version is sorted and uniqued. */
 struct cpu_aggr_map {
 	refcount_t refcnt;
+	/** Number of valid entries. */
 	int nr;
+	/** The entries. */
 	struct aggr_cpu_id map[];
 };
 
 struct perf_record_cpu_map_data;
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
-struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
 
 struct perf_cpu_map *cpu_map__new_data(struct perf_record_cpu_map_data *data);
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
@@ -67,6 +69,12 @@ int cpu__get_die_id(int cpu);
  */
 int cpu__get_core_id(int cpu);
 
+/**
+ * cpu_aggr_map__empty_new - Create a cpu_aggr_map of size nr with every entry
+ * being empty.
+ */
+struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
+
 typedef struct aggr_cpu_id (*aggr_cpu_id_get_t)(int cpu, void *data);
 
 /**
-- 
2.34.1.448.ga2b2bfdf31-goog

