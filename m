Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D078593BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347533AbiHOUbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347109AbiHOUX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:23:29 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBE14BD01;
        Mon, 15 Aug 2022 12:02:48 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id z19so7153916plb.1;
        Mon, 15 Aug 2022 12:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=eGwWLAV+VmdnzL2DzlRl4cqZkvkUk0pyXNIXElL51oM=;
        b=J/lvfr3edKFmTE604ZrQ7c46BPEPDrQKT6POvbxYhQTGKf2baJhUBrNqQfEkBLsqdc
         TgJ7BiBQTb3owvJ6CiWD6ROAXyvRIurtJIQwkM2cuZWotTw2iDFP0FAiVLw7Tzr8NIG8
         pvnuQfBhV1H9PEy+8he0i7Zh/WPiwPTPdwrO69CT6ANnLKxY7SGWhXkk8wpv4jrI1xC/
         35Lr9JrCPzOYxOJtg6t5AILyWhQZYM4YN3F6QcTRKceC3R1saINrFc6xsvk0k3y5+klO
         scUx+HQquIZAhb91/vt6XvoU7WNvZ/xStfKf7SNPZe4Bn9yCBSDZAKoTTEEAcKSff9OU
         H9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=eGwWLAV+VmdnzL2DzlRl4cqZkvkUk0pyXNIXElL51oM=;
        b=fOYCsm5W42ChTZGkB9MYqMFI1FuYSFOpnfg64FOexc4Mbba37arQrT2aIozsGRnqdz
         7Vqr3vi1VOsr+9fAUUcAp887nDminOkOsj/4VbFWl385qBya4m9JKKAJrZ3rMcBWjVNT
         WSH0w6EiahhMyS3BRH0ppbQXnlSRyJIDibOfwUhrsopGQBUT/GF1ZQtid/6rBCOHN20x
         QQ8581086/VcexbrVzVL7vgbmGR7RI+RKG117ZuPTcVPDkk8nAdLZy9z7MyvspEA+45T
         Hfm91mA2wPjSzAvzUSqteZDAxSGd4sp0TW0ty0r5oubtbkvbkAka7RF5bvnp8WYcDvgR
         Fvtg==
X-Gm-Message-State: ACgBeo1iVMQt7QsbPSCWUvNXBiJYyywwNmZiNc/kUYuj8/HfYVBY29QQ
        4IIxDNhiPyCidGZ6QtFKCeo=
X-Google-Smtp-Source: AA6agR6FsoK6jpHF+J6IYoYqVk42xSZCvYEAqxFRv568MP0hdMRmGFRKiEerc48b+ygoz4rlYkImEw==
X-Received: by 2002:a17:902:b903:b0:170:9964:b47b with SMTP id bf3-20020a170902b90300b001709964b47bmr18023909plb.83.1660590167848;
        Mon, 15 Aug 2022 12:02:47 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:df3e:22e0:b905:822b])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902a3cd00b0016a4db13429sm7266926plb.192.2022.08.15.12.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 12:02:46 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 4/4] perf tools: Support reading PERF_FORMAT_LOST
