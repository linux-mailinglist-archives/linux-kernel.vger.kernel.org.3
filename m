Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475444D707B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 20:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiCLTBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 14:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiCLTBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 14:01:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403055A0A6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 10:59:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD0831F37D;
        Sat, 12 Mar 2022 18:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647111592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xxVu7L2Go8gBiGdEbU82LGvfyXMCWcAuqd4a11WouYo=;
        b=wcCSpaHBQhjrj9BGFw1EO80ph8gAwFaXHDAzwstypG4PaGQPHpL+uDxpY0XMAeAhHhRTBm
        iEhdF1hyouTHYgYPOnyiQlp4gK/jOcU+QDkxaqnocKeBTCJtMQbTAt4xCtyUfEATfvsqav
        UqcOPHE/ATZQ9e8nMHKHAHHc3pFd+2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647111592;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xxVu7L2Go8gBiGdEbU82LGvfyXMCWcAuqd4a11WouYo=;
        b=XHN0eW79b5/zzyw+JxblniUxuodZy8RMgMkv4bQ1I3L+DcJKvDVM/N3GT0KW3jeRYmVf5u
        Tkvl/qqbTeTrABAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87E5E13AC3;
        Sat, 12 Mar 2022 18:59:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vblqH6jtLGJhSQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 12 Mar 2022 18:59:52 +0000
Message-ID: <15307f8a-c202-75d8-1361-dae0146df734@suse.cz>
Date:   Sat, 12 Mar 2022 19:58:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [mm/page_alloc] 8212a964ee: vm-scalability.throughput 30.5%
 improvement
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     0day robot <lkp@intel.com>, Eric Dumazet <edumazet@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
References: <20220312154321.GC1189@xsang-OptiPlex-9020>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220312154321.GC1189@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/22 16:43, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a 30.5% improvement of vm-scalability.throughput due to commit:
> 
> 
> commit: 8212a964ee020471104e34dce7029dec33c218a9 ("Re: [PATCH v2] mm/page_alloc: call check_new_pages() while zone spinlock is not held")
> url: https://github.com/0day-ci/linux/commits/Mel-Gorman/Re-PATCH-v2-mm-page_alloc-call-check_new_pages-while-zone-spinlock-is-not-held/20220309-203504
> patch link: https://lore.kernel.org/lkml/20220309123245.GI15701@techsingularity.net

Heh, that's weird. I would expect some improvement from Eric's patch,
but this seems to be actually about Mel's "mm/page_alloc: check
high-order pages for corruption during PCP operations" applied directly
on 5.17-rc7 per the github url above. This was rather expected to make
performance worse if anything, so maybe the improvement is due to some
unexpected side-effect of different inlining decisions or cache alignment...

