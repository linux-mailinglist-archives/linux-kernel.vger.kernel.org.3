Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D815004BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 05:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbiDNDpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 23:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbiDNDph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:45:37 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AED165B4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 20:43:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VA0LwpP_1649907790;
Received: from 30.225.28.199(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VA0LwpP_1649907790)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Apr 2022 11:43:11 +0800
Message-ID: <9e5758e2-c9a7-2253-ee69-9979ae31afdd@linux.alibaba.com>
Date:   Thu, 14 Apr 2022 11:43:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH RFC v1] arm64: mm: change mem_map to use block/section
 mapping with crashkernel
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com
References: <1649754476-8713-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <YlcAEo3lpKJg8HJf@arm.com>
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <YlcAEo3lpKJg8HJf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your response!

在 2022/4/14 0:53, Catalin Marinas 写道:
> On Tue, Apr 12, 2022 at 05:07:56PM +0800, Guanghui Feng wrote:
>> There are many changes and discussions:
>> commit 031495635b46
>> commit 1a8e1cef7603
>> commit 8424ecdde7df
>> commit 0a30c53573b0
>> commit 2687275a5843
>>
>> When using DMA/DMA32 zone and crashkernel, disable rodata full and kfence,
>> mem_map will use non block/section mapping(for crashkernel requires to shrink
>> the region in page granularity). But it will degrade performance when doing
>> larging continuous mem access in kernel(memcpy/memmove, etc).
>>
>> This patch firstly do block/section mapping at mem_map, reserve crashkernel
>> memory. And then walking pagetable to split block/section mapping
>> to non block/section mapping [only] for crashkernel mem. We will accelerate
>> mem access about 10-20% performance improvement, and reduce the cpu dTLB miss
>> conspicuously on some platform with this optimization.
> Do you actually have some real world use-cases where this improvement
> matters? I don't deny that large memcpy over the kernel linear map may
> be slightly faster but where does this really matter?
When doing fio test, there may be about 10-20% performance gap.
The test method:
1.prepare env with shell script

set -x
modprobe -r brd
modprobe brd rd_nr=1 rd_size=134217728
dmsetup remove_all
wipefs -a --force /dev/ram0
mkfs -t ext4 -E lazy_itable_init=0,lazy_journal_init=0 -q -F /dev/ram0
mkdir -p /fs/ram0
mount -t ext4 /dev/ram0 /fs/ram0
#sed -i s/scan_lvs = 1/scan_lvs = 1/ /etc/lvm/lvm.conf

2.prepare fio env with setting file in [x.fio]:

[global]
bs=4k
ioengine=psync
iodepth=128
size=8G
direct=1
runtime=30
invalidate=1
#fallocate=native
group_reporting
thread=1
time_based=1
rw=read
directory=/fs/ram0
#filename=/dev/ram0
numjobs=1

[task_0]
cpus_allowed=16
stonewall=1

3.running fio testcase:
sudo fio x.fio
-----------------------------------------------------
At the same time, I have test memcpy in the double envs
(block/section mapping + non block/section mapping):
1.alloc many continuous pages(src/dst: 10000 * 2^10 bytes): 
alloc_pages(GFP_KERNEL, 10)
2.memcpy for src to dst

>> +static void init_crashkernel_pmd(pud_t *pudp, unsigned long addr,
>> +				 unsigned long end, phys_addr_t phys,
>> +				 pgprot_t prot,
>> +				 phys_addr_t (*pgtable_alloc)(int), int flags)
>> +{
>> +	phys_addr_t map_offset;
>> +	unsigned long next;
>> +	pmd_t *pmdp;
>> +	pmdval_t pmdval;
>> +
>> +	pmdp = pmd_offset(pudp, addr);
>> +	do {
>> +		next = pmd_addr_end(addr, end);
>> +		if (!pmd_none(*pmdp) && pmd_sect(*pmdp)) {
>> +			phys_addr_t pte_phys = pgtable_alloc(PAGE_SHIFT);
>> +			pmd_clear(pmdp);
>> +			pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN;
>> +			if (flags & NO_EXEC_MAPPINGS)
>> +				pmdval |= PMD_TABLE_PXN;
>> +			__pmd_populate(pmdp, pte_phys, pmdval);
>> +			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> The architecture requires us to do a break-before-make here, so
> pmd_clear(), TLBI, __pmd_populate() - in this order. And that's where it
> gets tricky, if the kernel happens to access this pmd range while it is
> unmapped, you'd get a translation fault.
OK, Thanks.

+			if (map_offset)
+			    alloc_init_cont_pte(pmdp, addr & PMD_MASK, addr,
+						phys - map_offset, prot,
+						pgtable_alloc, flags);
+

+
+			map_offset = addr - (addr & PUD_MASK);
+			if (map_offset)
+			    alloc_init_cont_pmd(pudp, addr & PUD_MASK, addr,
+						phys - map_offset, prot,
+						pgtable_alloc, flags);
+

Sorry，There is a defect. When rebuilding normal pmd/pte(out of crashkernel mem),
the flags should strip NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS on some scenes:
!(can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE)).
So we will use as many as possible block/section mapping.

