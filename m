Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA46480157
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 17:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbhL0QAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 11:00:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:52627 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240030AbhL0P7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640620794; x=1672156794;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Qopi0GCbZb8D3tqnGHATwO1hv9M0cdIa+FRZv6opEto=;
  b=CU7xhaTCZMByetb9EFG7yF6dptQXGhV3L0pWaETGBguZOWK8W7RDHPEZ
   zvQts/HJU9I/awVwlb0/hKps6dvPMUaUbEpsH52qDvMIgMmUOZqCqoTno
   PCk/ho5pdC1eIHfTira04eIFe+0AMkkccWr5VUFdn40oSdfiH6SvxRPVl
   Fzfbh1jlKEmmYWCEU3T2j7G9jKIeCd5DqwOlicD3KJ5BJJu4pjL9PoXp0
   oS8YUPjIwET4qHaK/aB73DrpW2qqflM26pVMJQfce6UjIAxOrcluUN3MQ
   ZxRtcM8Iiq1ZJeqNJWQ4oVmP7NfOtk6UkV/iL+7pBNcjkSzdXnPGtMPx9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="241441778"
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="241441778"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 07:56:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="486053937"
Received: from dannysua-mobl2.amr.corp.intel.com (HELO [10.212.232.47]) ([10.212.232.47])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 07:56:16 -0800
Subject: Re: [PATCH v2 3/3] x86: Support huge vmalloc mappings
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Matthew Wilcox <willy@infradead.org>
References: <20211227145903.187152-1-wangkefeng.wang@huawei.com>
 <20211227145903.187152-4-wangkefeng.wang@huawei.com>
From:   Dave Hansen <dave.hansen@intel.com>
Message-ID: <70ff58bc-3a92-55c2-2da8-c5877af72e44@intel.com>
Date:   Mon, 27 Dec 2021 07:56:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211227145903.187152-4-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 6:59 AM, Kefeng Wang wrote:
> This patch select HAVE_ARCH_HUGE_VMALLOC to let X86_64 and X86_PAE
> support huge vmalloc mappings.

In general, this seems interesting and the diff is simple.  But, I don't
see _any_ x86-specific data.  I think the bare minimum here would be a
few kernel compiles and some 'perf stat' data for some TLB events.

> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index 95fa745e310a..6bf5cb7d876a 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -75,8 +75,8 @@ void *module_alloc(unsigned long size)
>  
>  	p = __vmalloc_node_range(size, MODULE_ALIGN,
>  				    MODULES_VADDR + get_module_load_offset(),
> -				    MODULES_END, gfp_mask,
> -				    PAGE_KERNEL, VM_DEFER_KMEMLEAK, NUMA_NO_NODE,
> +				    MODULES_END, gfp_mask, PAGE_KERNEL,
> +				    VM_DEFER_KMEMLEAK | VM_NO_HUGE_VMAP, NUMA_NO_NODE,
>  				    __builtin_return_address(0));
>  	if (p && (kasan_module_alloc(p, size, gfp_mask) < 0)) {
>  		vfree(p);

To figure out what's going on in this hunk, I had to look at the cover
letter (which I wasn't cc'd on).  That's not great and it means that
somebody who stumbles upon this in the code is going to have a really
hard time figuring out what is going on.  Cover letters don't make it
into git history.

This desperately needs a comment and some changelog material in *this*
patch.

But, even the description from the cover letter is sparse:

> There are some disadvantages about this feature[2], one of the main
> concerns is the possible memory fragmentation/waste in some scenarios,
> also archs must ensure that any arch specific vmalloc allocations that
> require PAGE_SIZE mappings(eg, module alloc with STRICT_MODULE_RWX)
> use the VM_NO_HUGE_VMAP flag to inhibit larger mappings.

That just says that x86 *needs* PAGE_SIZE allocations.  But, what
happens if VM_NO_HUGE_VMAP is not passed (like it was in v1)?  Will the
subsequent permission changes just fragment the 2M mapping?
