Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02CD59A38B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351407AbiHSRwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351972AbiHSRvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:51:47 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF77611C31;
        Fri, 19 Aug 2022 10:25:25 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id h28so4865557pfq.11;
        Fri, 19 Aug 2022 10:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=dSpM4iLTLrET7xFCs7v5LyLdzEl5fofMVCKIs5uE6gc=;
        b=Xurqqa14dBlMPL/YF/6uPBgMV5lilln5OAktYAZF8vR/WEosZY/ohC5vAOsF3naRYa
         DElxlAN2p30qR8FfMuqvY7ILYy4ek56VKAJ+kM4h+b/wLSVHIs7d/C+e/0jMe2VqrDhA
         PbzF/AcP8mb+/EfiZZCY8bkTeuMUg6wyqr6/SXmUx4OfKl1GhEZbeBgN7+17wNypdX+x
         duRvn/U/I5/Z/aXr1YzWROMeLpE4roSnqI7uLNCkqriRsv6tWns/Aap3nnlSf1/rlcuF
         1bciYmM0OFjsPAOQlifVfS/upEs6utU2bM90TQ5oqca9Ht+g2jMVN20WIk/eoAqQDbZe
         2i+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=dSpM4iLTLrET7xFCs7v5LyLdzEl5fofMVCKIs5uE6gc=;
        b=4m6vgZ/hXv6dkysf/twcWTtH+hefpKrcSKF/ydOXmFoQe915jZ4JiHQyEnLIMivdEp
         TjGR//bjOE47ki2gOLio8e43BvpIEg/A63JAKrqyMk4yjpzXFuPTkBkmH+aPyZqs8QBF
         LE5XaodLiNdugE7SMXMRNjISsBNN7vSaRy7REn1SLUV9e5PxU16iHbrhuDezQ9v265Md
         veRr8ENq+eyDU7HyLbzPgaeHQF0oDxKDxYM5ZadYhnSH6HLOiNO0mM0aU9za+Xu3fuhb
         acDNFMnthqJYE885NrKEL4s6mi3Dty2F+Pt24FE7n0BQqSf7xAGq0ZNrYjiuO9yEVLjx
         99kg==
X-Gm-Message-State: ACgBeo3Tylv/kTBai7XyGXlRt1FvQpH5OyZ3Z1h8NPVO3sUYCpyVnwjY
        GUPtge83/NlR3jgnt4mBnZE=
X-Google-Smtp-Source: AA6agR5NwCrxAqaqcR90TzeNSEODBYEwOJad8eu7REQtnpR9U/+XeP6JiCBFT4Ct4Y4NyqdXb28ugg==
X-Received: by 2002:a63:85c6:0:b0:42a:39c8:a95c with SMTP id u189-20020a6385c6000000b0042a39c8a95cmr3866138pgd.306.1660929925166;
        Fri, 19 Aug 2022 10:25:25 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:93f3:4394:cc21:adca])
        by smtp.gmail.com with ESMTPSA id e13-20020a631e0d000000b0041d5001f0ecsm3056459pge.43.2022.08.19.10.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 10:25:24 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v3.1] perf tools: Support reading PERF_FORMAT_LOST
Date:   Fri, 19 Aug 2022 10:25:13 -0700
Message-Id: <20220819172513.2543494-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <Yv9rnnHFQ7qxOsag@krava>
References: <Yv9rnnHFQ7qxOsag@krava>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent kernel added lost count can be read from either read(2) or
ring buffer data with PERF_SAMPLE_READ.  As it's a variable length data
we need to access it according to the format info.

But for perf tools use cases, PERF_FORMAT_ID is always set.  So we can
only check PERF_FORMAT_LOST bit to determine the data format.

