Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2B35AF824
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 00:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiIFWzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 18:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiIFWyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 18:54:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2BB237E4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 15:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEFF2B81AD4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 22:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3B3C43147;
        Tue,  6 Sep 2022 22:54:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oVhTd-00C9wn-33;
        Tue, 06 Sep 2022 18:55:29 -0400
Message-ID: <20220906225529.781407172@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 06 Sep 2022 18:53:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v2 4/4] tracing/filter: Call filter predicate functions directly via a switch
 statement
References: <20220906225313.361552496@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Due to retpolines, indirect calls are much more expensive than direct
calls. The filters have a select set of functions it uses for the
predicates. Instead of using function pointers to call them, create a
filter_pred_fn_call() function that uses a switch statement to call the
predicate functions directly. This gives almost a 10% speedup to the
filter logic.

Using the histogram benchmark:

Before:

 # event histogram
 #
 # trigger info: hist:keys=delta:vals=hitcount:sort=delta:size=2048 if delta > 0 [active]
 #

{ delta:        113 } hitcount:        272
{ delta:        114 } hitcount:        840
{ delta:        118 } hitcount:        344
{ delta:        119 } hitcount:      25428
{ delta:        120 } hitcount:     350590
{ delta:        121 } hitcount:    1892484
{ delta:        122 } hitcount:    6205004
{ delta:        123 } hitcount:   11583521
{ delta:        124 } hitcount:   37590979
{ delta:        125 } hitcount:  108308504
{ delta:        126 } hitcount:  131672461
{ delta:        127 } hitcount:   88700598
{ delta:        128 } hitcount:   65939870
{ delta:        129 } hitcount:   45055004
{ delta:        130 } hitcount:   33174464
{ delta:        131 } hitcount:   31813493
{ delta:        132 } hitcount:   29011676
{ delta:        133 } hitcount:   22798782
{ delta:        134 } hitcount:   22072486
{ delta:        135 } hitcount:   17034113
{ delta:        136 } hitcount:    8982490
{ delta:        137 } hitcount:    2865908
{ delta:        138 } hitcount:     980382
{ delta:        139 } hitcount:    1651944
{ delta:        140 } hitcount:    4112073
{ delta:        141 } hitcount:    3963269
{ delta:        142 } hitcount:    1712508
{ delta:        143 } hitcount:     575941

After:

 # event histogram
 #
 # trigger info: hist:keys=delta:vals=hitcount:sort=delta:size=2048 if delta > 0 [active]
 #

{ delta:        103 } hitcount:         60
{ delta:        104 } hitcount:      16966
{ delta:        105 } hitcount:     396625
{ delta:        106 } hitcount:    3223400
{ delta:        107 } hitcount:   12053754
{ delta:        108 } hitcount:   20241711
{ delta:        109 } hitcount:   14850200
{ delta:        110 } hitcount:    4946599
{ delta:        111 } hitcount:    3479315
{ delta:        112 } hitcount:   18698299
{ delta:        113 } hitcount:   62388733
{ delta:        114 } hitcount:   95803834
{ delta:        115 } hitcount:   58278130
{ delta:        116 } hitcount:   15364800
{ delta:        117 } hitcount:    5586866
{ delta:        118 } hitcount:    2346880
{ delta:        119 } hitcount:    1131091
{ delta:        120 } hitcount:     620896
{ delta:        121 } hitcount:     236652
{ delta:        122 } hitcount:     105957
{ delta:        123 } hitcount:     119107
{ delta:        124 } hitcount:      54494
{ delta:        125 } hitcount:      63856
{ delta:        126 } hitcount:      64454
{ delta:        127 } hitcount:      34818
{ delta:        128 } hitcount:      41446
{ delta:        129 } hitcount:      51242
{ delta:        130 } hitcount:      28361
{ delta:        131 } hitcount:      23926

The peak before was 126ns per event, after the peak is 114ns, and the
fastest time went from 113ns to 103ns.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 230 ++++++++++++++++++++---------
 1 file changed, 157 insertions(+), 73 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c49c689ce4ad..96acc2b71ac7 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -43,10 +43,33 @@ enum filter_op_ids { OPS };
 
 static const char * ops[] = { OPS };
 
