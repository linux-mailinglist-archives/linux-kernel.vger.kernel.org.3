Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254124A6948
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243413AbiBBAf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:35:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43330 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243361AbiBBAf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:35:57 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643762155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Xudt/1SVXxRDSAo0YR4XJsi03SY4B60SrXuaXjIQIo=;
        b=1iCDj2nNY6Bpay67jZM5r1f6Q5iMhDdg+lt0RI9DKvwBJUBFVp5tGpA4Q3xEGENgCICP7n
        foYiweJUyhuSUTqR+EM6/OlXbMS+s0PhRzaa6skcCs26CJQkDwVnd5UWT2qauSJea/TOQB
        CTI32CuBHvyNPEQS+EYnfqn6o3b83kF6ryXDGGFAZG38tJ57k67ULC7Zanj+DuSBOBtu55
        e5iQ9bMmZ8CMSjgUtliApoxXK6CPLMRhGT3oBMZGdupAMdowWVLtpz7PrwxMYKhbewLr4U
        gJsefiSqv1dvDYC42ploSxVa88ZhPEvV+N3QPyJjIaLqKBGkRLXTHqygTLbVFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643762155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Xudt/1SVXxRDSAo0YR4XJsi03SY4B60SrXuaXjIQIo=;
        b=8xCqzp14BPLDps1q/5K8jmFwezgWc3qF0nQFx7GcfOi4Ql7S0ZdnIJW65eVmjEBa1Ld7nf
        A+jdpOYIZHRxcQCw==
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 23/29] x86/tdx: Add helper to convert memory between
 shared and private
In-Reply-To: <20220124150215.36893-24-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-24-kirill.shutemov@linux.intel.com>
Date:   Wed, 02 Feb 2022 01:35:54 +0100
Message-ID: <878ruuw1ed.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
> Intel TDX protects guest memory from VMM access. Any memory that is
> required for communication with the VMM must be explicitly shared.
>
> It is a two-step process: the guest sets the shared bit in the page
> table entry and notifies VMM about the change. The notification happens
> using MapGPA hypercall.
>
> Conversion back to private memory requires clearing the shared bit,
> notifying VMM with MapGPA hypercall following with accepting the memory
> with AcceptPage hypercall.
>
> Provide a helper to do conversion between shared and private memory.
> It is going to be used by the following patch.

Strike that last sentence...

> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -13,6 +13,10 @@
>  /* TDX module Call Leaf IDs */
>  #define TDX_GET_INFO			1
>  #define TDX_GET_VEINFO			3
> +#define TDX_ACCEPT_PAGE			6
> +
> +/* TDX hypercall Leaf IDs */
> +#define TDVMCALL_MAP_GPA		0x10001
>  
>  /* See Exit Qualification for I/O Instructions in VMX documentation */
>  #define VE_IS_IO_IN(exit_qual)		(((exit_qual) & 8) ? 1 : 0)
> @@ -97,6 +101,80 @@ static void tdx_get_info(void)
>  	td_info.attributes = out.rdx;
>  }
>  
> +static bool tdx_accept_page(phys_addr_t gpa, enum pg_level pg_level)
> +{
> +	/*
> +	 * Pass the page physical address to the TDX module to accept the
> +	 * pending, private page.
> +	 *
> +	 * Bits 2:0 if GPA encodes page size: 0 - 4K, 1 - 2M, 2 - 1G.
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
> +		return true;

Crack. boolean return true means success. Can we please keep this
convention straight throughout the code and not as you see fit?

This random choice of return code meanings is just a recipe for
disaster. Consistency matters.

> +	}
> +
> +	return __tdx_module_call(TDX_ACCEPT_PAGE, gpa, 0, 0, 0, NULL);
> +}
> +
> +/*
> + * Inform the VMM of the guest's intent for this physical page: shared with
> + * the VMM or private to the guest.  The VMM is expected to change its mapping
> + * of the page in response.
> + */
> +int tdx_hcall_request_gpa_type(phys_addr_t start, phys_addr_t end, bool enc)
> +{
> +	u64 ret;
> +
> +	if (end <= start)
> +		return -EINVAL;
> +
> +	if (!enc) {
> +		start |= tdx_shared_mask();
> +		end |= tdx_shared_mask();
> +	}
> +
> +	/*
> +	 * Notify the VMM about page mapping conversion. More info about ABI
> +	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
> +	 * sec "TDG.VP.VMCALL<MapGPA>"
> +	 */
> +	ret = _tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0, NULL);
> +
> +	if (ret)
> +		ret = -EIO;
> +
> +	if (ret || !enc)
> +		return ret;
> +
> +	/*
> +	 * For shared->private conversion, accept the page using
> +	 * TDX_ACCEPT_PAGE TDX module call.
> +	 */
> +	while (start < end) {
> +		/* Try 2M page accept first if possible */

Talking about consistency:

tdx_accept_page() implements 1G maps, but they are not required to be
handled here for some random reason, right?

> +		if (!(start & ~PMD_MASK) && end - start >= PMD_SIZE &&
> +		    !tdx_accept_page(start, PG_LEVEL_2M)) {
> +			start += PMD_SIZE;
> +			continue;
> +		}
> +
> +		if (tdx_accept_page(start, PG_LEVEL_4K))
> +			return -EIO;
> +		start += PAGE_SIZE;
> +	}

Thanks,

        tglx
