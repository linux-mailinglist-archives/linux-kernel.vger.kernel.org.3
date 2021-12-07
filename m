Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D45D46C6E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242041AbhLGVs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbhLGVsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:48:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F89FC061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 13:44:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA9BAB81E83
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95B7C341DA;
        Tue,  7 Dec 2021 21:44:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1muiGE-000HxO-04;
        Tue, 07 Dec 2021 16:44:30 -0500
Message-ID: <20211207214429.838560481@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Dec 2021 16:44:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 05/13] libtraceevent: Add __rel_loc relative location attribute support
References: <20211207214406.148423650@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add '__rel_loc' new dynamic data location attribute which encodes
the data location from the next to the field itself. This is similar
to the '__data_loc' but the location offset is not from the event
entry but from the next of the field.

This patch adds '__rel_loc' decoding support in the libtraceevent.

Link: https://lkml.kernel.org/r/163757343994.510314.13241077597729303802.stgit@devnote2

Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse.c  | 59 +++++++++++++++++++----------
 tools/lib/traceevent/event-parse.h  |  5 ++-
 tools/lib/traceevent/parse-filter.c |  5 ++-
 3 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index fe58843d047c..8e24c4c78c7f 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -1367,6 +1367,14 @@ static int field_is_dynamic(struct tep_format_field *field)
 	return 0;
 }
 
