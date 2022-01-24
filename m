Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E797497A89
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242329AbiAXInx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:43:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:62624 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242393AbiAXInr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013827; x=1674549827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8q/Wt44pMdRN3PKEEkQ91EMdy7sMo2325SWA5ltc8EE=;
  b=kLuU5r9K6eiATsCE386SpsTgRiuQzHYj2EyF1+y953CsmMW88Ltu8Zof
   P6cSd6XLhuKiZN+o/WvmyB6EKwRKZ+5neDA7GLThld1ny5Ti0V28RApRp
   jt+IMF1A8YeZPuE+Dwt5t0fF8j58f5McDUjO39H2JXT3I6i5JYD6TgzsV
   ff8YLUg4iw1vIvXcq/6IG94aVAIcI8TmK3HHAqQ7EFVI0S98GvhMZ3Z6T
   0b0OiDL/IreL7aQ17ug2nHEw//mPMtY19S4Zln0gsyG08XJMHt/0GTslM
   ODyftx6G2/b2yPCPXUYyOaIxtjXuO9mvSdJibyQXjHIB8DCGz5VjQGKIN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778508"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778508"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417280"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:52 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 22/25] perf scripting python: Add all sample flags to DB export
Date:   Mon, 24 Jan 2022 10:41:58 +0200
Message-Id: <20220124084201.2699795-23-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the transaction flag (x) is kept separate from branch flags.
Instead of doing the same for the interrupt disabled flags (D and t), add
all flags so that new flags will not need to be handled separately in the
future.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index e752e1f4a5f0..413f2d19c13f 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1216,7 +1216,7 @@ static void python_export_sample_table(struct db_export *dbe,
 	struct tables *tables = container_of(dbe, struct tables, dbe);
 	PyObject *t;
 
-	t = tuple_new(24);
+	t = tuple_new(25);
 
 	tuple_set_d64(t, 0, es->db_id);
 	tuple_set_d64(t, 1, es->evsel->db_id);
@@ -1242,6 +1242,7 @@ static void python_export_sample_table(struct db_export *dbe,
 	tuple_set_d64(t, 21, es->call_path_id);
 	tuple_set_d64(t, 22, es->sample->insn_cnt);
 	tuple_set_d64(t, 23, es->sample->cyc_cnt);
+	tuple_set_s32(t, 24, es->sample->flags);
 
 	call_object(tables->sample_handler, t, "sample_table");
 
-- 
2.25.1

