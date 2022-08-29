Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982995A46EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiH2KPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiH2KOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:14:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F18323
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BfqUEpfAtKviGOSi1l2C06+GNHziXV+kCVcVUMnSczs=; b=bVG7AOxUlP0Rrd16vth0/ROqe2
        SDbP3okR9dkwOKvyOBdNZU7TvrdriFmRGp0wLcQLHkSeB7qWReCDsA+p3UnvcnkQd9ljRiQSfo0N7
        fWy+/w54al02jMeCVuDmEfLMs5bLf51dmGcQd9RclCHNHN58fht6G+YCMtuE32dajQsEJEvLpO5kZ
        DKhQzoLJ25XvoY8x1I7AjVfTHRB/+2mu9xzLtIhAt6GFI8kKetpqRBLakHslDeejpHsH1IFnEsv0a
        1oUlKJljxakJuz1VomDr6SK19c9rqBYgDAjQo4stw6uh2KsMFz2fvzJHUgHrgfBC5WPX7c/pqlUyd
        Jse3gvKA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSbn1-003056-TE; Mon, 29 Aug 2022 10:14:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D515B3007DA;
        Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 99784207F2716; Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Message-ID: <20220829101321.905673933@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 29 Aug 2022 12:10:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, kan.liang@linux.intel.com, eranian@google.com,
        ravi.bangoria@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: [PATCH v2 8/9] perf/x86/intel: Shadow MSR_ARCH_PERFMON_FIXED_CTR_CTRL
References: <20220829100959.917169441@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Less RDMSR is more better.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/intel/core.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2405,6 +2405,8 @@ static inline void intel_clear_masks(str
 	__clear_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
 }
 
+static DEFINE_PER_CPU(u64, intel_fixed_ctrl);
+
 static void intel_pmu_disable_fixed(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -2426,8 +2428,9 @@ static void intel_pmu_disable_fixed(stru
 	intel_clear_masks(event, idx);
 
 	mask = 0xfULL << ((idx - INTEL_PMC_IDX_FIXED) * 4);
-	rdmsrl(hwc->config_base, ctrl_val);
+	ctrl_val = this_cpu_read(intel_fixed_ctrl);
 	ctrl_val &= ~mask;
+	this_cpu_write(intel_fixed_ctrl, ctrl_val);
 	wrmsrl(hwc->config_base, ctrl_val);
 }
 
@@ -2746,9 +2749,10 @@ static void intel_pmu_enable_fixed(struc
 		mask |= ICL_FIXED_0_ADAPTIVE << (idx * 4);
 	}
 
-	rdmsrl(hwc->config_base, ctrl_val);
+	ctrl_val = this_cpu_read(intel_fixed_ctrl);
 	ctrl_val &= ~mask;
 	ctrl_val |= bits;
+	this_cpu_write(intel_fixed_ctrl, ctrl_val);
 	wrmsrl(hwc->config_base, ctrl_val);
 }
 


