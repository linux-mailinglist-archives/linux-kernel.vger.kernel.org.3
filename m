Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F9E54A781
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350616AbiFNDUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351355AbiFNDUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:20:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207412E69C;
        Mon, 13 Jun 2022 20:20:12 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LMYZm4jndzDrD4;
        Tue, 14 Jun 2022 11:19:44 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 11:20:09 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 11:20:08 +0800
Message-ID: <2737609c-78d9-b679-f2d6-a681614f68b5@huawei.com>
Date:   Tue, 14 Jun 2022 11:20:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/2] arm64: kcsan: Support detecting more missing
 memory barriers
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <elver@google.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <arnd@arndb.de>
References: <20220523113126.171714-1-wangkefeng.wang@huawei.com>
 <20220523113126.171714-3-wangkefeng.wang@huawei.com>
 <YouXQ+XX8CrgM5QX@FVFF77S0Q05N>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YouXQ+XX8CrgM5QX@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will and Catalin, kindly ping...

On 2022/5/23 22:16, Mark Rutland wrote:
> On Mon, May 23, 2022 at 07:31:26PM +0800, Kefeng Wang wrote:
>> As "kcsan: Support detecting a subset of missing memory barriers"[1]
>> introduced KCSAN_STRICT/KCSAN_WEAK_MEMORY which make kcsan detects
>> more missing memory barrier, but arm64 don't have KCSAN instrumentation
>> for barriers, so the new selftest test_barrier() and test cases for
>> memory barrier instrumentation in kcsan_test module will fail, even
>> panic on selftest.
>>
>> Let's prefix all barriers with __ on arm64, as asm-generic/barriers.h
>> defined the final instrumented version of these barriers, which will
>> fix the above issues.
>>
>> Note, barrier instrumentation that can be disabled via __no_kcsan with
>> appropriate compiler-support (and not just with objtool help), see
>> commit bd3d5bd1a0ad ("kcsan: Support WEAK_MEMORY with Clang where no
>> objtool support exists"), it adds disable_sanitizer_instrumentation to
>> __no_kcsan attribute which will remove all sanitizer instrumentation fully
>> (with Clang 14.0). Meanwhile, GCC does the same thing with no_sanitize.
>>
>> [1] https://lore.kernel.org/linux-mm/20211130114433.2580590-1-elver@google.com/
>>
>> Acked-by: Marco Elver <elver@google.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Having built this with GCC 12.1.0 and LLVM 14.0.0, I think this patch itself
> doesn't introduce any new problems, and logically makes sense. With that in
> mind:
>
>    Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> As an aside, having scanned the resulting vmlinux with objdump, there are
> plenty of latent issues where we get KCSAN instrumentation where we don't want
> it (e.g. early/late in arm64's entry-common.o). The bulk of those are due to
> missing `nonistr` or `__always_inline`, which we'll need to fix up.
>
> Thanks,
> Mark.
>
>> ---
>>   arch/arm64/include/asm/barrier.h | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
>> index 9f3e2c3d2ca0..2cfc4245d2e2 100644
>> --- a/arch/arm64/include/asm/barrier.h
>> +++ b/arch/arm64/include/asm/barrier.h
>> @@ -50,13 +50,13 @@
>>   #define pmr_sync()	do {} while (0)
>>   #endif
>>   
>> -#define mb()		dsb(sy)
>> -#define rmb()		dsb(ld)
>> -#define wmb()		dsb(st)
>> +#define __mb()		dsb(sy)
>> +#define __rmb()		dsb(ld)
>> +#define __wmb()		dsb(st)
>>   
>> -#define dma_mb()	dmb(osh)
>> -#define dma_rmb()	dmb(oshld)
>> -#define dma_wmb()	dmb(oshst)
>> +#define __dma_mb()	dmb(osh)
>> +#define __dma_rmb()	dmb(oshld)
>> +#define __dma_wmb()	dmb(oshst)
>>   
>>   #define io_stop_wc()	dgh()
>>   
>> -- 
>> 2.35.3
>>
> .
