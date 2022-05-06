Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D9C51D7B5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392026AbiEFMcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391970AbiEFMbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:31:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6082469CD5
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651840018; x=1683376018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=liQq9gf7AarOvqwtlQThYv0FU3CLHluG+yZPknBXwcQ=;
  b=bR+D+w7zgBCaHh7LKLvyFqIuK9XFCCN0Lf25jBC3VlYTrWg0xNfR0D6y
   Xg2sYGrQaPTRGnI7KH6LumYYde+aBxnrVsgWJBDWlmIBV6AA6ZtFBV+Zk
   UicVWT/mW4YqOynFbB6NtSxhagepLfB3WpIDp3y5zBLv5/k76H0PsppUP
   A4yjzWLeTdspXkaqkB1NYOin+rNIVrrE30J+wSmYllIM3tAVu1tubp7/B
   JhXeiVmmLdxey9ea19D2UEaR4Nqxwypqjm9B/dQzpXnZR6cz2B2FS2oy/
   CragwiJxmcyCBUpn0oBW9G2qDrR0JYQXWK+4+plfTIt54u0CQawmW60y4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266045877"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266045877"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:26:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709441155"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 05:26:55 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 21/23] libperf evsel: Add comments for booleans
Date:   Fri,  6 May 2022 15:25:59 +0300
Message-Id: <20220506122601.367589-22-adrian.hunter@intel.com>
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

Add comments for 'system_wide' and 'requires_cpu' booleans

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/include/internal/evsel.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 77fbb8b97e5c..cc8f1ba790bd 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -49,7 +49,16 @@ struct perf_evsel {
 
 	/* parse modifier helper */
 	int			 nr_members;
+	/*
+	 * system_wide is for events that need to be on every CPU, irrespective
+	 * of user requested CPUs or threads. Map propagation will not override
+	 * this events own_cpus, which will contribute to evlist all_cpus.
+	 */
 	bool			 system_wide;
+	/*
+	 * Some events, for example uncore events, require a CPU.
+	 * i.e. it cannot be the 'any CPU' value of -1.
+	 */
 	bool			 requires_cpu;
 	int			 idx;
 };
-- 
2.25.1

