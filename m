Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA11251D7A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359708AbiEFMbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391915AbiEFMaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:30:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9DE69498
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651840003; x=1683376003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wVM1pOx2QDTKQaGcOMqh41IRv9AQKSS3ODd+mtdbX1Q=;
  b=ECLl+rMfXpxPnpts/nPgk7GIx374O+hhWT/xKZETQWoHez2LY0cc6w1P
   ZaAcFnTlBnhnHRSyUFsi5p0vz6MlAl5zYOf9j8tXisoIdPVwrra5VKP7D
   rzyFRCv6fwJE43PWUg7U1LmVJTGB5One0acbDeK1UcEEizzGfX6yaFW6t
   2985J5d7SL2ugyxnugsCQrSA/2nI6ZQeOOAd6KcUvJBzSNrtclOZMqqN3
   rerhwuVxUZ0eBqW6BD2McK8imFYEh/uq7Y1sZ4JEI263MsHrB/ci9TwjE
   bQ+nOyAJ/gJePBZbIKtPOPqGAFVHXzkWVHmsOokOo1iIIPcMwqH9X2RBS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266045837"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266045837"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:26:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709440996"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 05:26:40 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 15/23] perf intel-pt: Use evlist__add_dummy_on_all_cpus() for switch tracking
Date:   Fri,  6 May 2022 15:25:53 +0300
Message-Id: <20220506122601.367589-16-adrian.hunter@intel.com>
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

Use evlist__add_dummy_on_all_cpus() for switch tracking in preparation for
allowing system-wide events on all CPUs while the user requested events are
on only user requested CPUs.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 2eaac4638aab..0ee93894a0da 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -811,18 +811,11 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 			if (!cpu_wide && perf_can_record_cpu_wide()) {
 				struct evsel *switch_evsel;
 
-				err = parse_events(evlist, "dummy:u", NULL);
-				if (err)
-					return err;
+				switch_evsel = evlist__add_dummy_on_all_cpus(evlist);
+				if (!switch_evsel)
+					return -ENOMEM;
 
-				switch_evsel = evlist__last(evlist);
-
-				switch_evsel->core.attr.freq = 0;
-				switch_evsel->core.attr.sample_period = 1;
 				switch_evsel->core.attr.context_switch = 1;
-
-				switch_evsel->core.system_wide = true;
-				switch_evsel->no_aux_samples = true;
 				switch_evsel->immediate = true;
 
 				evsel__set_sample_bit(switch_evsel, TID);
-- 
2.25.1

