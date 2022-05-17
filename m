Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B774152A441
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348388AbiEQOEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348362AbiEQOEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:04:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0302B41628;
        Tue, 17 May 2022 07:04:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 77CEB21CF2;
        Tue, 17 May 2022 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652796279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJBRE825W9Hw9NhmSzAfHFI89bt4xzkUKmjSGDnVJCI=;
        b=LBxtG1h57/581zdjsUzKBX75BW6c0aMplpWKr9R96YRBf9tQ2VxA4nUKdyKFd6jCWN64JJ
        KdNmvOBkXXerjJq5cw41GiIMo9Vm14mbanj6oTN8RC3NmWRBJH8pa5YlssZ+z6ZFEUOcmb
        6gwA7sAzmEQEWCYYX4+TWs+X7gCgI88=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A1BC12C141;
        Tue, 17 May 2022 14:04:38 +0000 (UTC)
Date:   Tue, 17 May 2022 16:04:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, ammarfaizi2@gnuweeb.org,
        oleksandr@natalenko.name, willy@infradead.org, linux-mm@kvack.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Hugh Dickins <hughd@google.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH] mm/ksm: introduce ksm_enabled for each process
Message-ID: <YoOrdh85+AqJH8w1@dhcp22.suse.cz>
References: <20220517092701.1662641-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517092701.1662641-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing Hugh and linux-api]

On Tue 17-05-22 09:27:01, cgel.zte@gmail.com wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> For now, if we want to use KSM to merge pages of some apps, we have to
> explicitly call madvise() in application code, which means installed
> apps on OS needs to be uninstall and source code needs to be modified.
> It is very inconvenient because sometimes users or app developers are not
> willing to modify their app source codes for any reasons.

Would it help to allow external control by process_madvise?
 
> So to use KSM more flexibly, we provide a new proc file "ksm_enabled" under
> /proc/<pid>/. We can pass parameter into this file with one of three values
> as follows:
> 
> 	always:
> 		force all anonymous and eligible VMAs of this process to be
> 		scanned by ksmd.
> 	madvise:
> 		the default state, unless user code call madvise, ksmd
> 		doesn't scan this process.
> 	never:
> 		this process will never be scanned by ksmd and no merged
> 		pages occurred in this process.
> 
> With this patch, we can control KSM with ``/proc/<pid>/ksm_enabled``
> based on every process. KSM for each process can be entirely disabled
> (mostly for debugging purposes) or only enabled inside MADV_MERGEABLE
> regions (to avoid the risk of consuming more cpu resources to scan for
> ksmd) or enabled entirely for a process.

I am not really familiar with KSM much but I am wondering whether the
proc based interface is really the best fit. We have a very similar
concern with THP where processes would like to override the global setup
and that has been done with prctl interface. Is there any reason why
this should be any different?

Another question I have is about the interaction of the per-process
tunable with any explicit madvise calls. AFAICS you have made this knob
per mm but the actual implementation currently relies on the per-vma
flags. That means that one can explicitly disallow merging by madvise
for a range. Is it wise to override that by a per-process knob? I mean
there might be a very good reason why a particular memory ranges should
never be merged but a per-process knob could easily ignore that hint
from the application. Or am I just confused?

[I am keeping the rest of the email for reference]

> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Reviewed-by: wangyong <wang.yong12@zte.com.cn>
> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> Reviewed-by: Jiang Xuexin <jiang.xuexin@zte.com.cn>
> Signed-off-by: CGEL <cgel.zte@gmail.com>
> ---
>  Documentation/admin-guide/mm/ksm.rst |  24 ++++++-
>  Documentation/filesystems/proc.rst   |  14 ++++
>  fs/proc/base.c                       | 102 ++++++++++++++++++++++++++-
>  include/linux/ksm.h                  |   5 ++
>  include/linux/mm_types.h             |  10 +++
>  mm/ksm.c                             |  35 ++++++++-
>  6 files changed, 185 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
> index b244f0202a03..91326198e37f 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -32,7 +32,7 @@ are swapped back in: ksmd must rediscover their identity and merge again).
>  Controlling KSM with madvise
>  ============================
>  
> -KSM only operates on those areas of address space which an application
> +KSM can operate on those areas of address space which an application
>  has advised to be likely candidates for merging, by using the madvise(2)
>  system call::
>  
> @@ -70,6 +70,28 @@ Applications should be considerate in their use of MADV_MERGEABLE,
>  restricting its use to areas likely to benefit.  KSM's scans may use a lot
>  of processing power: some installations will disable KSM for that reason.
>  
> +Controlling KSM with procfs
> +===========================
> +We can also control KSM with ``/proc/<pid>/ksm_enabled`` based on every
> +process. KSM for each process can be entirely disabled (mostly for
> +debugging purposes) or only enabled inside MADV_MERGEABLE regions (to avoid
> +the risk of consuming more cpu resources to scan for ksmd) or enabled entirely
> +for a process. This can be achieved with one of::
> +
> +    echo always > /proc/<pid>/ksm_enabled
> +    echo madvise > /proc/<pid>/ksm_enabled
> +    echo never > /proc/<pid>/ksm_enabled
> +
> +always:
> +        force all anonymous and eligible VMAs of this process to be scanned
> +        by ksmd.
> +madvise:
> +        the default state, unless user code call madvise, ksmd doesn't scan
> +        this process.
> +never:
> +        this process will never be scanned by ksmd and no merged pages
> +	occurred in this process.
> +
>  .. _ksm_sysfs:
>  
>  KSM daemon sysfs interface
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 1bc91fb8c321..ea7e08a1c143 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -47,6 +47,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
>    3.10  /proc/<pid>/timerslack_ns - Task timerslack value
>    3.11	/proc/<pid>/patch_state - Livepatch patch operation state
>    3.12	/proc/<pid>/arch_status - Task architecture specific information
> +  3.13  /proc/<pid>/ksm_enabled - Controlling KSM based on process
>  
>    4	Configuring procfs
>    4.1	Mount options
> @@ -2140,6 +2141,19 @@ AVX512_elapsed_ms
>    the task is unlikely an AVX512 user, but depends on the workload and the
>    scheduling scenario, it also could be a false negative mentioned above.
>  
> +3.13 /proc/<pid>/ksm_enabled - Controlling KSM based on process
> +---------------------------------------------------------------
> +When CONFIG_KSM is enabled, this file can be used to specify how this
> +process's anonymous memory gets involved in KSM scanning.
> +
> +If writing "always" to this file, it will force all anonymous and eligible
> +VMAs of this process to be scanned by ksmd.
> +
> +If writing "madvise" to this file, turn to the default state, unless user
> +code call madvise, ksmd doesn't scan this process.
> +
> +If writing "never" to this file, this process will never be scanned by ksmd.
> +
>  Chapter 4: Configuring procfs
>  =============================
>  
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 617816168748..760ceeab4aa1 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -96,6 +96,7 @@
>  #include <linux/time_namespace.h>
>  #include <linux/resctrl.h>
>  #include <linux/cn_proc.h>
> +#include <linux/ksm.h>
>  #include <trace/events/oom.h>
>  #include "internal.h"
>  #include "fd.h"
> @@ -3171,7 +3172,104 @@ static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *
>  
>  	return 0;
>  }
> -#endif /* CONFIG_KSM */
> +
> +static int ksm_enabled_show(struct seq_file *m, void *v)
> +{
> +	struct inode *inode = m->private;
> +	struct mm_struct *mm;
> +	struct task_struct *task = get_proc_task(inode);
> +
> +	if (!task)
> +		return -ESRCH;
> +
> +	mm = get_task_mm(task);
> +	if (mm) {
> +		if (mm->ksm_enabled == KSM_PROC_ALWAYS)
> +			seq_puts(m, "[always] madvise never\n");
> +		else if (mm->ksm_enabled == KSM_PROC_MADVISE)
> +			seq_puts(m, "always [madvise] never\n");
> +		else
> +			seq_puts(m, "always madvise [never]\n");
> +		mmput(mm);
> +	}
> +
> +	put_task_struct(task);
> +	return 0;
> +}
> +
> +static ssize_t ksm_enabled_write(struct file *file, const char __user *buf,
> +								size_t count, loff_t *ppos)
> +{
> +	struct task_struct *task;
> +	struct mm_struct *mm;
> +	char buffer[PROC_NUMBUF];
> +	int value;
> +	int err = 0;
> +	long str_len;
> +
> +	if (count > sizeof(buffer) - 1)
> +		count = sizeof(buffer) - 1;
> +	str_len = strncpy_from_user(buffer, buf, count);
> +	if (str_len < 0)
> +		return -EFAULT;
> +	buffer[str_len - 1] = '\0';
> +
> +	if (!strcmp("always", buffer))
> +		value = KSM_PROC_ALWAYS;
> +	else if (!strcmp("madvise", buffer))
> +		value = KSM_PROC_MADVISE;
> +	else if (!strcmp("never", buffer))
> +		value = KSM_PROC_NEVER;
> +	else
> +		return -EINVAL;
> +
> +	task = get_proc_task(file_inode(file));
> +	if (!task)
> +		return -ESRCH;
> +	mm = get_task_mm(task);
> +	if (!mm)
> +		goto out_put_task;
> +
> +	if (mm->ksm_enabled != value) {
> +		if (mmap_write_lock_killable(mm)) {
> +			err = -EINTR;
> +			goto out_mmput;
> +		}
> +		if (value == KSM_PROC_NEVER)
> +			mm->ksm_enabled = value;
> +		else {
> +			/*
> +			 * No matter whether it's KSM_PROC_ALWAYS or KSM_PROC_MADVISE, we need
> +			 * to recheck mm->flags to guarantee that this mm is in ksm_scan.
> +			 */
> +			if (!test_bit(MMF_VM_MERGEABLE, &mm->flags))
> +				err = __ksm_enter(mm);
> +			if (!err)
> +				mm->ksm_enabled = value;
> +		}
> +		mmap_write_unlock(mm);
> +	}
> +
> +out_mmput:
> +	mmput(mm);
> +out_put_task:
> +	put_task_struct(task);
> +	return err < 0 ? err : count;
> +}
> +
> +static int ksm_enabled_open(struct inode *inode, struct file *filp)
> +{
> +	return single_open(filp, ksm_enabled_show, inode);
> +}
> +
> +static const struct file_operations proc_pid_ksm_enabled_operations = {
> +	.open       = ksm_enabled_open,
> +	.read		= seq_read,
> +	.write		= ksm_enabled_write,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +#endif /*CONFIG_KSM */
>  
>  #ifdef CONFIG_STACKLEAK_METRICS
>  static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
> @@ -3306,6 +3404,7 @@ static const struct pid_entry tgid_base_stuff[] = {
>  #endif
>  #ifdef CONFIG_KSM
>  	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
> +	REG("ksm_enabled", S_IRUGO|S_IWUSR, proc_pid_ksm_enabled_operations),
>  #endif
>  };
>  
> @@ -3642,6 +3741,7 @@ static const struct pid_entry tid_base_stuff[] = {
>  #endif
>  #ifdef CONFIG_KSM
>  	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
> +	REG("ksm_enabled", S_IRUGO|S_IWUSR, proc_pid_ksm_enabled_operations),
>  #endif
>  };
>  
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index 0b4f17418f64..29d23d208b54 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -19,6 +19,11 @@ struct stable_node;
>  struct mem_cgroup;
>  
>  #ifdef CONFIG_KSM
> +
> +#define KSM_PROC_MADVISE	0
> +#define KSM_PROC_ALWAYS		1
> +#define KSM_PROC_NEVER		2
> +
>  int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>  		unsigned long end, int advice, unsigned long *vm_flags);
>  int __ksm_enter(struct mm_struct *mm);
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 417ef1519475..29fd4c84d08c 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -649,6 +649,16 @@ struct mm_struct {
>  		 * merging.
>  		 */
>  		unsigned long ksm_merging_pages;
> +
> +		/*
> +		 * Represent the state of this mm involing in KSM, with 3 states:
> +		 * 1) KSM_PROC_ALWAYS:  force all anonymous VMAs of this process to
> +		 *						be scanned.
> +		 * 2) KSM_PROC_MADVISE: the default state, unless user code call
> +		 *						madvise, don't scan this process.
> +		 * 3) KSM_PROC_NEVER: never be involed in KSM.
> +		 */
> +		int ksm_enabled;
>  #endif
>  	} __randomize_layout;
>  
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 26da7f813f23..90cc8eda8bca 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -334,6 +334,35 @@ static void __init ksm_slab_free(void)
>  	mm_slot_cache = NULL;
>  }
>  
> +static bool vma_scannable(struct vm_area_struct *vma)
> +{
> +	unsigned long vm_flags = vma->vm_flags;
> +	struct mm_struct *mm = vma->vm_mm;
> +
> +	if (mm->ksm_enabled == KSM_PROC_NEVER ||
> +			(!(vma->vm_flags & VM_MERGEABLE) &&
> +			mm->ksm_enabled != KSM_PROC_ALWAYS))
> +		return false;
> +
> +	if (vm_flags & (VM_SHARED	| VM_MAYSHARE	|
> +			VM_PFNMAP	| VM_IO | VM_DONTEXPAND |
> +			VM_HUGETLB	| VM_MIXEDMAP))
> +		return false;       /* just ignore this vma*/
> +
> +	if (vma_is_dax(vma))
> +		return false;
> +#ifdef VM_SAO
> +	if (vm_flags & VM_SAO)
> +		return false;
> +#endif
> +#ifdef VM_SPARC_ADI
> +	if (vm_flags & VM_SPARC_ADI)
> +		return false;
> +#endif
> +
> +	return true;
> +}
> +
>  static __always_inline bool is_stable_node_chain(struct stable_node *chain)
>  {
>  	return chain->rmap_hlist_len == STABLE_NODE_CHAIN;
> @@ -523,7 +552,7 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
>  	if (ksm_test_exit(mm))
>  		return NULL;
>  	vma = vma_lookup(mm, addr);
> -	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
> +	if (!vma || !vma_scannable(vma) || !vma->anon_vma)
>  		return NULL;
>  	return vma;
>  }
> @@ -990,7 +1019,7 @@ static int unmerge_and_remove_all_rmap_items(void)
>  		for_each_vma(vmi, vma) {
>  			if (ksm_test_exit(mm))
>  				break;
> -			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
> +			if (!vma_scannable(vma) || !vma->anon_vma)
>  				continue;
>  			err = unmerge_ksm_pages(vma,
>  						vma->vm_start, vma->vm_end);
> @@ -2300,7 +2329,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
>  		goto no_vmas;
>  
>  	for_each_vma(vmi, vma) {
> -		if (!(vma->vm_flags & VM_MERGEABLE))
> +		if (!vma_scannable(vma))
>  			continue;
>  		if (ksm_scan.address < vma->vm_start)
>  			ksm_scan.address = vma->vm_start;
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
