Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6C14E2B51
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244407AbiCUO6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349688AbiCUO5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:57:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EDD340F6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A671060E15
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 14:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30771C340E8;
        Mon, 21 Mar 2022 14:56:23 +0000 (UTC)
Date:   Mon, 21 Mar 2022 10:56:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] tracing: Updates for 5.18
Message-ID: <20220321105621.3d4a9bc6@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HEXHASH_WORD,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,


** NOTE **

This has major conflicts with two other trees.

A restructure of include/trace caused a conflict with:

 The nfsd tree for commit:

  tracing: Introduce helpers to safely handle dynamic-sized sockaddrs

(currently it is commit d07c9ad622474616e94572e59e725c2c4a494fb4 in linux-next)

And the custom event sample relies on matching the prototype of
the sched_switch event that was changed by:

 The tip sched/core tree:

  sched/tracing: Don't re-read p->state when emitting sched_switch event

(currently is commit fa2c3254d7cfff5f7a916ab928a562d1165f17bb in linux-next)

Which does not conflict, but will cause the build to fail. Merging the two
trees requires the sample in samples/trace_events/trace_custom_sched.h to
match the prototype of the sched_switch event in include/trace/events/sched.h.

My tree has a branch called:

  trace-merge-next-20220315

That resolved both of the above issues.

For more details see the report of the issues mentioned above:

 https://lore.kernel.org/all/20220315145828.413e9301@canb.auug.org.au/



Tracing updates for 5.18:

- New user_events interface. User space can register an event with the kernel
  describing the format of the event. Then it will receive a byte in a page
  mapping that it can check against. A privileged task can then enable that
  event like any other event, which will change the mapped byte to true,
  telling the user space application to start writing the event to the
  tracing buffer.

- Add new "ftrace_boot_snapshot" kernel command line parameter. When set,
  the tracing buffer will be saved in the snapshot buffer at boot up when
  the kernel hands things over to user space. This will keep the traces that
  happened at boot up available even if user space boot up has tracing as
  well.

- Have TRACE_EVENT_ENUM() also update trace event field type descriptions.
  Thus if a static array defines its size with an enum, the user space trace
  event parsers can still know how to parse that array.

- Add new TRACE_CUSTOM_EVENT() macro. This acts the same as the
  TRACE_EVENT() macro, but will attach to an existing tracepoint. This will
  make one tracepoint be able to trace different content and not be stuck at
  only what the original TRACE_EVENT() macro exports.

- Fixes to tracing error logging.

- Better saving of cmdlines to PIDs when tracing (use the wakeup events for
  mapping).

Please pull the latest trace-v5.18 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.18

Tag SHA1: 61be4324105e5feff3de2eff421cbea80a8d490f
Head SHA1: 795301d3c28996219d555023ac6863401b6076bc


Beau Belgrave (15):
      user_events: Add minimal support for trace_event into ftrace
      user_events: Add print_fmt generation support for basic types
      user_events: Handle matching arguments from dyn_events
      user_events: Add basic perf and eBPF support
      user_events: Optimize writing events by only copying data once
      user_events: Validate user payloads for size and null termination
      user_events: Add self-test for ftrace integration
      user_events: Add self-test for dynamic_events integration
      user_events: Add self-test for perf_event integration
      user_events: Add self-test for validator boundaries
      user_events: Add sample code for typical usage
      user_events: Add documentation file
      user_events: Fix potential uninitialized pointer while parsing field
      user_events: Prevent dyn_event delete racing with ioctl add/delete
      user_events: Add trace event call as root for low permission cases

Steven Rostedt (Google) (11):
      tracing: Save both wakee and current on wakeup events
      tracing: Fix allocation of last_cmd in last_cmd_set()
      tracing: Fix last_cmd_set() string management in histogram code
      tracing: Allow custom events to be added to the tracefs directory
      tracing: Add sample code for custom trace events
      tracing: Move the defines to create TRACE_EVENTS into their own files
      tracing: Add TRACE_CUSTOM_EVENT() macro
      tracing: Have TRACE_DEFINE_ENUM affect trace event types as well
      tracing: Add snapshot at end of kernel boot up
      tracing/user_events: Use alloc_pages instead of kzalloc() for register pages
      tracing: Have type enum modifications copy the strings

