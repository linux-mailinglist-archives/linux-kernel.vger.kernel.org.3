Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37CA4A6998
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 02:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243321AbiBBB1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 20:27:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43558 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiBBB1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 20:27:38 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643765256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DAAMAob0i2Ypp+A9dlOUSKJsFprakiY3w91g/F0pEqo=;
        b=Rme5/egE39TnNwf0GTCFnL9MNSNkspm0gKJ+rlEleTqe0/nlhTI2VesMG5JwaPOoYMnM53
        xAi1+cejjJx7pHhlu/bJ6NuNPTqRFm5oAn3WX7fALzjKFzdB7GjGzBZT/tk9i6y3MKemHP
        MylvXELtvfozwZ6zIbwutKjrRHiGUNhOkxsH9l6qsd8LvSHSleWhOVQdo8CYRfC43QvrXH
        CmPO7wPe67QEFPYjdM4hoPSP31cGDS9MUN+E1irZocRDjdldkThtZG4JtjZAbYrw87BSQ9
        UzL3tBnot4GBvmZFzPvsVJmJH99OtQX6ec004j5Xng4IsmzknM2lsmVHrKzmBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643765256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DAAMAob0i2Ypp+A9dlOUSKJsFprakiY3w91g/F0pEqo=;
        b=5oUaHDluevtFg/jMsO7qupZnzIKHQWozO7fNzXC/8HuO5uz5qu94LffpaJpF/5cizgD+zW
        OQPHL+sQM8/5WcBQ==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>
Subject: Re: [PATCHv2 24/29] x86/mm/cpa: Add support for TDX shared memory
In-Reply-To: <20220124150215.36893-25-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-25-kirill.shutemov@linux.intel.com>
Date:   Wed, 02 Feb 2022 02:27:36 +0100
Message-ID: <875ypyvz07.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
> -void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc)
> +int amd_notify_range_enc_status_changed(unsigned long vaddr, int npages,
> +					 bool enc)
>  {
>  #ifdef CONFIG_PARAVIRT
>  	unsigned long sz = npages << PAGE_SHIFT;
> @@ -270,7 +271,7 @@ void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc)
>  		kpte = lookup_address(vaddr, &level);
>  		if (!kpte || pte_none(*kpte)) {
>  			WARN_ONCE(1, "kpte lookup for vaddr\n");
> -			return;
> +			return 0;
>  		}
>  
>  		pfn = pg_level_to_pfn(level, kpte, NULL);
> @@ -285,6 +286,7 @@ void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc)
>  		vaddr = (vaddr & pmask) + psize;
>  	}
>  #endif
> +	return 0;
>  }

This is obviously a preparatory change, so please split it out into a
seperate patch. You know the drill already, right?

> +static pgprot_t pgprot_cc_mask(bool enc)
> +{
> +	if (enc)
> +		return pgprot_encrypted(__pgprot(0));
> +	else
> +		return pgprot_decrypted(__pgprot(0));
> +}

How is this relevant to the scope of this TDX patch? Why is this not
part of the previous change which consolidated __pgprot(_PAGE_ENC)?

Just because it is too obvious to fixup the usage sites first?

> +static int notify_range_enc_status_changed(unsigned long vaddr, int npages,
> +					   bool enc)
> +{
> +	if (cc_platform_has(CC_ATTR_GUEST_TDX)) {
> +		phys_addr_t start = __pa(vaddr);
> +		phys_addr_t end = __pa(vaddr + npages * PAGE_SIZE);
> +
> +		return tdx_hcall_request_gpa_type(start, end, enc);
> +	} else {
> +		return amd_notify_range_enc_status_changed(vaddr, npages, enc);
> +	}

This is more than lame, really. The existing SEV specific
notify_range_enc_status_changed() function has been called
unconditionally, but for TDX you add a cc_platform_has() check and still
call the AMD part unconditionally if !TDX.

Aside of that the two functions have different calling conventions. Why?

Just because the TDX function which you defined requires physical
addresses this needs to be part of the PAT code?

Make both functions share the same calling conventions and thinks hard
about whether cc_platform_has() is the proper mechanism. There are other
means to handle such things. Hint: x86_platform_ops

> +}
> +
>  /*
>   * __set_memory_enc_pgtable() is used for the hypervisors that get
>   * informed about "encryption" status via page tables.
> @@ -1999,8 +2021,10 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  	memset(&cpa, 0, sizeof(cpa));
>  	cpa.vaddr = &addr;
>  	cpa.numpages = numpages;
> -	cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
> -	cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
> +
> +	cpa.mask_set = pgprot_cc_mask(enc);
> +	cpa.mask_clr = pgprot_cc_mask(!enc);
> +
>  	cpa.pgd = init_mm.pgd;
>  
>  	/* Must avoid aliasing mappings in the highmem code */
> @@ -2008,9 +2032,17 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  	vm_unmap_aliases();
>  
>  	/*
> -	 * Before changing the encryption attribute, we need to flush caches.
> +	 * Before changing the encryption attribute, flush caches.
> +	 *
> +	 * For TDX, guest is responsible for flushing caches on private->shared
> +	 * transition. VMM is responsible for flushing on shared->private.
>  	 */
> -	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
> +	if (cc_platform_has(CC_ATTR_GUEST_TDX)) {
> +		if (!enc)
> +			cpa_flush(&cpa, 1);
> +	} else {
> +		cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
> +	}

This is the point where my disgust tolerance ends. Seriously. Is that
all you can come up with? Slapping this kind of conditionals all over
the place?

Again. Think hard about the right abstraction for this and not about how
to duct tape it into the existing code. Just becausre cc_platform_has()
exists does not mean it's the only tool which can be used. Not
everything is a nail...

This screams for an indirect branch, e.g. some extension to the existing
x86_platform_ops.

It's trivial enough to add a (encrypted) guest specific data structure
with relevant operations to x86_platform_ops and fill that in on
detection like we do for other things. Then the whole muck here boils
down to:

-	notify_range_enc_status_changed(addr, numpages, enc);
-
+	if (!ret)
+		ret =  x86_platform.guest.enc_status_changed(addr, numpages, enc);

and

-	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
+	cpa_flush(&cpa, x86_platform.guest.enc_flush_required(enc));

Hmm?

Feel free to come up with better names...

Thanks,

        tglx
