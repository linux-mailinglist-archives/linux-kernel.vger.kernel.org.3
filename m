Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4314DC4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiCQL11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiCQL10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:27:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E7B1E3E0D;
        Thu, 17 Mar 2022 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x/tKXZAuaT10dOmNb48L5fwcPj4mj0LsJJXIVULmxmo=; b=OttygPqts8Wu6Mt2x2yh5JfeVl
        4ILJ7FfsAvfive5NryHbromRQqJWsnlfX+LLpJbn3xz3lR6kxP6R8RHaGqTay4xbPHgSDriotQ4AU
        O3gTGfZsB+bEiRTC97gIvql4ohQJIN0aCrxI1LrU3BdCysynWyH6Ga4JuCPQSZh5xjT0HLTsjVTqc
        +QSNTZUAwHqOkx4P4Nrb+WI24QMBsi7YC3xTqRZUBmszaTiqxLgPdGJAojq7nW/sPD7yzSXeE4N7K
        mwjYcK6HiK6O30fLPADTqyC8niHn4wHYl0TdouNHFcsQzvi37U1QBrmERRrF0xUQUjzb/3zKzz0En
        l7YCXk6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUoGM-001s85-5a; Thu, 17 Mar 2022 11:25:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 201353001EA;
        Thu, 17 Mar 2022 12:25:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 012732D621570; Thu, 17 Mar 2022 12:25:47 +0100 (CET)
Date:   Thu, 17 Mar 2022 12:25:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, like.xu.linux@gmail.com,
        eranian@google.com, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH 2/7] x86/msr: Add PerfCntrGlobal* registers
Message-ID: <YjMau/irJUgy6nOk@hirez.programming.kicks-ass.net>
References: <cover.1647498015.git.sandipan.das@amd.com>
 <a5edd2f0caf5389916a08c0378648479c7c31d1b.1647498015.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5edd2f0caf5389916a08c0378648479c7c31d1b.1647498015.git.sandipan.das@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 11:58:31AM +0530, Sandipan Das wrote:
> Add MSR definitions that will be used to enable the new AMD
> Performance Monitoring Version 2 (PerfMonV2) features. These
> include:
> 
>   * Performance Counter Global Control (PerfCntrGlobalCtl)
>   * Performance Counter Global Status (PerfCntrGlobalStatus)
>   * Performance Counter Global Status Clear (PerfCntrGlobalStatusClr)
> 
> The new Performance Counter Global Control and Status MSRs
> provide an interface for enabling or disabling multiple
> counters at the same time and for testing overflow without
> probing the individual registers for each PMC.
> 
> The availability of these registers is indicated through the
> PerfMonV2 feature bit of CPUID Fn80000022[EAX].
> 
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index a4a39c3e0f19..61d1a55e15b8 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -504,6 +504,11 @@
>  #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
>  #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
>  
> +/* AMD Performance Counter Global Status and Control MSRs */
> +#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
> +#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
> +#define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301

My OCD would suggest ordering them by number :-)