Tom Zanussi (4):
      tracing: Remove size restriction on tracing_log_err cmd strings
      tracing: Remove size restriction on hist trigger cmd error logging
      tracing: Remove size restriction on synthetic event cmd error logging
      tracing: Fix strncpy warning in trace_events_synth.c

----
 Documentation/admin-guide/kernel-parameters.txt   |    8 +
 Documentation/trace/index.rst                     |    1 +
 Documentation/trace/user_events.rst               |  216 +++
 include/linux/ftrace.h                            |   11 +-
 include/linux/trace_events.h                      |   24 +-
 include/trace/define_custom_trace.h               |   77 +
 include/trace/stages/init.h                       |   37 +
 include/trace/stages/stage1_defines.h             |   45 +
 include/trace/stages/stage2_defines.h             |   48 +
 include/trace/stages/stage3_defines.h             |  129 ++
 include/trace/stages/stage4_defines.h             |   57 +
 include/trace/stages/stage5_defines.h             |   83 +
 include/trace/stages/stage6_defines.h             |   86 ++
 include/trace/stages/stage7_defines.h             |   34 +
 include/trace/trace_custom_events.h               |  221 +++
 include/trace/trace_events.h                      |  499 +-----
 include/uapi/linux/user_events.h                  |  116 ++
 kernel/trace/Kconfig                              |   14 +
 kernel/trace/Makefile                             |    1 +
 kernel/trace/ftrace.c                             |    2 +
 kernel/trace/trace.c                              |   73 +-
 kernel/trace/trace.h                              |    2 +-
 kernel/trace/trace_events.c                       |   90 ++
 kernel/trace/trace_events_hist.c                  |   33 +-
 kernel/trace/trace_events_synth.c                 |   14 +-
 kernel/trace/trace_events_user.c                  | 1690 +++++++++++++++++++++
 kernel/trace/trace_sched_switch.c                 |    2 +-
 samples/Kconfig                                   |    8 +-
 samples/Makefile                                  |    1 +
 samples/trace_events/Makefile                     |    2 +
 samples/trace_events/trace_custom_sched.c         |   60 +
 samples/trace_events/trace_custom_sched.h         |   95 ++
 samples/user_events/Makefile                      |    5 +
 samples/user_events/example.c                     |   91 ++
 tools/testing/selftests/user_events/Makefile      |    9 +
 tools/testing/selftests/user_events/dyn_test.c    |  130 ++
 tools/testing/selftests/user_events/ftrace_test.c |  452 ++++++
 tools/testing/selftests/user_events/perf_test.c   |  168 ++
 tools/testing/selftests/user_events/settings      |    1 +
 39 files changed, 4116 insertions(+), 519 deletions(-)
 create mode 100644 Documentation/trace/user_events.rst
 create mode 100644 include/trace/define_custom_trace.h
 create mode 100644 include/trace/stages/init.h
 create mode 100644 include/trace/stages/stage1_defines.h
 create mode 100644 include/trace/stages/stage2_defines.h
 create mode 100644 include/trace/stages/stage3_defines.h
 create mode 100644 include/trace/stages/stage4_defines.h
 create mode 100644 include/trace/stages/stage5_defines.h
 create mode 100644 include/trace/stages/stage6_defines.h
 create mode 100644 include/trace/stages/stage7_defines.h
 create mode 100644 include/trace/trace_custom_events.h
 create mode 100644 include/uapi/linux/user_events.h
 create mode 100644 kernel/trace/trace_events_user.c
 create mode 100644 samples/trace_events/trace_custom_sched.c
 create mode 100644 samples/trace_events/trace_custom_sched.h
 create mode 100644 samples/user_events/Makefile
 create mode 100644 samples/user_events/example.c
 create mode 100644 tools/testing/selftests/user_events/Makefile
 create mode 100644 tools/testing/selftests/user_events/dyn_test.c
 create mode 100644 tools/testing/selftests/user_events/ftrace_test.c
 create mode 100644 tools/testing/selftests/user_events/perf_test.c
 create mode 100644 tools/testing/selftests/user_events/settings
---------------------------
