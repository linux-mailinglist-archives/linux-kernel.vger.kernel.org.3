Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2CB4D78F4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 01:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiCNArf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 20:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiCNArb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 20:47:31 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B11954AE38
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 17:46:21 -0700 (PDT)
Received: from [10.20.42.25] (unknown [10.20.42.25])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxDxNbkC5iYgkJAA--.5546S3;
        Mon, 14 Mar 2022 08:46:19 +0800 (CST)
Subject: Re: [PATCH] mm/khugepaged: sched to numa node when collapse huge page
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220311090119.2412738-1-maobibo@loongson.cn>
 <CAHbLzkoiP+uRYGDm+FC_zg-LkPbTMFQ-wSzGMh0RPr-XP4_ciw@mail.gmail.com>
From:   maobibo <maobibo@loongson.cn>
Message-ID: <2b8b8349-d0fe-7a86-1591-21a7684a0f45@loongson.cn>
Date:   Mon, 14 Mar 2022 08:46:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHbLzkoiP+uRYGDm+FC_zg-LkPbTMFQ-wSzGMh0RPr-XP4_ciw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxDxNbkC5iYgkJAA--.5546S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw15Gr45ZryfJr4UXr17GFg_yoW5KFy7pF
        W8ta15GFWDJrykGw1Iq3Z8AryFqrykJrWkKw1rXayvkas8Xr1vgFyUuw45Z34UArWDGr47
        ArWjvrnY9F4jq3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU5PpnJUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

thanks for reviewing my patch. I reply inline.

On 03/12/2022 03:08 AM, Yang Shi wrote:
> On Fri, Mar 11, 2022 at 1:01 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> collapse huge page is slow, specially when khugepaged daemon runs
>> on different numa node with that of huge page. It suffers from
>> huge page copying across nodes, also cache is not used for target
>> node. With this patch, khugepaged daemon switches to the same numa
>> node with huge page. It saves copying time and makes use of local
>> cache better.
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
>>         struct list_head mm_head;
>>         struct mm_slot *mm_slot;
>>         unsigned long address;
>> +       int node;
>>  };
>>
>>  static struct khugepaged_scan khugepaged_scan = {
>> @@ -1066,6 +1067,7 @@ static void collapse_huge_page(struct mm_struct *mm,
>>         struct vm_area_struct *vma;
>>         struct mmu_notifier_range range;
>>         gfp_t gfp;
>> +       const struct cpumask *cpumask;
>>
>>         VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>>
>> @@ -1079,6 +1081,13 @@ static void collapse_huge_page(struct mm_struct *mm,
>>          * that. We will recheck the vma after taking it again in write mode.
>>          */
>>         mmap_read_unlock(mm);
>> +
>> +       /* sched to specified node before huage page memory copy */
>> +       cpumask = cpumask_of_node(node);
>> +       if ((khugepaged_scan.node != node) && !cpumask_empty(cpumask)) {
>> +               set_cpus_allowed_ptr(current, cpumask);
>> +               khugepaged_scan.node = node;
> 
> What if khugepaged was scheduled to the other nodes after this, but
> khugepaged_scan.node still equals to node? It seems possible to me
> IIUC.
khugepaged will not schedule to the other nodes after function 
set_cpus_allowed_ptr with my understanding. Or node is not necessary
to record and we can simply use task_node(current) like this:
 +       /* sched to specified node before huage page memory copy */
 +       cpumask = cpumask_of_node(node);
 +       if ((task_node(current) != node) && !cpumask_empty(cpumask))
 +               set_cpus_allowed_ptr(current, cpumask);
 
> 
> TBH I'm not quite sure if migrating khugepaged is really worth it for
> everyone or not. The worst case is the locality of base pages are not
> obvious, for example, the base pages may be across all nodes, so you
> always get cross nodes memory copy. And khugepaged may get slower if
> cpu is contentious.
target node is calculated from src node of base pages. If base pages
are across all nodes, target node is the most one from that of base pages.
Most time if THP is used, memory footprint for workload is large, it
is deserved for other architectures, however I have no such binary workload
on other architectures.

> 
> In addition, I saw MIPS has its own copy_user_highpage(), is it a
> contributing factor too?
copy_user_highpage is similar with function copy on mips64, it is only
different on mips32. It has nothing to do with this, else it will be big
issue.

regards
bibo,mao

> 
>> +       }
>>         new_page = khugepaged_alloc_page(hpage, gfp, node);
>>         if (!new_page) {
>>                 result = SCAN_ALLOC_HUGE_PAGE_FAIL;
>> @@ -2380,6 +2389,7 @@ int start_stop_khugepaged(void)
>>                 kthread_stop(khugepaged_thread);
>>                 khugepaged_thread = NULL;
>>         }
>> +       khugepaged_scan.node = NUMA_NO_NODE;
>>         set_recommended_min_free_kbytes();
>>  fail:
>>         mutex_unlock(&khugepaged_mutex);
>> --
>> 2.31.1
>>
>>

