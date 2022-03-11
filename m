Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916BD4D5ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344709AbiCKJxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241572AbiCKJxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:53:04 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07D191B9899
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:52:00 -0800 (PST)
Received: from [10.20.42.25] (unknown [10.20.42.25])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxLxO6GytiK0YHAA--.3026S3;
        Fri, 11 Mar 2022 17:51:54 +0800 (CST)
Subject: Re: [PATCH] mm/khugepaged: sched to numa node when collapse huge page
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220311090119.2412738-1-maobibo@loongson.cn>
 <52412f08-829a-6c29-60c6-a24c866e6253@redhat.com>
From:   maobibo <maobibo@loongson.cn>
Message-ID: <d2883450-1278-877e-e273-bda5a5728465@loongson.cn>
Date:   Fri, 11 Mar 2022 17:51:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <52412f08-829a-6c29-60c6-a24c866e6253@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxLxO6GytiK0YHAA--.3026S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw15Gr45Zry7CFyrWr45ZFb_yoW5Jw47pF
        Wkta15GFWUJryvkw1Iqwn8AryFqr1ktrWDK3WfJaykKr98Xr10gryUZa15ua48ArWkJF47
        ArWjvrn09r40q3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
        twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07
        bOoGdUUUUU=
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/11/2022 05:20 PM, David Hildenbrand wrote:
> On 11.03.22 10:01, Bibo Mao wrote:
>> collapse huge page is slow, specially when khugepaged daemon runs
>> on different numa node with that of huge page. It suffers from
>> huge page copying across nodes, also cache is not used for target
>> node. With this patch, khugepaged daemon switches to the same numa
>> node with huge page. It saves copying time and makes use of local
>> cache better.
> 
> Hi,
> 
> just the usual question, do you have any performance numbers to back
> your claims (e.g., "is slow, specially when") and proof that this patch
> does the trick?
With specint 2006 on loongarch 3C5000L 32core numa system, it improves
about 6%. The page size is 16K and pmd page size is 32M, memory performance
across numa node is obvious different. However I do not test it on x86 box.


> 
> 
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>  mm/khugepaged.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 131492fd1148..460c285dc974 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -116,6 +116,7 @@ struct khugepaged_scan {
>>  	struct list_head mm_head;
>>  	struct mm_slot *mm_slot;
>>  	unsigned long address;
>> +	int node;
>>  };
>>  
>>  static struct khugepaged_scan khugepaged_scan = {
>> @@ -1066,6 +1067,7 @@ static void collapse_huge_page(struct mm_struct *mm,
>>  	struct vm_area_struct *vma;
>>  	struct mmu_notifier_range range;
>>  	gfp_t gfp;
>> +	const struct cpumask *cpumask;
> 
> We tend to stick to reverse Christmas tree format as good as possible.
> 
>>  
>>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>>  
>> @@ -1079,6 +1081,13 @@ static void collapse_huge_page(struct mm_struct *mm,
>>  	 * that. We will recheck the vma after taking it again in write mode.
>>  	 */
>>  	mmap_read_unlock(mm);
>> +
>> +	/* sched to specified node before huage page memory copy */
> 
> s/huage/huge/
> 
>> +	cpumask = cpumask_of_node(node);
>> +	if ((khugepaged_scan.node != node) && !cpumask_empty(cpumask)) {
>> +		set_cpus_allowed_ptr(current, cpumask);
>> +		khugepaged_scan.node = node;
>> +	}
>>  	new_page = khugepaged_alloc_page(hpage, gfp, node);
>>  	if (!new_page) {
>>  		result = SCAN_ALLOC_HUGE_PAGE_FAIL;
>> @@ -2380,6 +2389,7 @@ int start_stop_khugepaged(void)
>>  		kthread_stop(khugepaged_thread);
>>  		khugepaged_thread = NULL;
>>  	}
>> +	khugepaged_scan.node = NUMA_NO_NODE;
>>  	set_recommended_min_free_kbytes();
>>  fail:
>>  	mutex_unlock(&khugepaged_mutex);
> 
> 

