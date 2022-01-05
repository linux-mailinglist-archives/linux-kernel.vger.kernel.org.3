Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F5C484E40
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbiAEGRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbiAEGQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:16:12 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC25C0698D5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:50 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v189-20020a2561c6000000b0060b5814a17eso55739205ybb.22
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l4aITqAr4kAWUMdh1BRMLGLBNjKWhPafS6IoiJKe+3o=;
        b=oq4qaiIdVmKbNmPSmU1ee7EYSBOWVUs0qBp1DNmNPiE1i6LOTJgd4U49eU8Qud+eAF
         BK9YPVFgysNVn0Jm0gzZFN+8U+8/pwXJB5sDD7nPgk/0MX309k1smI8yLpMytm2wK2G8
         jLg7oTVi0CiVtoZgHy1xC/sT6JbceUZ9QjAARlngFZklHrkJTRLucA4QxGBgamZoYfjh
         qB50KKL9C5/cjkAx+UNaSgDC1VX/tQ9Vqg2DtKfJ8MNPRa4D9fbpZ8crbtlOj79WX5qG
         xqCVMQokJemgqj7YoOC/pIJCI+MPyNWib/3uJMLOGnZcfzdt8LP1eJPEdtPS+eYN9P/b
         TsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l4aITqAr4kAWUMdh1BRMLGLBNjKWhPafS6IoiJKe+3o=;
        b=eSUQz53uGXBLKftfvZYCIbuhB4MuW0vuimK3LjSpvclDzXS6wfkw3A1sbbgKHUOxK2
         BJ/jSQWNkZqgtYxTGKm6H52nEByyjNZ6xFYt2Oindr1ugnlBMPj6dJls9sGM5h0TCpNO
         ssaHubNVuiZym6Expwcm46sU+TsAZt0c+kPwIaLHcYQeIbofW2bzEXOHL5QJnTDFgPnm
         3LFp5hoUORS8sv/inCuAwZeeE5ZyzRa2IEZZEEDIPo5hrkSjdWib+mjtjbpWWpKlWK4U
         En7HAThTulBJJXtUtniCS5ahzEHMDyPqD1ytD0LfIhq7Tla8IpZ9Ch3MvQ+2t7kuLj3s
         52eQ==
X-Gm-Message-State: AOAM530lGM9/+lqIvJqEBr7KigboZ4A+AcV/CZ4oZ4nd/X0JFAzafxM0
        jscmQMV1tBeBWcvx56jEQtSLA0FurPG8
X-Google-Smtp-Source: ABdhPJyPnXyAbZfjaFcz67v+Kw7nE2hg5GCzoqNQvaO7noAreCoYlyuiuJVgyHV9sb+ADV8pJ+AK+odgpgfW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:40ca:: with SMTP id
 n193mr64096091yba.683.1641363349798; Tue, 04 Jan 2022 22:15:49 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:48 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-46-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 45/48] perf c2c: Use more intention revealing iterator
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

Use perf_cpu_map__for_each_cpu in setup_nodes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index b5c67ef73862..ad1fbeafc93d 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2015,7 +2015,7 @@ static int setup_nodes(struct perf_session *session)
 {
 	struct numa_node *n;
 	unsigned long **nodes;
-	int node, cpu;
+	int node, cpu, idx;
 	int *cpu2node;
 
 	if (c2c.node_info > 2)
@@ -2057,13 +2057,13 @@ static int setup_nodes(struct perf_session *session)
 		if (perf_cpu_map__empty(map))
 			continue;
 
-		for (cpu = 0; cpu < map->nr; cpu++) {
-			set_bit(map->map[cpu], set);
+		perf_cpu_map__for_each_cpu(cpu, idx, map) {
+			set_bit(cpu, set);
 
-			if (WARN_ONCE(cpu2node[map->map[cpu]] != -1, "node/cpu topology bug"))
+			if (WARN_ONCE(cpu2node[cpu] != -1, "node/cpu topology bug"))
 				return -EINVAL;
 
-			cpu2node[map->map[cpu]] = node;
+			cpu2node[cpu] = node;
 		}
 	}
 
-- 
2.34.1.448.ga2b2bfdf31-goog

