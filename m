Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4623D52DA2F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242009AbiESQ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiESQ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:27:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD1362126
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:27:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id nr2-20020a17090b240200b001df2b1bfc40so9215907pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WjosEggMbaFmJXklvpWk1bBVyYWb+47bOUkqzBMuT0A=;
        b=UKWWfuydr8fT3A8hPCbbDxlaqPyGaSQMcsj64NZjII+BVYfE+JtBP8u3hkzETTv7xx
         BFVHPGww0iPFBghGB1PtBXNVOqTC3dhJ2e/pQ0W69ZGUbgK48se2PLuNJQYNQJ/kZHA5
         0/71W6CzHmhNHyd2YRYWZ1gt7MzTMKCQj/t6d43sx4iCrEMWpbLERMiZUcG/IJvXqU7j
         Op4otRXSVIUYCtDEZNhLqkowuFTf4qSbJvFynTWlivqOZJcSYeTxkjxe43b0qfMJhG3m
         yczV8IxNFfALUJ3lhIQv/BVLTNTKauupv+1HDC+wqT1Qqf869JX2lGP5dBaylyw4a3T1
         hDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WjosEggMbaFmJXklvpWk1bBVyYWb+47bOUkqzBMuT0A=;
        b=a3IHMh8kRgUDK0aTL4e1SgBo0e3thBmAhdZNhD8H9v7t7VK/ReTpfzDzQ1RQVkPMiz
         Lt14j/nyzKGsH4oWjHQBfuq0KTeKSYdSmZVuoqcI5N3Etfpxxe0kx7el3l9oYwnOt9pe
         PO+qCGEkmMA5DLbGyRLcg57sOk6OufEGs9qfkCQNupOrJq+peY0fa20oSM14ABcTaWLf
         28dT6SghvOVVzLSwp5s5vdz2/i6zd/H2pnar/vTC5CgN1tXnN3keTLxc96C6kh7q/vFo
         kkojrsA5CDk5JU9jX736NJs0iThoc6+UZvGCkQFzw8rUSizJibLY20VSm4nMzBo31RAi
         bxQA==
X-Gm-Message-State: AOAM530tAg8xxFmrUDpIyNypLE4pjiuv86yyBc6qqqO7VsoepgMKlb7B
        8PTHNkECG2KpfOUe2pXbNtS/Dg==
X-Google-Smtp-Source: ABdhPJzDfK2W6t96hRQ9D62TXq3QwSGZOkUfs7W4Usij4gE2WqYZ0qSU8ytNCtAToHux6K6hqLsqMg==
X-Received: by 2002:a17:902:eccc:b0:161:cad8:6ff5 with SMTP id a12-20020a170902eccc00b00161cad86ff5mr5396740plh.164.1652977652519;
        Thu, 19 May 2022 09:27:32 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n12-20020a63a50c000000b003c619f3d086sm3704536pgf.2.2022.05.19.09.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:27:32 -0700 (PDT)
Date:   Thu, 19 May 2022 16:27:28 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v3 04/19] KVM: x86: mmu: allow to enable write
 tracking externally
Message-ID: <YoZv8HmRc7tqQbuL@google.com>
References: <20220427200314.276673-1-mlevitsk@redhat.com>
 <20220427200314.276673-5-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427200314.276673-5-mlevitsk@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022, Maxim Levitsky wrote:
> This will be used to enable write tracking from nested AVIC code
> and can also be used to enable write tracking in GVT-g module
> when it actually uses it as opposed to always enabling it,
> when the module is compiled in the kernel.

Wrap at ~75.

> No functional change intended.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h       |  2 +-
>  arch/x86/include/asm/kvm_page_track.h |  1 +
>  arch/x86/kvm/mmu.h                    |  8 +++++---
>  arch/x86/kvm/mmu/mmu.c                | 17 ++++++++++-------
>  arch/x86/kvm/mmu/page_track.c         | 10 ++++++++--
>  5 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 636df87542555..fc7df778a3d71 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1254,7 +1254,7 @@ struct kvm_arch {
>  	 * is used as one input when determining whether certain memslot
>  	 * related allocations are necessary.
>  	 */

The above comment needs to be rewritten.

> -	bool shadow_root_allocated;
> +	bool mmu_page_tracking_enabled;
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	hpa_t	hv_root_tdp;
> diff --git a/arch/x86/include/asm/kvm_page_track.h b/arch/x86/include/asm/kvm_page_track.h
> index eb186bc57f6a9..955a5ae07b10e 100644
> --- a/arch/x86/include/asm/kvm_page_track.h
> +++ b/arch/x86/include/asm/kvm_page_track.h
> @@ -50,6 +50,7 @@ int kvm_page_track_init(struct kvm *kvm);
>  void kvm_page_track_cleanup(struct kvm *kvm);
>  
>  bool kvm_page_track_write_tracking_enabled(struct kvm *kvm);
> +int kvm_page_track_write_tracking_enable(struct kvm *kvm);
>  int kvm_page_track_write_tracking_alloc(struct kvm_memory_slot *slot);
>  
>  void kvm_page_track_free_memslot(struct kvm_memory_slot *slot);
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 671cfeccf04e9..44d15551f7156 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -269,7 +269,7 @@ int kvm_arch_write_log_dirty(struct kvm_vcpu *vcpu);
>  int kvm_mmu_post_init_vm(struct kvm *kvm);
>  void kvm_mmu_pre_destroy_vm(struct kvm *kvm);
>  
> -static inline bool kvm_shadow_root_allocated(struct kvm *kvm)
> +static inline bool mmu_page_tracking_enabled(struct kvm *kvm)
>  {
>  	/*
>  	 * Read shadow_root_allocated before related pointers. Hence, threads
> @@ -277,9 +277,11 @@ static inline bool kvm_shadow_root_allocated(struct kvm *kvm)
>  	 * see the pointers. Pairs with smp_store_release in
>  	 * mmu_first_shadow_root_alloc.
>  	 */

This comment also needs to be rewritten.

> -	return smp_load_acquire(&kvm->arch.shadow_root_allocated);
> +	return smp_load_acquire(&kvm->arch.mmu_page_tracking_enabled);
>  }

...

> diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
> index 2e09d1b6249f3..8857d629036d7 100644
> --- a/arch/x86/kvm/mmu/page_track.c
> +++ b/arch/x86/kvm/mmu/page_track.c
> @@ -21,10 +21,16 @@
>  
>  bool kvm_page_track_write_tracking_enabled(struct kvm *kvm)

This can be static, it's now used only by page_track.c.

>  {
> -	return IS_ENABLED(CONFIG_KVM_EXTERNAL_WRITE_TRACKING) ||
> -	       !tdp_enabled || kvm_shadow_root_allocated(kvm);
> +	return mmu_page_tracking_enabled(kvm);
>  }
>  
> +int kvm_page_track_write_tracking_enable(struct kvm *kvm)

This is too similar to the "enabled" version; "kvm_page_track_enable_write_tracking()"
would maintain namespacing and be less confusing.

Hmm, I'd probably vote to make this a "static inline" in kvm_page_track.h, and
rename mmu_enable_write_tracking() to kvm_mmu_enable_write_tracking and export.
Not a strong preference, just feels silly to export a one-liner.

> +{
> +	return mmu_enable_write_tracking(kvm);
> +}
> +EXPORT_SYMBOL_GPL(kvm_page_track_write_tracking_enable);
> +
> +
>  void kvm_page_track_free_memslot(struct kvm_memory_slot *slot)
>  {
>  	int i;
> -- 
> 2.26.3
> 
