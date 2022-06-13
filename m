Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27D854824C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240390AbiFMIsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240394AbiFMIsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:48:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB9E17AB4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:47:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-313bc9c54acso47900187b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e3k1t6ubd4zJKD6s+EQnq7VGeotywjYalzT/OIoKrJA=;
        b=LiM33q92XdF2+A+2GjoiHqU+bXy9faQKosr0ApO6xmjU6eDvGPEVxZ1IwI7MqFPS5Z
         CxYkTl50R/y9PrPd+rFDrJcIy8wS63WyD+ZhRI582fTuQvpmH0IwZAYuwGZz2tl73wn3
         JuP7/XtRK0DDMUh7sTKE22U+kwh2TF25Lfh7LNm8UniIX++cMl129pPvj/hyro8UEK17
         N1sEPTZL8+7v8pyI0UzS2IMOFFp2b++teui4v33fa0BikxwzMXaTzHwpgSFuRTtEnMMe
         KK4NeCnRJWOq0+MHeRY6AFMkWjMx6FYx7EM1IjNm1rCWI6Ve83kErvd45g+XkdSpWbU8
         wmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e3k1t6ubd4zJKD6s+EQnq7VGeotywjYalzT/OIoKrJA=;
        b=l1i6oxfCL2ALG26dq0h9fABxL86+ur96zCDcDjmTR3tBw1uVdsNPb6wIhMMfUXvGjz
         Z4ivMBqLAuV79wQ3loKhLxzkXpqagNYd5gI/2lz3RyxLvImmLh0jNHYyAZzNuLWDsKIE
         VCn20YjGlhcsdjLr56R8UHF/YXX+o4C+/HSsjUfKIhn2Nb50Fbm5bkTtqPvJ98AU46Fu
         NwZEsPprj26V1/yD/MXuScrc9xvat0NR7Q1kYCoDqn1WyjAgyXOInG1HK9rOvDNuhuoK
         gqUjJ9B8soZZPvUThUfQDEC722y+pvD4eWSuogELGD0U/C4kpQkZWRbwinhvZ4q4Iboj
         vf8Q==
X-Gm-Message-State: AOAM533rVS/oSwiIJtJ6qngkiinXuWV8UScaBvTNeNHpPmIa2DshYWbC
        4t5YDBGDCnI6b4hhqUJGFxb3Kp8a1KMe
X-Google-Smtp-Source: ABdhPJxALdusKhXb2Rj6pP8ilkYN+GxayrwZNrQj93BDDcdQ7PSm0enp6Q5p5hmA/w9NG/t1Bh42I/6fUOTl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1256:a8b4:594a:9164])
 (user=irogers job=sendgmr) by 2002:a25:db48:0:b0:664:7366:8f13 with SMTP id
 g69-20020a25db48000000b0066473668f13mr13541736ybf.87.1655110077624; Mon, 13
 Jun 2022 01:47:57 -0700 (PDT)
