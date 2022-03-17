Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF0C4DC9DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiCQP11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbiCQP0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:26:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57543205BEE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:25:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A481CB80682
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5322EC340E9;
        Thu, 17 Mar 2022 15:25:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nUs09-004zcM-Sh;
        Thu, 17 Mar 2022 11:25:21 -0400
Message-ID: <20220317152458.213689956@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 17 Mar 2022 11:24:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/13] tracing: Updates for 5.18
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next-core

Head SHA1: 03cd03b5c3f9836e625a99fa603b4683dc1ebb47


Beau Belgrave (1):
      user_events: Add trace event call as root for low permission cases

Jiri Olsa (1):
      ftrace: Add ftrace_set_filter_ips function

Masami Hiramatsu (11):
      fprobe: Add ftrace based probe APIs
      rethook: Add a generic return hook
      rethook: x86: Add rethook x86 implementation
      arm64: rethook: Add arm64 rethook implementation
      powerpc: Add rethook support
      ARM: rethook: Add rethook arm implementation
      fprobe: Add exit_handler support
      fprobe: Add sample program for fprobe
      fprobe: Introduce FPROBE_FL_KPROBE_SHARED flag for fprobe
      docs: fprobe: Add fprobe description to ftrace-use.rst
      fprobe: Add a selftest for fprobe

----
 Documentation/trace/fprobe.rst                | 173 ++++++++++++++
 Documentation/trace/index.rst                 |   1 +
 arch/arm/Kconfig                              |   1 +
 arch/arm/include/asm/stacktrace.h             |   4 +-
 arch/arm/kernel/stacktrace.c                  |   6 +
 arch/arm/probes/Makefile                      |   1 +
 arch/arm/probes/rethook.c                     | 103 ++++++++
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/include/asm/stacktrace.h           |   2 +-
 arch/arm64/kernel/probes/Makefile             |   1 +
 arch/arm64/kernel/probes/rethook.c            |  25 ++
 arch/arm64/kernel/probes/rethook_trampoline.S |  87 +++++++
 arch/arm64/kernel/stacktrace.c                |   7 +-
 arch/powerpc/Kconfig                          |   1 +
 arch/powerpc/kernel/Makefile                  |   1 +
 arch/powerpc/kernel/rethook.c                 |  72 ++++++
 arch/x86/Kconfig                              |   1 +
 arch/x86/include/asm/unwind.h                 |   8 +-
 arch/x86/kernel/Makefile                      |   1 +
 arch/x86/kernel/kprobes/common.h              |   1 +
 arch/x86/kernel/rethook.c                     | 119 +++++++++
 include/linux/fprobe.h                        | 105 ++++++++
 include/linux/ftrace.h                        |   3 +
 include/linux/kprobes.h                       |   3 +
 include/linux/rethook.h                       |  99 ++++++++
 include/linux/sched.h                         |   3 +
 kernel/exit.c                                 |   2 +
 kernel/fork.c                                 |   3 +
 kernel/trace/Kconfig                          |  26 ++
 kernel/trace/Makefile                         |   2 +
 kernel/trace/fprobe.c                         | 332 ++++++++++++++++++++++++++
 kernel/trace/ftrace.c                         |  58 ++++-
 kernel/trace/rethook.c                        | 317 ++++++++++++++++++++++++
 kernel/trace/trace_events_user.c              |  39 ++-
 lib/Kconfig.debug                             |  12 +
 lib/Makefile                                  |   2 +
 lib/test_fprobe.c                             | 174 ++++++++++++++
 samples/Kconfig                               |   7 +
 samples/Makefile                              |   1 +
 samples/fprobe/Makefile                       |   3 +
 samples/fprobe/fprobe_example.c               | 120 ++++++++++
 41 files changed, 1911 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/trace/fprobe.rst
 create mode 100644 arch/arm/probes/rethook.c
 create mode 100644 arch/arm64/kernel/probes/rethook.c
 create mode 100644 arch/arm64/kernel/probes/rethook_trampoline.S
 create mode 100644 arch/powerpc/kernel/rethook.c
 create mode 100644 arch/x86/kernel/rethook.c
 create mode 100644 include/linux/fprobe.h
 create mode 100644 include/linux/rethook.h
 create mode 100644 kernel/trace/fprobe.c
 create mode 100644 kernel/trace/rethook.c
 create mode 100644 lib/test_fprobe.c
 create mode 100644 samples/fprobe/Makefile
 create mode 100644 samples/fprobe/fprobe_example.c
