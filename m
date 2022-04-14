Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E0A501109
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 16:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344990AbiDNNo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245724AbiDNN3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:29:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FF1AFAF1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:23:57 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EC3xRx006596;
        Thu, 14 Apr 2022 13:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=0aT4Btz0BIzPRU3eEvAEUbN6enx90d1ia+1D8Ps+jrk=;
 b=LGhI6IIpJLRQWjrG0BjRkDZS1JPTug8NGNeNrjgYj74hKXO0yPIWK/i8hrebk3tzyoYh
 9PocU3jeBFBEquKaip7dEA9Vo6zMhFowtXYQHYO66JLvvYq3j5JgzmXOlijmhBQm/Ydu
 0zGfizHq0jf4ws1w/PGMg21wFpBImMJI8s6BDJ5lnoXo3yIA7ya6eJp1depdaKoCWblv
 xKmfhWrfy2jAXY/01Ti9ysNjgBvQ6N1wrWoKLkEgTwYr8HjhvVqHhepU/D2MzvGjiEyH
 N94fDTs2oo1xBhxMpq9XGyjbkwceXAt/zwRjPHwoE7n6R2ZfnRvFpeTwBZ+lugxRnLMV pA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fefh566eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 13:23:32 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23ECtOBE031011;
        Thu, 14 Apr 2022 13:23:31 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fefh566dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 13:23:31 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23EDC7bH018928;
        Thu, 14 Apr 2022 13:23:29 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3fb1s8pwy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 13:23:28 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23EDNQls32768474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 13:23:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D433A41E8;
        Thu, 14 Apr 2022 13:23:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46791A41E6;
        Thu, 14 Apr 2022 13:23:19 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.11.20])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 14 Apr 2022 13:23:18 +0000 (GMT)
Date:   Thu, 14 Apr 2022 18:53:11 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Zhong Jiang <zhongjiang-ali@linux.alibaba.com>
Subject: Re: [PATCH 1/3] memory tiering: hot page selection with hint page
 fault latency
Message-ID: <YlggP5Tub19gjF4g@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220408071222.219689-1-ying.huang@intel.com>
 <20220408071222.219689-2-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408071222.219689-2-ying.huang@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9pHSpVDA06WYqOCvO1jhWq-kk7goLquX
