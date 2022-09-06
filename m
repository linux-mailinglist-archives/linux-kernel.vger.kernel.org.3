Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43805AF823
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 00:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiIFWzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 18:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiIFWyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 18:54:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F5921E24
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 15:54:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD9876171F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 22:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9978C43142;
        Tue,  6 Sep 2022 22:54:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oVhTd-00C9vh-1r;
        Tue, 06 Sep 2022 18:55:29 -0400
Message-ID: <20220906225529.411545333@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 06 Sep 2022 18:53:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v2 2/4] tracing/hist: Call hist functions directly via a switch statement
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
calls. The histograms have a select set of functions it uses for the
histograms, instead of using function pointers to call them, create a
hist_fn_call() function that uses a switch statement to call the histogram
functions directly. This gives a 13% speedup to the histogram logic.

Using the histogram benchmark:

Before:

 # event histogram
 #
 # trigger info: hist:keys=delta:vals=hitcount:sort=delta:size=2048 if delta > 0 [active]
 #

{ delta:        129 } hitcount:       2213
{ delta:        130 } hitcount:     285965
{ delta:        131 } hitcount:    1146545
{ delta:        132 } hitcount:    5185432
{ delta:        133 } hitcount:   19896215
{ delta:        134 } hitcount:   53118616
{ delta:        135 } hitcount:   83816709
{ delta:        136 } hitcount:   68329562
{ delta:        137 } hitcount:   41859349
{ delta:        138 } hitcount:   46257797
{ delta:        139 } hitcount:   54400831
{ delta:        140 } hitcount:   72875007
{ delta:        141 } hitcount:   76193272
{ delta:        142 } hitcount:   49504263
{ delta:        143 } hitcount:   38821072
{ delta:        144 } hitcount:   47702679
{ delta:        145 } hitcount:   41357297
{ delta:        146 } hitcount:   22058238
{ delta:        147 } hitcount:    9720002
{ delta:        148 } hitcount:    3193542
{ delta:        149 } hitcount:     927030
{ delta:        150 } hitcount:     850772
{ delta:        151 } hitcount:    1477380
{ delta:        152 } hitcount:    2687977
{ delta:        153 } hitcount:    2865985
{ delta:        154 } hitcount:    1977492
{ delta:        155 } hitcount:    2475607
{ delta:        156 } hitcount:    3403612

After:

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
{ delta:        144 } hitcount:     351427
{ delta:        145 } hitcount:     218077
{ delta:        146 } hitcount:     167297
{ delta:        147 } hitcount:     146198
{ delta:        148 } hitcount:     116122
{ delta:        149 } hitcount:      58993
{ delta:        150 } hitcount:      40228

The delta above is in nanoseconds. It brings the fastest time down from
129ns to 113ns, and the peak from 141ns to 126ns.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 246 +++++++++++++++++++++----------
 1 file changed, 169 insertions(+), 77 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index fdf784620c28..48465f7e97b4 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -104,6 +104,38 @@ enum field_op_id {
 	FIELD_OP_MULT,
 };
 
