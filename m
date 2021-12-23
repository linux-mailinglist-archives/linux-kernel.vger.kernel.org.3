Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEAD47DFCC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347259AbhLWHr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347075AbhLWHrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D181C06175B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q198-20020a25d9cf000000b005f7a6a84f9fso8567449ybg.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MpQ9JbQr3HlpwnDJApfNQMTPoiVpc8Vmb9u/K5T47HA=;
        b=qwAHiOgIXlSa8wzdii8vzLZkZ7YeP4F8PPIJduxf8StSUXQOcCelsewNrRw/KLc9So
         n3An1dNZxVbbb5TRWl1YL1ZA6etm7YBs7UZ3w/Taul6jGKfL0qys9W6VQiE4wzC38+iv
         n1eBoZurEM7l1a1PS61AhWBv498kY/PujSTOSNuuJTPzjM8Wuxpfv2i5G5+wCu70IoP5
         5/kA2sgQBN0DUybhldTcHY51zvc/NMTE838RztRO1oP/+PbeQhWHgYKD9NAaMGLyhicw
         QIyhNrnWPrINMHY2A0CaLRWAhnRTB5S3YCunhq98V+aZFVijWyfVP7FSyQ7g8OZRYSKA
         eFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MpQ9JbQr3HlpwnDJApfNQMTPoiVpc8Vmb9u/K5T47HA=;
        b=V2O5ZMFgOKXknFuQq+k7P5+7QsSIizGASe3eHALdVYU7mIFXuqNkArEOgWe7QxfuzY
         a2mM1s/mU3f600lcugNcXhYBALppVqptX1AVMY6L0zVATIi2X//sSLhuhonYf7LcRztL
         aCZJjBpyStAnyiG3rCl89DybjC3zmckfAU/JykxthdcmxHp+cT7kPAIAs7VqbkqtezFn
         9uSThjfyf42VHCG9qbRLfElpM3JZ52cgEgj6ZoqBD+uuG3ssWc195i6v/lrV/2oXoeZ0
         A0X7/9EKJA5w2EJiqd4zNQTUL0DmWGZ9FEtV8UEZqMo83uqjhzoD4egeFoIlzAZW446G
         jDVw==
X-Gm-Message-State: AOAM5313eWcytcdhW6R4rLdTO8Rey9TV34DjKwVO6DMwpiz4aXKWmerl
        ucGAa0sWxcWTXgGShQRuaBx2/bRL/IAw
X-Google-Smtp-Source: ABdhPJx6e0CPGdyQKuaH3pga3LQ6mgyRV1se1FBJer87qYIGCvW0v+4KhJ/ZQjzvXJIQeHqrFdg8Q9vzsB51
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:26cb:: with SMTP id
 m194mr1631918ybm.558.1640245615441; Wed, 22 Dec 2021 23:46:55 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:12 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-20-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 19/48] perf cpumap: Rename cpu_map__get_X_aggr_by_cpu functions
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

