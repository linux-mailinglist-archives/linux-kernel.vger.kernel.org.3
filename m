Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EA8484E19
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbiAEGOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237706AbiAEGO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:28 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD14C06179B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:14:27 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q81-20020a252a54000000b0060af1d7e063so57557948ybq.17
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4MpQqbzavNLo0+7JIiR5CNmzapIg19tJzrEy7JBYf1M=;
        b=HRLvBXFnItFcTbexq7hQP/0hJPVOOLBwwtSIBZGvARAb6wnXyjzsN6wkgVknw/12Gz
         eqgSOG9hRXft7Y7py7ETKU4P8GytidLAiZQRFZBxZ7rP3ff/XDlkSabHGaqukpfffr2A
         ONx373c5iWplac9ixQKfw7o3lWiJlQ+zsoje3PZ4aNef+HBDsAKlF8CkMxP6Cai0yji0
         T2QXmVVrJS1sm7Ufz3kD90sCEDc5/Suxqns0FBsUZ9fNO4obPdI9zELgHkMUUCKqQ55C
         fesxU+JRDO5zow5AakMiZJtwno9F6kZuMbhHVQVjNoI368OT0/KjAFIx9RIXEaXVW+1m
         ECkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4MpQqbzavNLo0+7JIiR5CNmzapIg19tJzrEy7JBYf1M=;
        b=kGr8xjOUAoxCHAz+5BgSZlqIl/Rlu31xJSMAtpnZxMkbJsMnj/adkZ+bZlwvSUDWvG
         s91d6R6gLhzv0SAfXY+tGt1RnL+PajdOwtYPfsCg2KfA5rMQeU2TR4vm46aJYefHSugw
         aVoCIFnCoQMoioMGbp6PgJRHWhAt/j6x7RUqe9XzOiDaxDTx9HVQv2L+Cd3a2+q8IIw/
         ECnMZNwd0lvYIHMYG0D/pvLaNUfjK2H11IrwQIhk2yJpMOty2NvSMQay/69Z0UrTua6i
         oStDM1vRK16/EWI6nZ9pDBVZb8WLbQXWHJz5F+C7iSbyXjlk5GntMfStzYj/v9LuQlLE
         fVgw==
X-Gm-Message-State: AOAM5300I7h63iX+Y+WsXq3RoTYeMiMg/CdPoDe/nkfA+gwRQE++dVgU
        +CGTpwLlFFZKIu27PVXlydGHFREmdHnq
X-Google-Smtp-Source: ABdhPJzGcf8/560cafAHfBH7bYk7QPCsCHPVmBENp9mJogumNhbe26J57PTe/+PCZtrfz2ntCM98QciF4TNb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:68cf:: with SMTP id
 d198mr47567789ybc.746.1641363267088; Tue, 04 Jan 2022 22:14:27 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:15 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-13-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 12/48] perf cpumap: Remove unused cpu_map__socket
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

