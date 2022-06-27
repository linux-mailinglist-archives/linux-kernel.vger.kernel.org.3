Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0027C55CEBD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiF0Hu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiF0HuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:50:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EB32DD3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=is7Eu+0H7HDxhCl/shZXvpRh5hl4o3ATrtA6ia1L7MM=; b=cSfth6hdEoIZb/zjDZH/w6rGSn
        R76PdgIKZ780DCSfYzkJXp5IBZDMxb52+uXGZiXBQjbKo5KL/rvd9a3nSyGT1rZNPRxLIZMgkjVQp
        rowAaHtUyn4/S/pZYfBZ6y/fHhNtO2Uv9Hac8y7aycjck1LMAU7YqAbvoAN4KeoNY54Hife7bxzjt
        bHkmaLXfjmW8vCSJqvr2DK+vEbtTLzCqOyiom77U+hkUBs/gN27FZ4vbBQcNZrBBXnXP+LPXYqBt1
        HyEpIHQ24fVwDJ1nqwfbt24kSsqwElik2fssi8berbCwF+1T2fHgjvz/Y537eLPmDTe1/6q3usZdq
        ytKmRQDQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o5jVF-00BAP8-KF; Mon, 27 Jun 2022 07:49:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ED45A300091;
        Mon, 27 Jun 2022 09:49:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AFAE429BBBBC2; Mon, 27 Jun 2022 09:49:46 +0200 (CEST)
Date:   Mon, 27 Jun 2022 09:49:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Hui <guohui@uniontech.com>
Cc:     longman@redhat.com, jgross@suse.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, pv-drivers@vmware.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, will@kernel.org,
        boqun.feng@gmail.com, virtualization@lists.linux-foundation.org,
        wangxiaohua@uniontech.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/paravirt: useless assignment instructions cause
 Unixbench full core   performance degradation
Message-ID: <YrlhGqqce0NCQ6hi@hirez.programming.kicks-ass.net>
References: <f6b68466-968c-4a91-655a-23970280a072@redhat.com>
 <20220627021350.25714-1-guohui@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627021350.25714-1-guohui@uniontech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 10:13:50AM +0800, Guo Hui wrote:
> The instructions assigned to the vcpu_is_preempted function parameter
> in the X86 architecture physical machine are redundant instructions,
> causing the multi-core performance of Unixbench to drop by about 4% to 5%.
> The C function is as follows:
> static bool vcpu_is_preempted(long vcpu);
> 
> The parameter 'vcpu' in the function osq_lock
> that calls the function vcpu_is_preempted is assigned as follows:
> 
> The C code is in the function node_cpu:
> cpu = node->cpu - 1;
> 
> The instructions corresponding to the C code are:
> mov 0x14(%rax),%edi
> sub $0x1,%edi
> 
> The above instructions are unnecessary
> in the X86 Native operating environment,
> causing high cache-misses and degrading performance.

The above basically says that argument setup is not patched out and
causes significant pain due to a cache-miss.

> Signed-off-by: Guo Hui <guohui@uniontech.com>
> ---
>  arch/x86/kernel/paravirt-spinlocks.c | 4 ++++
>  kernel/locking/osq_lock.c            | 9 ++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
> index 9e1ea99ad..7a55f8407 100644
> --- a/arch/x86/kernel/paravirt-spinlocks.c
> +++ b/arch/x86/kernel/paravirt-spinlocks.c
> @@ -33,6 +33,8 @@ bool pv_is_native_vcpu_is_preempted(void)
>  		__raw_callee_save___native_vcpu_is_preempted;
>  }
>  
> +DECLARE_STATIC_KEY_FALSE(preemted_key);
> +
>  void __init paravirt_set_cap(void)
>  {
>  	if (!pv_is_native_spin_unlock())
> @@ -40,4 +42,6 @@ void __init paravirt_set_cap(void)
>  
>  	if (!pv_is_native_vcpu_is_preempted())
>  		setup_force_cpu_cap(X86_FEATURE_VCPUPREEMPT);
> +	else
> +		static_branch_enable(&preemted_key);
>  }

At least for x86 it makes sense to have the static_key default the other
way around. That is, enable it along with vcpu_is_preempted().

> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index d5610ad52..a8798e701 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -22,9 +22,16 @@ static inline int encode_cpu(int cpu_nr)
>  	return cpu_nr + 1;
>  }
>  
> +DEFINE_STATIC_KEY_FALSE(preemted_key);
> +
>  static inline int node_cpu(struct optimistic_spin_node *node)
>  {
> -	return node->cpu - 1;
> +	int cpu = 0;
> +
> +	if (!static_branch_unlikely(&preemted_key))
> +		cpu = node->cpu - 1;
> +
> +	return cpu;
>  }

Would not something like:

static inline bool
vcpu_is_preempted_node(struct optimistic_spin_node *node)
{
	if (!static_branch_unlikely(&vcpu_has_preemption))
		return false;

	return vcpu_is_preempted(node_cpu(node->prev));
}

And then use that like:

	if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
				  vcpu_is_preempted_node(node)))

Not generate better code still?
