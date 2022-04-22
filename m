Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6DE50BCE3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447012AbiDVQ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390632AbiDVQ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:27:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E285F3D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650644695; x=1682180695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yRpvc/5+lKYY2ErIrQ4yRGXINSu1VtbNTt3ZM+FzuEQ=;
  b=CH7wft1TsXLGXU0lCNh8lNC6SassYSn7Z/EDAPDfwSFTQSwbPTOV41wC
   4Ftb2OfGSQFfj9z2Kc4nUh0qoijLID3Irj9fQb1iAVlu5wOuRQfGjs1+T
   e/ilAMbaOR6d67NKpa8BaHsTCeLeJEwzIn/hJWos7myjx/amKBab1NOCU
   18m15M0hFre2gNGEUjYo2LPgjbIG6i+Ac9CJefUSI1lJv1d9ZttujmXHt
   aefoaJ5OuEuQCNNFsK4WQ+we+zxIh7aiTTCq1jhrkEpZ4s73/mScZ6rdw
   UTTfxfRnSpUdEk9WNoiGPi8pmUx+zhkKub9UtX+APTk0X/PDn4gvlO7TV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264886003"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264886003"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577979045"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 09:24:45 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 15/21] perf intel-pt: Use evlist__add_system_wide_dummy() for switch tracking
Date:   Fri, 22 Apr 2022 19:23:56 +0300
Message-Id: <20220422162402.147958-16-adrian.hunter@intel.com>
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

