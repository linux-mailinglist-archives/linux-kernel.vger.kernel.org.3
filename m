Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A6F5371CB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 18:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiE2Qqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 12:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiE2Qqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 12:46:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9189AC00
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 09:46:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 57253CE0DB5
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 16:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC053C385A9;
        Sun, 29 May 2022 16:46:15 +0000 (UTC)
Date:   Sun, 29 May 2022 12:46:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Congyu Liu <liu3101@purdue.edu>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Jeff Xie <xiehuan09@gmail.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Jun Miao <jun.miao@intel.com>,
        Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Li Huafei <lihuafei1@huawei.com>,
        Li kunyu <kunyu@nfschina.com>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Oscar Shiang <oscar0225@livemail.tw>,
        Song Liu <song@kernel.org>, Tom Rix <trix@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        liqiong <liqiong@nfschina.com>,
        sunliming <kelulanainsley@gmail.com>,
        sunliming <sunliming@kylinos.cn>
Subject: [GIT PULL] tracing: Updates for 5.19
Message-ID: <20220529124610.0c2b652e@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Note, this series is based off of one of Thomas's tip branches that
added the TAI clock. I have patches that depended on it.

Also, I apologize for being late. My day job got in the way of my
upstream work, and I pulled in a lot of patches just at the start of
the merge window and wanted to let it sit in linux-next for a few days.
But there's not much in this pull request that is concerning. The bulk
of it is clean ups and various fixes. And the other stuff isn't too invasive.

And to make matters worse, I'm doing this from Paris
 (Embedded / Kernel Recipes start tomorrow).

tracing updates for 5.19:

- The majority of the changes are for fixes and clean ups.

Noticeable changes:

- Rework trace event triggers code to be easier to interact with.

- Support for embedding bootconfig with the kernel (as suppose to having it
  embedded in initram). This is useful for embedded boards without initram
  disks.

- Speed up boot by parallelizing the creation of tracefs files.

- Allow absolute ring buffer timestamps handle timestamps that use more than
  59 bits.

- Added new tracing clock "TAI" (International Atomic Time)

- Have weak functions show up in available_filter_function list as:
   __ftrace_invalid_address___<invalid-offset>
  instead of using the name of the function before it.


Please pull the latest trace-v5.19 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.19

Tag SHA1: b66c571025d06f10c948ea09ca7fbfb8a95c29fe
Head SHA1: b39181f7c6907dc66ff937b74758671fa6ba430c


Ammar Faizi (2):
      tracing: Return -EINVAL if WARN_ON(!glob) triggered in event_hist_trigger_parse()
      tracing: Change `if (strlen(glob))` to `if (glob[0])`

Christophe Leroy (1):
      MAINTAINERS: Enlarge coverage of TRACING inside architectures

Congyu Liu (1):
      tracing: Disable kcov on trace_preemptirq.c

Daniel Bristot de Oliveira (3):
      tracing/timerlat: Notify IRQ new max latency only if stop tracing is set
      tracing/timerlat: Print stacktrace in the IRQ handler if needed
      tracing/timerlat: Do not wakeup the thread if the trace stops at the IRQ

Gautam Menghani (1):
      tracing: Initialize integer variable to prevent garbage return value

Guo Zhengkui (1):
      tracing: Use WARN instead of printk and WARN_ON

Jakob Koschel (4):
      tracing: Remove usage of list iterator after the loop body
      tracing: Remove usage of list iterator variable after the loop
      tracing: Replace usage of found with dedicated list iterator variable
      tracing: Remove check of list iterator against head past the loop body

Jeff Xie (1):
      tracing: Make tp_printk work on syscall tracepoints

Jiapeng Chong (1):
      tracing: Fix kernel-doc

Julia Lawall (1):
      ftrace: Fix typo in comment

Jun Miao (1):
      tracing: Fix sleeping function called from invalid context on RT kernel

Keita Suzuki (1):
      tracing: Fix potential double free in create_var_ref()

Kurt Kanzenbach (2):
      tracing: Introduce trace clock tai
      tracing: Add documentation for trace clock tai

Li Huafei (1):
      tracing: Reset the function filter after completing trampoline/graph selftest

Li kunyu (1):
      ftrace: Remove return value of ftrace_arch_modify_*()

Mark-PK Tsai (2):
      tracing: Avoid adding tracer option before update_tracer_options
      tracing: make tracer_init_tracefs initcall asynchronous

