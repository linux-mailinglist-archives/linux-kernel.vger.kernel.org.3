Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B85586E68
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbiHAQRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiHAQRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:17:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB802A27A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:17:04 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LxNSn71Gxz67ZwS;
        Tue,  2 Aug 2022 00:12:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 18:17:02 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 1 Aug
 2022 17:17:01 +0100
Date:   Mon, 1 Aug 2022 17:16:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <cgel.zte@gmail.com>
CC:     <hannes@cmpxchg.org>, <akpm@linux-foundation.org>, <tj@kernel.org>,
        <axboe@kernel.dk>, <vdavydov.dev@gmail.com>,
        <ran.xiaokai@zte.com.cn>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, cgel <cgel@zte.com.cn>
Subject: Re: [RFC PATCH 1/2] psi: introduce memory.pressure.stat
Message-ID: <20220801171659.00007125@huawei.com>
In-Reply-To: <20220801004205.1593100-1-ran.xiaokai@zte.com.cn>
References: <20220801004205.1593100-1-ran.xiaokai@zte.com.cn>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Aug 2022 00:42:04 +0000
cgel.zte@gmail.com wrote:

> From: cgel <cgel@zte.com.cn>
> 
Trivial things noticed in passing (not a full review!)

Please spell check patch descriptions.

> For now psi memory pressure account for all the mem stall in the
> system, And didnot provide a detailed information why the stall
did not
> happens. This patch introduce a cgroupu knob memory.pressure.stat,
> it tells the detailed stall information of all memory events and it
> format and the corresponding proc interface.
> 
> for the cgroup, add memory.pressure.stat and it shows:
> kswapd: avg10=0.00 avg60=0.00 avg300=0.00 total=0
> direct reclaim: avg10=0.00 avg60=0.00 avg300=0.12 total=42356
> kcompacted: avg10=0.00 avg60=0.00 avg300=0.00 total=0
> direct compact: avg10=0.00 avg60=0.00 avg300=0.00 total=0
> cgroup reclaim: avg10=0.00 avg60=0.00 avg300=0.00 total=0
> workingset thrashing:   avg10=0.00 avg60=0.00 avg300=0.00 total=0
> 
> for the system wide, a proc file introduced as pressure/memory_stat
> and the format is the same as the cgroup interface.
> 
> With this detaled information, for example, if the system is stalled

detailed

> because of kcompacted, compaction_proactiveness can be promoted so
> pro-compaction can be involved earlier.
> 
> Signed-off-by: cgel <cgel@zte.com.cn>
> ---
>  include/linux/psi.h       |   7 +--
>  include/linux/psi_types.h |  34 +++++++++++++
>  kernel/cgroup/cgroup.c    |  11 ++++
>  kernel/sched/psi.c        | 126 +++++++++++++++++++++++++++++++++++++++++++---
>  4 files changed, 168 insertions(+), 10 deletions(-)
> 
...

> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> index 07aaf9b..194ea78 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -9,6 +9,8 @@
>  
>  #ifdef CONFIG_PSI
>  
> +#define PSI_MASK(x)	((1UL << (x))-1)
> +
>  /* Tracked task states */
>  enum psi_task_count {
>  	NR_IOWAIT,
> @@ -22,6 +24,10 @@ enum psi_task_count {
>  #define TSK_MEMSTALL	(1 << NR_MEMSTALL)
>  #define TSK_RUNNING	(1 << NR_RUNNING)
>  
> +#define TSK_COUNT_MASK	PSI_MASK(NR_PSI_TASK_COUNTS)
> +#define TSK_COUNT_SHIFT	8
> +
> +
One blank line is probably enough.

>  /* Resources that workloads could be stalled on */
>  enum psi_res {
>  	PSI_IO,
> @@ -53,6 +59,27 @@ enum psi_aggregators {
>  	NR_PSI_AGGREGATORS,
>  };


> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 806fc9d..b50ab92 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3613,6 +3613,13 @@ static int cgroup_memory_pressure_show(struct seq_file *seq, void *v)
>  
>  	return psi_show(seq, psi, PSI_MEM);
>  }

Almost certainly what blank lines around this.  I'm not sure what reasoning behind
not having it for the other functions in this block is though...

> +static int cgroup_memory_pressure_stat_show(struct seq_file *seq, void *v)
> +{
> +	struct cgroup *cgroup = seq_css(seq)->cgroup;
> +	struct psi_group *psi = cgroup->id == 1 ? &psi_system : &cgroup->psi;
> +
> +	return psi_mem_pressure_stat_show(seq, psi);
> +}
>  static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
>  {
>  	struct cgroup *cgroup = seq_css(seq)->cgroup;
> @@ -4930,6 +4937,10 @@ static struct cftype cgroup_base_files[] = {
>  		.poll = cgroup_pressure_poll,
>  		.release = cgroup_pressure_release,
>  	},
> +	{
> +		.name = "memory.pressure.stat",
> +		.seq_show = cgroup_memory_pressure_stat_show,
> +	},
>  	{
>  		.name = "cpu.pressure",
>  		.seq_show = cgroup_cpu_pressure_show,
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 9154e74..072d535 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -279,6 +279,35 @@ static void get_recent_times(struct psi_group *group, int cpu,
..

>  	/*
> @@ -714,7 +770,7 @@ static u32 psi_group_change(struct psi_group *group, int cpu,
>  			state_mask |= (1 << s);
>  	}
>  	groupc->state_mask = state_mask;
> -

Probably better to leave the white space unless there is a strong reason to drop
the blank line.

> +	groupc->state_memstall = state_memstall;
>  	write_seqcount_end(&groupc->seq);
>  
>  	return state_mask;
..

>  static int psi_io_show(struct seq_file *m, void *v)
>  {
>  	return psi_show(m, &psi_system, PSI_IO);
> @@ -998,7 +1101,10 @@ static int psi_memory_open(struct inode *inode, struct file *file)
>  {
>  	return single_open(file, psi_memory_show, NULL);
>  }
> -

Fix this.  It's noise in this patch and the white space is probably desirable anyway.

> +static int psi_memory_stat_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, psi_mem_pressure_stat_show, NULL);
> +}
>  static int psi_cpu_open(struct inode *inode, struct file *file)
>  {
>  	return single_open(file, psi_cpu_show, NULL);
> @@ -1271,7 +1377,12 @@ static const struct file_operations psi_memory_fops = {
>  	.poll           = psi_fop_poll,
>  	.release        = psi_fop_release,
>  };
> -

And this

> +static const struct file_operations psi_memory_stat_fops = {
> +	.open           = psi_memory_stat_open,
> +	.read           = seq_read,
> +	.llseek         = seq_lseek,
> +	.release        = psi_fop_release,
> +};
>  static const struct file_operations psi_cpu_fops = {
>  	.open           = psi_cpu_open,
>  	.read           = seq_read,
> @@ -1286,6 +1397,7 @@ static int __init psi_proc_init(void)
>  	proc_mkdir("pressure", NULL);
>  	proc_create("pressure/io", 0, NULL, &psi_io_fops);
>  	proc_create("pressure/memory", 0, NULL, &psi_memory_fops);
> +	proc_create("pressure/memory_stat", 0, NULL, &psi_memory_stat_fops);
>  	proc_create("pressure/cpu", 0, NULL, &psi_cpu_fops);
>  	return 0;
>  }

