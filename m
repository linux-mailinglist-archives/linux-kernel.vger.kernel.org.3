Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17A94F0A32
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 16:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359059AbiDCOeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 10:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359000AbiDCOdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 10:33:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A278931937
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:31:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 196CEB80D52
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 14:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0B1C340F2;
        Sun,  3 Apr 2022 14:31:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nb1GV-001Efm-Jp;
        Sun, 03 Apr 2022 10:31:39 -0400
Message-ID: <20220403143139.452394151@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 03 Apr 2022 10:25:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 1/7] tracing: Rename the staging files for trace_events
References: <20220403142500.388473000@goodmis.org>
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

When looking for implementation of different phases of the creation of the
TRACE_EVENT() macro, it is pretty useless when all helper macro
redefinitions are in files labeled "stageX_defines.h". Rename them to
state which phase the files are for. For instance, when looking for the
defines that are used to create the event fields, seeing
"stage4_event_fields.h" gives the developer a good idea that the defines
are in that file.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../{stage1_defines.h => stage1_struct_define.h}   |  0
 .../{stage2_defines.h => stage2_data_offsets.h}    |  0
 .../{stage3_defines.h => stage3_trace_output.h}    |  0
 .../{stage4_defines.h => stage4_event_fields.h}    |  0
 .../{stage5_defines.h => stage5_get_offsets.h}     |  0
 .../{stage6_defines.h => stage6_event_callback.h}  |  0
 .../{stage7_defines.h => stage7_class_define.h}    |  0
 include/trace/trace_custom_events.h                | 14 +++++++-------
 include/trace/trace_events.h                       | 14 +++++++-------
 9 files changed, 14 insertions(+), 14 deletions(-)
 rename include/trace/stages/{stage1_defines.h => stage1_struct_define.h} (100%)
 rename include/trace/stages/{stage2_defines.h => stage2_data_offsets.h} (100%)
 rename include/trace/stages/{stage3_defines.h => stage3_trace_output.h} (100%)
 rename include/trace/stages/{stage4_defines.h => stage4_event_fields.h} (100%)
 rename include/trace/stages/{stage5_defines.h => stage5_get_offsets.h} (100%)
 rename include/trace/stages/{stage6_defines.h => stage6_event_callback.h} (100%)
 rename include/trace/stages/{stage7_defines.h => stage7_class_define.h} (100%)

diff --git a/include/trace/stages/stage1_defines.h b/include/trace/stages/stage1_struct_define.h
similarity index 100%
rename from include/trace/stages/stage1_defines.h
rename to include/trace/stages/stage1_struct_define.h
diff --git a/include/trace/stages/stage2_defines.h b/include/trace/stages/stage2_data_offsets.h
similarity index 100%
rename from include/trace/stages/stage2_defines.h
rename to include/trace/stages/stage2_data_offsets.h
diff --git a/include/trace/stages/stage3_defines.h b/include/trace/stages/stage3_trace_output.h
similarity index 100%
rename from include/trace/stages/stage3_defines.h
rename to include/trace/stages/stage3_trace_output.h
diff --git a/include/trace/stages/stage4_defines.h b/include/trace/stages/stage4_event_fields.h
similarity index 100%
rename from include/trace/stages/stage4_defines.h
rename to include/trace/stages/stage4_event_fields.h
diff --git a/include/trace/stages/stage5_defines.h b/include/trace/stages/stage5_get_offsets.h
similarity index 100%
rename from include/trace/stages/stage5_defines.h
rename to include/trace/stages/stage5_get_offsets.h
diff --git a/include/trace/stages/stage6_defines.h b/include/trace/stages/stage6_event_callback.h
similarity index 100%
rename from include/trace/stages/stage6_defines.h
rename to include/trace/stages/stage6_event_callback.h
diff --git a/include/trace/stages/stage7_defines.h b/include/trace/stages/stage7_class_define.h
similarity index 100%
rename from include/trace/stages/stage7_defines.h
rename to include/trace/stages/stage7_class_define.h
diff --git a/include/trace/trace_custom_events.h b/include/trace/trace_custom_events.h
index b567c7202339..6e492dba96bf 100644
--- a/include/trace/trace_custom_events.h
+++ b/include/trace/trace_custom_events.h
@@ -35,7 +35,7 @@
 
 /* Stage 1 creates the structure of the recorded event layout */
 
