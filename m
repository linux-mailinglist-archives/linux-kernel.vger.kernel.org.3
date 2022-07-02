Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E4E563DCA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 04:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiGBCe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 22:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGBCey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 22:34:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055D01ADAE;
        Fri,  1 Jul 2022 19:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656729294; x=1688265294;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SlJdL0k2KQJOdIUSrDncWRkM52Najqwb+GwPWfuTyAM=;
  b=MsraHRpqx3uuaGFZA1RKN+ZOmgaVn/4YjTPabluZe5xgwhlpuA7WXgcW
   xRKBXIPcUA6h0bnaSxzVS32JyOQK0/8EAihSjXmBhBOMGJsyX5Vn0PIem
   ea6IpERZSFr5sRRhzDSALoYida7BlPIAx89jc14H1w2p+JCSXRhW0sfCp
   jwVcPxKGNjs4+kk52YlZ/FErTY90JxdI8+qkc5/FKE6opDS/uOWqyAltg
   bcMnP/60t4t87w7kPhyW9NuwPXiQKCZKCwXhMlxgwg+tCOUMQCYs9DMTN
   BMqwgk97MlnDlOgCp/FSJ0gL9BEG7Efl511ueMWf9uYdM9tVehpLUjNH3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="369103814"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="369103814"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 19:34:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="589525817"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 01 Jul 2022 19:34:50 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH 1/2] perf record: Fix "--per-thread" option for hybrid machines
Date:   Sat,  2 Jul 2022 10:35:35 +0800
Message-Id: <20220702023536.2661899-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Commit b91e5492f9d7 ("perf record: Add a dummy event on hybrid systems to
collect metadata records") adds a dummy event on hybrid systems to fix the
symbol "unknown" issue when the workload is created in a P-core but runs
on an E-core. When "--per-thread" is enabled, the nr_cpus is reduced to 1,
 adding a dummy event is useless for this issue, and it will also cause
"failed to mmap with 22 (Invalid argument)". This patch stops adding dummy
events when the option "--per-thread" is enabled, then the option can work
on hybrid machines.

Before:

 # ./perf record -e cycles:u --per-thread  sleep 1
 failed to mmap with 22 (Invalid argument)

After:

 # ./perf record -e cycles:u --per-thread  sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.002 MB perf.data (6 samples) ]

Fixes: b91e5492f9d7 ("perf record: Add a dummy event on hybrid systems to collect metadata records")
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e1edd4e98358..44ea2dd424fe 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1223,7 +1223,7 @@ static int record__open(struct record *rec)
 	 * of waiting or event synthesis.
 	 */
 	if (opts->initial_delay || target__has_cpu(&opts->target) ||
-	    perf_pmu__has_hybrid()) {
+	    (perf_pmu__has_hybrid() && !opts->target.per_thread)) {
 		pos = evlist__get_tracking_event(evlist);
 		if (!evsel__is_dummy_event(pos)) {
 			/* Set up dummy event. */
-- 
2.25.1

