Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C14152CA6B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 05:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiESDhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 23:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbiESDhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 23:37:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACC1692AC
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 20:37:34 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L3b5c6Y8nzCshj;
        Thu, 19 May 2022 11:32:36 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 11:37:32 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 11:37:32 +0800
Message-ID: <3f8fcab1-16ab-8e8e-9d5f-dc8dba7066e3@huawei.com>
Date:   Thu, 19 May 2022 11:37:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 0/5] arm64: Cleanup ioremap() and support
 ioremap_prot()
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <hch@infradead.org>, <arnd@arndb.de>
References: <20220429103225.75121-1-wangkefeng.wang@huawei.com>
 <YoLVVJXRnDXCPVO8@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YoLVVJXRnDXCPVO8@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/5/17 6:51, Catalin Marinas wrote:
> On Fri, Apr 29, 2022 at 06:32:20PM +0800, Kefeng Wang wrote:
>> Kefeng Wang (5):
>>    mm: ioremap: Use more sensibly name in ioremap_prot()
>>    mm: ioremap: Setup phys_addr of struct vm_struct
>>    mm: ioremap: Add arch_ioremap/iounmap()
>>    arm64: mm: Convert to GENERIC_IOREMAP
>>    arm64: Add HAVE_IOREMAP_PROT support
>>
>>   .../features/vm/ioremap_prot/arch-support.txt |  2 +-
>>   arch/arm64/Kconfig                            |  2 +
>>   arch/arm64/include/asm/io.h                   | 20 +++--
>>   arch/arm64/include/asm/pgtable.h              | 10 +++
>>   arch/arm64/kernel/acpi.c                      |  2 +-
>>   arch/arm64/mm/hugetlbpage.c                   | 10 ---
>>   arch/arm64/mm/ioremap.c                       | 85 +++----------------
>>   include/asm-generic/io.h                      | 16 +++-
>>   mm/ioremap.c                                  | 27 ++++--
>>   9 files changed, 74 insertions(+), 100 deletions(-)
> These patches touch the generic mm parts. Andrew, would you like to
> merge these patches or are happy for them to go via the arm64 tree.
Hi Andrew, what's your preference ;)
> Thanks.
>
