Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D32B51D7A3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391869AbiEFMbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391864AbiEFMa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:30:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AAB692A8
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651840005; x=1683376005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TmJVw40nZyxu//7zocSUtg+Bql5vQ9H0HlIT57JgqHI=;
  b=m3tskn1+P3WGNmMdfjiRq5EefAZxozYY5L3gO25gN4iU6pxwToIlsCjB
   ZXYf8nGkhR01T8leXPtD4lotP76fK6+/kLXqeKx7qJOV9Jrcw+timDxAu
   iHfRfpzApjK7SRsYR8XShzB1IBZknWyz0jBNfn2ztsFzb4E4ylYHxWerP
   mLErNFjtBYFy+G61mswzJZ6eK59TYEiEKGAOATUFJsRBgIN1Fso8FZSle
   qtWczRCiqAwfI18WQFZhZw8u8e3nJxKgKmhZzd2z/CDcdATIp8hDenRi0
   rp7WOUX3vNopDV4q3E/zKIp4xerSIjsV8K52hi/LVo5tBkrDspIC76yLp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266045846"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266045846"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:26:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709441013"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 05:26:43 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 16/23] perf intel-pt: Track sideband system-wide when needed
Date:   Fri,  6 May 2022 15:25:54 +0300
Message-Id: <20220506122601.367589-17-adrian.hunter@intel.com>
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

User space tasks can migrate between CPUs, so when tracing selected CPUs,
sideband for all CPUs is still needed. This is in preparation for allowing
system-wide events on all CPUs while the user requested events are on only
user requested CPUs.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 0ee93894a0da..06c2cdfd8f2f 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -864,20 +864,22 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 
 	/* Add dummy event to keep tracking */
 	if (opts->full_auxtrace) {
+		bool need_system_wide_tracking;
 		struct evsel *tracking_evsel;
 
-		err = parse_events(evlist, "dummy:u", NULL);
-		if (err)
-			return err;
+		/*
+		 * User space tasks can migrate between CPUs, so when tracing
+		 * selected CPUs, sideband for all CPUs is still needed.
+		 */
+		need_system_wide_tracking = evlist->core.has_user_cpus &&
+					    !intel_pt_evsel->core.attr.exclude_user;
 
-		tracking_evsel = evlist__last(evlist);
+		tracking_evsel = evlist__add_aux_dummy(evlist, need_system_wide_tracking);
+		if (!tracking_evsel)
+			return -ENOMEM;
 
 		evlist__set_tracking_event(evlist, tracking_evsel);
 
-		tracking_evsel->core.attr.freq = 0;
-		tracking_evsel->core.attr.sample_period = 1;
-
-		tracking_evsel->no_aux_samples = true;
 		if (need_immediate)
 			tracking_evsel->immediate = true;
 
-- 
2.25.1

