Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958C5484E42
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbiAEGRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238187AbiAEGQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:16:14 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131CCC0698D9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s84-20020a254557000000b0060ac37f4bb1so58181813yba.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qtV1zFQM1oC6nqS9kOztDQtUXtSA1ZGHj+U+RoiLGco=;
        b=TF44h6bDW9ENH23eEmW9TItbeR7WjGNdvIzxU07LPcU/fVFvC13Vxf5hnb0t5zIi4L
         oQOsDHElQSTh7S/mT70nFE9Nm1VBwAMt/kptivfrpfiQcaVutbvK6eWOKyfKHoA516Sh
         fG7HiIp6e2uUFA5bMd41QW17SW9ctaigu70CBjtliIpF02yXP2lR8lz52KHEIPO5rMmG
         PbLPzLWCUxoqFVUPbOuCFCi3gOry2BVMXOH8Xikg93oG6BA5f9c4Si3CgfS4/KJ1Petv
         +1uM7MVZf3RS5Gqe5kw7Jyvq3SSZykfThKQyvxGZWuPZUReoQhTeEbSEOCIUPbrSK/VT
         sVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qtV1zFQM1oC6nqS9kOztDQtUXtSA1ZGHj+U+RoiLGco=;
        b=eMV1gql+n9yLzOBoygC7anVbbO+0pviGEQqgNbYf2D2RJbkrNpC7SjlxR+24XgS8PW
         m5bEEwz6DVOWX7JHev6uEUvjUqI5wuSx9bgDS9NqpWHhWRS0NmNCCz8hcsZql4G0Egzc
         lAoFI2T/S8dyUpKsRuDcmLDF0Novs1S/Nhe+lTvaH7FGHsfygGqaNv71lrGIaHYSir0B
         4gNXV8/Za4At6nDtgBrf6hk5CsepTPCdauZWfoNAGojZMJ6z6OZkgN8U4iJbEUdFvjhy
         gEyUdoYzPBBjWwmP9qo+aYxoAln/KUmLU87nsOwnH/za+99QvyFDNpEHt89gjd72zRxc
         TiPg==
X-Gm-Message-State: AOAM530Ul4UrPxxUb9nGAw9lQVzDSxRNFpBBh0ZVCn/ecBUeCGqZgHga
        QuhkjOncgavDyeFLa2ALBbci9Li9y4F1
X-Google-Smtp-Source: ABdhPJyO0RjQjjaLRZAsFsRj64Vi//uVlLSevrlUFyHAY3W0w1VhoNId3q47hdhQc3dTyIvu2xlWIy9+gchN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:aacd:: with SMTP id
 t71mr49891988ybi.542.1641363352306; Tue, 04 Jan 2022 22:15:52 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:49 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-47-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 46/48] perf script: Fix flipped index and cpu
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

perf_counts are accessed by the densely packed index.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f40319144856..bb43529618b3 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2131,7 +2131,7 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 		perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)) {
 			struct perf_counts_values *counts;
 
-			counts = perf_counts(counter->counts, cpu, thread);
+			counts = perf_counts(counter->counts, idx, thread);
 
 			printf("%3d %8d %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %s\n",
 				cpu,
-- 
2.34.1.448.ga2b2bfdf31-goog

