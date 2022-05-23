Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A315F53082E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 06:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355597AbiEWD6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 23:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353324AbiEWD6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 23:58:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1DC624F3E
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 20:58:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94B0C113E;
        Sun, 22 May 2022 20:58:00 -0700 (PDT)
Received: from [10.163.36.114] (unknown [10.163.36.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A5223F66F;
        Sun, 22 May 2022 20:57:56 -0700 (PDT)
Message-ID: <feae94cd-8474-73e2-2d64-520cec51eb3e@arm.com>
Date:   Mon, 23 May 2022 09:27:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 4/6] mm: ioremap: Add arch_ioremap/iounmap()
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, hch@infradead.org, arnd@arndb.de
References: <20220519082552.117736-1-wangkefeng.wang@huawei.com>
 <20220519082552.117736-5-wangkefeng.wang@huawei.com>
 <20220519115210.a6e41d5a997921354400557e@linux-foundation.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220519115210.a6e41d5a997921354400557e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/22 00:22, Andrew Morton wrote:
> On Thu, 19 May 2022 16:25:50 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
>> Add special hook for architecture to verify or setup addr, size
>> or prot when ioremap() or iounmap(), which will make the generic
>> ioremap more useful.
>>
>>   arch_ioremap() return a pointer,
>>     - IS_ERR means return an error
>>     - NULL means continue to remap
>>     - a non-NULL, non-IS_ERR pointer is directly returned
>>   arch_iounmap() return a int value,
>>     - 0 means continue to vunmap
>>     - error code means skip vunmap and return directly
>>
>> ...
>>
>> --- a/include/asm-generic/io.h
>> +++ b/include/asm-generic/io.h
>> @@ -964,6 +964,30 @@ static inline void iounmap(volatile void __iomem *addr)
>>  #elif defined(CONFIG_GENERIC_IOREMAP)
>>  #include <linux/pgtable.h>
>>  
>> +/*
>> + * Arch code can implement the following two special hooks when using GENERIC_IOREMAP
>> + * arch_ioremap() return a pointer,
>> + *   - IS_ERR means return an error
>> + *   - NULL means continue to remap
>> + *   - a non-NULL, non-IS_ERR pointer is returned directly
>> + * arch_iounmap() return a int,
>> + *   - 0 means continue to vunmap
>> + *   - error code means skip vunmap and return directly
>> + */
>> +#ifndef arch_ioremap
>> +static inline void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size, unsigned long prot)
>> +{
>> +	return NULL;
>> +}
> 
> Maybe should do
> 
> 	#define arch_ioremap arch_ioremap
> 
> here
> 
>> +#endif
>> +
>> +#ifndef arch_iounmap
>> +static inline int arch_iounmap(void __iomem *addr)
>> +{
>> +	return 0;
>> +}
> 
> and here.
> 
> It shouldn't matter a lot because this file has inclusion guards. 
> However it seems tidier and perhaps other code will want to know
> whether this was defined.  Dunno.

+1, agreed.
