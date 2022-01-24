Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79C9497A84
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiAXInV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:43:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:62624 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242281AbiAXInA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013780; x=1674549780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mDOEF1umuCiDtDZCtLqE0fShk/Up4rH4HVDS85Hwz7k=;
  b=LXKZRAHd2JlWe6eLJHdkIs7JsL/bA2Huh3itbRcuDNaN64ZlnaocKOyU
   bTwB7ESKef4aYlN9tFlj0SXhYYDN6yV8E9UmhQQGe5dGWTdPhR6mcjowa
   xVxjtdPOyNoW/C+zUP800Hv2EVNTbW6Dxwoun7hoB86cojfbqKffAxf3f
   bisdg2i7zZyvRn/zwG+X2d8Gr1gfsulBm4nqH4XWQ4QmXqrptuDA11xr4
   y1E6dXrzgcIoih0Q6W3ufm1WmjEU+0biPeebOf8WQna6kAgpl8hBGQhCt
   PKSQ8ejmCCfc+zGMxtuoYdagbKVqcnw/Imny55KXsaVSXtU5YjdGQFWfd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778468"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778468"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417212"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:42 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 18/25] perf script: Display Intel PT CFE / EVD synthesized event
Date:   Mon, 24 Jan 2022 10:41:54 +0200
Message-Id: <20220124084201.2699795-19-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to other Intel PT synth events, display Event Trace events recorded
by CFE / EVD packets.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index abae8184e171..08e8ef5fcf83 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1811,6 +1811,43 @@ static int perf_sample__fprintf_synth_psb(struct perf_sample *sample, FILE *fp)
 	return len + perf_sample__fprintf_pt_spacing(len, fp);
 }
 
+/* Intel PT Event Trace */
+static int perf_sample__fprintf_synth_evt(struct perf_sample *sample, FILE *fp)
+{
+	struct perf_synth_intel_evt *data = perf_sample__synth_ptr(sample);
+	const char *cfe[32] = {NULL, "INTR", "IRET", "SMI", "RSM", "SIPI",
+			       "INIT", "VMENTRY", "VMEXIT", "VMEXIT_INTR",
+			       "SHUTDOWN"};
+	const char *evd[64] = {"PFA", "VMXQ", "VMXR"};
+	const char *s;
+	int len, i;
+
+	if (perf_sample__bad_synth_size(sample, *data))
+		return 0;
+
+	s = cfe[data->type];
+	if (s) {
+		len = fprintf(fp, " cfe: %s IP: %d vector: %u",
+			      s, data->ip, data->vector);
+	} else {
+		len = fprintf(fp, " cfe: %u IP: %d vector: %u",
+			      data->type, data->ip, data->vector);
+	}
+	for (i = 0; i < data->evd_cnt; i++) {
+		unsigned int et = data->evd[i].evd_type & 0x3f;
+
+		s = evd[et];
+		if (s) {
+			len += fprintf(fp, " %s: %#" PRIx64,
+				       s, data->evd[i].payload);
+		} else {
+			len += fprintf(fp, " EVD_%u: %#" PRIx64,
+				       et, data->evd[i].payload);
+		}
+	}
+	return len + perf_sample__fprintf_pt_spacing(len, fp);
+}
+
 static int perf_sample__fprintf_synth(struct perf_sample *sample,
 				      struct evsel *evsel, FILE *fp)
 {
@@ -1829,6 +1866,8 @@ static int perf_sample__fprintf_synth(struct perf_sample *sample,
 		return perf_sample__fprintf_synth_cbr(sample, fp);
 	case PERF_SYNTH_INTEL_PSB:
 		return perf_sample__fprintf_synth_psb(sample, fp);
+	case PERF_SYNTH_INTEL_EVT:
+		return perf_sample__fprintf_synth_evt(sample, fp);
 	default:
 		break;
 	}
-- 
2.25.1

