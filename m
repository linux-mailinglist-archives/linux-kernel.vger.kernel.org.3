Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B87748B3E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344396AbiAKRbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:31:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45292 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241526AbiAKRbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:31:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82F67B81C04
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CFBC36AE3;
        Tue, 11 Jan 2022 17:31:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n7KzJ-00324J-Cc;
        Tue, 11 Jan 2022 12:31:13 -0500
Message-ID: <20220111173030.999527342@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 11 Jan 2022 12:30:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/31] tracing: Final updates for 5.17
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 0a85bdad9ae1c5f68d83e16433f4b88c264843b2


Daniel Bristot de Oliveira (14):
      rtla: Real-Time Linux Analysis tool
      rtla: Helper functions for rtla
      rtla: Add osnoise tool
      rtla/osnoise: Add osnoise top mode
      rtla/osnoise: Add the hist mode
      rtla: Add timerlat tool and timelart top mode
      rtla/timerlat: Add timerlat hist mode
      rtla: Add Documentation
      rtla: Add rtla osnoise man page
      rtla: Add rtla osnoise top documentation
      rtla: Add rtla osnoise hist documentation
      rtla: Add rtla timerlat documentation
      rtla: Add rtla timerlat top documentation
      rtla: Add rtla timerlat hist documentation

Geliang Tang (1):
      tracing: Fix mismatched comment in __string_len

Nikita Yushchenko (1):
      tracing/osnoise: Properly unhook events if start_per_cpu_kthreads() fails

Sebastian Andrzej Siewior (1):
      tracing: Account bottom half disabled sections.

Steven Rostedt (2):
      tracing: Have syscall trace events use trace_event_buffer_lock_reserve()
      tracing: Add test for user space strings when filtering on string pointers

Steven Rostedt (VMware) (1):
      ftrace: Add test to make sure compiled time sorts work

Tom Zanussi (6):
      tracing: Change event_command func() to parse()
      tracing: Change event_trigger_ops func() to trigger()
      tracing: Remove ops param from event_command reg()/unreg() callbacks
      tracing: Add helper functions to simplify event_command.parse() callback handling
      tracing: Have existing event_command.parse() implementations use helpers
      tracing: Remove redundant trigger_ops params

Xiangyang Zhang (1):
      tracing/kprobes: 'nmissed' not showed correctly for kretprobe

Xiaoke Wang (2):
      tracing/uprobes: Check the return value of kstrdup() for tu->filename
      tracing/probes: check the return value of kstrndup() for pbuf

Yinan Liu (1):
      scripts: ftrace - move the sort-processing in ftrace_init

Yuntao Wang (1):
      tracing: Remove duplicate warnings when calling trace_create_file()

