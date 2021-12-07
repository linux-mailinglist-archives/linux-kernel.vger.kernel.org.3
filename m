Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E9B46C6E2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbhLGVsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241978AbhLGVsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:48:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4246BC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 13:44:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8A1BFCE1E79
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B79C341DF;
        Tue,  7 Dec 2021 21:44:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1muiGE-000Hxx-64;
        Tue, 07 Dec 2021 16:44:30 -0500
Message-ID: <20211207214430.021097833@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Dec 2021 16:44:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 06/13] tools/perf: Add __rel_loc event field parsing support
References: <20211207214406.148423650@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add new '__rel_loc' dynamic data location attribute support.
This type attribute is similar to the '__data_loc' but records the
offset from the field itself.
The libtraceevent adds TEP_FIELD_IS_RELATIVE to the
'tep_format_field::flags' with TEP_FIELD_IS_DYNAMIC for'__rel_loc'.

Link: https://lkml.kernel.org/r/163757344810.510314.12449413842136229871.stgit@devnote2

Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/perf/builtin-trace.c                             | 2 ++
 tools/perf/util/data-convert-bt.c                      | 2 ++
 tools/perf/util/evsel.c                                | 2 ++
 tools/perf/util/python.c                               | 2 ++
 tools/perf/util/scripting-engines/trace-event-perl.c   | 2 ++
 tools/perf/util/scripting-engines/trace-event-python.c | 2 ++
 tools/perf/util/sort.c                                 | 2 ++
 7 files changed, 14 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0b52e08e558e..ea517762cb0c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2726,6 +2726,8 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 				offset = format_field__intval(field, sample, evsel->needs_swap);
 				syscall_arg.len = offset >> 16;
 				offset &= 0xffff;
+				if (field->flags & TEP_FIELD_IS_RELATIVE)
+					offset += field->offset + field->size;
 			}
 
 			val = (uintptr_t)(sample->raw_data + offset);
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 8f7705bbc2da..9e0aee276df8 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -318,6 +318,8 @@ static int add_tracepoint_field_value(struct ctf_writer *cw,
 		offset = tmp_val;
 		len = offset >> 16;
 		offset &= 0xffff;
+		if (flags & TEP_FIELD_IS_RELATIVE)
+			offset += fmtf->offset + fmtf->size;
 	}
 
 	if (flags & TEP_FIELD_IS_ARRAY) {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ac0127be0459..f29d37004f55 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2706,6 +2706,8 @@ void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char
 	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 		offset = *(int *)(sample->raw_data + field->offset);
 		offset &= 0xffff;
+		if (field->flags & TEP_FIELD_IS_RELATIVE)
+			offset += field->offset + field->size;
 	}
 
 	return sample->raw_data + offset;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 563a9ba8954f..3e7538db9107 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -428,6 +428,8 @@ tracepoint_field(struct pyrf_event *pe, struct tep_format_field *field)
 			offset  = val;
 			len     = offset >> 16;
 			offset &= 0xffff;
+			if (field->flags & TEP_FIELD_IS_RELATIVE)
+				offset += field->offset + field->size;
 		}
 		if (field->flags & TEP_FIELD_IS_STRING &&
 		    is_printable_array(data + offset, len)) {
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 32a721b3e9a5..a5d945415bbc 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -392,6 +392,8 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 				offset = *(int *)(data + field->offset);
 				offset &= 0xffff;
+				if (field->flags & TEP_FIELD_IS_RELATIVE)
+					offset += field->offset + field->size;
 			} else
 				offset = field->offset;
 			XPUSHs(sv_2mortal(newSVpv((char *)data + offset, 0)));
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index c0c010350bc2..d1f1501ce7fc 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -942,6 +942,8 @@ static void python_process_tracepoint(struct perf_sample *sample,
 				offset  = val;
 				len     = offset >> 16;
 				offset &= 0xffff;
+				if (field->flags & TEP_FIELD_IS_RELATIVE)
+					offset += field->offset + field->size;
 			}
 			if (field->flags & TEP_FIELD_IS_STRING &&
 			    is_printable_array(data + offset, len)) {
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index a111065b484e..d9a106f0edb2 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2365,6 +2365,8 @@ static int64_t __sort__hde_cmp(struct perf_hpp_fmt *fmt,
 		tep_read_number_field(field, a->raw_data, &dyn);
 		offset = dyn & 0xffff;
 		size = (dyn >> 16) & 0xffff;
+		if (field->flags & TEP_FIELD_IS_RELATIVE)
+			offset += field->offset + field->size;
 
 		/* record max width for output */
 		if (size > hde->dynamic_len)
-- 
2.33.0
