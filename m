Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D2047DFE2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347362AbhLWHtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347197AbhLWHsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:48:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315E8C061799
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q198-20020a25d9cf000000b005f7a6a84f9fso8570356ybg.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=84jiul3eS69fZOps8gyBR2xeuwa8naIlTNqvP/j/8xA=;
        b=eWvVaORPbPCnckO/NmOe+ry/whk3ae7kUZNUzcG+mrlyrUmZJAMUJzjb+aMMLos9VA
         3aF8p1UpAPuuUehAL4NI9mLMLA2AT7CimKeCxG1bJ4r8NrvH/Ag9dpRdUNMYOUpNz+NZ
         MDT7urMFaz5qbPYzLQUHQp1Nu3Dru8+RHWWE2nLNsuUxnBeAYtXxe5LgRY4izM2LoEQg
         +P+jY5XIjXuKW6r6/skwTDr3uoDZkiUCDd5RuCCqaGrh4QLQCEqGxXR3v0+3f6qvKYIH
         GMJmHEiZuL3CtVbNK2buWxV2fNimLbiDIbZ8hJcT+XyNiIhX/Y9qlYd2VOYotU5TM/t1
         Vjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=84jiul3eS69fZOps8gyBR2xeuwa8naIlTNqvP/j/8xA=;
        b=H7v9R/7Bhvk4u8IcI8BxnMh60gNuW+Ca2CSu9E5kpZg47yWgU44BdLL3YxcTC0Kfn+
         y5UqWYM/8/2kgHmust39o9hUKR+o2KsFeAwtqxBrZr1tMhdbVkfwM4mjLnCJOJFjl7S6
         +alDb7+RS3QdBJHuENtMRxwgMiG7ORcu5GucN1OIbAqIQv1KEEY6IVVhDNWDoQoeYn8i
         A/ykDKAWHfqbpbLRur6RMo6/95oYr0sXhGmn+ZvQ3rGNVc9I67hFRzDHE11BWiJ/fDeQ
         MfoAto1OozNG7Ofu4Mm6h9GN822UAPhz/wwFeUcoPCTya7BGTBir/ObYfIsXBS7M7Jaq
         p8+Q==
X-Gm-Message-State: AOAM531QJQgiH5XwB3DNuPHw//Avb+C22HZff4RIom7yVf9RKLfYp1je
        nG2Z8eKeRIKOSiIwN6QgQOPSjBhB2xJX
X-Google-Smtp-Source: ABdhPJxhU524UVDy65p+6AJP7nFi0/17OcNMoh/MQicxFL+nsP8RdWqJqC3cARe3QImikhkZrwzBUDdJOmI/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:13c6:: with SMTP id
 189mr1675596ybt.113.1640245672380; Wed, 22 Dec 2021 23:47:52 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:34 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-42-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 41/48] perf stat: Correct check_per_pkg cpu
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
2.34.1.307.g9b7440fafd-goog