+enum hist_field_fn {
+	HIST_FIELD_FN_NOP,
+	HIST_FIELD_FN_VAR_REF,
+	HIST_FIELD_FN_COUNTER,
+	HIST_FIELD_FN_CONST,
+	HIST_FIELD_FN_LOG2,
+	HIST_FIELD_FN_BUCKET,
+	HIST_FIELD_FN_TIMESTAMP,
+	HIST_FIELD_FN_CPU,
+	HIST_FIELD_FN_STRING,
+	HIST_FIELD_FN_DYNSTRING,
+	HIST_FIELD_FN_RELDYNSTRING,
+	HIST_FIELD_FN_PSTRING,
+	HIST_FIELD_FN_S64,
+	HIST_FIELD_FN_U64,
+	HIST_FIELD_FN_S32,
+	HIST_FIELD_FN_U32,
+	HIST_FIELD_FN_S16,
+	HIST_FIELD_FN_U16,
+	HIST_FIELD_FN_S8,
+	HIST_FIELD_FN_U8,
+	HIST_FIELD_FN_UMINUS,
+	HIST_FIELD_FN_MINUS,
+	HIST_FIELD_FN_PLUS,
+	HIST_FIELD_FN_DIV,
+	HIST_FIELD_FN_MULT,
+	HIST_FIELD_FN_DIV_POWER2,
+	HIST_FIELD_FN_DIV_NOT_POWER2,
+	HIST_FIELD_FN_DIV_MULT_SHIFT,
+	HIST_FIELD_FN_EXECNAME,
+};
+
 /*
  * A hist_var (histogram variable) contains variable information for
  * hist_fields having the HIST_FIELD_FL_VAR or HIST_FIELD_FL_VAR_REF
@@ -123,15 +155,15 @@ struct hist_var {
 struct hist_field {
 	struct ftrace_event_field	*field;
 	unsigned long			flags;
-	hist_field_fn_t			fn;
-	unsigned int			ref;
-	unsigned int			size;
-	unsigned int			offset;
-	unsigned int                    is_signed;
 	unsigned long			buckets;
 	const char			*type;
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 	struct hist_trigger_data	*hist_data;
+	enum hist_field_fn		fn_num;
+	unsigned int			ref;
+	unsigned int			size;
+	unsigned int			offset;
+	unsigned int                    is_signed;
 
 	/*
 	 * Variable fields contain variable-specific info in var.
@@ -166,14 +198,11 @@ struct hist_field {
 	u64				div_multiplier;
 };
 
-static u64 hist_field_none(struct hist_field *field,
-			   struct tracing_map_elt *elt,
-			   struct trace_buffer *buffer,
-			   struct ring_buffer_event *rbe,
-			   void *event)
-{
-	return 0;
-}
+static u64 hist_fn_call(struct hist_field *hist_field,
+			struct tracing_map_elt *elt,
+			struct trace_buffer *buffer,
+			struct ring_buffer_event *rbe,
+			void *event);
 
 static u64 hist_field_const(struct hist_field *field,
 			   struct tracing_map_elt *elt,
@@ -250,7 +279,7 @@ static u64 hist_field_log2(struct hist_field *hist_field,
 {
 	struct hist_field *operand = hist_field->operands[0];
 
-	u64 val = operand->fn(operand, elt, buffer, rbe, event);
+	u64 val = hist_fn_call(operand, elt, buffer, rbe, event);
 
 	return (u64) ilog2(roundup_pow_of_two(val));
 }
@@ -264,7 +293,7 @@ static u64 hist_field_bucket(struct hist_field *hist_field,
 	struct hist_field *operand = hist_field->operands[0];
 	unsigned long buckets = hist_field->buckets;
 
-	u64 val = operand->fn(operand, elt, buffer, rbe, event);
+	u64 val = hist_fn_call(operand, elt, buffer, rbe, event);
 
 	if (WARN_ON_ONCE(!buckets))
 		return val;
@@ -285,8 +314,8 @@ static u64 hist_field_plus(struct hist_field *hist_field,
 	struct hist_field *operand1 = hist_field->operands[0];
 	struct hist_field *operand2 = hist_field->operands[1];
 
-	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
-	u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
+	u64 val1 = hist_fn_call(operand1, elt, buffer, rbe, event);
+	u64 val2 = hist_fn_call(operand2, elt, buffer, rbe, event);
 
 	return val1 + val2;
 }
@@ -300,8 +329,8 @@ static u64 hist_field_minus(struct hist_field *hist_field,
 	struct hist_field *operand1 = hist_field->operands[0];
 	struct hist_field *operand2 = hist_field->operands[1];
 
-	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
-	u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
+	u64 val1 = hist_fn_call(operand1, elt, buffer, rbe, event);
+	u64 val2 = hist_fn_call(operand2, elt, buffer, rbe, event);
 
 	return val1 - val2;
 }
@@ -315,8 +344,8 @@ static u64 hist_field_div(struct hist_field *hist_field,
 	struct hist_field *operand1 = hist_field->operands[0];
 	struct hist_field *operand2 = hist_field->operands[1];
 
-	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
-	u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
+	u64 val1 = hist_fn_call(operand1, elt, buffer, rbe, event);
+	u64 val2 = hist_fn_call(operand2, elt, buffer, rbe, event);
 
 	/* Return -1 for the undefined case */
 	if (!val2)
