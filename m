Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D70497A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiAXIod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:44:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:62581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242266AbiAXIm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013747; x=1674549747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y+XqUkFbrC3xNp4+likfQxgrMPkd8q8VKsUjVkQGOV8=;
  b=TqRf4hBS/7yN+SPj0AhyuZblvIRiS1EibLQPZuTnFX05oqL2FqD1WuEb
   ZyDmjQ3D78GPu0kFjgcB2fIZYYVmV/JiV05jOl870ZOUNnWJExV8CLvRy
   k01aLilvDAir1EBsme46A7lXdhpQCxL2ZflEd8Hy41H68vUaPc0RFK7nN
   iyWsRRvJDo1GIqUegT5y8jvVEIX+VWcTXMDqjtnSUOI9Aj2BwtcGlQRth
   FvAq7VVDOJaYYEHWhib1HAuE/SjsGLEonAWOv6cfjDxaS7boGdY/6Qu1d
   /wH1rIY8R/YoiAGc1F7Ein37fnNnxzGrW9p/qRtvu4cDXs+8N/ietktr+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778409"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778409"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417093"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:25 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/25] perf tools: Define Intel PT iflag synthesized event
Date:   Mon, 24 Jan 2022 10:41:46 +0200
Message-Id: <20220124084201.2699795-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to other Intel PT synth events, define a structure to hold
information about a change to the interrupt flag.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/event.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 27ea7bd93df5..9354619953e9 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -183,6 +183,7 @@ enum perf_synth_id {
 	PERF_SYNTH_INTEL_CBR,
 	PERF_SYNTH_INTEL_PSB,
 	PERF_SYNTH_INTEL_EVT,
+	PERF_SYNTH_INTEL_IFLAG_CHG,
 };
 
 /*
@@ -308,6 +309,18 @@ struct perf_synth_intel_evt {
 	struct perf_synth_intel_evd evd[];
 };
 
+struct perf_synth_intel_iflag_chg {
+	u32 padding;
+	union {
+		struct {
+			u32	iflag		:  1,
+				via_branch	:  1;
+		};
+		u32	flags;
+	};
+	u64	branch_ip; /* If via_branch */
+};
+
 /*
  * raw_data is always 4 bytes from an 8-byte boundary, so subtract 4 to get
  * 8-byte alignment.
-- 
2.25.1

