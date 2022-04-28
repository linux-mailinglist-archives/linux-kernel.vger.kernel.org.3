Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46572512820
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 02:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbiD1An5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 20:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbiD1Ant (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 20:43:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B30E237C5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651106435; x=1682642435;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2+vTAP2/pAIbU0xKMwU3FmY2eRTQh73OFPfAlQ8kAu0=;
  b=QjqRrFR05Bj5LwNfN1UW+m8Ei1Rr1c9FRWX5ABN2F9yFAOQuDjPEKfhl
   gPgL7RaAiR+4bzjraNnQhLNiFThqOsDHAXZhDZt3cCsMsZemfM7SA6x59
   W5lfYCotbmjSTacvGJrixp5CuOqAeEUXVWWGDD1HcgW7ebwBJH5YAt5f2
   OB/Epvv/YBBlCcjP0hous50JQvNQH7u5xhswWkmlt7CY63QKjyg0yz4vb
   meEJk9P+UvEbv+2ymBaJbfBN52x7Dfy6pavyC8iyRBvyZIrDvxL4NSIlR
   YSZFeIVg4MTWu3Q0No1eTzAQL2MrK88GpwHa6mlhjIjydbN9CLFNjkPSQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="246035066"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="246035066"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 17:40:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="731094044"
Received: from leeyongj-mobl1.amr.corp.intel.com (HELO [10.212.138.148]) ([10.212.138.148])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 17:40:25 -0700
Message-ID: <5767175a-5ad5-1666-d520-d97496d56b7b@linux.intel.com>
Date:   Wed, 27 Apr 2022 17:40:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v4 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220422233418.1203092-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <0457ce8e78ddd1d6c7832176368e095adae1bc18.camel@intel.com>
 <1168a7cc-9e41-ee2d-8b3d-8dbd1ab85609@linux.intel.com>
 <a597c1fffab01e1048421887d5ef7aa2ac01c46e.camel@intel.com>
 <bcae2b91-c4eb-7b43-0b00-842fa1b9f57c@linux.intel.com>
 <82c7409878b5877a507f38b7e5e4de681f3de309.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <82c7409878b5877a507f38b7e5e4de681f3de309.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai,

On 4/27/22 4:40 PM, Kai Huang wrote:
> On Wed, 2022-04-27 at 14:45 -0700, Sathyanarayanan Kuppuswamy wrote:
>> Hi,
>>
>> On 4/26/22 10:15 PM, Kai Huang wrote:
>>> On Tue, 2022-04-26 at 12:07 -0700, Sathyanarayanan Kuppuswamy wrote:
>>>>> Is there any particular reason to use platform driver and support it as a
>>>>> module?
>>>>>
>>>>> SGX driver uses misc_register() to register /dev/sgx_enclave during boot.
>>>>> Looks
>>>>> it would be simpler.
>>>>
>>>> Main reason is to use a proper device in dma_alloc* APIs.
>>>>
>>>> My initial version only used misc device as you have mentioned. But
>>>> Hans raised a concern about using proper struct device in dma_alloc*
>>>> APIs and suggested modifying the driver to use platform device
>>>> model. You can find relevant discussion here.
>>>>
>>>> https://lore.kernel.org/all/47d06f45-c1b5-2c8f-d937-3abacbf10321@redhat.com/
>>>
>>> Thanks for the info.  Sorry I didn't dig review comments for previous version.
>>>
>>> However, after digging more, I am wondering why do you need to use DMA API at
>>> the first place.
>>>
>>> Firstly, for this basic driver to report TDREPORT to userspace, there's no need
>>> to use any DMA API, nor we need to use shared memory, as we just get the report
>>> into some buffer (doesn't need to be shared) and copy the report back to
>>> userspace.  So it doesn't make a lot sense to use platform device here.
>>
>> Yes. For this patch itself, since  we don't need to use DMA API,
>> platform driver model is not required. But I have made this patch use
>> platform driver format in consideration of its need in the next patch.
>> Making it misc driver in this patch and changing it to platform driver
>> in next patch does not make sense. Since they are all in the same patch
>> set we can add some changes in consideration of the next patch.
>>
>>>
>>> Secondly, in terms of GetQuote support, it seems Dave/Andi suggested you can use
>>> vmalloc()/vmap() and just use set_memory_decrypted() to convert it to shared:
>>>
>>> https://lore.kernel.org/all/ce0feeec-a949-35f8-3010-b0d69acbbc2e@linux.intel.com/
>>>
>>> I don't see why it cannot work?  Then wouldn't this approach be simpler than
>>> using DMA API?  Any reason to choose platform device?
>>
>> Yes, it will work. But I am not sure whether it is simpler than adding
>> platform driver specific buffer code. I have used DMA APIs because it
>> will handle allocation and decryption setting internally. I thought is
>> simpler than we handling it ourselves.
>>
>> But if platform device driver model is not preferred, I can change it.
> 
> I don't think ignoring Dave/Andi's comments w/o providing feedback is good.

It is not intentional. I think it is missed during my vacation due to
some mail access issues. Sorry about it.

> 
> Also I personally don't see how using DMA API is better than using
> vmalloc()/vmap().  In order to use DMA API, you have to add more code to use
> platform_device, which isn't necessary.
> 
> I'll leave this to Dave/Andi.

As I said, I am fine with the change (if it is preferred).

> 
>>
>>
>>>
>>> Btw, a side topic:
>>>
>>> Andy suggested we don't do memory allocation and private-shared conversion at
>>> IOCTL time as the conversion is expensive:
>>>
>>> https://lore.kernel.org/all/06c85c19-e16c-3121-ed47-075cfa779b67@kernel.org/
>>>
>>> This is reasonable (and sorry I didn't see this when I commented in v3).
>>>
>>> To avoid IOCTL time private-shared conversion, and yet support dynamic Quote
>>> length, can we do following:
>>>
>>> - Allocate a *default* size buffer at driver loading time (i.e. 4 pages), and
>>> convert to shared.  This default size should cover 99% cases as Intel QGS
>>> currently generates Quote smaller than 8K, and Intel attestation agent hard-code
>>> a 4 pages buffer for Quote.
>>>
>>> - In GetQuote IOCTL, when the len is larger than default size, we discard the
>>> original one and allocate a larger buffer.
>>>
>>> How does this sound?
>>
>> It sounds fine. Your suggestion can indeed decrease the IOCTL time.
>>
>> But, IMO, since attestation will not be used that frequently,
>> we don't need to consider optimization at this point of time. Also, I
>> think the memory allocation time is negligible compared to time it takes
>> for the TDQUOTE generation.
>>
>> Even if we have to do it, we can add it in future as a separate
>> patch. We don't need to add it part of this basic driver support
>> patch.
>>
>>
> 
> I am just pointing out Andy made such suggestion before, and it's not something
> we cannot support.
> 
> Anyway will let you decide.

Ok.

> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
