Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF1A50BCE0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446356AbiDVQ2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390699AbiDVQ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:27:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A053F5C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650644696; x=1682180696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uLF6qXh+XOVZJNuYD6lAJ6RB4iqOqKmveOdC3HuSOiQ=;
  b=NFMIkR1P8GCbmaQcIhc78tBMLgqxGdHOWXeURDLicnbhUQkSmDMiABtY
   rbJ8XgF2kPhzncB0sZMv+ncEqOmLHpbxrA6WCYFou/KHBgZ2oV4iurQBF
   YKL0KP/j76pK7eNGmwwkWC3loLJp20GqokgSQox4q+P/D0mvrCYD2ik5D
   zNe/KOebxcyjdO936JYL4ZEJbCUVo3p0LmefaEB1U9ko+lUslmrlE+RE0
   ZfFCp60A9+5MsjJPB05NqbpzlQfsRIPdPTiQghUGp7w1ofhIUIG+4bYm3
   uz7dqcqQ9QWuRDydc4+ITfsJBeJXQ46+siKSdbO7VKMGE0QhjsdZE1j1B
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264886024"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264886024"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577979087"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 09:24:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 16/21] perf intel-pt: Track sideband system-wide when needed
Date:   Fri, 22 Apr 2022 19:23:57 +0300
Message-Id: <20220422162402.147958-17-adrian.hunter@intel.com>
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