-typedef int (*filter_pred_fn_t) (struct filter_pred *pred, void *event);
+enum filter_pred_fn {
+	FILTER_PRED_FN_NOP,
+	FILTER_PRED_FN_64,
+	FILTER_PRED_FN_S64,
+	FILTER_PRED_FN_U64,
+	FILTER_PRED_FN_32,
+	FILTER_PRED_FN_S32,
+	FILTER_PRED_FN_U32,
+	FILTER_PRED_FN_16,
+	FILTER_PRED_FN_S16,
+	FILTER_PRED_FN_U16,
+	FILTER_PRED_FN_8,
+	FILTER_PRED_FN_S8,
+	FILTER_PRED_FN_U8,
+	FILTER_PRED_FN_COMM,
+	FILTER_PRED_FN_STRING,
+	FILTER_PRED_FN_STRLOC,
+	FILTER_PRED_FN_STRRELLOC,
+	FILTER_PRED_FN_PCHAR_USER,
+	FILTER_PRED_FN_PCHAR,
+	FILTER_PRED_FN_CPU,
+	FILTER_PRED_FN_,
+	FILTER_PRED_TEST_VISITED,
+};
 
 struct filter_pred {
-	filter_pred_fn_t 	fn;
+	enum filter_pred_fn 	fn_num;
 	u64 			val;
 	struct regex		regex;
 	unsigned short		*ops;
@@ -603,44 +626,48 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 	return ERR_PTR(ret);
 }
 
+enum pred_cmp_types {
+	PRED_CMP_TYPE_NOP,
+	PRED_CMP_TYPE_LT,
+	PRED_CMP_TYPE_LE,
+	PRED_CMP_TYPE_GT,
+	PRED_CMP_TYPE_GE,
+	PRED_CMP_TYPE_BAND,
+};
+
 #define DEFINE_COMPARISON_PRED(type)					\
-static int filter_pred_LT_##type(struct filter_pred *pred, void *event)	\
-{									\
-	type *addr = (type *)(event + pred->offset);			\
-	type val = (type)pred->val;					\
-	return *addr < val;						\
-}									\
-static int filter_pred_LE_##type(struct filter_pred *pred, void *event)	\
+static int filter_pred_##type(struct filter_pred *pred, void *event)	\
 {									\
-	type *addr = (type *)(event + pred->offset);			\
-	type val = (type)pred->val;					\
-	return *addr <= val;						\
-}									\
-static int filter_pred_GT_##type(struct filter_pred *pred, void *event)	\
-{									\
-	type *addr = (type *)(event + pred->offset);			\
-	type val = (type)pred->val;					\
-	return *addr > val;					\
-}									\
-static int filter_pred_GE_##type(struct filter_pred *pred, void *event)	\
-{									\
-	type *addr = (type *)(event + pred->offset);			\
-	type val = (type)pred->val;					\
-	return *addr >= val;						\
-}									\
-static int filter_pred_BAND_##type(struct filter_pred *pred, void *event) \
-{									\
-	type *addr = (type *)(event + pred->offset);			\
-	type val = (type)pred->val;					\
-	return !!(*addr & val);						\
-}									\
-static const filter_pred_fn_t pred_funcs_##type[] = {			\
-	filter_pred_LE_##type,						\
-	filter_pred_LT_##type,						\
-	filter_pred_GE_##type,						\
-	filter_pred_GT_##type,						\
-	filter_pred_BAND_##type,					\
-};
+	switch (pred->op) {						\
+	case OP_LT: {							\
+		type *addr = (type *)(event + pred->offset);		\
+		type val = (type)pred->val;				\
+		return *addr < val;					\
+	}								\
+	case OP_LE: {					\
+		type *addr = (type *)(event + pred->offset);		\
+		type val = (type)pred->val;				\
+		return *addr <= val;					\
+	}								\
+	case OP_GT: {					\
+		type *addr = (type *)(event + pred->offset);		\
+		type val = (type)pred->val;				\
+		return *addr > val;					\
+	}								\
+	case OP_GE: {					\
+		type *addr = (type *)(event + pred->offset);		\
+		type val = (type)pred->val;				\
+		return *addr >= val;					\
+	}								\
+	case OP_BAND: {					\
+		type *addr = (type *)(event + pred->offset);		\
+		type val = (type)pred->val;				\
+		return !!(*addr & val);					\
+	}								\
+	default:							\
+		return 0;						\
+	}								\
+}
 
 #define DEFINE_EQUALITY_PRED(size)					\
 static int filter_pred_##size(struct filter_pred *pred, void *event)	\
@@ -849,11 +876,6 @@ static int filter_pred_comm(struct filter_pred *pred, void *event)
 	return cmp ^ pred->not;
 }
 
