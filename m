Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D30350BCDB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391593AbiDVQ2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384521AbiDVQ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:27:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106585E154
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650644677; x=1682180677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9DOXfRd3f3OReVW0h+/JBRH8U4w0AkNB8ioN2ETNxZ4=;
  b=CCtLxcUAjzIBC1e0PsSRoHFA0CKqreR/1Wx9Cmj8eRe3vYpVpnIpYvss
   Lcyh6EITY8Xd7ZFMINtjTdyHb8J8RpNeHeBlLl3p89mqDm/HgMVf8Qe5j
   2+yBwaPfBn6WTUCUTiPPUCcniFPYZVHDa1MgpiSQpBzeGFH4GCf7AVw8x
   2dp7GR9/YIOsdU2uD3GQ9lGbruNzls2yEv2L7HQs0FlthLEGNuGTw5U9b
   Ps+LBgbJByF+iM3D9IAHnVvT+anobiG3lgpzb/9JI5R2GBJ5TLtweR8Je
   bHa5ooxB7VA8ThUk7mMuWDDEuv9bNI8i434wmAciC6fBffFEKUvkpTcbF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264885856"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264885856"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:24:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577978690"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 09:24:17 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 05/21] perf auxtrace: Do not mix up mmap idx
Date:   Fri, 22 Apr 2022 19:23:46 +0300
Message-Id: <20220422162402.147958-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422162402.147958-1-adrian.hunter@intel.com>
References: <20220422162402.147958-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idx is with respect to evlist not evsel. That hasn't mattered because
they are the same at present. Prepare for that not being the case, which it
won't be when sideband tracking events are allowed on all CPUs even when
auxtrace is limited to selected CPUs.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 10936a38031f..2d015b0be549 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -640,8 +640,14 @@ static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel,
 {
 	bool per_cpu_mmaps = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
 
-	if (per_cpu_mmaps)
-		return perf_evsel__enable_cpu(&evsel->core, idx);
+	if (per_cpu_mmaps) {
+		struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
+		int cpu = perf_cpu_map__idx(evsel->core.cpus, evlist_cpu);
+
+		if (cpu == -1)
+			return -EINVAL;
+		return perf_evsel__enable_cpu(&evsel->core, cpu);
+	}
 
 	return perf_evsel__enable_thread(&evsel->core, idx);
 }
-- 
2.25.1

