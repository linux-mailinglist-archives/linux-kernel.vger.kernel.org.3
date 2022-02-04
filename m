Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DB84A9FE6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiBDTSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiBDTSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:18:14 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0B3C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:18:14 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v15-20020a17090a4ecf00b001b82db48754so6996558pjl.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 11:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=42P0RkbrK1PQHs+ZTbHwM7kEGdYNQVmANbDyAZZWTvA=;
        b=RoWEUamAkogvX5xsJGspiXmzbfM7Z/vGADYLoaf24DKkM4nBRV2oB2lbIBztGhg2IM
         EM+6CocXccze+NZZ5mJa7oRQyyokomkHjwSnBWDr9NDQvHy1terajLKrrooMkC7/vIZ/
         VlBL7S+6uaf6Vznoi5qtsMzq429LRqhT77Kep6Z4wkjPtgohV7E/UyLYyJjXGhnr9Nvu
         THi1xtJ0UwxpJR8UwAosyvfkqzfF9W1+5uqyVuN3EM6git1+c3ARRQ5EHyvEqnfIVGNB
         7xjn9WSQzIH87J3wl8IoPPRDL/2+xUc3j2SoxXjMfDXqxeoBOFxrku5TOdOjib623uEg
         pxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=42P0RkbrK1PQHs+ZTbHwM7kEGdYNQVmANbDyAZZWTvA=;
        b=n2d1+Leg02wsVu1uRPjfdmH/2+K4tzLUlQeP3NNd9wxPlkj1Yik5MI/l7/4BufNtK9
         2CAxAuQR7PFwyQzuYs+pzJKPC6leqkbJswiUPGzScfu9JqnsD4FYnGs0vbpnjMCLYQlJ
         lLaYnFqjH7D42rfBAba38me0eFjFdycfgZp1neL60ex3jpTJ/vYqb2KZV4uMOwUlD8Pu
         fdKOx8AqRL5/FxjoVgnzg5VKxTk7ydxdM8jDYrJBXg4XrERcBqBJkIzKSiO/NeTK9wpF
         ZO8YjI2XQDaaLlcWRq4Vm97wdCadk0ZRfLbxRS594BC+07Fc1Q7UqVZMMNpZ7aJf3TJt
         Ch7g==
X-Gm-Message-State: AOAM530VpL72wlrej3mPBqS/t7L58yqs0lSmeIbtO3NMkkwa64cZKg6C
        uQB4ZIR2ssTDdZu9Zyktei3mMA==
X-Google-Smtp-Source: ABdhPJx7D2gzMfV9sTiwH5KkbdXKRG6tBzNdXYfFViGkvxO5diPDLXGOCYtjcWUgqjTueEfTkx+kFw==
X-Received: by 2002:a17:902:d4ca:: with SMTP id o10mr4685547plg.28.1644002293319;
        Fri, 04 Feb 2022 11:18:13 -0800 (PST)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id 3sm10604743pjk.29.2022.02.04.11.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 11:18:12 -0800 (PST)
Date:   Fri, 4 Feb 2022 19:18:08 +0000
From:   David Matlack <dmatlack@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, vkuznets@redhat.com
Subject: Re: [PATCH 06/23] KVM: MMU: load new PGD once nested two-dimensional
 paging is initialized
Message-ID: <Yf178LYEY4pFJcLc@google.com>
References: <20220204115718.14934-1-pbonzini@redhat.com>
 <20220204115718.14934-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204115718.14934-7-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 06:57:01AM -0500, Paolo Bonzini wrote:
> __kvm_mmu_new_pgd looks at the MMU's root_level and shadow_root_level
> via fast_pgd_switch.

Those checks are just for performance correct (to skip iterating through
the list of roots)?

Either way, it's probably worth including a Fixes tag below.

> It makes no sense to call it before updating
> these fields, even though it was done like that ever since nested
> VMX grew the ability to use fast CR3 switch (commit 50c28f21d045,
> "kvm: x86: Use fast CR3 switch for nested VMX").
> 
> Pull it to the end of the initialization of the shadow nested MMUs.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
>  arch/x86/kvm/mmu/mmu.c | 41 +++++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 577e70509510..b8ab16323629 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4869,10 +4869,9 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
>  
>  	new_role = kvm_calc_shadow_npt_root_page_role(vcpu, &regs);
>  
> -	__kvm_mmu_new_pgd(vcpu, nested_cr3, new_role.base);
> -
>  	shadow_mmu_init_context(vcpu, context, &regs, new_role);
>  	reset_shadow_zero_bits_mask(vcpu, context, is_efer_nx(context));
> +	__kvm_mmu_new_pgd(vcpu, nested_cr3, new_role.base);
>  }
>  EXPORT_SYMBOL_GPL(kvm_init_shadow_npt_mmu);
>  
> @@ -4906,27 +4905,25 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
>  		kvm_calc_shadow_ept_root_page_role(vcpu, accessed_dirty,
>  						   execonly, level);
>  
> -	__kvm_mmu_new_pgd(vcpu, new_eptp, new_role.base);
> -
> -	if (new_role.as_u64 == context->mmu_role.as_u64)
> -		return;
> -
> -	context->mmu_role.as_u64 = new_role.as_u64;
> -
> -	context->shadow_root_level = level;
> -
> -	context->ept_ad = accessed_dirty;
> -	context->page_fault = ept_page_fault;
> -	context->gva_to_gpa = ept_gva_to_gpa;
> -	context->sync_page = ept_sync_page;
> -	context->invlpg = ept_invlpg;
> -	context->root_level = level;
> -	context->direct_map = false;
> +	if (new_role.as_u64 != context->mmu_role.as_u64) {
> +		context->mmu_role.as_u64 = new_role.as_u64;
> +
> +		context->shadow_root_level = level;
> +
> +		context->ept_ad = accessed_dirty;
> +		context->page_fault = ept_page_fault;
> +		context->gva_to_gpa = ept_gva_to_gpa;
> +		context->sync_page = ept_sync_page;
> +		context->invlpg = ept_invlpg;
> +		context->root_level = level;
> +		context->direct_map = false;
> +		update_permission_bitmask(context, true);
> +		context->pkru_mask = 0;
> +		reset_rsvds_bits_mask_ept(vcpu, context, execonly, huge_page_level);
> +		reset_ept_shadow_zero_bits_mask(context, execonly);
> +	}
>  
> -	update_permission_bitmask(context, true);
> -	context->pkru_mask = 0;
> -	reset_rsvds_bits_mask_ept(vcpu, context, execonly, huge_page_level);
> -	reset_ept_shadow_zero_bits_mask(context, execonly);
> +	__kvm_mmu_new_pgd(vcpu, new_eptp, new_role.base);
>  }
>  EXPORT_SYMBOL_GPL(kvm_init_shadow_ept_mmu);
>  
> -- 
> 2.31.1
> 
> 
