Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80E647EED9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 13:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352684AbhLXMkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 07:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhLXMkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 07:40:31 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F317C061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 04:40:30 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id a11-20020a17090a854b00b001b11aae38d6so8325451pjw.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 04:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vkaMjLSrWnNSKIxsm+YqOMH5aHbPwyhp0hWkPZSKCIM=;
        b=AFLAA49FbqsuxgvYmuClU8Ug7dP8wg4QG7O+nD14ujS4PrpIZ4BYnLuGWQhPnCDpro
         MN/M0ETWP6QAwG84M1fgN7t+W0OsQ5GMDctqZ72Fykw0PcvmW7hGihLfhHnhlL2qkiCg
         xCnL7vmimapkmiVeSq03ruraeO20I7jiN0Q215cvg+DxcJo2OPI3F3B0O6o/7LCXwzj+
         71NXALneYVs9kHFSxulLCuMqRJjJIbbyV7/9TSXy3RnkZY36pG7QDIh95Ugr0c/6ogVI
         wfRckqKUZP3SgySzYkDKc7lXJGxcIs5mNBwC+NrghGMr1FNxBOB9P8WO1A7HgFWh5tL+
         Noag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vkaMjLSrWnNSKIxsm+YqOMH5aHbPwyhp0hWkPZSKCIM=;
        b=RjGw9lmKvQH3mWInS8recZgIl6e295iTAZgUSFKdPCWwUwbhEnUhnCoIaA5bl+17j4
         XpMSizSY2yYAzjrZFoGjVFDi49th4ARc8FhGWe37lz8jCpY0PA1OIBJJwLdfa6oE1V/I
         XW7zm0pFgzhDSUDUcHzdIea35bm6rpzpRqBvtkDAPMATcRDTiioYL5NxSJ5QQwobTBPR
         Lx+x6gBWK8NMCHd3dIBWlLrmBOEPthBa7g2T2QoeGMaJeXnyp7B8ioX5veuIU+pr8mAk
         iMhDG4ycyFADbOms8RKOesNN7EUEta9EYaKHmF1Fb5g7Er6YBvu9AP+qn25nWUwPri6h
         eBFA==
X-Gm-Message-State: AOAM532Jt4crOsYmyX/uuZ20HU1HngviAmIpXdB6DkJTFm0pJDEUF4I5
        zPTUmBcmjVYre8IslM8hQy7lMQ==
X-Google-Smtp-Source: ABdhPJxD1s4hcy+HGU2tEEvPWtmHtypQXFYznV/whq4r6mO1x06m1jZP7wfkAm2Qe+QNr0w0W3RpdA==
X-Received: by 2002:a17:902:b944:b0:148:be4b:66dd with SMTP id h4-20020a170902b94400b00148be4b66ddmr6358166pls.63.1640349629854;
        Fri, 24 Dec 2021 04:40:29 -0800 (PST)
Received: from localhost ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id k8sm7222685pjj.3.2021.12.24.04.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 04:40:29 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1] perf synthetic-events: Return error if procfs isn't mounted for PID namespaces
Date:   Fri, 24 Dec 2021 20:40:13 +0800
Message-Id: <20211224124014.2492751-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For perf recording, it retrieves process info by iterating nodes in proc
fs.  If we run perf in a non-root PID namespace with command:

  # unshare --fork --pid perf record -e cycles -a -- test_program

... in this case, unshare command creates a child PID namespace and
launches perf tool in it, but the issue is the proc fs is not mounted
for the non-root PID namespace, this leads to the perf tool gathering
process info from its parent PID namespace.

We can use below command to observe the process nodes under proc fs:

  # unshare --pid --fork ls /proc
1    137   1968  2128  3    342  48  62   78	     crypto	  kcore        net	      uptime
10   138   2	 2142  30   35	 49  63   8	     devices	  keys	       pagetypeinfo   version
11   139   20	 2143  304  36	 50  64   82	     device-tree  key-users    partitions     vmallocinfo
12   14    2011  22    305  37	 51  65   83	     diskstats	  kmsg	       self	      vmstat
128  140   2038  23    307  39	 52  656  84	     driver	  kpagecgroup  slabinfo       zoneinfo
129  15    2074  24    309  4	 53  67   9	     execdomains  kpagecount   softirqs
13   16    2094  241   31   40	 54  68   asound     fb		  kpageflags   stat
130  164   2096  242   310  41	 55  69   buddyinfo  filesystems  loadavg      swaps
131  17    2098  25    317  42	 56  70   bus	     fs		  locks        sys
132  175   21	 26    32   43	 57  71   cgroups    interrupts   meminfo      sysrq-trigger
133  179   2102  263   329  44	 58  75   cmdline    iomem	  misc	       sysvipc
134  1875  2103  27    330  45	 59  76   config.gz  ioports	  modules      thread-self
135  19    2117  29    333  46	 6   77   consoles   irq	  mounts       timer_list
136  1941  2121  298   34   47	 60  773  cpuinfo    kallsyms	  mtd	       tty

So it shows many existed tasks, since unshared command has not mounted
the proc fs for the new created PID namespace, it still accesses the
proc fs of the root PID namespace.  This leads to two prominent issues:

- Firstly, PID values are mismatched between thread info and samples.
  The gathered thread info are coming from the proc fs of the root PID
  namespace, but samples record its PID from the child PID namespace.

- The second issue is profiled program 'test_program' returns its forked
  PID number from the child PID namespace, perf tool wrongly uses this
  PID number to retrieve the process info via the proc fs of the root
  PID namespace.

To avoid issues, we need to mount proc fs for the child PID namespace
with the option '--mount-proc' when use unshare command:

  # unshare --fork --pid --mount-proc perf record -e cycles -a -- test_program

Conversely, when the proc fs of the root PID namespace is used by child
namespace, perf tool can detect the multiple PID levels and
nsinfo__is_in_root_namespace() returns false, this patch reports error
for this case:

  # unshare --fork --pid perf record -e cycles -a -- test_program
  Couldn't synthesize bpf events.
  Perf runs in non-root PID namespace but it tries to gather process info from its parent PID namespace.
  Please mount the proc file system properly, e.g. add the option '--mount-proc' for unshare command.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/synthetic-events.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 198982109f0f..cf7800347f77 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1784,6 +1784,25 @@ int __machine__synthesize_threads(struct machine *machine, struct perf_tool *too
 				  perf_event__handler_t process, bool needs_mmap,
 				  bool data_mmap, unsigned int nr_threads_synthesize)
 {
+	/*
+	 * When perf runs in non-root PID namespace, and the namespace's proc FS
+	 * is not mounted, nsinfo__is_in_root_namespace() returns false.
+	 * In this case, the proc FS is coming for the parent namespace, thus
+	 * perf tool will wrongly gather process info from its parent PID
+	 * namespace.
+	 *
+	 * To avoid the confusion that the perf tool runs in a child PID
+	 * namespace but it synthesizes thread info from its parent PID
+	 * namespace, returns failure with warning.
+	 */
+	if (!nsinfo__is_in_root_namespace()) {
+		pr_err("Perf runs in non-root PID namespace but it tries to ");
+		pr_err("gather process info from its parent PID namespace.\n");
+		pr_err("Please mount the proc file system properly, e.g. ");
+		pr_err("add the option '--mount-proc' for unshare command.\n");
+		return -EPERM;
+	}
+
 	if (target__has_task(target))
 		return perf_event__synthesize_thread_map(tool, threads, process, machine,
 							 needs_mmap, data_mmap);
-- 
2.25.1

