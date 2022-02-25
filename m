Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007904C4B68
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbiBYQx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243152AbiBYQwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:52:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFD31AF16
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:52:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F216961CE5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAC3C340F1;
        Fri, 25 Feb 2022 16:52:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nNdpK-00B8Hy-6o;
        Fri, 25 Feb 2022 11:52:18 -0500
Message-ID: <20220225165151.824659113@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 25 Feb 2022 11:51:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 00/13] tracing: Updates for 5.17-rc
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tracing fixes for 5.17:

 - rtla (Real-Time Linux Analysis tool): fix typo in man page

 - rtla: Update API -e to -E before it is released

 - rlla: Error message fix and memory leak fix

 - Partially unline trace event soft disable to shrink text

 - Fix function graph start up test

 - Have triggers affect the trace instance they are in and not top level

 - Have osnoise sleep in the units it says it uses

 - Remove unused ftrace stub function

 - Remove event probe reduntant info from event in the buffer

 - Fix group ownership setting in tracefs

 - Ensure trace buffer is minimum size to prevent crashes

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/urgent

Head SHA1: f4b8715634f04fa03e730f1493ee919b56468de8


Arnaldo Carvalho de Melo (1):
      rtla: Fix systme -> system typo on man page

Christophe Leroy (2):
      tracing: Uninline trace_trigger_soft_disabled() partly
      tracing: Fix selftest config check for function graph start up test

Daniel Bristot de Oliveira (5):
      tracing: Dump stacktrace trigger to the corresponding instance
      tracing/osnoise: Make osnoise_main to sleep for microseconds
      rtla/hist: Make -E the short version of --entries
      rtla/osnoise: Free params at the exit
      rtla/osnoise: Fix error message when failing to enable trace instance

Nathan Chancellor (1):
      ftrace: Remove unused ftrace_startup_enable() stub

Steven Rostedt (Google) (3):
      tracing: Have traceon and traceoff trigger honor the instance
      eprobes: Remove redundant event type information
      tracefs: Set the group ownership in apply_options() not parse_options()

Sven Schnelle (1):
      tracing: Ensure trace buffer is at least 4096 bytes large

----
 Documentation/tools/rtla/common_hist_options.rst   |  2 +-
 .../tools/rtla/common_osnoise_description.rst      |  2 +-
 Documentation/tools/rtla/rtla-osnoise-hist.rst     |  2 +-
 fs/tracefs/inode.c                                 |  4 +-
 include/linux/trace_events.h                       | 22 ++++---
 kernel/trace/ftrace.c                              |  1 -
 kernel/trace/trace.c                               | 10 +--
 kernel/trace/trace.h                               |  1 -
 kernel/trace/trace_eprobe.c                        | 16 +++--
 kernel/trace/trace_events_trigger.c                | 73 +++++++++++++++++++---
 kernel/trace/trace_osnoise.c                       | 53 +++++++++-------
 kernel/trace/trace_probe.c                         | 10 +--
 kernel/trace/trace_probe.h                         |  1 -
 kernel/trace/trace_selftest.c                      |  6 +-
 tools/tracing/rtla/src/osnoise.c                   |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c              | 10 +--
 tools/tracing/rtla/src/osnoise_top.c               |  1 +
 tools/tracing/rtla/src/timerlat_hist.c             | 10 +--
 18 files changed, 148 insertions(+), 78 deletions(-)
