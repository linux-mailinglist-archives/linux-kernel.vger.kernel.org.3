Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781DE4BEC38
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiBUVFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:05:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbiBUVFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:05:45 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD7A23BCD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:05:21 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5BCDF1EC0528;
        Mon, 21 Feb 2022 22:05:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645477516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZLr4Dbc0Ykgd1Sw1Vf7Q0Pg/edHQ0YaSAAU2I1EwowE=;
        b=MkwLljycWkQ/Tt3zp7OfEImPdLn+OFcZeTcnVvSFsaAhzdllZuaAZ2oPRC92TpMiyrJa1d
        WKCJf3rI5uY0Gb5PceboCDuaq83cFk9BtSVqL0K+s/AF/0oVbn2uGP1GEX5K8Q4SupPal5
        rbLVtbeXSs6AuJ7DWR8t/4XuwiS4A1g=
Date:   Mon, 21 Feb 2022 22:05:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        knsathya@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: Re: [PATCHv3.1 2.1/2] x86/coco: Add API to handle encryption mask
Message-ID: <YhP+kES/UVx7RwYz@zn.tnic>
References: <YhAWcPbzgUGcJZjI@zn.tnic>
 <20220219001305.22883-1-kirill.shutemov@linux.intel.com>
 <20220219001305.22883-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220219001305.22883-2-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 03:13:05AM +0300, Kirill A. Shutemov wrote:
> AMD SME/SEV uses a bit in the page table entries to indicate that the
> page is encrypted and not accessible to the VMM.
> 
> TDX uses a similar approach, but the polarity of the mask is opposite to
> AMD: if the bit is set the page is accessible to VMM.
> 
> Provide vendor-neutral API to deal with the mask:
> 
>   - cc_mkenc() and cc_mkdec() modify given address to make it
>     encrypted/decrypted. It can be applied to phys_addr_t, pgprotval_t
>     or page table entry value.
> 
>   - cc_get_mask() returns encryption or decrypthion mask. It is useful

Unknown word [encrypthion] in commit message.
Suggestions: ['encryption', 'decryption']

Unknown word [decrypthion] in commit message.
Suggestions: ['decryption', 'encryption']

>     for set_memory_encrypted() and set_memory_decrypted()
>     implementation.
> 
> The implementation will be extended to cover TDX.
> 
> pgprot_decrypted() is used by drivers (i915, virtio_gpu, vfio).
> cc_mkdec() called by pgprot_decrypted(). Export cc_mkdec().
> 
> HyperV doesn't use bits in page table entries, so the mask is 0 for both
> encrypthion and decrypthion.

ditto.

> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index d77cf3a31f07..9af6be143998 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -346,7 +346,7 @@ static void __init ms_hyperv_init_platform(void)
>  		swiotlb_force = SWIOTLB_FORCE;
>  #endif
>  		if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
> -			cc_init(CC_VENDOR_HYPERV);
> +			cc_init(CC_VENDOR_HYPERV, 0);
>  	}
>  
>  	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index eb7fbd85b77e..fa758247ab57 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -603,5 +603,5 @@ void __init sme_enable(struct boot_params *bp)
>  out:
>  	physical_mask &= ~sme_me_mask;
>  	if (sme_me_mask)
> -		cc_init(CC_VENDOR_AMD);
> +		cc_init(CC_VENDOR_AMD, sme_me_mask);

I'm wondering why this is looking weird... an init function with two
arguments which get assigned. I think it would be better if you do:

	cc_set_vendor(CC_VENDOR_XXX);
	cc_set_mask(mask);

and those helpers simply assign to __ro_after_init, local variables.

IOW, simple setter functions.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
