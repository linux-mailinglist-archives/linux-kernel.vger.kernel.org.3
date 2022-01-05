Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92D2484E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiAEGQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbiAEGPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D60C061D72
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:40 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s84-20020a254557000000b0060ac37f4bb1so58181081yba.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wNEaBrVID5KM3S+MlzNQlzdEQtierpy9+J1kdBtC9c0=;
        b=WZn8xmkrKYSldq7JqIbFNcKZISXWtE24gAeqxe6WCDbrccu2Na4X6LhsDB70POLjWs
         GZiEqTanFDVpY5baoNwRYrFOkXnFRPPTjViOrsSBkVFTbcJOAxANKymYca22p/Ij1mT+
         6QHcEP/VK4Ks06lVGJXFdog6KwUPjRgxSjNLKX7etHoFKCrGQs8GFqxlimdnEdmK76Hf
         wlzYah3Zlq7dvgc50O40UriT9aaXwwKKqvgd5GQx8SCa/N8Fz7KQZQkMl9fEZnX2Oalu
         y7nZLXzm/U1WJI3LpZ8bBn6cEAOgOsV6+JEUWmCQJ3rLIQSlNGMhKCiGrlGLWFyisIU7
         3/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wNEaBrVID5KM3S+MlzNQlzdEQtierpy9+J1kdBtC9c0=;
        b=nhRU99sTrYZ9jkGyKtquYdBTBFUayqyhWin4xC7hzqcLj5RWIa+hGWHSNLM7t/HJbc
         T/YMfpSOkTX1rS/W8LJesRpebzkFksQKfnH5iYQvMBIzZiPUvOuyX/1w7R9qbxvlXmbE
         m+V3P2lfE13XP2OtB0mr0PLrAwMaeM7qVL+qrnFnPPRNoVOdhU2Pwx0+iX76SbvYviTA
         y8CI7EJ5LDT6PCVhManSe3vo08joMkhGjc8dPuwmxHvnvZ7r1PTPVdnqIamNASD1nhrC
         emxWBL9CuMeqIyr5TG78GcoK7JSiiaKuIDACRfifUbOHtd9xrzANffRjkTq6PPOPd/24
         WazA==
X-Gm-Message-State: AOAM531wbiilgjpLW/dwIQq+DkELXaHWfUuOJjOCcFrrvqSrU65yTTAz
        Aim4jQG8+sXpQZwp4KU2M07FYYpcQCAY
X-Google-Smtp-Source: ABdhPJxvHg/G/TnVmSMcJExq8JscSaEMGMUJGDv0dfelD+vcY1O+NwfP5Cg4pWKMN5NrRECAnW1joptjWk29
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:7609:: with SMTP id
 r9mr50860138ybc.508.1641363339813; Tue, 04 Jan 2022 22:15:39 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:44 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-42-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 41/48] perf stat: Correct check_per_pkg cpu
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

Code was incorrectly using the cpu map index as the CPU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index f7f9757eba23..86ab427e87fc 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -292,11 +292,12 @@ static bool pkg_id_equal(const void *__key1, const void *__key2,
 	return *key1 == *key2;
 }
 
-static int check_per_pkg(struct evsel *counter,
-			 struct perf_counts_values *vals, int cpu, bool *skip)
+static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
+			 int cpu_map_idx, bool *skip)
 {
 	struct hashmap *mask = counter->per_pkg_mask;
 	struct perf_cpu_map *cpus = evsel__cpus(counter);
+	int cpu = perf_cpu_map__cpu(cpus, cpu_map_idx);
 	int s, d, ret = 0;
 	uint64_t *key;
 
-- 
2.34.1.448.ga2b2bfdf31-goog