-#include "stages/stage1_defines.h"
+#include "stages/stage1_struct_define.h"
 
 #undef DECLARE_CUSTOM_EVENT_CLASS
 #define DECLARE_CUSTOM_EVENT_CLASS(name, proto, args, tstruct, assign, print) \
@@ -56,7 +56,7 @@
 
 /* Stage 2 creates the custom class */
 
-#include "stages/stage2_defines.h"
+#include "stages/stage2_data_offsets.h"
 
 #undef DECLARE_CUSTOM_EVENT_CLASS
 #define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
@@ -71,7 +71,7 @@
 
 /* Stage 3 create the way to print the custom event */
 
-#include "stages/stage3_defines.h"
+#include "stages/stage3_trace_output.h"
 
 #undef DECLARE_CUSTOM_EVENT_CLASS
 #define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
@@ -102,7 +102,7 @@ static struct trace_event_functions trace_custom_event_type_funcs_##call = { \
 
 /* Stage 4 creates the offset layout for the fields */
 
-#include "stages/stage4_defines.h"
+#include "stages/stage4_event_fields.h"
 
 #undef DECLARE_CUSTOM_EVENT_CLASS
 #define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, func, print)	\
@@ -114,7 +114,7 @@ static struct trace_event_fields trace_custom_event_fields_##call[] = {	\
 
 /* Stage 5 creates the helper function for dynamic fields */
 
-#include "stages/stage5_defines.h"
+#include "stages/stage5_get_offsets.h"
 
 #undef DECLARE_CUSTOM_EVENT_CLASS
 #define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
@@ -134,7 +134,7 @@ static inline notrace int trace_custom_event_get_offsets_##call(	\
 
 /* Stage 6 creates the probe function that records the event */
 
-#include "stages/stage6_defines.h"
+#include "stages/stage6_event_callback.h"
 
 #undef DECLARE_CUSTOM_EVENT_CLASS
 #define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
@@ -182,7 +182,7 @@ static inline void ftrace_test_custom_probe_##call(void)		\
 
 /* Stage 7 creates the actual class and event structure for the custom event */
 
-#include "stages/stage7_defines.h"
+#include "stages/stage7_class_define.h"
 
 #undef DECLARE_CUSTOM_EVENT_CLASS
 #define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 8a8cd66cc6d5..c2f9cabf154d 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -45,7 +45,7 @@
 			     PARAMS(print));		       \
 	DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
 
-#include "stages/stage1_defines.h"
+#include "stages/stage1_struct_define.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(name, proto, args, tstruct, assign, print)	\
@@ -109,7 +109,7 @@
  * The size of an array is also encoded, in the higher 16 bits of <item>.
  */
 
-#include "stages/stage2_defines.h"
+#include "stages/stage2_data_offsets.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
@@ -181,7 +181,7 @@
  * in binary.
  */
 
-#include "stages/stage3_defines.h"
+#include "stages/stage3_trace_output.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
@@ -236,7 +236,7 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
-#include "stages/stage4_defines.h"
+#include "stages/stage4_event_fields.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, func, print)	\
@@ -249,7 +249,7 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
-#include "stages/stage5_defines.h"
+#include "stages/stage5_get_offsets.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
@@ -372,7 +372,7 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #define _TRACE_PERF_INIT(call)
 #endif /* CONFIG_PERF_EVENTS */
 
-#include "stages/stage6_defines.h"
+#include "stages/stage6_event_callback.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
@@ -418,7 +418,7 @@ static inline void ftrace_test_probe_##call(void)			\
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
-#include "stages/stage7_defines.h"
+#include "stages/stage7_class_define.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
-- 
2.35.1
