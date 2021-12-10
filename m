Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B56747058C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241479AbhLJQ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:27:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:49130 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240119AbhLJQ05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639153402; x=1670689402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WxLkbCgeJzdOfStmnw0fseQ7x7zavK/SrLOwuha/124=;
  b=A5GMDGB7NM5lVEJpRLhcjybkfFGX59dAY717VAdIrXHr+jABZ6Vofr4B
   f8Xb7ZcVxrtJyeJFM0fVveodT+8FxQwQqOTY0f2PAO1kENIRcyJXgqIZV
   ukDi8tECw907/OWtUdikbfUkVE27ACMlLOtLvZELmqzqcMZIVCBoEvts3
   2NRNmnzs/NHUslr8geSExDSpUw425BofsCfuQFVqnDj5fBsOgvPJBXC+g
   xUrGbo9aNfla0ssBYYI0LN+6ddGvQywp6580jsKtzYAkPUnlP54nkKLI8
   69fx4lTJrWNmLIXhLX2pHoUseMjZAeSIIWWJ8EpGlfxSJS9bGewcPrMwb
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225647104"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="225647104"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 08:23:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="503981824"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2021 08:23:06 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] perf intel-pt: Fix some PGE usage
Date:   Fri, 10 Dec 2021 18:22:57 +0200
Message-Id: <20211210162303.2288710-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210162303.2288710-1-adrian.hunter@intel.com>
References: <20211210162303.2288710-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Packet generation enable (PGE) refers to whether control flow (COFI)
packets are being produced. PGE may be false even when branch-tracing is
enabled, due to being out-of-context, or outside a filter address range.
Fix some missing PGE usage.

Fixes: 839598176b0554 ("perf intel-pt: Allow decoding with branch tracing disabled")
Fixes: 7c1b16ba0e26e6 ("perf intel-pt: Add support for decoding FUP/TIP only")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 5f83937bf8f3..6f6f163161a9 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -2678,6 +2678,7 @@ static int intel_pt_hop_trace(struct intel_pt_decoder *decoder, bool *no_tip, in
 		return HOP_IGNORE;
 
 	case INTEL_PT_TIP_PGD:
+		decoder->pge = false;
 		if (!decoder->packet.count) {
 			intel_pt_set_nr(decoder);
 			return HOP_IGNORE;
@@ -2707,7 +2708,7 @@ static int intel_pt_hop_trace(struct intel_pt_decoder *decoder, bool *no_tip, in
 		intel_pt_set_ip(decoder);
 		if (intel_pt_fup_event(decoder))
 			return HOP_RETURN;
-		if (!decoder->branch_enable)
+		if (!decoder->branch_enable || !decoder->pge)
 			*no_tip = true;
 		if (*no_tip) {
 			decoder->state.type = INTEL_PT_INSTRUCTION;
@@ -2897,7 +2898,7 @@ static bool intel_pt_psb_with_fup(struct intel_pt_decoder *decoder, int *err)
 {
 	struct intel_pt_psb_info data = { .fup = false };
 
-	if (!decoder->branch_enable || !decoder->pge)
+	if (!decoder->branch_enable)
 		return false;
 
 	intel_pt_pkt_lookahead(decoder, intel_pt_psb_lookahead_cb, &data);
@@ -2999,7 +3000,7 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 				break;
 			}
 			intel_pt_set_last_ip(decoder);
-			if (!decoder->branch_enable) {
+			if (!decoder->branch_enable || !decoder->pge) {
 				decoder->ip = decoder->last_ip;
 				if (intel_pt_fup_event(decoder))
 					return 0;
-- 
2.25.1

