Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F25151B831
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245222AbiEEGuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiEEGuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:50:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37951FA7C
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 23:46:55 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kv4310yQ8zfbF5;
        Thu,  5 May 2022 14:45:49 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 14:46:53 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 14:46:52 +0800
Message-ID: <3f0439c7-9c25-b83a-58dd-9c3d638b9236@huawei.com>
Date:   Thu, 5 May 2022 14:46:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v6 5/6] arm64/mm: Enable
 ARCH_SUPPORTS_PAGE_TABLE_CHECK
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220426081036.1374452-1-tongtiangen@huawei.com>
 <20220426081036.1374452-6-tongtiangen@huawei.com>
 <ae74ea7c-9014-b162-f1e7-a66f402aee49@arm.com>
 <80f6c347-db5d-8836-bc79-60c7b2a6eed8@huawei.com> <YnK3U3qDhhgwaULb@arm.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <YnK3U3qDhhgwaULb@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/5 1:26, Catalin Marinas 写道:
> On Tue, May 03, 2022 at 09:13:20AM +0800, Tong Tiangen wrote:
>> 在 2022/4/29 14:18, Anshuman Khandual 写道:
>>> On 4/26/22 13:40, Tong Tiangen wrote:
>>>> @@ -884,7 +928,11 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>>    static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
>>>>    					    unsigned long address, pmd_t *pmdp)
>>>>    {
>>>> -	return pte_pmd(ptep_get_and_clear(mm, address, (pte_t *)pmdp));
>>>> +	pmd_t pmd = pte_pmd(__pte(xchg_relaxed(&pte_val(*(pte_t *)pmdp), 0)));
>>>
>>> Why there is any change here ? Why not just the following instead, like what you did
>>> in ptep_get_and_clear() above. The page table entry return value here just needs to
>>> be preserved for subsequent page table check helpers.
>>>
>>> 	pmd_t pmd = pte_pmd(ptep_get_and_clear(mm, address, (pte_t *)pmdp));
>>
>> The purpose of what I do here is to avoid doing page_table_check_pte_clear()
>> in ptep_get_and_clear(). there is no functional change here.
> 
> I'm fine with using xchg here but I'd go for pmd_val directly, no need
> for conversion to pte_t:
> 
> 	pmd_t pmd = __pmd(xchg_relaxed(&pmd_val(*pmdp), 0));
> 

OK, This implementation is good and avoids redundant conversion, will 
fix it next version.

Thanks,
Tong.

