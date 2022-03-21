Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E594E2088
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbiCUGRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238570AbiCUGRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:17:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B5D8A31F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:15:40 -0700 (PDT)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KMPTB6yTQzfYr5;
        Mon, 21 Mar 2022 14:14:06 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500002.china.huawei.com (7.221.188.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 14:15:38 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 14:15:37 +0800
Message-ID: <d3006048-f737-439e-b985-cfbab69c4167@huawei.com>
Date:   Mon, 21 Mar 2022 14:15:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Tong Tiangen <tongtiangen@huawei.com>
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
 <cb91532b-c0cd-034c-2f93-4f76fabf5fc1@huawei.com> <YjS+2FVpq8D4Gx0S@arm.com>
In-Reply-To: <YjS+2FVpq8D4Gx0S@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/3/19 1:18, Catalin Marinas 写道:
> On Fri, Mar 18, 2022 at 11:58:22AM +0800, Tong Tiangen wrote:
>> 在 2022/3/18 3:00, Catalin Marinas 写道:
>>> On Thu, Mar 17, 2022 at 02:12:02PM +0000, Tong Tiangen wrote:
>>>> @@ -628,6 +647,25 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>>>>    #define pud_leaf(pud)		pud_sect(pud)
>>>>    #define pud_valid(pud)		pte_valid(pud_pte(pud))
>>>> +#ifdef CONFIG_PAGE_TABLE_CHECK
>>>> +static inline bool pte_user_accessible_page(pte_t pte)
>>>> +{
>>>> +	return (pte_val(pte) & PTE_VALID) && (pte_val(pte) & PTE_USER);
>>>> +}
> [...]
>>> Do we care about PROT_NONE mappings here? They have the valid bit
>>> cleared but pte_present() is true.
>>>
>>
>> PTC will not check this special type(PROT_NONE) of page.
> 
> PROT_NONE is just a permission but since we don't have independent read
> and write bits in the pte, we implement it as an invalid pte (bit 0
> cleared). The other content of the pte is fine, so pte_pfn() should
> still work. PTC could as well check this, I don't think it hurts.

You have a point and the logic should be:

	pte_present(pte) && (pte_user(pte) || pte_user_exec(pte))

> 
>>>> +static inline bool pmd_user_accessible_page(pmd_t pmd)
>>>> +{
>>>> +	return pmd_leaf(pmd) && (pmd_val(pmd) & PTE_VALID) &&
>>>> +		(pmd_val(pmd) & PTE_USER);
>>>> +}
>>>
>>> pmd_leaf() implies valid, so you can skip it if that's the aim.
>>
>> PTC only checks whether the memory block corresponding to the pmd_leaf type
>> can access, for !pmd_leaf, PTC checks at the pte level. So i think this is
>> necessary.
> 
> My point is that the (pmd_val(pmd) & PTE_VALID) check is superfluous
> since that's covered by pmd_leaf() already.

Oh，i got it，you're right and these will be fixed in v2.

Considering all your suggestions, The final logic should be:

+#define pte_user(pte)          (!!(pte_val(pte) & PTE_USER))

+#define pmd_user(pmd)		pte_user(pmd_pte(pmd))
+#define pmd_user_exec(pmd)	pte_user_exec(pmd_pte(pmd))

+#define pud_user(pud)          pte_user(pud_pte(pud))

+static inline bool pte_user_accessible_page(pte_t pte)
+{
+	return pte_present(pte) && (pte_user(pte)|| pte_user_exec(pte));
+}

+static inline bool pmd_user_accessible_page(pmd_t pmd)
+{
+	return pmd_present(pmd) && (pmd_user(pmd)|| pmd_user_exec(pmd));
+}

+static inline bool pud_user_accessible_page(pud_t pud)
+{
+	return pud_present(pud) && pud_user(pud);
+}

> 
