Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F93481A42
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbhL3HWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbhL3HWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:02 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D817C061377
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:48 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id r32-20020a17090a43a300b001b2a1644b8dso5556126pjg.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=awNrzmXXwhgHegLo/XT1TXhJodtpZbEQSRhdkuOAA7A=;
        b=PG2diDhkb5i7ogEM5VvdDCDHxrJYDQzZwNMq4MtIk6SnVaypQKlShQlUuhPeWSh1Kj
         9M8Nl+9CT0Y/Ky1eReJa4PSxNm1ytCwF+LS/7ujzbJjxZ4+XUVv5Bdk8GosiaZTAl/6M
         8tcxJEC4yJm/wkb+WvldQ1MQYgmCNlxI8hqiLP/wVqcSslcgrguLVYHYPbbblV48U29N
         JV+LjNQSQ6vDw1hMQM96+0C/QIZd/mqyfXunlffbLoNv/HbwW2IBG3Ge8ZA0SLLvTEES
         tJK4vRxJokHa8njyWH4u62vFUlBP1RbQrPlCb7O0keKwoVCaXXVdTVmMZvbTfgRZLWML
         a7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=awNrzmXXwhgHegLo/XT1TXhJodtpZbEQSRhdkuOAA7A=;
        b=2WETmFoJZFfTuok+hQHL629vSosMPCcO/G2xz3eJs+cCixmamrzvOZRR94LGQM4Kfh
         fxvRmhFZc5mIXVMjo7Nce/0+Q3nZYE4MhJqBdTjNBYpr/CeuyQh6Q21kuInYNIZiG27P
         4VmRLxN+BM41SOPO2A7BA7IMykFA6WPkO+lIY2sq2wJJ5i5IMj2HgpzT8dkJFSJ+MOjZ
         aPQvBhqGiGS0OyrTF8fLkXgWj/P6s9MsHkbXUdoeN+hEIRVsZq4OsdQx+UQVJQ5FQ+9E
         zDZb0yFM3qbrk44pP1PWlqizNeX/2JjYuzotD60YS9NtGygyUM8aJX4CrHbEjy/N/uMl
         SMWA==
X-Gm-Message-State: AOAM532nS6v9l3tmrAF+Wym1jgdiinJA2e+U/0sjdxLNHg5636cJpiRX
        Cs+zJY/SyW9bAOm73HoSrpKRRLxCRs7q
X-Google-Smtp-Source: ABdhPJzV/t/Mm6XrZ55WBlWiVBPAgYNKl8mk/J4YgsYsaDqr7uQSS9skiOIuSxze7KHWOuzFZh9/58Wx3cG4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a63:a744:: with SMTP id
 w4mr4176724pgo.142.1640848908047; Wed, 29 Dec 2021 23:21:48 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:10 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-30-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 28/48] libperf: Use cpu not index for evsel mmap
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

Fix issue where evsel's CPU map index was being used as the mmap cpu.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evsel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 8028b5a4da69..f1e1665ef4bd 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -252,6 +252,7 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
 		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
 			int *fd = FD(evsel, idx, thread);
 			struct perf_mmap *map;
+			int cpu = perf_cpu_map__cpu(evsel->cpus, idx);
 
 			if (fd == NULL || *fd < 0)
 				continue;
@@ -259,7 +260,7 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
 			map = MMAP(evsel, idx, thread);
 			perf_mmap__init(map, NULL, false, NULL);
 
-			ret = perf_mmap__mmap(map, &mp, *fd, idx);
+			ret = perf_mmap__mmap(map, &mp, *fd, cpu);
 			if (ret) {
 				perf_evsel__munmap(evsel);
 				return ret;
-- 
2.34.1.448.ga2b2bfdf31-goog

