Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E9B51C597
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382415AbiEERDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382271AbiEERBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:01:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FBA5D5FF
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651769886; x=1683305886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=raq1KD4MPnIuPYUp96rbTd2w5zATae1PXN5+lX8Jm6M=;
  b=KR+RHik9E+4WjI/LEBjA+um7pu6JV6ZPbTuQhXzoSMNb4N1+FcjHlX6x
   G+T6Ps+rWcmLW51WZst52/Z85MmX+d+X9LPj1PoRpiZgpBjB6Q1GAA+LS
   qMGlTcOHxMBa235xepu0IfG+upbzq5jwO9UzE1EK/wDapf4s29gF+UsNm
   GMMXyMH7bG+doAIwEzO/pe/7BdpagVNq2Rv+YJQdmbHp6hzPr1VzM9OIi
   WqKBukm5uvNXxRQCBPPQl8srp+DVEb3Qul7ZY5YmYsg7ufJLuf0RRae6B
   mqDnX6yeCNAmTShkBsgh5Fb9D6GRs8kTeUl9PbAZDEwaAgM/QWP9O+bAH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248718317"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248718317"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 09:57:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="709033059"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 09:57:33 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V1 21/23] libperf evsel: Add comments for booleans
Date:   Thu,  5 May 2022 19:56:37 +0300
Message-Id: <20220505165639.361733-22-adrian.hunter@intel.com>
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

Add comments for 'system_wide' and 'requires_cpu' booleans

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/include/internal/evsel.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 77fbb8b97e5c..f613c3ae868e 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -49,7 +49,15 @@ struct perf_evsel {
 
 	/* parse modifier helper */
 	int			 nr_members;
+	/*
+	 * system_wide is for events that need to be on every CPU, irrespective
+	 * of user requested CPUs or threads.
+	 */
 	bool			 system_wide;
+	/*
+	 * Some events, for example uncore events, require a CPU.
+	 * i.e. it cannot be -1
+	 */
 	bool			 requires_cpu;
 	int			 idx;
 };
-- 
2.25.1

