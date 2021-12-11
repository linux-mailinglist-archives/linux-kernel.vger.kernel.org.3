Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CE3470F30
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 01:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244113AbhLKAKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 19:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237677AbhLKAKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 19:10:31 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA88CC061714
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 16:06:55 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p18so7283128plf.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 16:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mwvtcAs9c4jmcp1ZvbkbEf/bbuZRRXYok6y7Iov0DfQ=;
        b=F5NluEQnvqqPKyswd8my80EgcD67m7YRvf/Z9LohE8VrSxhsNDuqOVE40o1euf72jL
         l/jPFhhhx0aYrzIzi0gBIN45NH263PvFq/tyDoXJAVIhAz7neS3HpZC3GFNpgyfNQC5t
         FHVOO/l5tQmB5E2MgDghz7VH8kWlRW048ldTsPiMduSb/py0IkmusNLohr+nf23Y7YEE
         2UC86/g63KMbVHXQNZZ9rtxWZ5dtJOnk9Kg47Jp8FsZQl9YgRlvfwrZJb28yUkmZa6Jd
         CoS/UG1TAorxJeV69yPazfcCQlzQtS092aClUAO2j6Geb/c/4AOWXEBMuQuMDJj0Op4v
         3kyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=mwvtcAs9c4jmcp1ZvbkbEf/bbuZRRXYok6y7Iov0DfQ=;
        b=ysYCWTSkbu9249VEnG7O7s0IVlq3lCLFuakBbjAjy2Hl8TbyAXlmZPRBDwmWo5RhAC
         n7dlheQWueFMSIXupPX7xQEspZv1Z63TYmi4W3hcSfwd+0gWe4tixcLg46+ai1b1Iysx
         9vMkqKflQmEpTeDOhioKCkgZSezEw4bh58UdUhpWKwvchYJ9iC7Bvz7i59JVhKPVKZyh
         KsGxpp8BdHK5eCl+K9Bw2aCrjORVehGs5lAgoywSFuYse3dUkCUSvJtOibR0bvz4JZSz
         lvBEfK8mDJO4Acd3jTE0DJ1tGTH6IcEz/Rz52G8EEsPYm7lFvjfl4OWaSPoh91acXC0t
         EP0Q==
X-Gm-Message-State: AOAM531xyJkCCcaGibBse6epYsc+kRt6pcjA3R2NCIO6w9Hx/Qyujk1W
        4+1h46xI50pVC064ALOJeI0=
