Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E4951D799
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391860AbiEFMa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391845AbiEFMaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:30:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E85692AE
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651839983; x=1683375983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d3l1u9Tv0gtCM+Vaellvr0QGnqW3rFX/vqrcrjcyS6g=;
  b=jntHryOWahvOT5Ch+JaBAzxWp5Vx+VWyXsDogRNYqLqKVgphUW4QAj8D
   pA2wDvwkA3IKZ6OwfmSVdUiN6CeRpNfYQZZRyNc2ijchSD+0AQQszN+7E
   BUtjHr3EsNOSC05B2I4zDekQjX8doBE6SFeRYxB3SHEkLinPF61e4qfT+
   Yb3sNtHELnTJJ/ZqwsIya4nrnj5FgFa0sFyoA3Ba3u2mJyXN3B8VGy2OG
   uUogIG4erLvUo75F6mcbB3vdYA7ZEhOqkU/hPm5+td+e6ShLSSsU0kb6d
   vA+ktsydmT2Qx7IhG7jbxVYm2+cmQeP9ZW++yCF64FIXOuQSnew9lOlFm
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266045757"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266045757"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:26:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709440764"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 05:26:20 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 07/23] libperf evlist: Move ->idx() into mmap_per_evsel()
Date:   Fri,  6 May 2022 15:25:45 +0300
Message-Id: <20220506122601.367589-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506122601.367589-1-adrian.hunter@intel.com>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ->idx() into mmap_per_evsel() in preparation for adding evsel as a
parameter.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 5e8ad854fa8a..4fce417432aa 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -478,6 +478,9 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 			 */
 			refcount_set(&map->refcnt, 2);
 
+			if (ops->idx)
+				ops->idx(evlist, mp, idx);
+
 			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
 				return -1;
 
@@ -520,9 +523,6 @@ mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		int output = -1;
 		int output_overwrite = -1;
 
-		if (ops->idx)
-			ops->idx(evlist, mp, thread);
-
 		if (mmap_per_evsel(evlist, ops, thread, mp, 0, thread,
 				   &output, &output_overwrite))
 			goto out_unmap;
@@ -547,9 +547,6 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		int output = -1;
 		int output_overwrite = -1;
 
-		if (ops->idx)
-			ops->idx(evlist, mp, cpu);
-
 		for (thread = 0; thread < nr_threads; thread++) {
 			if (mmap_per_evsel(evlist, ops, cpu, mp, cpu,
 					   thread, &output, &output_overwrite))
-- 
2.25.1

