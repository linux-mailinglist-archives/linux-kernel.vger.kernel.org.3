Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E377C481A49
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbhL3HWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbhL3HWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:01 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9EDC0613B5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:46 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e2-20020a25d302000000b0060c57942183so22010646ybf.18
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jSsFFLhWB7MnpKAldIeOinUTQRyOvwUdMysgsTlE4q4=;
        b=WZTt7fIDiyBo9rt7z2dTw3jUTc3Mqma7DWNCYi+Wv+rmH4n/xtiw8lg4TUvJlS+9ww
         o7l2oEZcI/1zAOik7aYEnrZdY5HIG7aF2gI3MKerJLTCywCEvCjufgtICX4MPGXaBnOw
         5elXjlugQs2PCzOR+HC2Ioa9528XDe0Q5phry+ZuePY5NMDX8syzaCilc4R8o4ir+si7
         a23L3yPT+f0KFFqymtpiwn2d6BaruTFHGfku1mkW0o5KDaL+Cj4TMPUWiV/4azfUOW4n
         FeIJxtdhPsvVBznimjF2PUe9KCLG3X8PPrw767ChK9UvmNjMgIUu9pGrLxe6wD7T1P8r
         lyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jSsFFLhWB7MnpKAldIeOinUTQRyOvwUdMysgsTlE4q4=;
        b=6/kJzPeMiMsj4KtscO81MwWJthg8BtUUEqCLGkftqo7KMEc5fKeJ0UuyvV8KN8T91Z
         P/YWHG6PeR4PYJO5EIktYX2EhZEIsmFsJ++jyeAMWY5qwjSXtqEAoSkXFH38Q0j9kuIr
         SblZA/VHWLIvLJyeqY0Pz1b22gM2pVfWe+rwNGRP9SmEghEKdNE0DxcY1b6X0VoVRE7e
         v9oS4FSzmWsnYIKv1awEGh/Sv4OPajJjwlUrIAYoRj46ZkGFFYyNCmRpC5YVkfPWuuAZ
         FpvpqDKcce/Hjn2G6kNYBlCD9mi3Dz0t7PWmMT5XpgWLNDttPGhH9r6Ko7QLZQCWt4W4
         qpGQ==
X-Gm-Message-State: AOAM531vVTd/AdpnIOQWch3ZX8jWmR+gU72vIdWtzOhAsRUrYNzfmtiP
        V+YvuTz21mwN0EmX9qVLvnc0TrXn7Sp3
X-Google-Smtp-Source: ABdhPJw7fj6ApL9Z9gutmoKsdimI82WAuhQEcciATSD/AQuKtYsrclmu+VR4MS55zWu8zWBrzH7d+Cv5BMy+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:8c9:: with SMTP id 192mr37166693ybi.102.1640848905438;
 Wed, 29 Dec 2021 23:21:45 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:09 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-29-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 27/48] libperf: Switch cpu to more accurate cpu_map_idx
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify variable names and adopt perf_cpu_map__for_each_cpu in
perf_evsel__open. Renaming is done by looking for consistency in API
usage.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evsel.c              | 88 +++++++++++++++--------------
 tools/lib/perf/include/perf/evsel.h | 10 ++--
 2 files changed, 50 insertions(+), 48 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 68f83d2c27c1..8028b5a4da69 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -43,18 +43,22 @@ void perf_evsel__delete(struct perf_evsel *evsel)
 	free(evsel);
 }
 
