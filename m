Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27E851C58F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382482AbiEERCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382406AbiEERBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:01:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DC45D5DA
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651769882; x=1683305882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uLF6qXh+XOVZJNuYD6lAJ6RB4iqOqKmveOdC3HuSOiQ=;
  b=hHPIxn3QGW8VWhPOsY7ptpnWPZhkGmwuN9e9BPqK+5uO9z2ijD7ikKvP
   0MzNY8S8UDq63CwMC0mwUjpEaNxQ0ipfZj4trYqOMri16oDobF3StrP3r
   qVwjnL45khEbDN2a6U7ts6flsywLLEhn7e5RmplDaZI9LOUIlRq76bw8F
   Ia7/1lLKukH/zvQxEgjDwbOB6CvdFH9kKTGiJZJ4obA6C+ZtCy08Sw2ll
   bTjr8XFFPmf/JPJsk9/oa3FvaosWXj53vqcYWKYsh9EZKYDThFby4caYn
   FWomUHqxdLXUQfKmIs3drL+cdzb/ThjqYCguiLuF1gSJjKIWWVtEDf4H7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248718288"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248718288"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 09:57:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="709032957"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 09:57:21 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V1 16/23] perf intel-pt: Track sideband system-wide when needed
Date:   Thu,  5 May 2022 19:56:32 +0300
Message-Id: <20220505165639.361733-17-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505165639.361733-1-adrian.hunter@intel.com>
References: <20220505165639.361733-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index e45d64dec57c..62be78bc90b6 100644
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

