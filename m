Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD8349FF82
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350341AbiA1RWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:22:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56372 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350811AbiA1RU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:20:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 579CCB82682
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 17:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED79C340E0;
        Fri, 28 Jan 2022 17:20:22 +0000 (UTC)
Date:   Fri, 28 Jan 2022 12:20:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [GIT PULL] tracing: Fixes for 5.17-rc1
Message-ID: <20220128122020.7d938e68@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes for 5.17-rc1:

 - Limit mcount build time sorting to only those archs that
   we know it works for.

 - Fix memory leak in error path of histogram setup

 - Fix and clean up rel_loc array out of bounds issue

 - tools/rtla documentation fixes

 - Fix issues with histogram logic


Please pull the latest trace-v5.17-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.17-rc1

Tag SHA1: d0f57822f437071b7f79a57352c33353aeb6a260
Head SHA1: 67ab5eb71b37b55f7c5522d080a1b42823351776


Kees Cook (1):
      tracing/perf: Avoid -Warray-bounds warning for __rel_loc macro

Masami Hiramatsu (1):
      tracing: Avoid -Warray-bounds warning for __rel_loc macro

Shuah Khan (2):
      rtla: Make doc build optional
      tools/tracing: Update Makefile to build rtla

Steven Rostedt (Google) (1):
      ftrace: Have architectures opt-in for mcount build time sorting

Tom Zanussi (4):
      tracing: Fix smatch warning for null glob in event_hist_trigger_parse()
      tracing: Fix smatch warning for do while check in event_hist_trigger_parse()
      tracing: Propagate is_signed to expression
      tracing: Don't inc err_log entry count if entry allocation fails

Xiaoke Wang (1):
      tracing/histogram: Fix a potential memory leak for kstrdup()

----
 arch/arm/Kconfig                 |  1 +
 arch/x86/Kconfig                 |  1 +
 include/trace/perf.h             |  5 +++--
 include/trace/trace_events.h     |  9 +++++----
 kernel/trace/Kconfig             |  8 +++++++-
 kernel/trace/trace.c             |  3 ++-
 kernel/trace/trace_events_hist.c | 10 ++++++++--
 scripts/Makefile                 |  2 +-
 tools/tracing/Makefile           | 18 ++++++++++++++----
 tools/tracing/rtla/Makefile      |  2 +-
 10 files changed, 43 insertions(+), 16 deletions(-)
---------------------------
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fabe39169b12..4c97cb40eebb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -83,6 +83,7 @@ config ARM
 	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_C_RECORDMCOUNT
+	select HAVE_BUILDTIME_MCOUNT_SORT
 	select HAVE_DEBUG_KMEMLEAK if !XIP_KERNEL
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ebe8fc76949a..9f5bd41bf660 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -186,6 +186,7 @@ config X86
 	select HAVE_CONTEXT_TRACKING_OFFSTACK	if HAVE_CONTEXT_TRACKING
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_OBJTOOL_MCOUNT		if STACK_VALIDATION
+	select HAVE_BUILDTIME_MCOUNT_SORT
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
diff --git a/include/trace/perf.h b/include/trace/perf.h
index ea4405de175a..5d48c46a3008 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -23,8 +23,9 @@
 
 #undef __get_rel_dynamic_array
 #define __get_rel_dynamic_array(field)	\
