Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4581E472142
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 07:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhLMG7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 01:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhLMG7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 01:59:41 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E84AC06173F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 22:59:41 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q16so13706874pgq.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 22:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZjfaRxDW+LbC37hF7gyfGpLJvWLQW/7kDRsRcHSUrM=;
        b=VEeLpsyyJanyiSAAN9OKx6UVSbUsr5XseiND8grnRsC6cBJaT9L3lMZYziW28Sy6i/
         C3LNR9RCh+IDTma6mq1NbnmzlPjucrJzCi39nTSq6++oqkfGKkQZNdk8nr13bnUfOU2e
         PYg3C6eJ3MM2ykOCkF8aQlPVOGXlxSALswgPczysV6SA2oyKtVOSF129MIvwrdIMDV7V
         XWOplZ8FqjExT/X5A9PN+WDrUerfy8QvtWQeAkVAh0Xhhu/3EhYEKXXuJWICWh4gh3sg
         7JTJa3u5r/Ky1CTQo7sHRlGA2tFoMRX0X8pjLR9DvCxIJ1rhPx3R7I0wWluI1z2kpKcD
         4R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=jZjfaRxDW+LbC37hF7gyfGpLJvWLQW/7kDRsRcHSUrM=;
        b=HduVPnsP+nN3uxslepVvGFu1oBf7GGYDg9qdbq4IheETMksi/kQYrkBJOA2m2oApSx
         AVtt0XLF3yNVWCCDumLBJNZDDHvr4rQ3OocVEDAQUPvcXrfV53OGYjotK7P3BPpzn0KY
         OKgGiuxzZ+HwwMREJxWNYPUfrZ0Q1+Oh8nXIieVuVJTDqoa5JNjUbeD7SWDgwhfKMsOY
         xBKQp6ZMF87y4bfUV1tK9Sp9g8hs+jmRcWxqbqNF3TCLAAs6/lDHvva17IkWPXhmOVTB
         n6trr4qWs8sVT07eM8vYjIEOyE198okYc+zRkNiYNmxNUEvUuEGff4SH29Q7bjgDhEvo
         Xz+Q==
X-Gm-Message-State: AOAM531xSOGmzCPWIEMv1GOPZR5Ex9/1z4lpFQViY+KQQX6vkfE3rGD1
        KGrl7SB139i75KZKG9R2A+LJZdyWz0k=
X-Google-Smtp-Source: ABdhPJzT+C04WoJbrzt66uTLkoFUGQbQmv8BnFG0sCl6MPIQdKInvwOhzY0MhOE7uiL6RZWCr01C5w==
X-Received: by 2002:a05:6a00:2283:b0:49f:dea0:b9ba with SMTP id f3-20020a056a00228300b0049fdea0b9bamr31906636pfe.56.1639378780646;
        Sun, 12 Dec 2021 22:59:40 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:791f:f6fd:ec5b:b1f9])
        by smtp.gmail.com with ESMTPSA id d13sm10878659pfu.213.2021.12.12.22.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 22:59:40 -0800 (PST)
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
        Ian Rogers <irogers@google.com>,
        kernel test robot <lkp@intel.com>,
        Marco Elver <elver@google.com>
Subject: [PATCH v2] perf/core: Fix cgroup event list management
Date:   Sun, 12 Dec 2021 22:59:36 -0800
Message-Id: <20211213065936.1965081-1-namhyung@kernel.org>
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
cgroup events too.

Reported-by: kernel test robot <lkp@intel.com>  # for build error
Cc: Marco Elver <elver@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2) simply use IPI for cgroup events

 kernel/events/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 30d94f68c5bd..9460c083acd9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2388,7 +2388,7 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
 	 * event_function_call() user.
 	 */
 	raw_spin_lock_irq(&ctx->lock);
-	if (!ctx->is_active) {
+	if (!ctx->is_active && !is_cgroup_event(event)) {
 		__perf_remove_from_context(event, __get_cpu_context(ctx),
 					   ctx, (void *)flags);
 		raw_spin_unlock_irq(&ctx->lock);
@@ -2857,11 +2857,14 @@ perf_install_in_context(struct perf_event_context *ctx,
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

