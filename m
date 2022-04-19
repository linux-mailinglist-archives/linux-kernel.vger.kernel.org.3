Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E33A506735
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350171AbiDSIzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiDSIz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:55:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC44193EF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:52:46 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KjHc014LhzfZDR;
        Tue, 19 Apr 2022 16:52:00 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 16:52:43 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 16:52:42 +0800
Message-ID: <be7043f9-e9fb-d444-4ffd-9f3e7e83cf86@huawei.com>
Date:   Tue, 19 Apr 2022 16:52:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v4 3/4] arm64: mm: add support for page table check
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
References: <20220418034444.520928-1-tongtiangen@huawei.com>
 <20220418034444.520928-4-tongtiangen@huawei.com>
 <1c314feb-cd78-2bb3-462e-4ea3cefe122e@arm.com>
 <ca13a4ec-17a6-8e29-e29e-39f9b47e78df@huawei.com>
 <88a70fa7-b1c8-6f5c-1018-df673949785c@arm.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <88a70fa7-b1c8-6f5c-1018-df673949785c@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/19 15:10, Anshuman Khandual 写道:
> 
> 
> On 4/18/22 21:17, Tong Tiangen wrote:
>>
>>
>> 在 2022/4/18 17:28, Anshuman Khandual 写道:
>>> On 4/18/22 09:14, Tong Tiangen wrote:
>>>> From: Kefeng Wang <wangkefeng.wang@huawei.com>
[...]
>>>
>>> Could you explain what was expected during pmdp_collapse_flush() which when
>>> failed, triggered this BUG_ON() ? This counter seems to be page table check
>>> specific, could it just go wrong ? I have not looked into the details about
>>> page table check mechanism.
>>>
>>> - Anshuman
>>> .
>>
>> Hi Anshuman:
>>
>> Thanks for your job.
>>
>> Let me briefly explain the principle of page table check(PTC).
>>
>> PTC introduces the following struct for page mapping type count:
>> struct page_table_check {
>>          atomic_t anon_map_count;
>>          atomic_t file_map_count;
>> };
>> This structure can be obtained by "lookup_page_ext(page)"
> 
> 
> Right.
> 
>>
>> When page table entries are set(pud/pmd/pte), page_table_check_set()  is called to increase the page mapping count, Also check for errors (eg:if a page is used for anonymous mapping, then the page cannot be used for file mapping at the same time).
>>
>> When page table entries are clear(pud/pmd/pte), page_table_check_clear()  is called to decrease the page mapping count, Also check for errors.
>>
>> The error check rules are described in the following documents: Documentation/vm/page_table_check.rst
> 
> Snippet from that document.
> 
> +-------------------+-------------------+-------------------+------------------+
> | Current Mapping   | New mapping       | Permissions       | Rule             |
> +===================+===================+===================+==================+
> | Anonymous         | Anonymous         | Read              | Allow            |
> +-------------------+-------------------+-------------------+------------------+
> | Anonymous         | Anonymous         | Read / Write      | Prohibit         |
> +-------------------+-------------------+-------------------+------------------+
> | Anonymous         | Named             | Any               | Prohibit         |
> +-------------------+-------------------+-------------------+------------------+
> | Named             | Anonymous         | Any               | Prohibit         |
> +-------------------+-------------------+-------------------+------------------+
> | Named             | Named             | Any               | Allow            |
> +-------------------+-------------------+-------------------+------------------+
> 
> Does 'Named' refer to file mapping ? Also what does 'Prohibit' imply here ? The
> check will call out a BUG_ON() in such cases ?

Right， Named means file mapping,  Prohibit here trigger BUG_ON.

> 
> page_table_check_clear()
> {
> 
>                  if (anon) {
>                          BUG_ON(atomic_read(&ptc->file_map_count));
>                          BUG_ON(atomic_dec_return(&ptc->anon_map_count) < 0);
>                  } else {
>                          BUG_ON(atomic_read(&ptc->anon_map_count));
>                          BUG_ON(atomic_dec_return(&ptc->file_map_count) < 0);
>                  }
> }
> 
> So in the clear path, there are two checks
> 
> - If the current mapping is Anon, file_map_count cannot be positive and other way
> - Decrement the applicable counter ensuring that it does not turn negative
> 
> page_table_check_set()
> {
>                  if (anon) {
>                          BUG_ON(atomic_read(&ptc->file_map_count));
>                          BUG_ON(atomic_inc_return(&ptc->anon_map_count) > 1 && rw);
>                  } else {
>                          BUG_ON(atomic_read(&ptc->anon_map_count));
>                          BUG_ON(atomic_inc_return(&ptc->file_map_count) < 0);
>                  }
> }
> 
> So in the set path, there are two checks
> 
> - If the current mapping is anon, file_map_count cannot be positive and other way
> - Anon mapping cannot be RW if the page has been mapped more than once
> - But then why check for negative values for file_map_count after increment ?

Check for negative after increment is logically OK and <=0 should be 
more reasonable.

> 
> Is there any other checks, which this test ensures, that I might be missing ?

The following checks are performed when page table entry are 
allocated/released:
__page_table_check_zero()
{
	BUG_ON(atomic_read(&ptc->anon_map_count));
	BUG_ON(atomic_read(&ptc->file_map_count));
}

> 
>>
>> The setting and clearing of page table entries are symmetrical.
> 
> This assumption should be true for any user accessible mapping, for this test to work ?

Right, if not, here is BUG_ON.

However, as Pasha said:
"this being new on ARM64, it is possible that the bug is in 
PTC/khugepaged itself."

> 
> Also why PUD_PAGE_SIZE/PMD_PAGE_SIZE are being used here instead of directly using
> generic macros such as PUD_SIZE/PMD_SIZE ? Is there a specific reason ?

I did code optimization for this, in patch 1/4 of this patchset:

+#ifndef PMD_PAGE_SIZE
+#define PMD_PAGE_SIZE	PMD_SIZE
+#endif
+
+#ifndef PUD_PAGE_SIZE
+#define PUD_PAGE_SIZE	PUD_SIZE
+#endif


Thank you.
Tong.

> 
>>
>> Here __page_table_check_pmd_clear() trigger BUGON which indicates that the pmd entry file mapping count has become negative.
>>
>> I guess if PTC didn't detect this exception, would there have been any problems?
> 
> I am looking into this, not sure for now.
> .
