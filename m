Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47D3484E25
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbiAEGPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237861AbiAEGO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:58 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3C9C061397
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:14:58 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e2-20020a25d302000000b0060c57942183so50884856ybf.18
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u+LdW+lyUkI2NE4p4LcQuSrlWFNUmwlWA5f438wkJ9A=;
        b=YJNnWCLe5li8AXB12kFgrxUZh7e6WMGq2pd+QOy3DQnx2gkW4F/AQxpUHHPYvH8V83
         c2F4CbfQrS3SsFGZ7ohcOqkHVXB0RHJAj1+wiSZIBvzE0GBFaA5CSfUcH17CFyEDNv2Z
         TlQqj72b3xp23XVx2WLGmE+5Z8LpOdTYwh8j4H3i11TCAr5gMJCSFPIvRYTHpc2fmQ5Y
         4p+9ZPyxNsxOrintwcwLXrJ2dXgepq58waPd/ybV7mur3Unm52wFFmbm+tJY+yFdHvq6
         ObCklgORQ08wHBcb7dkJ0LmiFSn3bzwSslA9/p1Ja0wnBA+z6utVufAbC8q5PChOfFbu
         ZEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u+LdW+lyUkI2NE4p4LcQuSrlWFNUmwlWA5f438wkJ9A=;
        b=Wy7QV3+xvqTKOTXZEQUwnb7uoIMKJc6pwtAuOZYybvagEJFcc6qC7m1C12VGww+wAC
         Nni8Cpd9ZMt8EjBOXHCSbVNXUEv/QknwGANhstUMMVF6sy9ACAzefN546eTbsvo/5EzT
         +b/oJuIJ8xlGLgxK7tt61jmjyB4+rwWeNr89hk1j4YcvxBNE/QsXyEJkl3bBIHmnttnI
         Vi5JEuI/9mzW8EHYTvJVfNkIyo/LLtcC1ZCWGn/v82iUnnZCBOIDN8YhNCrTSIVGbK3d
         crCWsc0eoX1aBLAUppZ/gEtgLI/7PWyF9N4ByYnl6wW3O/FttaMKzl0+6Xi3te8JzW8C
         7neQ==
X-Gm-Message-State: AOAM532qDNTYUUbMP+C2BmR+8HBqTUDKA2mRjPPKFa55stLLh6+qd8at
        GYUVc34KtNyWXDbcbLd41HUjRd8BixAZ
X-Google-Smtp-Source: ABdhPJyEQkpnXczIcyI/Cab13UYlyDLu2cNhMqbIsdMME/gnNpeMq4w/KPxh1DwEeb77FMNLctsRaZPaOP8E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:d81:: with SMTP id 123mr55489015ybn.496.1641363297315;
 Tue, 04 Jan 2022 22:14:57 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:27 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-25-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 24/48] perf cpumap: Add CPU to aggr_cpu_id
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

With no aggregration, such as 'perf stat -A', the aggr_cpu_id lacks a
way to describe per CPU aggregation and the core is set to the CPU in
places like print_counter_aggrdata in stat-display.c. Setting the core
to the CPU is undesirable as the CPU will exceed valid core values and
lead to confusion. Add a CPU variable to address this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/topology.c | 19 +++++++++++++++++++
 tools/perf/util/cpumap.c    | 25 +++++++++++++++++++++----
 tools/perf/util/cpumap.h    |  8 ++++++++
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index cb29ea7ec409..33e4cb81265c 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -119,6 +119,22 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 			 session->header.env.cpu[i].socket_id);
 	}
 
+	// Test that CPU ID contains socket, die, core and CPU
+	for (i = 0; i < map->nr; i++) {
+		id = aggr_cpu_id__cpu(perf_cpu_map__cpu(map, i), NULL);
+		TEST_ASSERT_VAL("Cpu map - CPU ID doesn't match", map->map[i] == id.cpu);
+
+		TEST_ASSERT_VAL("Cpu map - Core ID doesn't match",
+			session->header.env.cpu[map->map[i]].core_id == id.core);
+		TEST_ASSERT_VAL("Cpu map - Socket ID doesn't match",
+			session->header.env.cpu[map->map[i]].socket_id == id.socket);
+
+		TEST_ASSERT_VAL("Cpu map - Die ID doesn't match",
+			session->header.env.cpu[map->map[i]].die_id == id.die);
+		TEST_ASSERT_VAL("Cpu map - Node ID is set", id.node == -1);
+		TEST_ASSERT_VAL("Cpu map - Thread is set", id.thread == -1);
+	}
+
 	// Test that core ID contains socket, die and core
 	for (i = 0; i < map->nr; i++) {
 		id = aggr_cpu_id__core(perf_cpu_map__cpu(map, i), NULL);
@@ -145,6 +161,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 		TEST_ASSERT_VAL("Die map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Die map - Core is set", id.core == -1);
+		TEST_ASSERT_VAL("Die map - CPU is set", id.cpu == -1);
 		TEST_ASSERT_VAL("Die map - Thread is set", id.thread == -1);
 	}
 
