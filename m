Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D136E4B1B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346893AbiBKBdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:33:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346853AbiBKBdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:33:03 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D292E2606
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:33:02 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so10418592pja.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=86u7Yk1s45yAdaNuHNZmXJLjbjBW6l2gIfCXVJT8/Z4=;
        b=RrsR7A4XtwL4br8LYXlsw8s9DV6FLbY+HBjKfavqOifKi1HaR5XkB85e4qQ0uo9kv4
         b8pnMpdv07544nKwyBrPY4LBqx+neSgqcqRfnfHwPOUZ1PiQc1v1rJrME9XFjWoY3GRf
         mPNBTlLHSR+t+PxCkYd+JVNSDSLiIxywte76S/CvYC0il0KPCSGPMhV6xCdcSyq5eI1s
         CkxyBRQJ+yCvk+qkDtJRpaA+RH8OXbibP1JQRQMRtZhlY/LH/Q1Dqiw/QlXrGrdOEgjD
         zrgngkLY41dqJlGNTTKjlsLFPKxwgjmlkozkhL1aAL+jc19qvVhhmd1FY6hYdFxhP6D1
         CCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=86u7Yk1s45yAdaNuHNZmXJLjbjBW6l2gIfCXVJT8/Z4=;
        b=Dp/704mTagRqjRC5dmCe3SEX8OLjgbH2JkqCr24vlVjHAP1w+0kBEBJUmPxN/rEw+G
         LuYphNe/9ifF3k4tIxa/HsH9Sc6vlwj/hpBBCWsZQeEezsJZ9z/HeGD6Pjf0xV0NVobn
         mJT9l6VCTX13ChWJMsjA+//ORTuhg1/+MkOhU+W2cfk+1AEagpIkuk3tjpeTpHNxMM21
         /a/53W/hJESgIBYGGIyHtNY+gohjafYE+13QLlFgj0ol9Qc9q7fO03uoPFG2Mr8Y9dYj
         yq/m4xPjm4xZJJ7VOG4W6qf1aMQpuMrD+3PHebXFWXJc8HqBeiSTlytSklH5yxLBWpPN
         Nd5Q==
X-Gm-Message-State: AOAM531ElKtMr41MmEbQ3Elj+QZVZX9rzDftVdfdcE6ArtFotlOTzquU
        cj4dFz8MitM0wbld4DlMzOYA8g==
X-Google-Smtp-Source: ABdhPJyst66gui/O0sfzKXlaPn3TryFHdo+e13zHCHhJjLtFCy6iPVCfEcOyXBcmL5MK6y4TynHKLQ==
X-Received: by 2002:a17:902:d88e:: with SMTP id b14mr10099564plz.4.1644543181882;
        Thu, 10 Feb 2022 17:33:01 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id il18sm3723408pjb.27.2022.02.10.17.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 17:33:01 -0800 (PST)
Date:   Fri, 11 Feb 2022 01:32:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, mlevitsk@redhat.com, dmatlack@google.com
Subject: Re: [PATCH 09/12] KVM: MMU: look for a cached PGD when going from
 32-bit to 64-bit
Message-ID: <YgW8ySdRSWjPvOQx@google.com>
References: <20220209170020.1775368-1-pbonzini@redhat.com>
 <20220209170020.1775368-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209170020.1775368-10-pbonzini@redhat.com>
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

