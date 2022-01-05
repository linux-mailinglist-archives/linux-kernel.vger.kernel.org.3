Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75779484E33
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbiAEGQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237969AbiAEGPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:20 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF20EC0613B1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a9-20020a251a09000000b0060b2c94d515so56597630yba.20
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zx3eoMgk2E9Q1m2Vv8UqlZ4wRR3W4iMt/10PWukXDj0=;
        b=JzhU/p628/opiLcLIsURp0pnOITWo3VMDbz1xTScpyWKXTQ80ky+9phYvVj5YskKIC
         ihV1UilgKg+fxIR4lNRHT2jbRH5xt6z9qcMV2CsvJwr2ey6a884uofLI44XNilaitkIZ
         t1vI3Whq21gSG5xhKvTtflEVRoIWzAK4x+EyoUSDkQVPS4z0aBp0uNzVJlG10nbmRXf8
         Qimi21bEbywjJXYALyBU8WePexxl8cnJyM5mN8wwdJ4Rd1VvdhyoWg/m61iwNEXsXuM7
         IW2j4cuizU/2649UP7UvfnXkYyF4DloSnqBcS5aq9woNDszcs1uyavBg6D5cRuOkmLwR
         +xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zx3eoMgk2E9Q1m2Vv8UqlZ4wRR3W4iMt/10PWukXDj0=;
        b=n5PYQWeECEt9jMTbM94k9t2k6whlvcvwPlb8t+CP1Bazh0h+yHivxHyErE5TXJAtCO
         Lp78EotBSQvzHeyvAHvZapAiTYb7xxrMZa4QuKIuBoqorko8rVSOSlgYuM/aks8GyOmi
         7oFRRdlm5cIRU6ijXWV867t0VT5XJpnVzZT/7afklzjaj9ACCnRsO8ofjdNMDvZah9Ij
         twi03cJEjOhxT1ndAIItNMlk0wM8po7LCl1WP7TdXTolOWxotSTogXOTMGU+tdJHZ/X0
         StFd1aGD4uqF3Zt1TDIox5wWgdhZTmDaQis5bWbjBdWMzA03oKFAa7t/ADRrIZCZBDR3
         LOmQ==
X-Gm-Message-State: AOAM533LDaaFQT61kR23KxH+leADOgoE7uKX4qJ0tuUnxfqB/fxhHAwX
        bsMHfjbIlS6fZU5XxOk+fWodRSXWLVds
X-Google-Smtp-Source: ABdhPJzsyfej2FDjgM0ae4+/ARSD37iN1p79WMe+BCIr76RgnKeFFpZkmXOBSkD22Il0+R8oWA1ghKXmKhIm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a5b:350:: with SMTP id q16mr367766ybp.639.1641363319931;
 Tue, 04 Jan 2022 22:15:19 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:36 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-34-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 33/48] libperf: Allow NULL in perf_cpu_map__idx
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

Return -1, not found, if NULL is passed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 3c36a06771af..eacea3ab965a 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -270,8 +270,13 @@ bool perf_cpu_map__empty(const struct perf_cpu_map *map)
 
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, int cpu)
 {
-	int low = 0, high = cpus->nr;
+	int low, high;
 
+	if (!cpus)
+		return -1;
+
+	low = 0;
+	high = cpus->nr;
 	while (low < high) {
 		int idx = (low + high) / 2,
 		    cpu_at_idx = cpus->map[idx];
-- 
2.34.1.448.ga2b2bfdf31-goog

