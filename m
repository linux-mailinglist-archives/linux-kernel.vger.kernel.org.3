Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DB04BA831
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbiBQS0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:26:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiBQS0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:26:31 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6551A33351
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:26:16 -0800 (PST)
Received: from [192.168.4.54] (cpe-70-95-196-11.san.res.rr.com [70.95.196.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6417420BE580;
        Thu, 17 Feb 2022 10:26:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6417420BE580
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1645122375;
        bh=M5mtPIPM0j89LYQrp63Y0RDZN8FfF+oH71W+YVr1EAg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZkSaFxck2/vs6ydzKP+M0Vwdxo3z9RLR4b/doO3dwzRWM79cluxNtJXvtFZIeh0mG
         OZryPCMcrDKN/rMuZNVGd2F/1wwU4zgQnn5If+KUOspP/jtbCOXH9+HTPwRzlYgFs0
         P35lWg9V09Qvn1zsp5zps+G/NOArhl2Fio5iyDWo=
Message-ID: <a22c9bed-3cc3-e2c0-7eb2-1a19d64af574@linux.microsoft.com>
Date:   Thu, 17 Feb 2022 10:26:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] arm64: Do not defer reserve_crashkernel() for platforms
 with no DMA memory zones
Content-Language: en-US
To:     nicolas saenz julienne <nsaenz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1645056294-6509-1-git-send-email-vijayb@linux.microsoft.com>
 <ed4f4589f322bd3871f825239985410b535df30e.camel@kernel.org>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <ed4f4589f322bd3871f825239985410b535df30e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/2022 2:49 AM, nicolas saenz julienne wrote:
> On Wed, 2022-02-16 at 16:04 -0800, Vijay Balakrishna wrote:
>> The following patches resulted in deferring crash kernel reservation to
>> mem_init(), mainly aimed at platforms with DMA memory zones (no IOMMU),
>> in particular Raspberry Pi 4.
>>
>> commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
>> commit 8424ecdde7df ("arm64: mm: Set ZONE_DMA size based on devicetree's dma-ranges")
>> commit 0a30c53573b0 ("arm64: mm: Move reserve_crashkernel() into mem_init()")
..
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index acfae9b41cc8..e7faf5edccfc 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -517,7 +517,7 @@ static void __init map_mem(pgd_t *pgdp)
>>   	 */
>>   	BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
>>   
>> -	if (can_set_direct_map() || crash_mem_map || IS_ENABLED(CONFIG_KFENCE))
>> +	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
>>   		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>   
>>   	/*
>> @@ -528,6 +528,14 @@ static void __init map_mem(pgd_t *pgdp)
>>   	 */
>>   	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>>   
>> +#ifdef CONFIG_KEXEC_CORE
>> +	if (crash_mem_map && !crashk_res.end)
>> +		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> 
> Using IS_ENABLED(ZONE_DMA/DMA32) instead of '!crashk_res.end' would be more
> efficient and a bit more explicit IMO.

Sure, I will make change in a follow up submission.

> 
>>   	/* map all the memory banks */
>>   	for_each_mem_range(i, &start, &end) {
>>   		if (start >= end)
>> @@ -554,6 +562,20 @@ static void __init map_mem(pgd_t *pgdp)
>>   	__map_memblock(pgdp, kernel_start, kernel_end,
>>   		       PAGE_KERNEL, NO_CONT_MAPPINGS);
>>   	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
>> +#ifdef CONFIG_KEXEC_CORE
>> +	/*
>> +	 * Use page-level mappings here so that we can shrink the region
>> +	 * in page granularity and put back unused memory to buddy system
>> +	 * through /sys/kernel/kexec_crash_size interface.
>> +	 */
>> +	if (crashk_res.end) {
> 
> Same here.

Yes.

> 
>> +		__map_memblock(pgdp, crashk_res.start, crashk_res.end + 1,
>> +			       PAGE_KERNEL,
>> +			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
>> +		memblock_clear_nomap(crashk_res.start,
>> +				     resource_size(&crashk_res));
>> +	}
>> +#endif
> 
> Now, I carefully reviewed the patch and it seems to be doing the right thing.
> But even while knowlegable on the topic, it took a good amount of effort to
> untangle the possible code paths. I suspect it's going to be painful to
> maintain. I'd suggest at least introducing a comment explaining the situation.

I appreciate your review.  Yes, it took a good amount of time for me 
(new here) too and glad for your notice.  Let me take a shot at 
explaining in my next revision.
> 
> If there approach if deemed acceptable, I'll test is on the RPi4.

Please, your testing on RPi4 would be valuable.

Thanks,
Vijay

> 
> Regards,
> Nicolas
