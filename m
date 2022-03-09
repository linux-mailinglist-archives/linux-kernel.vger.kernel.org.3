Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4654D3A85
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbiCITpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbiCITpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:45:17 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C53C5DB8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 11:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646855057; x=1678391057;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=b1H4XnUG186Q1fM2HqTD8xktjQ01F+tOP/NZT0bJJbs=;
  b=Gk7qxxPyIAbV3TJslNxwd3PrXxcorVtXAGG3uPmSfQLEKzzQqOCuw8wQ
   RbuRhj0UH4aD2Ybbsc3cwI9LacDtQWx5FsdIe4ZdT5hHO+IIJh59YXcCY
   XZ9HQDHDZYCIrFWsX0qJKNLO8ClgR81R2ucJCQF52bIEA//dRzCkpSNN8
   8JAhDx4EBNtov6zR+4DuAGQFeNXoQDLiof9tNU0w0Di2telsdSibkhT7x
   /0bUI8AXiIH0oLDQ3mUYWwltu9dzXN94sld30WqdtQnMH7YIoxm19JCGW
   cY0fFyNehmQtmBOykke47ZSs24mzqbM9tuceqbklTa/JOchHr6HeMTMMG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255017920"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="255017920"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 11:44:17 -0800
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="642277047"
Received: from sli6-mobl.amr.corp.intel.com (HELO [10.209.104.236]) ([10.209.104.236])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 11:44:15 -0800
Message-ID: <4e5aaf9f-10b2-e659-5173-a710f4423cf6@intel.com>
Date:   Wed, 9 Mar 2022 11:44:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-27-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5 26/30] x86/mm/cpa: Add support for TDX shared memory
In-Reply-To: <20220302142806.51844-27-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static bool tdx_tlb_flush_required(bool enc)
> +{
> +	/*
> +	 * TDX guest is responsible for flushing caches on private->shared

Caches?  In a "tlb" flushing function?  Did you mean paging structure
caches or CPU caches?

> +	 * transition. VMM is responsible for flushing on shared->private.
> +	 */
> +	return !enc;
> +}

It's also pretty nasty to have that argument called 'enc' when there's
no encryption in the comment.  That at least needs to be mentioned.

I'd also appreciate a mention somewhere of what the security/stability
model is here.  What if a malicious VMM doesn't flush on a
shared->private transition?  What is the fallout?  Who gets hurt?

> +static bool tdx_cache_flush_required(void)
> +{
> +	return true;
> +}

This leaves me totally in the dark.  I frankly don't know what
enc_tlb_flush_required does without looking, but I also don't know your
intent.  A one-liner about intent would be nice to ensure it matches
what enc_tlb_flush_required does.

> +static bool accept_page(phys_addr_t gpa, enum pg_level pg_level)
> +{
> +	/*
> +	 * Pass the page physical address to the TDX module to accept the
> +	 * pending, private page.
> +	 *
> +	 * Bits 2:0 of GPA encode page size: 0 - 4K, 1 - 2M, 2 - 1G.
> +	 */
> +	switch (pg_level) {
> +	case PG_LEVEL_4K:
> +		break;
> +	case PG_LEVEL_2M:
> +		gpa |= 1;
> +		break;
> +	case PG_LEVEL_1G:
> +		gpa |= 2;
> +		break;
> +	default:
> +		return false;
> +	}

Just a style thing.  I'd much rather this be something like:

	u8 page_size;
	u64 tdcall_rcx;

	switch (pg_level) {
	case PG_LEVEL_4K:
		page_size = 0;
		break;
	case PG_LEVEL_2M:
		page_size = 1;
		break;
	case PG_LEVEL_1G:
		page_size = 2;
		break;
	default:
		return false;
	}

	tdcall_rcx = gpa | page_size;

BTW, the spec from August 2021 says these bits are "either 0 (4kb) or 1
(2MB)" on the spec.  No mention of 1G.


> +	return !__tdx_module_call(TDX_ACCEPT_PAGE, gpa, 0, 0, 0, NULL);
> +}

The TDX rcx register in the TDX_ACCEPT_PAGE is *NOT* the gpa.  It
contains the gpa in a few of its bits.  Doing it this way ^ makes it
painfully clear that argument is not solely a gpa.

