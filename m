Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AEE47058F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243096AbhLJQ1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:27:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:49136 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241289AbhLJQ06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639153403; x=1670689403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H5N/7xSGC/z+hRkn27Qrsr1/aud0j6HbfMxfr5FVkV8=;
  b=b0GdAkJALtSrfnP4y13PqKyYoaQxGimd9OGYT4++dg6jp0DcM34PJYuo
   XQQe6o+lPrMZqcfwI596rdL3SXlAePvZwLN/i5qiph6CeLWPLV7tlKdQT
   7kS4/7RfXmDUSdSK6E/VepLfTiojPCZRLHyzlwO6tKSVtDTqQjxVfxq2u
   FJHswOKjiWY9PEt4d4Cg+KVOLTz/hMPD39E8Jp/GhCEi1Bf4zJEsg5V6Y
   MJz8JpRcKj0Sk3WIqh3SmdG5eZiMZMyKAyj2xjvwxKVme9cu99a2e7Km5
   ldbmkj5pWJ3j2J/GYTlIfQpT5f4PlPNg/rew8hIpRsU90DS45TwTu83h8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225647130"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="225647130"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 08:23:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="503981878"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2021 08:23:14 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] perf intel-pt: Fix missing 'instruction' events with 'q' option
Date:   Fri, 10 Dec 2021 18:23:02 +0200
Message-Id: <20211210162303.2288710-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210162303.2288710-1-adrian.hunter@intel.com>
References: <20211210162303.2288710-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FUP packets contain IP information, which makes them also an 'instruction'
event in 'hop' mode i.e. the itrace 'q' option.  That wasn't happening, so
restructure the logic so that FUP events are added along with appropriate
'instruction' and 'branch' events.

Fixes: 7c1b16ba0e26e6 ("perf intel-pt: Add support for decoding FUP/TIP only")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 75b504aed7f4..0e013c2d9eb4 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -2683,6 +2683,8 @@ static int intel_pt_scan_for_psb(struct intel_pt_decoder *decoder);
 /* Hop mode: Ignore TNT, do not walk code, but get ip from FUPs and TIPs */
 static int intel_pt_hop_trace(struct intel_pt_decoder *decoder, bool *no_tip, int *err)
 {
+	*err = 0;
+
 	/* Leap from PSB to PSB, getting ip from FUP within PSB+ */
 	if (decoder->leap && !decoder->in_psb && decoder->packet.type != INTEL_PT_PSB) {
 		*err = intel_pt_scan_for_psb(decoder);
@@ -2723,18 +2725,21 @@ static int intel_pt_hop_trace(struct intel_pt_decoder *decoder, bool *no_tip, in
 		if (!decoder->packet.count)
 			return HOP_IGNORE;
 		intel_pt_set_ip(decoder);
-		if (intel_pt_fup_event(decoder))
-			return HOP_RETURN;
+		if (decoder->set_fup_mwait || decoder->set_fup_pwre)
+			*no_tip = true;
 		if (!decoder->branch_enable || !decoder->pge)
 			*no_tip = true;
 		if (*no_tip) {
 			decoder->state.type = INTEL_PT_INSTRUCTION;
 			decoder->state.from_ip = decoder->ip;
 			decoder->state.to_ip = 0;
+			intel_pt_fup_event(decoder);
 			return HOP_RETURN;
 		}
+		intel_pt_fup_event(decoder);
+		decoder->state.type |= INTEL_PT_INSTRUCTION | INTEL_PT_BRANCH;
 		*err = intel_pt_walk_fup_tip(decoder);
-		if (!*err)
+		if (!*err && decoder->state.to_ip)
 			decoder->pkt_state = INTEL_PT_STATE_RESAMPLE;
 		return HOP_RETURN;
 
-- 
2.25.1

