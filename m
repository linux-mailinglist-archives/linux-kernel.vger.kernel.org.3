Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E278586091
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 21:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbiGaTFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 15:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237724AbiGaTEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 15:04:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA18EE0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 12:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D280B80DD0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03833C433D6;
        Sun, 31 Jul 2022 19:04:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oIEEp-007G1a-2v;
        Sun, 31 Jul 2022 15:04:31 -0400
Message-ID: <20220731190329.641602282@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 31 Jul 2022 15:03:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/21] tracing: Updates for 5.20
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel Bristot de Oliveira (16):
      rv: Add Runtime Verification (RV) interface
      rv: Add runtime reactors interface
      rv/include: Add helper functions for deterministic automata
      rv/include: Add deterministic automata monitor definition via C macros
      rv/include: Add instrumentation helper functions
      Documentation/rv: Add a basic documentation
      tools/rv: Add dot2c
      Documentation/rv: Add deterministic automaton documentation
      tools/rv: Add dot2k
      Documentation/rv: Add deterministic automata monitor synthesis documentation
      Documentation/rv: Add deterministic automata instrumentation documentation
      rv/monitor: Add the wip monitor skeleton created by dot2k
      rv/monitor: Add the wip monitor
      rv/monitor: Add the wwnr monitor
      rv/reactor: Add the printk reactor
      rv/reactor: Add the panic reactor

Steven Rostedt (Google) (5):
      USB: mtu3: tracing: Use the new __vstring() helper
      batman-adv: tracing: Use the new __vstring() helper
      tracing: Use a copy of the va_list for __assign_vstr()
      ftrace/x86: Add back ftrace_expected assignment
      tracing: Use a struct alignof to determine trace event field alignment

----
 Documentation/trace/index.rst                      |   1 +
 .../trace/rv/da_monitor_instrumentation.rst        | 171 +++++
 Documentation/trace/rv/da_monitor_synthesis.rst    | 147 ++++
 Documentation/trace/rv/deterministic_automata.rst  | 184 +++++
 Documentation/trace/rv/index.rst                   |  14 +
 Documentation/trace/rv/monitor_wip.rst             |  55 ++
 Documentation/trace/rv/monitor_wwnr.rst            |  45 ++
 Documentation/trace/rv/runtime-verification.rst    | 231 ++++++
 arch/x86/kernel/ftrace.c                           |   1 +
 drivers/usb/mtu3/mtu3_trace.h                      |   6 +-
 include/linux/rv.h                                 |  70 ++
 include/linux/sched.h                              |  11 +
 include/rv/automata.h                              |  75 ++
 include/rv/da_monitor.h                            | 544 ++++++++++++++
 include/rv/instrumentation.h                       |  29 +
 include/trace/events/rv.h                          | 142 ++++
 include/trace/stages/stage4_event_fields.h         |   8 +-
 include/trace/stages/stage6_event_callback.h       |   7 +-
 kernel/fork.c                                      |  14 +
 kernel/trace/Kconfig                               |   2 +
 kernel/trace/Makefile                              |   1 +
 kernel/trace/rv/Kconfig                            |  78 ++
 kernel/trace/rv/Makefile                           |   8 +
 kernel/trace/rv/monitors/wip/wip.c                 |  88 +++
 kernel/trace/rv/monitors/wip/wip.h                 |  46 ++
 kernel/trace/rv/monitors/wwnr/wwnr.c               |  87 +++
 kernel/trace/rv/monitors/wwnr/wwnr.h               |  46 ++
 kernel/trace/rv/reactor_panic.c                    |  43 ++
 kernel/trace/rv/reactor_printk.c                   |  42 ++
 kernel/trace/rv/rv.c                               | 799 +++++++++++++++++++++
 kernel/trace/rv/rv.h                               |  68 ++
 kernel/trace/rv/rv_reactors.c                      | 508 +++++++++++++
 kernel/trace/trace.c                               |   2 +
 kernel/trace/trace.h                               |   9 +
 net/batman-adv/trace.h                             |   9 +-
 tools/verification/dot2/Makefile                   |  26 +
 tools/verification/dot2/automata.py                | 174 +++++
 tools/verification/dot2/dot2c                      |  26 +
 tools/verification/dot2/dot2c.py                   | 254 +++++++
 tools/verification/dot2/dot2k                      |  47 ++
 tools/verification/dot2/dot2k.py                   | 177 +++++
 .../dot2/dot2k_templates/main_global.c             |  91 +++
 .../dot2/dot2k_templates/main_per_cpu.c            |  91 +++
 .../dot2/dot2k_templates/main_per_task.c           |  91 +++
 tools/verification/models/wip.dot                  |  16 +
 tools/verification/models/wwnr.dot                 |  16 +
 46 files changed, 4585 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/trace/rv/da_monitor_instrumentation.rst
 create mode 100644 Documentation/trace/rv/da_monitor_synthesis.rst
 create mode 100644 Documentation/trace/rv/deterministic_automata.rst
 create mode 100644 Documentation/trace/rv/index.rst
 create mode 100644 Documentation/trace/rv/monitor_wip.rst
 create mode 100644 Documentation/trace/rv/monitor_wwnr.rst
 create mode 100644 Documentation/trace/rv/runtime-verification.rst
 create mode 100644 include/linux/rv.h
 create mode 100644 include/rv/automata.h
 create mode 100644 include/rv/da_monitor.h
 create mode 100644 include/rv/instrumentation.h
 create mode 100644 include/trace/events/rv.h
 create mode 100644 kernel/trace/rv/Kconfig
 create mode 100644 kernel/trace/rv/Makefile
 create mode 100644 kernel/trace/rv/monitors/wip/wip.c
 create mode 100644 kernel/trace/rv/monitors/wip/wip.h
 create mode 100644 kernel/trace/rv/monitors/wwnr/wwnr.c
 create mode 100644 kernel/trace/rv/monitors/wwnr/wwnr.h
 create mode 100644 kernel/trace/rv/reactor_panic.c
 create mode 100644 kernel/trace/rv/reactor_printk.c
 create mode 100644 kernel/trace/rv/rv.c
 create mode 100644 kernel/trace/rv/rv.h
 create mode 100644 kernel/trace/rv/rv_reactors.c
 create mode 100644 tools/verification/dot2/Makefile
 create mode 100644 tools/verification/dot2/automata.py
 create mode 100644 tools/verification/dot2/dot2c
 create mode 100644 tools/verification/dot2/dot2c.py
 create mode 100644 tools/verification/dot2/dot2k
 create mode 100644 tools/verification/dot2/dot2k.py
 create mode 100644 tools/verification/dot2/dot2k_templates/main_global.c
 create mode 100644 tools/verification/dot2/dot2k_templates/main_per_cpu.c
 create mode 100644 tools/verification/dot2/dot2k_templates/main_per_task.c
 create mode 100644 tools/verification/models/wip.dot
 create mode 100644 tools/verification/models/wwnr.dot
