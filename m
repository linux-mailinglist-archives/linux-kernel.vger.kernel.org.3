Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AF149E197
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbiA0LuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiA0LuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:50:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC56C061714;
        Thu, 27 Jan 2022 03:50:15 -0800 (PST)
Date:   Thu, 27 Jan 2022 11:50:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643284213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uz3HSjIa9cRJSSIU4iaPkMhcTw6INU0OtISKFygmtwI=;
        b=lIBp1+ZZR4tv7ixPBbbMMCftaVl0qCa2s7+gvfD/fh3nTpP1xyYwlGAkulnb0H8HaGwV5k
        BIiuq7EB8PsAqrUz1lOfaHEvPdFiS6xYLlZsKzOG1KpojpztrHQMwbtqEDsUWlbmxwf1nL
        MhHeIxOnsDyFwWZz829jOjUI3OIp4D1WnZ7hy5ijI5zUKKEsQOeAU2G9rmvApSKwi+mSTW
        pruKxSm2TM5feFr9+d1vRKetOUkImAXoU8+gJ1+Ls2j21MNZ46PJ8Y5fH655kYc4UlaCxc
        BDTrOhV3MVopL9Ib7SWilDXLD6dO1DqEEo7aw5SAItLgtD57ZP8neoSAVtlddw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643284213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uz3HSjIa9cRJSSIU4iaPkMhcTw6INU0OtISKFygmtwI=;
        b=j6TeOcvfljAFSS6+xaP2lQEKj8665qWyYmpLAA8NsyaeJygB9To3j7LBov5R++0XOqn3QW
        pUVYsB8T6SALEfAQ==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix cgroup event list management
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220124195808.2252071-1-namhyung@kernel.org>
References: <20220124195808.2252071-1-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <164328421215.16921.8709898069420344232.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     c5de60cd622a2607c043ba65e25a6e9998a369f9
Gitweb:        https://git.kernel.org/tip/c5de60cd622a2607c043ba65e25a6e9998a369f9
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Mon, 24 Jan 2022 11:58:08 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Jan 2022 15:06:06 +01:00

perf/core: Fix cgroup event list management

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

Fixes: ef54c1a476ae ("perf: Rework perf_event_exit_event()")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220124195808.2252071-1-namhyung@kernel.org
---
 kernel/events/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b1c1928..76c754e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2462,7 +2462,11 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
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
@@ -2895,11 +2899,14 @@ perf_install_in_context(struct perf_event_context *ctx,
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
