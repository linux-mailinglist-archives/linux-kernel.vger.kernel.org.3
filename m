Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0053859B0FD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 02:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiHUAIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 20:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiHUAId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 20:08:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA531146F
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 17:08:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81F1C60C54
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 00:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E523AC433D6;
        Sun, 21 Aug 2022 00:08:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oPYWC-005DjI-1a;
        Sat, 20 Aug 2022 20:08:44 -0400
Message-ID: <20220821000737.328590235@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 20 Aug 2022 20:07:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 00/10] tracing: Fixes for 6.0
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Various fixes for tracing:

 - Suppress the errors that is_signed_type() causes static analysis tools

 - Fix a return value of traceprobe_parse_event_name()

 - Fix NULL pointer dereference from failed ftrace enabling

 - Fix NULL pointer dereference by asking for registers from eprobes

 - Make eprobes consistent with kprobes/uprobes, filters and histograms

Bart Van Assche (1):
      tracing: Suppress sparse warnings triggered by is_signed_type()

Lukas Bulwahn (1):
      tracing: React to error return from traceprobe_parse_event_name()

Steven Rostedt (Google) (7):
      tracing/perf: Fix double put of trace event when init fails
      tracing/eprobes: Do not allow eprobes to use $stack, or % for regs
      tracing/eprobes: Do not hardcode $comm as a string
      tracing/eprobes: Fix reading of string fields
      tracing/eprobes: Have event probes be consistent with kprobes and uprobes
      tracing/probes: Have kprobes and uprobes use $COMM too
      tracing: Have filter accept "common_cpu" to be consistent

Yang Jihong (1):
      ftrace: Fix NULL pointer dereference in is_ftrace_trampoline when ftrace is dead

----
 include/linux/trace_events.h    | 12 ++++++
 kernel/trace/ftrace.c           | 10 +++++
 kernel/trace/trace_eprobe.c     | 93 +++++++++++++++++++++++++++++++++++++----
 kernel/trace/trace_event_perf.c |  7 ++--
 kernel/trace/trace_events.c     |  1 +
 kernel/trace/trace_probe.c      | 29 ++++++++-----
 6 files changed, 131 insertions(+), 21 deletions(-)
