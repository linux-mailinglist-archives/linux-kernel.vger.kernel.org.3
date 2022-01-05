Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B0B484E28
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbiAEGPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiAEGPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:05 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46138C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:05 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n2-20020a255902000000b0060f9d75eafeso15618154ybb.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jSsFFLhWB7MnpKAldIeOinUTQRyOvwUdMysgsTlE4q4=;
        b=VdqVOwvoOMcCw4Z1k1OWvj566yvzrIGcrNZlvdngwH2ZKntAOegzzzh9RaUkpteU8d
         EG+/G8W/w9rIEztRkIASbCxgUckOhxb5GoGoqCKnAh2zDBJlzxn7cW0qAU3pxvfOfNzd
         /1hD2zrfNbKFvpLQZvKueoRasIJKfCnmNKGakoEIBWatUgPYoiUvu4t7fevHATIvcex0
         PG21QGAe7FZlq0HUiomvkNF3U8gX1u6NQwhNR2CV0ZD57X927asz84E9d/aBTdGD8eik
         XUZYloXaQPLyIXT4MHITAF/b0Y1XRQkYyvosqOFHcNl1DEhrmM1VtNCR92Xc3pPja3dV
         CskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jSsFFLhWB7MnpKAldIeOinUTQRyOvwUdMysgsTlE4q4=;
        b=uaJ5N3EmhrF84jh5F+WAO8ex9VIrchqgPlpm0aQt6YIQLAUp1+Tn+ttGtxeRZ8wAwZ
         cGXMait3Zxs+F5GbRAp/4/cjT+oes87LOUlHBCR7DdGTpYGxHnEDiaJr2BDndjSoSeY+
         tWO+v8d7/XI/5c2kyxl5ep+XfOgZ71bnqY/99ZCy+Onc+oyuQMVvShR31xCXGtBshUvf
         E6etOkEoScjiB+ca/TlwUyulzOry+mM2PZClHx0tuepfZ2qxFREmzYOpRI+OyE9x/zFr
         /kyGB3ugkZp67o2nM/s8Snqh7BMh0TX/JEpGjXDKQkJ+sFnFo/37ica1EI16m2KXVxL6
         qCow==
X-Gm-Message-State: AOAM5307yot0+av6roDJABzO/6WyY6ZS4H7YyTGNkr3aIRMd8NGSzm3A
        YkDnVfKiC79SIhPT4hQm03LdJPzrxfzv
X-Google-Smtp-Source: ABdhPJxJni4sdSLrT8nZXKaIZ7nSXCkpVps94xCL8LJ6uKaLwqmbIzMHvISv/YIO2ehdN7IxNsuZYaqA5XDS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:e705:: with SMTP id
 e5mr18720895ybh.618.1641363304489; Tue, 04 Jan 2022 22:15:04 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:30 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-28-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 27/48] libperf: Switch cpu to more accurate cpu_map_idx
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