Add sample_read_value_size() and next_sample_read_value() helpers to
make it a bit easier to access.  Use them in all places where it reads
the struct sample_read_value.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
* remove an unnecessary cast change

 tools/perf/tests/sample-parsing.c             | 14 +++++---
 tools/perf/util/event.h                       | 21 ++++++++++-
 tools/perf/util/evsel.c                       | 26 +++++++++-----
 .../scripting-engines/trace-event-python.c    | 19 +++++++---
 tools/perf/util/session.c                     | 35 +++++++++++--------
 tools/perf/util/synthetic-events.c            | 32 +++++++++++++----
 6 files changed, 107 insertions(+), 40 deletions(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 07f2411b0ad4..20930dd48ee0 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -86,10 +86,15 @@ static bool samples_same(const struct perf_sample *s1,
 			COMP(read.time_running);
 		/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
 		if (read_format & PERF_FORMAT_GROUP) {
-			for (i = 0; i < s1->read.group.nr; i++)
-				MCOMP(read.group.values[i]);
+			for (i = 0; i < s1->read.group.nr; i++) {
+				/* FIXME: check values without LOST */
+				if (read_format & PERF_FORMAT_LOST)
+					MCOMP(read.group.values[i]);
+			}
 		} else {
 			COMP(read.one.id);
+			if (read_format & PERF_FORMAT_LOST)
+				COMP(read.one.lost);
 		}
 	}
 
@@ -263,7 +268,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 			.data	= (void *)aux_data,
 		},
 	};
-	struct sample_read_value values[] = {{1, 5}, {9, 3}, {2, 7}, {6, 4},};
+	struct sample_read_value values[] = {{1, 5, 0}, {9, 3, 0}, {2, 7, 0}, {6, 4, 1},};
 	struct perf_sample sample_out, sample_out_endian;
 	size_t i, sz, bufsz;
 	int err, ret = -1;
@@ -286,6 +291,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 	} else {
 		sample.read.one.value = 0x08789faeb786aa87ULL;
 		sample.read.one.id    = 99;
+		sample.read.one.lost  = 1;
 	}
 
 	sz = perf_event__sample_event_size(&sample, sample_type, read_format);
@@ -370,7 +376,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
  */
 static int test__sample_parsing(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	const u64 rf[] = {4, 5, 6, 7, 12, 13, 14, 15};
+	const u64 rf[] = {4, 5, 6, 7, 12, 13, 14, 15, 20, 21, 22, 28, 29, 30, 31};
 	u64 sample_type;
 	u64 sample_regs;
 	size_t i;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index a7b0931d5137..058d07923f04 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -65,7 +65,8 @@ struct stack_dump {
 
 struct sample_read_value {
 	u64 value;
-	u64 id;
+	u64 id;   /* only if PERF_FORMAT_ID */
+	u64 lost; /* only if PERF_FORMAT_LOST */
 };
 
 struct sample_read {
@@ -80,6 +81,24 @@ struct sample_read {
 	};
 };
 
+static inline size_t sample_read_value_size(u64 read_format)
+{
+	/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
+	if (read_format & PERF_FORMAT_LOST)
+		return sizeof(struct sample_read_value);
+	else
+		return offsetof(struct sample_read_value, lost);
+}
+
+static inline struct sample_read_value *
+next_sample_read_value(struct sample_read_value *v, u64 read_format)
+{
+	return (void *)v + sample_read_value_size(read_format);
+}
+
+#define sample_read_group__for_each(v, nr, rf)		\
+	for (int __i = 0; __i < (int)nr; v = next_sample_read_value(v, rf), __i++)
+
 struct ip_callchain {
 	u64 nr;
 	u64 ips[];
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4852089e1d79..16383df26166 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1541,7 +1541,7 @@ static int evsel__read_one(struct evsel *evsel, int cpu_map_idx, int thread)
 }
 
 static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
-			     u64 val, u64 ena, u64 run)
+			     u64 val, u64 ena, u64 run, u64 lost)
 {
 	struct perf_counts_values *count;
 
@@ -1550,6 +1550,7 @@ static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 	count->val    = val;
 	count->ena    = ena;
 	count->run    = run;
+	count->lost   = lost;
 
 	perf_counts__set_loaded(counter->counts, cpu_map_idx, thread, true);
 }
