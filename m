Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD9B5A0786
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 05:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiHYDFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 23:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiHYDFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 23:05:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9FA9926D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 20:05:03 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MCnpc3y4GzGppf;
        Thu, 25 Aug 2022 11:03:20 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 11:05:01 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 11:05:00 +0800
Message-ID: <868e2e01-3462-dcb3-257a-f71d904b2a27@huawei.com>
Date:   Thu, 25 Aug 2022 11:04:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v2 0/2]riscv: some refactorings realted to uaccess
 and extable
To:     <Conor.Dooley@microchip.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <palmer@rivosinc.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, <guohanjun@huawei.com>
References: <20220815032025.2685516-1-tongtiangen@huawei.com>
 <4063da85-b110-4afd-2023-59d4da41c27f@huawei.com>
 <207ef9da-34d3-b059-9bfd-871a0c6ddab2@microchip.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <207ef9da-34d3-b059-9bfd-871a0c6ddab2@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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



在 2022/8/25 0:49, Conor.Dooley@microchip.com 写道:
> On 24/08/2022 07:31, Tong Tiangen wrote:
>> Hi riscv maintainers, kindly ping...
>>
>> Thanks,
>> Tong.
>>
>> 在 2022/8/15 11:20, Tong Tiangen 写道:
> 
> It's barely been more than a week, relax :)
> 
> checkpatch really does not like one of the macros you added. Please
> consider whether this is valid:
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> #38: FILE: arch/riscv/include/asm/asm-extable.h:61:
> +#define _ASM_EXTABLE_KACCESS_ERR_ZERO(insn, fixup, err, zero)          \
> +       __DEFINE_ASM_GPR_NUMS                                           \
> +       __ASM_EXTABLE_RAW(#insn, #fixup,                                \
> +                         __stringify(EX_TYPE_KACCESS_ERR_ZERO),        \
> +                         "("                                           \
> +                           EX_DATA_REG(ERR, err) " | "                 \
> +                           EX_DATA_REG(ZERO, zero)                     \
> +                         ")")
> 
> Thanks,
> Conor.


Judging from the use context of this macro, there is no problem with the 
definition of this macro.

In addition, I refer to the definition of macro 
_ASM_EXTABLE_UACCESS_ERR_ZERO for the style of this macro. The 
difference is that the types used in the macro are different.

:)

Thanks,
Tong.

> 
>>> This patchset do some refactorings related to riscv's uaccess and extable,
>>> mainly for the usage of __get/put_user_nocheck() which not distinguish user
>>> access and kernel access.
>>>
>>> v1 -> v2:
>>>     According to Conor's suggestion, split into two logically independent
>>>     patches.
>>>
>>> Tong Tiangen (2):
>>>     riscv: uaccess: rename __get/put_user_nocheck to __get/put_mem_nocheck
>>>     riscv: extable: add new extable type EX_TYPE_KACCESS_ERR_ZERO support
>>>
>>>    arch/riscv/include/asm/asm-extable.h |  12 ++
>>>    arch/riscv/include/asm/uaccess.h     | 162 +++++++++++++--------------
>>>    arch/riscv/mm/extable.c              |   1 +
>>>    3 files changed, 94 insertions(+), 81 deletions(-)
>>>
