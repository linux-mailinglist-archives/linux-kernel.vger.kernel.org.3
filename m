Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912EE481A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbhL3HWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbhL3HVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:37 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48B0C061394
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:36 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v189-20020a2561c6000000b0060b5814a17eso26924716ybb.22
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r8DPKd9/Sw54Ic+0J53LiDeJxVBy3KIktvCz7ol2teU=;
        b=Y1olYxL5xdUbS/5Pur5YSEFeIndFNzsuvsDwKkPACbpQcTfSpvtFSjcBTYFJCD3T2R
         DhjEeBCngbuFsTWdcHY09UHqCJ5h8gHusC2bMXCZSlJpIxdtOxQs5aPD4P7LtihMm8c3
         vz5seXS3n8pqgqhoF1uTJlZL1bAVkbmcmebD7kQkYt8wOh4q7GEfPAjLsRqJW7wh/beY
         +qb3x1Sb8X9eGeDRssv1t7Z04GNyYaojaBVX5aj6vDum9cTWKxXJRhZT7BtTowMAoga/
         /XIILBYPx7eY9BDFL3pK0OPbnsrEK5oT/Kjm7eqV7tWYMqgqxHU7Xl+QE6C90QyzAq7j
         schA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r8DPKd9/Sw54Ic+0J53LiDeJxVBy3KIktvCz7ol2teU=;
        b=VJ/iGQ0j+JE6db6jXlPrwstFP+gParjTBfkObr4PktV5/TmBFmuzs2z4i2wpQWSHh8
         vJbQAlYdtqTZlQQjTXe2att5N66mtM/f9q8O8iI8POEx6usNfAhS7kGMGvqRQdI7Rksb
         23hJZR83776eVlqDvLo3A99x+Vh6Jgp31RHoHAc6yxvy/N7k+H1frEdUvpAX1y2qzucZ
         pvfBF+n/ibDx1ZzNzmJTE5vRbuBWFLxm+yRa0gPc9rhhfRt7SllNq/mEhV5UdkMr5qLT
         oi5rGkMNUCHH9/A6+435tqKkFwfyA6hmVkC+eR5FDPeENGqWSIOMlIlZvZRIkb2/1ls8
         taOw==
X-Gm-Message-State: AOAM532x+muYXrFyP5XO5SkSYmbhhizJJpy6srxHaDiXm2HwZBqFEN1L
        574cdNcCihd3QmmIv6290WpELvP8lDfP
X-Google-Smtp-Source: ABdhPJyO73+i/r0f/wr2X4131/M6h8Mhaxy8uZEgH3Y5Xbw/y8CbL842aFLHLlGs6FD/PPgL2o8I90TL0Brz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:a184:: with SMTP id
 a4mr36612571ybi.56.1640848895883; Wed, 29 Dec 2021 23:21:35 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:05 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-25-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 23/48] perf stat: Fix memory leak in check_per_pkg
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
2.34.1.448.ga2b2bfdf31-goog

