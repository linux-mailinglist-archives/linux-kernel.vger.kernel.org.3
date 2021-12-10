Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE2447058D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243095AbhLJQ1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:27:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:49130 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241134AbhLJQ05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639153402; x=1670689402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4JV67OqeZITDn3Xe0736eLRCaM2iuGMEFtQuTA4+C1U=;
  b=c/D6i1/b/ZcA3vHLt+VSv86v4aE6swt0NeKI64L9+3ws980fHRxyhvuo
   S4URmrPEzxVJGk6VhMr2yNyfgEe1v7bBuFgh3VbVsvX9uLXpo1n1wVz5L
   nF20htH1FXrJMbE1qmE2kU4PvU929uUBUJ/06jfF0I1QSCI/ODCvUEm7+
   wN5FkoT06Pe8RWaydSU6FKX8UWK1qEd6TuuPjtD0j3Gvh12tiN4Mmw0Ji
   ktYTnlmndXfk7VVB9IS687nWDBq2IfOhl1VS+JGz/8D++6yk0XLSTHFT2
   +yBs9sJtG0vQouuJSQhUsmbUEEojBwRset0EnxKjLXuJhMvH27cLuO6bZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225647112"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="225647112"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 08:23:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="503981842"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2021 08:23:09 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] perf intel-pt: Fix intel_pt_fup_event() assumptions
Date:   Fri, 10 Dec 2021 18:22:59 +0200
Message-Id: <20211210162303.2288710-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210162303.2288710-1-adrian.hunter@intel.com>
References: <20211210162303.2288710-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_pt_fup_event() assumes it can overwrite the state type if there has
been an FUP event, but this is an unnecessary and unexpected constraint on
callers. Fix by touching only the state type flags that are affected by an
FUP event.

Fixes: a472e65fc490a ("perf intel-pt: Add decoder support for ptwrite and power event packets")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 32 ++++++++-----------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index bddf98123dc3..16fbbf07e367 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1205,61 +1205,55 @@ static int intel_pt_walk_insn(struct intel_pt_decoder *decoder,
 
 static bool intel_pt_fup_event(struct intel_pt_decoder *decoder)
 {
+	enum intel_pt_sample_type type = decoder->state.type;
 	bool ret = false;
 
+	decoder->state.type &= ~INTEL_PT_BRANCH;
+
 	if (decoder->set_fup_tx_flags) {
 		decoder->set_fup_tx_flags = false;
 		decoder->tx_flags = decoder->fup_tx_flags;
-		decoder->state.type = INTEL_PT_TRANSACTION;
+		decoder->state.type |= INTEL_PT_TRANSACTION;
 		if (decoder->fup_tx_flags & INTEL_PT_ABORT_TX)
 			decoder->state.type |= INTEL_PT_BRANCH;
-		decoder->state.from_ip = decoder->ip;
-		decoder->state.to_ip = 0;
 		decoder->state.flags = decoder->fup_tx_flags;
-		return true;
+		ret = true;
 	}
 	if (decoder->set_fup_ptw) {
 		decoder->set_fup_ptw = false;
-		decoder->state.type = INTEL_PT_PTW;
+		decoder->state.type |= INTEL_PT_PTW;
 		decoder->state.flags |= INTEL_PT_FUP_IP;
-		decoder->state.from_ip = decoder->ip;
-		decoder->state.to_ip = 0;
 		decoder->state.ptw_payload = decoder->fup_ptw_payload;
-		return true;
+		ret = true;
 	}
 	if (decoder->set_fup_mwait) {
 		decoder->set_fup_mwait = false;
-		decoder->state.type = INTEL_PT_MWAIT_OP;
-		decoder->state.from_ip = decoder->ip;
-		decoder->state.to_ip = 0;
+		decoder->state.type |= INTEL_PT_MWAIT_OP;
 		decoder->state.mwait_payload = decoder->fup_mwait_payload;
 		ret = true;
 	}
 	if (decoder->set_fup_pwre) {
 		decoder->set_fup_pwre = false;
 		decoder->state.type |= INTEL_PT_PWR_ENTRY;
-		decoder->state.type &= ~INTEL_PT_BRANCH;
-		decoder->state.from_ip = decoder->ip;
-		decoder->state.to_ip = 0;
 		decoder->state.pwre_payload = decoder->fup_pwre_payload;
 		ret = true;
 	}
 	if (decoder->set_fup_exstop) {
 		decoder->set_fup_exstop = false;
 		decoder->state.type |= INTEL_PT_EX_STOP;
-		decoder->state.type &= ~INTEL_PT_BRANCH;
 		decoder->state.flags |= INTEL_PT_FUP_IP;
-		decoder->state.from_ip = decoder->ip;
-		decoder->state.to_ip = 0;
 		ret = true;
 	}
 	if (decoder->set_fup_bep) {
 		decoder->set_fup_bep = false;
 		decoder->state.type |= INTEL_PT_BLK_ITEMS;
-		decoder->state.type &= ~INTEL_PT_BRANCH;
+		ret = true;
+	}
+	if (ret) {
 		decoder->state.from_ip = decoder->ip;
 		decoder->state.to_ip = 0;
-		ret = true;
+	} else {
+		decoder->state.type = type;
 	}
 	return ret;
 }
-- 
2.25.1

