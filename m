Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CF44E61E1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349550AbiCXKoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbiCXKoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:44:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A60F9E9E7;
        Thu, 24 Mar 2022 03:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AfngXjCslJfCGNrgOvXQFMP+NBEA/TKmmxvGwvQRyoo=; b=GBjqe3cd/aRN6PIHQO27k4ENTA
        JYGBluf3eZk2pCNes7bjArMOr1rUw6wrqQ0uYrSNn4CD5nabd2s9H9Fupj5CTCVa+Bzqfb9bZFLeo
        B54s0oVsPNyshrisQwLMi7XOaUvv/H6HT2gYUz5VpFczMmadoipvx9B1FG9KDCrsxrtV4mWkU/w6Z
        xcUePpqm+6QOHBteCvHMuIObcpo+6xLRJQaOtj/+1ARKj/kr3TJUAe133o5sLrUWLKwLozWKBnkY2
        jRZGlUTj3LRHN72WBY3nADg8ffF4wk1h+lPbSSEfCHTCSdPQ6hpdXJRaVseOVUg2qtIsK807bM2fQ
        0iSY5a1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXKv4-00DLvx-4h; Thu, 24 Mar 2022 10:42:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A07AF986201; Thu, 24 Mar 2022 11:42:17 +0100 (CET)
Date:   Thu, 24 Mar 2022 11:42:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dongli Si <kvmx86@gmail.com>
Cc:     joro@8bytes.org, liam.merwick@oracle.com, kim.phillips@amd.com,
        mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf/x86/amd: Don't touch the Host-only bit inside
 the guest hypervisor
Message-ID: <20220324104217.GE8939@worktop.programming.kicks-ass.net>
References: <20220320002106.1800166-1-sidongli1997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320002106.1800166-1-sidongli1997@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 08:21:06AM +0800, Dongli Si wrote:

> @@ -1027,7 +1028,8 @@ void amd_pmu_enable_virt(void)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  
> -	cpuc->perf_ctr_virt_mask = 0;
> +	if (hypervisor_is_type(X86_HYPER_NATIVE))
> +		cpuc->perf_ctr_virt_mask = 0;

So I had to go and read the original commit to figure out wth this code
is supposed to be doing. I'm thinking this all can use a wee comment.

Also, the above is very ambiguous as to what it does. Specifically if we
don't set perf_ctr_virt_mask, then what is the actual value (yes, I
know, but its not very clear is it). Also, if we don't in fact change
perf_ctr_virt_mask then these following two lines:

>  
>  	/* Reload all events */
>  	amd_pmu_disable_all();
	amd_pmu_enable_all(0);

are somewhat completely pointless, no?

So can we please get a patch that clarifies things instead of making
things even more obscure?
