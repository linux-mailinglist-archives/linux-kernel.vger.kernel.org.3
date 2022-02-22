Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812CA4C01B5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiBVSzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbiBVSzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:55:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9483F13AA33
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:55:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D2D1042;
        Tue, 22 Feb 2022 10:55:05 -0800 (PST)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15A843F66F;
        Tue, 22 Feb 2022 10:55:02 -0800 (PST)
Date:   Tue, 22 Feb 2022 18:55:00 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Scull <ascull@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v2 4/9] KVM: arm64: Add guard pages for pKVM (protected
 nVHE) hypervisor stack
Message-ID: <YhUxhEHNKlqip51u@lakrids>
References: <20220222165212.2005066-1-kaleshsingh@google.com>
 <20220222165212.2005066-5-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222165212.2005066-5-kaleshsingh@google.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:51:05AM -0800, Kalesh Singh wrote:
> Maps the stack pages in the flexible private VA range and allocates
> guard pages below the stack as unbacked VA space. The stack is aligned
> to twice its size to aid overflow detection (implemented in a subsequent
> patch in the series).
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/setup.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
> index 27af337f9fea..69df21320b09 100644
> --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> @@ -105,11 +105,28 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
>  		if (ret)
>  			return ret;
>  
> -		end = (void *)per_cpu_ptr(&kvm_init_params, i)->stack_hyp_va;
> +		/*
> +		 * Private mappings are allocated upwards from __io_map_base
> +		 * so allocate the guard page first then the stack.
> +		 */
> +		start = (void *)pkvm_alloc_private_va_range(PAGE_SIZE, PAGE_SIZE);
> +		if (IS_ERR_OR_NULL(start))
> +			return PTR_ERR(start);

As on a prior patch, this usage of PTR_ERR() pattern is wrong when the
ptr is NULL.

> +		/*
> +		 * The stack is aligned to twice its size to facilitate overflow
> +		 * detection.
> +		 */
> +		end = (void *)per_cpu_ptr(&kvm_init_params, i)->stack_pa;
>  		start = end - PAGE_SIZE;
> -		ret = pkvm_create_mappings(start, end, PAGE_HYP);
> -		if (ret)
> -			return ret;
> +		start = (void *)__pkvm_create_private_mapping((phys_addr_t)start,
> +					PAGE_SIZE, PAGE_SIZE * 2, PAGE_HYP);
> +		if (IS_ERR_OR_NULL(start))
> +			return PTR_ERR(start);

Likewise.

Thanks,
Mark.

> +		end = start + PAGE_SIZE;
> +
> +		/* Update stack_hyp_va to end of the stack's private VA range */
> +		per_cpu_ptr(&kvm_init_params, i)->stack_hyp_va = (unsigned long) end;
>  	}
>  
>  	/*
> -- 
> 2.35.1.473.g83b2b277ed-goog
> 
