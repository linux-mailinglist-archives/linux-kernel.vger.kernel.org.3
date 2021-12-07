Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8A246C6DC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbhLGVsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:48:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48716 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbhLGVsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:48:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90EDBB81E83
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471A6C341CB;
        Tue,  7 Dec 2021 21:44:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1muiGD-000Hvk-EM;
        Tue, 07 Dec 2021 16:44:29 -0500
Message-ID: <20211207214429.277660101@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Dec 2021 16:44:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 02/13] tracing: Support __rel_loc relative dynamic data location attribute
References: <20211207214406.148423650@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add '__rel_loc' new dynamic data location attribute which encodes
the data location from the next to the field itself.

The '__data_loc' is used for encoding the dynamic data location on
the trace event record. But '__data_loc' is not useful if the writer
doesn't know the event header (e.g. user event), because it records
the dynamic data offset from the entry of the record, not the field
itself.

This new '__rel_loc' attribute encodes the data location relatively
from the next of the field. For example, when there is a record like
below (the number in the parentheses is the size of fields)

 |header(N)|common(M)|fields(K)|__data_loc(4)|fields(L)|data(G)|

In this case, '__data_loc' field will be

 __data_loc = (G << 16) | (N+M+K+4+L)

If '__rel_loc' is used, this will be

 |header(N)|common(M)|fields(K)|__rel_loc(4)|fields(L)|data(G)|

where

 __rel_loc = (G << 16) | (L)

This case shows L bytes after the '__rel_loc' attribute  field,
if there is no fields after the __rel_loc field, L must be 0.

This is relatively easy (and no need to consider the kernel header
change) when the event data fields are composed by user who doesn't
know header and common fields.

