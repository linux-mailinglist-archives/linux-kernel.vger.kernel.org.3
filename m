Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4EC497A79
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242284AbiAXIm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:42:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:62581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242242AbiAXImW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013742; x=1674549742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wMz/88t6sXC6bchK+SUeYsfhZWrCD/X2I+77HMnVuUg=;
  b=BWElwywS6mRLXNMFiQ3f5bgYjG5kDaqNq2qzK6fk60CMk0TLm100j8pK
   gNHocTfA2KGprg9sl7QKmzrce6rYX9+fc5uEKvUDNAqqniAIxRBeJNuGR
   mgn2QyscJ/yo7nc9VJEr6F/1nFbZQ6ebMtm5RVKXNgTcbofm38Zbv3jym
   hr/qNBudYluTkRNK4pVrrrhly5L4h3uE3wpt6+KGF3vTbQrE67nb2yr8s
   s29Sd5S5bcHSbV8SEaLU2/feiqf1vysMCMoy8vQnoKTOmMoqKeHRiXexw
   YVxq27fsxTNoCadkoceEgjIfwy2mSJchg4K2Z/e8J3SRm2DgOAgsCX5Y7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778358"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778358"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417026"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:16 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/25] perf intel-pt: decoder: Factor out clearing of FUP event variables
Date:   Mon, 24 Jan 2022 10:41:42 +0200
Message-Id: <20220124084201.2699795-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out clearing of FUP event variables, to avoid code duplication.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 3980ee2080ae..5792d536b458 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1206,6 +1206,16 @@ static int intel_pt_walk_insn(struct intel_pt_decoder *decoder,
 	return err;
 }
 
+static void intel_pt_clear_fup_event(struct intel_pt_decoder *decoder)
+{
+	decoder->set_fup_tx_flags = false;
+	decoder->set_fup_ptw = false;
+	decoder->set_fup_mwait = false;
+	decoder->set_fup_pwre = false;
+	decoder->set_fup_exstop = false;
+	decoder->set_fup_bep = false;
+}
+
 static bool intel_pt_fup_event(struct intel_pt_decoder *decoder)
 {
 	enum intel_pt_sample_type type = decoder->state.type;
@@ -1623,12 +1633,7 @@ static int intel_pt_overflow(struct intel_pt_decoder *decoder)
 	decoder->state.from_ip = decoder->ip;
 	decoder->ip = 0;
 	decoder->pge = false;
-	decoder->set_fup_tx_flags = false;
-	decoder->set_fup_ptw = false;
-	decoder->set_fup_mwait = false;
-	decoder->set_fup_pwre = false;
-	decoder->set_fup_exstop = false;
-	decoder->set_fup_bep = false;
+	intel_pt_clear_fup_event(decoder);
 	decoder->overflow = true;
 	return -EOVERFLOW;
 }
@@ -3518,12 +3523,7 @@ static int intel_pt_sync_ip(struct intel_pt_decoder *decoder)
 {
 	int err;
 
-	decoder->set_fup_tx_flags = false;
-	decoder->set_fup_ptw = false;
-	decoder->set_fup_mwait = false;
-	decoder->set_fup_pwre = false;
-	decoder->set_fup_exstop = false;
-	decoder->set_fup_bep = false;
+	intel_pt_clear_fup_event(decoder);
 	decoder->overflow = false;
 
 	if (!decoder->branch_enable) {
-- 
2.25.1

