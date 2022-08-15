Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF97E592CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbiHOJMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiHOJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:12:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB5621E2D;
        Mon, 15 Aug 2022 02:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TfpBC458fNMwuJim+LX9wzEgy0r+1CzNINaC0XhHYTY=; b=pv21Q2xcgWo0gE35aU+detWxmJ
        FohGIgaoPUblYdGr+/ltk9hGqBbCgZYoJbUiUCR3FBIEhFeAIy6+4QAoed9VCpE6AEv6X0UtrNoaM
        sTi/7pI4z/5bkAHhWl5R4R0Do75U1KZdf8I+ofdx9iDzz4CcTvk8c8k/0FPImew6PYsxqkO44881U
        lP/Zzzifrad+Hyr8hovemYDrLtlcHv8vR2ag1gC78n6RA63/ICnhgIF3Ng4MHRdVajWOts8v5jiVV
        3Tyunvs7yY8KRMICOkVJ7Km9HYE5d0WU/RE/euGsWlFpv3q/1uX2+KIUGCACQLObeTIQtv5Dn7CsB
        ZoaMNKhA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNW8X-005aEr-6K; Mon, 15 Aug 2022 09:11:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55537980153; Mon, 15 Aug 2022 11:11:52 +0200 (CEST)
Date:   Mon, 15 Aug 2022 11:11:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com
Subject: Re: [PATCH 7/7] perf/x86/intel/P4: Fix smp_num_siblings usage
Message-ID: <YvoN2DTABnRZiJhf@worktop.programming.kicks-ass.net>
References: <20220812164144.30829-1-rui.zhang@intel.com>
 <20220812164144.30829-8-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812164144.30829-8-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2022 at 12:41:44AM +0800, Zhang Rui wrote:
> smp_num_siblings can be larger than 2.

Not on a P4 it can't ;-)

> 
> Any value larger than 1 suggests HT is supported.
> 
> Reviewed-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  arch/x86/include/asm/perf_event_p4.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/perf_event_p4.h b/arch/x86/include/asm/perf_event_p4.h
> index 94de1a05aeba..b14e9a20a7c0 100644
> --- a/arch/x86/include/asm/perf_event_p4.h
> +++ b/arch/x86/include/asm/perf_event_p4.h
> @@ -189,7 +189,7 @@ static inline int p4_ht_active(void)
>  static inline int p4_ht_thread(int cpu)
>  {
>  #ifdef CONFIG_SMP
> -	if (smp_num_siblings == 2)
> +	if (smp_num_siblings > 1)
>  		return cpu != cpumask_first(this_cpu_cpumask_var_ptr(cpu_sibling_map));
>  #endif
>  	return 0;

Unless Intel plans to respin an P4 with extra siblings on, I don't think
this qualifies for the word 'fix'.
