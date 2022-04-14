Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7913D5019FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245671AbiDNR1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245627AbiDNR1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:27:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5139D4C6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649957080; x=1681493080;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=0zLW2H67Vu3q710WNvk8HEeL0XmQc0GrU44QmfVgE2g=;
  b=NEkABJcBC3zwjxy+I18n4bPPp52cupjgYnzehln2HK11r4uTh9j7umeG
   KfitzxZTRgzWvREheR2HB1qoWXI1HjpQJbqK/3zKCbQkyfuL1kUPAl3P9
   BnuEJP130uLO3rEREBKHu8MHRJ1r3UKJg68KHI4mafoxlI8wCmJsP2WiY
   Sa4PancRyMMFSlBLrWR36AEvopMra8VjmqZtULztgzFRbUSrmHC7l4pdo
   7rJUlinqk1yAUDhNHZpeo2njwh94YpQQLfqWrnIOjoEuug6ufIYDvLiS1
   Irx/JfeEJ0J8t6lF3QNs5O/mUXMwiBt/eG+mkVi1bNSDyUXT0YLSE3++6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="262429728"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="262429728"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 10:24:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="612409801"
Received: from msahoo-mobl1.amr.corp.intel.com (HELO [10.212.62.78]) ([10.212.62.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 10:24:38 -0700
Message-ID: <a93e6d3f-e8b9-2fab-1139-a8ba3dc4820b@intel.com>
Date:   Thu, 14 Apr 2022 10:24:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
References: <20220404103741.809025935@linutronix.de>
 <20220404104820.713066297@linutronix.de>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [patch 3/3] x86/fpu/xsave: Optimize XSAVEC/S when XGETBV1 is
 supported
In-Reply-To: <20220404104820.713066297@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 05:11, Thomas Gleixner wrote:
> A typical scenario is an active set of 0x202 (PKRU + SSE) out of the full
> supported set of 0x2FF. That means XSAVEC/S writes and XRSTOR[S] reads:

It might be worth reminding folks why PKRU is a special snowflake:

The default PKRU enforced by the kernel is its most restrictive possible
value (0xfffffffc).  This means that PKRU defaults to being in its
non-init state even for tasks which do nothing protection-keys-related.


> which is suboptimal. Prefetch works better when the access is linear. But
> what's worse is that PKRU can be located in a different page which
> obviously affects dTLB.

The numbers don't lie, but I'm still surprised by this.  Was this in a
VM that isn't backed with large pages?  task_struct.thread.fpu is
kmem_cache_alloc()'d and is in the direct map, which should be 2M/1G
pages almost all the time.

> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -86,6 +86,8 @@ static unsigned int xstate_flags[XFEATUR
>  #define XSTATE_FLAG_SUPERVISOR	BIT(0)
>  #define XSTATE_FLAG_ALIGNED64	BIT(1)
>  
> +DEFINE_STATIC_KEY_FALSE(__xsave_use_xgetbv1);
> +
>  /*
>   * Return whether the system supports a given xfeature.
>   *
> @@ -1481,7 +1483,7 @@ void xfd_validate_state(struct fpstate *
>  }
>  #endif /* CONFIG_X86_DEBUG_FPU */
>  
> -static int __init xfd_update_static_branch(void)
> +static int __init fpu_update_static_branches(void)
>  {
>  	/*
>  	 * If init_fpstate.xfd has bits set then dynamic features are
> @@ -1489,9 +1491,13 @@ static int __init xfd_update_static_bran
>  	 */
>  	if (init_fpstate.xfd)
>  		static_branch_enable(&__fpu_state_size_dynamic);
> +
> +	if (cpu_feature_enabled(X86_FEATURE_XGETBV1) &&
> +	    cpu_feature_enabled(X86_FEATURE_XCOMPACTED))
> +		static_branch_enable(&__xsave_use_xgetbv1);
>  	return 0;
>  }
> -arch_initcall(xfd_update_static_branch)
> +arch_initcall(fpu_update_static_branches)
>  
>  void fpstate_free(struct fpu *fpu)
>  {
> --- a/arch/x86/kernel/fpu/xstate.h
> +++ b/arch/x86/kernel/fpu/xstate.h
> @@ -10,7 +10,12 @@
>  DECLARE_PER_CPU(u64, xfd_state);
>  #endif
>  
> -static inline bool xsave_use_xgetbv1(void) { return false; }
> +DECLARE_STATIC_KEY_FALSE(__xsave_use_xgetbv1);
> +
> +static __always_inline __pure bool xsave_use_xgetbv1(void)
> +{
> +	return static_branch_likely(&__xsave_use_xgetbv1);
> +}
>  
>  static inline void __xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
>  {
> @@ -185,13 +190,18 @@ static inline int __xfd_enable_feature(u
>  static inline void os_xsave(struct fpstate *fpstate)
>  {
>  	u64 mask = fpstate->xfeatures;
> -	u32 lmask = mask;
> -	u32 hmask = mask >> 32;
> +	u32 lmask, hmask;
>  	int err;
>  
>  	WARN_ON_FPU(!alternatives_patched);
>  	xfd_validate_state(fpstate, mask, false);
>  
> +	if (xsave_use_xgetbv1())
> +		mask &= xgetbv(1);

How about this comment for the masking operation:

	/*
	 * Remove features in their init state from the mask.  This
	 * makes the XSAVE{S,C} writes less sparse and quicker for
	 * the CPU.
	 */

> +	lmask = mask;
> +	hmask = mask >> 32;
> +
>  	XSTATE_XSAVE(&fpstate->regs.xsave, lmask, hmask, err);
>  
>  	/* We should never fault when copying to a kernel buffer: */

