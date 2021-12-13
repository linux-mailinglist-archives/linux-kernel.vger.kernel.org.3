Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F96B473859
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244162AbhLMXW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbhLMXW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:22:28 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFC3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 15:22:28 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id d11so7210541pgl.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 15:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QFrmLrndzerdh9aU5SWF29/xqbEUateEGmk2RBUBTBo=;
        b=FfKWQQxMWmrLMGc1xlVK7YXtrd6SJfx9EZcMs+1++jCYXds9ioGVAUs/70yrjghBYc
         eL2fqc1nn8M3t+Z0jvI5YICbOEBBpIX4fFyFmRxlxt+bTPs93si4L9fpYB8tWMUZpXle
         u99buoBtPY0rdMGtBkQDvudw6xLoPgMLSqPqGD/0KvXCXcPV695lNCkyPKB3kcP3xlqT
         QnYwiWtA0d3qMXqnpPSUVJH394GHiaQLdKfBoE3y3t5I8Q4LeOEbH0+HLlxpFPV4OOw/
         2fRwswmBLXaVQL8lc0ghrh1jCA1wBNH7GHk/QImGYjXoRLR1VfohhYKfoLF63xVC5Ze0
         BnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QFrmLrndzerdh9aU5SWF29/xqbEUateEGmk2RBUBTBo=;
        b=1ilUG0pkpWwRYR8dcwDYHF/lofYrgYfa1gHEMHbKcU7wNX8qZjuthijLf4wlO8Hxky
         PHyD2NuH8YuVLwfY2ba9KBFADbnIRpJfRJcPnuf1sz+HINw+A6KS0jo0mwZfj9aAbL90
         56leWwKzq3h0pTxrFeG7UQdfvTXhnFqny5SMX4vSF8XWdcB6eM2tfFB7s8OdyW0ttKFe
         XsLq3pNsdKEyDaPntbluGBTOhXCNhTBvpPNZkxvzSJDgY91UXo51eRM2vuXSlMcQvplJ
         YVHunSZgSjOzC32jJTF4Dfura1oy69r2G07adv5V+alaiHYAfIdnxJntmT8vaqg1uatr
         kqDw==
X-Gm-Message-State: AOAM533OwwaeBPv+HsXy39ww6e2UwEIgMBsBP1KOajtBx71oV4j2TfZZ
        OHgS2UgxUgOvQPF3UFDjrpA=
X-Google-Smtp-Source: ABdhPJxpyDUcsk7GbWFrFqcGYXAgS8+X+GtmI3hzmkz1DqyLDvyi5t42rRKo+7Min/RJ/Gxhc8o4Og==
X-Received: by 2002:a63:cd49:: with SMTP id a9mr1173933pgj.607.1639437747806;
        Mon, 13 Dec 2021 15:22:27 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:dbb:6986:346d:4122])
        by smtp.gmail.com with ESMTPSA id t3sm14371491pfg.94.2021.12.13.15.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 15:22:27 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Marco Elver <elver@google.com>
Subject: [PATCH v3] perf/core: Fix cgroup event list management
Date:   Mon, 13 Dec 2021 15:22:24 -0800
Message-Id: <20211213232224.2023465-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The active cgroup events are managed in the per-cpu cgrp_cpuctx_list.
This list is only accessed from current cpu and not protected by any
locks.  But from the commit ef54c1a476ae ("perf: Rework
perf_event_exit_event()"), it's possible to access (actually modify)
the list from another cpu.

In the perf_remove_from_context(), it can remove an event from the
context without an IPI when the context is not active.  This is not
safe with cgroup events which can have some active events in the
context even if ctx->is_active is 0 at the moment.  The target cpu
might be in the middle of list iteration at the same time.

If the event is enabled when it's about to be closed, it might call
perf_cgroup_event_disable() and list_del() with the cgrp_cpuctx_list
on a different cpu.

This resulted in a crash due to an invalid list pointer access during
the cgroup list traversal on the cpu which the event belongs to.

Let's fallback to IPI to access the cgrp_cpuctx_list from that cpu.
Similarly, perf_install_in_context() should use IPI for the cgroup
events too.

Cc: Marco Elver <elver@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 30d94f68c5bd..f4754e93d4ee 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2388,7 +2388,11 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
 	 * event_function_call() user.
 	 */
 	raw_spin_lock_irq(&ctx->lock);
-	if (!ctx->is_active) {
+	/*
+	 * Cgroup events are per-cpu events, and must IPI because of
+	 * cgrp_cpuctx_list.
+	 */
+	if (!ctx->is_active && !is_cgroup_event(event)) {
 		__perf_remove_from_context(event, __get_cpu_context(ctx),
 					   ctx, (void *)flags);
 		raw_spin_unlock_irq(&ctx->lock);
@@ -2857,11 +2861,14 @@ perf_install_in_context(struct perf_event_context *ctx,
 	 * perf_event_attr::disabled events will not run and can be initialized
 	 * without IPI. Except when this is the first event for the context, in
 	 * that case we need the magic of the IPI to set ctx->is_active.
+	 * Similarly, cgroup events for the context also needs the IPI to
+	 * manipulate the cgrp_cpuctx_list.
 	 *
 	 * The IOC_ENABLE that is sure to follow the creation of a disabled
 	 * event will issue the IPI and reprogram the hardware.
 	 */
-	if (__perf_effective_state(event) == PERF_EVENT_STATE_OFF && ctx->nr_events) {
+	if (__perf_effective_state(event) == PERF_EVENT_STATE_OFF &&
+	    ctx->nr_events && !is_cgroup_event(event)) {
 		raw_spin_lock_irq(&ctx->lock);
 		if (ctx->task == TASK_TOMBSTONE) {
 			raw_spin_unlock_irq(&ctx->lock);

base-commit: 73743c3b092277febbf69b250ce8ebbca0525aa2
-- 
2.34.1.173.g76aa8bc2d0-goog

