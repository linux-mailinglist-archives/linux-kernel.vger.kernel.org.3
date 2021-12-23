Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231A247DFD1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347303AbhLWHsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347143AbhLWHrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:11 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B09C0617A2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h5-20020a255f45000000b005ffd939127bso8564808ybm.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4fl4+/RnYjZ/c1n8ssVcVocIenEbnGshJWO17sTd1Uo=;
        b=oJfnWHmlynNBn19s9/HxQ1IK3WCOMXNxc7scb8vAYOYBizAcv9o6gqt8VqdYzDtnr9
         QljlK4aAp9ZJ6wHnEFE+wHnQEJgax6fbyNSRiXoXMnp3fdxKYbuOFB3tsUbPLAHwdv09
         UH6ahZ/BtFOvBp/9oAKJ7iNLsGXSpwH3K+nNRMfTfyiIAKSa2AbIPoyUU2G0JA30bfhO
         qRF0vfNwvNwh4XGqRc2shAkpVko8NMIOzTgm4GTLUms/OfNG8Wj5A5lAs4V7aFY2kFj1
         9NaVeAdM/eY304F8LTLkma1ZlpExQNsO1n+Wso+/AirzMTq0Q08KXvl22VIMPvmgu8Z1
         umTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4fl4+/RnYjZ/c1n8ssVcVocIenEbnGshJWO17sTd1Uo=;
        b=5nIljoOZVeTEGlD9iLBcAFW3Vm0QNB78RSgQW4KKQKFQBhUTxhshxoPzIsjLEn9Mda
         HZy6pI9FS+pLvCB31i10IQiiXZK1ftCrxRkBbyBvx86lQ/nSHxU5Cl3hxuMCjjL3CGq2
         FqOi3+k0J3P6yJkqeHijQ7CSh5BB0SLJCur/4k8T42xbPNzawXEFlGN0DCsGWWCCeDb+
         jLdxsELnIxi0CcY70Y1rcfdk48kJJ1TEB2ZNNXAi2/eeegsorh6vg6bCJNwv4hFmfesY
         kWy/IkqyaEV+KQn46dRGTnB5Q1PhDytC6VIy5Xb9d4o/nPqNliNCeWtSLgRREsxucL7d
         /jyQ==
X-Gm-Message-State: AOAM530Dyp0fZGFQkUP4l8Gyf+Vp+a6+gyNVkSu6V0gigvRgfSTJWaum
        HV3utjtUofhO8jfkEe/cnkv/8b88Xz0e
X-Google-Smtp-Source: ABdhPJxeDyR4cL1775cPklXCUGbNUUrez4v3eL6JgYpB5hpzHlaMeypTbkzUhbIYH0sAg4bmvOd4T9kLv+ZI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a05:6902:706:: with SMTP id
 k6mr1788789ybt.643.1640245628437; Wed, 22 Dec 2021 23:47:08 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:17 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-25-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 24/48] perf cpumap: Add CPU to aggr_cpu_id
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

With no aggregration, such as 'perf stat -A', the aggr_cpu_id lacks a
way to describe per CPU aggregation and the core is set to the CPU in
places like print_counter_aggrdata in stat-display.c. Setting the core
to the CPU is undesirable as the CPU will exceed valid core values and
lead to confusion. Add a CPU variable to address this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/topology.c | 19 +++++++++++++++++++
 tools/perf/util/cpumap.c    | 23 ++++++++++++++++++++---
 tools/perf/util/cpumap.h    |  8 ++++++++
 3 files changed, 47 insertions(+), 3 deletions(-)

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
index 985c87f1f1ca..a535fd360d46 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -253,6 +253,20 @@ struct aggr_cpu_id aggr_cpu_id__core(int cpu, void *data)
 
 }
 
+struct aggr_cpu_id aggr_cpu_id__cpu(int cpu, void *data)
+{
+	struct aggr_cpu_id id;
+
+	/* aggr_cpu_id__die returns a struct with socket and die set*/
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
@@ -576,7 +590,8 @@ bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b
 		a->node == b->node &&
 		a->socket == b->socket &&
 		a->die == b->die &&
-		a->core == b->core;
+		a->core == b->core &&
+		a->cpu == b->cpu;
 }
 
 bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a)
@@ -585,7 +600,8 @@ bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a)
 		a->node == -1 &&
 		a->socket == -1 &&
 		a->die == -1 &&
-		a->core == -1;
+		a->core == -1 &&
+		a->cpu == -1;
 }
 
 struct aggr_cpu_id aggr_cpu_id__empty(void)
@@ -595,7 +611,8 @@ struct aggr_cpu_id aggr_cpu_id__empty(void)
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
index 8acef8ff8753..651c6417d3c3 100644
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
2.34.1.307.g9b7440fafd-goog

