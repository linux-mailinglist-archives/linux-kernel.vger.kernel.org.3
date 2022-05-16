Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74780528C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344369AbiEPRj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344346AbiEPRjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:39:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41EC36B42
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652722787; x=1684258787;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E351kjdHM4yyOzHxYpzD4Ez9vYrSwygxY8UcWv9n7c0=;
  b=gUWutekvo1885i1fUHgriFU72BtbZCfw95Dp9UvjDZR7W0px2rLitHsV
   nRzJcsMToWr+wzp+L12YDoNBa+D5S12mlAW2BeyRv92LsrfAsKLUU11Df
   +HCIwnMgD3Eniz+DLZhw9vJ5+ihLcfhIGsu+0eerh9Yoe2OODYCvlbzuH
   z3I2sOZmwlQ6P9Wox/sUV/gcjsV2fI1/xPFi+RXXmnlhDH5Qlhi0BHPgQ
   RNgNRUd3ZuyRCSAZ3AJ6B4KtZX6hQVSSxIX77BKUtAUPyn+eF+irUZARe
   SIvDPlULbSOYZNoqKb8u6jo7JV5RUrA4WYe5GwDMjSzP64yPAq283rb6+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="251426850"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="251426850"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 10:39:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="596631886"
Received: from skechkar-mobl.ger.corp.intel.com (HELO [10.255.228.165]) ([10.255.228.165])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 10:39:46 -0700
Message-ID: <f2ab7c58-2d69-9042-4880-9b86bcdd4053@linux.intel.com>
Date:   Mon, 16 May 2022 10:39:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
 <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
 <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
 <2ed5c9cc316950a5a47ee714715b7980f358a140.camel@intel.com>
 <ab17102c-0cb7-87d3-3494-969866d64573@linux.intel.com>
 <d53696f85ada39a91a3685c61d177c582810772e.camel@intel.com>
 <d63d2774-c44d-27da-74b6-550935a196fd@intel.com>
 <dca06ffa36abe9989f0a7abaeafc83c1a7250651.camel@intel.com>
 <20220507004236.5p5dyksftge7wwr3@black.fi.intel.com>
 <45d184273f1950320843f6696eb3071f7d354fd3.camel@intel.com>
 <20220509120927.7rg6v5pyc3f4pxsh@box.shutemov.name>
 <75d4755c9a376df2e98a267e10e60da3bd178b17.camel@intel.com>
 <690ae2cb2099ac3e13c3da530a1b4a4eb5bafc5a.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <690ae2cb2099ac3e13c3da530a1b4a4eb5bafc5a.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 5/10/22 3:42 AM, Kai Huang wrote:
