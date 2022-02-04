Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5EC4A9F0F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377550AbiBDSc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiBDSc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:32:57 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027CAC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 10:32:56 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id cq9-20020a17090af98900b001b8262fe2d5so6389480pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 10:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gecemPh1YoVknpgrAKqTb7sbuwcTf07fGkePgdRPvXk=;
        b=MkM+GGnGVqRmGGXqh0GQI/K2awyjlQH8m2THpguDP4BKSqf4hIsdOteRQFK6QNW6Jv
         f2DVOG1uIj+7NlMi3kq3IyY+CS8xKTB4r8ON4qwSx2civhd3u7X00Fra3ZXh7NoMPHLx
         Yr3Dnh9nz6s90gXoxr6nQ/iIjvVUP7URyjh52glzaAZ8GOAAH4wOCS16aPbXcdPR3eW6
         sbC7VGgh1W7tjQE2V25pSdGG0+Dr7Y5U0j7JcfBzGTjdPZ9niSpARZuFE2d2F+dIlPJW
         dFrqQHbqAlI/EvOo3pG3Iw858AsRVWk5IDtE82Db579rRmOQvTpTtNADEZcW2smzQvPv
         HvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gecemPh1YoVknpgrAKqTb7sbuwcTf07fGkePgdRPvXk=;
        b=pKQdJ4VteFuX/K7IxYpPQkKAPZYdGEKvLi+H7HNuzLfMiInRF69o4Rk88oandG/4Ux
         D391Fg4O01Nf4HymWWU5cOBooHu6qxL6ndEWuS7u4QlUB88JfDqQjXV9Pmn/zG5SNDq4
         gyOvg792VdN4BmG7C7pZCyokeDF2V9jLd3o9ZstBC4bVdE1laQq5PTfdo4iC+h4n2XFl
         v5QABSEYsIsp++yFbA2ZZWAdCQ5QwCsKW75NOTSAjwBDY2307WXIygmjaljiR0sgpwy+
         F2Krdux3jr6jWfRkF6IFH8FhPCttyx096b+49RMBRLGmkxyF6GTP+ZDGV9wr6+8fN1/S
         k05g==
X-Gm-Message-State: AOAM530XejATd35soJ4C+tzTa86ph5Hq4J5mBgXCjbLEr35p7jHD9T8y
        V24856UcTh4UD5KBVyapCZrcBA==
X-Google-Smtp-Source: ABdhPJyYCXN46amEt9Aqhax4xUS312+0Wvq/pnhllosSF9E1QS4QeJ8arQRIddlP+mdKC6HHIpHYuA==
X-Received: by 2002:a17:902:b40b:: with SMTP id x11mr4614644plr.75.1643999576229;
        Fri, 04 Feb 2022 10:32:56 -0800 (PST)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id a125sm3087602pfa.205.2022.02.04.10.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 10:32:55 -0800 (PST)
Date:   Fri, 4 Feb 2022 18:32:51 +0000
From:   David Matlack <dmatlack@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, vkuznets@redhat.com
Subject: Re: [PATCH 03/23] KVM: MMU: remove valid from extended role
Message-ID: <Yf1xU+EVukcX4Exb@google.com>
References: <20220204115718.14934-1-pbonzini@redhat.com>
 <20220204115718.14934-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204115718.14934-4-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 06:56:58AM -0500, Paolo Bonzini wrote:
> The level field of the MMU role can act as a marker for validity
> instead: it is guaranteed to be nonzero so a zero value means the role
> is invalid and the MMU properties will be computed again.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 4 +---
>  arch/x86/kvm/mmu/mmu.c          | 9 +++------
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index e7e5bd9a984d..4ec7d1e3aa36 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -342,8 +342,7 @@ union kvm_mmu_page_role {
>   * kvm_mmu_extended_role complements kvm_mmu_page_role, tracking properties
>   * relevant to the current MMU configuration.   When loading CR0, CR4, or EFER,
>   * including on nested transitions, if nothing in the full role changes then
> - * MMU re-configuration can be skipped. @valid bit is set on first usage so we
> - * don't treat all-zero structure as valid data.
> + * MMU re-configuration can be skipped.
>   *
>   * The properties that are tracked in the extended role but not the page role
>   * are for things that either (a) do not affect the validity of the shadow page
> @@ -360,7 +359,6 @@ union kvm_mmu_page_role {
>  union kvm_mmu_extended_role {
>  	u32 word;
>  	struct {
> -		unsigned int valid:1;
>  		unsigned int execonly:1;
>  		unsigned int cr0_pg:1;
>  		unsigned int cr4_pae:1;
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index b0065ae3cea8..0039b2f21286 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4683,8 +4683,6 @@ static union kvm_mmu_extended_role kvm_calc_mmu_role_ext(struct kvm_vcpu *vcpu,
>  		ext.efer_lma = ____is_efer_lma(regs);
>  	}
>  
> -	ext.valid = 1;
> -
>  	return ext;
>  }
>  
> @@ -4891,7 +4889,6 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
>  	/* EPT, and thus nested EPT, does not consume CR0, CR4, nor EFER. */
>  	role.ext.word = 0;
>  	role.ext.execonly = execonly;
> -	role.ext.valid = 1;
>  
>  	return role;
>  }
> @@ -5039,9 +5036,9 @@ void kvm_mmu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	 * problem is swept under the rug; KVM's CPUID API is horrific and
>  	 * it's all but impossible to solve it without introducing a new API.
>  	 */
> -	vcpu->arch.root_mmu.mmu_role.ext.valid = 0;
> -	vcpu->arch.guest_mmu.mmu_role.ext.valid = 0;
> -	vcpu->arch.nested_mmu.mmu_role.ext.valid = 0;
> +	vcpu->arch.root_mmu.mmu_role.base.level = 0;
> +	vcpu->arch.guest_mmu.mmu_role.base.level = 0;
> +	vcpu->arch.nested_mmu.mmu_role.base.level = 0;

I agree this will work but I think it makes the code more difficult to
follow (and I start worrying that some code that relies on level being
accurate will creep in in the future). At minimum we should extend the
comment here to describe why level is being changed.

I did a half-assed attempt to pass something like "bool force_role_reset"
down to the MMU initialization functions as an alternative but it very
quickly got out of hand.

What about just changing `valid` to `cpuid_stale` and flip the meaning?
kvm_mmu_after_set_cpuid() would set the cpuid_stale bit and then reset
the MMUs.

>  	kvm_mmu_reset_context(vcpu);
>  
>  	/*
> -- 
> 2.31.1
> 
> 
