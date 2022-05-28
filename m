Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6F9536A5A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 04:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbiE1CxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 22:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352962AbiE1Cwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:52:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0447D12E304
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 19:52:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C63AB82688
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D101BC385A9;
        Sat, 28 May 2022 02:52:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1numZM-000LJq-Qo;
        Fri, 27 May 2022 22:52:48 -0400
Message-ID: <20220528025028.850906216@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 27 May 2022 22:50:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/23] tracing: Last minute fixes and updates for 5.19
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, a lot of these changes were in my queue, I just haven't
tested them. But they are mostly fixes and clean ups. No real functional
features.

My tests on these have not completely finished, so I may have to rebase.
But since this is half way into the merge window, I want these in
linux-next for a little bit before sending my pull request.

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next-core

Head SHA1: 8e929948ac1f0bd2655b4776fbdc6b529f123350


Congyu Liu (1):
      tracing: Disable kcov on trace_preemptirq.c

Daniel Bristot de Oliveira (3):
      tracing/timerlat: Notify IRQ new max latency only if stop tracing is set
      tracing/timerlat: Print stacktrace in the IRQ handler if needed
      tracing/timerlat: Do not wakeup the thread if the trace stops at the IRQ

Gautam Menghani (1):
      tracing: Initialize integer variable to prevent garbage return value

Julia Lawall (1):
      ftrace: Fix typo in comment

Keita Suzuki (1):
      tracing: Fix potential double free in create_var_ref()

Li Huafei (1):
      tracing: Reset the function filter after completing trampoline/graph selftest

Li kunyu (1):
      ftrace: Remove return value of ftrace_arch_modify_*()

Masami Hiramatsu (1):
      kprobes: Fix build errors with CONFIG_KRETPROBES=n

Song Liu (1):
      ftrace: Clean up hash direct_functions on register failures

Steven Rostedt (Google) (2):
      tracing: Have event format check not flag %p* on __get_dynamic_array()
      ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid adding weak function

Wonhyuk Yang (1):
      tracing: Fix return value of trace_pid_write()

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
 Documentation/trace/timerlat-tracer.rst |   5 +-
 arch/arm/kernel/ftrace.c                |   6 +-
 arch/riscv/kernel/ftrace.c              |   6 +-
 arch/s390/kernel/ftrace.c               |   3 +-
 arch/x86/include/asm/ftrace.h           |   7 ++
 arch/x86/kernel/ftrace.c                |   6 +-
 arch/x86/kernel/tracepoint.c            |   6 --
 include/linux/ftrace.h                  |   4 +-
 include/linux/kprobes.h                 |   2 +-
 kernel/kprobes.c                        | 144 ++++++++++++-------------
 kernel/trace/Makefile                   |   4 +
 kernel/trace/ftrace.c                   | 186 +++++++++++++++++++++++++++-----
 kernel/trace/trace.c                    |  20 ++--
 kernel/trace/trace_boot.c               |   2 +-
 kernel/trace/trace_dynevent.c           |   9 +-
 kernel/trace/trace_events.c             |  42 +++-----
 kernel/trace/trace_events_filter.c      |   2 +-
 kernel/trace/trace_events_hist.c        |   5 +-
 kernel/trace/trace_events_trigger.c     |   8 +-
 kernel/trace/trace_kprobe.c             |  15 +--
 kernel/trace/trace_osnoise.c            |  22 +++-
 kernel/trace/trace_recursion_record.c   |   7 +-
 kernel/trace/trace_selftest.c           |   3 +
 23 files changed, 319 insertions(+), 195 deletions(-)
