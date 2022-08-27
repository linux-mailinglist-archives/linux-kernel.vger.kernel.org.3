Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F27A5A3712
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 12:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiH0Kjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 06:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243326AbiH0Kjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 06:39:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47EC2FE
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 03:39:45 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MFCm95yQQzkWcF;
        Sat, 27 Aug 2022 18:36:09 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 18:39:44 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 18:39:42 +0800
Message-ID: <b1af8198-3291-149e-cd8b-c55d7321deb7@huawei.com>
Date:   Sat, 27 Aug 2022 18:39:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v2 1/2] riscv: uaccess: rename
 __get/put_user_nocheck to __get/put_mem_nocheck
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <Conor.Dooley@microchip.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220815032025.2685516-1-tongtiangen@huawei.com>
 <20220815032025.2685516-2-tongtiangen@huawei.com>
 <20220825105600.ezueddmwehob42rf@kamzik>
 <3541c980-7fcf-7047-cec7-3c2ca6381a99@huawei.com>
 <20220826074318.g6nwri5ziiutiio5@kamzik>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20220826074318.g6nwri5ziiutiio5@kamzik>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/8/26 15:43, Andrew Jones 写道:
> On Fri, Aug 26, 2022 at 02:33:47PM +0800, Tong Tiangen wrote:
>>
>>
>> 在 2022/8/25 18:56, Andrew Jones 写道:
>>> On Mon, Aug 15, 2022 at 03:20:24AM +0000, Tong Tiangen wrote:
>>>> Current, The helpers __get/put_user_nocheck() is used by get/put_user() and
>>>> __get/put_kernel_nofault(), which is not always uaccess, so the name with
>>>> *user* is not appropriate.
>>>>
>>>> Also rename xxx_user_xxx to xxx_mem_xx  on the call path of
>>>> __get/put_user_nocheck()
>>>>
>>>> Only refactor code without any functional changes.
>>>>
>>>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>>>> ---
>>>>    arch/riscv/include/asm/uaccess.h | 48 ++++++++++++++++----------------
>>>>    1 file changed, 24 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
>>>> index 855450bed9f5..1370da055b44 100644
>>>> --- a/arch/riscv/include/asm/uaccess.h
>>>> +++ b/arch/riscv/include/asm/uaccess.h
>>>> @@ -50,7 +50,7 @@
>>>>     * call.
>>>>     */
>>>> -#define __get_user_asm(insn, x, ptr, err)			\
>>>> +#define __get_mem_asm(insn, x, ptr, err)			\
>>>>    do {								\
>>>>    	__typeof__(x) __x;					\
>>>>    	__asm__ __volatile__ (					\
>>>> @@ -64,12 +64,12 @@ do {								\
>>>>    } while (0)
>>>>    #ifdef CONFIG_64BIT
>>>> -#define __get_user_8(x, ptr, err) \
>>>> -	__get_user_asm("ld", x, ptr, err)
>>>> +#define __get_mem_8(x, ptr, err) \
>>>> +	__get_mem_asm("ld", x, ptr, err)
>>>>    #else /* !CONFIG_64BIT */
>>>> -#define __get_user_8(x, ptr, err)				\
>>>> +#define __get_mem_8(x, ptr, err)				\
>>>>    do {								\
>>>> -	u32 __user *__ptr = (u32 __user *)(ptr);		\
>>>> +	u32 *__ptr = (u32 *)(ptr);				\
>>>
>>> Doesn't casting away __user reduce sparse's utility?
>>
>>  From the call logic[1], the address passed into this macro is not
>> necessarily __user. I understand that no problem will be introduced for
>> sparse's utility.
>>
>> In addition, there is no need to do a pointer conversion here, will be fixed
>> next version.
>>
>> [1] __get_kernel_nofault -> __get_mem_nocheck -> __get_mem_8
> 
> Yes, I understood that. My concern was for the times that the address was
> __user as we'd no longer get that check for them.

Check __user ptr at __get_user() has the same effect? Is this 
understanding correct？

Thanks,
Tong.

> 
> Thanks,
> drew
> 
> .
