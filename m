Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6575F532C46
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbiEXObR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238224AbiEXObI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:31:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF7E62FB
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:31:07 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L6xRM08ZJz1JC6X;
        Tue, 24 May 2022 22:29:35 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 22:31:04 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 22:31:03 +0800
Message-ID: <49ca1cd8-e9a4-a76f-abae-d6204691665f@huawei.com>
Date:   Tue, 24 May 2022 22:31:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 4/6] mm: ioremap: Add arch_ioremap/iounmap()
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
CC:     kernel test robot <lkp@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <kbuild-all@lists.01.org>, Linux-MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>
References: <20220519082552.117736-5-wangkefeng.wang@huawei.com>
 <202205240657.BXxrhbgp-lkp@intel.com>
 <c4ea8f50-f445-f4ee-1d17-f21954e52a83@huawei.com>
 <CAK8P3a1qEk3hLUOijtzXRhT4-nZO8KUe1a_3mvUVSSzaGt2itg@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAK8P3a1qEk3hLUOijtzXRhT4-nZO8KUe1a_3mvUVSSzaGt2itg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/5/24 20:35, Arnd Bergmann wrote:
> On Tue, May 24, 2022 at 11:48 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>>> mm/ioremap.c:59:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got void [noderef] __iomem *vaddr @@
>>>      mm/ioremap.c:59:16: sparse:     expected void const *addr
>>>      mm/ioremap.c:59:16: sparse:     got void [noderef] __iomem *vaddr
>>>
>>> vim +59 mm/ioremap.c
>>>
>>>       51
>>>       52       void iounmap(volatile void __iomem *addr)
>>>       53       {
>>>       54               void __iomem *vaddr = (void __iomem *)((unsigned long)addr & PAGE_MASK);
>>>       55
>>>       56               if (arch_iounmap(vaddr))
>>>       57                       return;
>>>       58
>>>     > 59               vunmap(vaddr);
>> 1) Will add generic "arch_ioremap/arch_iounmap define"
>>
>> 2) and change this to vunmap((void *)vaddr);
> I think this need an extra __force to actually suppress the sparse
> warning, as in
>
>          vunmap((void __force *)vaddr);
>
> Using __force is usually wrong, this is one of the exceptions, so
> maybe add a comment
> as well.
Right, I found this too， and  using  ___force in local, will update, thank.
>
>           Arnd
>
> .
