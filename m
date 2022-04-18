Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B906505C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346037AbiDRP5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345981AbiDRP5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:57:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD57B381B2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:47:38 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Khrq65jkxzFq1Y;
        Mon, 18 Apr 2022 23:45:06 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 23:47:36 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 23:47:34 +0800
Message-ID: <ca13a4ec-17a6-8e29-e29e-39f9b47e78df@huawei.com>
Date:   Mon, 18 Apr 2022 23:47:34 +0800
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
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <1c314feb-cd78-2bb3-462e-4ea3cefe122e@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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



在 2022/4/18 17:28, Anshuman Khandual 写道:
> On 4/18/22 09:14, Tong Tiangen wrote:
>> From: Kefeng Wang <wangkefeng.wang@huawei.com>
>>
[...]
>>   #endif
> 
> Ran this series on arm64 platform after enabling
> 
> - CONFIG_PAGE_TABLE_CHECK
> - CONFIG_PAGE_TABLE_CHECK_ENFORCED (avoiding kernel command line option)
> 
> After some time, the following error came up
> 
> [   23.266013] ------------[ cut here ]------------
> [   23.266807] kernel BUG at mm/page_table_check.c:90!
> [   23.267609] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [   23.268503] Modules linked in:
> [   23.269012] CPU: 1 PID: 30 Comm: khugepaged Not tainted 5.18.0-rc3-00004-g60aa8e363a91 #2
> [   23.270383] Hardware name: linux,dummy-virt (DT)
> [   23.271210] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   23.272445] pc : page_table_check_clear.isra.6+0x114/0x148
> [   23.273429] lr : page_table_check_clear.isra.6+0x64/0x148
> [   23.274395] sp : ffff80000afb3ca0
> [   23.274994] x29: ffff80000afb3ca0 x28: fffffc00022558e8 x27: ffff80000a27f628
> [   23.276260] x26: ffff800009f9f2b0 x25: ffff00008a8d5000 x24: ffff800009f09fa0
> [   23.277527] x23: 0000ffff89e00000 x22: ffff800009f09fb8 x21: ffff000089414cc0
> [   23.278798] x20: 0000000000000200 x19: fffffc00022a0000 x18: 0000000000000001
> [   23.280066] x17: 0000000000000001 x16: 0000000000000000 x15: 0000000000000003
> [   23.281331] x14: 0000000000000068 x13: 00000000000000c0 x12: 0000000000000010
> [   23.282602] x11: fffffc0002320008 x10: fffffc0002320000 x9 : ffff800009fa1000
> [   23.283868] x8 : 00000000ffffffff x7 : 0000000000000001 x6 : ffff800009fa1f08
> [   23.285135] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [   23.286406] x2 : 00000000ffffffff x1 : ffff000080f2800c x0 : ffff000080f28000
> [   23.287673] Call trace:
> [   23.288123]  page_table_check_clear.isra.6+0x114/0x148
> [   23.289043]  __page_table_check_pmd_clear+0x3c/0x50
> [   23.289918]  pmdp_collapse_flush+0x114/0x370
> [   23.290692]  khugepaged+0x1170/0x19e0
> [   23.291356]  kthread+0x110/0x120
> [   23.291945]  ret_from_fork+0x10/0x20
> [   23.292596] Code: 91001041 b8e80024 51000482 36fffd62 (d4210000)
> [   23.293678] ---[ end trace 0000000000000000 ]---
> [   23.294511] note: khugepaged[30] exited with preempt_count 2
> 
> Looking into file mm/page_table_check.c where this problem occured.
> 
> /*
>   * An enty is removed from the page table, decrement the counters for that page
>   * verify that it is of correct type and counters do not become negative.
>   */
> static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
>                                     unsigned long pfn, unsigned long pgcnt)
> {
>          struct page_ext *page_ext;
>          struct page *page;
>          unsigned long i;
>          bool anon;
> 
>          if (!pfn_valid(pfn))
>                  return;
> 
>          page = pfn_to_page(pfn);
>          page_ext = lookup_page_ext(page);
>          anon = PageAnon(page);
> 
>          for (i = 0; i < pgcnt; i++) {
>                  struct page_table_check *ptc = get_page_table_check(page_ext);
> 
>                  if (anon) {
>                          BUG_ON(atomic_read(&ptc->file_map_count));
>                          BUG_ON(atomic_dec_return(&ptc->anon_map_count) < 0);
>                  } else {
>                          BUG_ON(atomic_read(&ptc->anon_map_count));
>   Triggered here ====>>  BUG_ON(atomic_dec_return(&ptc->file_map_count) < 0);
>                  }
>                  page_ext = page_ext_next(page_ext);
>          }
> }
> 
> Could you explain what was expected during pmdp_collapse_flush() which when
> failed, triggered this BUG_ON() ? This counter seems to be page table check
> specific, could it just go wrong ? I have not looked into the details about
> page table check mechanism.
> 
> - Anshuman
> .

Hi Anshuman:

Thanks for your job.

Let me briefly explain the principle of page table check(PTC).

PTC introduces the following struct for page mapping type count:
struct page_table_check {
         atomic_t anon_map_count;
         atomic_t file_map_count;
};
This structure can be obtained by "lookup_page_ext(page)"

When page table entries are set(pud/pmd/pte), page_table_check_set()  is 
called to increase the page mapping count, Also check for errors (eg:if 
a page is used for anonymous mapping, then the page cannot be used for 
file mapping at the same time).

When page table entries are clear(pud/pmd/pte), page_table_check_clear() 
  is called to decrease the page mapping count, Also check for errors.

The error check rules are described in the following documents: 
Documentation/vm/page_table_check.rst

The setting and clearing of page table entries are symmetrical.

Here __page_table_check_pmd_clear() trigger BUGON which indicates that 
the pmd entry file mapping count has become negative.

I guess if PTC didn't detect this exception, would there have been any 
problems?

Thanks,
Tong.
