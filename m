Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9444351FDBB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbiEINQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbiEINQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:16:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED961A44B0;
        Mon,  9 May 2022 06:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=n4rkQQU7/xYEHvdjU2quuucIOfcZR2es0FVvNk6/LQQ=; b=OOJmAkFq4dgUgmGVUNZoFJOt66
        P2PDpxgCs28mGkZL5Cf44dEveHH2JSG22rWXTSRd15v4LqC38RzrkfeCYUwTpMdznyj98cZsqw3Z4
        BVtRnyHV7ZCGn+d356nvbKDs6h9xR7Sj6fUqH1gE75mCkxf5jj9IJmVL1cWb1QFr4QxFsRHEIVGQz
        iKCEP4jwiKqXTgDTso2hzhfCMcirTZ9vAgtdKtcc0+LHTKOKbc8eIKKW4a26f6F8s3irgbmv6TlWd
        jfVsJGJEGSn4IjaziZIQqQ0Ns1HydfzgaDJWT3ezJFX8huTyCr6WCGyI+PJ8RsEBF1UIALnII2W+P
        sN9cGxhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1no3B2-003Swo-Fl; Mon, 09 May 2022 13:11:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0370B3001F3;
        Mon,  9 May 2022 15:11:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E28902026963D; Mon,  9 May 2022 15:11:49 +0200 (CEST)
Date:   Mon, 9 May 2022 15:11:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     Like Xu <like.xu.linux@gmail.com>, bp@alien8.de,
        dave.hansen@linux.intel.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, eranian@google.com,
        puwen@hygon.cn, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 3/7] perf/x86/amd/core: Detect PerfMonV2 support
Message-ID: <YnkTFRNpCykEndsk@hirez.programming.kicks-ass.net>
References: <cover.1651058600.git.sandipan.das@amd.com>
 <8d3e23760726cf6647a98999e1fcd12a37f36a42.1651058600.git.sandipan.das@amd.com>
 <78e001bd-42bd-5481-5a19-1a0bcca9a63c@gmail.com>
 <96e41431-eb80-f61d-9ab9-c76cd9b6086a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96e41431-eb80-f61d-9ab9-c76cd9b6086a@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 06:38:19PM +0530, Sandipan Das wrote:
> 
> On 5/9/2022 6:31 PM, Like Xu wrote:
> > On 27/4/2022 7:31 pm, Sandipan Das wrote:
> > 
> >>       x86_pmu.num_counters    = AMD64_NUM_COUNTERS_CORE;
> > 
> > Thus boot_cpu_has(X86_FEATURE_PERFCTR_CORE) is true.
> > 
> >> +
> >> +    /* Check for Performance Monitoring v2 support */
> >> +    if (boot_cpu_has(X86_FEATURE_PERFMON_V2)) {
> >> +        /* Update PMU version for later usage */
> >> +        x86_pmu.version = 2;
> > 
> > Is it safe to assume that once AMD CPU has the PERFMON_V2 (or further) bit,
> > 
> > it must also have the PERFCTR_CORE bit set ?
> > 
> 
> Yes, always. There won't be a case where PERFCTR_CORE is absent
> but PERFMON_V2 is present.

Let me introduce you to this dodgy virt stuff :-) Best put a sanity
check on it.
