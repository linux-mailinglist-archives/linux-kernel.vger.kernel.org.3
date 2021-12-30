Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A2D481A33
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbhL3HVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbhL3HVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:10 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7699CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:09 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s127-20020a252c85000000b0060be2b7b8e9so24392335ybs.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4MpQqbzavNLo0+7JIiR5CNmzapIg19tJzrEy7JBYf1M=;
        b=kXoA13WOKQIftVzZWO4HPUuV3ZzbRFc766qGcXsU5lIzsbLaWePjPAChzhTjJw18XB
         ezxaXy4Uv1c2Du76Ko4gwC91vIrvCM3ggm9zIVTJr4hexeJm4z6dvMdozbh8tGvq+zmd
         /QnB9H3gMb1zivqVAQeXMeGVnxlaHXv8Y/wELEKdnZWWfFBJBztyK0Z95UQkaz7Y1oOE
         W6ki6PrsFwHa4/GIZfRZCPC72h4gi1/a62TR89XKPRzbO5VWS/+G836nopw/oJN2MBJC
         CypKer12qZ2GIMtMWwW1YMrCovGqMQLyh5XqpGWQL7eSMObFVRg7vZAcaLpiqcHRikLJ
         hRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4MpQqbzavNLo0+7JIiR5CNmzapIg19tJzrEy7JBYf1M=;
        b=w9Aw8Pt8lep3qkZMwzpBKsJlUCjV8qRIwInHp/lZ2OCbJFLcO+VVqLl8MYCc/JlsB4
         l/jU3hU9Eo18d7gMec/N2+3cdC1yyE6eWyv53COBhZLYVziNlPsI2gUHWqf3kT2yBDJ5
         sQBoWqZNk3XGw1ccFC23RFsYFUgbQxMcMhwnTtBs/iuCJ4vEj+kVudeDFCD3KTCpGahu
         Y08rt5srdU//YylTfWyIoSCV5zh4nKeaVET0F/iz2SODUNJcfPtLsHV69dOZ3OtEZWMQ
         M2T75hmi4nu3e0AZu6zVEyyu5g8S3QX+PZsOGUuyQabe55CzxNefHoPgahifjuJYnRSn
         z57g==
X-Gm-Message-State: AOAM5316WCmuV3QHBRwJviRUfX3N5UTO47p1qf4L+vNymT3ihIqGmVz7
        bjflh2H3K+9EFavU5/B+Vq4xRq1JtJ6D
X-Google-Smtp-Source: ABdhPJwE0WxTfbpAvt6d/swn2WJ5h727lammLK2k1Me4z1oYDnY4PoE78/VcpLfmw8FLS4n+YKUA4Mk3yljz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:cdc3:: with SMTP id
 d186mr34482066ybf.400.1640848868720; Wed, 29 Dec 2021 23:21:08 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:54 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-14-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 12/48] perf cpumap: Remove unused cpu_map__socket
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

Unused function so remove.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index edd93e1db36a..22e53fd54657 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -53,13 +53,6 @@ int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **cor
 int cpu_map__build_node_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **nodep);
 const struct perf_cpu_map *cpu_map__online(void); /* thread unsafe */
 
-static inline int cpu_map__socket(struct perf_cpu_map *sock, int s)
-{
-	if (!sock || s > sock->nr || s < 0)
-		return 0;
-	return sock->map[s];
-}
-
 int cpu__setup_cpunode_map(void);
 
 int cpu__max_node(void);
-- 
2.34.1.448.ga2b2bfdf31-goog

