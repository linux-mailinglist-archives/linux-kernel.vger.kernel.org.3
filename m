Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E557B53494D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbiEZDgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiEZDgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:36:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78274FC67
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 20:36:46 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L7tqz2sp6zjX7b;
        Thu, 26 May 2022 11:35:43 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 11:36:44 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 11:36:42 +0800
Message-ID: <87bdb1c6-5803-d9c0-9208-432027ae1d8b@huawei.com>
Date:   Thu, 26 May 2022 11:36:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v4 3/7] arm64: add support for machine check error
 safe
To:     Mark Rutland <mark.rutland@arm.com>
CC:     James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220420030418.3189040-1-tongtiangen@huawei.com>
 <20220420030418.3189040-4-tongtiangen@huawei.com> <Yn54mA7KnlAs1dER@lakrids>
 <46e5954c-a9a8-f4a8-07cc-de42e2753051@huawei.com>
 <Yo3pP/Y+6HHuVBns@FVFF77S0Q05N>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <Yo3pP/Y+6HHuVBns@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/25 16:30, Mark Rutland 写道:
> On Thu, May 19, 2022 at 02:29:54PM +0800, Tong Tiangen wrote:
>>
>>
>> 在 2022/5/13 23:26, Mark Rutland 写道:
>>> On Wed, Apr 20, 2022 at 03:04:14AM +0000, Tong Tiangen wrote:
>>>> During the processing of arm64 kernel hardware memory errors(do_sea()), if
>>>> the errors is consumed in the kernel, the current processing is panic.
>>>> However, it is not optimal.
>>>>
>>>> Take uaccess for example, if the uaccess operation fails due to memory
>>>> error, only the user process will be affected, kill the user process
>>>> and isolate the user page with hardware memory errors is a better choice.
>>>
>>> Conceptually, I'm fine with the idea of constraining what we do for a
>>> true uaccess, but I don't like the implementation of this at all, and I
>>> think we first need to clean up the arm64 extable usage to clearly
>>> distinguish a uaccess from another access.
>>
>> OK,using EX_TYPE_UACCESS and this extable type could be recover, this is
>> more reasonable.
> 
> Great.
> 
>> For EX_TYPE_UACCESS_ERR_ZERO, today we use it for kernel accesses in a
>> couple of cases, such as
>> get_user/futex/__user_cache_maint()/__user_swpX_asm(),
> 
> Those are all user accesses.
> 
> However, __get_kernel_nofault() and __put_kernel_nofault() use
> EX_TYPE_UACCESS_ERR_ZERO by way of __{get,put}_mem_asm(), so we'd need to
> refactor that code to split the user/kernel cases higher up the callchain.
> 
>> your suggestion is:
>> get_user continues to use EX_TYPE_UACCESS_ERR_ZERO and the other cases use
>> new type EX_TYPE_FIXUP_ERR_ZERO?
> 
> Yes, that's the rough shape. We could make the latter EX_TYPE_KACCESS_ERR_ZERO
> to be clearly analogous to EX_TYPE_UACCESS_ERR_ZERO, and with that I susepct we
> could remove EX_TYPE_FIXUP.
> 
> Thanks,
> Mark.
According to your suggestion, i think the definition is like this:

#define EX_TYPE_NONE                    0
#define EX_TYPE_FIXUP                   1    --> delete
#define EX_TYPE_BPF                     2
#define EX_TYPE_UACCESS_ERR_ZERO        3
#define EX_TYPE_LOAD_UNALIGNED_ZEROPAD  4
#define EX_TYPE_UACCESS		        xx   --> add
#define EX_TYPE_KACCESS_ERR_ZERO        xx   --> add
[The value defined by the macro here is temporary]

There are two points to modify:

1、_get_kernel_nofault() and __put_kernel_nofault()  using 
EX_TYPE_KACCESS_ERR_ZERO, Other positions using 
EX_TYPE_UACCESS_ERR_ZERO keep unchanged.

2、delete EX_TYPE_FIXUP.

There is no doubt about others. As for EX_TYPE_FIXUP, I think it needs 
to be retained, _cond_extable(EX_TYPE_FIXUP) is still in use in assembler.h.

Thanks,
Tong.

> .
