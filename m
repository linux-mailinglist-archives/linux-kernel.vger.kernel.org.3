Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E32481A54
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhL3HX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbhL3HWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:32 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7454BC061746
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c132-20020a251c8a000000b0060c39ab7d36so23102863ybc.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l4aITqAr4kAWUMdh1BRMLGLBNjKWhPafS6IoiJKe+3o=;
        b=eG/VkvxCAxv7FJdaMjw7BxI6/KZEFoB/JPtBET2zF5N6elUc1+n1tZcMFnSVRzn92A
         dWMCahCjXzUunPAFJ3rARUiOB/EKWyM5cN1+CzaVLlWO0cs00flPnuLlLeL4KzGfbp3j
         0erZlMjNvKHGmrV4rOV2zd+aRP00m40w6sUQrt0+dbGaeN7uRIvazydNUmM1+lAFJAwn
         OzfE5iaB29vSXL4omRM5aUC1h6pIl3DBtFzZ9bjiNkHEQQqcPUwbxq16EeGX/Sh+siCd
         nhLbxfDL9cOhigw3uzfRUFWGBr0IYFZAysIa+l8pSc5YoGXgygNhgasPX5PYLGWuiMag
         qyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l4aITqAr4kAWUMdh1BRMLGLBNjKWhPafS6IoiJKe+3o=;
        b=rMs8Vaot1HCa+T654MSxDrCEpQXNBXGl8URCeLWeoEE7WnSg86Mvt9yCZgIeASmxSO
         xLM61zP7rUyZT8Ea4nQOga3yoCchCkXvBGv18nYTlYD5CqKb0SRFQSsHHWGhtBkL96DQ
         eBbmIqpcAIHCog6fhRJD4oV0hYw8zzDOmfCDrgwnt/FOuUxoaf33FCAJr4fXmFTPlXlI
         b8XTSEQ6FYgVF7Nzw+X+B3KWgVyBdVyeJzvrKHWzKqy9DLwBIlMiielI6Ru5bkGV8wNS
         1Pu1jU8HOy/D5zt7aDUj7Q7m1AuOtL7+GIa9qaAAZQ2NlY+Z3817BPzB7tAZPrllZWnp
         E9DA==
X-Gm-Message-State: AOAM530tGbYPkjo8kNsogctKZD5Lvi9EiOONDzKObfv0nFTp1J+0kqGw
        Z2JSeWlQtjwR9u+G1CzyMqfUdk9ZBGpx
X-Google-Smtp-Source: ABdhPJz4PObQBINBLDM7ybJfAZH1GdUHrMFnx3ClsT9yMsZFN7tl4Vm/ezlizX+D+12RXPI8Dt+8uIx9LRhJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:bc85:: with SMTP id
 e5mr22499668ybk.330.1640848951716; Wed, 29 Dec 2021 23:22:31 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:27 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-47-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 45/48] perf c2c: Use more intention revealing iterator
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

