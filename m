Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F060D5B092D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiIGPtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiIGPt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:49:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D1D10C0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662565768; x=1694101768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YWEdEv2iIKep1g0+qWhBYJegFaPr+gtlXES13egcvqI=;
  b=lQcM8651JWDBGKoyu8/qTqk+SJqilbZChjNt9N/qdngn5HWa4dtDblhM
   9ZcXTcy2q7pmMSygcZfDZSuS+IV58//ppTf1H72quYSwbAYdo6mfZM8Ew
   9NUX+DuonyUsf2Kha8SMpB+Y/ndN9C4oymRF5XSjsdCjRTxN0FvQ6y2yZ
   pPvblwIWzpIS4hon4ggX9hC3W0D8Zj8ZOVT040T9JSNz+kTohwicXPw8F
   t1+cGhzGbZpGwTcAlokCB69A870AsTpI8TvKamtN1qRZqZRdab05dQJIe
   tB02TDHt71PCXPHtmmLkeJTZ1zYRw7P93/yUn6De06gUttmDQ4q9YqPFA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="283911209"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="283911209"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 08:49:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="676243503"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.58.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 08:49:14 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf script: Fix sample type validation of dummy events
Date:   Wed,  7 Sep 2022 18:49:04 +0300
Message-Id: <20220907154904.70883-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dummy events need the sample type only for ID samples and we expect perf
to set up their sample type correctly for that purpose. Consequently
there is no reason to attempt to validate the sample type against
user-specified fields like 'iregs'.

So skip sample type validation for dummy events.

Example:

 Before:

   $ perf record --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p,dummy -c 1000 uname
   Linux
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.017 MB (18 samples) ]
   $ perf script -F ip,sym,iregs
   Samples for 'dummy' event do not have IREGS attribute set. Cannot print 'iregs' field.

 After:

   $ perf script -F ip,sym,iregs
    ffffffffabf816f0 perf_iterate_ctx ABI:2    CX:0x0    DX:0xffffab5802bbfb60    DI:0xffff9f5e8a2a0800    R8:0x1
    ffffffffabe034a0 x86_pmu_filter_match ABI:2    CX:0x0    DX:0xffffab5802bbfc68    DI:0xffff9f5fc7ad0ba0    R8:0xffff9f5fbf0504a0
    ffffffffabe315c0 fpregs_assert_state_consistent ABI:2    CX:0x0    DX:0x0    DI:0xffffffffad0e77f1    R8:0x0
    ffffffffabf90260 perf_event_mmap ABI:2    CX:0x0    DX:0xffffffffabfcedc0    DI:0xffff9f5fbf050540    R8:0x0
    ffffffffabee76c0 __rcu_read_unlock ABI:2    CX:0x70    DX:0xffff9f5e812a300c    DI:0x7    R8:0xffffffffadc93aa0
    ffffffffac85a1a0 debug_smp_processor_id ABI:2    CX:0x0    DX:0xffffab5802bbfd28    DI:0xffffffffad0e77f1    R8:0xffff9f5f69b869e0
    ffffffffac0178e0 policy_nodemask ABI:2    CX:0x7fc123152000    DX:0xffffffffadc8ac80    DI:0x100cca    R8:0x0
        7fc1231880d0 add_to_global_resize ABI:2    CX:0x7fc1231b7650    DX:0x7ffd7e896168    DI:0x5635ea713b0c    R8:0x7fc12317aa50
    ffffffffabfcecc0 vmacache_update ABI:2    CX:0xffff9f5f69ab8000    DX:0xffff9f5f69b861a0    DI:0x7fc123055480    R8:0x0
    ffffffffac85a1a0 debug_smp_processor_id ABI:2    CX:0x0    DX:0x0    DI:0xffffffffad0e77f1    R8:0x1
    ffffffffac85a1a0 debug_smp_processor_id ABI:2    CX:0x0    DX:0xffffab5802bbfdb8    DI:0xffffffffad0e77f1    R8:0xffff9f5f69b86e60
    ffffffffac00c120 PageHeadHuge ABI:2    CX:0x53    DX:0xf    DI:0xffffe312c47c1740    R8:0xffff9f5e83cb66c8
    ffffffffabea1530 preempt_count_add ABI:2    CX:0xffffe312c886aa40    DX:0x5635eb38a    DI:0x1    R8:0x0
    ffffffffabfedb90 flush_tlb_batched_pending ABI:2    CX:0x103a68067    DX:0x1    DI:0xffff9f5e80262c00    R8:0xffffab5802bbfd90
    ffffffffabfe7340 __tlb_remove_page_size ABI:2    CX:0x25    DX:0x1000    DI:0xffffab5802bbfe00    R8:0x33f905025
    ffffffffabfee490 page_remove_rmap ABI:2    CX:0x25    DX:0x0    DI:0xffffe312c4581e00    R8:0x116078025
    ffffffffac85a1a0 debug_smp_processor_id ABI:2    CX:0x40    DX:0x8    DI:0xffff9f622042a540    R8:0x1
    ffffffffabe6be00 vm_area_free ABI:2    CX:0x8015000f    DX:0x80000000    DI:0xffff9f5fbf050000    R8:0x1

Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 585171479876..eb263cdf51ee 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -411,7 +411,7 @@ static int evsel__do_check_stype(struct evsel *evsel, u64 sample_type, const cha
 	int type = output_type(attr->type);
 	const char *evname;
 
-	if (attr->sample_type & sample_type)
+	if (evsel__is_dummy_event(evsel) || attr->sample_type & sample_type)
 		return 0;
 
 	if (output[type].user_set_fields & field) {
-- 
2.25.1

