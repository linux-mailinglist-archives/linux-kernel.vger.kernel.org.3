Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F41C51C591
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382477AbiEERCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382354AbiEERBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:01:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F065D198
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651769876; x=1683305876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yRpvc/5+lKYY2ErIrQ4yRGXINSu1VtbNTt3ZM+FzuEQ=;
  b=JpJ7Etwqt2tSNQ0pI26lMIGCMD4YOBHSM7a5DT07wRLQdB4hcpsTKqDY
   Frxl+M3DtJWOLPJoUw0DNd41zaKB+H1Z7HrJEg91ttYkKihgVQ4+4OkJa
   AvovRk21xW1Y//jBvgM0wzj1uVV6JAyS1HYBCqfI58m0e7sePCkY4/SEi
   PWCXxkzUqzCtpHM2YTdqpx17DM4UBWCuw73PJ8pqjZjzCWkJGj4yrBGae
   c10gU8QyL3I1/DfmJUj5kMpp2m/IZdY+TcLbkc25vItMwGG/6QLyUCJ2V
   Kc+GRa8KOvbSBIoDA/HkU87bIHqT6tNuuSgJWiEgETdZkGgmjPv/opFZr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248718245"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248718245"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 09:57:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="709032934"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 09:57:18 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V1 15/23] perf intel-pt: Use evlist__add_system_wide_dummy() for switch tracking
Date:   Thu,  5 May 2022 19:56:31 +0300
Message-Id: <20220505165639.361733-16-adrian.hunter@intel.com>
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

Use evlist__add_system_wide_dummy() for switch tracking in preparation for
allowing system-wide events on all CPUs while the user requested events are
on only user requested CPUs.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 2eaac4638aab..e45d64dec57c 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -811,18 +811,11 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 			if (!cpu_wide && perf_can_record_cpu_wide()) {
 				struct evsel *switch_evsel;
 
-				err = parse_events(evlist, "dummy:u", NULL);
-				if (err)
-					return err;
+				switch_evsel = evlist__add_system_wide_dummy(evlist);
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

