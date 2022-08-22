Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AD559C1C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiHVOkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbiHVOj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:39:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0D332EFF
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YXpJDAwoP3DXJXHxWw6bMfnMGyUA4AOgddWHUmODCAU=; b=glMpQmFs4x79IyothW/L1sISwA
        cMi2Ot58sW1KnM7EriEPrEYe8T+IzmPjj3nJpoanvl/knnPNio/XN3Xgd8EVUapcnO1valSzUatGQ
        tahgQrUbuJPHDPBiwZR5WYB+LQ7V4RPJv/sbkINyccXyYkZ/QkzYDrSa6/62VNcT51GG/P+vjDqGS
        cZ1TNIyg64oyYv2hLDSaZ6X8PHbeKH4+eTk8gc63s2gHKtZVP/aAMT3Xg2ELAZ+eeaR27agAjjdxl
        jstHwLtdXpHNgCTEkSPoqKcXfVvcI+OBnjak24zkAGW5wuFvI+COmWGPqc3kFJ9W0uSIqVuiuEsJt
        4PljLjtw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ8aU-00EMZm-E1; Mon, 22 Aug 2022 14:39:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 429AB9804A3; Mon, 22 Aug 2022 16:39:32 +0200 (CEST)
Date:   Mon, 22 Aug 2022 16:39:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error
 for Alder Lake N
Message-ID: <YwOVJO05Ge8V9y5i@worktop.programming.kicks-ass.net>
References: <20220818181530.2355034-1-kan.liang@linux.intel.com>
 <Yv+ggf6PRjL8Eio1@worktop.programming.kicks-ass.net>
 <80eea4f7-bb1e-ebb9-37db-9317b8d9c28f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80eea4f7-bb1e-ebb9-37db-9317b8d9c28f@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 09:28:31AM -0400, Liang, Kan wrote:
> 
> 
> On 2022-08-19 10:38 a.m., Peter Zijlstra wrote:
> > On Thu, Aug 18, 2022 at 11:15:30AM -0700, kan.liang@linux.intel.com wrote:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> For some Alder Lake N machine, the below unchecked MSR access error may be
> >> triggered.
> >>
> >> [ 0.088017] rcu: Hierarchical SRCU implementation.
> >> [ 0.088017] unchecked MSR access error: WRMSR to 0x38f (tried to write
> >> 0x0001000f0000003f) at rIP: 0xffffffffb5684de8 (native_write_msr+0x8/0x30)
> >> [ 0.088017] Call Trace:
> >> [ 0.088017] <TASK>
> >> [ 0.088017] __intel_pmu_enable_all.constprop.46+0x4a/0xa0
> > 
> > FWIW, I seem to get the same error when booting KVM on my ADL. I'm
> > fairly sure the whole CPUID vs vCPU thing is a trainwreck.
> 
> We will enhance the CPUID to address the issues. Hopefully, we can have
> them supported in the next generation.
> 

How about this?

---
[    0.170231] Performance Events: Alderlake Hybrid events, full-width counters, Intel PMU driver.
[    0.171420] core: hybrid PMU and virt are incompatible


 arch/x86/events/intel/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2db93498ff71..232e24324fd7 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4473,6 +4473,11 @@ static bool init_hybrid_pmu(int cpu)
 	struct x86_hybrid_pmu *pmu = NULL;
 	int i;
 
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+		pr_warn_once("hybrid PMU and virt are incompatible\n");
+		return false;
+	}
+
 	if (!cpu_type && x86_pmu.get_hybrid_cpu_type)
 		cpu_type = x86_pmu.get_hybrid_cpu_type();
 
