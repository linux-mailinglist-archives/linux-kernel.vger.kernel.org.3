Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D49532496
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiEXH4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbiEXHzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:55:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402B69B18B
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653378939; x=1684914939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B7zVdJsa03qxeddmKuZ5ZR71Qpo4nIqSIXJjSOiLhdQ=;
  b=FxYbx1vUXtRR46Ex1zwu86G3ckCwA4eODVffUuqmKk/oIpDQ6OfmSeEf
   3pnJiiMTk7sIIJ2UMNTWkduuQnbhdFC6GHHaTDeLxMxSYCTpVtJyCb9kI
   w9QcylTJaRfdSm3De5GTReEHOWI6YasO8yJy+sbgE/UFgLhVF6iLPVcJW
   l9wr/qcfPICv7BcQ5NJaDnWRQ85EYtRvAGw/iQl6rHsnJ3XQOoMZo3t7s
   QlCKpQu2Wa6NqDgRFeMb5zFTuPCp/pGhxJb7MJywrLKASpbirnzXQXQ+H
   y3q9rrv+TA0QbvOclqjG5SNuYqhScwhEQFh0AohkVa8qH9pCnOmlPxjhC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273455525"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273455525"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="717072448"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.52.210])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:36 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 15/15] perf tools: Allow system-wide events to keep their own threads
Date:   Tue, 24 May 2022 10:54:36 +0300
Message-Id: <20220524075436.29144-16-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524075436.29144-1-adrian.hunter@intel.com>
References: <20220524075436.29144-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System-wide events do not have threads, so do not propagate threads to
them.

Acked-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 9a6801b53274..e6c98a6e3908 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -52,8 +52,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
 	}
 
-	perf_thread_map__put(evsel->threads);
-	evsel->threads = perf_thread_map__get(evlist->threads);
+	if (!evsel->system_wide) {
+		perf_thread_map__put(evsel->threads);
+		evsel->threads = perf_thread_map__get(evlist->threads);
+	}
+
 	evlist->all_cpus = perf_cpu_map__merge(evlist->all_cpus, evsel->cpus);
 }
 
-- 
2.25.1

