Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814A54CC863
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbiCCVuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiCCVuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:50:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68794A3CA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 13:49:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75DC361D74
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9269C004E1;
        Thu,  3 Mar 2022 21:49:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nPtK2-00ESDY-Hw;
        Thu, 03 Mar 2022 16:49:18 -0500
Message-ID: <20220303214832.031378059@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 16:48:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 0/4 v2] tracing: Add a way to have custom events in the tracefs directory
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We would like to have in production a way to record sched wakeups and
sched switch, and be able to save the information in a small file
with as much available as possible. Currently the wake up and sched switch
events are 36 and 64 bytes each (plus a 4 byte ring buffer event header).

By having a custom module tap into the sched switch and waking trace points
we can bring those events down to 16 and 14 bytes respectively.

This version adds the new TRACE_CUSTOM_EVENT() which makes creating
a custom event as easy as creating a TRACE_EVENT()!

The TRACE_CUSTOM_EVENT() macro does all the work to create the
event, and has the same format as the TRACE_EVENT() does.

Note, currently perf and bpf do not hook to this, but we can add
that later.

I kept patch 2 that has the complex way of hand coding the custom
event just to keep the histor of it.

But now, to add a custom event for sched_switch, all that needs to be
done is:

trace_custom_sched.c:
-------------------------%<-------------------------
#include <linux/trace_events.h>
#include <linux/version.h>
#include <linux/module.h>
#include <linux/sched.h>

#include <trace/events/sched.h>

#define CREATE_CUSTOM_TRACE_EVENTS

#include "trace_custom_sched.h"

static void fct(struct tracepoint *tp, void *priv)
{
	trace_custom_event_sched_switch_update(tp);
}

static int __init trace_sched_init(void)
{
	for_each_kernel_tracepoint(fct, NULL);
	return 0;
}

static void __exit trace_sched_exit(void)
{
}

module_init(trace_sched_init);
module_exit(trace_sched_exit);
------------------------->%-------------------------


-------------------------%<-------------------------
#if !defined(_TRACE_CUSTOM_SCHED_H) || defined(TRACE_CUSTOM_MULTI_READ)
#define _TRACE_CUSTOM_SCHED_H

#include <linux/trace_events.h>

TRACE_CUSTOM_EVENT(sched_switch,

	/* The below must be the same as the original sched_switch */
	TP_PROTO(bool preempt,
		 struct task_struct *prev,
		 struct task_struct *next),

	TP_ARGS(preempt, prev, next),

	/* The below is the customization */
	TP_STRUCT__entry(
		__field(	unsigned short,		prev_prio	)
		__field(	unsigned short,		next_prio	)
		__field(	pid_t,	next_pid			)
	),

	TP_fast_assign(
		__entry->prev_prio	= prev->prio;
		__entry->next_pid	= next->pid;
		__entry->next_prio	= next->prio;
	),

	TP_printk("prev_prio=%d next_pid=%d next_prio=%d",
		  __entry->prev_prio, __entry->next_pid, __entry->next_prio)
)
#endif
#undef TRACE_INCLUDE_PATH
#undef TRACE_INCLUDE_FILE
#define TRACE_INCLUDE_PATH .

#define TRACE_INCLUDE_FILE trace_custom_sched
#include <trace/define_custom_trace.h>
------------------------->%-------------------------

And update the Makefile to have:

  CFLAGS_trace_custom_sched.o := -I$(src)

Steven Rostedt (Google) (4):
      tracing: Allow custom events to be added to the tracefs directory
      tracing: Add sample code for custom trace events
      tracing: Move the defines to create TRACE_EVENTS into their own files
      tracing: Add TRACE_CUSTOM_EVENT() macro

----
 arch/x86/kernel/kprobes/core.c            |   4 +-
 include/linux/trace_events.h              |  24 +-
 include/trace/stages/init.h               |  37 +++
 include/trace/stages/stage1_defines.h     |  46 +++
 include/trace/stages/stage2_defines.h     |  48 +++
 include/trace/stages/stage3_defines.h     | 129 ++++++++
 include/trace/stages/stage4_defines.h     |  57 ++++
 include/trace/stages/stage5_defines.h     |  83 +++++
 include/trace/stages/stage6_defines.h     |  86 +++++
 include/trace/stages/stage7_defines.h     |  34 ++
 include/trace/trace_events.h              | 499 +-----------------------------
 kernel/trace/ftrace.c                     |  33 +-
 kernel/trace/trace_events.c               |   2 +
 samples/Kconfig                           |   8 +-
 samples/Makefile                          |   1 +
 samples/trace_events/Makefile             |   2 +
 samples/trace_events/trace_custom_sched.c |  60 ++++
 samples/trace_events/trace_custom_sched.h |  95 ++++++
 18 files changed, 751 insertions(+), 497 deletions(-)
 create mode 100644 include/trace/stages/init.h
 create mode 100644 include/trace/stages/stage1_defines.h
 create mode 100644 include/trace/stages/stage2_defines.h
 create mode 100644 include/trace/stages/stage3_defines.h
 create mode 100644 include/trace/stages/stage4_defines.h
 create mode 100644 include/trace/stages/stage5_defines.h
 create mode 100644 include/trace/stages/stage6_defines.h
 create mode 100644 include/trace/stages/stage7_defines.h
 create mode 100644 samples/trace_events/trace_custom_sched.c
 create mode 100644 samples/trace_events/trace_custom_sched.h
