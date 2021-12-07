Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB0346C6DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241997AbhLGVsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241957AbhLGVsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:48:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8D8C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 13:44:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BDE8DCE1E71
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7CBC341C3;
        Tue,  7 Dec 2021 21:44:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1muiGD-000Hub-1z;
        Tue, 07 Dec 2021 16:44:29 -0500
Message-ID: <20211207214406.148423650@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Dec 2021 16:44:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/13] tracing: Updates for 5.17
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: a6ed2aee54644cfa2d04ca86308767f5c3a087e8


Colin Ian King (1):
      tracing: Fix spelling mistake "aritmethic" -> "arithmetic"

Masami Hiramatsu (5):
      tracing: Support __rel_loc relative dynamic data location attribute
      tracing: Add '__rel_loc' using trace event macros
      samples/trace_event: Add '__rel_loc' using sample event
      libtraceevent: Add __rel_loc relative location attribute support
      tools/perf: Add '__rel_loc' event field parsing support

Qiujun Huang (1):
      tracing: Fix synth_event_add_val() kernel-doc comment

Steven Rostedt (VMware) (5):
      tracing: Use __this_cpu_read() in trace_event_buffer_lock_reserver()
      tracing: Disable preemption when using the filter buffer
      tracing: Have eprobes use filtering logic of trace events
      tracing/kprobes: Do not open code event reserve logic
      tracing/uprobes: Use trace_event_buffer_reserve() helper

Uladzislau Rezki (Sony) (1):
      tracing: Switch to kvfree_rcu() API

----
 include/linux/trace_events.h                       |   1 +
 include/trace/bpf_probe.h                          |  16 +++
 include/trace/perf.h                               |  16 +++
 include/trace/trace_events.h                       | 120 ++++++++++++++++++++-
 kernel/trace/trace.c                               |  61 ++++++-----
 kernel/trace/trace.h                               |   8 +-
 kernel/trace/trace_eprobe.c                        |  16 +--
 kernel/trace/trace_events_filter.c                 |  32 +++++-
 kernel/trace/trace_events_hist.c                   |  21 +++-
 kernel/trace/trace_events_inject.c                 |  11 +-
 kernel/trace/trace_events_synth.c                  |   2 +-
 kernel/trace/trace_kprobe.c                        |  25 ++---
 kernel/trace/trace_osnoise.c                       |   3 +-
 kernel/trace/trace_probe.c                         |   3 +-
 kernel/trace/trace_uprobe.c                        |  11 +-
 samples/trace_events/trace-events-sample.c         |   3 +
 samples/trace_events/trace-events-sample.h         |  33 ++++++
 tools/lib/traceevent/event-parse.c                 |  59 ++++++----
 tools/lib/traceevent/event-parse.h                 |   5 +-
 tools/lib/traceevent/parse-filter.c                |   5 +-
 tools/perf/builtin-trace.c                         |   2 +
 tools/perf/util/data-convert-bt.c                  |   2 +
 tools/perf/util/evsel.c                            |   2 +
 tools/perf/util/python.c                           |   2 +
 .../perf/util/scripting-engines/trace-event-perl.c |   2 +
 .../util/scripting-engines/trace-event-python.c    |   2 +
 tools/perf/util/sort.c                             |   2 +
 27 files changed, 366 insertions(+), 99 deletions(-)
