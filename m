Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255C34DD3D0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 04:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiCRD7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 23:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiCRD7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:59:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12F411C0E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:58:27 -0700 (PDT)
Received: from kwepemi100008.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KKVYf2rxszCqk9;
        Fri, 18 Mar 2022 11:56:22 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 11:58:24 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 11:58:23 +0800
Message-ID: <cb91532b-c0cd-034c-2f93-4f76fabf5fc1@huawei.com>
Date:   Fri, 18 Mar 2022 11:58:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH -next 3/4] arm64: mm: add support for page table check
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Will Deacon" <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>
References: <20220317141203.3646253-1-tongtiangen@huawei.com>
 <20220317141203.3646253-4-tongtiangen@huawei.com> <YjOFNEvj7EfBasCI@arm.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <YjOFNEvj7EfBasCI@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/3/18 3:00, Catalin Marinas 写道:
> On Thu, Mar 17, 2022 at 02:12:02PM +0000, Tong Tiangen wrote:
>> @@ -628,6 +647,25 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>>   #define pud_leaf(pud)		pud_sect(pud)
>>   #define pud_valid(pud)		pte_valid(pud_pte(pud))
>>   
>> +#ifdef CONFIG_PAGE_TABLE_CHECK
>> +static inline bool pte_user_accessible_page(pte_t pte)
>> +{
>> +	return (pte_val(pte) & PTE_VALID) && (pte_val(pte) & PTE_USER);
>> +}
> 
> There is another class of user mappings, execute-only, that have both
> PTE_USER and PTE_UXN cleared. So this logic should be:
> 
> 	pte_valid(pte) && (pte_user(pte) || pte_user_exec(pte))
> 
> with pte_user() as:
> 
> #define pte_user(pte)	(!!(pte_val(pte) & PTE_USER))

Good suggestion, the PTC(page table check) can cover UXN page and 
pte_user(pte) helper is required.

> 
> Do we care about PROT_NONE mappings here? They have the valid bit
> cleared but pte_present() is true.
>

PTC will not check this special type(PROT_NONE) of page.

>> +static inline bool pmd_user_accessible_page(pmd_t pmd)
>> +{
>> +	return pmd_leaf(pmd) && (pmd_val(pmd) & PTE_VALID) &&
>> +		(pmd_val(pmd) & PTE_USER);
>> +}
> 
> pmd_leaf() implies valid, so you can skip it if that's the aim.

PTC only checks whether the memory block corresponding to the pmd_leaf 
type can access, for !pmd_leaf, PTC checks at the pte level. So i think 
this is necessary.

> 
> Similar comment to the pte variant on execute-only and PROT_NONE
> mappings

Same considerations as above.

Thanks.
Tong
> 