X-Proofpoint-ORIG-GUID: HEgySBxdujOUwakNwK3AgY4Fcj3GnAff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-14_04,2022-04-14_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 03:12:20PM +0800, Huang Ying wrote:
> To optimize page placement in a memory tiering system with NUMA
> balancing, the hot pages in the slow memory node need to be
> identified.  Essentially, the original NUMA balancing implementation
> selects the mostly recently accessed (MRU) pages as the hot pages.
> But this isn't a very good algorithm to identify the hot pages.
> 
> So, in this patch we implemented a better hot page selection
> algorithm.  Which is based on NUMA balancing page table scanning and
> hint page fault as follows,
> 
> - When the page tables of the processes are scanned to change PTE/PMD
>   to be PROT_NONE, the current time is recorded in struct page as scan
>   time.
> 
> - When the page is accessed, hint page fault will occur.  The scan
>   time is gotten from the struct page.  And The hint page fault
>   latency is defined as
> 
>     hint page fault time - scan time
> 
> The shorter the hint page fault latency of a page is, the higher the
> probability of their access frequency to be higher.  So the hint page
> fault latency is a good estimation of the page hot/cold.
> 
> But it's hard to find some extra space in struct page to hold the scan
> time.  Fortunately, we can reuse some bits used by the original NUMA
> balancing.
> 
> NUMA balancing uses some bits in struct page to store the page
> accessing CPU and PID (referring to page_cpupid_xchg_last()).  Which
> is used by the multi-stage node selection algorithm to avoid to
> migrate pages shared accessed by the NUMA nodes back and forth.  But
> for pages in the slow memory node, even if they are shared accessed by
> multiple NUMA nodes, as long as the pages are hot, they need to be
> promoted to the fast memory node.  So the accessing CPU and PID
> information are unnecessary for the slow memory pages.  We can reuse
> these bits in struct page to record the scan time for them.  For the
> fast memory pages, these bits are used as before.
> 
> For the hot threshold, the default value is 1 second, which works well
> in our performance test.  All pages with hint page fault latency < the
> threshold will be considered hot.  A debugfs interface is also
> provided to adjust the hot threshold.
> 
> The downside of the above method is that the response time to the
> workload hot spot changing may be much longer.  For example,
> 
> - A previous cold memory area becomes hot
> 
> - The hint page fault will be triggered.  But the hint page fault
>   latency isn't shorter than the hot threshold.  So the pages will
>   not be promoted.
> 
> - When the memory area is scanned again, maybe after a scan period,
>   the hint page fault latency measured will be shorter than the hot
>   threshold and the pages will be promoted.
> 
> To mitigate this,
> 
> - If there are enough free space in the fast memory node, the hot
>   threshold will not be used, all pages will be promoted upon the hint
>   page fault for fast response.
> 
> - If fast response is more important for system performance, the
>   administrator can set a higher hot threshold.
> 
> Thanks Zhong Jiang reported and tested the fix for a bug when
> disabling memory tiering mode dynamically.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: osalvador <osalvador@suse.de>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Zhong Jiang <zhongjiang-ali@linux.alibaba.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  include/linux/mm.h   | 30 ++++++++++++++++++
>  kernel/sched/debug.c |  1 +
>  kernel/sched/fair.c  | 74 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h |  1 +
>  mm/huge_memory.c     | 13 ++++++--
>  mm/memory.c          | 11 ++++++-
>  mm/migrate.c         | 12 +++++++
>  mm/mprotect.c        |  8 ++++-
>  8 files changed, 145 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e34edb775334..455a3d0e699d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1311,6 +1311,18 @@ static inline int folio_nid(const struct folio *folio)
>  }
>  
>  #ifdef CONFIG_NUMA_BALANCING
> +/* page access time bits needs to hold at least 4 seconds */
> +#define PAGE_ACCESS_TIME_MIN_BITS	12
> +#if LAST_CPUPID_SHIFT < PAGE_ACCESS_TIME_MIN_BITS
> +#define PAGE_ACCESS_TIME_BUCKETS				\
> +	(PAGE_ACCESS_TIME_MIN_BITS - LAST_CPUPID_SHIFT)
> +#else
> +#define PAGE_ACCESS_TIME_BUCKETS	0
> +#endif
> +
> +#define PAGE_ACCESS_TIME_MASK				\
> +	(LAST_CPUPID_MASK << PAGE_ACCESS_TIME_BUCKETS)
> +
>  static inline int cpu_pid_to_cpupid(int cpu, int pid)
>  {
>  	return ((cpu & LAST__CPU_MASK) << LAST__PID_SHIFT) | (pid & LAST__PID_MASK);
> @@ -1346,6 +1358,11 @@ static inline bool __cpupid_match_pid(pid_t task_pid, int cpupid)
>  	return (task_pid & LAST__PID_MASK) == cpupid_to_pid(cpupid);
>  }
>  
> +static inline bool check_cpupid(int cpupid)
> +{
> +	return cpupid_to_cpu(cpupid) < nr_cpu_ids;
> +}
> +
>  #define cpupid_match_pid(task, cpupid) __cpupid_match_pid(task->pid, cpupid)
>  #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
>  static inline int page_cpupid_xchg_last(struct page *page, int cpupid)
> @@ -1374,12 +1391,25 @@ static inline void page_cpupid_reset_last(struct page *page)
>  	page->flags |= LAST_CPUPID_MASK << LAST_CPUPID_PGSHIFT;
>  }
>  #endif /* LAST_CPUPID_NOT_IN_PAGE_FLAGS */
> +
> +static inline int xchg_page_access_time(struct page *page, int time)
> +{
> +	int last_time;
> +
> +	last_time = page_cpupid_xchg_last(page, time >> PAGE_ACCESS_TIME_BUCKETS);
> +	return last_time << PAGE_ACCESS_TIME_BUCKETS;
> +}
>  #else /* !CONFIG_NUMA_BALANCING */
>  static inline int page_cpupid_xchg_last(struct page *page, int cpupid)
>  {
>  	return page_to_nid(page); /* XXX */
>  }
>  
> +static inline int xchg_page_access_time(struct page *page, int time)
> +{
> +	return 0;
> +}
> +
>  static inline int page_cpupid_last(struct page *page)
>  {
>  	return page_to_nid(page); /* XXX */
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index bb3d63bdf4ae..ad63dbfc54f1 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -333,6 +333,7 @@ static __init int sched_init_debug(void)
>  	debugfs_create_u32("scan_period_min_ms", 0644, numa, &sysctl_numa_balancing_scan_period_min);
>  	debugfs_create_u32("scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
>  	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
> +	debugfs_create_u32("hot_threshold_ms", 0644, numa, &sysctl_numa_balancing_hot_threshold);
>  #endif
>  
>  	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299d67ab..cb130ea46c71 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1058,6 +1058,9 @@ unsigned int sysctl_numa_balancing_scan_size = 256;
>  /* Scan @scan_size MB every @scan_period after an initial @scan_delay in ms */
>  unsigned int sysctl_numa_balancing_scan_delay = 1000;
>  
> +/* The page with hint page fault latency < threshold in ms is considered hot */
> +unsigned int sysctl_numa_balancing_hot_threshold = 1000;
> +
>  struct numa_group {
>  	refcount_t refcount;
>  
> @@ -1400,6 +1403,37 @@ static inline unsigned long group_weight(struct task_struct *p, int nid,
>  	return 1000 * faults / total_faults;
>  }
>  
> +static bool pgdat_free_space_enough(struct pglist_data *pgdat)
> +{
> +	int z;
> +	unsigned long enough_mark;
> +
> +	enough_mark = max(1UL * 1024 * 1024 * 1024 >> PAGE_SHIFT,
> +			  pgdat->node_present_pages >> 4);
> +	for (z = pgdat->nr_zones - 1; z >= 0; z--) {
> +		struct zone *zone = pgdat->node_zones + z;
> +
> +		if (!populated_zone(zone))
> +			continue;
> +
> +		if (zone_watermark_ok(zone, 0,
> +				      high_wmark_pages(zone) + enough_mark,
> +				      ZONE_MOVABLE, 0))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static int numa_hint_fault_latency(struct page *page)
> +{
> +	int last_time, time;
> +
> +	time = jiffies_to_msecs(jiffies);
> +	last_time = xchg_page_access_time(page, time);
> +
> +	return (time - last_time) & PAGE_ACCESS_TIME_MASK;

This code can possibly consider cold page as hot,

Assume,

LAST_CPUPID_SHIFT = 12
PAGE_ACCESS_TIME_BUCKETS = 0
sysctl_numa_balancing_hot_threshold = 1000

Assume while changing pte,
jiffies_to_msecs(jiffies) = 0xAABB0100

So value saved in page->flags will be lowest 12 bits of 0xAABB0100
which is 0x100.

Assume when numa_hint_fault_latency() gets called,
time = jiffies_to_msecs(jiffies) = 0xAACC0100

So, time = 0xAACC0100, and last_time = 0x100,
time - last_time = 0xAACC0100 - 0x100 = 0xAACC0000
0xAACC0000 & PAGE_ACCESS_TIME_MASK = 0xAACC0000 & ((1 << 12) - 1) = 0

so the return value of this function is 0, the code will consider it as
hot page but it is cold page because actual difference is
0xAACC0100 - 0xAABB0100 = 110000 ms

There may be more such scenarios. What do you think?

> +}
> +
>  bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
>  				int src_nid, int dst_cpu)
>  {
> @@ -1407,9 +1441,38 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
>  	int dst_nid = cpu_to_node(dst_cpu);
>  	int last_cpupid, this_cpupid;
>  
> +	/*
> +	 * The pages in slow memory node should be migrated according
> +	 * to hot/cold instead of accessing CPU node.
> +	 */
> +	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
> +	    !node_is_toptier(src_nid)) {
> +		struct pglist_data *pgdat;
> +		unsigned long latency, th;
> +
> +		pgdat = NODE_DATA(dst_nid);
> +		if (pgdat_free_space_enough(pgdat))
> +			return true;
> +
> +		th = sysctl_numa_balancing_hot_threshold;
> +		latency = numa_hint_fault_latency(page);
> +		if (latency >= th)
> +			return false;
> +
> +		return true;
> +	}
> +
>  	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
>  	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
>  
> +	/*
> +	 * The cpupid may be invalid when NUMA_BALANCING_MEMORY_TIERING
> +	 * is disabled dynamically.
> +	 */
> +	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
> +	    !node_is_toptier(src_nid) && !check_cpupid(last_cpupid))
> +		return false;
> +
>  	/*
>  	 * Allow first faults or private faults to migrate immediately early in
>  	 * the lifetime of a task. The magic number 4 is based on waiting for
> @@ -2642,6 +2705,17 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
>  	if (!p->mm)
>  		return;
>  
> +	/*
> +	 * NUMA faults statistics are unnecessary for the slow memory node.
> +	 *
> +	 * And, the cpupid may be invalid when NUMA_BALANCING_MEMORY_TIERING
> +	 * is disabled dynamically.
> +	 */
> +	if (!node_is_toptier(mem_node) &&
> +	    (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING ||
> +	     !check_cpupid(last_cpupid)))
> +		return;
> +
>  	/* Allocate buffer to track faults on a per-node basis */
>  	if (unlikely(!p->numa_faults)) {
>  		int size = sizeof(*p->numa_faults) *
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 58263f90c559..86ce60d3d472 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2408,6 +2408,7 @@ extern unsigned int sysctl_numa_balancing_scan_delay;
>  extern unsigned int sysctl_numa_balancing_scan_period_min;
>  extern unsigned int sysctl_numa_balancing_scan_period_max;
>  extern unsigned int sysctl_numa_balancing_scan_size;
> +extern unsigned int sysctl_numa_balancing_hot_threshold;
>  #endif
>  
>  #ifdef CONFIG_SCHED_HRTICK
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2fe38212e07c..3a715eeeebb5 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1401,7 +1401,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  	struct page *page;
>  	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>  	int page_nid = NUMA_NO_NODE;
> -	int target_nid, last_cpupid = -1;
> +	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
>  	bool migrated = false;
>  	bool was_writable = pmd_savedwrite(oldpmd);
>  	int flags = 0;
> @@ -1422,7 +1422,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  		flags |= TNF_NO_GROUP;
>  
>  	page_nid = page_to_nid(page);
> -	last_cpupid = page_cpupid_last(page);
> +	if (node_is_toptier(page_nid))
> +		last_cpupid = page_cpupid_last(page);
>  	target_nid = numa_migrate_prep(page, vma, haddr, page_nid,
>  				       &flags);
>  
> @@ -1740,6 +1741,7 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  
>  	if (prot_numa) {
>  		struct page *page;
> +		bool toptier;
>  		/*
>  		 * Avoid trapping faults against the zero page. The read-only
>  		 * data is likely to be read-cached on the local CPU and
> @@ -1752,13 +1754,18 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  			goto unlock;
>  
>  		page = pmd_page(*pmd);
> +		toptier = node_is_toptier(page_to_nid(page));
>  		/*
>  		 * Skip scanning top tier node if normal numa
>  		 * balancing is disabled
>  		 */
>  		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
> -		    node_is_toptier(page_to_nid(page)))
> +		    toptier)
>  			goto unlock;
> +
> +		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
> +		    !toptier)
> +			xchg_page_access_time(page, jiffies_to_msecs(jiffies));
>  	}
>  	/*
>  	 * In case prot_numa, we are under mmap_read_lock(mm). It's critical
> diff --git a/mm/memory.c b/mm/memory.c
> index b370ed118767..a8ac15ce7a75 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -74,6 +74,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/ptrace.h>
>  #include <linux/vmalloc.h>
> +#include <linux/sched/sysctl.h>
>  
>  #include <trace/events/kmem.h>
>  
> @@ -4455,8 +4456,16 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	if (page_mapcount(page) > 1 && (vma->vm_flags & VM_SHARED))
>  		flags |= TNF_SHARED;
>  
> -	last_cpupid = page_cpupid_last(page);
>  	page_nid = page_to_nid(page);
> +	/*
> +	 * In memory tiering mode, cpupid of slow memory page is used
> +	 * to record page access time.  So use default value.
> +	 */
> +	if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
> +	    !node_is_toptier(page_nid))
> +		last_cpupid = (-1 & LAST_CPUPID_MASK);
> +	else
> +		last_cpupid = page_cpupid_last(page);
>  	target_nid = numa_migrate_prep(page, vma, vmf->address, page_nid,
>  			&flags);
>  	if (target_nid == NUMA_NO_NODE) {
> diff --git a/mm/migrate.c b/mm/migrate.c
> index dc84edfae842..e73f26dfeb38 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -534,6 +534,18 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
>  	 * future migrations of this same page.
>  	 */
>  	cpupid = page_cpupid_xchg_last(&folio->page, -1);
> +	/*
> +	 * If migrate between slow and fast memory node, reset cpupid,
> +	 * because that is used to record page access time in slow
> +	 * memory node
> +	 */
> +	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) {
> +		bool f_toptier = node_is_toptier(page_to_nid(&folio->page));
> +		bool t_toptier = node_is_toptier(page_to_nid(&newfolio->page));
> +
> +		if (f_toptier != t_toptier)
> +			cpupid = -1;
> +	}
>  	page_cpupid_xchg_last(&newfolio->page, cpupid);
>  
>  	folio_migrate_ksm(newfolio, folio);
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index b69ce7a7b2b7..e7cb90d84fac 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -85,6 +85,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  			if (prot_numa) {
>  				struct page *page;
>  				int nid;
> +				bool toptier;
>  
>  				/* Avoid TLB flush if possible */
>  				if (pte_protnone(oldpte))
> @@ -114,14 +115,19 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  				nid = page_to_nid(page);
>  				if (target_node == nid)
>  					continue;
> +				toptier = node_is_toptier(nid);
>  
>  				/*
>  				 * Skip scanning top tier node if normal numa
>  				 * balancing is disabled
>  				 */
>  				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
> -				    node_is_toptier(nid))
> +				    toptier)
>  					continue;
> +				if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
> +				    !toptier)
> +					xchg_page_access_time(page,
> +						jiffies_to_msecs(jiffies));
>  			}
>  
>  			oldpte = ptep_modify_prot_start(vma, addr, pte);
> -- 
> 2.30.2
> 
> 
