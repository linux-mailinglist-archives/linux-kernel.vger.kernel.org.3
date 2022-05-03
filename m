Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3747517BF7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiECCmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiECCmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:42:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009BD3633E
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 19:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651545545; x=1683081545;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y3Zle4T8/437UxAnWC+mgnGd4rivsPIeZXtuI0xWNvk=;
  b=LRxf+QDeoiFrn+54vjfjmMsljtJUVkZwM2idmUnqVJPoEeZZ4eoQNRBU
   HXsu8+t5Mz5vWW9K4CwOgVWk8CSnDdKgX5Am1h1GfxWb1PV6QhZDGR8n3
   VzDjBuAA7R982qAMSyen9qw746CtEsGtFC+0vu5f0tprh8MGagBhozHYt
   Nx4niV4yvG4iF5bP/10Cq3RmHg5ixjPH7bkz0GWmfrNCOOFXFfg6rmH1Q
   3x4cGOmG4n7dJTXwXaIvI79i0J5JhambBOzVftBCg51qhwWpyQK7IMXS7
   8h2754M7GsFjBJk0uzGxljeQm5AfPh2TT6sjSh+Q58LogynsXiEGSML4D
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="249363501"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="249363501"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 19:39:05 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="584007104"
Received: from wahmed-mobl.amr.corp.intel.com (HELO [10.209.71.202]) ([10.209.71.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 19:39:05 -0700
Message-ID: <ac299f99-7ef6-7fc2-a9fe-7ed2586b9b09@linux.intel.com>
Date:   Mon, 2 May 2022 19:39:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
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
 <4cf22a0799cc13fa6f09ffbf0e5d83ed7eeb32ad.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <4cf22a0799cc13fa6f09ffbf0e5d83ed7eeb32ad.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/22 7:18 PM, Kai Huang wrote:
> On Tue, 2022-05-03 at 04:27 +0300, Kirill A. Shutemov wrote:
>> On Mon, May 02, 2022 at 02:40:26PM +1200, Kai Huang wrote:
>>>
>>>> +
>>>> +	/* Get order for Quote buffer page allocation */
>>>> +	order = get_order(quote_req.len);
>>>> +
>>>> +	/*
>>>> +	 * Allocate buffer to get TD Quote from the VMM.
>>>> +	 * Size needs to be 4KB aligned (which is already
>>>> +	 * met in page allocation).
>>>> +	 */
>>>> +	tdquote = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
>>>> +	if (!tdquote) {
>>>> +		ret = -ENOMEM;
>>>> +		goto quote_failed;
>>>> +	}
>>>
>>> You can use alloc_pages_exact().
>>>
>>>> +
>>>> +	/*
>>>> +	 * Since this buffer will be shared with the VMM via GetQuote
>>>> +	 * hypercall, decrypt it.
>>>> +	 */
>>>> +	ret = set_memory_decrypted((unsigned long)tdquote, 1UL << order);
>>>> +	if (ret)
>>>> +		goto quote_failed;
>>>
>>>
>>> Again, Dave and Andi already commented you should use vmap() to avoid breaking
>>> up the direct-mapping.  Please use vmap() instead.
>>>
>>> https://lore.kernel.org/all/ce0feeec-a949-35f8-3010-b0d69acbbc2e@linux.intel.com/
>>>
>>> Will review the rest later.
>>
>> I would rather convert it to use DMA API for memory allocation. It will
>> tap into swiotlb buffer that already converted and there's no need to
>> touch direct mapping. Both allocation and freeing such memory is cheaper
>> because of that.
>>
> 
> Does each DMA allocation and free internally do the actual private/shared
> conversion?  Or the swiotlb is converted at the beginning at boot and DMA
> allocation will always get the shared buffer automatically?

DMA allocation will always return shared buffer.

> 
> The problem of using DMA API is it will need to bring additional code to use
> platform device, which isn't necessary.

Yes.

> 
> Using vmap() we can still (almost) avoid private/shared conversion at IOCTL time
> by allocating a default size buffer (which is large enough to cover 99% cases,
> etc) at driver initialization time:

Allocating fixed size buffer pool will work for dma buffer allocation
as well.

So the comparison is between platform driver boilerplate code vs vmap
and shared/unshared code addition. It is arguable which is better. I
think it is about preference.

> 
> https://lore.kernel.org/lkml/20220422233418.1203092-2-sathyanarayanan.kuppuswamy@linux.intel.com/T/#maf7e5f6894548972c5de71f607199a79645856ff
> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
