Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8F3484E17
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbiAEGOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237689AbiAEGOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:20 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BC0C0617A0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:14:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s83-20020a255e56000000b0060c46cc1890so50232222ybb.16
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Zr180MbAuyMK3FOJ6p+f1v/pd05fFRyT7sFFspoiHfQ=;
        b=VNo9f4KK4euu5YXn4BKU7BXdArb0b4h8wW8IVc6HqTx5HwZzfdL4N0X5sw0VC4MMvv
         v3btgO4OZiiH1LcdyGTdJ9ifbhjqt05X+aRCiz0Whzjj4AE/MiML5USCm2wstiDL/+FS
         ZNdU5zUzjkcH4f/AGwLHcbV8J7v+kyOMmIDSeKMJTlFh9ntMpFsgAuv23DZ8zYL1OKk9
         TfEET6XsgVSq6xEC1PBn68PQhwWCDqUFvNm7iiSx5qx6+GwelE0klY6BqWP+RbFruYVA
         LBviSiVYsBea4dDS/y8npKhko1Rpo8vjhIAW8IYxSAF9HONeCxGmBdpGJFjcACPVcTs1
         gBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Zr180MbAuyMK3FOJ6p+f1v/pd05fFRyT7sFFspoiHfQ=;
        b=ZrO5ZGc2rD/9C5clvtnBBedp2L4bbD8OvHInn6uMKgKi+HQHs7Ch93nkCh3NlZp5VS
         5koVbnTwJ7aYhAxpZ2FjfXOOVllXJJHOSQzMvG8G6MQsyd5PI8Ewc+nI3jbZb1Hb04Oa
         rFlNEQlV7FW/l5iuoCcbD4Z1HVLzdgHSwKU8eFVt7ehOwWotNVoL4kabMed/IGKFVMsX
         LwFaOo01JmkQObZ6mpdmbUdd/xcRlp+PmL4bkWiRlN4jmCHiiVWARUdC1+l3AiYHhZbh
         jVFbj69HCd7BozNARp+aSSionA5TKIPalXP1Wz5NXrUd9gtI6kTTFbDhOLUMvzoDdkfO
         UA1Q==
X-Gm-Message-State: AOAM530BIHLyd6Kom+TCv7e8/4ZoOQt64QWaAPEys3W+3PjphZ0d0NVz
        JZjXryqLmij9G836Ymb45aCS0HpZ7W0U
X-Google-Smtp-Source: ABdhPJxBobdXrtq0N0+VovRJPnr4rxsjyWi0x6tNIMNdX7bMcDzKwzquhVhYNQSaffe2kDLoMJrPwegRdhRF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:1389:: with SMTP id
 131mr48194573ybt.381.1641363259688; Tue, 04 Jan 2022 22:14:19 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:12 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-10-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 09/48] perf cpumap: Remove map+index get_core
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

Migrate final users to appropriate cpu variant.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/topology.c | 2 +-
 tools/perf/util/cpumap.c    | 8 --------
 tools/perf/util/cpumap.h    | 1 -
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index ce085b6f379b..9a671670415a 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -121,7 +121,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 	// Test that core ID contains socket, die and core
 	for (i = 0; i < map->nr; i++) {
-		id = cpu_map__get_core(map, i, NULL);
+		id = cpu_map__get_core_aggr_by_cpu(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Core map - Core ID doesn't match",
 			session->header.env.cpu[map->map[i]].core_id == id.core);
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index ff91c32da688..e8149bcf8bfa 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -246,14 +246,6 @@ struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data)
 
 }
 
-struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data)
-{
-	if (idx < 0 || idx > map->nr)
-		return cpu_map__empty_aggr_cpu_id();
-
-	return cpu_map__get_core_aggr_by_cpu(map->map[idx], data);
-}
-
 struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data __maybe_unused)
 {
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 365ed69699e1..7e1829468bd6 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -36,7 +36,6 @@ int cpu_map__get_die_id(int cpu);
 struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
 int cpu_map__get_core_id(int cpu);
 struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data);
-struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__get_node_id(int cpu);
 struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data);
 struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data);
-- 
2.34.1.448.ga2b2bfdf31-goog

