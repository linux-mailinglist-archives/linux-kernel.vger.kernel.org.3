Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CA5462AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbhK3Cqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbhK3Cqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:46:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B5EC061714
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:43:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AE3FB80D1E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA97AC53FCE;
        Tue, 30 Nov 2021 02:43:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mrt70-000RSP-Lg;
        Mon, 29 Nov 2021 21:43:18 -0500
Message-ID: <20211130023945.789683928@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 29 Nov 2021 21:39:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/5] tracing: Various updates
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Make trace_event_buffer_lock_reserver always disable preemption
   (it says it does but not always)

 - Have kprobes, uprobes and eprobes use
   trace_event_buffer_lock_reserver() functions.

Steven Rostedt (VMware) (5):
      tracing: Use __this_cpu_read() in trace_event_buffer_lock_reserver()
      tracing: Disable preemption when using the filter buffer
      tracing: Have eprobes use filtering logic of trace events
      tracing/kprobes: Do not open code event reserve logic
      tracing/uprobes: Use trace_event_buffer_reserve() helper

----
 kernel/trace/trace.c        | 59 +++++++++++++++++++++++++--------------------
 kernel/trace/trace.h        |  4 ++-
 kernel/trace/trace_eprobe.c | 16 ++++--------
 kernel/trace/trace_kprobe.c | 25 ++++++-------------
 kernel/trace/trace_uprobe.c | 10 +++-----
 5 files changed, 52 insertions(+), 62 deletions(-)