Date:   Mon, 13 Jun 2022 01:47:39 -0700
In-Reply-To: <20220613084739.1159111-1-irogers@google.com>
Message-Id: <20220613084739.1159111-7-irogers@google.com>
Mime-Version: 1.0
References: <20220613084739.1159111-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 6/6] perf cpumap: Add range data encoding
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Often cpumaps encode a range of all CPUs, add a compact encoding that
doesn't require a bit mask or list of all CPUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/perf/event.h |  14 +++
 tools/perf/tests/cpumap.c           |  52 ++++++++--
 tools/perf/util/cpumap.c            |  31 +++++-
 tools/perf/util/session.c           |   5 +
 tools/perf/util/synthetic-events.c  | 151 ++++++++++++++--------------
 5 files changed, 166 insertions(+), 87 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 21170f5afb61..43f990b8c58b 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -152,6 +152,7 @@ struct perf_record_header_attr {
 enum {
 	PERF_CPU_MAP__CPUS = 0,
 	PERF_CPU_MAP__MASK = 1,
+	PERF_CPU_MAP__RANGE_CPUS = 2,
 };
 
 /*
@@ -185,6 +186,17 @@ struct perf_record_mask_cpu_map64 {
 	__u64			 mask[];
 };
 
+/*
+ * An encoding of a CPU map for a range starting at start_cpu through to
+ * end_cpu. If any_cpu is 1, an any CPU (-1) value (aka dummy value) is present.
+ */
+struct perf_record_range_cpu_map {
+	__u8 any_cpu;
+	__u8 __pad;
+	__u16 start_cpu;
+	__u16 end_cpu;
+};
+
 struct __packed perf_record_cpu_map_data {
 	__u16			 type;
 	union {
@@ -194,6 +206,8 @@ struct __packed perf_record_cpu_map_data {
 		struct perf_record_mask_cpu_map32 mask32_data;
 		/* Used when type == PERF_CPU_MAP__MASK and long_size == 8. */
 		struct perf_record_mask_cpu_map64 mask64_data;
+		/* Used when type == PERF_CPU_MAP__RANGE_CPUS. */
+		struct perf_record_range_cpu_map range_cpu_data;
 	};
 };
 
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 7ea150cdc137..7c873c6ae3eb 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -19,7 +19,6 @@ static int process_event_mask(struct perf_tool *tool __maybe_unused,
 	struct perf_record_cpu_map *map_event = &event->cpu_map;
 	struct perf_record_cpu_map_data *data;
 	struct perf_cpu_map *map;
-	int i;
 	unsigned int long_size;
 
 	data = &map_event->data;
@@ -32,16 +31,17 @@ static int process_event_mask(struct perf_tool *tool __maybe_unused,
 
 	TEST_ASSERT_VAL("wrong nr",   data->mask32_data.nr == 1);
 
-	for (i = 0; i < 20; i++) {
+	TEST_ASSERT_VAL("wrong cpu", perf_record_cpu_map_data__test_bit(0, data));
+	TEST_ASSERT_VAL("wrong cpu", !perf_record_cpu_map_data__test_bit(1, data));
+	for (int i = 2; i <= 20; i++)
 		TEST_ASSERT_VAL("wrong cpu", perf_record_cpu_map_data__test_bit(i, data));
-	}
 
 	map = cpu_map__new_data(data);
 	TEST_ASSERT_VAL("wrong nr",  perf_cpu_map__nr(map) == 20);
 
-	for (i = 0; i < 20; i++) {
-		TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, i).cpu == i);
-	}
+	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, 0).cpu == 0);
+	for (int i = 2; i <= 20; i++)
+		TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, i - 1).cpu == i);
 
 	perf_cpu_map__put(map);
 	return 0;
@@ -73,25 +73,59 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
+static int process_event_range_cpus(struct perf_tool *tool __maybe_unused,
+				union perf_event *event,
+				struct perf_sample *sample __maybe_unused,
+				struct machine *machine __maybe_unused)
+{
+	struct perf_record_cpu_map *map_event = &event->cpu_map;
+	struct perf_record_cpu_map_data *data;
+	struct perf_cpu_map *map;
+
+	data = &map_event->data;
+
+	TEST_ASSERT_VAL("wrong type", data->type == PERF_CPU_MAP__RANGE_CPUS);
+
+	TEST_ASSERT_VAL("wrong any_cpu",   data->range_cpu_data.any_cpu == 0);
+	TEST_ASSERT_VAL("wrong start_cpu", data->range_cpu_data.start_cpu == 1);
+	TEST_ASSERT_VAL("wrong end_cpu",   data->range_cpu_data.end_cpu == 256);
+
+	map = cpu_map__new_data(data);
+	TEST_ASSERT_VAL("wrong nr",  perf_cpu_map__nr(map) == 256);
+	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, 0).cpu == 1);
+	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__max(map).cpu == 256);
+	TEST_ASSERT_VAL("wrong refcnt", refcount_read(&map->refcnt) == 1);
+	perf_cpu_map__put(map);
+	return 0;
+}
+
 
 static int test__cpu_map_synthesize(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_cpu_map *cpus;
 
-	/* This one is better stores in mask. */
-	cpus = perf_cpu_map__new("0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19");
+	/* This one is better stored in a mask. */
+	cpus = perf_cpu_map__new("0,2-20");
 
 	TEST_ASSERT_VAL("failed to synthesize map",
 		!perf_event__synthesize_cpu_map(NULL, cpus, process_event_mask, NULL));
 
 	perf_cpu_map__put(cpus);
 
-	/* This one is better stores in cpu values. */
+	/* This one is better stored in cpu values. */
 	cpus = perf_cpu_map__new("1,256");
 
 	TEST_ASSERT_VAL("failed to synthesize map",
 		!perf_event__synthesize_cpu_map(NULL, cpus, process_event_cpus, NULL));
 
+	perf_cpu_map__put(cpus);
+
+	/* This one is better stored as a range. */
+	cpus = perf_cpu_map__new("1-256");
+
+	TEST_ASSERT_VAL("failed to synthesize map",
+		!perf_event__synthesize_cpu_map(NULL, cpus, process_event_range_cpus, NULL));
+
 	perf_cpu_map__put(cpus);
 	return 0;
 }
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index ae43fb88f444..2389bd3e19b8 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -112,12 +112,39 @@ static struct perf_cpu_map *cpu_map__from_mask(const struct perf_record_cpu_map_
 
 }
 
