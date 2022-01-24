Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F995497A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242239AbiAXImd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:42:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:62581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242283AbiAXImZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013745; x=1674549745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0BBOhXq0bK7bpMu2jJU8HZlBHfIroQqBAKbNWe3rJsA=;
  b=E+02FlsR5S32S488EMvgZ5M/IPfb9L4TEyLOy3CAnSM1nA8iowSr8np/
   kkXTFJeOsQ5joXhprOJchmry6cxNdlW7xQjltc3ItcMe0bUFPNW0Iqvdc
   Bh2c6cwx7vrfISNgWedY22rvmXfj5s6D6jwnCqHS3QWr7/m0hqe+2Vvc0
   QCOREKP4N7VkSI1/m4miU9KAJtmZnbrDRkakVwTDJQTjj8pOu42zQ55lI
   AW3zD0mX6PSCDWUBopfnv6jVlwG8Zl4PX3jNYCjJtNWhcX8Wb+t4uAoGV
   s5eJ2aespDOUdLRcZfHLGfP/TEHK2cWdciGWDVF6t8Cjr6/KNWkoSjkIR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778397"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778397"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417081"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:22 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 09/25] perf tools: Define Intel PT CFE / EVD event
Date:   Mon, 24 Jan 2022 10:41:45 +0200
Message-Id: <20220124084201.2699795-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to other Intel PT synth events, define structures to hold CFE and
EVD data.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/event.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index c59331eea1d9..27ea7bd93df5 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -182,6 +182,7 @@ enum perf_synth_id {
 	PERF_SYNTH_INTEL_PWRX,
 	PERF_SYNTH_INTEL_CBR,
 	PERF_SYNTH_INTEL_PSB,
+	PERF_SYNTH_INTEL_EVT,
 };
 
 /*
@@ -280,6 +281,33 @@ struct perf_synth_intel_psb {
 	u64 offset;
 };
 
+struct perf_synth_intel_evd {
+	union {
+		struct {
+			u8	evd_type;
+			u8	reserved[7];
+		};
+		u64	et;
+	};
+	u64	payload;
+};
+
+/* Intel PT Event Trace */
+struct perf_synth_intel_evt {
+	u32 padding;
+	union {
+		struct {
+			u32	type		:  5,
+				reserved	:  2,
+				ip		:  1,
+				vector		:  8,
+				evd_cnt		: 16;
+		};
+		u32	cfe;
+	};
+	struct perf_synth_intel_evd evd[];
+};
+
 /*
  * raw_data is always 4 bytes from an 8-byte boundary, so subtract 4 to get
  * 8-byte alignment.
-- 
2.25.1

