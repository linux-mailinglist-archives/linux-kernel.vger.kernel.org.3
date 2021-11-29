Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C6F462829
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhK2XWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhK2XWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:22:02 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17500C061746
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:18:44 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q17so13402375plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MCM67v7x0EUDxJmAPBrBMAF6E74DuOKq5bhBMSK8KqA=;
        b=pcbJJECvqWqqKgWnKUVwyWFN6k4xkU6ZITf2RPj11vB5o4wzO0pKNnIeGCK+Z8UUmw
         xsfvn/QTcm7h9qHEpWpzwOO9F+I7etN0f28WXmj2Qmm/4N2e48QBUcorS6lv7EFoF4nN
         wRYfDq4XHT2p3353oOiEy7alrGPXt7QUCh7IazOSXirn0R9mcioM2r0mgGK5NJQUQmV4
         z5WlR1CSezbxg2H513/ei0YeBXPZQoAnS+50V/EFRvFg3afOR5RE5sWCqx2ppQ/YWL8Y
         31gCMep/g0u4zS6vGYqMpVTrgYiRx60ACOJmNsRtaa5c+442MAY4EWCumnWtBtqbX0KE
         Mzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MCM67v7x0EUDxJmAPBrBMAF6E74DuOKq5bhBMSK8KqA=;
        b=R2n76jezFlImRuwpW5tKFMT04NN8CVHb7YpDOAgGbp+XiNEdQxGiFeAsT38tGl3DsD
         ODmzyjydzWUlXz+qKipmZHlrit5ROXNo9l9z7vx1hwHEq91NbdejdTqxASkUP7EJ7VJ1
         fbZNY+HwwntwQiAtIq6nB+Xq+icTRaWvX0cVJEDRkc3qxTopYRRrj+XU1zZz5Br/Sf95
         BsIPMXHSPMkdwG/rXPBlJXvzMlwYryN3SEweOs+CNzrPiMSS8VuRwctYcZzaqdBzPE7n
         ozR4pwfVLR3QaspISFvFw3cG/dMm7YZimONUKKu9LjORfm8pFZkioryHkT/rFk6en4r1
         h5Lg==
X-Gm-Message-State: AOAM531n/TiYcsVeGJDq0zF2upDelJqCOREK0zkkYS5Oqx9iG732BGUM
        boia+3ZYEZfBQ6s+Rokue+0=
X-Google-Smtp-Source: ABdhPJxWkc5rcf9+WeQzwQ21I0lVuL/+M20aQv2tqisHSyZSQAYGRNAB9DDgrRqYnCdf32kb/QufwA==
X-Received: by 2002:a17:902:c115:b0:142:2441:aa23 with SMTP id 21-20020a170902c11500b001422441aa23mr61642218pli.16.1638227923567;
        Mon, 29 Nov 2021 15:18:43 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:7f54:1f52:ae81:8c78])
        by smtp.gmail.com with ESMTPSA id j7sm18334762pfu.164.2021.11.29.15.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 15:18:43 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 5/5] perf ftrace: Implement cpu and task filters in BPF
Date:   Mon, 29 Nov 2021 15:18:30 -0800
Message-Id: <20211129231830.1117781-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211129231830.1117781-1-namhyung@kernel.org>
References: <20211129231830.1117781-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Honor cpu and task options to set up filters (by pid or tid) in the
BPF program.  For example, the following command will show latency of
the mutex_lock for process 2570.

  # perf ftrace latency -b -T mutex_lock -p 2570 sleep 3
  #   DURATION     |      COUNT | GRAPH                          |
       0 - 1    us |        675 | ############################## |
       1 - 2    us |          9 |                                |
       2 - 4    us |          0 |                                |
       4 - 8    us |          0 |                                |
       8 - 16   us |          0 |                                |
      16 - 32   us |          0 |                                |
      32 - 64   us |          0 |                                |
      64 - 128  us |          0 |                                |
     128 - 256  us |          0 |                                |
     256 - 512  us |          0 |                                |
     512 - 1024 us |          0 |                                |
       1 - 2    ms |          0 |                                |
       2 - 4    ms |          0 |                                |
       4 - 8    ms |          0 |                                |
       8 - 16   ms |          0 |                                |
      16 - 32   ms |          0 |                                |
      32 - 64   ms |          0 |                                |
      64 - 128  ms |          0 |                                |
     128 - 256  ms |          0 |                                |
     256 - 512  ms |          0 |                                |
     512 - 1024 ms |          0 |                                |
       1 - ...   s |          0 |                                |

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_ftrace.c                | 41 +++++++++++++++++++++
 tools/perf/util/bpf_skel/func_latency.bpf.c | 21 +++++++++++
 2 files changed, 62 insertions(+)

diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
index 1975a6fe73c9..18d6f1558163 100644
--- a/tools/perf/util/bpf_ftrace.c
+++ b/tools/perf/util/bpf_ftrace.c
@@ -6,7 +6,10 @@
 #include <linux/err.h>
 
 #include "util/ftrace.h"
+#include "util/cpumap.h"
+#include "util/thread_map.h"
 #include "util/debug.h"
+#include "util/evlist.h"
 #include "util/bpf_counter.h"
 
 #include "util/bpf_skel/func_latency.skel.h"
@@ -16,6 +19,7 @@ static struct func_latency_bpf *skel;
 int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 {
 	int fd, err;
+	int i, ncpus = 1, ntasks = 1;
 	struct filter_entry *func;
 	struct bpf_link *begin_link, *end_link;
 
@@ -33,6 +37,17 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 		return -1;
 	}
 
+	/* don't need to set cpu filter for system-wide mode */
+	if (ftrace->target.cpu_list) {
+		ncpus = perf_cpu_map__nr(ftrace->evlist->core.cpus);
+		bpf_map__set_max_entries(skel->maps.cpu_filter, ncpus);
+	}
+
+	if (target__has_task(&ftrace->target) || target__none(&ftrace->target)) {
+		ntasks = perf_thread_map__nr(ftrace->evlist->core.threads);
+		bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
+	}
+
 	set_max_rlimit();
 
 	err = func_latency_bpf__load(skel);
@@ -41,6 +56,32 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 		goto out;
 	}
 
+	if (ftrace->target.cpu_list) {
+		u32 cpu;
+		u8 val = 1;
+
+		skel->bss->has_cpu = 1;
+		fd = bpf_map__fd(skel->maps.cpu_filter);
+
+		for (i = 0; i < ncpus; i++) {
+			cpu = cpu_map__cpu(ftrace->evlist->core.cpus, i);
+			bpf_map_update_elem(fd, &cpu, &val, BPF_ANY);
+		}
+	}
+
+	if (target__has_task(&ftrace->target) || target__none(&ftrace->target)) {
+		u32 pid;
+		u8 val = 1;
+
+		skel->bss->has_task = 1;
+		fd = bpf_map__fd(skel->maps.task_filter);
+
+		for (i = 0; i < ntasks; i++) {
+			pid = perf_thread_map__pid(ftrace->evlist->core.threads, i);
+			bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
+		}
+	}
+
 	begin_link = bpf_program__attach_kprobe(skel->progs.func_begin,
 						 false, func->name);
 	if (IS_ERR(begin_link)) {
diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
index d7d31cfeabf8..17a2a53b4f16 100644
--- a/tools/perf/util/bpf_skel/func_latency.bpf.c
+++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
@@ -36,6 +36,8 @@ struct {
 
 
 int enabled = 0;
+int has_cpu = 0;
+int has_task = 0;
 
 SEC("kprobe/func")
 int BPF_PROG(func_begin)
@@ -46,6 +48,25 @@ int BPF_PROG(func_begin)
 		return 0;
 
 	key = bpf_get_current_pid_tgid();
+
+	if (has_cpu) {
+		__u32 cpu = bpf_get_smp_processor_id();
+		__u8 *ok;
+
+		ok = bpf_map_lookup_elem(&cpu_filter, &cpu);
+		if (!ok)
+			return 0;
+	}
+
+	if (has_task) {
+		__u32 pid = key & 0xffffffff;
+		__u8 *ok;
+
+		ok = bpf_map_lookup_elem(&task_filter, &pid);
+		if (!ok)
+			return 0;
+	}
+
 	now = bpf_ktime_get_ns();
 
 	// overwrite timestamp for nested functions
-- 
2.34.0.rc2.393.gf8c9666880-goog

