Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D80563DC9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 04:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiGBCfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 22:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiGBCfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 22:35:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A4B23164;
        Fri,  1 Jul 2022 19:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656729298; x=1688265298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WCSzslw9U/mYhVAHLXe921e3DDc5EmNjta+XRNlKj9Y=;
  b=Vm1B2RmD1fUGkP1B5SzLWmEvtmebj83UJ/Z5TGcxmW/y5wzVqPbBYBzg
   gK7DckCzC27Y3WOCsqQehNae4wM2elEROF/GT1pWcxVIBRL/mjywT5Y/a
   7YZAGJu6nPwtqFVY4qq4RIFTpTmjk0q3+6LB5L/6rSNuhk7HI9W8Tajud
   Tb2GihchgStw6l6YZYwDzHAwIJ/gFp9qCO7NDcArz4kW+sXIzVuMO3jzT
   JO+sPbJZekSesbyONfN4KIcCof2OkYNxFM3oE4d9MWfFuSE/BPx1Ilc3x
   0iDX01xZfL3zUbJCpwgJzlJZSElRtr7RSktF1Svgwck7NGM2dIJd0KCsr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="369103824"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="369103824"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 19:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="589525825"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 01 Jul 2022 19:34:55 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH 2/2] perf test: Fix test case 87 ("perf record tests") for hybrid systems
Date:   Sat,  2 Jul 2022 10:35:36 +0800
Message-Id: <20220702023536.2661899-2-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220702023536.2661899-1-zhengjun.xing@linux.intel.com>
References: <20220702023536.2661899-1-zhengjun.xing@linux.intel.com>
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

The test case 87 ("perf record tests") failed on hybrid systems,the event
"cpu/br_inst_retired.near_call/p" is only for non-hybrid system. Correct
the test event to support both non-hybrid and hybrid systems.

Before:
 # ./perf test 87
 87: perf record tests                                   : FAILED!

After:
 # ./perf test 87
 87: perf record tests                                   : Ok

Fixes: 24f378e66021 ("perf test: Add basic perf record tests")
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 00c7285ce1ac..301f95427159 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -61,7 +61,7 @@ test_register_capture() {
     echo "Register capture test [Skipped missing registers]"
     return
   fi
-  if ! perf record -o - --intr-regs=di,r8,dx,cx -e cpu/br_inst_retired.near_call/p \
+  if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p \
     -c 1000 --per-thread true 2> /dev/null \
     | perf script -F ip,sym,iregs -i - 2> /dev/null \
     | egrep -q "DI:"
-- 
2.25.1

