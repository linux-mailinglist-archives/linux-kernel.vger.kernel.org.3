Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBDF47DFCF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347277AbhLWHsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347051AbhLWHrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:04 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3762EC06175C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:04 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l28-20020a25b31c000000b005c27dd4987bso8672867ybj.18
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g+jHwVdZi4B6GdlseRL5ELravrR1guQUj3kmE+JxJm8=;
        b=B4vGh4VAwLBWoylESSncozctWph8CS0QeXEDByAGcppY0P9nGS+w0sesanM55ugnTb
         /WeQLHISwQs5H67cPQnSua2Nv8OVey40AvwtwE7MS8fnMzVzOLotHejQLZGxfngrjVmg
         eiFVHMK1vm4UIfShpqDMENuOb/UP8N/tb4OfV5u6posui4nDhzqGmws+NoJTfHMEwwKl
         Ii9nULWt4Nr/FZPmXsSUcOoD1XDYyygsPgXfI03AExcHvQYq2JnZUliOn+dhu7LMyiSx
         x5l71m2SkIjskS2sLqKmkBGSjqM6TahyIFmkR78SzfYbz8+ezWQO8YfHJL6xkP5lTKVY
         1oWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g+jHwVdZi4B6GdlseRL5ELravrR1guQUj3kmE+JxJm8=;
        b=mc6qWtLU/Rr2nS13+P6mLM1ulqF5PiCRVgA2dUEhNnvOK/G85GxK2OIHNWoGtloGWl
         H6nj3MVt91sbHixqu3hIeQbUkJmNuBlAqGeghU9fBWqKSeiF1m8RAkHpXg8LGT9CUbVo
         JoW34Zrpzr1d1J6jq8eu6QXfVhMcPNVDu0r7xCO2GVmv8YHXVPY7CbRD3V98NrCxci0G
         fbYslGOuwb8t/bhSfUYk+BDPfZllhgkzEdQpMSI9WRyOiXlcuOTlx0NgD4lUjJ8G0hfC
         0wstEqax3hgWlAXHLnUjQbZVOOUB8mg/QDn3QtVF9mpAtlqurBCykf77N1HA0bVdpn+h
         13WA==
X-Gm-Message-State: AOAM530l4IwVcWGXOMmf5xFtl32IMmZZOM1PsWqqQRgWU2FtacvAHT9p
        2xSMVA0xHtz0qOtgW1Avzo/B4cBY1AW9
X-Google-Smtp-Source: ABdhPJzg3LpTwWlyt8N1+tZ1tGQQMdgr2r8ENnhl+i42HOW9nej5lVbnMNKfVUy+kRwpLQ/89koZK4xBlfoK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:7dc4:: with SMTP id
 y187mr1800387ybc.165.1640245623434; Wed, 22 Dec 2021 23:47:03 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:15 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-23-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 22/48] perf cpumap: Trim the cpu_aggr_map
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

cpu_aggr_map__new removes duplicates, when this happens shrink the
array.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 8a72ee996722..985c87f1f1ca 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -185,7 +185,12 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 			c->nr++;
 		}
 	}
-
+	/* Trim. */
+	if (c->nr != cpus->nr) {
+		c = realloc(c, sizeof(struct cpu_aggr_map) + sizeof(struct aggr_cpu_id) * c->nr);
+		if (!c)
+			return NULL;
+	}
 	/* ensure we process id in increasing order */
 	qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), aggr_cpu_id__cmp);
 
-- 
2.34.1.307.g9b7440fafd-goog