+static int field_is_relative_dynamic(struct tep_format_field *field)
+{
+	if (strncmp(field->type, "__rel_loc", 9) == 0)
+		return 1;
+
+	return 0;
+}
+
 static int field_is_long(struct tep_format_field *field)
 {
 	/* includes long long */
@@ -1622,6 +1630,8 @@ static int event_read_fields(struct tep_event *event, struct tep_format_field **
 			field->flags |= TEP_FIELD_IS_STRING;
 		if (field_is_dynamic(field))
 			field->flags |= TEP_FIELD_IS_DYNAMIC;
+		if (field_is_relative_dynamic(field))
+			field->flags |= TEP_FIELD_IS_DYNAMIC | TEP_FIELD_IS_RELATIVE;
 		if (field_is_long(field))
 			field->flags |= TEP_FIELD_IS_LONG;
 
@@ -2928,7 +2938,7 @@ process_str(struct tep_event *event __maybe_unused, struct tep_print_arg *arg,
 
 	arg->type = TEP_PRINT_STRING;
 	arg->string.string = token;
-	arg->string.offset = -1;
+	arg->string.field = NULL;
 
 	if (read_expected(TEP_EVENT_DELIM, ")") < 0)
 		goto out_err;
@@ -2957,7 +2967,7 @@ process_bitmask(struct tep_event *event __maybe_unused, struct tep_print_arg *ar
 
 	arg->type = TEP_PRINT_BITMASK;
 	arg->bitmask.bitmask = token;
-	arg->bitmask.offset = -1;
+	arg->bitmask.field = NULL;
 
 	if (read_expected(TEP_EVENT_DELIM, ")") < 0)
 		goto out_err;
@@ -3123,19 +3133,23 @@ process_function(struct tep_event *event, struct tep_print_arg *arg,
 		free_token(token);
 		return process_int_array(event, arg, tok);
 	}
-	if (strcmp(token, "__get_str") == 0) {
+	if (strcmp(token, "__get_str") == 0 ||
+	    strcmp(token, "__get_rel_str") == 0) {
 		free_token(token);
 		return process_str(event, arg, tok);
 	}
-	if (strcmp(token, "__get_bitmask") == 0) {
+	if (strcmp(token, "__get_bitmask") == 0 ||
+	    strcmp(token, "__get_rel_bitmask") == 0) {
 		free_token(token);
 		return process_bitmask(event, arg, tok);
 	}
-	if (strcmp(token, "__get_dynamic_array") == 0) {
+	if (strcmp(token, "__get_dynamic_array") == 0 ||
+	    strcmp(token, "__get_rel_dynamic_array") == 0) {
 		free_token(token);
 		return process_dynamic_array(event, arg, tok);
 	}
-	if (strcmp(token, "__get_dynamic_array_len") == 0) {
+	if (strcmp(token, "__get_dynamic_array_len") == 0 ||
+	    strcmp(token, "__get_rel_dynamic_array_len") == 0) {
 		free_token(token);
 		return process_dynamic_array_len(event, arg, tok);
 	}
@@ -4163,14 +4177,16 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 	case TEP_PRINT_STRING: {
 		int str_offset;
 
-		if (arg->string.offset == -1) {
-			struct tep_format_field *f;
+		if (!arg->string.field)
+			arg->string.field = tep_find_any_field(event, arg->string.string);
+		if (!arg->string.field)
+			break;
 
-			f = tep_find_any_field(event, arg->string.string);
-			arg->string.offset = f->offset;
-		}
-		str_offset = data2host4(tep, *(unsigned int *)(data + arg->string.offset));
+		str_offset = data2host4(tep,
+				*(unsigned int *)(data + arg->string.field->offset));
 		str_offset &= 0xffff;
+		if (arg->string.field->flags & TEP_FIELD_IS_RELATIVE)
+			str_offset += arg->string.field->offset + arg->string.field->size;
 		print_str_to_seq(s, format, len_arg, ((char *)data) + str_offset);
 		break;
 	}
@@ -4181,15 +4197,16 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 		int bitmask_offset;
 		int bitmask_size;
 
-		if (arg->bitmask.offset == -1) {
-			struct tep_format_field *f;
-
-			f = tep_find_any_field(event, arg->bitmask.bitmask);
-			arg->bitmask.offset = f->offset;
-		}
-		bitmask_offset = data2host4(tep, *(unsigned int *)(data + arg->bitmask.offset));
+		if (!arg->bitmask.field)
+			arg->bitmask.field = tep_find_any_field(event, arg->bitmask.bitmask);
+		if (!arg->bitmask.field)
+			break;
+		bitmask_offset = data2host4(tep,
+				*(unsigned int *)(data + arg->bitmask.field->offset));
 		bitmask_size = bitmask_offset >> 16;
 		bitmask_offset &= 0xffff;
+		if (arg->bitmask.field->flags & TEP_FIELD_IS_RELATIVE)
+			bitmask_offset += arg->bitmask.field->offset + arg->bitmask.field->size;
 		print_bitmask_to_seq(tep, s, format, len_arg,
 				     data + bitmask_offset, bitmask_size);
 		break;
@@ -5109,6 +5126,8 @@ void tep_print_field(struct trace_seq *s, void *data,
 			offset = val;
 			len = offset >> 16;
 			offset &= 0xffff;
+			if (field->flags & TEP_FIELD_IS_RELATIVE)
+				offset += field->offset + field->size;
 		}
 		if (field->flags & TEP_FIELD_IS_STRING &&
 		    is_printable_array(data + offset, len)) {
@@ -6987,6 +7006,8 @@ void *tep_get_field_raw(struct trace_seq *s, struct tep_event *event,
 					 data + offset, field->size);
 		*len = offset >> 16;
 		offset &= 0xffff;
+		if (field->flags & TEP_FIELD_IS_RELATIVE)
+			offset += field->offset + field->size;
 	} else
 		*len = field->size;
 
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index a67ad9a5b835..41d4f9f6a843 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -125,6 +125,7 @@ enum tep_format_flags {
 	TEP_FIELD_IS_LONG	= 32,
 	TEP_FIELD_IS_FLAG	= 64,
 	TEP_FIELD_IS_SYMBOLIC	= 128,
+	TEP_FIELD_IS_RELATIVE	= 256,
 };
 
 struct tep_format_field {
@@ -153,12 +154,12 @@ struct tep_print_arg_atom {
 
 struct tep_print_arg_string {
 	char			*string;
-	int			offset;
+	struct tep_format_field *field;
 };
 
 struct tep_print_arg_bitmask {
 	char			*bitmask;
-	int			offset;
+	struct tep_format_field *field;
 };
 
 struct tep_print_arg_field {
diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 368826bb5a57..5df177070d53 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1712,8 +1712,11 @@ static const char *get_field_str(struct tep_filter_arg *arg, struct tep_record *
 
 		if (arg->str.field->flags & TEP_FIELD_IS_DYNAMIC) {
 			addr = *(unsigned int *)val;
-			val = record->data + (addr & 0xffff);
 			size = addr >> 16;
+			addr &= 0xffff;
+			if (arg->str.field->flags & TEP_FIELD_IS_RELATIVE)
+				addr += arg->str.field->offset + arg->str.field->size;
+			val = record->data + addr;
 		}
 
 		/*
-- 
2.33.0
