Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF166497A82
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiAXInH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:43:07 -0500
Received: from mga09.intel.com ([134.134.136.24]:62581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242387AbiAXImp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013765; x=1674549765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wJb9eTAjmQ7zYzdn4Qp13ayT03ao8p4X0rn1JcgJoTI=;
  b=SWNyqe/q6VH8AvZYcY4MUFg4uenRTU8WbBpZpKLAf9R/YEjEwHJyKE2h
   Dv9ppxz+eZ27cCGphBpBXs84YpuKfXwuMmKgBUy8BWins0S0YUOVGjtZX
   9xHiVgKSEnGkHtFQTkAyKhFiDODYhsvZSzboSYHoEKybG7nY3ZF/xd8pW
   jwQ2qIX89QIKJvSremmujJq/CBGi/Zk1cHl3XmnOKl25qXfC0dUjJFBFW
   YED9CX0mFAdGdjhGIQ2f9Cta65Ydj8agwOuV6oiy2RJIinti46s0kkVMd
   +KEo4AMLlwlU7W6nLYJuT7qQD11sZ9lNX5d7tFMj60Sp6h58Jjw/ndzTh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778457"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778457"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417185"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:38 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 16/25] perf intel-pt: Synthesize new D and t flags
Date:   Mon, 24 Jan 2022 10:41:52 +0200
Message-Id: <20220124084201.2699795-17-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update sample flags to represent the state and changes to the interrupt
flag.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index c5b860c842f0..d76e4b865cb0 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1329,6 +1329,8 @@ static void intel_pt_set_pid_tid_cpu(struct intel_pt *pt,
 
 static void intel_pt_sample_flags(struct intel_pt_queue *ptq)
 {
+	struct intel_pt *pt = ptq->pt;
+
 	ptq->insn_len = 0;
 	if (ptq->state->flags & INTEL_PT_ABORT_TX) {
 		ptq->flags = PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TX_ABORT;
@@ -1359,6 +1361,17 @@ static void intel_pt_sample_flags(struct intel_pt_queue *ptq)
 		ptq->flags |= PERF_IP_FLAG_TRACE_BEGIN;
 	if (ptq->state->type & INTEL_PT_TRACE_END)
 		ptq->flags |= PERF_IP_FLAG_TRACE_END;
+
+	if (pt->cap_event_trace) {
+		if (ptq->state->type & INTEL_PT_IFLAG_CHG) {
+			if (!ptq->state->from_iflag)
+				ptq->flags |= PERF_IP_FLAG_INTR_DISABLE;
+			if (ptq->state->from_iflag != ptq->state->to_iflag)
+				ptq->flags |= PERF_IP_FLAG_INTR_TOGGLE;
+		} else if (!ptq->state->to_iflag) {
+			ptq->flags |= PERF_IP_FLAG_INTR_DISABLE;
+		}
+	}
 }
 
 static void intel_pt_setup_time_range(struct intel_pt *pt,
-- 
2.25.1