@@ -338,7 +367,7 @@ static u64 div_by_power_of_two(struct hist_field *hist_field,
 	struct hist_field *operand1 = hist_field->operands[0];
 	struct hist_field *operand2 = hist_field->operands[1];
 
-	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
+	u64 val1 = hist_fn_call(operand1, elt, buffer, rbe, event);
 
 	return val1 >> __ffs64(operand2->constant);
 }
@@ -352,7 +381,7 @@ static u64 div_by_not_power_of_two(struct hist_field *hist_field,
 	struct hist_field *operand1 = hist_field->operands[0];
 	struct hist_field *operand2 = hist_field->operands[1];
 
-	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
+	u64 val1 = hist_fn_call(operand1, elt, buffer, rbe, event);
 
 	return div64_u64(val1, operand2->constant);
 }
@@ -366,7 +395,7 @@ static u64 div_by_mult_and_shift(struct hist_field *hist_field,
 	struct hist_field *operand1 = hist_field->operands[0];
 	struct hist_field *operand2 = hist_field->operands[1];
 
-	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
+	u64 val1 = hist_fn_call(operand1, elt, buffer, rbe, event);
 
 	/*
 	 * If the divisor is a constant, do a multiplication and shift instead.
@@ -400,8 +429,8 @@ static u64 hist_field_mult(struct hist_field *hist_field,
 	struct hist_field *operand1 = hist_field->operands[0];
 	struct hist_field *operand2 = hist_field->operands[1];
 
-	u64 val1 = operand1->fn(operand1, elt, buffer, rbe, event);
-	u64 val2 = operand2->fn(operand2, elt, buffer, rbe, event);
+	u64 val1 = hist_fn_call(operand1, elt, buffer, rbe, event);
+	u64 val2 = hist_fn_call(operand2, elt, buffer, rbe, event);
 
 	return val1 * val2;
 }
@@ -414,7 +443,7 @@ static u64 hist_field_unary_minus(struct hist_field *hist_field,
 {
 	struct hist_field *operand = hist_field->operands[0];
 
-	s64 sval = (s64)operand->fn(operand, elt, buffer, rbe, event);
+	s64 sval = (s64)hist_fn_call(operand, elt, buffer, rbe, event);
 	u64 val = (u64)-sval;
 
 	return val;
@@ -657,19 +686,19 @@ struct snapshot_context {
  * Returns the specific division function to use if the divisor
  * is constant. This avoids extra branches when the trigger is hit.
  */
-static hist_field_fn_t hist_field_get_div_fn(struct hist_field *divisor)
+static enum hist_field_fn hist_field_get_div_fn(struct hist_field *divisor)
 {
 	u64 div = divisor->constant;
 
 	if (!(div & (div - 1)))
-		return div_by_power_of_two;
+		return HIST_FIELD_FN_DIV_POWER2;
 
 	/* If the divisor is too large, do a regular division */
 	if (div > (1 << HIST_DIV_SHIFT))
-		return div_by_not_power_of_two;
+		return HIST_FIELD_FN_DIV_NOT_POWER2;
 
 	divisor->div_multiplier = div64_u64((u64)(1 << HIST_DIV_SHIFT), div);
-	return div_by_mult_and_shift;
+	return HIST_FIELD_FN_DIV_MULT_SHIFT;
 }
 
 static void track_data_free(struct track_data *track_data)
@@ -1334,38 +1363,32 @@ static const char *hist_field_name(struct hist_field *field,
 	return field_name;
 }
 
-static hist_field_fn_t select_value_fn(int field_size, int field_is_signed)
+static enum hist_field_fn select_value_fn(int field_size, int field_is_signed)
 {
-	hist_field_fn_t fn = NULL;
-
 	switch (field_size) {
 	case 8:
 		if (field_is_signed)
-			fn = hist_field_s64;
+			return HIST_FIELD_FN_S64;
 		else
-			fn = hist_field_u64;
-		break;
+			return HIST_FIELD_FN_U64;
 	case 4:
 		if (field_is_signed)
-			fn = hist_field_s32;
+			return HIST_FIELD_FN_S32;
 		else
-			fn = hist_field_u32;
-		break;
+			return HIST_FIELD_FN_U32;
 	case 2:
 		if (field_is_signed)
-			fn = hist_field_s16;
+			return HIST_FIELD_FN_S16;
 		else
-			fn = hist_field_u16;
-		break;
+			return HIST_FIELD_FN_U16;
 	case 1:
 		if (field_is_signed)
-			fn = hist_field_s8;
+			return HIST_FIELD_FN_S8;
 		else
-			fn = hist_field_u8;
-		break;
+			return HIST_FIELD_FN_U8;
 	}
 
-	return fn;
+	return HIST_FIELD_FN_NOP;
 }
 
 static int parse_map_size(char *str)
@@ -1922,19 +1945,19 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		goto out; /* caller will populate */
 
 	if (flags & HIST_FIELD_FL_VAR_REF) {
-		hist_field->fn = hist_field_var_ref;
+		hist_field->fn_num = HIST_FIELD_FN_VAR_REF;
 		goto out;
 	}
 
 	if (flags & HIST_FIELD_FL_HITCOUNT) {
-		hist_field->fn = hist_field_counter;
+		hist_field->fn_num = HIST_FIELD_FN_COUNTER;
 		hist_field->size = sizeof(u64);
 		hist_field->type = "u64";
 		goto out;
 	}
 
 	if (flags & HIST_FIELD_FL_CONST) {
-		hist_field->fn = hist_field_const;
+		hist_field->fn_num = HIST_FIELD_FN_CONST;
 		hist_field->size = sizeof(u64);
 		hist_field->type = kstrdup("u64", GFP_KERNEL);
 		if (!hist_field->type)
@@ -1943,14 +1966,14 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	}
 
 	if (flags & HIST_FIELD_FL_STACKTRACE) {
-		hist_field->fn = hist_field_none;
+		hist_field->fn_num = HIST_FIELD_FN_NOP;
 		goto out;
 	}
 
 	if (flags & (HIST_FIELD_FL_LOG2 | HIST_FIELD_FL_BUCKET)) {
 		unsigned long fl = flags & ~(HIST_FIELD_FL_LOG2 | HIST_FIELD_FL_BUCKET);
-		hist_field->fn = flags & HIST_FIELD_FL_LOG2 ? hist_field_log2 :
-			hist_field_bucket;
+		hist_field->fn_num = flags & HIST_FIELD_FL_LOG2 ? HIST_FIELD_FN_LOG2 :
+			HIST_FIELD_FN_BUCKET;
 		hist_field->operands[0] = create_hist_field(hist_data, field, fl, NULL);
 		hist_field->size = hist_field->operands[0]->size;
 		hist_field->type = kstrdup_const(hist_field->operands[0]->type, GFP_KERNEL);
@@ -1960,14 +1983,14 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	}
 
 	if (flags & HIST_FIELD_FL_TIMESTAMP) {
-		hist_field->fn = hist_field_timestamp;
+		hist_field->fn_num = HIST_FIELD_FN_TIMESTAMP;
 		hist_field->size = sizeof(u64);
 		hist_field->type = "u64";
 		goto out;
 	}
 
 	if (flags & HIST_FIELD_FL_CPU) {
-		hist_field->fn = hist_field_cpu;
+		hist_field->fn_num = HIST_FIELD_FN_CPU;
 		hist_field->size = sizeof(int);
 		hist_field->type = "unsigned int";
 		goto out;
@@ -1987,14 +2010,14 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 			goto free;
 
 		if (field->filter_type == FILTER_STATIC_STRING) {
-			hist_field->fn = hist_field_string;
+			hist_field->fn_num = HIST_FIELD_FN_STRING;
 			hist_field->size = field->size;
 		} else if (field->filter_type == FILTER_DYN_STRING) {
-			hist_field->fn = hist_field_dynstring;
+			hist_field->fn_num = HIST_FIELD_FN_DYNSTRING;
 		} else if (field->filter_type == FILTER_RDYN_STRING)
-			hist_field->fn = hist_field_reldynstring;
+			hist_field->fn_num = HIST_FIELD_FN_RELDYNSTRING;
 		else
-			hist_field->fn = hist_field_pstring;
+			hist_field->fn_num = HIST_FIELD_FN_PSTRING;
 	} else {
 		hist_field->size = field->size;
 		hist_field->is_signed = field->is_signed;
@@ -2002,9 +2025,9 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		if (!hist_field->type)
 			goto free;
 
-		hist_field->fn = select_value_fn(field->size,
-						 field->is_signed);
-		if (!hist_field->fn) {
+		hist_field->fn_num = select_value_fn(field->size,
+						     field->is_signed);
+		if (hist_field->fn_num == HIST_FIELD_FN_NOP) {
 			destroy_hist_field(hist_field, 0);
 			return NULL;
 		}
@@ -2340,7 +2363,7 @@ static struct hist_field *create_alias(struct hist_trigger_data *hist_data,
 	if (!alias)
 		return NULL;
 
-	alias->fn = var_ref->fn;
+	alias->fn_num = var_ref->fn_num;
 	alias->operands[0] = var_ref;
 
 	if (init_var_ref(alias, var_ref, var_ref->system, var_ref->event_name)) {
@@ -2523,7 +2546,7 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 
 	expr->flags |= operand1->flags &
 		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
-	expr->fn = hist_field_unary_minus;
+	expr->fn_num = HIST_FIELD_FN_UMINUS;
 	expr->operands[0] = operand1;
 	expr->size = operand1->size;
 	expr->is_signed = operand1->is_signed;
@@ -2595,7 +2618,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	unsigned long operand_flags, operand2_flags;
 	int field_op, ret = -EINVAL;
 	char *sep, *operand1_str;
-	hist_field_fn_t op_fn;
+	enum hist_field_fn op_fn;
 	bool combine_consts;
 
 	if (*n_subexprs > 3) {
@@ -2654,16 +2677,16 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 
 	switch (field_op) {
 	case FIELD_OP_MINUS:
-		op_fn = hist_field_minus;
+		op_fn = HIST_FIELD_FN_MINUS;
 		break;
 	case FIELD_OP_PLUS:
-		op_fn = hist_field_plus;
+		op_fn = HIST_FIELD_FN_PLUS;
 		break;
 	case FIELD_OP_DIV:
-		op_fn = hist_field_div;
+		op_fn = HIST_FIELD_FN_DIV;
 		break;
 	case FIELD_OP_MULT:
-		op_fn = hist_field_mult;
+		op_fn = HIST_FIELD_FN_MULT;
 		break;
 	default:
 		ret = -EINVAL;
@@ -2719,13 +2742,16 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		op_fn = hist_field_get_div_fn(operand2);
 	}
 
+	expr->fn_num = op_fn;
+
 	if (combine_consts) {
 		if (var1)
 			expr->operands[0] = var1;
 		if (var2)
 			expr->operands[1] = var2;
 
-		expr->constant = op_fn(expr, NULL, NULL, NULL, NULL);
+		expr->constant = hist_fn_call(expr, NULL, NULL, NULL, NULL);
+		expr->fn_num = HIST_FIELD_FN_CONST;
 
 		expr->operands[0] = NULL;
 		expr->operands[1] = NULL;
@@ -2739,8 +2765,6 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 
 		expr->name = expr_str(expr, 0);
 	} else {
-		expr->fn = op_fn;
-
 		/* The operand sizes should be the same, so just pick one */
 		expr->size = operand1->size;
 		expr->is_signed = operand1->is_signed;
@@ -3065,7 +3089,7 @@ static inline void __update_field_vars(struct tracing_map_elt *elt,
 		struct hist_field *var = field_var->var;
 		struct hist_field *val = field_var->val;
 
-		var_val = val->fn(val, elt, buffer, rbe, rec);
+		var_val = hist_fn_call(val, elt, buffer, rbe, rec);
 		var_idx = var->var.idx;
 
 		if (val->flags & HIST_FIELD_FL_STRING) {
@@ -4186,6 +4210,74 @@ static u64 hist_field_execname(struct hist_field *hist_field,
 	return (u64)(unsigned long)(elt_data->comm);
 }
 
+static u64 hist_fn_call(struct hist_field *hist_field,
+			struct tracing_map_elt *elt,
+			struct trace_buffer *buffer,
+			struct ring_buffer_event *rbe,
+			void *event)
+{
+	switch (hist_field->fn_num) {
+	case HIST_FIELD_FN_VAR_REF:
+		return hist_field_var_ref(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_COUNTER:
+		return hist_field_counter(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_CONST:
+		return hist_field_const(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_LOG2:
+		return hist_field_log2(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_BUCKET:
+		return hist_field_bucket(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_TIMESTAMP:
+		return hist_field_timestamp(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_CPU:
+		return hist_field_cpu(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_STRING:
+		return hist_field_string(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_DYNSTRING:
+		return hist_field_dynstring(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_RELDYNSTRING:
+		return hist_field_reldynstring(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_PSTRING:
+		return hist_field_pstring(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_S64:
+		return hist_field_s64(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_U64:
+		return hist_field_u64(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_S32:
+		return hist_field_s32(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_U32:
+		return hist_field_u32(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_S16:
+		return hist_field_s16(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_U16:
+		return hist_field_u16(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_S8:
+		return hist_field_s8(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_U8:
+		return hist_field_u8(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_UMINUS:
+		return hist_field_unary_minus(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_MINUS:
+		return hist_field_minus(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_PLUS:
+		return hist_field_plus(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_DIV:
+		return hist_field_div(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_MULT:
+		return hist_field_mult(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_DIV_POWER2:
+		return div_by_power_of_two(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_DIV_NOT_POWER2:
+		return div_by_not_power_of_two(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_DIV_MULT_SHIFT:
+		return div_by_mult_and_shift(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_EXECNAME:
+		return hist_field_execname(hist_field, elt, buffer, rbe, event);
+	default:
+		return 0;
+	}
+}
+
 /* Convert a var that points to common_pid.execname to a string */
 static void update_var_execname(struct hist_field *hist_field)
 {
@@ -4197,7 +4289,7 @@ static void update_var_execname(struct hist_field *hist_field)
 	kfree_const(hist_field->type);
 	hist_field->type = "char[]";
 
-	hist_field->fn = hist_field_execname;
+	hist_field->fn_num = HIST_FIELD_FN_EXECNAME;
 }
 
 static int create_var_field(struct hist_trigger_data *hist_data,
@@ -4956,7 +5048,7 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 
 	for_each_hist_val_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
-		hist_val = hist_field->fn(hist_field, elt, buffer, rbe, rec);
+		hist_val = hist_fn_call(hist_field, elt, buffer, rbe, rec);
 		if (hist_field->flags & HIST_FIELD_FL_VAR) {
 			var_idx = hist_field->var.idx;
 
@@ -4987,7 +5079,7 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 	for_each_hist_key_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
 		if (hist_field->flags & HIST_FIELD_FL_VAR) {
-			hist_val = hist_field->fn(hist_field, elt, buffer, rbe, rec);
+			hist_val = hist_fn_call(hist_field, elt, buffer, rbe, rec);
 			var_idx = hist_field->var.idx;
 			tracing_map_set_var(elt, var_idx, hist_val);
 		}
@@ -5062,7 +5154,7 @@ static void event_hist_trigger(struct event_trigger_data *data,
 					 HIST_STACKTRACE_SKIP);
 			key = entries;
 		} else {
-			field_contents = key_field->fn(key_field, elt, buffer, rbe, rec);
+			field_contents = hist_fn_call(key_field, elt, buffer, rbe, rec);
 			if (key_field->flags & HIST_FIELD_FL_STRING) {
 				key = (void *)(unsigned long)field_contents;
 				use_compound_key = true;
-- 
2.35.1