> On Tue, 2022-05-10 at 11:54 +1200, Kai Huang wrote:
>> On Mon, 2022-05-09 at 15:09 +0300, Kirill A. Shutemov wrote:
>>> On Mon, May 09, 2022 at 03:37:22PM +1200, Kai Huang wrote:
>>>> On Sat, 2022-05-07 at 03:42 +0300, Kirill A. Shutemov wrote:
>>>>> On Fri, May 06, 2022 at 12:11:03PM +1200, Kai Huang wrote:
>>>>>> Kirill, what's your opinion?
>>>>>
>>>>> I said before that I think DMA API is the right tool here.
>>>>>
>>>>> Speculation about future of DMA in TDX is irrelevant here. If semantics
>>>>> change we will need to re-evaluate all users. VirtIO uses DMA API and it
>>>>> is conceptually the same use-case: communicate with the host.
>>>>
>>>> Virtio is designed for device driver to use, so it's fine to use DMA API. And
>>>> real DMA can happen to the virtio DMA buffers.  Attestation doesn't have such
>>>> assumption.
>>>
>>> Whether attestation driver uses struct device is implementation detail.
>>> I don't see what is you point.
>>
>> No real DMA is involved in attestation.
>>
>>>
>>>> So I don't see why TD guest kernel cannot have a simple protocol to vmap() a
>>>> page (or couple of pages) as shared on-demand, like below:
>>>>
>>>> 	page = alloc_page();
>>>>
>>>> 	addr = vmap(page,  pgprot_decrypted(PAGE_KERNEL));
>>>>
>>>> 	clflush_cache_range(page_address(page), PAGE_SIZE);
>>>>
>>>> 	MapGPA(page_to_phys(page) | cc_mkdec(0), PAGE_SIZE);
>>>>
>>>> And we can even avoid above clflush_cache_range() if I understand correctly.
>>>>
>>>> Or  I missed something?
>>>
>>> For completeness, cover free path too. Are you going to opencode page
>>> accept too?
>>
>> Call __tdx_module_call(TDX_ACCEPT_PAGE, ...) right after MapGPA() to convert
>> back to private.  I don't think there is any problem?
>>
>>>
>>> Private->Shared conversion is destructive. You have to split SEPT, flush
>>> TLB. Backward conversion even more costly.
>>
>> I think I won't call it destructive.
>>
>> And I suggested before, we can allocate a default size buffer (i.e. 4 pages),
>> which is large enough to cover all requests for now, during driver
>> initialization.  This avoids IOCTL time conversion.  We should still have code
>> in the IOCTL to check the request buffer size and when it is larger than the
>> default, the old should be freed a larger one should be allocated.  But for now
>> this code path will never happen.
>>
>> Btw above is based on assumption that we don't support concurrent IOCTLs.  This
>> version Sathya somehow changed to support concurrent IOCTLs but this was a
>> surprise as I thought we somehow agreed we don't need to support this.
> 
> Hi Dave,
> 
> Sorry I forgot to mention that GHCI 1.5 defines a generic TDVMCALL<Service> for
> a TD to communicate with VMM or another TD or some service in the host.  This
> TDVMCALL can support many sub-commands.  For now only sub-commands for TD
> migration is defined, but we can have more.
> 
> For this, we cannot assume the size of the command buffer, and I don't see why
> we don't want to support concurrent TDVMCALLs.  So looks from long term, we will
> very likely need IOCTL time buffer private-shared conversion.
> 
> 


Let me summarize the discussion so far.

Problem: Allocate shared buffer without breaking the direct map.

Solution 1: Use alloc_pages*()/vmap()/set_memory_*crypted() APIs

Pros/Cons:

1. Uses virtual mapped address for shared/private conversion and
    hence does not touch the direct mapping.

2. Current version of set_memory_*crypted() APIs  modifies the
    aliased mappings, which also includes the direct mapping. So if we
    want to use set_memory_*() APIs, we need a new variant that does not
    touch the direct mapping. An alternative solution is to open code the
    page attribute conversion, cache flushing and MapGpa/Page acceptance
    logic in the attestation driver itself. But, IMO, this is not
    preferred because it is not favorable to sprinkle the mapping
    conversion code in multiple places in the kernel. It is better to use
    a single API if possible.

3. This solution can possibly break the SEPT entries on private-shared
    conversion. The backward conversion is also costly. IMO, since the
    attestation requests are not very frequent, we don't need to be
    overly concerned about the cost involved in the conversion.

Solution 2: Use DMA alloc APIs.

Pros/Cons:

1. Simpler to use. It taps into the SWIOTLB buffers and does not
    affect the direct map. Since we will be using already converted
    memory, allocation/freeing will be cheaper compared to solution 1.

2. There is a concern that it is not a long term solution. Since
    with advent of TDX IO, not all DMA allocations need to use
    SWIOTLB model. But as per Kirill's comments, this is not a concern
    and force_dma_unencrypted() hook can be used to differentiate which
    devices need to use TDX IO vs SWIOTLB model.

3. Using DMA APIs requires a valid bus device as argument and hence
    requires this driver converted into a platform device driver. But,
    since this driver does not do real DMA, making above changes just
    to use the DMA API is not recommended.

Since both solutions fix the problem (and there are pros/cons), and both
Kai/Kirill's comments conclusion is, there is no hard preference and
to let you decide on it.

Since you have already made a comment about "irrespective of which
model is chosen, you need the commit log talk about the solution and
how it not touches the direct map", I have posted the v6 version
adapting Solution 1.

Please let me know if you agree with this direction or have comments
about the solution.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
