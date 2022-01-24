Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB25B497A73
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242212AbiAXImK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:42:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:62581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242227AbiAXImH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013727; x=1674549727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U1vhEzhRFkAEErR6RhgKwR5F23Ejyyp9x2qH5mDyASY=;
  b=FXyOfzvz3MvzFhewAUYrhgkSJ3QebbfMq/QbBK1vpzmdKaQR4EAlsoDE
   mBVJA8LP2WPhk7zl4d8fXuVk9zVEVfIu5ZQw/dkuOzMTk3X/q+7fmzEeN
   7oFxcNE6oWvr4qrnzh0MwbY+gbSJ2ULmvOM0S36FplkwFZfmZtin2oA2M
   +Booh6+KGCPNngDQtFK04atBQPhH7nAKrehZNXYM9CfJu+6OGLS4Q4gkh
   Xl9m0OTd9tDrK302hSTfM75Brwr37ovJ+nYERCcUohj/WdoE34dKM67Yk
   a9PR6wUOgCLLr+gVa8D2BKPjTsCZoampyp9RBBipdIXsBmC58I9Ii+8er
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778320"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778320"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627416940"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:04 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/25] perf intel-pt: pkt-decoder-test: Fix scope of test_data
Date:   Mon, 24 Jan 2022 10:41:37 +0200
Message-Id: <20220124084201.2699795-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make test_data 'static' otherwise it will conflict with any global
variable of the same name.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c b/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
index 2fc882ab24c1..395de4471840 100644
--- a/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
+++ b/tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c
@@ -17,7 +17,7 @@
  * @new_ctx: expected new packet context
  * @ctx_unchanged: the packet context must not change
  */
-struct test_data {
+static struct test_data {
 	int len;
 	u8 bytes[INTEL_PT_PKT_MAX_SZ];
 	enum intel_pt_pkt_ctx ctx;
-- 
2.25.1

