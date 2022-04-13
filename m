Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2654FEF0C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiDMGDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiDMGDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:03:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4E5252BC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:01:23 -0700 (PDT)
Received: from kwepemi100008.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KdX0v3s8pzBsLw;
        Wed, 13 Apr 2022 13:57:03 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 14:01:21 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 14:01:20 +0800
Message-ID: <855ea9f7-5f0a-68a3-eece-6e9c1b27e90b@huawei.com>
Date:   Wed, 13 Apr 2022 14:01:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH -next V3 1/6] x86: fix function define in
 copy_mc_to_user
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Xie XiuQi <xiexiuqi@huawei.com>
References: <20220412072552.2526871-1-tongtiangen@huawei.com>
 <20220412072552.2526871-2-tongtiangen@huawei.com>
 <cd01ee8b-6686-fe8e-0d02-5507165f55eb@huawei.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <cd01ee8b-6686-fe8e-0d02-5507165f55eb@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/12 19:49, Kefeng Wang 写道:
> 
> On 2022/4/12 15:25, Tong Tiangen wrote:
>> X86 has it's implementation of copy_mc_to_user but not use #define to
>> declare.
>>
>> This may cause problems, for example, if other architectures open
>> CONFIG_ARCH_HAS_COPY_MC, but want to use copy_mc_to_user() outside the
>> architecture, the code add to include/linux/uaddess.h is as follows:
>>
>>      #ifndef copy_mc_to_user
>>      static inline unsigned long __must_check
>>      copy_mc_to_user(void *dst, const void *src, size_t cnt)
>>      {
>>         ...
>>      }
>>      #endif
>>
>> Then this definition will conflict with the implementation of X86 and 
>> cause
>> compilation errors.
> Does powerpc need this define?

Oh, missing that, will do next version.
>>
>> Fixes: ec6347bb4339 ("x86, powerpc: Rename memcpy_mcsafe() to 
>> copy_mc_to_{user, kernel}()")
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>> ---
>>   arch/x86/include/asm/uaccess.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/include/asm/uaccess.h 
>> b/arch/x86/include/asm/uaccess.h
>> index f78e2b3501a1..e18c5f098025 100644
>> --- a/arch/x86/include/asm/uaccess.h
>> +++ b/arch/x86/include/asm/uaccess.h
>> @@ -415,6 +415,7 @@ copy_mc_to_kernel(void *to, const void *from, 
>> unsigned len);
>>   unsigned long __must_check
>>   copy_mc_to_user(void *to, const void *from, unsigned len);
>> +#define copy_mc_to_user copy_mc_to_user
>>   #endif
>>   /*
> .
