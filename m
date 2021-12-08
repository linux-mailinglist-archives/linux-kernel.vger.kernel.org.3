Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CAC46CB26
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbhLHCuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243595AbhLHCuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:50:12 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E61C061D76
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 18:46:39 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t184-20020a2546c1000000b006008b13c80bso2176952yba.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 18:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JDNiGhsNHgdmMUztfVS0cnfpFuxHbFnC3w+TxzcO4qI=;
        b=JJ7/x6DfuHkASvF7wwLFs0k6i+67I0tnw9tx9PMmghz72m5Sn13MHx/YhyOjfi+Zr8
         SbC03NZPML15LTl1g3fxNoiQnFBYix6jL0tJhSL9vjfRNV9d+sRXhcX4EQtL+fF4uD5S
         frd4E+pDfSuJD/Mtpx4kHDsa81aCpq/49V629laKEw65BRMBPUXmeFIdkFt0c/9kPAH5
         BxaBF2GOAWQpfq6VS4FWgSN2s6ARePKRkJOFh7rRJ3nejs9sX/S07EztA6JktNQu6t94
         M6wXYcJsvH1v0Cx2s2YWOAB0ryUtrdXNshmjVYvI+oeDO8p9NCdj1jrtBtxufod4hrAd
         VtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JDNiGhsNHgdmMUztfVS0cnfpFuxHbFnC3w+TxzcO4qI=;
        b=vSKvSwlmRZCwPHgHadFfxvWF6fKA1eALVurqgRJa2P+fV7r4Ve8wZjy5dRlm5xY93y
         CqXYGxLwJ9NLXKikXjOgq01/TI9u2KcJDeqhw4+d0Z2wSewmJTax2r44RmtGl4V7il/0
         7DpM1EFja70bqjmJ2zQrsjAKEyFeqn9KyqwHI5lDHuf3aZxezfh0W6hHzzkwrEqVrM+B
         PUub8SxfS7RYAomwpfEAAmlbBLBzNs5jw99dOWNw/Bcb+RA7ZWMrlkn6A6zI/Qpv2iEn
         dxnjYeuL2AchIIfqljxBi6L1fMbHiBjCHygjux0PFpNZKV/W+37drW/r25fUZWuSNn7D
         1PJA==
X-Gm-Message-State: AOAM532n9cD0Ilkt0DUzpc/dB5PY/WBODF02+GEJWbdCMYHg9bP1Xa6U
        Wl1O2i5a5TY9tZrtIroGyZdPs8gXLDd8
X-Google-Smtp-Source: ABdhPJzCbvy3TlsCCC1ENscWrGWTXClq62iKwu8pToTV891HdLlKh5Rl3a8xK+72qtmxOd8TDK362KXAgy6e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:b18e:: with SMTP id
 h14mr29366868ybj.744.1638931598466; Tue, 07 Dec 2021 18:46:38 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:45:56 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-12-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 11/22] perf cpumap: Remove unused cpu_map__socket
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

Unused function so remove.

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
2.34.1.400.ga245620fadb-goog

