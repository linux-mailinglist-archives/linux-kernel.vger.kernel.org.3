Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421EE470590
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbhLJQ1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:27:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:49134 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241221AbhLJQ06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639153403; x=1670689403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9TEIvqVm9IYgt0LOfWL6D7YPruPXPtkk7V+zIYmaxPw=;
  b=meOj1cSv8RIGm8HvpVGambFDA/Iy9A+mOwz3mFyFE2MbNir01o/sziNB
   gMs4pAnGq6CIdFP03d88ACeJ/MCKIugpv3H4RaMi20d0ScW569VevmnqS
   qH64CRs2xz3lOKz0uaZ2BYA1i6riyFrwuXfOAl9uM8mYnCFpp30QvDdtS
   Dm3H+ouF0gVlZnNfmm2lwqcR1yu+fr1jHun9RJgcbiW7AfDYgwg+f6xsP
   ZGzkII/7jv2YfV1BTgZf6BGdJr2N3nr/jvxty+z+fXIRhQdiqphZBNYoj
   tkSOxU2ShNaVE+wACJv3av8IYXTfBkO+ovKMwEl5Q5c5s3ksXzYrNFg0A
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225647120"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="225647120"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 08:23:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="503981854"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2021 08:23:11 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] perf intel-pt: Fix overflow state
Date:   Fri, 10 Dec 2021 18:23:00 +0200
Message-Id: <20211210162303.2288710-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210162303.2288710-1-adrian.hunter@intel.com>
References: <20211210162303.2288710-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An overflow (OVF packet) is treated as an error because it represents a
loss of trace data, but there is no loss of synchronization, so the packet
state should be INTEL_PT_STATE_IN_SYNC not INTEL_PT_STATE_ERR_RESYNC.
To support that, some additional variables must be reset, and the FUP
packet that may follow OVF is treated as an FUP event.

Fixes: f4aa081949e7b6 ("perf tools: Add Intel PT decoder")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 16fbbf07e367..845b0ca866a4 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1249,6 +1249,20 @@ static bool intel_pt_fup_event(struct intel_pt_decoder *decoder)
 		decoder->state.type |= INTEL_PT_BLK_ITEMS;
 		ret = true;
 	}
+	if (decoder->overflow) {
+		decoder->overflow = false;
+		if (!ret && !decoder->pge) {
+			if (decoder->hop) {
+				decoder->state.type = 0;
+				decoder->pkt_state = INTEL_PT_STATE_RESAMPLE;
+			}
+			decoder->pge = true;
+			decoder->state.type |= INTEL_PT_BRANCH | INTEL_PT_TRACE_BEGIN;
+			decoder->state.from_ip = 0;
+			decoder->state.to_ip = decoder->ip;
+			return true;
+		}
+	}
 	if (ret) {
 		decoder->state.from_ip = decoder->ip;
 		decoder->state.to_ip = 0;
@@ -1602,7 +1616,16 @@ static int intel_pt_overflow(struct intel_pt_decoder *decoder)
 	intel_pt_clear_tx_flags(decoder);
 	intel_pt_set_nr(decoder);
 	decoder->timestamp_insn_cnt = 0;
-	decoder->pkt_state = INTEL_PT_STATE_ERR_RESYNC;
+	decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
+	decoder->state.from_ip = decoder->ip;
+	decoder->ip = 0;
+	decoder->pge = false;
+	decoder->set_fup_tx_flags = false;
+	decoder->set_fup_ptw = false;
+	decoder->set_fup_mwait = false;
+	decoder->set_fup_pwre = false;
+	decoder->set_fup_exstop = false;
+	decoder->set_fup_bep = false;
 	decoder->overflow = true;
 	return -EOVERFLOW;
 }
@@ -2957,6 +2980,7 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 
 		case INTEL_PT_TIP_PGE: {
 			decoder->pge = true;
+			decoder->overflow = false;
 			intel_pt_mtc_cyc_cnt_pge(decoder);
 			intel_pt_set_nr(decoder);
 			if (decoder->packet.count == 0) {
@@ -3462,10 +3486,10 @@ static int intel_pt_sync_ip(struct intel_pt_decoder *decoder)
 	decoder->set_fup_pwre = false;
 	decoder->set_fup_exstop = false;
 	decoder->set_fup_bep = false;
+	decoder->overflow = false;
 
 	if (!decoder->branch_enable) {
 		decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
-		decoder->overflow = false;
 		decoder->state.type = 0; /* Do not have a sample */
 		return 0;
 	}
@@ -3480,7 +3504,6 @@ static int intel_pt_sync_ip(struct intel_pt_decoder *decoder)
 		decoder->pkt_state = INTEL_PT_STATE_RESAMPLE;
 	else
 		decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
-	decoder->overflow = false;
 
 	decoder->state.from_ip = 0;
 	decoder->state.to_ip = decoder->ip;
@@ -3699,7 +3722,8 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 
 	if (err) {
 		decoder->state.err = intel_pt_ext_err(err);
-		decoder->state.from_ip = decoder->ip;
+		if (err != -EOVERFLOW)
+			decoder->state.from_ip = decoder->ip;
 		intel_pt_update_sample_time(decoder);
 		decoder->sample_tot_cyc_cnt = decoder->tot_cyc_cnt;
 		intel_pt_set_nr(decoder);
-- 
2.25.1

