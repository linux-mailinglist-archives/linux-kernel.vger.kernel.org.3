Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0832550655B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349061AbiDSHMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349208AbiDSHMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:12:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B343B11C2E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:09:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBE011042;
        Tue, 19 Apr 2022 00:09:53 -0700 (PDT)
Received: from [10.163.40.223] (unknown [10.163.40.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AF383F766;
        Tue, 19 Apr 2022 00:09:45 -0700 (PDT)
Message-ID: <88a70fa7-b1c8-6f5c-1018-df673949785c@arm.com>
Date:   Tue, 19 Apr 2022 12:40:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next v4 3/4] arm64: mm: add support for page table check
Content-Language: en-US
To:     Tong Tiangen <tongtiangen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220418034444.520928-1-tongtiangen@huawei.com>
 <20220418034444.520928-4-tongtiangen@huawei.com>
 <1c314feb-cd78-2bb3-462e-4ea3cefe122e@arm.com>
 <ca13a4ec-17a6-8e29-e29e-39f9b47e78df@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ca13a4ec-17a6-8e29-e29e-39f9b47e78df@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/22 21:17, Tong Tiangen wrote:
> 
> 
> 在 2022/4/18 17:28, Anshuman Khandual 写道:
>> On 4/18/22 09:14, Tong Tiangen wrote:
>>> From: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>
> [...]
>>>   #endif
>>
>> Ran this series on arm64 platform after enabling
>>
>> - CONFIG_PAGE_TABLE_CHECK
>> - CONFIG_PAGE_TABLE_CHECK_ENFORCED (avoiding kernel command line option)
>>
>> After some time, the following error came up
>>
>> [   23.266013] ------------[ cut here ]------------
>> [   23.266807] kernel BUG at mm/page_table_check.c:90!
>> [   23.267609] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>> [   23.268503] Modules linked in:
>> [   23.269012] CPU: 1 PID: 30 Comm: khugepaged Not tainted 5.18.0-rc3-00004-g60aa8e363a91 #2
>> [   23.270383] Hardware name: linux,dummy-virt (DT)
>> [   23.271210] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [   23.272445] pc : page_table_check_clear.isra.6+0x114/0x148
>> [   23.273429] lr : page_table_check_clear.isra.6+0x64/0x148
>> [   23.274395] sp : ffff80000afb3ca0
>> [   23.274994] x29: ffff80000afb3ca0 x28: fffffc00022558e8 x27: ffff80000a27f628
>> [   23.276260] x26: ffff800009f9f2b0 x25: ffff00008a8d5000 x24: ffff800009f09fa0
>> [   23.277527] x23: 0000ffff89e00000 x22: ffff800009f09fb8 x21: ffff000089414cc0
>> [   23.278798] x20: 0000000000000200 x19: fffffc00022a0000 x18: 0000000000000001
>> [   23.280066] x17: 0000000000000001 x16: 0000000000000000 x15: 0000000000000003
>> [   23.281331] x14: 0000000000000068 x13: 00000000000000c0 x12: 0000000000000010
>> [   23.282602] x11: fffffc0002320008 x10: fffffc0002320000 x9 : ffff800009fa1000
>> [   23.283868] x8 : 00000000ffffffff x7 : 0000000000000001 x6 : ffff800009fa1f08
>> [   23.285135] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
>> [   23.286406] x2 : 00000000ffffffff x1 : ffff000080f2800c x0 : ffff000080f28000
>> [   23.287673] Call trace:
>> [   23.288123]  page_table_check_clear.isra.6+0x114/0x148
>> [   23.289043]  __page_table_check_pmd_clear+0x3c/0x50
>> [   23.289918]  pmdp_collapse_flush+0x114/0x370
>> [   23.290692]  khugepaged+0x1170/0x19e0
>> [   23.291356]  kthread+0x110/0x120
>> [   23.291945]  ret_from_fork+0x10/0x20
>> [   23.292596] Code: 91001041 b8e80024 51000482 36fffd62 (d4210000)
>> [   23.293678] ---[ end trace 0000000000000000 ]---
>> [   23.294511] note: khugepaged[30] exited with preempt_count 2
>>
>> Looking into file mm/page_table_check.c where this problem occured.
>>
>> /*
>>   * An enty is removed from the page table, decrement the counters for that page
>>   * verify that it is of correct type and counters do not become negative.
>>   */
>> static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
>>                                     unsigned long pfn, unsigned long pgcnt)
>> {
>>          struct page_ext *page_ext;
>>          struct page *page;
>>          unsigned long i;
>>          bool anon;
>>
>>          if (!pfn_valid(pfn))
>>                  return;
>>
>>          page = pfn_to_page(pfn);
>>          page_ext = lookup_page_ext(page);
>>          anon = PageAnon(page);
>>
>>          for (i = 0; i < pgcnt; i++) {
>>                  struct page_table_check *ptc = get_page_table_check(page_ext);
>>
>>                  if (anon) {
>>                          BUG_ON(atomic_read(&ptc->file_map_count));
>>                          BUG_ON(atomic_dec_return(&ptc->anon_map_count) < 0);
>>                  } else {
>>                          BUG_ON(atomic_read(&ptc->anon_map_count));
>>   Triggered here ====>>  BUG_ON(atomic_dec_return(&ptc->file_map_count) < 0);
>>                  }
>>                  page_ext = page_ext_next(page_ext);
>>          }
>> }
>>
>> Could you explain what was expected during pmdp_collapse_flush() which when
>> failed, triggered this BUG_ON() ? This counter seems to be page table check
>> specific, could it just go wrong ? I have not looked into the details about
>> page table check mechanism.
>>
>> - Anshuman
>> .
> 
> Hi Anshuman:
> 
> Thanks for your job.
> 
> Let me briefly explain the principle of page table check(PTC).
> 
> PTC introduces the following struct for page mapping type count:
> struct page_table_check {
>         atomic_t anon_map_count;
>         atomic_t file_map_count;
> };
> This structure can be obtained by "lookup_page_ext(page)"


