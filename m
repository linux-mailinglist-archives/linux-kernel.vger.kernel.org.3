Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26C64FF096
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiDMHdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiDMHdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:33:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E5843393
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:30:43 -0700 (PDT)
Received: from kwepemi100019.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KdZ281BQCzFpnZ;
        Wed, 13 Apr 2022 15:28:16 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100019.china.huawei.com (7.221.188.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 15:30:40 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 15:30:39 +0800
Message-ID: <976b642a-4085-ac8f-1377-cc8f295203a2@huawei.com>
Date:   Wed, 13 Apr 2022 15:30:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH -next V3 4/6] arm64: add copy_{to, from}_user to
 machine check safe
To:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
References: <20220412072552.2526871-1-tongtiangen@huawei.com>
 <20220412072552.2526871-5-tongtiangen@huawei.com>
 <38c6d4b5-a3db-5c3e-02e7-39875edb3476@arm.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <38c6d4b5-a3db-5c3e-02e7-39875edb3476@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/13 1:08, Robin Murphy 写道:
> On 12/04/2022 8:25 am, Tong Tiangen wrote:
> [...]
>> diff --git a/arch/arm64/include/asm/asm-uaccess.h 
>> b/arch/arm64/include/asm/asm-uaccess.h
>> index 0557af834e03..bb17f0829042 100644
>> --- a/arch/arm64/include/asm/asm-uaccess.h
>> +++ b/arch/arm64/include/asm/asm-uaccess.h
>> @@ -92,4 +92,20 @@ alternative_else_nop_endif
>>           _asm_extable    8888b,\l;
>>       .endm
>> +
>> +    .macro user_ldp_mc l, reg1, reg2, addr, post_inc
>> +8888:        ldtr    \reg1, [\addr];
>> +8889:        ldtr    \reg2, [\addr, #8];
>> +        add    \addr, \addr, \post_inc;
>> +
>> +        _asm_extable_uaccess_mc    8888b, \l;
>> +        _asm_extable_uaccess_mc    8889b, \l;
>> +    .endm
> 
> You're replacing the only user of this, so please just 
> s/_asm_extable/_asm_extable_uaccess_mc/ in the existing macro and save 
> the rest of the churn.
> 
> Furthermore, how come you're not similarly updating user_stp, given that 
> you *are* updating the other stores in copy_to_user?

I think all load/store instructions should be handled.

Generally speaking, the load operation will receive a sea when consuming 
a hardware memory error, and the store operation will not receive a sea 
when consuming a hardware error. Depends on chip behavior.

So add store class instructions to processed is no harm.

If there is any problem with my understanding, correct me.

Thanks,
Tong.

> 
>> +
>> +    .macro user_ldst_mc l, inst, reg, addr, post_inc
>> +8888:        \inst        \reg, [\addr];
>> +        add        \addr, \addr, \post_inc;
>> +
>> +        _asm_extable_uaccess_mc    8888b, \l;
>> +    .endm
>
[...]