@@ -157,6 +174,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Socket map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Socket map - Die ID is set", id.die == -1);
 		TEST_ASSERT_VAL("Socket map - Core is set", id.core == -1);
+		TEST_ASSERT_VAL("Socket map - CPU is set", id.cpu == -1);
 		TEST_ASSERT_VAL("Socket map - Thread is set", id.thread == -1);
 	}
 
@@ -168,6 +186,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Node map - Socket is set", id.socket == -1);
 		TEST_ASSERT_VAL("Node map - Die ID is set", id.die == -1);
 		TEST_ASSERT_VAL("Node map - Core is set", id.core == -1);
+		TEST_ASSERT_VAL("Node map - CPU is set", id.cpu == -1);
 		TEST_ASSERT_VAL("Node map - Thread is set", id.thread == -1);
 	}
 	perf_session__delete(session);
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 2779474f39db..48ce583af0ec 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -242,7 +242,7 @@ struct aggr_cpu_id aggr_cpu_id__core(int cpu, void *data)
 	struct aggr_cpu_id id;
 	int core = cpu__get_core_id(cpu);
 
-	/* aggr_cpu_id__die returns a struct with socket and die set*/
+	/* aggr_cpu_id__die returns a struct with socket and die set. */
 	id = aggr_cpu_id__die(cpu, data);
 	if (aggr_cpu_id__is_empty(&id))
 		return id;
@@ -256,6 +256,20 @@ struct aggr_cpu_id aggr_cpu_id__core(int cpu, void *data)
 
 }
 
+struct aggr_cpu_id aggr_cpu_id__cpu(int cpu, void *data)
+{
+	struct aggr_cpu_id id;
+
+	/* aggr_cpu_id__core returns a struct with socket, die and core set. */
+	id = aggr_cpu_id__core(cpu, data);
+	if (aggr_cpu_id__is_empty(&id))
+		return id;
+
+	id.cpu = cpu;
+	return id;
+
+}
+
 struct aggr_cpu_id aggr_cpu_id__node(int cpu, void *data __maybe_unused)
 {
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
@@ -579,7 +593,8 @@ bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b
 		a->node == b->node &&
 		a->socket == b->socket &&
 		a->die == b->die &&
-		a->core == b->core;
+		a->core == b->core &&
+		a->cpu == b->cpu;
 }
 
 bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a)
@@ -588,7 +603,8 @@ bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a)
 		a->node == -1 &&
 		a->socket == -1 &&
 		a->die == -1 &&
-		a->core == -1;
+		a->core == -1 &&
+		a->cpu == -1;
 }
 
 struct aggr_cpu_id aggr_cpu_id__empty(void)
@@ -598,7 +614,8 @@ struct aggr_cpu_id aggr_cpu_id__empty(void)
 		.node = -1,
 		.socket = -1,
 		.die = -1,
-		.core = -1
+		.core = -1,
+		.cpu = -1
 	};
 	return ret;
 }
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 25a08d640d81..b98cd1739677 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -22,6 +22,8 @@ struct aggr_cpu_id {
 	int die;
 	/** The core id as read from /sys/devices/system/cpu/cpuX/topology/core_id. */
 	int core;
+	/** CPU aggregation, note there is one CPU for each SMT thread. */
+	int cpu;
 };
 
 /** A collection of aggr_cpu_id values, the "built" version is sorted and uniqued. */
@@ -109,6 +111,12 @@ struct aggr_cpu_id aggr_cpu_id__die(int cpu, void *data);
  * compatible with aggr_cpu_id_get_t.
  */
 struct aggr_cpu_id aggr_cpu_id__core(int cpu, void *data);
+/**
+ * aggr_cpu_id__core - Create an aggr_cpu_id with the cpu, core, die and socket
+ * populated with the cpu, core, die and socket for cpu. The function signature
+ * is compatible with aggr_cpu_id_get_t.
+ */
+struct aggr_cpu_id aggr_cpu_id__cpu(int cpu, void *data);
 /**
  * aggr_cpu_id__node - Create an aggr_cpu_id with the numa node populated for
  * cpu. The function signature is compatible with aggr_cpu_id_get_t.
-- 
2.34.1.448.ga2b2bfdf31-goog

