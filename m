Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CA25132CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345717AbiD1LwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345691AbiD1LwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:52:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB674689B5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:48:52 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kpv5c1xC1zhY1t;
        Thu, 28 Apr 2022 19:48:36 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 19:48:50 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 19:48:50 +0800
Message-ID: <46c0fff6-dff9-5669-7aa7-79bae0883a7e@huawei.com>
Date:   Thu, 28 Apr 2022 19:48:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 0/4] arm64: Cleanup ioremap() and support ioremap_prot()
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
 <20220428104612.GA14515@willie-the-truck>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220428104612.GA14515@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/28 18:46, Will Deacon wrote:
> On Wed, Apr 27, 2022 at 08:14:09PM +0800, Kefeng Wang wrote:
>> Let's arm64 use GENERIC_IOREMAP to cleanup code, and
>> support ioremap_prot()/HAVE_IOREMAP_PROT, which could
>> enable generic_access_phys().
>>
>> Kefeng Wang (4):
>>    mm: ioremap: Setup phys_addr of struct vm_struct
>>    mm: ioremap: Add arch_ioremap/iounmap_check()
>>    arm64: mm: Convert to GENERIC_IOREMAP
>>    arm64: Add HAVE_IOREMAP_PROT support
>>
>>   .../features/vm/ioremap_prot/arch-support.txt |  2 +-
>>   arch/arm64/Kconfig                            |  2 +
>>   arch/arm64/include/asm/io.h                   | 14 +--
>>   arch/arm64/include/asm/pgtable.h              | 10 +++
>>   arch/arm64/kernel/acpi.c                      |  2 +-
>>   arch/arm64/mm/hugetlbpage.c                   | 10 ---
>>   arch/arm64/mm/ioremap.c                       | 86 +++----------------
>>   include/asm-generic/io.h                      |  3 +
>>   mm/ioremap.c                                  | 21 ++++-
>>   9 files changed, 56 insertions(+), 94 deletions(-)
> That's not a massively compelling diffstat for a cleanup, in all honesty.
> I looked at generic_access_phys() to try to figure out why we would want
> that on arm64, but it seems like it's related to mmap() of devices in
> userspace. Bearing in mind that CONFIG_STRICT_DEVMEM=y by default, please
> can you justify why this is something worth doing?

The geneirc_access_phys was introduced by

   7ae8ed5053a3 use generic_access_phys for /dev/mem mappings
   28b2ee20c7cb access_process_vm device memory infrastructure

and add into uio.c  by

   7294151d0592 "uio: provide vm access to UIO_MEM_PHYS maps"

It could let user to debug(eg, gdb or ptrace) app via access_process_vm().

also some upstream drivers and out-of-tree modules could use it too
   drivers/fpga/dfl-afu-main.c:    .access = generic_access_phys,
   drivers/pci/mmap.c:     .access = generic_access_phys,

When see the ioremap_prot from generic ioremap, for better debug, I think

we could enabled it on arm64 too.

> Will
> .
