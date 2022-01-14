Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4E648EF2A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243832AbiANRU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiANRUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:20:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9F7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 09:20:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3979B829D4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 17:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E96C36AE9;
        Fri, 14 Jan 2022 17:20:49 +0000 (UTC)
Date:   Fri, 14 Jan 2022 12:20:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Colin Ian King <colin.i.king@googlemail.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>,
        Jiri Olsa <jolsa@redhat.com>, John Keeping <john@metanate.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>,
        Qiujun Huang <hqjagain@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Xiangyang Zhang <xyz.sun.ok@gmail.com>,
        Xiaoke Wang <xkernel.wang@foxmail.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Yinan Liu <yinan@linux.alibaba.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Updates for 5.17
Message-ID: <20220114122047.061a16e6@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Note, I'm just recovering from COVID. I started getting sick on Monday, and
was pretty much bedridden from Tuesday through Thursday, although last
night I was able to start sorting out my pull request and found a few
issues I had to clean up. But it should be good to go. Sorry for the delay.

Tracing updates for 5.17:

New:

- The Real Time Linux Analysis (RTLA) tool is added to the tools directory.

- Can safely filter on user space pointers with: field.ustring ~ "match-string"

- eprobes can now be filtered like any other event.

- trace_marker(_raw) now uses stream_open() to allow multiple threads to safely
  write to it. Note, this could possibly break existing user space, but we will
  not know until we hear about it, and then can revert the change if need be.

- New field in events to display when bottom halfs are disabled.

- Sorting of the ftrace functions are now done at compile time instead of
  at bootup.

Infrastructure changes to support future efforts:

- Added __rel_loc type for trace events. Similar to __data_loc but the offset
  to the dynamic data is based off of the location of the descriptor and not
  the beginning of the event. Needed for user defined events.

- Some simplification of event trigger code.

- Make synthetic events process its callback better to not hinder other
  event callbacks that are registered. Needed for user defined events.

And other small fixes and clean ups.



Please pull the latest trace-v5.17 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.17

Tag SHA1: 9a38345e8252c9fba23c5ec173fd086ee9fd7c65
Head SHA1: f37c3bbc635994eda203a6da4ba0f9d05165a8d6


Beau Belgrave (1):
      tracing: Do not let synth_events block other dyn_event systems during create

Colin Ian King (1):
      tracing: Fix spelling mistake "aritmethic" -> "arithmetic"

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

Jiri Olsa (1):
      tracing: Iterate trace_[ku]probe objects directly

John Keeping (1):
      tracing: Make trace_marker{,_raw} stream-like

Masami Hiramatsu (5):
      tracing: Support __rel_loc relative dynamic data location attribute
      tracing: Add '__rel_loc' using trace event macros
      samples/trace_event: Add '__rel_loc' using sample event
      libtraceevent: Add __rel_loc relative location attribute support
      tools/perf: Add '__rel_loc' event field parsing support

Nikita Yushchenko (1):
      tracing/osnoise: Properly unhook events if start_per_cpu_kthreads() fails

Qiujun Huang (1):
      tracing: Fix synth_event_add_val() kernel-doc comment

Sebastian Andrzej Siewior (1):
      tracing: Account bottom half disabled sections.

Steven Rostedt (3):
      tracing: Have syscall trace events use trace_event_buffer_lock_reserve()
      tracing: Add test for user space strings when filtering on string pointers
      tracing: Add ustring operation to filtering string pointers

Steven Rostedt (VMware) (8):
      tracing: Use __this_cpu_read() in trace_event_buffer_lock_reserver()
      tracing: Disable preemption when using the filter buffer
      tracing: Have eprobes use filtering logic of trace events
      tracing/kprobes: Do not open code event reserve logic
      tracing/uprobes: Use trace_event_buffer_reserve() helper
      tracefs: Use d_inode() helper function to get the dentry inode
      tracing: Use trace_iterator_reset() in tracing_read_pipe()
      ftrace: Add test to make sure compiled time sorts work

Tom Zanussi (4):
      tracing: Change event_command func() to parse()
      tracing: Change event_trigger_ops func() to trigger()
      tracing: Remove ops param from event_command reg()/unreg() callbacks
      tracing: Add helper functions to simplify event_command.parse() callback handling

Uladzislau Rezki (Sony) (1):
      tracing: Switch to kvfree_rcu() API

Xiangyang Zhang (1):
      tracing/kprobes: 'nmissed' not showed correctly for kretprobe

Xiaoke Wang (2):
      tracing/uprobes: Check the return value of kstrdup() for tu->filename
      tracing/probes: check the return value of kstrndup() for pbuf

Xiu Jianfeng (1):
      tracing: Use memset_startat helper in trace_iterator_reset()

Yinan Liu (2):
      script/sorttable: Code style improvements
      scripts: ftrace - move the sort-processing in ftrace_init

