Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA51512B69
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243749AbiD1GXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239165AbiD1GXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:23:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4A160062
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:20:28 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kplnv2QVFz1JBk4;
        Thu, 28 Apr 2022 14:19:31 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 14:20:26 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 14:20:25 +0800
Message-ID: <a0e058a5-3f46-1d05-5007-d339fa50e957@huawei.com>
Date:   Thu, 28 Apr 2022 14:20:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 2/4] mm: ioremap: Add arch_ioremap/iounmap_check()
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
 <20220427121413.168468-3-wangkefeng.wang@huawei.com>
 <CAK8P3a1E1vP-vS=-aH-XP=5taSTy8EUTfNSpQk9x47WLRMCOzQ@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAK8P3a1E1vP-vS=-aH-XP=5taSTy8EUTfNSpQk9x47WLRMCOzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/28 2:20, Arnd Bergmann wrote:
> On Wed, Apr 27, 2022 at 2:14 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> @@ -964,6 +964,9 @@ static inline void iounmap(volatile void __iomem *addr)
>>   #elif defined(CONFIG_GENERIC_IOREMAP)
>>   #include <linux/pgtable.h>
>>
>> +bool arch_ioremap_check(phys_addr_t addr, size_t size, unsigned long prot);
>> +bool arch_iounmap_check(void __iomem *addr);
>> +
>>   void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
>>   void iounmap(volatile void __iomem *addr);
>>
>> diff --git a/mm/ioremap.c b/mm/ioremap.c
>> index 522ef899c35f..d1117005dcc7 100644
>> --- a/mm/ioremap.c
>> +++ b/mm/ioremap.c
>> @@ -11,6 +11,16 @@
>>   #include <linux/io.h>
>>   #include <linux/export.h>
>>
>> +bool __weak arch_ioremap_check(phys_addr_t addr, size_t size, unsigned long prot)
>> +{
>> +       return true;
>> +}
>> +
>> +bool __weak arch_iounmap_check(void __iomem *addr)
>> +{
>> +       return true;
>> +}
>> +
> I don't really like the weak functions. The normal way to do this in
> asm-generic headers
> is to have something like
>
> #ifndef arch_ioremap_check
> static inline bool arch_ioremap_check(phys_addr_t addr, size_t size,
> unsigned long prot)
> {
>         return true;
> }
> #endif
>
> and then in architectures that actually do some checking, have these
> bits in asm/io.h
>
> bool arch_ioremap_check(phys_addr_t addr, size_t size, unsigned long prot);
> #define arch_ioremap_check arch_ioremap_check
Ok, I could use this way, and keep consistent with others definitions in 
asm/io.h
> (or alternatively an extern declaration, if the implementation is nontrivial)
>
> It may be worth pointing out that either way requires including
> asm-generic/io.h,
> which most architectures don't. This is probably fine, as only csky, riscv and
> now arm64 use CONFIG_GENERIC_IOREMAP, and we can probably require
> that any further architectures using this symbol also have to use
> asm-generic/io.h.

It looks the arch is already include it,

$ git grep "asm-generic/io.h" arch/

arch/arc/include/asm/io.h:#include <asm-generic/io.h>
arch/arm/include/asm/io.h:#include <asm-generic/io.h>
arch/arm64/include/asm/io.h:#include <asm-generic/io.h>
arch/csky/include/asm/io.h:#include <asm-generic/io.h>
arch/h8300/include/asm/io.h:#include <asm-generic/io.h>
arch/ia64/include/asm/io.h:#include <asm-generic/io.h>
arch/m68k/include/asm/io.h:#include <asm-generic/io.h>
arch/m68k/include/asm/io_no.h: * that behavior here first before we 
include asm-generic/io.h.
arch/microblaze/include/asm/io.h:#include <asm-generic/io.h>
arch/nios2/include/asm/io.h:#include <asm-generic/io.h>
arch/openrisc/include/asm/io.h:#include <asm-generic/io.h>
arch/powerpc/include/asm/io.h:#include <asm-generic/io.h>
arch/riscv/include/asm/io.h:#include <asm-generic/io.h>
arch/s390/include/asm/io.h:#include <asm-generic/io.h>
arch/sparc/include/asm/io_32.h:#include <asm-generic/io.h>
arch/um/include/asm/io.h:#include <asm-generic/io.h>
arch/x86/include/asm/io.h:#include <asm-generic/io.h>
arch/xtensa/include/asm/io.h:#include <asm-generic/io.h>

>        Arnd
>
> .