-#define FD(e, x, y) ((int *) xyarray__entry(e->fd, x, y))
-#define MMAP(e, x, y) (e->mmap ? ((struct perf_mmap *) xyarray__entry(e->mmap, x, y)) : NULL)
+#define FD(_evsel, _cpu_map_idx, _thread)				\
+	((int *)xyarray__entry(_evsel->fd, _cpu_map_idx, _thread))
+#define MMAP(_evsel, _cpu_map_idx, _thread)				\
+	(_evsel->mmap ? ((struct perf_mmap *) xyarray__entry(_evsel->mmap, _cpu_map_idx, _thread)) \
+		      : NULL)
 
 int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
 {
 	evsel->fd = xyarray__new(ncpus, nthreads, sizeof(int));
 
 	if (evsel->fd) {
-		int cpu, thread;
-		for (cpu = 0; cpu < ncpus; cpu++) {
+		int idx, thread;
+
+		for (idx = 0; idx < ncpus; idx++) {
 			for (thread = 0; thread < nthreads; thread++) {
-				int *fd = FD(evsel, cpu, thread);
+				int *fd = FD(evsel, idx, thread);
 
 				if (fd)
 					*fd = -1;
@@ -80,7 +84,7 @@ sys_perf_event_open(struct perf_event_attr *attr,
 	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
 }
 
-static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread, int *group_fd)
+static int get_group_fd(struct perf_evsel *evsel, int cpu_map_idx, int thread, int *group_fd)
 {
 	struct perf_evsel *leader = evsel->leader;
 	int *fd;
@@ -97,7 +101,7 @@ static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread, int *grou
 	if (!leader->fd)
 		return -ENOTCONN;
 
-	fd = FD(leader, cpu, thread);
+	fd = FD(leader, cpu_map_idx, thread);
 	if (fd == NULL || *fd == -1)
 		return -EBADF;
 
@@ -109,7 +113,7 @@ static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread, int *grou
 int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 		     struct perf_thread_map *threads)
 {
-	int cpu, thread, err = 0;
+	int cpu, idx, thread, err = 0;
 
 	if (cpus == NULL) {
 		static struct perf_cpu_map *empty_cpu_map;
@@ -139,21 +143,21 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 	    perf_evsel__alloc_fd(evsel, cpus->nr, threads->nr) < 0)
 		return -ENOMEM;
 
-	for (cpu = 0; cpu < cpus->nr; cpu++) {
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
 		for (thread = 0; thread < threads->nr; thread++) {
 			int fd, group_fd, *evsel_fd;
 
-			evsel_fd = FD(evsel, cpu, thread);
+			evsel_fd = FD(evsel, idx, thread);
 			if (evsel_fd == NULL)
 				return -EINVAL;
 
-			err = get_group_fd(evsel, cpu, thread, &group_fd);
+			err = get_group_fd(evsel, idx, thread, &group_fd);
 			if (err < 0)
 				return err;
 
 			fd = sys_perf_event_open(&evsel->attr,
 						 threads->map[thread].pid,
-						 cpus->map[cpu], group_fd, 0);
+						 cpu, group_fd, 0);
 
 			if (fd < 0)
 				return -errno;
@@ -165,12 +169,12 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 	return err;
 }
 
-static void perf_evsel__close_fd_cpu(struct perf_evsel *evsel, int cpu)
+static void perf_evsel__close_fd_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 {
 	int thread;
 
 	for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
-		int *fd = FD(evsel, cpu, thread);
+		int *fd = FD(evsel, cpu_map_idx, thread);
 
 		if (fd && *fd >= 0) {
 			close(*fd);
@@ -181,10 +185,8 @@ static void perf_evsel__close_fd_cpu(struct perf_evsel *evsel, int cpu)
 
 void perf_evsel__close_fd(struct perf_evsel *evsel)
 {
-	int cpu;
-
-	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++)
-		perf_evsel__close_fd_cpu(evsel, cpu);
+	for (int idx = 0; idx < xyarray__max_x(evsel->fd); idx++)
+		perf_evsel__close_fd_cpu(evsel, idx);
 }
 
 void perf_evsel__free_fd(struct perf_evsel *evsel)
@@ -202,29 +204,29 @@ void perf_evsel__close(struct perf_evsel *evsel)
 	perf_evsel__free_fd(evsel);
 }
 
-void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu)
+void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 {
 	if (evsel->fd == NULL)
 		return;
 
-	perf_evsel__close_fd_cpu(evsel, cpu);
+	perf_evsel__close_fd_cpu(evsel, cpu_map_idx);
 }
 
 void perf_evsel__munmap(struct perf_evsel *evsel)
 {
-	int cpu, thread;
+	int idx, thread;
 
 	if (evsel->fd == NULL || evsel->mmap == NULL)
 		return;
 
-	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
+	for (idx = 0; idx < xyarray__max_x(evsel->fd); idx++) {
 		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
-			int *fd = FD(evsel, cpu, thread);
+			int *fd = FD(evsel, idx, thread);
 
 			if (fd == NULL || *fd < 0)
 				continue;
 
-			perf_mmap__munmap(MMAP(evsel, cpu, thread));
+			perf_mmap__munmap(MMAP(evsel, idx, thread));
 		}
 	}
 
@@ -234,7 +236,7 @@ void perf_evsel__munmap(struct perf_evsel *evsel)
 
 int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
 {
-	int ret, cpu, thread;
+	int ret, idx, thread;
 	struct perf_mmap_param mp = {
 		.prot = PROT_READ | PROT_WRITE,
 		.mask = (pages * page_size) - 1,
@@ -246,18 +248,18 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
 	if (perf_evsel__alloc_mmap(evsel, xyarray__max_x(evsel->fd), xyarray__max_y(evsel->fd)) < 0)
 		return -ENOMEM;
 
-	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
+	for (idx = 0; idx < xyarray__max_x(evsel->fd); idx++) {
 		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
-			int *fd = FD(evsel, cpu, thread);
+			int *fd = FD(evsel, idx, thread);
 			struct perf_mmap *map;
 
 			if (fd == NULL || *fd < 0)
 				continue;
 
-			map = MMAP(evsel, cpu, thread);
+			map = MMAP(evsel, idx, thread);
 			perf_mmap__init(map, NULL, false, NULL);
 
-			ret = perf_mmap__mmap(map, &mp, *fd, cpu);
+			ret = perf_mmap__mmap(map, &mp, *fd, idx);
 			if (ret) {
 				perf_evsel__munmap(evsel);
 				return ret;
@@ -268,14 +270,14 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
 	return 0;
 }
 
-void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread)
+void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu_map_idx, int thread)
 {
-	int *fd = FD(evsel, cpu, thread);
+	int *fd = FD(evsel, cpu_map_idx, thread);
 
-	if (fd == NULL || *fd < 0 || MMAP(evsel, cpu, thread) == NULL)
+	if (fd == NULL || *fd < 0 || MMAP(evsel, cpu_map_idx, thread) == NULL)
 		return NULL;
 
-	return MMAP(evsel, cpu, thread)->base;
+	return MMAP(evsel, cpu_map_idx, thread)->base;
 }
 
 int perf_evsel__read_size(struct perf_evsel *evsel)
@@ -303,19 +305,19 @@ int perf_evsel__read_size(struct perf_evsel *evsel)
 	return size;
 }
 
-int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
+int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
 		     struct perf_counts_values *count)
 {
 	size_t size = perf_evsel__read_size(evsel);
-	int *fd = FD(evsel, cpu, thread);
+	int *fd = FD(evsel, cpu_map_idx, thread);
 
 	memset(count, 0, sizeof(*count));
 
 	if (fd == NULL || *fd < 0)
 		return -EINVAL;
 
-	if (MMAP(evsel, cpu, thread) &&
-	    !perf_mmap__read_self(MMAP(evsel, cpu, thread), count))
+	if (MMAP(evsel, cpu_map_idx, thread) &&
+	    !perf_mmap__read_self(MMAP(evsel, cpu_map_idx, thread), count))
 		return 0;
 
 	if (readn(*fd, count->values, size) <= 0)
@@ -326,13 +328,13 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 
 static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
 				 int ioc,  void *arg,
-				 int cpu)
+				 int cpu_map_idx)
 {
 	int thread;
 
 	for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
 		int err;
-		int *fd = FD(evsel, cpu, thread);
+		int *fd = FD(evsel, cpu_map_idx, thread);
 
 		if (fd == NULL || *fd < 0)
 			return -1;
@@ -346,9 +348,9 @@ static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
 	return 0;
 }
 
-int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu)
+int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu);
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
 }
 
 int perf_evsel__enable(struct perf_evsel *evsel)
@@ -361,9 +363,9 @@ int perf_evsel__enable(struct perf_evsel *evsel)
 	return err;
 }
 
-int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu)
+int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, cpu);
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, cpu_map_idx);
 }
 
 int perf_evsel__disable(struct perf_evsel *evsel)
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index f401c7484bec..2a9516b42d15 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -28,16 +28,16 @@ LIBPERF_API void perf_evsel__delete(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 				 struct perf_thread_map *threads);
 LIBPERF_API void perf_evsel__close(struct perf_evsel *evsel);
-LIBPERF_API void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
+LIBPERF_API void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu_map_idx);
 LIBPERF_API int perf_evsel__mmap(struct perf_evsel *evsel, int pages);
 LIBPERF_API void perf_evsel__munmap(struct perf_evsel *evsel);
-LIBPERF_API void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread);
-LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
+LIBPERF_API void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu_map_idx, int thread);
+LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
 				 struct perf_counts_values *count);
 LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
-LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu);
+LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
-LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu);
+LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
 LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
-- 
2.34.1.448.ga2b2bfdf31-goog

