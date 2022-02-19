Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489CF4BC420
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbiBSAz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:55:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240716AbiBSAzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:55:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D281E279928
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:55:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81786B8275F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E76C340E9;
        Sat, 19 Feb 2022 00:55:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nLE1o-0051WB-Bo;
        Fri, 18 Feb 2022 19:55:12 -0500
Message-ID: <20220219005430.848118506@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 19:54:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/16] tracing: Updates for 5.18
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

Head SHA1: 864ea0e10cc90416a01b46f0d47a6f26dc020820


Beau Belgrave (12):
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

Steven Rostedt (Google) (1):
      tracing: Save both wakee and current on wakeup events

Tom Zanussi (3):
      tracing: Remove size restriction on tracing_log_err cmd strings
      tracing: Remove size restriction on hist trigger cmd error logging
      tracing: Remove size restriction on synthetic event cmd error logging

----
 Documentation/trace/index.rst                     |    1 +
 Documentation/trace/user_events.rst               |  216 +++
 include/uapi/linux/user_events.h                  |  116 ++
 kernel/trace/Kconfig                              |   14 +
 kernel/trace/Makefile                             |    1 +
 kernel/trace/trace.c                              |   55 +-
 kernel/trace/trace.h                              |    2 +-
 kernel/trace/trace_events_hist.c                  |   30 +-
 kernel/trace/trace_events_synth.c                 |   17 +-
 kernel/trace/trace_events_user.c                  | 1617 +++++++++++++++++++++
 kernel/trace/trace_sched_switch.c                 |    2 +-
 samples/user_events/Makefile                      |    5 +
 samples/user_events/example.c                     |   91 ++
 tools/testing/selftests/user_events/Makefile      |    9 +
 tools/testing/selftests/user_events/dyn_test.c    |  130 ++
 tools/testing/selftests/user_events/ftrace_test.c |  452 ++++++
 tools/testing/selftests/user_events/perf_test.c   |  168 +++
 tools/testing/selftests/user_events/settings      |    1 +
 18 files changed, 2902 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/trace/user_events.rst
 create mode 100644 include/uapi/linux/user_events.h
 create mode 100644 kernel/trace/trace_events_user.c
 create mode 100644 samples/user_events/Makefile
 create mode 100644 samples/user_events/example.c
 create mode 100644 tools/testing/selftests/user_events/Makefile
 create mode 100644 tools/testing/selftests/user_events/dyn_test.c
 create mode 100644 tools/testing/selftests/user_events/ftrace_test.c
 create mode 100644 tools/testing/selftests/user_events/perf_test.c
 create mode 100644 tools/testing/selftests/user_events/settings
