Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617A84F639E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiDFPsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbiDFPr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:47:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB9E3CF4B6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:06:13 -0700 (PDT)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KYPLc10vxzBs3R;
        Wed,  6 Apr 2022 20:43:04 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500009.china.huawei.com (7.221.188.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 20:47:14 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 20:47:13 +0800
Message-ID: <e269a621-ed0e-c74c-9cf6-f81c44c1fbcd@huawei.com>
Date:   Wed, 6 Apr 2022 20:47:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH -next V2 2/7] arm64: fix page_address return value in
 copy_highpage
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        <james.morse@arm.com>
References: <20220406091311.3354723-1-tongtiangen@huawei.com>
 <20220406091311.3354723-3-tongtiangen@huawei.com>
 <Yk1pz7IYwEyGDVNV@FVFF77S0Q05N>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <Yk1pz7IYwEyGDVNV@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/6 18:22, Mark Rutland 写道:
> On Wed, Apr 06, 2022 at 09:13:06AM +0000, Tong Tiangen wrote:
>> Function page_address return void, fix it.
>>
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> 
> This looks like a sensible cleanup, but the commit title and message aren't
> that clear.
> 
> Can you please make this:
> 
> | arm64: fix types in copy_highpage()
> |
> | In copy_highpage() the `kto` and `kfrom` local variables are pointers to
> | struct page, but these are used to hold arbitrary pointers to kernel memory.
> | Each call to page_address() returns a void pointer to memory associated with
> | the relevant page, and copy_page() expects void pointers to this memory.
> |
> | This inconsistency was introduced in commit:
> |
> |   2563776b41c31908 ("arm64: mte: Tags-aware copy_{user_,}highpage() implementations")
> |
> | ... and while this doesn't appear to be harmful in practice it is clearly wrong.
> |
> | Correct this by making `kto` and `kfrom` void pointers.
> |
> | Fixes: 2563776b41c31908 ("arm64: mte: Tags-aware copy_{user_,}highpage() implementations")
> 
> With that:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks,
> Mark.
> 

OK, sure , will do in next version.

Thanks.
Tong.

>> ---
>>   arch/arm64/mm/copypage.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
>> index b5447e53cd73..0dea80bf6de4 100644
>> --- a/arch/arm64/mm/copypage.c
>> +++ b/arch/arm64/mm/copypage.c
>> @@ -16,8 +16,8 @@
>>   
>>   void copy_highpage(struct page *to, struct page *from)
>>   {
>> -	struct page *kto = page_address(to);
>> -	struct page *kfrom = page_address(from);
>> +	void *kto = page_address(to);
>> +	void *kfrom = page_address(from);
>>   
>>   	copy_page(kto, kfrom);
>>   
>> -- 
>> 2.18.0.huawei.25
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> .
