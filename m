Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C953849FDF3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350114AbiA1QXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350058AbiA1QXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:23:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A3FC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:23:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 133FA61F1D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694C2C340E6;
        Fri, 28 Jan 2022 16:23:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nDU2J-00ASxy-DF;
        Fri, 28 Jan 2022 11:23:43 -0500
Message-ID: <20220128161802.711119424@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 28 Jan 2022 11:18:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [for-linus][PATCH 00/10] tracing: Fixes for 5.17-rc1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracing fixes for 5.17-rc1:

 - Limit mcount build time sorting to only those archs that
   we know it works for.

 - Fix memory leak in error path of historgam setup

 - Fix and clean up rel_loc array out of bounds issue

 - tools/rtla documentation fixes

 - Fix issues with histogram logic

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/urgent

Head SHA1: 67ab5eb71b37b55f7c5522d080a1b42823351776


Kees Cook (1):
      tracing/perf: Avoid -Warray-bounds warning for __rel_loc macro

Masami Hiramatsu (1):
      tracing: Avoid -Warray-bounds warning for __rel_loc macro

Shuah Khan (2):
      rtla: Make doc build optional
      tools/tracing: Update Makefile to build rtla

Steven Rostedt (Google) (1):
      ftrace: Have architectures opt-in for mcount build time sorting

Tom Zanussi (4):
      tracing: Fix smatch warning for null glob in event_hist_trigger_parse()
      tracing: Fix smatch warning for do while check in event_hist_trigger_parse()
      tracing: Propagate is_signed to expression
      tracing: Don't inc err_log entry count if entry allocation fails

Xiaoke Wang (1):
      tracing/histogram: Fix a potential memory leak for kstrdup()

----
 arch/arm/Kconfig                 |  1 +
 arch/x86/Kconfig                 |  1 +
 include/trace/perf.h             |  5 +++--
 include/trace/trace_events.h     |  9 +++++----
 kernel/trace/Kconfig             |  8 +++++++-
 kernel/trace/trace.c             |  3 ++-
 kernel/trace/trace_events_hist.c | 10 ++++++++--
 scripts/Makefile                 |  2 +-
 tools/tracing/Makefile           | 18 ++++++++++++++----
 tools/tracing/rtla/Makefile      |  2 +-
 10 files changed, 43 insertions(+), 16 deletions(-)