X-Google-Smtp-Source: ABdhPJxoDtE3BxP733bwVy3nAMEHl5XMwyEdqk8KeltkRCuLUJTLilQ1K9Qpq72o8aeCtVzH45QhcA==
X-Received: by 2002:a17:90b:1812:: with SMTP id lw18mr27908444pjb.196.1639181215114;
        Fri, 10 Dec 2021 16:06:55 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:db25:1c11:3359:7a32])
        by smtp.gmail.com with ESMTPSA id e11sm120952pjl.20.2021.12.10.16.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 16:06:54 -0800 (PST)
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
Subject: [PATCH] perf/core: Fix cgroup event list management
Date:   Fri, 10 Dec 2021 16:06:52 -0800
Message-Id: <20211211000652.1836690-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The active cgroup events are managed in the per-cpu cgrp_cpuctx_list.
This list is accessed from current cpu and not protected by any locks.
But from the commit ef54c1a476ae ("perf: Rework
perf_event_exit_event()"), this assumption does not hold true anymore.

In the perf_remove_from_context(), it can remove an event from the
context without an IPI when the context is not active.  I think it
assumes task event context, but it's possible for cpu event context
only with cgroup events can be inactive at the moment - and it might
become active soon.

If the event is enabled when it's about to be closed, it might call
perf_cgroup_event_disable() and list_del() with the cgrp_cpuctx_list
on a different cpu.

This resulted in a crash due to an invalid list pointer access during
the cgroup list traversal on the cpu which the event belongs to.

The following program can crash my box easily..

  #include <stdio.h>
  #include <fcntl.h>
  #include <unistd.h>
  #include <linux/perf_event.h>
  #include <sys/stat.h>
  #include <sys/syscall.h>

  //#define CGROUP_ROOT  "/dev/cgroup/devices"
  #define CGROUP_ROOT  "/sys/fs/cgroup"

  int perf_event_open(struct perf_event_attr *attr, int pid, int cpu,
                      int grp, unsigned long flags)
  {
    return syscall(SYS_perf_event_open, attr, pid, cpu, grp, flags);
  }

  int get_cgroup_fd(const char *grp)
  {
    char buf[128];

    snprintf(buf, sizeof(buf), "%s/%s", CGROUP_ROOT, grp);

    /* ignore failures */
    mkdir(buf, 0755);

    return open(buf, O_RDONLY);
  }

  int main(int argc, char *argv[])
  {
    struct perf_event_attr hw = {
      .type = PERF_TYPE_HARDWARE,
      .config = PERF_COUNT_HW_CPU_CYCLES,
    };
    struct perf_event_attr sw = {
      .type = PERF_TYPE_SOFTWARE,
      .config = PERF_COUNT_SW_CPU_CLOCK,
    };
    int cpus = sysconf(_SC_NPROCESSORS_ONLN);
    int fd[4][cpus];
    int cgrpA, cgrpB;

    cgrpA = get_cgroup_fd("A");
    cgrpB = get_cgroup_fd("B");
    if (cgrpA < 0 || cgrpB < 0) {
      printf("failed to get cgroup fd\n");
      return 1;
    }

    while (1) {
      int i;

      for (i = 0; i < cpus; i++) {
        fd[0][i] = perf_event_open(&hw, cgrpA, i, -1, PERF_FLAG_PID_CGROUP);
        fd[1][i] = perf_event_open(&sw, cgrpA, i, -1, PERF_FLAG_PID_CGROUP);
        fd[2][i] = perf_event_open(&hw, cgrpB, i, -1, PERF_FLAG_PID_CGROUP);
        fd[3][i] = perf_event_open(&sw, cgrpB, i, -1, PERF_FLAG_PID_CGROUP);
      }

      for (i = 0; i < cpus; i++) {
        close(fd[3][i]);
        close(fd[2][i]);
        close(fd[1][i]);
        close(fd[0][i]);
      }
    }
    return 0;
  }

Let's use IPI to prevent such crashes.

Similarly, I think perf_install_in_context() should use IPI for the
first cgroup event at least.

Cc: Marco Elver <elver@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 30d94f68c5bd..8ebb41ab2089 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2388,7 +2388,7 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
 	 * event_function_call() user.
 	 */
 	raw_spin_lock_irq(&ctx->lock);
-	if (!ctx->is_active) {
+	if (!ctx->is_active && (!is_cgroup_event(event) || ctx->nr_cgroups > 1)) {
 		__perf_remove_from_context(event, __get_cpu_context(ctx),
 					   ctx, (void *)flags);
 		raw_spin_unlock_irq(&ctx->lock);
@@ -2857,11 +2857,14 @@ perf_install_in_context(struct perf_event_context *ctx,
 	 * perf_event_attr::disabled events will not run and can be initialized
 	 * without IPI. Except when this is the first event for the context, in
 	 * that case we need the magic of the IPI to set ctx->is_active.
+	 * Similarly, the first cgroup event for the context also needs the IPI
+	 * to manipulate the cgrp_cpuctx_list.
 	 *
 	 * The IOC_ENABLE that is sure to follow the creation of a disabled
 	 * event will issue the IPI and reprogram the hardware.
 	 */
-	if (__perf_effective_state(event) == PERF_EVENT_STATE_OFF && ctx->nr_events) {
+	if (__perf_effective_state(event) == PERF_EVENT_STATE_OFF &&
+	    ctx->nr_events && (ctx->nr_cgroups || !is_cgroup_event(event))) {
 		raw_spin_lock_irq(&ctx->lock);
 		if (ctx->task == TASK_TOMBSTONE) {
 			raw_spin_unlock_irq(&ctx->lock);
-- 
2.34.1.173.g76aa8bc2d0-goog