@@ -1558,7 +1559,7 @@ static int evsel__process_group_data(struct evsel *leader, int cpu_map_idx, int
 {
 	u64 read_format = leader->core.attr.read_format;
 	struct sample_read_value *v;
-	u64 nr, ena = 0, run = 0, i;
+	u64 nr, ena = 0, run = 0, lost = 0;
 
 	nr = *data++;
 
@@ -1573,16 +1574,17 @@ static int evsel__process_group_data(struct evsel *leader, int cpu_map_idx, int
 
 	v = (struct sample_read_value *) data;
 
-	evsel__set_count(leader, cpu_map_idx, thread, v[0].value, ena, run);
-
-	for (i = 1; i < nr; i++) {
+	sample_read_group__for_each(v, nr, read_format) {
 		struct evsel *counter;
 
-		counter = evlist__id2evsel(leader->evlist, v[i].id);
+		counter = evlist__id2evsel(leader->evlist, v->id);
 		if (!counter)
 			return -EINVAL;
 
-		evsel__set_count(counter, cpu_map_idx, thread, v[i].value, ena, run);
+		if (read_format & PERF_FORMAT_LOST)
+			lost = v->lost;
+
+		evsel__set_count(counter, cpu_map_idx, thread, v->value, ena, run, lost);
 	}
 
 	return 0;
@@ -2475,8 +2477,8 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
 			if (data->read.group.nr > max_group_nr)
 				return -EFAULT;
-			sz = data->read.group.nr *
-			     sizeof(struct sample_read_value);
+
+			sz = data->read.group.nr * sample_read_value_size(read_format);
 			OVERFLOW_CHECK(array, sz, max_size);
 			data->read.group.values =
 					(struct sample_read_value *)array;
@@ -2485,6 +2487,12 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			OVERFLOW_CHECK_u64(array);
 			data->read.one.id = *array;
 			array++;
+
+			if (read_format & PERF_FORMAT_LOST) {
+				OVERFLOW_CHECK_u64(array);
+				data->read.one.lost = *array;
+				array++;
+			}
 		}
 	}
 
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 9ef2406e0ede..1f2040f36d4e 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -642,15 +642,19 @@ static PyObject *python_process_brstacksym(struct perf_sample *sample,
 	return pylist;
 }
 
-static PyObject *get_sample_value_as_tuple(struct sample_read_value *value)
+static PyObject *get_sample_value_as_tuple(struct sample_read_value *value,
+					   u64 read_format)
 {
 	PyObject *t;
 
-	t = PyTuple_New(2);
+	t = PyTuple_New(3);
 	if (!t)
 		Py_FatalError("couldn't create Python tuple");
 	PyTuple_SetItem(t, 0, PyLong_FromUnsignedLongLong(value->id));
 	PyTuple_SetItem(t, 1, PyLong_FromUnsignedLongLong(value->value));
+	if (read_format & PERF_FORMAT_LOST)
+		PyTuple_SetItem(t, 2, PyLong_FromUnsignedLongLong(value->lost));
+
 	return t;
 }
 
@@ -681,12 +685,17 @@ static void set_sample_read_in_dict(PyObject *dict_sample,
 		Py_FatalError("couldn't create Python list");
 
 	if (read_format & PERF_FORMAT_GROUP) {
-		for (i = 0; i < sample->read.group.nr; i++) {
-			PyObject *t = get_sample_value_as_tuple(&sample->read.group.values[i]);
+		struct sample_read_value *v = sample->read.group.values;
+
+		i = 0;
+		sample_read_group__for_each(v, sample->read.group.nr, read_format) {
+			PyObject *t = get_sample_value_as_tuple(v, read_format);
 			PyList_SET_ITEM(values, i, t);
+			i++;
 		}
 	} else {
-		PyObject *t = get_sample_value_as_tuple(&sample->read.one);
+		PyObject *t = get_sample_value_as_tuple(&sample->read.one,
+							read_format);
 		PyList_SET_ITEM(values, 0, t);
 	}
 	pydict_set_item_string_decref(dict_sample, "values", values);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 98e16659a149..40a907d95639 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1283,21 +1283,25 @@ static void sample_read__printf(struct perf_sample *sample, u64 read_format)
 		       sample->read.time_running);
 
 	if (read_format & PERF_FORMAT_GROUP) {
-		u64 i;
+		struct sample_read_value *value = sample->read.group.values;
 
 		printf(".... group nr %" PRIu64 "\n", sample->read.group.nr);
 
-		for (i = 0; i < sample->read.group.nr; i++) {
-			struct sample_read_value *value;
-
-			value = &sample->read.group.values[i];
+		sample_read_group__for_each(value, sample->read.group.nr, read_format) {
 			printf("..... id %016" PRIx64
-			       ", value %016" PRIx64 "\n",
+			       ", value %016" PRIx64,
 			       value->id, value->value);
+			if (read_format & PERF_FORMAT_LOST)
+				printf(", lost %" PRIu64, value->lost);
+			printf("\n");
 		}
-	} else
-		printf("..... id %016" PRIx64 ", value %016" PRIx64 "\n",
+	} else {
+		printf("..... id %016" PRIx64 ", value %016" PRIx64,
 			sample->read.one.id, sample->read.one.value);
+		if (read_format & PERF_FORMAT_LOST)
+			printf(", lost %" PRIu64, sample->read.one.lost);
+		printf("\n");
+	}
 }
 
 static void dump_event(struct evlist *evlist, union perf_event *event,
@@ -1411,6 +1415,9 @@ static void dump_read(struct evsel *evsel, union perf_event *event)
 
 	if (read_format & PERF_FORMAT_ID)
 		printf("... id           : %" PRI_lu64 "\n", read_event->id);
+
+	if (read_format & PERF_FORMAT_LOST)
+		printf("... lost         : %" PRI_lu64 "\n", read_event->lost);
 }
 
 static struct machine *machines__find_for_cpumode(struct machines *machines,
@@ -1479,14 +1486,14 @@ static int deliver_sample_group(struct evlist *evlist,
 				struct perf_tool *tool,
 				union  perf_event *event,
 				struct perf_sample *sample,
-				struct machine *machine)
+				struct machine *machine,
+				u64 read_format)
 {
 	int ret = -EINVAL;
-	u64 i;
+	struct sample_read_value *v = sample->read.group.values;
 
-	for (i = 0; i < sample->read.group.nr; i++) {
-		ret = deliver_sample_value(evlist, tool, event, sample,
-					   &sample->read.group.values[i],
+	sample_read_group__for_each(v, sample->read.group.nr, read_format) {
+		ret = deliver_sample_value(evlist, tool, event, sample, v,
 					   machine);
 		if (ret)
 			break;
@@ -1510,7 +1517,7 @@ static int evlist__deliver_sample(struct evlist *evlist, struct perf_tool *tool,
 	/* For PERF_SAMPLE_READ we have either single or group mode. */
 	if (read_format & PERF_FORMAT_GROUP)
 		return deliver_sample_group(evlist, tool, event, sample,
-					    machine);
+					    machine, read_format);
 	else
 		return deliver_sample_value(evlist, tool, event, sample,
 					    &sample->read.one, machine);
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 2ae59c03ae77..24df0d9755e4 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1432,11 +1432,12 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 			result += sizeof(u64);
 		/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
 		if (read_format & PERF_FORMAT_GROUP) {
-			sz = sample->read.group.nr *
-			     sizeof(struct sample_read_value);
-			result += sz;
+			sz = sample_read_value_size(read_format);
+			result += sz * sample->read.group.nr;
 		} else {
 			result += sizeof(u64);
+			if (read_format & PERF_FORMAT_LOST)
+				result += sizeof(u64);
 		}
 	}
 
@@ -1521,6 +1522,20 @@ void __weak arch_perf_synthesize_sample_weight(const struct perf_sample *data,
 	*array = data->weight;
 }
 
+static __u64 *copy_read_group_values(__u64 *array, __u64 read_format,
+				     const struct perf_sample *sample)
+{
+	size_t sz = sample_read_value_size(read_format);
+	struct sample_read_value *v = sample->read.group.values;
+
+	sample_read_group__for_each(v, sample->read.group.nr, read_format) {
+		/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
+		memcpy(array, v, sz);
+		array = (void *)array + sz;
+	}
+	return array;
+}
+
 int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format,
 				  const struct perf_sample *sample)
 {
@@ -1602,13 +1617,16 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 
 		/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
 		if (read_format & PERF_FORMAT_GROUP) {
-			sz = sample->read.group.nr *
-			     sizeof(struct sample_read_value);
-			memcpy(array, sample->read.group.values, sz);
-			array = (void *)array + sz;
+			array = copy_read_group_values(array, read_format,
+						       sample);
 		} else {
 			*array = sample->read.one.id;
 			array++;
+
+			if (read_format & PERF_FORMAT_LOST) {
+				*array = sample->read.one.lost;
+				array++;
+			}
 		}
 	}
 
-- 
2.37.1.595.g718a3a8f04-goog