-static int filter_pred_none(struct filter_pred *pred, void *event)
-{
-	return 0;
-}
-
 /*
  * regex_match_foo - Basic regex callbacks
  *
@@ -999,6 +1021,19 @@ static void filter_build_regex(struct filter_pred *pred)
 	}
 }
 
+
+#ifdef CONFIG_FTRACE_STARTUP_TEST
+static int test_pred_visited_fn(struct filter_pred *pred, void *event);
+#else
+static int test_pred_visited_fn(struct filter_pred *pred, void *event)
+{
+	return 0;
+}
+#endif
+
+
+static int filter_pred_fn_call(struct filter_pred *pred, void *event);
+
 /* return 1 if event matches, 0 otherwise (discard) */
 int filter_match_preds(struct event_filter *filter, void *rec)
 {
@@ -1016,7 +1051,7 @@ int filter_match_preds(struct event_filter *filter, void *rec)
 
 	for (i = 0; prog[i].pred; i++) {
 		struct filter_pred *pred = prog[i].pred;
-		int match = pred->fn(pred, rec);
+		int match = filter_pred_fn_call(pred, rec);
 		if (match == prog[i].when_to_branch)
 			i = prog[i].target;
 	}
@@ -1202,10 +1237,10 @@ int filter_assign_type(const char *type)
 	return FILTER_OTHER;
 }
 