On Wed, Feb 09, 2022, Paolo Bonzini wrote:
> Right now, PGD caching avoids placing a PAE root in the cache by using the
> old value of mmu->root_level and mmu->shadow_root_level; it does not look
> for a cached PGD if the old root is a PAE one, and then frees it using
> kvm_mmu_free_roots.
> 
> Change the logic instead to free the uncacheable root early.
> This way, __kvm_new_mmu_pgd is able to look up the cache when going from
> 32-bit to 64-bit (if there is a hit, the invalid root becomes the least
> recently used).  An example of this is nested virtualization with shadow
> paging, when a 64-bit L1 runs a 32-bit L2.
> 
> As a side effect (which is actually the reason why this patch was
> written), PGD caching does not use the old value of mmu->root_level
> and mmu->shadow_root_level anymore.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 71 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 54 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 95d0fa0bb876..f61208ccce43 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4087,20 +4087,20 @@ static inline bool is_root_usable(struct kvm_mmu_root_info *root, gpa_t pgd,
>  				  union kvm_mmu_page_role role)
>  {
>  	return (role.direct || pgd == root->pgd) &&
> -	       VALID_PAGE(root->hpa) && to_shadow_page(root->hpa) &&
> +	       VALID_PAGE(root->hpa) &&
>  	       role.word == to_shadow_page(root->hpa)->role.word;
>  }
>  
>  /*
>   * Find out if a previously cached root matching the new pgd/role is available.
> - * The current root is also inserted into the cache.
> - * If a matching root was found, it is assigned to kvm_mmu->root.hpa and true is
> - * returned.
> - * Otherwise, the LRU root from the cache is assigned to kvm_mmu->root.hpa and
> - * false is returned. This root should now be freed by the caller.
> + * If a matching root is found, it is assigned to kvm_mmu->root and
> + * true is returned.
> + * If no match is found, the current root becomes the MRU of the cache

This is misleading, the current root _always_ becomes the MRU of the cache, i.e.
the explanation about rotating the cache to do LRU/MRU updates happens regardless
of whether or not a root is found.

> + * if valid (thus evicting the LRU root), kvm_mmu->root is left invalid,

The "if valid" part is also misleading, this function is called iff the current
root is valid.

> + * and false is returned.
>   */
> -static bool cached_root_available(struct kvm_vcpu *vcpu, gpa_t new_pgd,
> -				  union kvm_mmu_page_role new_role)
> +static bool cached_root_find_and_promote(struct kvm_vcpu *vcpu, gpa_t new_pgd,
> +					 union kvm_mmu_page_role new_role)

I'm not entirely understand what you mean by "promote", but regardless of what
is meant, I find it confusing.

If you mean the root that's found is promoted to the current root, then it's
confusing because cached_root_find_and_replace() also promotes the root it finds.

If you mean something else, then it's obviously confusing, because I don't know
what you mean :-)  If you're referring to the cached roots, that's arguably wrong
because any non-matching root, including the current root, is demoted, not promoted.

Maybe cached_root_find_and_rotate() or cached_root_find_and_age()?

>  {
>  	uint i;
>  	struct kvm_mmu *mmu = vcpu->arch.mmu;
> @@ -4109,13 +4109,48 @@ static bool cached_root_available(struct kvm_vcpu *vcpu, gpa_t new_pgd,
>  		return true;
>  
>  	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++) {
> +		/*
> +		 * The swaps end up rotating the cache like this:
> +		 *   C   0 1 2 3   (on entry to the function)
> +		 *   0   C 1 2 3
> +		 *   1   C 0 2 3
> +		 *   2   C 0 1 3
> +		 *   3   C 0 1 2   (on exit from the loop)

Woot!  I've written this down on my whiteboard sooo many times.  This defintely
warrants a virtual gold star.  :-)

        .
       ,O,
      ,OOO,
'oooooOOOOOooooo'
  `OOOOOOOOOOO`
    `OOOOOOO`
    OOOO'OOOO
   OOO'   'OOO
  O'         'O

> +		 */
>  		swap(mmu->root, mmu->prev_roots[i]);
> -
>  		if (is_root_usable(&mmu->root, new_pgd, new_role))
> -			break;
> +			return true;
>  	}
>  
> -	return i < KVM_MMU_NUM_PREV_ROOTS;
> +	kvm_mmu_free_roots(vcpu, vcpu->arch.mmu, KVM_MMU_ROOT_CURRENT);
> +	return false;
> +}
> +
> +/*
> + * Find out if a previously cached root matching the new pgd/role is available.
> + * If a matching root is found, it is assigned to kvm_mmu->root and true
> + * is returned.  The current, invalid root goes to the bottom of the cache.

Can you phrase this as LRU instead of "bottom of the cache"?  E.g. seomthing like
"The current, invalid root becomes the LRU entry in the cache."

> + * If no match is found, kvm_mmu->root is left invalid and false is returned.
> + */
> +static bool cached_root_find_and_replace(struct kvm_vcpu *vcpu, gpa_t new_pgd,
> +					 union kvm_mmu_page_role new_role)
> +{
> +	uint i;
> +	struct kvm_mmu *mmu = vcpu->arch.mmu;

Hmm, while we're refactoring this, I'd really prefer we not grab vcpu->arch.mmu
way down in the helpers.  @vcpu is needed only for the request, so what about
doing this?

	if (!fast_pgd_switch(vcpu, new_pgd, new_role)) {
		/*
		 * <whatever kvm_mmu_reload() becomes> will set up a new root
		 * prior to the next VM-Enter.  Free the current root if it's
		 * valid, i.e. if a valid root was evicted from the cache.
		 */
		if (VALID_PAGE(vcpu->arch.mmu->root.hpa))
			kvm_mmu_free_roots(vcpu, vcpu->arch.mmu, KVM_MMU_ROOT_CURRENT);
		return;
	}

Then the low level helpers can take @mmu, not @vcpu.

> +
> +	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)