The functions don't use a cpu_map so reduce them to being like
constructors of aggr_cpu_id.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c   | 18 +++++++++---------
 tools/perf/tests/topology.c |  8 ++++----
 tools/perf/util/cpumap.c    | 14 +++++++-------
 tools/perf/util/cpumap.h    | 29 +++++++++++++++++++++++++----
 4 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2b04a948cf37..98f80c217279 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1336,25 +1336,25 @@ static const char *const aggr_mode__string[] = {
 static struct aggr_cpu_id perf_stat__get_socket(struct perf_stat_config *config __maybe_unused,
 						int cpu)
 {
-	return cpu_map__get_socket_aggr_by_cpu(cpu, /*data=*/NULL);
+	return aggr_cpu_id__socket(cpu, /*data=*/NULL);
 }
 
 static struct aggr_cpu_id perf_stat__get_die(struct perf_stat_config *config __maybe_unused,
 					     int cpu)
 {
-	return cpu_map__get_die_aggr_by_cpu(cpu, /*data=*/NULL);
+	return aggr_cpu_id__die(cpu, /*data=*/NULL);
 }
 
 static struct aggr_cpu_id perf_stat__get_core(struct perf_stat_config *config __maybe_unused,
 					      int cpu)
 {
-	return cpu_map__get_core_aggr_by_cpu(cpu, /*data=*/NULL);
+	return aggr_cpu_id__core(cpu, /*data=*/NULL);
 }
 
 static struct aggr_cpu_id perf_stat__get_node(struct perf_stat_config *config __maybe_unused,
 					      int cpu)
 {
-	return cpu_map__get_node_aggr_by_cpu(cpu, /*data=*/NULL);
+	return aggr_cpu_id__node(cpu, /*data=*/NULL);
 }
 
 static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
@@ -1409,16 +1409,16 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
 {
 	switch (aggr_mode) {
 	case AGGR_SOCKET:
-		return cpu_map__get_socket_aggr_by_cpu;
+		return aggr_cpu_id__socket;
 	case AGGR_DIE:
-		return cpu_map__get_die_aggr_by_cpu;
+		return aggr_cpu_id__die;
 	case AGGR_CORE:
-		return cpu_map__get_core_aggr_by_cpu;
+		return aggr_cpu_id__core;
 	case AGGR_NODE:
-		return cpu_map__get_node_aggr_by_cpu;
+		return aggr_cpu_id__node;
 	case AGGR_NONE:
 		if (term_percore_set())
-			return cpu_map__get_core_aggr_by_cpu;
+			return aggr_cpu_id__core;
 
 		return NULL;
 	case AGGR_GLOBAL:
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 5992b323c4f5..0cb7b015b4b9 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -121,7 +121,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 	// Test that core ID contains socket, die and core
 	for (i = 0; i < map->nr; i++) {
-		id = cpu_map__get_core_aggr_by_cpu(perf_cpu_map__cpu(map, i), NULL);
+		id = aggr_cpu_id__core(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Core map - Core ID doesn't match",
 			session->header.env.cpu[map->map[i]].core_id == id.core);
 
@@ -136,7 +136,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 	// Test that die ID contains socket and die
 	for (i = 0; i < map->nr; i++) {
-		id = cpu_map__get_die_aggr_by_cpu(perf_cpu_map__cpu(map, i), NULL);
+		id = aggr_cpu_id__die(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Die map - Socket ID doesn't match",
 			session->header.env.cpu[map->map[i]].socket_id == id.socket);
 
@@ -150,7 +150,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 	// Test that socket ID contains only socket
 	for (i = 0; i < map->nr; i++) {
-		id = cpu_map__get_socket_aggr_by_cpu(perf_cpu_map__cpu(map, i), NULL);
+		id = aggr_cpu_id__socket(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Socket map - Socket ID doesn't match",
 			session->header.env.cpu[map->map[i]].socket_id == id.socket);
 
@@ -162,7 +162,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 	// Test that node ID contains only node
 	for (i = 0; i < map->nr; i++) {
-		id = cpu_map__get_node_aggr_by_cpu(perf_cpu_map__cpu(map, i), NULL);
+		id = aggr_cpu_id__node(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Node map - Node ID doesn't match",
 			cpu__get_node(map->map[i]) == id.node);
 		TEST_ASSERT_VAL("Node map - Socket is set", id.socket == -1);
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index ba4468f691c8..0e325559c33c 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -132,7 +132,7 @@ int cpu__get_socket_id(int cpu)
 	return ret ?: value;
 }
 
-struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data __maybe_unused)
+struct aggr_cpu_id aggr_cpu_id__socket(int cpu, void *data __maybe_unused)
 {
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
@@ -200,7 +200,7 @@ int cpu__get_die_id(int cpu)
 	return ret ?: value;
 }
 
-struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data)
+struct aggr_cpu_id aggr_cpu_id__die(int cpu, void *data)
 {
 	struct aggr_cpu_id id;
 	int die;
@@ -215,7 +215,7 @@ struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data)
 	 * with the socket ID and then add die to
 	 * make a unique ID.
 	 */
-	id = cpu_map__get_socket_aggr_by_cpu(cpu, data);
+	id = aggr_cpu_id__socket(cpu, data);
 	if (aggr_cpu_id__is_empty(&id))
 		return id;
 
@@ -229,13 +229,13 @@ int cpu__get_core_id(int cpu)
 	return ret ?: value;
 }
 
-struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data)
+struct aggr_cpu_id aggr_cpu_id__core(int cpu, void *data)
 {
 	struct aggr_cpu_id id;
 	int core = cpu__get_core_id(cpu);
 
-	/* cpu_map__get_die returns a struct with socket and die set*/
-	id = cpu_map__get_die_aggr_by_cpu(cpu, data);
+	/* aggr_cpu_id__die returns a struct with socket and die set*/
+	id = aggr_cpu_id__die(cpu, data);
 	if (aggr_cpu_id__is_empty(&id))
 		return id;
 
@@ -248,7 +248,7 @@ struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data)
 
 }
 
-struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data __maybe_unused)
+struct aggr_cpu_id aggr_cpu_id__node(int cpu, void *data __maybe_unused)
 {
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 02e8c80fea0a..15043e764fa6 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -39,10 +39,6 @@ struct perf_cpu_map *cpu_map__new_data(struct perf_record_cpu_map_data *data);
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
 size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size);
 size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp);
-struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data);
-struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
-struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data);
-struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data);
 const struct perf_cpu_map *cpu_map__online(void); /* thread unsafe */
 
 int cpu__setup_cpunode_map(void);
@@ -88,4 +84,29 @@ bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b
 bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a);
 struct aggr_cpu_id aggr_cpu_id__empty(void);
 
+
+/**
+ * aggr_cpu_id__socket - Create an aggr_cpu_id with the socket populated with
+ * the socket for cpu. The function signature is compatible with
+ * aggr_cpu_id_get_t.
+ */
+struct aggr_cpu_id aggr_cpu_id__socket(int cpu, void *data);
+/**
+ * aggr_cpu_id__die - Create an aggr_cpu_id with the die and socket populated
+ * with the die and socket for cpu. The function signature is compatible with
+ * aggr_cpu_id_get_t.
+ */
+struct aggr_cpu_id aggr_cpu_id__die(int cpu, void *data);
+/**
+ * aggr_cpu_id__core - Create an aggr_cpu_id with the core, die and socket
+ * populated with the core, die and socket for cpu. The function signature is
+ * compatible with aggr_cpu_id_get_t.
+ */
+struct aggr_cpu_id aggr_cpu_id__core(int cpu, void *data);
+/**
+ * aggr_cpu_id__node - Create an aggr_cpu_id with the numa node populated for
+ * cpu. The function signature is compatible with aggr_cpu_id_get_t.
+ */
+struct aggr_cpu_id aggr_cpu_id__node(int cpu, void *data);
+
 #endif /* __PERF_CPUMAP_H */
-- 
2.34.1.307.g9b7440fafd-goog

