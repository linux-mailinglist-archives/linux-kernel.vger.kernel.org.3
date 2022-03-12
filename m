Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853FC4D7184
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 00:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiCLX1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 18:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiCLX1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 18:27:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6172B931AB
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 15:25:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EFA2B80B06
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 23:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34501C340EB;
        Sat, 12 Mar 2022 23:25:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nTB7O-000WcP-18;
        Sat, 12 Mar 2022 18:25:50 -0500
Message-ID: <20220312232525.234705244@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 12 Mar 2022 18:25:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/12] tracing: Updates for v5.18
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: bc47ee4844d6b7d7351536cd99d35848c4449689


Beau Belgrave (2):
      user_events: Fix potential uninitialized pointer while parsing field
      user_events: Prevent dyn_event delete racing with ioctl add/delete

Steven Rostedt (Google) (9):
      tracing: Fix allocation of last_cmd in last_cmd_set()
      tracing: Fix last_cmd_set() string management in histogram code
      tracing: Allow custom events to be added to the tracefs directory
      tracing: Add sample code for custom trace events
      tracing: Move the defines to create TRACE_EVENTS into their own files
      tracing: Add TRACE_CUSTOM_EVENT() macro
      tracing: Have TRACE_DEFINE_ENUM affect trace event types as well
      tracing: Add snapshot at end of kernel boot up
      tracing/user_events: Use alloc_pages instead of kzalloc() for register pages

Tom Zanussi (1):
      tracing: Fix strncpy warning in trace_events_synth.c

----
 Documentation/admin-guide/kernel-parameters.txt |   8 +
 include/linux/ftrace.h                          |  11 +-
 include/linux/trace_events.h                    |  24 +-
 include/trace/define_custom_trace.h             |  77 ++++
 include/trace/stages/init.h                     |  37 ++
 include/trace/stages/stage1_defines.h           |  45 +++
 include/trace/stages/stage2_defines.h           |  48 +++
 include/trace/stages/stage3_defines.h           | 129 ++++++
 include/trace/stages/stage4_defines.h           |  57 +++
 include/trace/stages/stage5_defines.h           |  83 ++++
 include/trace/stages/stage6_defines.h           |  86 ++++
 include/trace/stages/stage7_defines.h           |  34 ++
 include/trace/trace_custom_events.h             | 221 +++++++++++
 include/trace/trace_events.h                    | 499 +-----------------------
 kernel/trace/ftrace.c                           |   2 +
 kernel/trace/trace.c                            |  18 +
 kernel/trace/trace_events.c                     |  30 ++
 kernel/trace/trace_events_hist.c                |   9 +-
 kernel/trace/trace_events_synth.c               |   5 +-
 kernel/trace/trace_events_user.c                |  64 ++-
 samples/Kconfig                                 |   8 +-
 samples/Makefile                                |   1 +
 samples/trace_events/Makefile                   |   2 +
 samples/trace_events/trace_custom_sched.c       |  60 +++
 samples/trace_events/trace_custom_sched.h       |  95 +++++
 25 files changed, 1139 insertions(+), 514 deletions(-)
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
 create mode 100644 samples/trace_events/trace_custom_sched.c
 create mode 100644 samples/trace_events/trace_custom_sched.h