-		((void *)(&__entry->__rel_loc_##field) +	\
-		 sizeof(__entry->__rel_loc_##field) +		\
+		((void *)__entry +					\
+		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
+		 sizeof(__entry->__rel_loc_##field) +			\
 		 (__entry->__rel_loc_##field & 0xffff))
 
 #undef __get_rel_dynamic_array_len
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 8c6f7c433518..3d29919045af 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -128,7 +128,7 @@ TRACE_MAKE_SYSTEM_STR();
 	struct trace_event_raw_##name {					\
 		struct trace_entry	ent;				\
 		tstruct							\
-		char			__data[0];			\
+		char			__data[];			\
 	};								\
 									\
 	static struct trace_event_class event_class_##name;
@@ -318,9 +318,10 @@ TRACE_MAKE_SYSTEM_STR();
 #define __get_str(field) ((char *)__get_dynamic_array(field))
 
 #undef __get_rel_dynamic_array
-#define __get_rel_dynamic_array(field)	\
-		((void *)(&__entry->__rel_loc_##field) +	\
-		 sizeof(__entry->__rel_loc_##field) +		\
+#define __get_rel_dynamic_array(field)					\
+		((void *)__entry + 					\
+		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
+		 sizeof(__entry->__rel_loc_##field) +			\
 		 (__entry->__rel_loc_##field & 0xffff))
 
 #undef __get_rel_dynamic_array_len
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 752ed89a293b..a5eb5e7fd624 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -70,10 +70,16 @@ config HAVE_C_RECORDMCOUNT
 	help
 	  C version of recordmcount available?
 
+config HAVE_BUILDTIME_MCOUNT_SORT
+       bool
+       help
+         An architecture selects this if it sorts the mcount_loc section
+	 at build time.
+
 config BUILDTIME_MCOUNT_SORT
        bool
        default y
-       depends on BUILDTIME_TABLE_SORT && !S390
+       depends on HAVE_BUILDTIME_MCOUNT_SORT && DYNAMIC_FTRACE
        help
          Sort the mcount_loc section at build time.
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a569a0cb81ee..c860f582b078 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7740,7 +7740,8 @@ static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr)
 		err = kzalloc(sizeof(*err), GFP_KERNEL);
 		if (!err)
 			err = ERR_PTR(-ENOMEM);
-		tr->n_err_log_entries++;
+		else
+			tr->n_err_log_entries++;
 
 		return err;
 	}
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5e6a988a8a51..ada87bfb5bb8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2503,6 +2503,8 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
 	expr->fn = hist_field_unary_minus;
 	expr->operands[0] = operand1;
+	expr->size = operand1->size;
+	expr->is_signed = operand1->is_signed;
 	expr->operator = FIELD_OP_UNARY_MINUS;
 	expr->name = expr_str(expr, 0);
 	expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
@@ -2719,6 +2721,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 
 		/* The operand sizes should be the same, so just pick one */
 		expr->size = operand1->size;
+		expr->is_signed = operand1->is_signed;
 
 		expr->operator = field_op;
 		expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
@@ -3935,6 +3938,7 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 
 			var_ref_idx = find_var_ref_idx(hist_data, var_ref);
 			if (WARN_ON(var_ref_idx < 0)) {
+				kfree(p);
 				ret = var_ref_idx;
 				goto err;
 			}
@@ -6163,7 +6167,9 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 
 	lockdep_assert_held(&event_mutex);
 
-	if (glob && strlen(glob)) {
+	WARN_ON(!glob);
+
+	if (strlen(glob)) {
 		hist_err_clear();
 		last_cmd_set(file, param);
 	}
@@ -6196,7 +6202,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 			continue;
 		}
 		break;
-	} while (p);
+	} while (1);
 
 	if (!p)
 		param = NULL;
diff --git a/scripts/Makefile b/scripts/Makefile
index ecd3acacd0ec..ce5aa9030b74 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -25,7 +25,7 @@ HOSTCFLAGS_sorttable.o += -I$(srctree)/tools/arch/x86/include
 HOSTCFLAGS_sorttable.o += -DUNWINDER_ORC_ENABLED
 endif
 
-ifdef CONFIG_DYNAMIC_FTRACE
+ifdef CONFIG_BUILDTIME_MCOUNT_SORT
 HOSTCFLAGS_sorttable.o += -DMCOUNT_SORT_ENABLED
 endif
 
diff --git a/tools/tracing/Makefile b/tools/tracing/Makefile
index 87e0ec48e2e7..95e485f12d97 100644
--- a/tools/tracing/Makefile
+++ b/tools/tracing/Makefile
@@ -1,11 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 include ../scripts/Makefile.include
 
-all: latency
+all: latency rtla
 
-clean: latency_clean
+clean: latency_clean rtla_clean
 
-install: latency_install
+install: latency_install rtla_install
 
 latency:
 	$(call descend,latency)
@@ -16,4 +16,14 @@ latency_install:
 latency_clean:
 	$(call descend,latency,clean)
 
-.PHONY: all install clean latency latency_install latency_clean
+rtla:
+	$(call descend,rtla)
+
+rtla_install:
+	$(call descend,rtla,install)
+
+rtla_clean:
+	$(call descend,rtla,clean)
+
+.PHONY: all install clean latency latency_install latency_clean \
+	rtla rtla_install rtla_clean
diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 2d52ff0bff7d..7c39728d08de 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -59,7 +59,7 @@ endif
 .PHONY:	all
 all:	rtla
 
-rtla: $(OBJ) doc
+rtla: $(OBJ)
 	$(CC) -o rtla $(LDFLAGS) $(OBJ) $(LIBS)
 
 static: $(OBJ)