-static filter_pred_fn_t select_comparison_fn(enum filter_op_ids op,
-					    int field_size, int field_is_signed)
+static enum filter_pred_fn select_comparison_fn(enum filter_op_ids op,
+						int field_size, int field_is_signed)
 {
-	filter_pred_fn_t fn = NULL;
+	enum filter_pred_fn fn = FILTER_PRED_FN_NOP;
 	int pred_func_index = -1;
 
 	switch (op) {
@@ -1214,50 +1249,99 @@ static filter_pred_fn_t select_comparison_fn(enum filter_op_ids op,
 		break;
 	default:
 		if (WARN_ON_ONCE(op < PRED_FUNC_START))
-			return NULL;
+			return fn;
 		pred_func_index = op - PRED_FUNC_START;
 		if (WARN_ON_ONCE(pred_func_index > PRED_FUNC_MAX))
-			return NULL;
+			return fn;
 	}
 
 	switch (field_size) {
 	case 8:
 		if (pred_func_index < 0)
-			fn = filter_pred_64;
+			fn = FILTER_PRED_FN_64;
 		else if (field_is_signed)
-			fn = pred_funcs_s64[pred_func_index];
+			fn = FILTER_PRED_FN_S64;
 		else
-			fn = pred_funcs_u64[pred_func_index];
+			fn = FILTER_PRED_FN_U64;
 		break;
 	case 4:
 		if (pred_func_index < 0)
-			fn = filter_pred_32;
+			fn = FILTER_PRED_FN_32;
 		else if (field_is_signed)
-			fn = pred_funcs_s32[pred_func_index];
+			fn = FILTER_PRED_FN_S32;
 		else
-			fn = pred_funcs_u32[pred_func_index];
+			fn = FILTER_PRED_FN_U32;
 		break;
 	case 2:
 		if (pred_func_index < 0)
-			fn = filter_pred_16;
+			fn = FILTER_PRED_FN_16;
 		else if (field_is_signed)
-			fn = pred_funcs_s16[pred_func_index];
+			fn = FILTER_PRED_FN_S16;
 		else
-			fn = pred_funcs_u16[pred_func_index];
+			fn = FILTER_PRED_FN_U16;
 		break;
 	case 1:
 		if (pred_func_index < 0)
-			fn = filter_pred_8;
+			fn = FILTER_PRED_FN_8;
 		else if (field_is_signed)
-			fn = pred_funcs_s8[pred_func_index];
+			fn = FILTER_PRED_FN_S8;
 		else
-			fn = pred_funcs_u8[pred_func_index];
+			fn = FILTER_PRED_FN_U8;
 		break;
 	}
 
 	return fn;
 }
 
+
+static int filter_pred_fn_call(struct filter_pred *pred, void *event)
+{
+	switch (pred->fn_num) {
+	case FILTER_PRED_FN_64:
+		return filter_pred_64(pred, event);
+	case FILTER_PRED_FN_S64:
+		return filter_pred_s64(pred, event);
+	case FILTER_PRED_FN_U64:
+		return filter_pred_u64(pred, event);
+	case FILTER_PRED_FN_32:
+		return filter_pred_32(pred, event);
+	case FILTER_PRED_FN_S32:
+		return filter_pred_s32(pred, event);
+	case FILTER_PRED_FN_U32:
+		return filter_pred_u32(pred, event);
+	case FILTER_PRED_FN_16:
+		return filter_pred_16(pred, event);
+	case FILTER_PRED_FN_S16:
+		return filter_pred_s16(pred, event);
+	case FILTER_PRED_FN_U16:
+		return filter_pred_u16(pred, event);
+	case FILTER_PRED_FN_8:
+		return filter_pred_8(pred, event);
+	case FILTER_PRED_FN_S8:
+		return filter_pred_s8(pred, event);
+	case FILTER_PRED_FN_U8:
+		return filter_pred_u8(pred, event);
+	case FILTER_PRED_FN_COMM:
+		return filter_pred_comm(pred, event);
+	case FILTER_PRED_FN_STRING:
+		return filter_pred_string(pred, event);
+	case FILTER_PRED_FN_STRLOC:
+		return filter_pred_strloc(pred, event);
+	case FILTER_PRED_FN_STRRELLOC:
+		return filter_pred_strrelloc(pred, event);
+	case FILTER_PRED_FN_PCHAR_USER:
+		return filter_pred_pchar_user(pred, event);
+	case FILTER_PRED_FN_PCHAR:
+		return filter_pred_pchar(pred, event);
+	case FILTER_PRED_FN_CPU:
+		return filter_pred_cpu(pred, event);
+	case FILTER_PRED_TEST_VISITED:
+		return test_pred_visited_fn(pred, event);
+	default:
+		return 0;
+	}
+}
+
 /* Called when a predicate is encountered by predicate_parse() */
 static int parse_pred(const char *str, void *data,
 		      int pos, struct filter_parse_error *pe,
@@ -1351,7 +1435,7 @@ static int parse_pred(const char *str, void *data,
 			parse_error(pe, FILT_ERR_IP_FIELD_ONLY, pos + i);
 			goto err_free;
 		}
-		pred->fn = filter_pred_none;
+		pred->fn_num = FILTER_PRED_FN_NOP;
 
 		/*
 		 * Quotes are not required, but if they exist then we need
@@ -1429,16 +1513,16 @@ static int parse_pred(const char *str, void *data,
 		filter_build_regex(pred);
 
 		if (field->filter_type == FILTER_COMM) {
-			pred->fn = filter_pred_comm;
+			pred->fn_num = FILTER_PRED_FN_COMM;
 
 		} else if (field->filter_type == FILTER_STATIC_STRING) {
-			pred->fn = filter_pred_string;
+			pred->fn_num = FILTER_PRED_FN_STRING;
 			pred->regex.field_len = field->size;
 
 		} else if (field->filter_type == FILTER_DYN_STRING) {
-			pred->fn = filter_pred_strloc;
+			pred->fn_num = FILTER_PRED_FN_STRLOC;
 		} else if (field->filter_type == FILTER_RDYN_STRING)
-			pred->fn = filter_pred_strrelloc;
+			pred->fn_num = FILTER_PRED_FN_STRRELLOC;
 		else {
 
 			if (!ustring_per_cpu) {
@@ -1449,9 +1533,9 @@ static int parse_pred(const char *str, void *data,
 			}
 
 			if (ustring)
-				pred->fn = filter_pred_pchar_user;
+				pred->fn_num = FILTER_PRED_FN_PCHAR_USER;
 			else
-				pred->fn = filter_pred_pchar;
+				pred->fn_num = FILTER_PRED_FN_PCHAR;
 		}
 		/* go past the last quote */
 		i++;
@@ -1499,10 +1583,10 @@ static int parse_pred(const char *str, void *data,
 		pred->val = val;
 
 		if (field->filter_type == FILTER_CPU)
-			pred->fn = filter_pred_cpu;
+			pred->fn_num = FILTER_PRED_FN_CPU;
 		else {
-			pred->fn = select_comparison_fn(pred->op, field->size,
-							field->is_signed);
+			pred->fn_num = select_comparison_fn(pred->op, field->size,
+							    field->is_signed);
 			if (pred->op == OP_NE)
 				pred->not = 1;
 		}
@@ -2309,7 +2393,7 @@ static void update_pred_fn(struct event_filter *filter, char *fields)
 		struct filter_pred *pred = prog[i].pred;
 		struct ftrace_event_field *field = pred->field;
 
-		WARN_ON_ONCE(!pred->fn);
+		WARN_ON_ONCE(pred->fn_num == FILTER_PRED_FN_NOP);
 
 		if (!field) {
 			WARN_ONCE(1, "all leafs should have field defined %d", i);
@@ -2319,7 +2403,7 @@ static void update_pred_fn(struct event_filter *filter, char *fields)
 		if (!strchr(fields, *field->name))
 			continue;
 
-		pred->fn = test_pred_visited_fn;
+		pred->fn_num = FILTER_PRED_TEST_VISITED;
 	}
 }
 
-- 
2.35.1