+static struct perf_cpu_map *cpu_map__from_range(const struct perf_record_cpu_map_data *data)
+{
+	struct perf_cpu_map *map;
+	unsigned int i = 0;
+
+	map = perf_cpu_map__empty_new(data->range_cpu_data.end_cpu -
+				data->range_cpu_data.start_cpu + 1 + data->range_cpu_data.any_cpu);
+	if (!map)
+		return NULL;
+
+	if (data->range_cpu_data.any_cpu)
+		map->map[i++].cpu = -1;
+
+	for (int cpu = data->range_cpu_data.start_cpu; cpu <= data->range_cpu_data.end_cpu;
+	     i++, cpu++)
+		map->map[i].cpu = cpu;
+
+	return map;
+}
+
 struct perf_cpu_map *cpu_map__new_data(const struct perf_record_cpu_map_data *data)
 {
-	if (data->type == PERF_CPU_MAP__CPUS)
+	switch (data->type) {
+	case PERF_CPU_MAP__CPUS:
 		return cpu_map__from_entries(data);
-	else
+	case PERF_CPU_MAP__MASK:
 		return cpu_map__from_mask(data);
+	case PERF_CPU_MAP__RANGE_CPUS:
+		return cpu_map__from_range(data);
+	default:
+		pr_err("cpu_map__new_data unknown type %d\n", data->type);
+		return NULL;
+	}
 }
 
 size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp)
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d52a39ba48e3..0acb9de54b06 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -941,6 +941,11 @@ static void perf_event__cpu_map_swap(union perf_event *event,
 		default:
 			pr_err("cpu_map swap: unsupported long size\n");
 		}
+		break;
+	case PERF_CPU_MAP__RANGE_CPUS:
+		data->range_cpu_data.start_cpu = bswap_16(data->range_cpu_data.start_cpu);
+		data->range_cpu_data.end_cpu = bswap_16(data->range_cpu_data.end_cpu);
+		break;
 	default:
 		break;
 	}
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index ec54ac1ed96f..810ed1dc6e6d 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1183,93 +1183,97 @@ int perf_event__synthesize_thread_map2(struct perf_tool *tool,
 	return err;
 }
 
