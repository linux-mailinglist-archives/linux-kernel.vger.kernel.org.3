Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDED47DFD0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347154AbhLWHsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347130AbhLWHrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CB2C06179E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y125-20020a25dc83000000b005c2326bf744so8489264ybe.21
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J5Uxwz+NmtGEEgwvjL1sqJyX0/ppatr3BMcnhgtMNdI=;
        b=P+SChYI6l4zrhclWgOqBwpBXlMLUJiQXf8pyYNraVwtkdhs7KWxi4SHRuEs8Dijfgf
         kB1zINsX/1g3a6FuZyqmfEelCd7gyfYYCTtIpCFy2FxhV/ZOBHyDptAOnFsp6C3HVdhZ
         WkVyOVFxTKqSjMdxYGMUpMXp9RUfPetQ9mrev4LzHC+t+v611w5UC2P5sKBbddh+XkzM
         pg59NoJ+Ls4g/9bHvkjqV+KQiVTf3LaRBoNk7NzWdeke3jAlFx+a+gTeOmLXbtjIkBQC
         mTMKim6DKViJkpsGVDSFhFS1zlCWZl3Kwh+HIU/qNb+pACBdW1rcVEGSg+8ihB9wPwgx
         RKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J5Uxwz+NmtGEEgwvjL1sqJyX0/ppatr3BMcnhgtMNdI=;
        b=Xx3edXxXaVcmHUsn8PobCQSoWTxqcolgD8s/CEiazSUBOP0FX+o6PWKtuQoqyqz2kg
         HOOAll1/HQHORneVlVH18hXV9kXn4a0zvr1hu2uPMkfYc9cS4YpPeIOwSHenZWTxH0sH
         QBqbhrp6pBplarUOPtXv98ffTSmly6jCLAqFWJO4TVtS9rrnv+jmlCcPGWyGb9l+4Tel
         Pq6ZwMAHahFdknRKjuJdbJgMXoGawI5RF+JN07CbWU0Ldc/Y62HJYA5tZgQCHOg6SXYX
         jPF1QevMS4Yy2NSq91GdQtQ8xb0jT6b/Dmzd51/CX2LgfGiuQ4ooZwVwAztPW8orkcAw
         308A==
X-Gm-Message-State: AOAM531+BvDfpkaGENaEcKavXhCVW4+ZQIt8D+bKqw6c8td7cGflJwQx
        8hoEBDKMdADQ952oUpXbLC5NuFGlC+Ko
X-Google-Smtp-Source: ABdhPJzuyhZb4oXRwSxm+ExXDmsSz287nUms3ZLP6USDOSqq/SCugWDf3aY2ieELM5n9Z8Xd11OZuvQJU437
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:ac23:: with SMTP id
 w35mr1680442ybi.341.1640245625867; Wed, 22 Dec 2021 23:47:05 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:16 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-24-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 23/48] perf stat: Fix memory leak in check_per_pkg
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

If the key is already present then free the key used for lookup.

Found with:
$ perf stat -M IO_Read_BW /bin/true

==1749112==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 32 byte(s) in 4 object(s) allocated from:
    #0 0x7f6f6fa7d7cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x55acecd9d7a6 in check_per_pkg util/stat.c:343
    #2 0x55acecd9d9c5 in process_counter_values util/stat.c:365
    #3 0x55acecd9e0ab in process_counter_maps util/stat.c:421
    #4 0x55acecd9e292 in perf_stat_process_counter util/stat.c:443
    #5 0x55aceca8553e in read_counters ./tools/perf/builtin-stat.c:470
    #6 0x55aceca88fe3 in __run_perf_stat ./tools/perf/builtin-stat.c:1023
    #7 0x55aceca89146 in run_perf_stat ./tools/perf/builtin-stat.c:1048
    #8 0x55aceca90858 in cmd_stat ./tools/perf/builtin-stat.c:2555
    #9 0x55acecc05fa5 in run_builtin ./tools/perf/perf.c:313
    #10 0x55acecc064fe in handle_internal_command ./tools/perf/perf.c:365
    #11 0x55acecc068bb in run_argv ./tools/perf/perf.c:409
    #12 0x55acecc070aa in main ./tools/perf/perf.c:539

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 5c24aca0968c..c69b221f5e3e 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -345,9 +345,10 @@ static int check_per_pkg(struct evsel *counter,
 		return -ENOMEM;
 
 	*key = (uint64_t)d << 32 | s;
-	if (hashmap__find(mask, (void *)key, NULL))
+	if (hashmap__find(mask, (void *)key, NULL)) {
 		*skip = true;
-	else
+		free(key);
+	} else
 		ret = hashmap__add(mask, (void *)key, (void *)1);
 
 	return ret;
-- 
2.34.1.307.g9b7440fafd-goog

