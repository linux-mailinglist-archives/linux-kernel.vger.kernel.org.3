Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC9E497A85
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242445AbiAXInY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:43:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:62581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242378AbiAXInG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013785; x=1674549785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eikBDUZ3omO3sAq/4CvQOCJc/wxTAuBw/ebwEZMCkm0=;
  b=IlOsXfdb3Lw4GRhUnil7+bqPqnLZbPFw+wAysA5yw4egaKmOCF7uVUtS
   wUM5c/tTJxQLCyNsj0hrkuxgNta/5t8/ONGjzLZiV4FwGqf5A53xftNX2
   ymYWs/yOyGbNeEURD1Zp3OsFs11kh/795FC0pS3x0ESjHmZLwIv6Wnw6G
   V4Q7ssPaekOAlKf/ixEBbo/Sc7m2gm6jyic/JhJr98oTwx7Y3veFsRVRY
   4GG16So7RLpLftqK1dDSmoDLs3tEymIKCTiVXfisGko7orzCQDRwP2fBy
   GVhE9ky+BHJOju9ewcf8o4AkH6C5s5S0uyB1YEBQEYqYuc9dQwApgJkzx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778473"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778473"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417221"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:45 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 19/25] perf script: Display Intel PT iflag synthesized event
Date:   Mon, 24 Jan 2022 10:41:55 +0200
Message-Id: <20220124084201.2699795-20-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to other Intel PT synth events, display changes to the interrupt
flag represented by the MODE.Exec packet.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 08e8ef5fcf83..517d5f7a7d39 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1848,6 +1848,19 @@ static int perf_sample__fprintf_synth_evt(struct perf_sample *sample, FILE *fp)
 	return len + perf_sample__fprintf_pt_spacing(len, fp);
 }
 
+static int perf_sample__fprintf_synth_iflag_chg(struct perf_sample *sample, FILE *fp)
+{
+	struct perf_synth_intel_iflag_chg *data = perf_sample__synth_ptr(sample);
+	int len;
+
+	if (perf_sample__bad_synth_size(sample, *data))
+		return 0;
+
+	len = fprintf(fp, " IFLAG: %d->%d %s branch", !data->iflag, data->iflag,
+		      data->via_branch ? "via" : "non");
+	return len + perf_sample__fprintf_pt_spacing(len, fp);
+}
+
 static int perf_sample__fprintf_synth(struct perf_sample *sample,
 				      struct evsel *evsel, FILE *fp)
 {
@@ -1868,6 +1881,8 @@ static int perf_sample__fprintf_synth(struct perf_sample *sample,
 		return perf_sample__fprintf_synth_psb(sample, fp);
 	case PERF_SYNTH_INTEL_EVT:
 		return perf_sample__fprintf_synth_evt(sample, fp);
+	case PERF_SYNTH_INTEL_IFLAG_CHG:
+		return perf_sample__fprintf_synth_iflag_chg(sample, fp);
 	default:
 		break;
 	}
-- 
2.25.1

