Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E70659C080
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbiHVN1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbiHVN1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:27:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5064C31236;
        Mon, 22 Aug 2022 06:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hYtojPMz9irO+oG6WMN7GeV1hjHjMbyrt3xn3Ye5F4M=; b=telDdeV9S/RPd/vQa3QCYA2EwV
        j7J6BAXROQxnM4A4VHodLqpzMKA7Gn8pDpgRD56fXBFHitsCJp22Pjy2lxhAtsrBna7V8xBWLMQQ4
        Z8JH13HSrZ3qniUGmv+qpaN3GNlB+c+SxdhRu3RYkU9Wxr82pj8DnoRN0g4nS3i4ndyrxYYxo2MQq
        oxQvQnn9+u2U2EYfBHefvA2K8e6R7jYe2SGBQ0c0MQznxWg0hS5MQi5iehENj4vttg8g198ciacrK
        jINTr2LdNmF2lkzywXX3/kSlVPB52vOAicpy5sP3W68MZW10l5+Oag8FPttaNJYeQf7TxMvS5JOgE
        u0YWhiNg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ7SF-00EJDr-FL; Mon, 22 Aug 2022 13:26:59 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D50709804A3; Mon, 22 Aug 2022 15:26:56 +0200 (CEST)
Date:   Mon, 22 Aug 2022 15:26:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, acme@kernel.org, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        dave.hansen@linux.intel.com, like.xu.linux@gmail.com,
        Stephane Eranian <eranian@google.com>, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com
Subject: Re: [PATCH 04/13] x86/cpufeatures: Add LbrExtV2 feature bit
Message-ID: <YwOEIESeDSuekmf8@worktop.programming.kicks-ass.net>
References: <cover.1660211399.git.sandipan.das@amd.com>
 <172d2b0df39306ed77221c45ee1aa62e8ae0548d.1660211399.git.sandipan.das@amd.com>
 <YvotoHMaLE1XawiO@worktop.programming.kicks-ass.net>
 <CABPqkBQ1YLAu+sJC_U4QsQuo3PuzUwRDrNm9KcrUAEUxeBaYbg@mail.gmail.com>
 <YwNG1XzcyR5ys+rA@worktop.programming.kicks-ass.net>
 <06e9a357-422d-1870-ae72-18e74964caf3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06e9a357-422d-1870-ae72-18e74964caf3@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 06:22:25PM +0530, Sandipan Das wrote:
> AMD LbrExtV2 is similar to Intel LBR. Unlike BRS, LbrExtV2 does not rely on

LbrExtV2 must be the most terrible name ever, please stop using it. Heck
your own code calls it lbr_v2 wherever it can.

So can we please just kill that name entirely?

$ quilt diff --combine - | grep -i lbrext_v2
+       if (x86_pmu.version < 2 || !boot_cpu_has(X86_FEATURE_LBREXT_V2))
+#define X86_FEATURE_LBREXT_V2          ( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
+       { X86_FEATURE_LBREXT_V2,        CPUID_EAX,  1, 0x80000022, 0 },

Is the complete usage of this silly name.

> interrupt holding. The branch records are "frozen" at the time of counter
> overflow.

Yes, I get all that. It is also significantly different from Intel LBR
in all details and shares not a single line of code, so also calling it
LBR is confusing at best.

The MSRs are called AMD_SAMPL_BR, so why not call the thing BRS_V2 ?
