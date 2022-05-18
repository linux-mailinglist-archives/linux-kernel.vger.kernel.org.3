Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274B152BE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbiEROvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239105AbiEROve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:51:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2DB1C903;
        Wed, 18 May 2022 07:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652885490; x=1684421490;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6GUnEmMSUTv1RQZ9ktE5wS4moSPg+cH9Gjd3EHfMPUI=;
  b=R0wMXt+gsMlNtQY+uzNu/J9AjdLUWXBofbD/64BkPr8hAKrwZhjhqOhT
   +1BNh1OO29B4KjpEGxpiHQviB5Vmhb8JF1JNSqMEuAE9VLUN0NcraW2tz
   pt4IViHRIOfCskXGgj0eHMDmHY9ic8uPQdrHuGCMkFx3e8jzeXZlldDxj
   CLVCsXPQ31gprZ7HHbKHUDJCOeHMaxcmHFIgA8+pwoHrx2DoOcipfuf9s
   FaX9ex9rtjFm8cm5PRywFzb8QHuNCeLzOsAQX6uXjxoZwk5Ozckmu+vBm
   yaMu5ZB82A9yiA32l+hYJsd+li7hlaN4Dx8VkuCbVI+M/AocoaqbiZffI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="270533038"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="270533038"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 07:51:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="545497515"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2022 07:51:29 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        jolsa@kernel.org, irogers@google.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, zhengjun.xing@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Ammy Yi <ammy.yi@intel.com>
Subject: [PATCH] perf regs x86: Fix arch__intr_reg_mask() for the hybrid platform
Date:   Wed, 18 May 2022 07:51:25 -0700
Message-Id: <20220518145125.1494156-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The X86 specific arch__intr_reg_mask() is to check whether the kernel
and hardware can collect XMM registers. But it doesn't work on some
hybrid platform.

Without the patch on ADL-N,

$perf record -I?
available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
R11 R12 R13 R14 R15

The config of the test event doesn't contain the PMU information. The
kernel may fail to initialize it on the correct hybrid PMU and return
the wrong non-supported information.

Add the PMU information into the config for the hybrid platform. The
same register set is supported among different hybrid PMUs. Checking
the first available one is good enough.

With the patch on ADL-N,

$perf record -I?
available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
R11 R12 R13 R14 R15 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 XMM9
XMM10 XMM11 XMM12 XMM13 XMM14 XMM15

Fixes: 6466ec14aaf4 ("perf regs x86: Add X86 specific arch__intr_reg_mask()")
Reported-by: Ammy Yi <ammy.yi@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/perf_regs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 207c56805c55..0ed177991ad0 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -9,6 +9,8 @@
 #include "../../../util/perf_regs.h"
 #include "../../../util/debug.h"
 #include "../../../util/event.h"
+#include "../../../util/pmu.h"
+#include "../../../util/pmu-hybrid.h"
 
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(AX, PERF_REG_X86_AX),
@@ -284,12 +286,22 @@ uint64_t arch__intr_reg_mask(void)
 		.disabled 		= 1,
 		.exclude_kernel		= 1,
 	};
+	struct perf_pmu *pmu;
 	int fd;
 	/*
 	 * In an unnamed union, init it here to build on older gcc versions
 	 */
 	attr.sample_period = 1;
 
+	if (perf_pmu__has_hybrid()) {
+		/*
+		 * The same register set is supported among different hybrid PMUs.
+		 * Only check the first available one.
+		 */
+		pmu = list_first_entry(&perf_pmu__hybrid_pmus, typeof(*pmu), hybrid_list);
+		attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+	}
+
 	event_attr_init(&attr);
 
 	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
-- 
2.35.1

