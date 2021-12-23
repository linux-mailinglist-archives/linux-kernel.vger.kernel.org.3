Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B98D47DFD4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347372AbhLWHsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347205AbhLWHrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:35 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199C0C06139A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y125-20020a25dc83000000b005c2326bf744so8489908ybe.21
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ErABhHzBAdfT0a5ELxa3T/433q7mkoWRWaaPkr2zYLE=;
        b=h8ZCv5xpAMC9yF2kAMaxLxcymXWeg49EXaiL3OtamiPvT60DCEbRj+QLqM5moN4W8N
         cDtzztDAzcCThB3KlEz4R+jmMAHQWwC0HWP9jzLrXQeSgbrISK7vUtwmIT3hgpk8SnZf
         Ea9k4Vw/8Cu2Cdt9poAJAnCZzvqBtOEBBihTwocK1pOVbQEMqkL30NhY5x1b3qIvRjz4
         fZ/pakEDofR/HPl2V3MJr+X78TgyvuQt7Pnw0BdOGwBWbb1AwiQ5TqTdNRY8Ibpa4R9J
         QnytXVyIbzFHR52fV6mELViTABsYuN04e+hTtQnQ/bbrmoakuXNkJUX/vXlWQxbzo5zJ
         3Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ErABhHzBAdfT0a5ELxa3T/433q7mkoWRWaaPkr2zYLE=;
        b=GC9oya3X9U6eHDu645xD4JD+b2hmmzUocZHt8zC5aqzO05rEm/MShg+730z/fRS8ll
         JWBWWMTnNTTTCiE4r77ftYorHdNY4+HRG2MWcw1ws3CNGiRW3GEE2wuUZq56i7MoXEnq
         pF5OblgiZcwL7ZqtyPJ737Crm2AisiQEuBsubATDPJHIU8BY/pcMG5w1sl7QKweCe65u
         PKhjLbrfL5CxvT4tgxDYyzQXnZjP750aI/qkb1e4xaobs8KbxBcnfLDEYQk8es2wC3XV
         aDbq+Ba/ivpcj0hw0QPqLl0Oz1sOQAslXaw/ECFclTR8scp+1u2utInXxefRLNxUMSrc
         mjvQ==
X-Gm-Message-State: AOAM533PG4LOUa4pjeGfLk/bhz+A+eS8Hw23Q2C5b3sJ513SgrwbJlqm
        LKFJCGNLfulLUW4KTP/tHPcaj3tV6cpX
X-Google-Smtp-Source: ABdhPJwqZDzpHASDcXqKxGGvIcAj99RfagujZOxumPIiBCWlWRZFjRDOAtRAIxTsQbSB/e87K/O6PSKPvp4b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:238a:: with SMTP id
 j132mr1715031ybj.530.1640245639355; Wed, 22 Dec 2021 23:47:19 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:21 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-29-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 28/48] libperf: Use cpu not index for evsel mmap
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
        linux-arm-kernel@lists.infradead.org
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
2.34.1.307.g9b7440fafd-goog

