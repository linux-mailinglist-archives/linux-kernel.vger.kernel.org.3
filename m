Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5735867D8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiHAKx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiHAKxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:53:23 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D73729803
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 03:53:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VL5xOVg_1659351196;
Received: from 30.240.98.221(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VL5xOVg_1659351196)
          by smtp.aliyun-inc.com;
          Mon, 01 Aug 2022 18:53:18 +0800
Message-ID: <53793484-07a4-edab-652d-06e5e28521d8@linux.alibaba.com>
Date:   Mon, 1 Aug 2022 18:53:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [RFC V3 PATCH] mm: add last level page table numa info to
 /proc/pid/numa_pgtable
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, willy@infradead.org
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220801032704.64356-1-xhao@linux.alibaba.com>
 <f4f9c5be-a5ce-9e82-56ff-89d1aeee4d98@linux.alibaba.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <f4f9c5be-a5ce-9e82-56ff-89d1aeee4d98@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/1 下午2:06, Baolin Wang 写道:
> Hi Xin,
>
> On 8/1/2022 11:27 AM, Xin Hao wrote:
>> In many data center servers, the shared memory architectures is
>> Non-Uniform Memory Access (NUMA), remote numa node data access
>> often brings a high latency problem, but what we are easy to ignore
>> is that the page table remote numa access, It can also leads to a
>> performance degradation.
>>
>> So there add a new interface in /proc, This will help developers to
>> get more info about performance issues if they are caused by cross-NUMA.
>>
>> V2 -> V3
>> 1, Fix compile warning bug.
>>
>> V1 -> V2
>> 1, As Matthew Wilcox advise, Simplify the code.
>> 2, Do some codes format fix.
>
> Please move the changes history under your 'Signed-off-by' with '---'.
>
>>
>> V2: 
>> https://lore.kernel.org/linux-mm/20220731155223.60238-1-xhao@linux.alibaba.com/
>> V1: 
>> https://lore.kernel.org/linux-mm/YuVqdcY8Ibib2LJa@casper.infradead.org/T/
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   fs/proc/base.c     |  2 ++
>>   fs/proc/internal.h |  1 +
>>   fs/proc/task_mmu.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 90 insertions(+)
>>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index 8dfa36a99c74..487e82dd3275 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -3224,6 +3224,7 @@ static const struct pid_entry tgid_base_stuff[] 
>> = {
>>       REG("maps",       S_IRUGO, proc_pid_maps_operations),
>>   #ifdef CONFIG_NUMA
>>       REG("numa_maps",  S_IRUGO, proc_pid_numa_maps_operations),
>> +    REG("numa_pgtable", S_IRUGO, proc_pid_numa_pgtable_operations),
>>   #endif
>>       REG("mem",        S_IRUSR|S_IWUSR, proc_mem_operations),
>>       LNK("cwd",        proc_cwd_link),
>> @@ -3571,6 +3572,7 @@ static const struct pid_entry tid_base_stuff[] = {
>>   #endif
>>   #ifdef CONFIG_NUMA
>>       REG("numa_maps", S_IRUGO, proc_pid_numa_maps_operations),
>> +    REG("numa_pgtable", S_IRUGO, proc_pid_numa_pgtable_operations),
>>   #endif
>>       REG("mem",       S_IRUSR|S_IWUSR, proc_mem_operations),
>>       LNK("cwd",       proc_cwd_link),
>> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
>> index 06a80f78433d..e7ed9ef097b6 100644
>> --- a/fs/proc/internal.h
>> +++ b/fs/proc/internal.h
>> @@ -296,6 +296,7 @@ struct mm_struct *proc_mem_open(struct inode 
>> *inode, unsigned int mode);
>>
>>   extern const struct file_operations proc_pid_maps_operations;
>>   extern const struct file_operations proc_pid_numa_maps_operations;
>> +extern const struct file_operations proc_pid_numa_pgtable_operations;
>>   extern const struct file_operations proc_pid_smaps_operations;
>>   extern const struct file_operations proc_pid_smaps_rollup_operations;
>>   extern const struct file_operations proc_clear_refs_operations;
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 2d04e3470d4c..77b7a49757f5 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -1999,4 +1999,91 @@ const struct file_operations 
>> proc_pid_numa_maps_operations = {
>>       .release    = proc_map_release,
>>   };
>>
>> +struct pgtable_numa_private {
>> +    struct proc_maps_private proc_maps;
>> +    unsigned long node[MAX_NUMNODES];
>> +};
>> +
>> +static int gather_pgtable_numa_stats(pmd_t *pmd, unsigned long addr,
>> +                     unsigned long end, struct mm_walk *walk)
>> +{
>> +    struct pgtable_numa_private *priv = walk->private;
>> +    struct page *page;
>> +    int nid;
>> +
>> +    if (pmd_huge(*pmd)) {
>> +        page = virt_to_page(pmd);
>> +    } else {
>> +        page = pmd_page(*pmd);
>
> You should validate if the pmd is valid or present before getting the 
> pagetable page.
>
> if (pmd_none(*pmd) || !pmd_present(*pmd))
>
> Another issue is I think you should hold the pmd lock to call 
> pmd_page(), since after the validation of pmd_huge(), the pmd entry 
> can be modified by other threads if you did not hold the pmd lock.
>
Thanks, Baolin, i will fix it in the next version.
>> +    }
>> +
>> +    nid = page_to_nid(page);
>> +    priv->node[nid]++;
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct mm_walk_ops show_numa_pgtable_ops = {
>> +    .pmd_entry = gather_pgtable_numa_stats,
>> +};
>> +
>> +/*
>> + * Display the page talbe allocated per node via /proc.
>> + */
>> +static int show_numa_pgtable(struct seq_file *m, void *v)
>> +{
>> +    struct pgtable_numa_private *numa_priv = m->private;
>> +    struct vm_area_struct *vma = v;
>> +    struct mm_struct *mm = vma->vm_mm;
>> +    struct file *file = vma->vm_file;
>> +    int nid;
>> +
>> +    if (!mm)
>> +        return 0;
>> +
>> +    memset(numa_priv->node, 0, sizeof(numa_priv->node));
>> +
>> +    seq_printf(m, "%08lx ", vma->vm_start);
>> +
>> +    if (file) {
>> +        seq_puts(m, " file=");
>> +        seq_file_path(m, file, "\n\t= ");
>> +    } else if (vma->vm_start <= mm->brk && vma->vm_end >= 
>> mm->start_brk) {
>> +        seq_puts(m, " heap");
>> +    } else if (is_stack(vma)) {
>> +        seq_puts(m, " stack");
>> +    }
>> +
>> +    /* mmap_lock is held by m_start */
>> +    walk_page_vma(vma, &show_numa_pgtable_ops, numa_priv);
>> +
>> +    for_each_node_state(nid, N_MEMORY) {
>> +        if (numa_priv->node[nid])
>> +            seq_printf(m, " N%d=%lu", nid, numa_priv->node[nid]);
>> +    }
>> +    seq_putc(m, '\n');
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct seq_operations proc_pid_numa_pgtable_op = {
>> +    .start  = m_start,
>> +    .next   = m_next,
>> +    .stop   = m_stop,
>> +    .show   = show_numa_pgtable,
>> +};
>> +
>> +static int pid_numa_pgtable_open(struct inode *inode, struct file 
>> *file)
>> +{
>> +    return proc_maps_open(inode, file, &proc_pid_numa_pgtable_op,
>> +            sizeof(struct pgtable_numa_private));
>> +}
>> +
>> +const struct file_operations proc_pid_numa_pgtable_operations = {
>> +    .open        = pid_numa_pgtable_open,
>> +    .read        = seq_read,
>> +    .llseek        = seq_lseek,
>> +    .release    = proc_map_release,
>> +};
>> +
>>   #endif /* CONFIG_NUMA */
>> -- 
>> 2.31.0