-static void synthesize_cpus(struct perf_record_cpu_map_data *data,
-			    const struct perf_cpu_map *map)
-{
-	int i, map_nr = perf_cpu_map__nr(map);
-
-	data->cpus_data.nr = map_nr;
+struct synthesize_cpu_map_data {
+	const struct perf_cpu_map *map;
+	int nr;
+	int min_cpu;
+	int max_cpu;
+	int has_any_cpu;
+	int type;
+	size_t size;
+	struct perf_record_cpu_map_data *data;
+};
 
-	for (i = 0; i < map_nr; i++)
-		data->cpus_data.cpu[i] = perf_cpu_map__cpu(map, i).cpu;
+static void synthesize_cpus(struct synthesize_cpu_map_data *data)
+{
+	data->data->type = PERF_CPU_MAP__CPUS;
+	data->data->cpus_data.nr = data->nr;
+	for (int i = 0; i < data->nr; i++)
+		data->data->cpus_data.cpu[i] = perf_cpu_map__cpu(data->map, i).cpu;
 }
 
-static void synthesize_mask(struct perf_record_cpu_map_data *data,
-			    const struct perf_cpu_map *map, int max)
+static void synthesize_mask(struct synthesize_cpu_map_data *data)
 {
 	int idx;
 	struct perf_cpu cpu;
 
 	/* Due to padding, the 4bytes per entry mask variant is always smaller. */
-	data->mask32_data.nr = BITS_TO_U32(max);
-	data->mask32_data.long_size = 4;
+	data->data->type = PERF_CPU_MAP__MASK;
+	data->data->mask32_data.nr = BITS_TO_U32(data->max_cpu);
+	data->data->mask32_data.long_size = 4;
 
-	perf_cpu_map__for_each_cpu(cpu, idx, map) {
+	perf_cpu_map__for_each_cpu(cpu, idx, data->map) {
 		int bit_word = cpu.cpu / 32;
-		__u32 bit_mask = 1U << (cpu.cpu & 31);
+		u32 bit_mask = 1U << (cpu.cpu & 31);
 
-		data->mask32_data.mask[bit_word] |= bit_mask;
+		data->data->mask32_data.mask[bit_word] |= bit_mask;
 	}
 }
 
-static size_t cpus_size(const struct perf_cpu_map *map)
+static void synthesize_range_cpus(struct synthesize_cpu_map_data *data)
 {
-	return sizeof(struct cpu_map_entries) + perf_cpu_map__nr(map) * sizeof(u16);
+	data->data->type = PERF_CPU_MAP__RANGE_CPUS;
+	data->data->range_cpu_data.any_cpu = data->has_any_cpu;
+	data->data->range_cpu_data.start_cpu = data->min_cpu;
+	data->data->range_cpu_data.end_cpu = data->max_cpu;
 }
 
-static size_t mask_size(const struct perf_cpu_map *map, int *max)
-{
-	*max = perf_cpu_map__max(map).cpu;
-	return sizeof(struct perf_record_mask_cpu_map32) + BITS_TO_U32(*max) * sizeof(__u32);
-}
-
-static void *cpu_map_data__alloc(const struct perf_cpu_map *map, size_t *size,
-				 u16 *type, int *max)
+static void *cpu_map_data__alloc(struct synthesize_cpu_map_data *syn_data,
+				 size_t header_size)
 {
 	size_t size_cpus, size_mask;
-	bool is_dummy = perf_cpu_map__empty(map);
 
-	/*
-	 * Both array and mask data have variable size based
-	 * on the number of cpus and their actual values.
-	 * The size of the 'struct perf_record_cpu_map_data' is:
-	 *
-	 *   array = size of 'struct cpu_map_entries' +
-	 *           number of cpus * sizeof(u64)
-	 *
-	 *   mask  = size of 'struct perf_record_record_cpu_map' +
-	 *           maximum cpu bit converted to size of longs
-	 *
-	 * and finally + the size of 'struct perf_record_cpu_map_data'.
-	 */
-	size_cpus = cpus_size(map);
-	size_mask = mask_size(map, max);
+	syn_data->nr = perf_cpu_map__nr(syn_data->map);
+	syn_data->has_any_cpu = (perf_cpu_map__cpu(syn_data->map, 0).cpu == -1) ? 1 : 0;
 
-	if (is_dummy || (size_cpus < size_mask)) {
-		*size += size_cpus;
-		*type  = PERF_CPU_MAP__CPUS;
-	} else {
-		*size += size_mask;
-		*type  = PERF_CPU_MAP__MASK;
+	syn_data->min_cpu = perf_cpu_map__cpu(syn_data->map, syn_data->has_any_cpu).cpu;
+	syn_data->max_cpu = perf_cpu_map__max(syn_data->map).cpu;
+	if (syn_data->max_cpu - syn_data->min_cpu + 1 == syn_data->nr - syn_data->has_any_cpu) {
+		/* A consecutive range of CPUs can be encoded using a range. */
+		assert(sizeof(u16) + sizeof(struct perf_record_range_cpu_map) == sizeof(u64));
+		syn_data->type = PERF_CPU_MAP__RANGE_CPUS;
+		syn_data->size = header_size + sizeof(u64);
+		return zalloc(syn_data->size);
 	}
 
-	*size += sizeof(__u16); /* For perf_record_cpu_map_data.type. */
-	*size = PERF_ALIGN(*size, sizeof(u64));
-	return zalloc(*size);
+	size_cpus = sizeof(u16) + sizeof(struct cpu_map_entries) + syn_data->nr * sizeof(u16);
+	/* Due to padding, the 4bytes per entry mask variant is always smaller. */
+	size_mask = sizeof(u16) + sizeof(struct perf_record_mask_cpu_map32) +
+		BITS_TO_U32(syn_data->max_cpu) * sizeof(__u32);
+	if (syn_data->has_any_cpu || size_cpus < size_mask) {
+		/* Follow the CPU map encoding. */
+		syn_data->type = PERF_CPU_MAP__CPUS;
+		syn_data->size = header_size + PERF_ALIGN(size_cpus, sizeof(u64));
+		return zalloc(syn_data->size);
+	}
+	/* Encode using a bitmask. */
+	syn_data->type = PERF_CPU_MAP__MASK;
+	syn_data->size = header_size + PERF_ALIGN(size_mask, sizeof(u64));
+	return zalloc(syn_data->size);
 }
 
-static void cpu_map_data__synthesize(struct perf_record_cpu_map_data *data,
-				     const struct perf_cpu_map *map,
-				     u16 type, int max)
+static void cpu_map_data__synthesize(struct synthesize_cpu_map_data *data)
 {
-	data->type = type;
-
-	switch (type) {
+	switch (data->type) {
 	case PERF_CPU_MAP__CPUS:
-		synthesize_cpus(data, map);
+		synthesize_cpus(data);
 		break;
 	case PERF_CPU_MAP__MASK:
-		synthesize_mask(data, map, max);
+		synthesize_mask(data);
+		break;
+	case PERF_CPU_MAP__RANGE_CPUS:
+		synthesize_range_cpus(data);
+		break;
 	default:
 		break;
 	}
@@ -1277,23 +1281,22 @@ static void cpu_map_data__synthesize(struct perf_record_cpu_map_data *data,
 
 static struct perf_record_cpu_map *cpu_map_event__new(const struct perf_cpu_map *map)
 {
-	size_t size = sizeof(struct perf_event_header);
+	struct synthesize_cpu_map_data syn_data = { .map = map };
 	struct perf_record_cpu_map *event;
-	int max;
-	u16 type;
 
-	event = cpu_map_data__alloc(map, &size, &type, &max);
+
+	event = cpu_map_data__alloc(&syn_data, sizeof(struct perf_event_header));
 	if (!event)
 		return NULL;
 
+	syn_data.data = &event->data;
 	event->header.type = PERF_RECORD_CPU_MAP;
-	event->header.size = size;
-	event->data.type   = type;
-
-	cpu_map_data__synthesize(&event->data, map, type, max);
+	event->header.size = syn_data.size;
+	cpu_map_data__synthesize(&syn_data);
 	return event;
 }
 
+
 int perf_event__synthesize_cpu_map(struct perf_tool *tool,
 				   const struct perf_cpu_map *map,
 				   perf_event__handler_t process,
@@ -1891,24 +1894,20 @@ int perf_event__synthesize_event_update_name(struct perf_tool *tool, struct evse
 int perf_event__synthesize_event_update_cpus(struct perf_tool *tool, struct evsel *evsel,
 					     perf_event__handler_t process)
 {
-	size_t size = sizeof(struct perf_event_header) + sizeof(u64) + sizeof(u64);
+	struct synthesize_cpu_map_data syn_data = { .map = evsel->core.own_cpus };
 	struct perf_record_event_update *ev;
-	int max, err;
-	u16 type;
-
-	if (!evsel->core.own_cpus)
-		return 0;
+	int err;
 
-	ev = cpu_map_data__alloc(evsel->core.own_cpus, &size, &type, &max);
+	ev = cpu_map_data__alloc(&syn_data, sizeof(struct perf_event_header));
 	if (!ev)
 		return -ENOMEM;
 
+	syn_data.data = &ev->cpus.cpus;
 	ev->header.type = PERF_RECORD_EVENT_UPDATE;
-	ev->header.size = (u16)size;
+	ev->header.size = (u16)syn_data.size;
 	ev->type	= PERF_EVENT_UPDATE__CPUS;
 	ev->id		= evsel->core.id[0];
-
-	cpu_map_data__synthesize(&ev->cpus.cpus, evsel->core.own_cpus, type, max);
+	cpu_map_data__synthesize(&syn_data);
 
 	err = process(tool, (union perf_event *)ev, NULL, NULL);
 	free(ev);
-- 
2.36.1.476.g0c4daa206d-goog

