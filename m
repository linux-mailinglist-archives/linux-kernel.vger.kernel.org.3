Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244F0481A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbhL3HWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbhL3HVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:34 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222FAC061747
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:34 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a9-20020a251a09000000b0060b2c94d515so27973927yba.20
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ue3Sc4M2PULu8G7idSi+UKsFDq60wD74fexukfC/fcc=;
        b=RgPIJ3CxdVKGxX2ivNN+mgiAZhGMJAf1uHegdL57m4nmFBiLW3Qn3c+ZILE9tq9Air
         xst/+qnStFVCVDhPXd/IPYhpO6+twqIagXmvBSogWBbWSATGCxRP/c6vJZ1On8xt67+M
         +feHKWUZtWQ7d4J3af5NGYMfnl/axYLQ+162n+io4k8+8CF32Ehr/wotZ/Gff/l695X4
         8GVqDKz3Q968rvD/nBwJc9Lr5yg0ntqZwjoxXGuzSSU3X4iuwOdjxDlRRaGT16cF47Wd
         z1CaKAW6EtsSkJrW0ulwWiq0ciymoN6H0bwPRV+Dar41+Vf1FDKvAXg1SQTcz5aLCSfj
         kf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ue3Sc4M2PULu8G7idSi+UKsFDq60wD74fexukfC/fcc=;
        b=NPpj9s00ix+M48zAgFh+4xJd81BrKmShkM3MCznRIDt//4tzwgRifPNknyL26Z6OLa
         PFWwosLmhtLY+idKIip6OPMa4PFYCU1wNJXUpXWEKCM1J1YAfCbv22oDzBWd5Y6yGJ8r
         9/qyppDJ+7PxIUY7NBsrCH317OdNpG3ylkGzB19ZiHpVB/FJiU6kuZQL8pElN0yysBfD
         66BWfynllvFPVo6p1tQZRjXANkN4pGXLpdmm/VgfBDxLHH/SxZZ5fmPsREWKF4vTnXSd
         ewZdllXZzQzL1aXFtTJ3yfuOG8VeGGfaK+gmv43tXGaiFXvb6jZO8vUgGVh0okscBHG2
         elsQ==
X-Gm-Message-State: AOAM530BwUkJ4hWejCOScPb1n2aOIAd6nHR31NY8+c16OcjZRwQ6klqJ
        IyjhTiZFOBL6ZxeSmCtHLCcQnSA2FDR7
X-Google-Smtp-Source: ABdhPJyIaLxKF2hCbxmhSNGy06maxPg4IbLH5POO5tfbw+284KED4uP0dg5+jywJRRp01yc2Rq36s6WeqcaB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a05:6902:702:: with SMTP id
 k2mr470352ybt.66.1640848893417; Wed, 29 Dec 2021 23:21:33 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:04 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-24-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 22/48] perf cpumap: Trim the cpu_aggr_map
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

cpu_aggr_map__new removes duplicates, when this happens shrink the
array.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 8a72ee996722..3061b4369ab5 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -185,7 +185,15 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 			c->nr++;
 		}
 	}
-
+	/* Trim. */
+	if (c->nr != cpus->nr) {
+		struct cpu_aggr_map *trimmed_c =
+			realloc(c,
+				sizeof(struct cpu_aggr_map) + sizeof(struct aggr_cpu_id) * c->nr);
+
+		if (trimmed_c)
+			c = trimmed_c;
+	}
 	/* ensure we process id in increasing order */
 	qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), aggr_cpu_id__cmp);
 
-- 
2.34.1.448.ga2b2bfdf31-goog

