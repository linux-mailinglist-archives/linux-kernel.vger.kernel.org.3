Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13D953248C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbiEXH4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbiEXHz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:55:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44139AE40
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653378922; x=1684914922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WkixHFEAcC/ws5HZg3LcXnjXZ0DVFhKTdPNaiNysLrA=;
  b=jENOSN0iBagYCMJUQClHZYClbKN8VmX5mjavjVwaktG/zy8HAOHYBeh9
   UIdcprUybuLcepM87wOG0WW6RO/mIpIw2MBDOs6LIqiOYD2+Zac0BpEHP
   c60Q03FG1au10xQGRVjyoGhF5q8i6nGDzSy1s0vMNqTHxKgfMPPdOg4Ed
   k0bOxbcTJPj7rkMzRfe8qDgQwuii8AUpUhiMTMrRdCQn9v+g8Ke+6VAXz
   To2m2dF9iWpUtDXqQqtJC3x5aq5e+3Z1ADXuPsEiG154WQUgmRXZRGPhW
   KCCZm7dAAvfkaUt3jcR0qqhIZtPhI+Ft6tKD85PKQWGk4HOUMteoTYPqo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273455476"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273455476"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="717072412"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.52.210])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:20 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 08/15] perf intel-pt: Track sideband system-wide when needed
Date:   Tue, 24 May 2022 10:54:29 +0300
Message-Id: <20220524075436.29144-9-adrian.hunter@intel.com>
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

User space tasks can migrate between CPUs, so when tracing selected CPUs,
sideband for all CPUs is still needed. This is in preparation for allowing
system-wide events on all CPUs while the user requested events are on only
user requested CPUs.

Acked-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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

