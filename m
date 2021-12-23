Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBB147DFE6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347463AbhLWHtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347361AbhLWHsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:48:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEE7C0698CB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:48:03 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j18-20020a258152000000b006000d292a42so8800455ybm.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0+jllfj9qKTtJn62Mv0xaycKEmjVjVqlWS+UU/ykrAI=;
        b=VS1sJ5HaFNgLWNjQYGVO1AtJP7sYCg/muV4bWo4w9PU1mXOnMoE2wy2OOHSPptpn2e
         8LBFCDKZ4EjtqSPtym/k8DfExCgIcaZ64yNjXn0dfjp1nOoiQzswq3FYIS8MOteOJGtE
         yCaOybVqwP/dg7QKAKb3xVJjcmqSEbX+9Z8BQo1GizOG3xz0MQcHMis3c6tTiCb2f7Mo
         4Kl5OgK9mi4fV0xNjFYNcncF/iQVH2cpuZkxSN7Y1P9B9h8HjRvr9mZJh4G2bhe+boat
         m5W3RIosFUHAC9q0KNgBYT3dMEzl6qtVOwXxTHw1OiUyFsBO1JEfQJtUP/oSiOmpojl7
         TIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0+jllfj9qKTtJn62Mv0xaycKEmjVjVqlWS+UU/ykrAI=;
        b=dxX9Gqbm18TghQl1RGB8AGvWPQps667pwOCetv3DvkMCmix7L8aQsPzQ6q8upH8cXG
         0eXAwSue7mzbPg7eNKAMl094sVPeTW3//0qobgah4jVkoFIlGWWT0If6E6W1duSUoz8L
         5UPur+5GlTza5lGBbyCelFRZYU30SAM1b7PHCTmqysQyN99mzriKhZSNOkyK/7tIj29x
         hPM4oces0UZ1TDls7m0QE7g01P3lMvmU75ghJfgIZ1WXHIjjNEDaX3ryf023VbNM++DN
         zA8d4a1SdrX3GxD2iyL+3SPINlM/gsx5n4XEUsNsHhwvyMFLdqNo0RL3HVAvgTGmqZ3B
         1vpA==
X-Gm-Message-State: AOAM533RC4Yf1GzY3s5q1awYl5Cu5f3o86Hp8Ojg+X2QfPc60RcZv1Jw
        v7Rj9DEOg7I46xygI8KOEQA4YT5q7RVz
X-Google-Smtp-Source: ABdhPJw1XvXrCrCmgw8Tk2gnaSSb4wGPW7JXEGtNiZ5hS4rNdk0qW6Y2vLin1IHozUlivVvyHQGwrvdHCPkX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:2c4d:: with SMTP id
 s74mr1589032ybs.171.1640245682584; Wed, 22 Dec 2021 23:48:02 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:38 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-46-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 45/48] perf c2c: Use more intention revealing iterator
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
2.34.1.307.g9b7440fafd-goog

