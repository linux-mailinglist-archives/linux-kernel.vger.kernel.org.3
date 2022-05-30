Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F7E5387E6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 21:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243087AbiE3TyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 15:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiE3TyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 15:54:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D78D65422
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 12:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653940456; x=1685476456;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=glIVLesF9bUs71QpLqXPHIcztRqPJ11tc0MAhp62YCU=;
  b=O6Lstzj39V8aA8C3vg7vHMv3/kGaog65CwhNK1XsiByaZHQG1uJnncYF
   QEJfE2REm/zy1ldHpiO8Kzhe0srm4AdjG+ShDlAHDpAIMT0GEDIAgxD9B
   +ng4p7h608yZH9zW8p7/sNyZah/t9OddFCih1qB07FJXjDTY7yITPnOYa
   LnlebNeDpJwpE7vn5pRhOPVlzM1YiXiLFvRGx4C7bHKqyKcP8rRuYrpmP
   CfO8Ss4mqbyEfWvAkFOY85gXPo1lPABerBf63TlOXOqFtjP8wEJ9+QLEM
   2/vZtbA3crZWhAqJHqSuqEqzFAO0gUAQrg4rRA7zQ+ISWqRyPl1Clca8k
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="275157561"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="275157561"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 12:54:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="720012259"
Received: from hyang-mobl1.amr.corp.intel.com (HELO [10.212.248.21]) ([10.212.248.21])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 12:54:15 -0700
Message-ID: <61b2da02-0e71-1da5-cc3f-8777a8647962@linux.intel.com>
Date:   Mon, 30 May 2022 12:54:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v7 3/5] x86/mm: Make tdx_enc_status_changed() vmalloc
 address compatible
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220524040517.703581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220524040517.703581-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <ba5aa2939e81f730396d41120aa603df7999d937.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <ba5aa2939e81f730396d41120aa603df7999d937.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/22 3:47 AM, Kai Huang wrote:
> On Mon, 2022-05-23 at 21:05 -0700, Kuppuswamy Sathyanarayanan wrote:
>> set_memory_*crypted() APIs are used to change encryption or decryption
>> page attributes for the given address. It also by default support the
>> conversion for the vmalloc'ed memory address.
>>
>> In TDX Guest, tdx_enc_status_changed() function is triggered by
>> set_memory_*crypted() APIs when converting memory from/to shared or
>> private. Internally this function uses __pa() for physical address
>> conversion, which breaks the vmalloc address compatibility of the
>> set_memory_*crypted() APIs.
>>
>> So add support to fix the vmalloc'ed address compatibility issue.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   arch/x86/coco/tdx/tdx.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
>> index b49211994864..37d58675ccf1 100644
>> --- a/arch/x86/coco/tdx/tdx.c
>> +++ b/arch/x86/coco/tdx/tdx.c
>> @@ -15,6 +15,7 @@
>>   #include <asm/idtentry.h>
>>   #include <asm/irq_regs.h>
>>   #include <asm/desc.h>
>> +#include <asm/io.h>
>>   
>>   /* TDX module Call Leaf IDs */
>>   #define TDX_GET_INFO			1
>> @@ -680,8 +681,14 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
>>    */
>>   static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>>   {
>> -	phys_addr_t start = __pa(vaddr);
>> -	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
>> +	phys_addr_t start, end;
>> +
>> +	if (is_vmalloc_addr((void *)vaddr))
>> +		start = vmalloc_to_pfn((void *) vaddr) << PAGE_SHIFT;
>> +	else
>> +		start = __pa(vaddr);
>> +
>> +	end = start + numpages * PAGE_SIZE;
>>   
>>   	if (!enc) {
>>   		/* Set the shared (decrypted) bits: */
> 
> AMD uses lookup_address() which doesn't require the vaddr being vmap() address.
> Shouldn't TDX use the same way?

AMD uses it to add some additional checks for address validation and
missing PTE entry. But in our case, reaching here means address is valid
and there is a valid PTE entry. So there is no need to lookup again and
convert it. It is easier to use above method.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