> +/*
> + * Inform the VMM of the guest's intent for this physical page: shared with
> + * the VMM or private to the guest.  The VMM is expected to change its mapping
> + * of the page in response.
> + */
> +static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
> +{
> +	phys_addr_t start = __pa(vaddr);
> +	phys_addr_t end = __pa(vaddr + numpages * PAGE_SIZE);
> +
> +	if (!enc) {
> +		start |= cc_mkdec(0);
> +		end |= cc_mkdec(0);
> +	}
> +
> +	/*
> +	 * Notify the VMM about page mapping conversion. More info about ABI
> +	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
> +	 * section "TDG.VP.VMCALL<MapGPA>"
> +	 */
> +	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
> +		return false;

This is really confusing.  "start" and "end" are physical addresses and
you're doing physical address math on them.  But they also have some
other bits encoded in them.

I *guess* that works.  If you've set the same bits in both, then you
subtract them, the bits cancel out.  But, it's horribly confusing.

Look how much more sane this is to read if we do a few things:

	phys_addr_t start = __pa(vaddr);
	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
			^ add vertical alignment
	phys_addr_t len_bytes = end - start;
	bool private = enc;

	if (!private) {
		/* Set the shared (decrypted) bits: */
		    ^ Note that we're helping the reader impedance-match
	 		between 'enc' and shared/private
		start |= cc_mkdec(0);
		end   |= cc_mkdec(0);
		    ^ more vertical alginment
	}

	if (__tdx_hypercall(TDVMCALL_MAP_GPA, start, len_bytes, 0, 0))
		return false;


> +	/* private->shared conversion  requires only MapGPA call */
> +	if (!enc)
> +		return true;
> +
> +	/*
> +	 * For shared->private conversion, accept the page using
> +	 * TDX_ACCEPT_PAGE TDX module call.
> +	 */
> +	while (start < end) {
> +		/* Try if 1G page accept is possible */
> +		if (!(start & ~PUD_MASK) && end - start >= PUD_SIZE &&
> +		    accept_page(start, PG_LEVEL_1G)) {
> +			start += PUD_SIZE;
> +			continue;
> +		}

This is rather ugly.  Why not just do a helper:

static int try_accept_one(phys_addr_t *start, unsigned long len,
unsigned long accept_size)
{
	int ret;

	if (!IS_ALIGNED(*start, accept_size));
		return -ESOMETHING;
	if (len < accept_size)
		return -ESOMETHING;

	ret = accept_page(start, size_to_level(accept_size));

	if (!ret)
		*start += accept_size;

	return ret;
}

Then the loop becomes actually readable:

	while (start < end) {
		len = end - start;

		/* Try larger accepts first because... */	

		ret = try_accept_one(&start, len, PUD_SIZE);
		if (ret)
			continue;

		ret = try_accept_one(&start, len, PMD_SIZE);
		if (ret)
			continue;

		ret = try_accept_one(&start, len, PTE_SIZE);
		if (ret)
			return false;
	}



> +
> +		/* Try if 2M page accept is possible */
> +		if (!(start & ~PMD_MASK) && end - start >= PMD_SIZE &&
> +		    accept_page(start, PG_LEVEL_2M)) {
> +			start += PMD_SIZE;
> +			continue;
> +		}
> +
> +		if (!accept_page(start, PG_LEVEL_4K))
> +			return false;
> +		start += PAGE_SIZE;
> +	}
> +
> +	return true;
> +}
> +
>  void __init tdx_early_init(void)
>  {
>  	unsigned int gpa_width;
> @@ -526,5 +623,9 @@ void __init tdx_early_init(void)
>  	 */
>  	cc_set_mask(BIT_ULL(gpa_width - 1));
>  
> +	x86_platform.guest.enc_cache_flush_required = tdx_cache_flush_required;
> +	x86_platform.guest.enc_tlb_flush_required = tdx_tlb_flush_required;
> +	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;

Could you double-check for vertical alignment opportunities in this
patch?  This is a place where two spaces can at least tell you quickly
that this is all TDX-specific:

	x86_platform.guest.enc_cache_flush_required = tdx_cache_flush_required;
	x86_platform.guest.enc_tlb_flush_required   = tdx_tlb_flush_required;
	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;

>  	pr_info("Guest detected\n");
>  }
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 1c3cb952fa2a..080f21171b27 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -1308,7 +1308,7 @@ static void ve_raise_fault(struct pt_regs *regs, long error_code)
>   *
>   * In the settings that Linux will run in, virtualization exceptions are
>   * never generated on accesses to normal, TD-private memory that has been
> - * accepted.
> + * accepted (by BIOS or with tdx_enc_status_changed()).
>   *
>   * Syscall entry code has a critical window where the kernel stack is not
>   * yet set up. Any exception in this window leads to hard to debug issues