Link: https://lkml.kernel.org/r/163757341258.510314.4214431827833229956.stgit@devnote2

Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h       |  1 +
 kernel/trace/trace.h               |  1 +
 kernel/trace/trace_events_filter.c | 32 ++++++++++++++++++++++++++++--
 kernel/trace/trace_events_hist.c   | 21 ++++++++++++++++++--
 kernel/trace/trace_events_inject.c | 11 ++++++++--
 5 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 2d167ac3452c..3900404aa063 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -782,6 +782,7 @@ enum {
 	FILTER_OTHER = 0,
 	FILTER_STATIC_STRING,
 	FILTER_DYN_STRING,
+	FILTER_RDYN_STRING,
 	FILTER_PTR_STRING,
 	FILTER_TRACE_FN,
 	FILTER_COMM,
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 38715aa6cfdf..5db2bec8ca7e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1465,6 +1465,7 @@ struct filter_pred {
 static inline bool is_string_field(struct ftrace_event_field *field)
 {
 	return field->filter_type == FILTER_DYN_STRING ||
+	       field->filter_type == FILTER_RDYN_STRING ||
 	       field->filter_type == FILTER_STATIC_STRING ||
 	       field->filter_type == FILTER_PTR_STRING ||
 	       field->filter_type == FILTER_COMM;
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c9124038b140..996920ed1812 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -706,6 +706,29 @@ static int filter_pred_strloc(struct filter_pred *pred, void *event)
 	return match;
 }
 
+/*
+ * Filter predicate for relative dynamic sized arrays of characters.
+ * These are implemented through a list of strings at the end
+ * of the entry as same as dynamic string.
+ * The difference is that the relative one records the location offset
+ * from the field itself, not the event entry.
+ */
+static int filter_pred_strrelloc(struct filter_pred *pred, void *event)
+{
+	u32 *item = (u32 *)(event + pred->offset);
+	u32 str_item = *item;
+	int str_loc = str_item & 0xffff;
+	int str_len = str_item >> 16;
+	char *addr = (char *)(&item[1]) + str_loc;
+	int cmp, match;
+
+	cmp = pred->regex.match(addr, &pred->regex, str_len);
+
+	match = cmp ^ pred->not;
+
+	return match;
+}
+
 /* Filter predicate for CPUs. */
 static int filter_pred_cpu(struct filter_pred *pred, void *event)
 {
@@ -756,7 +779,7 @@ static int filter_pred_none(struct filter_pred *pred, void *event)
  *
  * Note:
  * - @str might not be NULL-terminated if it's of type DYN_STRING
- *   or STATIC_STRING, unless @len is zero.
+ *   RDYN_STRING, or STATIC_STRING, unless @len is zero.
  */
 
 static int regex_match_full(char *str, struct regex *r, int len)
@@ -1083,6 +1106,9 @@ int filter_assign_type(const char *type)
 	if (strstr(type, "__data_loc") && strstr(type, "char"))
 		return FILTER_DYN_STRING;
 
+	if (strstr(type, "__rel_loc") && strstr(type, "char"))
+		return FILTER_RDYN_STRING;
+
 	if (strchr(type, '[') && strstr(type, "char"))
 		return FILTER_STATIC_STRING;
 
@@ -1318,8 +1344,10 @@ static int parse_pred(const char *str, void *data,
 			pred->fn = filter_pred_string;
 			pred->regex.field_len = field->size;
 
-		} else if (field->filter_type == FILTER_DYN_STRING)
+		} else if (field->filter_type == FILTER_DYN_STRING) {
 			pred->fn = filter_pred_strloc;
+		} else if (field->filter_type == FILTER_RDYN_STRING)
+			pred->fn = filter_pred_strrelloc;
 		else
 			pred->fn = filter_pred_pchar;
 		/* go past the last quote */
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 319f9c8ca7e7..9b8da439149c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -217,6 +217,20 @@ static u64 hist_field_dynstring(struct hist_field *hist_field,
 	return (u64)(unsigned long)addr;
 }
 
+static u64 hist_field_reldynstring(struct hist_field *hist_field,
+				   struct tracing_map_elt *elt,
+				   struct trace_buffer *buffer,
+				   struct ring_buffer_event *rbe,
+				   void *event)
+{
+	u32 *item = event + hist_field->field->offset;
+	u32 str_item = *item;
+	int str_loc = str_item & 0xffff;
+	char *addr = (char *)&item[1] + str_loc;
+
+	return (u64)(unsigned long)addr;
+}
+
 static u64 hist_field_pstring(struct hist_field *hist_field,
 			      struct tracing_map_elt *elt,
 			      struct trace_buffer *buffer,
@@ -1956,8 +1970,10 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		if (field->filter_type == FILTER_STATIC_STRING) {
 			hist_field->fn = hist_field_string;
 			hist_field->size = field->size;
-		} else if (field->filter_type == FILTER_DYN_STRING)
+		} else if (field->filter_type == FILTER_DYN_STRING) {
 			hist_field->fn = hist_field_dynstring;
+		} else if (field->filter_type == FILTER_RDYN_STRING)
+			hist_field->fn = hist_field_reldynstring;
 		else
 			hist_field->fn = hist_field_pstring;
 	} else {
@@ -4961,7 +4977,8 @@ static inline void add_to_key(char *compound_key, void *key,
 		struct ftrace_event_field *field;
 
 		field = key_field->field;
-		if (field->filter_type == FILTER_DYN_STRING)
+		if (field->filter_type == FILTER_DYN_STRING ||
+		    field->filter_type == FILTER_RDYN_STRING)
 			size = *(u32 *)(rec + field->offset) >> 16;
 		else if (field->filter_type == FILTER_STATIC_STRING)
 			size = field->size;
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index c188045c5f97..d6b4935a78c0 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -168,10 +168,14 @@ static void *trace_alloc_entry(struct trace_event_call *call, int *size)
 			continue;
 		if (field->filter_type == FILTER_STATIC_STRING)
 			continue;
-		if (field->filter_type == FILTER_DYN_STRING) {
+		if (field->filter_type == FILTER_DYN_STRING ||
+		    field->filter_type == FILTER_RDYN_STRING) {
 			u32 *str_item;
 			int str_loc = entry_size & 0xffff;
 
+			if (field->filter_type == FILTER_RDYN_STRING)
+				str_loc -= field->offset + field->size;
+
 			str_item = (u32 *)(entry + field->offset);
 			*str_item = str_loc; /* string length is 0. */
 		} else {
@@ -214,7 +218,8 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
 
 			if (field->filter_type == FILTER_STATIC_STRING) {
 				strlcpy(entry + field->offset, addr, field->size);
-			} else if (field->filter_type == FILTER_DYN_STRING) {
+			} else if (field->filter_type == FILTER_DYN_STRING ||
+				   field->filter_type == FILTER_RDYN_STRING) {
 				int str_len = strlen(addr) + 1;
 				int str_loc = entry_size & 0xffff;
 				u32 *str_item;
@@ -229,6 +234,8 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
 
 				strlcpy(entry + (entry_size - str_len), addr, str_len);
 				str_item = (u32 *)(entry + field->offset);
+				if (field->filter_type == FILTER_RDYN_STRING)
+					str_loc -= field->offset + field->size;
 				*str_item = (str_len << 16) | str_loc;
 			} else {
 				char **paddr;
-- 
2.33.0
