Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4030E51CE56
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388185AbiEFB7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 21:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbiEFB66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 21:58:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38E1332
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 18:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651802116; x=1683338116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vb9z/PeiA7AoF2yieZao6NQviemX7jtg0+6eKDesZy8=;
  b=GO8tm6enMDexGmdlbhS5Z+mfuzQSawXT6zCHkGD2x0HCVdEtLOWuOwQB
   +QD5/jGmCV+NaDwfO/5qE9cCfwBy1wA39uu/l7E1ROtGqtjIBPnfiikoL
   JetmsUPG2I/Vs998ArUNMvO81+VsallacDyWnH4ujqJi9DYPo/CQYPR/x
   neORu9+q2J6ntKtSOeViOpmJF4kKiBMbCJKQ2RHEuwyz5GYuqXpy2ffYe
   d1WT2iKvTlHsgn/dm07R2WpiIPj+VUC8K1lquCLrl6DKm7qidN8L0Jt/1
   HRUAaSS+nIyk7rrvAXH95wUbUjDO6Hi6XmhlVihLs4Y0p12Bl5m6ThYFa
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="267156888"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="267156888"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:55:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="585691206"
Received: from jdrobitc-mobl1.amr.corp.intel.com (HELO [10.209.123.186]) ([10.209.123.186])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:55:15 -0700
Message-ID: <497c6cf7-7d6e-a019-0f88-57200e3e81c3@linux.intel.com>
Date:   Thu, 5 May 2022 18:55:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
 <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
 <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
 <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
 <2ed5c9cc316950a5a47ee714715b7980f358a140.camel@intel.com>
 <ab17102c-0cb7-87d3-3494-969866d64573@linux.intel.com>
 <d53696f85ada39a91a3685c61d177c582810772e.camel@intel.com>
 <d63d2774-c44d-27da-74b6-550935a196fd@intel.com>
 <dca06ffa36abe9989f0a7abaeafc83c1a7250651.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <dca06ffa36abe9989f0a7abaeafc83c1a7250651.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/22 5:11 PM, Kai Huang wrote:
> On Thu, 2022-05-05 at 16:06 -0700, Dave Hansen wrote:
>> On 5/5/22 15:15, Kai Huang wrote:
>>> set_memory_xx()  is supposedly only for direct-mapping.  Please use my
>>> suggestion above.
>>
>> Kai, please take a look at some of the other users, especially
>> set_memory_x().  See how long the "supposed" requirement holds up.
> 
> Right I should not have used "supposed".  My bad.  I got the impression by
> roughly looking at set_memory_{uc|wc..}().  Looks they can only work on direct
> mapaping as they internally uses __pa():
> 
> int set_memory_wc(unsigned long addr, int numpages)
> {
>          int ret;
> 
>          ret = memtype_reserve(__pa(addr), __pa(addr) + numpages * PAGE_SIZE,
>                  _PAGE_CACHE_MODE_WC, NULL);
>          if (ret)
>                  return ret;
> 
>          ret = _set_memory_wc(addr, numpages);
>          if (ret)
>                  memtype_free(__pa(addr), __pa(addr) + numpages * PAGE_SIZE);
> 
>          return ret;
> }
> 
> Don't all set_memory_xxx() functions have the same schematic?
> 
>>
>> That said, I've forgotten by now if this _could_ have used vmalloc() or
>> vmap() or vmap_pfn().  None of the logic about why or how the allocator
>> and mapping design decisions were made.  Could that be be rectified for
>> the next post?

In addition to Kai's reply, a few more points about where this memory 
being used, and your comment history is listed below:

This memory is used by VMM to copy the TD Quote data after completing
the Quote generation request from the TD guest. It requires a physically
contiguous shared buffer of given length, which is passed to VMM using
GetQuote hypercall.

Initially, we have allocated this memory using alloc_pages* (or some
variant of it) and directly called set_memory_{de/en}crypted() to share
/unshare these pages. For the above-mentioned approach, you have
suggested to use vmap to not affect the direct mapping.

Regarding vmalloc(), we cannot use it because we need physically
contiguous space.

Regarding history about using DMA APIs vs VMAP approach is already
explained by Kai below.

I will add relevant details to the commit log in next patch submission.

> 
> Looking at set_memory_{encrypted|decrypted}() again, it seems they currently
> only works on direct mapping for TDX (as sathya's code has showed).  For AMD it
> appears they can work on any virtual address as AMD uses lookup_address() to
> find the PFN.
> 
> So if the two are supposed to work on any virtual address, then it makes sense
> to fix at TDX side.
> 
> Btw, regarding to my suggestion of using vmap() with prot_decrypted() +
> MapGPA(), after thinking again, I think there is also a problem -- the TLB for
> private mapping and the cache are not flushed.  So looks we should fix
> set_memory_decrypted() to work on any virtual address and use it for vmap().
> 
> Back to the "why and how the allocator and mapping design decisions were made",
> let me summarize options and my preference below:
> 
> 1) Using DMA API.  This guarantees for TDX1.0 the allocated buffer is shared
> (set_memory_decrypted() is called for swiotlb).  But this may not guarantee the
> buffer is shared in future generation of TDX.  This of course depends on how we
> are going to change those DMA API implementations for future TDX but
> conceptually using DMA API is more like for convenience purpose.  Also, in order
> to use DMA API, we need more code to handle additional 'platform device' which
> is not mandatory for attestation driver.
> 
> 2) Using vmap() + set_memory_decrypted().  This requires to change the latter to
> support any virtual address for TDX.  But now I guess it's the right way since
> it's better to have some infrastructure to convert private page to shared
> besides DMA API anyway.
> 
> 3) Using vmap() + MapGPA().  This requires additional work on TLB flush and
> cache flush.  Now I think we should not use this.
> 
> Given above, I personally think 2) is better.
> 
> Kirill, what's your opinion?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