Yuntao Wang (1):
      tracing: Remove duplicate warnings when calling trace_create_file()

----
 Documentation/tools/rtla/Makefile                  |  41 +
 Documentation/tools/rtla/common_appendix.rst       |  12 +
 Documentation/tools/rtla/common_hist_options.rst   |  23 +
 Documentation/tools/rtla/common_options.rst        |  28 +
 .../tools/rtla/common_osnoise_description.rst      |   8 +
 .../tools/rtla/common_osnoise_options.rst          |  17 +
 .../tools/rtla/common_timerlat_description.rst     |  10 +
 .../tools/rtla/common_timerlat_options.rst         |  16 +
 Documentation/tools/rtla/common_top_options.rst    |   3 +
 Documentation/tools/rtla/rtla-osnoise-hist.rst     |  66 ++
 Documentation/tools/rtla/rtla-osnoise-top.rst      |  61 ++
 Documentation/tools/rtla/rtla-osnoise.rst          |  59 ++
 Documentation/tools/rtla/rtla-timerlat-hist.rst    | 106 +++
 Documentation/tools/rtla/rtla-timerlat-top.rst     | 145 ++++
 Documentation/tools/rtla/rtla-timerlat.rst         |  57 ++
 Documentation/tools/rtla/rtla.rst                  |  48 ++
 Documentation/trace/events.rst                     |  19 +
 fs/tracefs/inode.c                                 |  24 +-
 include/linux/trace_events.h                       |   2 +
 include/trace/bpf_probe.h                          |  16 +
 include/trace/perf.h                               |  16 +
 include/trace/trace_events.h                       | 120 ++-
 kernel/trace/Kconfig                               |  14 +
 kernel/trace/ftrace.c                              |  34 +-
 kernel/trace/trace.c                               |  88 ++-
 kernel/trace/trace.h                               |  83 +-
 kernel/trace/trace_eprobe.c                        |  38 +-
 kernel/trace/trace_events.c                        |  12 +-
 kernel/trace/trace_events_filter.c                 | 139 +++-
 kernel/trace/trace_events_hist.c                   |  69 +-
 kernel/trace/trace_events_inject.c                 |  11 +-
 kernel/trace/trace_events_synth.c                  |  15 +-
 kernel/trace/trace_events_trigger.c                | 424 +++++++++-
 kernel/trace/trace_kprobe.c                        |  43 +-
 kernel/trace/trace_osnoise.c                       |  23 +-
 kernel/trace/trace_output.c                        |   4 +
 kernel/trace/trace_probe.c                         |   5 +-
 kernel/trace/trace_syscalls.c                      |   6 +-
 kernel/trace/trace_uprobe.c                        |  39 +-
 samples/trace_events/trace-events-sample.c         |   3 +
 samples/trace_events/trace-events-sample.h         |  35 +-
 scripts/Makefile                                   |   6 +-
 scripts/link-vmlinux.sh                            |   6 +-
 scripts/sorttable.c                                |   2 +
 scripts/sorttable.h                                | 124 ++-
 tools/lib/traceevent/event-parse.c                 |  59 +-
 tools/lib/traceevent/event-parse.h                 |   5 +-
 tools/lib/traceevent/parse-filter.c                |   5 +-
 tools/perf/builtin-trace.c                         |   2 +
 tools/perf/util/data-convert-bt.c                  |   2 +
 tools/perf/util/evsel.c                            |   2 +
 tools/perf/util/python.c                           |   2 +
 .../perf/util/scripting-engines/trace-event-perl.c |   2 +
 .../util/scripting-engines/trace-event-python.c    |   2 +
 tools/perf/util/sort.c                             |   2 +
 tools/tracing/rtla/Makefile                        | 102 +++
 tools/tracing/rtla/README.txt                      |  36 +
 tools/tracing/rtla/src/osnoise.c                   | 875 +++++++++++++++++++++
 tools/tracing/rtla/src/osnoise.h                   |  91 +++
 tools/tracing/rtla/src/osnoise_hist.c              | 801 +++++++++++++++++++
 tools/tracing/rtla/src/osnoise_top.c               | 579 ++++++++++++++
 tools/tracing/rtla/src/rtla.c                      |  87 ++
 tools/tracing/rtla/src/timerlat.c                  |  72 ++
 tools/tracing/rtla/src/timerlat.h                  |   4 +
 tools/tracing/rtla/src/timerlat_hist.c             | 822 +++++++++++++++++++
 tools/tracing/rtla/src/timerlat_top.c              | 618 +++++++++++++++
 tools/tracing/rtla/src/trace.c                     | 192 +++++
 tools/tracing/rtla/src/trace.h                     |  27 +
 tools/tracing/rtla/src/utils.c                     | 433 ++++++++++
 tools/tracing/rtla/src/utils.h                     |  56 ++
 70 files changed, 6706 insertions(+), 292 deletions(-)
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
---------------------------
