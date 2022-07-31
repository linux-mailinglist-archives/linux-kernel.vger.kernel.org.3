Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB3E585F36
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 16:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiGaOLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 10:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGaOLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 10:11:35 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2355CDFCA
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 07:11:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VKwb5pz_1659276688;
Received: from 30.30.99.227(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VKwb5pz_1659276688)
          by smtp.aliyun-inc.com;
          Sun, 31 Jul 2022 22:11:29 +0800
Message-ID: <7a4d0960-c985-2b5f-bb5d-492542f9f087@linux.alibaba.com>
Date:   Sun, 31 Jul 2022 22:11:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [RFC PATCH] mm: add last level page table numa info to
 /proc/pid/numa_pgtable
To:     Matthew Wilcox <willy@infradead.org>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, xhao@linux.alibaba.com
References: <20220730163528.48377-1-xhao@linux.alibaba.com>
 <YuVqdcY8Ibib2LJa@casper.infradead.org>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <YuVqdcY8Ibib2LJa@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/7/31 上午1:29, Matthew Wilcox 写道:
> On Sun, Jul 31, 2022 at 12:35:28AM +0800, Xin Hao wrote:
>> In many data center servers, the shared memory architectures is
>> Non-Uniform Memory Access (NUMA), remote numa node data access
>> often brings a high latency problem, but what we are easy to ignore
>> is that the page table remote numa access, It can also leads to a
>> performance degradation.
>>
>> So there add a new interface in /proc, This will help developers to
>> get more info about performance issues if they are caused by cross-NUMA.
> Interesting.  The implementation seems rather more complex than
> necessary though.
>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 2d04e3470d4c..a51befb47ea8 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -1999,4 +1999,133 @@ const struct file_operations proc_pid_numa_maps_operations = {
>>   	.release	= proc_map_release,
>>   };
>>
>> +struct pgtable_numa_maps {
>> +	unsigned long node[MAX_NUMNODES];
>> +};
>> +
>> +struct pgtable_numa_private {
>> +	struct proc_maps_private proc_maps;
>> +	struct pgtable_numa_maps md;
>> +};
> struct pgtable_numa_private {
> 	struct proc_maps_private proc_maps;
> 	unsigned long node[MAX_NUMNODES];
> };
>
>> +static void gather_pgtable_stats(struct page *page, struct pgtable_numa_maps *md)
>> +{
>> +	md->node[page_to_nid(page)] += 1;
>> +}
>> +
>> +static struct page *can_gather_pgtable_numa_stats(pmd_t pmd, struct vm_area_struct *vma,
>> +		unsigned long addr)
>> +{
>> +	struct page *page;
>> +	int nid;
>> +
>> +	if (!pmd_present(pmd))
>> +		return NULL;
>> +
>> +	if (pmd_huge(pmd))
>> +		return NULL;
>> +
>> +	page = pmd_page(pmd);
>> +	nid = page_to_nid(page);
>> +	if (!node_isset(nid, node_states[N_MEMORY]))
>> +		return NULL;
>> +
>> +	return page;
>> +}
>> +
>> +static int gather_pgtable_numa_stats(pmd_t *pmd, unsigned long addr,
>> +		unsigned long end, struct mm_walk *walk)
>> +{
>> +	struct pgtable_numa_maps *md = walk->private;
>> +	struct vm_area_struct *vma = walk->vma;
>> +	struct page *page;
>> +
>> +	if (pmd_huge(*pmd)) {
>> +		struct page *pmd_page;
>> +
>> +		pmd_page = virt_to_page(pmd);
>> +		if (!pmd_page)
>> +			return 0;
>> +
>> +		if (!node_isset(page_to_nid(pmd_page), node_states[N_MEMORY]))
>> +			return 0;
>> +
>> +		gather_pgtable_stats(pmd_page, md);
>> +		goto out;
>> +	}
>> +
>> +	page = can_gather_pgtable_numa_stats(*pmd, vma, addr);
>> +	if (!page)
>> +		return 0;
>> +
>> +	gather_pgtable_stats(page, md);
>> +
>> +out:
>> +	cond_resched();
>> +	return 0;
>> +}
> static int gather_pgtable_numa_stats(pmd_t *pmd, unsigned long addr,
> 		unsigned long end, struct mm_walk *walk)
> {
> 	struct pgtable_numa_private *priv = walk->private;
> 	struct vm_area_struct *vma = walk->vma;
> 	struct page *page;
> 	int nid;
>
> 	if (pmd_huge(*pmd)) {
> 		page = virt_to_page(pmd);
> 	} else {
> 		page = pmd_page(*pmd);
> 	}
>
> 	nid = page_to_nid(page);
> 	priv->node[nid]++;
>
> 	return 0;
> }
Oh,  Thank you for reviewing the code, i will fix it in the next version.