Right.

> 
> When page table entries are set(pud/pmd/pte), page_table_check_set()  is called to increase the page mapping count, Also check for errors (eg:if a page is used for anonymous mapping, then the page cannot be used for file mapping at the same time).
> 
> When page table entries are clear(pud/pmd/pte), page_table_check_clear()  is called to decrease the page mapping count, Also check for errors.
> 
> The error check rules are described in the following documents: Documentation/vm/page_table_check.rst

Snippet from that document.

+-------------------+-------------------+-------------------+------------------+
| Current Mapping   | New mapping       | Permissions       | Rule             |
+===================+===================+===================+==================+
| Anonymous         | Anonymous         | Read              | Allow            |
+-------------------+-------------------+-------------------+------------------+
| Anonymous         | Anonymous         | Read / Write      | Prohibit         |
+-------------------+-------------------+-------------------+------------------+
| Anonymous         | Named             | Any               | Prohibit         |
+-------------------+-------------------+-------------------+------------------+
| Named             | Anonymous         | Any               | Prohibit         |
+-------------------+-------------------+-------------------+------------------+
| Named             | Named             | Any               | Allow            |
+-------------------+-------------------+-------------------+------------------+

Does 'Named' refer to file mapping ? Also what does 'Prohibit' imply here ? The
check will call out a BUG_ON() in such cases ?

page_table_check_clear()
{

                if (anon) {
                        BUG_ON(atomic_read(&ptc->file_map_count));
                        BUG_ON(atomic_dec_return(&ptc->anon_map_count) < 0);
                } else {
                        BUG_ON(atomic_read(&ptc->anon_map_count));
                        BUG_ON(atomic_dec_return(&ptc->file_map_count) < 0);
                }
}

So in the clear path, there are two checks

- If the current mapping is Anon, file_map_count cannot be positive and other way
- Decrement the applicable counter ensuring that it does not turn negative

page_table_check_set()
{
                if (anon) {
                        BUG_ON(atomic_read(&ptc->file_map_count));
                        BUG_ON(atomic_inc_return(&ptc->anon_map_count) > 1 && rw);
                } else {
                        BUG_ON(atomic_read(&ptc->anon_map_count));
                        BUG_ON(atomic_inc_return(&ptc->file_map_count) < 0);
                }
}

So in the set path, there are two checks

- If the current mapping is anon, file_map_count cannot be positive and other way
- Anon mapping cannot be RW if the page has been mapped more than once
- But then why check for negative values for file_map_count after increment ?

Is there any other checks, which this test ensures, that I might be missing ?

> 
> The setting and clearing of page table entries are symmetrical.

This assumption should be true for any user accessible mapping, for this test to work ?

Also why PUD_PAGE_SIZE/PMD_PAGE_SIZE are being used here instead of directly using
generic macros such as PUD_SIZE/PMD_SIZE ? Is there a specific reason ?

> 
> Here __page_table_check_pmd_clear() trigger BUGON which indicates that the pmd entry file mapping count has become negative.
> 
> I guess if PTC didn't detect this exception, would there have been any problems?

I am looking into this, not sure for now.
