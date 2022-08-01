Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF79586BF2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiHAN22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiHAN2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDFA73C179
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659360499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9HeT4J2pwN84U0RWrWPAlfTJpr5y0EVb+TVvboAarr4=;
        b=hCamkqLDwQbEplQglLNvN1DCXzTN+LUTuS6g0m7/0c5RHQi1Yi3GAcKqBum2yik38SNJRO
        1gaNaD20hS+tQ8dLZOfI0oJdIM7+oIgw0rcz8Q6clEQd07gw8AzFmIJjfVQI6cgCow4hOy
        oX1r3inix1Pf6GEi5Nf4AkxINYC3NPE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-wfcs6X_eM6-4CKH-UlyKHg-1; Mon, 01 Aug 2022 09:28:18 -0400
X-MC-Unique: wfcs6X_eM6-4CKH-UlyKHg-1
Received: by mail-wm1-f69.google.com with SMTP id x17-20020a05600c21d100b003a32dda6577so1533708wmj.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 06:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=9HeT4J2pwN84U0RWrWPAlfTJpr5y0EVb+TVvboAarr4=;
        b=DFQ67wkZTuvmPMW4wbRoq+hdpjOhDMP2P5G0k5ym9POyhyd77ghTjlfMfofYrg89nk
         KiEN6xV9BzaHtbGTYRrA7nNd3aiN38VweiNvWoUKZ90rMvczun1YiVvPDjXBfFXzQPod
         4xs98qPm616HgSRIljTsH+nIIYQUWdVwjJh5wnE/yvVP6H7M6D1rnWylmM7VP35oXY68
         xf5Sey297G9T7/goxZWbVzC3nOLHlHpf7yXHVcieXzzzBJRVSQxk0Nmuf27Jql4+TV1S
         5+7osrAUxUJhblPhkpdZHCZ2qbq98Fu10p96sRZ7dJuUGSzZ5ud+KNmQl/Q2IZe+pHTC
         xQMA==
X-Gm-Message-State: ACgBeo10QdgelXmS17tUG0sNEWXboUFf/0VY4HrbQJHv5ZTk8ASqLiKD
        4kdwNCxe5H9IDpB2EmAZJUsLvPODk0+BGumOnfBN04+7DpmbpZ+4r0XjpS0Q1lcOUz++/if56YO
        KR4c8sJ1SYQPlDjaZpJjZWjoH
X-Received: by 2002:adf:e881:0:b0:21f:abb:fc0a with SMTP id d1-20020adfe881000000b0021f0abbfc0amr9692044wrm.103.1659360497231;
        Mon, 01 Aug 2022 06:28:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7UYK7ZDuMNgtMyeC5Mwc+2jyxv+KxRym0qux7n9+Y6OT4H9DgkvxuzUxC/BH0QrzhH/lRuFA==
X-Received: by 2002:adf:e881:0:b0:21f:abb:fc0a with SMTP id d1-20020adfe881000000b0021f0abbfc0amr9692021wrm.103.1659360496952;
        Mon, 01 Aug 2022 06:28:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6900:6d08:8df1:dd2c:bf00? (p200300cbc70469006d088df1dd2cbf00.dip0.t-ipconnect.de. [2003:cb:c704:6900:6d08:8df1:dd2c:bf00])
        by smtp.gmail.com with ESMTPSA id z12-20020a05600c03cc00b003a2eacc8179sm14598761wmd.27.2022.08.01.06.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 06:28:16 -0700 (PDT)
Message-ID: <0c1f9e76-9b1d-7069-bb09-c18e4f19f0c4@redhat.com>
Date:   Mon, 1 Aug 2022 15:28:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Xin Hao <xhao@linux.alibaba.com>, willy@infradead.org
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220801121727.76186-1-xhao@linux.alibaba.com>
 <20220801121727.76186-2-xhao@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH V4 1/1] mm: add last level page table numa info to
 /proc/pid/numa_pgtable
In-Reply-To: <20220801121727.76186-2-xhao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.08.22 14:17, Xin Hao wrote:
> In many data center servers, the shared memory architectures is
> Non-Uniform Memory Access (NUMA), remote numa node data access
> often brings a high latency problem, but what we are easy to ignore
> is that the page table remote numa access, It can also leads to a
> performance degradation.

Let me try rewriting:

"
Many data center servers employ Non-Uniform Memory Access (NUMA)
architectures. Remote numa memory access results in high latency. While
memory placement is one issue, sub-optimal page table placement can also
result in surprise performance degradation.
"

> 
> So there add a new interface in /proc, This will help developers to
> get more info about performance issues if they are caused by cross-NUMA.


Why do we only care about "last level page table", why not about the others?

IMHO, we could emit something like "0, 1, 3, 0" instead for a given user
space address, showing the NUMA node the page table belongs to from
highest to lowest page table level.

> 
> Reported-by: kernel test robot <lkp@intel.com>

The kernel test robot reported that we need "/proc/pid/numa_pgtable" ?! :)

Just drop that unless it's a follow-up fix.

> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  fs/proc/base.c     |  2 ++
>  fs/proc/internal.h |  1 +
>  fs/proc/task_mmu.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 8dfa36a99c74..487e82dd3275 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3224,6 +3224,7 @@ static const struct pid_entry tgid_base_stuff[] = {
>  	REG("maps",       S_IRUGO, proc_pid_maps_operations),
>  #ifdef CONFIG_NUMA
>  	REG("numa_maps",  S_IRUGO, proc_pid_numa_maps_operations),
> +	REG("numa_pgtable", S_IRUGO, proc_pid_numa_pgtable_operations),
>  #endif
>  	REG("mem",        S_IRUSR|S_IWUSR, proc_mem_operations),
>  	LNK("cwd",        proc_cwd_link),
> @@ -3571,6 +3572,7 @@ static const struct pid_entry tid_base_stuff[] = {
>  #endif
>  #ifdef CONFIG_NUMA
>  	REG("numa_maps", S_IRUGO, proc_pid_numa_maps_operations),
> +	REG("numa_pgtable", S_IRUGO, proc_pid_numa_pgtable_operations),
>  #endif
>  	REG("mem",       S_IRUSR|S_IWUSR, proc_mem_operations),
>  	LNK("cwd",       proc_cwd_link),
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 06a80f78433d..e7ed9ef097b6 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -296,6 +296,7 @@ struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode);
> 
>  extern const struct file_operations proc_pid_maps_operations;
>  extern const struct file_operations proc_pid_numa_maps_operations;
> +extern const struct file_operations proc_pid_numa_pgtable_operations;
>  extern const struct file_operations proc_pid_smaps_operations;
>  extern const struct file_operations proc_pid_smaps_rollup_operations;
>  extern const struct file_operations proc_clear_refs_operations;
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 2d04e3470d4c..77b7a49757f5 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1999,4 +1999,91 @@ const struct file_operations proc_pid_numa_maps_operations = {
>  	.release	= proc_map_release,
>  };
> 
> +struct pgtable_numa_private {
> +	struct proc_maps_private proc_maps;
> +	unsigned long node[MAX_NUMNODES];
> +};
> +
> +static int gather_pgtable_numa_stats(pmd_t *pmd, unsigned long addr,
> +				     unsigned long end, struct mm_walk *walk)
> +{
> +	struct pgtable_numa_private *priv = walk->private;
> +	struct page *page;
> +	int nid;
> +
> +	if (pmd_huge(*pmd)) {
> +		page = virt_to_page(pmd);
> +	} else {
> +		page = pmd_page(*pmd);
> +	}
> +
> +	nid = page_to_nid(page);
> +	priv->node[nid]++;
> +
> +	return 0;
> +}
> +
> +static const struct mm_walk_ops show_numa_pgtable_ops = {
> +	.pmd_entry = gather_pgtable_numa_stats,
> +};
> +
> +/*
> + * Display the page talbe allocated per node via /proc.

s/talbe/table/

but the comment somehow doesn't make sense. We don't display a page table.

> + */
> +static int show_numa_pgtable(struct seq_file *m, void *v)
> +{
> +	struct pgtable_numa_private *numa_priv = m->private;
> +	struct vm_area_struct *vma = v;
> +	struct mm_struct *mm = vma->vm_mm;
> +	struct file *file = vma->vm_file;
> +	int nid;
> +
> +	if (!mm)
> +		return 0;
> +
> +	memset(numa_priv->node, 0, sizeof(numa_priv->node));
> +
> +	seq_printf(m, "%08lx ", vma->vm_start);
> +
> +	if (file) {
> +		seq_puts(m, " file=");
> +		seq_file_path(m, file, "\n\t= ");
> +	} else if (vma->vm_start <= mm->brk && vma->vm_end >= mm->start_brk) {
> +		seq_puts(m, " heap");
> +	} else if (is_stack(vma)) {
> +		seq_puts(m, " stack");
> +	}
> +
> +	/* mmap_lock is held by m_start */
> +	walk_page_vma(vma, &show_numa_pgtable_ops, numa_priv);
> +
> +	for_each_node_state(nid, N_MEMORY) {
> +		if (numa_priv->node[nid])
> +			seq_printf(m, " N%d=%lu", nid, numa_priv->node[nid]);
> +	}
> +	seq_putc(m, '\n');
> +
> +	return 0;
> +}
> +
> +static const struct seq_operations proc_pid_numa_pgtable_op = {
> +	.start  = m_start,
> +	.next   = m_next,
> +	.stop   = m_stop,
> +	.show   = show_numa_pgtable,
> +};
> +
> +static int pid_numa_pgtable_open(struct inode *inode, struct file *file)
> +{
> +	return proc_maps_open(inode, file, &proc_pid_numa_pgtable_op,
> +			sizeof(struct pgtable_numa_private));
> +}
> +
> +const struct file_operations proc_pid_numa_pgtable_operations = {
> +	.open		= pid_numa_pgtable_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= proc_map_release,
> +};
> +
>  #endif /* CONFIG_NUMA */
> --
> 2.31.0
> 


-- 
Thanks,

David / dhildenb