----
 Documentation/tools/rtla/Makefile                  |   41 +
 Documentation/tools/rtla/common_appendix.rst       |   12 +
 Documentation/tools/rtla/common_hist_options.rst   |   23 +
 Documentation/tools/rtla/common_options.rst        |   24 +
 .../tools/rtla/common_osnoise_description.rst      |    8 +
 .../tools/rtla/common_osnoise_options.rst          |   17 +
 .../tools/rtla/common_timerlat_description.rst     |   10 +
 .../tools/rtla/common_timerlat_options.rst         |   16 +
 Documentation/tools/rtla/common_top_options.rst    |    3 +
 Documentation/tools/rtla/rtla-osnoise-hist.rst     |   66 ++
 Documentation/tools/rtla/rtla-osnoise-top.rst      |   61 ++
 Documentation/tools/rtla/rtla-osnoise.rst          |   59 ++
 Documentation/tools/rtla/rtla-timerlat-hist.rst    |  106 ++
 Documentation/tools/rtla/rtla-timerlat-top.rst     |  145 +++
 Documentation/tools/rtla/rtla-timerlat.rst         |   57 ++
 Documentation/tools/rtla/rtla.rst                  |   48 +
 Documentation/trace/events.rst                     |   10 +
 include/linux/trace_events.h                       |    1 +
 kernel/trace/Kconfig                               |   14 +
 kernel/trace/ftrace.c                              |   34 +-
 kernel/trace/trace.c                               |    6 +-
 kernel/trace/trace.h                               |   81 +-
 kernel/trace/trace_eprobe.c                        |   30 +-
 kernel/trace/trace_events.c                        |   12 +-
 kernel/trace/trace_events_filter.c                 |   59 +-
 kernel/trace/trace_events_hist.c                   |  147 ++-
 kernel/trace/trace_events_trigger.c                |  626 ++++++++----
 kernel/trace/trace_kprobe.c                        |    5 +-
 kernel/trace/trace_osnoise.c                       |   20 +-
 kernel/trace/trace_output.c                        |    4 +
 kernel/trace/trace_probe.c                         |    2 +
 kernel/trace/trace_syscalls.c                      |    6 +-
 kernel/trace/trace_uprobe.c                        |    5 +
 samples/trace_events/trace-events-sample.h         |    2 +-
 scripts/Makefile                                   |    6 +-
 scripts/link-vmlinux.sh                            |    6 +-
 scripts/sorttable.c                                |    2 +
 scripts/sorttable.h                                |  120 ++-
 tools/tracing/rtla/Makefile                        |  102 ++
 tools/tracing/rtla/README.txt                      |   36 +
 tools/tracing/rtla/src/osnoise.c                   | 1017 ++++++++++++++++++++
 tools/tracing/rtla/src/osnoise.h                   |   96 ++
 tools/tracing/rtla/src/osnoise_hist.c              |  799 +++++++++++++++
 tools/tracing/rtla/src/osnoise_top.c               |  577 +++++++++++
 tools/tracing/rtla/src/rtla.c                      |   87 ++
 tools/tracing/rtla/src/timerlat.c                  |   72 ++
 tools/tracing/rtla/src/timerlat.h                  |    4 +
 tools/tracing/rtla/src/timerlat_hist.c             |  820 ++++++++++++++++
 tools/tracing/rtla/src/timerlat_top.c              |  615 ++++++++++++
 tools/tracing/rtla/src/trace.c                     |  192 ++++
 tools/tracing/rtla/src/trace.h                     |   27 +
 tools/tracing/rtla/src/utils.c                     |  433 +++++++++
 tools/tracing/rtla/src/utils.h                     |   56 ++
 53 files changed, 6477 insertions(+), 350 deletions(-)
 create mode 100644 Documentation/tools/rtla/Makefile
 create mode 100644 Documentation/tools/rtla/common_appendix.rst
 create mode 100644 Documentation/tools/rtla/common_hist_options.rst
 create mode 100644 Documentation/tools/rtla/common_options.rst
 create mode 100644 Documentation/tools/rtla/common_osnoise_description.rst
 create mode 100644 Documentation/tools/rtla/common_osnoise_options.rst
 create mode 100644 Documentation/tools/rtla/common_timerlat_description.rst
 create mode 100644 Documentation/tools/rtla/common_timerlat_options.rst
 create mode 100644 Documentation/tools/rtla/common_top_options.rst
 create mode 100644 Documentation/tools/rtla/rtla-osnoise-hist.rst
 create mode 100644 Documentation/tools/rtla/rtla-osnoise-top.rst
 create mode 100644 Documentation/tools/rtla/rtla-osnoise.rst
 create mode 100644 Documentation/tools/rtla/rtla-timerlat-hist.rst
 create mode 100644 Documentation/tools/rtla/rtla-timerlat-top.rst
 create mode 100644 Documentation/tools/rtla/rtla-timerlat.rst
 create mode 100644 Documentation/tools/rtla/rtla.rst
 create mode 100644 tools/tracing/rtla/Makefile
 create mode 100644 tools/tracing/rtla/README.txt
 create mode 100644 tools/tracing/rtla/src/osnoise.c
 create mode 100644 tools/tracing/rtla/src/osnoise.h
 create mode 100644 tools/tracing/rtla/src/osnoise_hist.c
 create mode 100644 tools/tracing/rtla/src/osnoise_top.c
 create mode 100644 tools/tracing/rtla/src/rtla.c
 create mode 100644 tools/tracing/rtla/src/timerlat.c
 create mode 100644 tools/tracing/rtla/src/timerlat.h
 create mode 100644 tools/tracing/rtla/src/timerlat_hist.c
 create mode 100644 tools/tracing/rtla/src/timerlat_top.c
 create mode 100644 tools/tracing/rtla/src/trace.c
 create mode 100644 tools/tracing/rtla/src/trace.h
 create mode 100644 tools/tracing/rtla/src/utils.c
 create mode 100644 tools/tracing/rtla/src/utils.h