Date:   Mon, 15 Aug 2022 12:01:06 -0700
Message-Id: <20220815190106.1293082-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220815190106.1293082-1-namhyung@kernel.org>
References: <20220815190106.1293082-1-namhyung@kernel.org>
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

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/sample-parsing.c             | 14 +++++---
 tools/perf/util/event.h                       | 18 +++++++++-
 tools/perf/util/evsel.c                       | 33 +++++++++++++-----
 .../scripting-engines/trace-event-python.c    | 16 ++++++---
 tools/perf/util/session.c                     | 32 +++++++++++------
 tools/perf/util/synthetic-events.c            | 34 +++++++++++++++----
 6 files changed, 112 insertions(+), 35 deletions(-)

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
index a7b0931d5137..7753368d70d6 100644
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
@@ -80,6 +81,21 @@ struct sample_read {
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
 struct ip_callchain {
 	u64 nr;
 	u64 ips[];
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4852089e1d79..781367ccdb84 100644
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
+	u64 nr, ena = 0, run = 0, lost = 0, i;
 
 	nr = *data++;
 
@@ -1573,16 +1574,25 @@ static int evsel__process_group_data(struct evsel *leader, int cpu_map_idx, int
 
 	v = (struct sample_read_value *) data;
 
-	evsel__set_count(leader, cpu_map_idx, thread, v[0].value, ena, run);
+	if (read_format & PERF_FORMAT_LOST)
+		lost = v->lost;
+
+	evsel__set_count(leader, cpu_map_idx, thread, v[0].value, ena, run, lost);
+
+	v = next_sample_read_value(v, read_format);
 
 	for (i = 1; i < nr; i++) {
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
+		v = next_sample_read_value(v, read_format);
 	}
 
 	return 0;
@@ -2475,16 +2485,21 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
 			if (data->read.group.nr > max_group_nr)
 				return -EFAULT;
-			sz = data->read.group.nr *
-			     sizeof(struct sample_read_value);
+
+			sz = data->read.group.nr * sample_read_value_size(read_format);
 			OVERFLOW_CHECK(array, sz, max_size);
-			data->read.group.values =
-					(struct sample_read_value *)array;
+			data->read.group.values = (void *)array;
 			array = (void *)array + sz;
 		} else {
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
index 9ef2406e0ede..7e15e64f311b 100644
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
 
@@ -681,12 +685,16 @@ static void set_sample_read_in_dict(PyObject *dict_sample,
 		Py_FatalError("couldn't create Python list");
 
 	if (read_format & PERF_FORMAT_GROUP) {
+		struct sample_read_value *v = sample->read.group.values;
+
 		for (i = 0; i < sample->read.group.nr; i++) {
-			PyObject *t = get_sample_value_as_tuple(&sample->read.group.values[i]);
+			PyObject *t = get_sample_value_as_tuple(v, read_format);
 			PyList_SET_ITEM(values, i, t);
+			v = next_sample_read_value(v, read_format);
 		}
 	} else {
-		PyObject *t = get_sample_value_as_tuple(&sample->read.one);
+		PyObject *t = get_sample_value_as_tuple(&sample->read.one,
+							read_format);
 		PyList_SET_ITEM(values, 0, t);
 	}
 	pydict_set_item_string_decref(dict_sample, "values", values);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 98e16659a149..dd818764bd4d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1284,20 +1284,26 @@ static void sample_read__printf(struct perf_sample *sample, u64 read_format)
 
 	if (read_format & PERF_FORMAT_GROUP) {
 		u64 i;
+		struct sample_read_value *value = sample->read.group.values;
 
 		printf(".... group nr %" PRIu64 "\n", sample->read.group.nr);
 
 		for (i = 0; i < sample->read.group.nr; i++) {
-			struct sample_read_value *value;
-
-			value = &sample->read.group.values[i];
 			printf("..... id %016" PRIx64
-			       ", value %016" PRIx64 "\n",
+			       ", value %016" PRIx64,
 			       value->id, value->value);
+			if (read_format & PERF_FORMAT_LOST)
+				printf(", lost %" PRIu64, value->lost);
+			printf("\n");
+			value = next_sample_read_value(value, read_format);
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
@@ -1411,6 +1417,9 @@ static void dump_read(struct evsel *evsel, union perf_event *event)
 
 	if (read_format & PERF_FORMAT_ID)
 		printf("... id           : %" PRI_lu64 "\n", read_event->id);
+
+	if (read_format & PERF_FORMAT_LOST)
+		printf("... lost         : %" PRI_lu64 "\n", read_event->lost);
 }
 
 static struct machine *machines__find_for_cpumode(struct machines *machines,
@@ -1479,17 +1488,20 @@ static int deliver_sample_group(struct evlist *evlist,
 				struct perf_tool *tool,
 				union  perf_event *event,
 				struct perf_sample *sample,
-				struct machine *machine)
+				struct machine *machine,
+				u64 read_format)
 {
 	int ret = -EINVAL;
 	u64 i;
+	struct sample_read_value *v = sample->read.group.values;
 
 	for (i = 0; i < sample->read.group.nr; i++) {
-		ret = deliver_sample_value(evlist, tool, event, sample,
-					   &sample->read.group.values[i],
+		ret = deliver_sample_value(evlist, tool, event, sample, v,
 					   machine);
 		if (ret)
 			break;
+
+		v = next_sample_read_value(v, read_format);
 	}
 
 	return ret;
@@ -1510,7 +1522,7 @@ static int evlist__deliver_sample(struct evlist *evlist, struct perf_tool *tool,
 	/* For PERF_SAMPLE_READ we have either single or group mode. */
 	if (read_format & PERF_FORMAT_GROUP)
 		return deliver_sample_group(evlist, tool, event, sample,
-					    machine);
+					    machine, read_format);
 	else
 		return deliver_sample_value(evlist, tool, event, sample,
 					    &sample->read.one, machine);
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 2ae59c03ae77..9b8dc7633a02 100644
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
 
@@ -1521,6 +1522,22 @@ void __weak arch_perf_synthesize_sample_weight(const struct perf_sample *data,
 	*array = data->weight;
 }
 
+static __u64 *copy_read_group_values(__u64 *array, __u64 read_format,
+				     const struct perf_sample *sample)
+{
+	size_t i, sz;
+	void *data = sample->read.group.values;
+
+	sz = sample_read_value_size(read_format);
+	for (i = 0; i < sample->read.group.nr; i++) {
+		memcpy(array, data, sz);
+
+		data += sz;
+		array = (void *)array + sz;
+	}
+	return array;
+}
+
 int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format,
 				  const struct perf_sample *sample)
 {
@@ -1602,13 +1619,16 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 
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

