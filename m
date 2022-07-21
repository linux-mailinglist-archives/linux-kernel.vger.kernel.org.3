Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDC357D1C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiGUQm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiGUQmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:42:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79648743DC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658421772; x=1689957772;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Grj6Db995/Rp4smNtuo4xU1C5cdPHv5qH/01R47s5tg=;
  b=g7gyPnXqlgy/BHvGnnhCo36p6+5MCtKMWcJwTKUF0NG8p2/3+ZHbp0WZ
   ns4Mecakucl7dARXvjdC3zcXAFfnRlMgFgUb+qf2/QZNEJ91KfP61MZNX
   LgDCRvc7a3ANAc+oVNLNzCOxq82ygXbToLnaGlfbPEBq0FNjvDC0ul7rS
   B+mBbgehAxc4Lr5hhFWBHONWLnf5dUvwiiLtMtshm222YeWcoej43kwpD
   9qbfD9xJJY4CqBngnFth/64+YvSHV3PADM1p/VUUK7gYwLWCOl4lUu6d+
   ikimw8QsKYTQge4cc4ZIf3hvm9UUx7AgPe/wTtYwh6xG81HIRAm44NvCw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="348799574"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="348799574"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 09:42:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="598527821"
Received: from sattaran-mobl1.amr.corp.intel.com (HELO [10.212.246.186]) ([10.212.246.186])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 09:42:51 -0700
Message-ID: <f043d9f5-8f89-4ef3-2ce1-75665122bb3a@linux.intel.com>
Date:   Thu, 21 Jul 2022 09:42:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <d3808510-9974-258e-0c7b-9a76e0868d48@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <d3808510-9974-258e-0c7b-9a76e0868d48@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 7/21/22 9:08 AM, Dave Hansen wrote:
> On 6/8/22 19:52, Kuppuswamy Sathyanarayanan wrote:
>> For shared buffer allocation, alternatives like using the DMA API is
>> also considered. Although it simpler to use, it is not preferred because
>> dma_alloc_*() APIs require a valid bus device as argument, which would
>> need converting the attestation driver into a platform device driver.
>> This is unnecessary, and since the attestation driver does not do real
>> DMA, there is no need to use real DMA APIs.
> 
> Let's actually try to walk through the requirements for the memory
> allocation here.
> 
>  1. The guest kernel needs to allocate some guest physical memory
>     for the attestation data buffer

Physically contiguous memory.

>  2. The guest physical memory must be mapped by the guest so that
>     it can be read/written.
>  3. The guest mapping must be a "TDX Shared" mapping.  Since all
>     guest physical memory is "TDX Private" by default, something
>     must convert the memory from Private->Shared.
>  4. If there are alias mappings with "TDX Private" page table
>     permissions, those mappings must never be used while the page is
>     in its shared state.
>     4a. load_unaligned_zeropad() must be prevented from being used
> 	on the page immediately preceding a Private alias to a Shared
>  	page.
>  5. Actions that increasingly fracture the direct map must be avoided.
>     Attestation may happen many times and repeated allocations that
>     fracture the direct map have performance consequences.
>  6. A softer requirement: presuming that bounce buffers won't be used
>     for TDX devices *forever*, it would be nice to use a mechanism that
>     will continue to work on systems that don't have swiotlb on.
>

Other than the above-mentioned correction, the rest of the requirements
are correct.
 
> I think we've talked about three different solutions:
> 
> == vmalloc() ==
> 
> So, let's say we used a relatively plain vmalloc().  That's great for
> #1->#3 as long as the vmalloc() mapping gets the "TDX Shared" bit set
> properly on its PTEs.  But, it falls over for *either* #4 or #5.  If it
> leaves the direct map alone, it's exposed to load_unaligned_zeropad().
> If it unmaps the memory from the direct map, it runs afoul of #5
Since we need physically contiguous memory, vmalloc is not preferred.

> 
> == order-1 + vmap() ==
> 
> Let's now consider a vmalloc() variant: allocate a bunch of order-1
> pages and vmap() page[1], leaving page[0] as a guard page against
> load_unaligned_zeropad() on the direct map.  That works, but it's an
> annoying amount of code.
> 
> == swiotlb pages ==
> 
> Using the swiotlb bounce buffer pages is the other proposed option.
> They already have a working kernel mapping and have already been
> converted.  They are mitigated against load_unaligned_zeropad().  They
> do cause direct map fracturing, but only once since they're allocated
> statically.  They don't increasingly degrade things.  It's a one-time
> cost.  Their interaction with #6 is not great.
> 
> Did I miss anything?  Does that accurately capture where we are?



-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
