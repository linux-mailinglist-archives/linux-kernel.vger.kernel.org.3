Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EEC480B23
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbhL1QPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:15:05 -0500
Received: from mga11.intel.com ([192.55.52.93]:11155 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235159AbhL1QPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640708104; x=1672244104;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vD34BvYBr7K6ySutnohM2Grn1RkmZJLe6AIv33TdiOM=;
  b=liHHCqAYlgTFFzT6Mv32bNaTHNC9x5vifpR41g1hZMM3Rq55IkE3FJv4
   XQzhpabAjktmAlabez+/CnsbFMx8e5CFMX2U9ioaXbUun1K7t3vL7S149
   qtN0bpmr8BXRbeCuXFjfl7tvH8b676xqi9N/E/Eik8cv+YeBGuZyHAWFX
   +I8WEsAjpKwUGyP51Zh+uy3RGnXrPw65FOgOpgot+afitw76DUSxmyrCz
   j4i2pmaOXtWbctX7iP0F4uNYZyZjNHBCqIjFpGvdqE/VnfvCUbY+PoyW5
   svzCWUVF/92l0exF5+ww2DzCbksOfGAQP8ENbt2dbwiIwuKW2fRsW4D7I
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="238931395"
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="238931395"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 08:15:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="470066185"
Received: from jseaman-mobl.amr.corp.intel.com (HELO [10.252.133.172]) ([10.252.133.172])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 08:15:01 -0800
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
 <70ff58bc-3a92-55c2-2da8-c5877af72e44@intel.com>
 <3858de1f-cdbc-ff52-2890-4254d0f48b0a@huawei.com>
From:   Dave Hansen <dave.hansen@intel.com>
Message-ID: <31a75f95-6e6e-b640-2d95-08a95ea8cf51@intel.com>
Date:   Tue, 28 Dec 2021 08:14:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <3858de1f-cdbc-ff52-2890-4254d0f48b0a@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/21 2:26 AM, Kefeng Wang wrote:
>>> There are some disadvantages about this feature[2], one of the main
>>> concerns is the possible memory fragmentation/waste in some scenarios,
>>> also archs must ensure that any arch specific vmalloc allocations that
>>> require PAGE_SIZE mappings(eg, module alloc with STRICT_MODULE_RWX)
>>> use the VM_NO_HUGE_VMAP flag to inhibit larger mappings.
>> That just says that x86 *needs* PAGE_SIZE allocations.  But, what
>> happens if VM_NO_HUGE_VMAP is not passed (like it was in v1)?  Will the
>> subsequent permission changes just fragment the 2M mapping?
> 
> Yes, without VM_NO_HUGE_VMAP, it could fragment the 2M mapping.
> 
> When module alloc with STRICT_MODULE_RWX on x86, it calls
> __change_page_attr()
> 
> from set_memory_ro/rw/nx which will split large page, so there is no
> need to make
> 
> module alloc with HUGE_VMALLOC.

This all sounds very fragile to me.  Every time a new architecture would
get added for huge vmalloc() support, the developer needs to know to go
find that architecture's module_alloc() and add this flag.  They next
guy is going to forget, just like you did.

Considering that this is not a hot path, a weak function would be a nice
choice:

/* vmalloc() flags used for all module allocations. */
unsigned long __weak arch_module_vm_flags()
{
	/*
	 * Modules use a single, large vmalloc().  Different
	 * permissions are applied later and will fragment
	 * huge mappings.  Avoid using huge pages for modules.
	 */
	return VM_NO_HUGE_VMAP;
}

Stick that in some the common module code, next to:

> void * __weak module_alloc(unsigned long size)
> {
>         return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
...

Then, put arch_module_vm_flags() in *all* of the module_alloc()
implementations, including the generic one.  That way (even with a new
architecture) whoever copies-and-pastes their module_alloc()
implementation is likely to get it right.  The next guy who just does a
"select HAVE_ARCH_HUGE_VMALLOC" will hopefully just work.

VM_FLUSH_RESET_PERMS could probably be dealt with in the same way.