Masami Hiramatsu (5):
      bootconfig: Make the bootconfig.o as a normal object file
      bootconfig: Check the checksum before removing the bootconfig from initrd
      bootconfig: Support embedding a bootconfig file in kernel
      docs: bootconfig: Add how to embed the bootconfig into kernel
      kprobes: Fix build errors with CONFIG_KRETPROBES=n

Oscar Shiang (1):
      tracing: Fix inconsistent style of mini-HOWTO

Song Liu (1):
      ftrace: Clean up hash direct_functions on register failures

Steven Rostedt (Google) (4):
      ring-buffer: Have absolute time stamps handle large numbers
      ring-buffer: Have 32 bit time stamps use all 64 bits
      tracing: Have event format check not flag %p* on __get_dynamic_array()
      ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid adding weak function

Tom Rix (1):
      tracing: Cleanup double word in comment

Tom Zanussi (4):
      tracing: Remove logic for registering multiple event triggers at a time
      tracing: Remove redundant trigger_ops params
      tracing: Have existing event_command.parse() implementations use helpers
      tracing: Separate hist state updates from hist registration

Wan Jiabing (1):
      ring-buffer: Simplify if-if to if-else

Wonhyuk Yang (1):
      tracing: Fix return value of trace_pid_write()

Yang Li (1):
      tracing: Fix tracing_map_sort_entries() kernel-doc comment

Yuntao Wang (3):
      tracing: Use trace_create_file() to simplify creation of tracefs entries
      ftrace: Deal with error return code of the ftrace_process_locs() function
      tracing: Use strim() to remove whitespace instead of doing it manually

liqiong (2):
      tracing: Change "char *" string form to "char []"
      tracing: Cleanup code by removing init "char *name"

sunliming (4):
      tracing: Fix comments of create_filter()
      x86,tracing: Remove unused headers
      x86/traceponit: Fix comment about irq vector tracepoints
      tracing: Fix comments for event_trigger_separate_filter()

----
 Documentation/admin-guide/bootconfig.rst |  31 ++-
 Documentation/trace/ftrace.rst           |  12 ++
 Documentation/trace/timerlat-tracer.rst  |   5 +-
 MAINTAINERS                              |   5 +-
 arch/arm/kernel/ftrace.c                 |   6 +-
 arch/riscv/kernel/ftrace.c               |   6 +-
 arch/s390/kernel/ftrace.c                |   3 +-
 arch/x86/include/asm/ftrace.h            |   7 +
 arch/x86/kernel/ftrace.c                 |   6 +-
 arch/x86/kernel/tracepoint.c             |   6 -
 include/linux/bootconfig.h               |  10 +
 include/linux/ftrace.h                   |   4 +-
 include/linux/kprobes.h                  |   2 +-
 init/Kconfig                             |  21 +-
 init/main.c                              |  38 ++--
 kernel/kprobes.c                         | 144 +++++++-------
 kernel/trace/Makefile                    |   4 +
 kernel/trace/ftrace.c                    | 210 ++++++++++++++++----
 kernel/trace/pid_list.c                  |   4 +-
 kernel/trace/ring_buffer.c               |  81 ++++++--
 kernel/trace/trace.c                     |  72 ++++---
 kernel/trace/trace.h                     |  26 ++-
 kernel/trace/trace_boot.c                |   2 +-
 kernel/trace/trace_dynevent.c            |   9 +-
 kernel/trace/trace_eprobe.c              |  24 +--
 kernel/trace/trace_events.c              |  69 +++----
 kernel/trace/trace_events_filter.c       |   2 +-
 kernel/trace/trace_events_hist.c         | 191 +++++++++---------
 kernel/trace/trace_events_trigger.c      | 324 +++++++++++--------------------
 kernel/trace/trace_kprobe.c              |  15 +-
 kernel/trace/trace_osnoise.c             |  22 ++-
 kernel/trace/trace_output.c              |  25 ++-
 kernel/trace/trace_recursion_record.c    |   7 +-
 kernel/trace/trace_selftest.c            |   3 +
 kernel/trace/trace_syscalls.c            |  35 ++--
 kernel/trace/tracing_map.c               |   3 +-
 lib/.gitignore                           |   1 +
 lib/Makefile                             |  10 +-
 lib/bootconfig-data.S                    |  10 +
 lib/bootconfig.c                         |  13 ++
 40 files changed, 822 insertions(+), 646 deletions(-)
 create mode 100644 lib/bootconfig-data.S
---------------------------