> in testcase: vm-scalability
> on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory
> with following parameters:
> 
> 	runtime: 300s
> 	size: 512G
> 	test: anon-w-rand-hugetlb
> 	cpufreq_governor: performance
> 	ucode: 0xd000331
> 
> test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
> 
> 
> 
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase/ucode:
>   gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/512G/lkp-icl-2sp5/anon-w-rand-hugetlb/vm-scalability/0xd000331
> 
> commit: 
>   v5.17-rc7
>   8212a964ee ("mm/page_alloc: call check_new_pages() while zone spinlock is not held")
> 
>        v5.17-rc7 8212a964ee020471104e34dce70 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>       0.00 ±  5%      -7.4%       0.00 ±  4%  vm-scalability.free_time
>      47190 ±  2%     +25.5%      59208 ±  2%  vm-scalability.median
>    6352467 ±  2%     +30.5%    8293110 ±  2%  vm-scalability.throughput
>     218.97 ±  2%     -18.7%     177.98 ±  3%  vm-scalability.time.elapsed_time
>     218.97 ±  2%     -18.7%     177.98 ±  3%  vm-scalability.time.elapsed_time.max
>     121357 ±  7%     -24.9%      91162 ± 10%  vm-scalability.time.involuntary_context_switches
>      11226            -5.2%      10641        vm-scalability.time.percent_of_cpu_this_job_got
>       2311 ±  3%     -35.2%       1496 ±  6%  vm-scalability.time.system_time
>      22275 ±  2%     -21.7%      17443 ±  3%  vm-scalability.time.user_time
>       9358 ±  3%     -13.1%       8130        vm-scalability.time.voluntary_context_switches
>     255.23           -16.1%     214.10 ±  2%  uptime.boot
>       2593            +6.8%       2771 ±  5%  vmstat.system.cs
>      11.51 ±  7%      +4.5       16.05 ±  8%  mpstat.cpu.all.idle%
>       8.48 ±  2%      -1.6        6.84 ±  3%  mpstat.cpu.all.sys%
>     727581 ± 12%     -17.2%     602238 ±  6%  numa-numastat.node1.local_node
>     798037 ±  8%     -13.3%     691955 ±  6%  numa-numastat.node1.numa_hit
>    5806206 ± 17%     +26.7%    7356010 ± 10%  turbostat.C1E
>       9.55 ± 26%      +5.9       15.48 ±  9%  turbostat.C1E%
>   59854751 ±  2%     -17.8%   49202950 ±  3%  turbostat.IRQ
>      42804 ±  6%     -54.9%      19301 ± 21%  meminfo.Active
>      41832 ±  7%     -56.2%      18325 ± 23%  meminfo.Active(anon)
>      63386 ±  6%     -26.6%      46542 ±  3%  meminfo.Mapped
>     137758           -25.5%     102591 ±  3%  meminfo.Shmem
>      36980 ±  5%     -62.6%      13823 ± 29%  numa-meminfo.node1.Active
>      36495 ±  5%     -63.9%      13173 ± 30%  numa-meminfo.node1.Active(anon)
>      19454 ± 26%     -57.7%       8233 ± 33%  numa-meminfo.node1.Mapped
>      65896 ± 38%     -67.8%      21189 ± 13%  numa-meminfo.node1.Shmem
>       9185 ±  6%     -64.7%       3246 ± 31%  numa-vmstat.node1.nr_active_anon
>       4769 ± 26%     -54.5%       2171 ± 32%  numa-vmstat.node1.nr_mapped
>      16462 ± 37%     -68.1%       5258 ± 14%  numa-vmstat.node1.nr_shmem
>       9185 ±  6%     -64.7%       3246 ± 31%  numa-vmstat.node1.nr_zone_active_anon
>      10436 ±  5%     -56.2%       4570 ± 23%  proc-vmstat.nr_active_anon
>      69290            +1.3%      70203        proc-vmstat.nr_anon_pages
>    1717695            +4.5%    1794462        proc-vmstat.nr_dirty_background_threshold
>    3439592            +4.5%    3593312        proc-vmstat.nr_dirty_threshold
>     640952            -1.4%     632171        proc-vmstat.nr_file_pages
>   17356030            +4.4%   18125242        proc-vmstat.nr_free_pages
>      93258            -2.4%      91059        proc-vmstat.nr_inactive_anon
>      16187 ±  5%     -26.4%      11911 ±  2%  proc-vmstat.nr_mapped
>      34477 ±  2%     -25.6%      25663 ±  4%  proc-vmstat.nr_shmem
>      10436 ±  5%     -56.2%       4570 ± 23%  proc-vmstat.nr_zone_active_anon
>      93258            -2.4%      91059        proc-vmstat.nr_zone_inactive_anon
>      32151 ± 16%     -61.0%      12542 ± 13%  proc-vmstat.numa_hint_faults
>      21214 ± 22%     -86.0%       2964 ± 45%  proc-vmstat.numa_hint_faults_local
>    1598135           -10.9%    1423466        proc-vmstat.numa_hit
>    1481881           -11.8%    1307551        proc-vmstat.numa_local
>     117279            -1.2%     115916        proc-vmstat.numa_other
>     555445 ± 16%     -53.2%     260178 ± 53%  proc-vmstat.numa_pte_updates
>      93889 ±  4%     -74.3%      24113 ±  7%  proc-vmstat.pgactivate
>    1599893           -11.0%    1424527        proc-vmstat.pgalloc_normal
>    1594626           -14.2%    1368920        proc-vmstat.pgfault
>    1609987           -20.8%    1275284        proc-vmstat.pgfree
>      49893           -14.8%      42496 ±  5%  proc-vmstat.pgreuse
>      15.23 ±  2%      -7.8%      14.04        perf-stat.i.MPKI
>  1.348e+10           +22.0%  1.645e+10 ±  3%  perf-stat.i.branch-instructions
>  6.957e+08 ±  2%     +22.4%  8.517e+08 ±  3%  perf-stat.i.cache-misses
>  7.117e+08 ±  2%     +22.4%   8.71e+08 ±  3%  perf-stat.i.cache-references
>       7.86 ±  2%     -29.0%       5.58 ±  6%  perf-stat.i.cpi
>  3.739e+11            -5.1%  3.549e+11        perf-stat.i.cpu-cycles
>     550.18 ±  3%     -22.2%     427.87 ±  5%  perf-stat.i.cycles-between-cache-misses
>  1.605e+10           +22.1%  1.959e+10 ±  3%  perf-stat.i.dTLB-loads
>       0.02 ±  3%      -0.0        0.01 ±  4%  perf-stat.i.dTLB-store-miss-rate%
>     921125 ±  2%      -4.6%     878569        perf-stat.i.dTLB-store-misses
>  5.803e+09           +22.0%  7.078e+09 ±  3%  perf-stat.i.dTLB-stores
>  5.665e+10           +22.0%  6.911e+10 ±  3%  perf-stat.i.instructions
>       0.16 ±  3%     +26.1%       0.20 ±  3%  perf-stat.i.ipc
>       2.92            -5.1%       2.77        perf-stat.i.metric.GHz
>     123.32 ± 16%    +158.4%     318.61 ± 22%  perf-stat.i.metric.K/sec
>     286.92           +21.8%     349.59 ±  3%  perf-stat.i.metric.M/sec
>       6641            +4.8%       6957 ±  2%  perf-stat.i.minor-faults
>     586608 ± 12%     +36.4%     800024 ±  7%  perf-stat.i.node-loads
>      26.79 ±  4%     -10.5       16.31 ± 12%  perf-stat.i.node-store-miss-rate%
>  1.785e+08 ±  2%     -27.7%  1.291e+08 ±  7%  perf-stat.i.node-store-misses
>  5.131e+08 ±  3%     +39.8%  7.172e+08 ±  5%  perf-stat.i.node-stores
>       6643            +4.8%       6959 ±  2%  perf-stat.i.page-faults
>       0.02 ± 18%      -0.0        0.01 ±  4%  perf-stat.overall.branch-miss-rate%
>       6.66 ±  2%     -22.5%       5.16 ±  3%  perf-stat.overall.cpi
>     539.35 ±  2%     -22.7%     416.69 ±  3%  perf-stat.overall.cycles-between-cache-misses
>       0.02 ±  3%      -0.0        0.01 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
>       0.15 ±  2%     +29.1%       0.19 ±  3%  perf-stat.overall.ipc
>      25.88 ±  4%     -10.6       15.28 ± 10%  perf-stat.overall.node-store-miss-rate%
>  1.325e+10 ±  2%     +22.3%  1.622e+10 ±  3%  perf-stat.ps.branch-instructions
>   6.88e+08 ±  2%     +22.7%  8.444e+08 ±  3%  perf-stat.ps.cache-misses
>  7.043e+08 ±  2%     +22.7%  8.638e+08 ±  3%  perf-stat.ps.cache-references
>  3.708e+11            -5.2%  3.515e+11        perf-stat.ps.cpu-cycles
>  1.577e+10 ±  2%     +22.4%  1.931e+10 ±  3%  perf-stat.ps.dTLB-loads
>     910623 ±  2%      -4.6%     868700        perf-stat.ps.dTLB-store-misses
>  5.701e+09 ±  2%     +22.3%  6.975e+09 ±  3%  perf-stat.ps.dTLB-stores
>  5.569e+10 ±  2%     +22.3%  6.813e+10 ±  3%  perf-stat.ps.instructions
>       6716            +4.8%       7038        perf-stat.ps.minor-faults
>     595302 ± 11%     +37.2%     816710 ±  8%  perf-stat.ps.node-loads
>  1.769e+08 ±  2%     -27.8%  1.277e+08 ±  7%  perf-stat.ps.node-store-misses
>  5.071e+08 ±  3%     +40.3%  7.113e+08 ±  5%  perf-stat.ps.node-stores
>       6717            +4.8%       7039        perf-stat.ps.page-faults
>       0.00            +0.8        0.80 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.rmqueue_bulk.get_page_from_freelist.__alloc_pages
>       0.00            +0.8        0.80 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.rmqueue_bulk.get_page_from_freelist.__alloc_pages.alloc_buddy_huge_page
>       0.00            +0.8        0.83 ±  8%  perf-profile.calltrace.cycles-pp.rmqueue_bulk.get_page_from_freelist.__alloc_pages.alloc_buddy_huge_page.alloc_fresh_huge_page
>       0.00            +0.8        0.84 ±  8%  perf-profile.calltrace.cycles-pp.__alloc_pages.alloc_buddy_huge_page.alloc_fresh_huge_page.alloc_surplus_huge_page.hugetlb_acct_memory
>       0.00            +0.8        0.84 ±  8%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.alloc_buddy_huge_page.alloc_fresh_huge_page.alloc_surplus_huge_page
>       0.00            +0.8        0.84 ±  8%  perf-profile.calltrace.cycles-pp.alloc_buddy_huge_page.alloc_fresh_huge_page.alloc_surplus_huge_page.hugetlb_acct_memory.hugetlb_reserve_pages
>       0.00            +0.9        0.85 ±  8%  perf-profile.calltrace.cycles-pp.alloc_fresh_huge_page.alloc_surplus_huge_page.hugetlb_acct_memory.hugetlb_reserve_pages.hugetlbfs_file_mmap
>       0.00            +0.9        0.88 ±  8%  perf-profile.calltrace.cycles-pp.alloc_surplus_huge_page.hugetlb_acct_memory.hugetlb_reserve_pages.hugetlbfs_file_mmap.mmap_region
>       0.00            +0.9        0.88 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
>       0.00            +0.9        0.88 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>       0.00            +0.9        0.88 ±  8%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>       0.00            +0.9        0.88 ±  8%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.9        0.88 ±  8%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
>       0.00            +0.9        0.88 ±  8%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>       0.00            +0.9        0.88 ±  8%  perf-profile.calltrace.cycles-pp.__mmap
>       0.00            +0.9        0.88 ±  8%  perf-profile.calltrace.cycles-pp.hugetlbfs_file_mmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
>       0.00            +0.9        0.88 ±  8%  perf-profile.calltrace.cycles-pp.hugetlb_reserve_pages.hugetlbfs_file_mmap.mmap_region.do_mmap.vm_mmap_pgoff
>       0.00            +0.9        0.88 ±  8%  perf-profile.calltrace.cycles-pp.hugetlb_acct_memory.hugetlb_reserve_pages.hugetlbfs_file_mmap.mmap_region.do_mmap
>      60.28 ±  5%      +4.7       64.98 ±  2%  perf-profile.calltrace.cycles-pp.do_rw_once
>       0.09 ±  8%      +0.0        0.11 ±  9%  perf-profile.children.cycles-pp.task_tick_fair
>       0.14 ±  7%      +0.0        0.17 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
>       0.20 ±  9%      +0.0        0.24 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
>       0.19 ±  9%      +0.0        0.24 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
>       0.19 ±  9%      +0.0        0.23 ±  4%  perf-profile.children.cycles-pp.update_process_times
>       0.24 ±  8%      +0.0        0.29 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>       0.40 ±  8%      +0.1        0.45 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>       0.39 ±  7%      +0.1        0.45 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
>       0.26 ± 71%      +0.6        0.86 ±  8%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>       0.28 ± 71%      +0.6        0.88 ±  8%  perf-profile.children.cycles-pp.__mmap
>       0.28 ± 71%      +0.6        0.88 ±  8%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
>       0.27 ± 71%      +0.6        0.88 ±  8%  perf-profile.children.cycles-pp.hugetlbfs_file_mmap
>       0.27 ± 71%      +0.6        0.88 ±  8%  perf-profile.children.cycles-pp.hugetlb_reserve_pages
>       0.27 ± 71%      +0.6        0.88 ±  8%  perf-profile.children.cycles-pp.hugetlb_acct_memory
>       0.27 ± 71%      +0.6        0.88 ±  8%  perf-profile.children.cycles-pp.alloc_surplus_huge_page
>       0.28 ± 71%      +0.6        0.88 ±  8%  perf-profile.children.cycles-pp.vm_mmap_pgoff
>       0.28 ± 71%      +0.6        0.88 ±  8%  perf-profile.children.cycles-pp.do_mmap
>       0.28 ± 71%      +0.6        0.88 ±  8%  perf-profile.children.cycles-pp.mmap_region
>       0.55 ± 44%      +0.6        1.16 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>       0.55 ± 44%      +0.6        1.16 ±  9%  perf-profile.children.cycles-pp.do_syscall_64
>       0.12 ± 71%      +0.7        0.85 ±  8%  perf-profile.children.cycles-pp.alloc_fresh_huge_page
>       0.03 ± 70%      +0.8        0.84 ±  8%  perf-profile.children.cycles-pp.alloc_buddy_huge_page
>       0.04 ± 71%      +0.8        0.84 ±  8%  perf-profile.children.cycles-pp.get_page_from_freelist
>       0.04 ± 71%      +0.8        0.84 ±  8%  perf-profile.children.cycles-pp.__alloc_pages
>       0.00            +0.8        0.82 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock
>       0.00            +0.8        0.83 ±  8%  perf-profile.children.cycles-pp.rmqueue_bulk
>       0.26 ± 71%      +0.6        0.86 ±  8%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> ---
> 0-DAY CI Kernel Test Service
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org
> 
> Thanks,
> Oliver Sang
> 

