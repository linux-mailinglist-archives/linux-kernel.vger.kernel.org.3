Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2EA51CC41
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386451AbiEEWm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiEEWm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:42:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1FA12747
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651790326; x=1683326326;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1Sq/xZE1X6kmNEwQaxs1pljVcvp2FPUdxENXoyPY/Rk=;
  b=WNFbQhMATGQBs5/l7/0pt0d1oMG+ihJ8nrZy3JXPzJcDvizHVoEcjv7w
   ceIvN9B4Mh5+IhEuVfqxwKnNDw9d9q4GzYXDiR5riaPv+cxflAm/EXmvi
   3A71GVlFYbm0oF6k74v38IvqbBB1AlC95qXmMlp5CBK0xqUglziM2Aexz
   Kebf1t5AyBKUOr0L53m7V2dzD1T0AAw2I0+gS4TwXf5l9FgcrwqmWiuCc
   VSqIr6KGxpCBYvFbrKrHczX5VN4vV4SBS3MxXaatmoleDxZT4+cMjKfSE
   NojQgcb7VqYIh1fvQzKbxJFKl3fSzlP3RDcn6/Fahw5nk+2ODtGCMekWJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="331262722"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="331262722"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 15:38:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="585607067"
Received: from jdrobitc-mobl1.amr.corp.intel.com (HELO [10.209.123.186]) ([10.209.123.186])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 15:38:45 -0700
Message-ID: <9d869ed2-2b3b-8007-a12d-6d73a54d6a05@linux.intel.com>
Date:   Thu, 5 May 2022 15:38:43 -0700
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
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <d53696f85ada39a91a3685c61d177c582810772e.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/22 3:15 PM, Kai Huang wrote:
> On Thu, 2022-05-05 at 13:53 -0700, Sathyanarayanan Kuppuswamy wrote:
>> Hi Kai,
>>
>> On 5/4/22 4:28 PM, Kai Huang wrote:
>>> On Wed, 2022-05-04 at 15:49 -0700, Sathyanarayanan Kuppuswamy wrote:
>>>> --- a/arch/x86/coco/tdx/tdx.c
>>>> +++ b/arch/x86/coco/tdx/tdx.c
>>>> @@ -15,6 +15,7 @@
>>>>     #include <asm/idtentry.h>
>>>>     #include <asm/irq_regs.h>
>>>>     #include <asm/desc.h>
>>>> +#include <asm/io.h>
>>>>
>>>>     /* TDX module Call Leaf IDs */
>>>>     #define TDX_GET_INFO                   1
>>>> @@ -680,8 +681,15 @@ static bool try_accept_one(phys_addr_t *start,
>>>> unsigned long len,
>>>>      */
>>>>     static bool tdx_enc_status_changed(unsigned long vaddr, int numpages,
>>>> bool enc)
>>>>     {
>>>> -       phys_addr_t start = __pa(vaddr);
>>>> -       phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
>>>> +       phys_addr_t start;
>>>> +       phys_addr_t end;
>>>> +
>>>> +       if (is_vmalloc_addr((void *)vaddr))
>>>> +               start =  page_to_phys(vmalloc_to_page((void*)vaddr));
>>>> +       else
>>>> +               start = __pa(vaddr);
>>>> +
>>>> +       end = start + numpages * PAGE_SIZE;
>>>>
>>>>            if (!enc) {
>>>>                    /* Set the shared (decrypted) bits: */
>>>
>>> Looks set_memory_decrypted() only works for direct-mapping, so you should not
>>> use this.  Instead, you can pass shared bit in 'prot' argument (using
>>> pgprot_decrypted()) when you call vmap(), and explicitly call MapGPA().
>>
>> Is it because of the above change, or you see other direct-mapping
>> dependencies in set_memory_*() functions?
>>
>>
>>
> set_memory_xx()  is supposedly only for direct-mapping.  Please use my
> suggestion above.

I did not find any other direct-mapping dependency in set_memory_*()
functions other than what I have fixed. If I missed anything, please
let me know.

Also, even if set_memory_*() functions does not support vmalloc'ed
memory,  IMO, it is better to add this support to it.

I want to avoid custom solution if it is possible to use generic
function.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
