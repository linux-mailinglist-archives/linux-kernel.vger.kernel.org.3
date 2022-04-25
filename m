Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DF150DA3E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiDYHh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240233AbiDYHhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:37:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0863DEDA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:34:44 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kmxb322vHzfb6c;
        Mon, 25 Apr 2022 15:33:51 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 15:34:41 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 15:34:40 +0800
Message-ID: <d6eb7e4e-aaf1-ab4f-dbe1-90e60b37b18e@huawei.com>
Date:   Mon, 25 Apr 2022 15:34:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v5 4/5] arm64: mm: add support for page table check
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220421082042.1167967-1-tongtiangen@huawei.com>
 <20220421082042.1167967-5-tongtiangen@huawei.com>
 <89ec03a9-5fee-7f4f-d189-67eb2aad24a3@arm.com>
 <c64e2159-d560-b560-f37e-4594692d88e1@huawei.com>
 <1ad261fc-4eb0-21f4-2f6b-11696cd5c1c3@arm.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <1ad261fc-4eb0-21f4-2f6b-11696cd5c1c3@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/25 13:41, Anshuman Khandual 写道:
> 
> 
> On 4/24/22 09:44, Tong Tiangen wrote:
>>
>>
>> 在 2022/4/22 14:45, Anshuman Khandual 写道:
>>> Please change the subject line as
>>>
>>> arm64/mm: Enable ARCH_SUPPORTS_PAGE_TABLE_CHECK
>>>
>>> OR
>>>
>>> arm64/mm: Subscribe ARCH_SUPPORTS_PAGE_TABLE_CHECK
>>>
>>> On 4/21/22 13:50, Tong Tiangen wrote:
>>>> From: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>
>>>> As commit d283d422c6c4 ("x86: mm: add x86_64 support for page table
>>>> check"), add some necessary page table check hooks into routines that
>>>> modify user page tables.
>>>
>>> Please make the commit message comprehensive, which should include
>>>
>>> - Enabling ARCH_SUPPORTS_PAGE_TABLE_CHECK on arm64
>>> - Adding all additional page table helpers required for PAGE_TABLE_CHECK
>>> - Instrumenting existing page table helpers with page table check hooks
>>>
>>
>> Good suggestion, if i need to do a new version for some other reason i think it should be described more comprehensivel
> 
> 
> This series needs revision to accommodate earlier comments.
> .

OK, Thanks.