Needs curly braces.
> +		if (is_root_usable(&mmu->prev_roots[i], new_pgd, new_role))
> +			goto hit;
> +
> +	return false;
> +
> +hit:
> +	swap(mmu->root, mmu->prev_roots[i]);
> +	/* Bubble up the remaining roots.  */
> +	for (; i < KVM_MMU_NUM_PREV_ROOTS - 1; i++)
> +		mmu->prev_roots[i] = mmu->prev_roots[i + 1];
> +	mmu->prev_roots[i].hpa = INVALID_PAGE;

This looks wrong.

> +	return true;
>  }
>  
>  static bool fast_pgd_switch(struct kvm_vcpu *vcpu, gpa_t new_pgd,
> @@ -4124,22 +4159,24 @@ static bool fast_pgd_switch(struct kvm_vcpu *vcpu, gpa_t new_pgd,
>  	struct kvm_mmu *mmu = vcpu->arch.mmu;
>  
>  	/*
> -	 * For now, limit the fast switch to 64-bit hosts+VMs in order to avoid
> +	 * For now, limit the caching to 64-bit hosts+VMs in order to avoid
>  	 * having to deal with PDPTEs. We may add support for 32-bit hosts/VMs
>  	 * later if necessary.

Probably worth explicitly calling out that the current root needs to be nuked to
avoid shoving it into the cache, that's somewhat subtle.

>  	 */
> -	if (mmu->shadow_root_level >= PT64_ROOT_4LEVEL &&
> -	    mmu->root_level >= PT64_ROOT_4LEVEL)
> -		return cached_root_available(vcpu, new_pgd, new_role);
> +	if (VALID_PAGE(mmu->root.hpa) && !to_shadow_page(mmu->root.hpa))

Hmm, so it doesn't matter (yet) because shadowing 4-level NPT with 5-level NPT
is fubar anyways[1], but this will prevent caching roots when shadowing 4-level
NPT with 5-level NPT (have I mentioned how much I love NPT?).  This can be:

	if (VALID_PAGE(mmu->root.hpa) && mmu->root.hpa == __pa(mmu->pae_root))

This should also Just Work when all roots are backed by shadow pages[2], which I
really hope we can make happen (it's by far the easiest way to deal with nested NPT).

[1] https://lore.kernel.org/lkml/YbFY533IT3XSIqAK@google.com
[2] https://lore.kernel.org/all/20211210092508.7185-1-jiangshanlai@gmail.com

> +		kvm_mmu_free_roots(vcpu, vcpu->arch.mmu, KVM_MMU_ROOT_CURRENT);
>  
> -	return false;
> +	if (VALID_PAGE(mmu->root.hpa))
> +		return cached_root_find_and_promote(vcpu, new_pgd, new_role);
> +	else
> +		return cached_root_find_and_replace(vcpu, new_pgd, new_role);
>  }
>  
>  static void __kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t new_pgd,
>  			      union kvm_mmu_page_role new_role)
>  {
>  	if (!fast_pgd_switch(vcpu, new_pgd, new_role)) {
> -		kvm_mmu_free_roots(vcpu, vcpu->arch.mmu, KVM_MMU_ROOT_CURRENT);
> +		/* kvm_mmu_ensure_valid_pgd will set up a new root.  */
>  		return;
>  	}
>  
> -- 
> 2.31.1
> 
> 
