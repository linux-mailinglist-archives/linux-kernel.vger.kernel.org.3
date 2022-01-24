Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E732049997A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455480AbiAXVf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392305AbiAXUvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:51:02 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C5DC05430A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:58:14 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id w190so10888069pfw.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ccbVMq565aJHY14D23rObCZOomhJYVRFWJcYpQW3YiI=;
        b=L6aVelYoBwUsEMQV68jC/J8hXE+7yzpPLCsKpB0/qN2rx2fG2Vyn0VFdFA4oQnlPhq
         k1b72vnTeIBzP2HvL0IVkadDs7/xVHPcMpb7xAnV/x6F9atjMFugU69loAMK5qoUT0Bh
         VmWeXKxgsCUvUBl/yfDifMZGQGNVu7xkR6JqH0hjHwta7m2PIjDC3GI5oTca80MOOhJe
         93ml7bjoBC9r816N8kChpXXE+toVcyrSi+S96w9NJZerG3VisS3w8AWOuxi0bO7GcIdQ
         +cPYG3pPsg8bbebQaox1lRtedDVKQ+lKnZ4izwZxxwIsAUbyUX8R/vh0uQ4al4dgjGoD
         olsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ccbVMq565aJHY14D23rObCZOomhJYVRFWJcYpQW3YiI=;
        b=UvxWlo1A+q+/Uv+Al2y37FtBEI+JlFq86kuYe0Ealdgz10BxAflG3WMNCQeC6R06hZ
         d/LiJ1MSm1SbUSPezMXPrztCULVz6VsOVhxh102kxlLWSaRdyjO3uGohGsYU6MYSJYSb
         rmsuI9TXUZHk+rAhLdRXhs7OZqxDnAG4KH25On2pumSpYpwdlUFtypMWGyk95mSI2hIz
         pNtFJuXsCL7RdRyqqGn5CpevG+YJY4CAFQpxewimoY9fCdJfarkjZkBl0n58TLDdNWrI
         FZPXJHU7iaacYzlFURkD9eFuBGNIkk5/ZDLX4ZkcE+MabPObyVX+Kd9MtnCSNZpaioy3
         9yPQ==
X-Gm-Message-State: AOAM532c4Dn52wXrB0So1rfUP3EhL3UfHokaZGLIoopkM/ihnr9tU4/x
        M5RFyKZ7ckPc5b7yHj6+KKI=
X-Google-Smtp-Source: ABdhPJzsC0HFPKdb0Jx+CR+SjK0VUTDdt8giuxugqexI44AsXT4KObNAkzOV95Pk8MQgp31JIWu2Bg==
X-Received: by 2002:aa7:988b:0:b0:4c8:b982:d4fa with SMTP id r11-20020aa7988b000000b004c8b982d4famr7871751pfl.14.1643054293804;
        Mon, 24 Jan 2022 11:58:13 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:1baf:f671:4eb6:e10c])
        by smtp.gmail.com with ESMTPSA id j11sm141048pjf.53.2022.01.24.11.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:58:13 -0800 (PST)
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
Subject: [PATCH v4] perf/core: Fix cgroup event list management
Date:   Mon, 24 Jan 2022 11:58:08 -0800
Message-Id: <20220124195808.2252071-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
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

Fixes: ef54c1a476ae ("perf: Rework perf_event_exit_event()")
Cc: Marco Elver <elver@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
* rebased to tip/perf/urgent
* add Fixes tag

 kernel/events/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 479c9e672ec4..3ad549fdec3b 100644
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
-- 
2.35.0.rc0.227.g00780c9af4-goog

