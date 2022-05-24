Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA0353248A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiEXHz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbiEXHz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:55:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F6D9A991
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653378920; x=1684914920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KNMAtJ9vAz9UQl/ElaKVD54mWn81+SRdQsKEQHlDlas=;
  b=KXKV043rxLQmKeEfyjmZbJBBIyM4QyxHaf+NSqrAbY18T098x50g3hDy
   p/qlQMg2uzLWbfSMcWSrOyixqpluwaKtRhoHRPE7I3o4GfGcrWM4Wg9xN
   nOn9bLIyqWWati18+IlJweMmU8UVD+BmuchRH0NtvHPr1Ccriy0pE16W6
   dW+MJ7NqBxnzKfhuUGl+sRucQXMFdR+oR+2VrkoJhwiEM3ywhlnKIXAS/
   41ZxXtj3xD8y5rXEKP4cdbEyL4RrrQI8iRebgfBlHFHHpKJ5bkiSBukhp
   XXtTm8GwIr+8k5MJ9fuXCcIwXVmMCDAz41DW+PBWoPmp5L/nhYB78Mz2j
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273455460"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273455460"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="717072402"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.52.210])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:18 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 07/15] perf intel-pt: Use evlist__add_dummy_on_all_cpus() for switch tracking
Date:   Tue, 24 May 2022 10:54:28 +0300
Message-Id: <20220524075436.29144-8-adrian.hunter@intel.com>
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

Use evlist__add_dummy_on_all_cpus() for switch tracking in preparation for
allowing system-wide events on all CPUs while the user requested events are
on only user requested CPUs.

Acked-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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

