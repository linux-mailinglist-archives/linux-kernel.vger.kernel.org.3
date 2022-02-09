Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AD24AEE1A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbiBIJcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:32:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbiBIJbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:31:23 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04F2E04A83B;
        Wed,  9 Feb 2022 01:31:16 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JttwW0D3RzbkLT;
        Wed,  9 Feb 2022 16:54:19 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 16:55:20 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Feb
 2022 16:55:19 +0800
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <frederic@kernel.org>, <tglx@linutronix.de>, <mtosatti@redhat.com>,
        <mgorman@suse.de>, <linux-rt-users@vger.kernel.org>,
        <vbabka@suse.cz>, <cl@linux.com>, <paulmck@kernel.org>,
        <willy@infradead.org>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <7c87f388-cc50-e9a1-17a7-802bb42656e4@huawei.com>
Date:   Wed, 9 Feb 2022 16:55:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20220208100750.1189808-1-nsaenzju@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas，

When I applied the patchset on the following commit and tested on QEMU, I came
accross the following CallTrace.
  commit dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0

I wrote a userspace application to consume the memory. When the memory is used
out, the OOM killer is triggered and the following Calltrace is printed. I am
not sure if it is related to this patchset. But when I reverted this patchset,
the 'NULL pointer' Calltrace didn't show.

root@syzkaller:~# [  148.041840][  T476] Unable to handle kernel NULL pointer
dereference at virtual address 0000000000000058
[  148.042838][  T476] Mem abort info:
[  148.043188][  T476]   ESR = 0x96000004
[  148.043540][  T476]   EC = 0x25: DABT (current EL), IL = 32 bits
[  148.044102][  T476]   SET = 0, FnV = 0
[  148.044451][  T476]   EA = 0, S1PTW = 0
[  148.044812][  T476]   FSC = 0x04: level 0 translation fault
[  148.045333][  T476] Data abort info:
[  148.045666][  T476]   ISV = 0, ISS = 0x00000004
[  148.046103][  T476]   CM = 0, WnR = 0
[  148.046444][  T476] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000abcec000
[  148.047187][  T476] [0000000000000058] pgd=0000000000000000, p4d=0000000000000000
[  148.047915][  T476] Internal error: Oops: 96000004 [#1] SMP
[  148.048450][  T476] Dumping ftrace buffer:
[  148.048843][  T476]    (ftrace buffer empty)
[  148.049473][  T476] Modules linked in:
[  148.049834][  T476] CPU: 1 PID: 476 Comm: test Not tainted 5.17.0-rc1+ #19
[  148.050485][  T476] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
02/06/2015
[  148.051242][  T476] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[  148.052019][  T476] pc : __drain_all_pages+0x1c4/0x318
[  148.052548][  T476] lr : __drain_all_pages+0x1a0/0x318
[  148.053070][  T476] sp : ffff80000ce9ba20
[  148.053477][  T476] x29: ffff80000ce9ba20 x28: 0000000000000000 x27:
0000000000000000
[  148.054268][  T476] x26: 0000000000000000 x25: ffff800009799000 x24:
0000000000000000
[  148.055067][  T476] x23: ffff80000979f460 x22: ffff800009bac000 x21:
ffff800009ed7110
[  148.055997][  T476] x20: ffff80000979a000 x19: 0000000000000000 x18:
0000000000000000
[  148.056784][  T476] x17: 0000000000000000 x16: 0000000000000000 x15:
0000000000000000
[  148.058493][  T476] x14: 0000000000000000 x13: 0000000000000000 x12:
ffff80000ce9b558
[  148.059649][  T476] x11: 0000000000000000 x10: ffff000bfffe6240 x9 :
0000000000000002
[  148.060775][  T476] x8 : 0000000000000000 x7 : ffffffffffffffff x6 :
0000000000000000
[  148.061609][  T476] x5 : 0000000000000000 x4 : ffff80000979bb70 x3 :
ffff800bf6a18000
[  148.062435][  T476] x2 : 0000000000000080 x1 : 00000000000c0000 x0 :
ffff000bfffe6240
[  148.063267][  T476] Call trace:
[  148.063602][  T476]  __drain_all_pages+0x1c4/0x318
[  148.064110][  T476]  __alloc_pages_slowpath.constprop.126+0x328/0xac8
[  148.064790][  T476]  __alloc_pages+0x270/0x330
[  148.065260][  T476]  alloc_pages+0xb0/0x160
[  148.065703][  T476]  __pte_alloc+0x44/0x180
[  148.066147][  T476]  __handle_mm_fault+0x59c/0xb30
[  148.066656][  T476]  handle_mm_fault+0xc4/0x210
[  148.067139][  T476]  do_page_fault+0x1cc/0x480
[  148.067607][  T476]  do_translation_fault+0x80/0x98
[  148.068265][  T476]  do_mem_abort+0x50/0xa0
[  148.068724][  T476]  el0_da+0x40/0x118
[  148.069132][  T476]  el0t_64_sync_handler+0x60/0xb0
[  148.069659][  T476]  el0t_64_sync+0x16c/0x170
[  148.070127][  T476] Code: b4fff7e0 f9404401 b4ffffa1 f87c7ae3 (f9402f01)
[  148.070874][  T476] ---[ end trace 0000000000000000 ]---
[  149.059678][  T229] systemd-journal invoked oom-killer:
gfp_mask=0x1140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), order=0, oom_score_adj=0
[  149.064280][  T229] CPU: 0 PID: 229 Comm: systemd-journal Tainted: G      D
        5.17.0-rc1+ #19
[  149.069110][  T229] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
02/06/2015
[  149.073070][  T229] Call trace:
[  149.074392][  T229]  dump_backtrace+0x114/0x120
[  149.077045][  T229]  show_stack+0x2c/0x78
[  149.079680][  T229]  dump_stack_lvl+0x64/0x7c
[  149.081741][  T229]  dump_stack+0x14/0x2c
[  149.083760][  T229]  dump_header+0x48/0x200
[  149.085772][  T229]  oom_kill_process+0x230/0x2e0
[  149.087877][  T229]  out_of_memory+0xf0/0x5a8
[  149.090776][  T229]  __alloc_pages_slowpath.constprop.126+0x830/0xac8
[  149.103397][  T229]  __alloc_pages+0x270/0x330
[  149.112662][  T229]  alloc_pages+0xb0/0x160
[  149.113088][  T229]  folio_alloc+0x28/0x50
[  149.113504][  T229]  filemap_alloc_folio+0x98/0xc8
[  149.113990][  T229]  __filemap_get_folio+0x194/0x2f0
[  149.114492][  T229]  filemap_fault+0x434/0x708
[  149.115799][  T229]  __do_fault+0x3c/0x118
[  149.117842][  T229]  do_fault+0x160/0x428
[  149.119893][  T229]  __handle_mm_fault+0x498/0xb30
[  149.123249][  T229]  handle_mm_fault+0xc4/0x210
[  149.125558][  T229]  do_page_fault+0x1cc/0x480
[  149.128347][  T229]  do_translation_fault+0x80/0x98
[  149.130444][  T229]  do_mem_abort+0x50/0xa0
[  149.132513][  T229]  el0_da+0x40/0x118
[  149.135152][  T229]  el0t_64_sync_handler+0x60/0xb0
[  149.137802][  T229]  el0t_64_sync+0x16c/0x170
[  149.140088][  T229] Mem-Info:
[  149.141197][  T229] active_anon:108 inactive_anon:12226341 isolated_anon:0
[  149.141197][  T229]  active_file:68 inactive_file:6 isolated_file:0
[  149.141197][  T229]  unevictable:0 dirty:0 writeback:0
[  149.141197][  T229]  slab_reclaimable:5964 slab_unreclaimable:14242
[  149.141197][  T229]  mapped:41 shmem:995 pagetables:24564 bounce:0
[  149.141197][  T229]  kernel_misc_reclaimable:0
[  149.141197][  T229]  free:52077 free_pcp:1845 free_cma:13312

Thanks,
Xiongfeng

On 2022/2/8 18:07, Nicolas Saenz Julienne wrote:
> This series replaces mm/page_alloc's per-cpu page lists drain mechanism with
> one that allows accessing the lists remotely. Currently, only a local CPU is
> permitted to change its per-cpu lists, and it's expected to do so, on-demand,
> whenever a process demands it by means of queueing a drain task on the local
> CPU. This causes problems for NOHZ_FULL CPUs and real-time systems that can't
> take any sort of interruption and to some lesser extent inconveniences idle and
> virtualised systems.
> 
> The new algorithm will atomically switch the pointer to the per-cpu page lists
> and use RCU to make sure it's not being concurrently used before draining the
> lists. And its main benefit of is that it fixes the issue for good, avoiding
> the need for configuration based heuristics or having to modify applications
> (i.e. using the isolation prctrl being worked by Marcello Tosatti ATM).
> 
> All this with minimal performance implications: a page allocation
> microbenchmark was run on multiple systems and architectures generally showing
> no performance differences, only the more extreme cases showed a 1-3%
> degradation. See data below. Needless to say that I'd appreciate if someone
> could validate my values independently.
> 
> The approach has been stress-tested: I forced 100 drains/s while running
> mmtests' pft in a loop for a full day on multiple machines and archs (arm64,
> x86_64, ppc64le).
> 
> Note that this is not the first attempt at fixing this per-cpu page lists:
>  - The first attempt[1] tried to conditionally change the pagesets locking
>    scheme based the NOHZ_FULL config. It was deemed hard to maintain as the
>    NOHZ_FULL code path would be rarely tested. Also, this only solves the issue
>    for NOHZ_FULL setups, which isn't ideal.
>  - The second[2] unanimously switched the local_locks to per-cpu spinlocks. The
>    performance degradation was too big.
> 
> Previous RFC: https://lkml.org/lkml/2021/10/8/793
> 
> Thanks!
> 
> [1] https://lkml.org/lkml/2021/9/21/599
> [2] https://lkml.org/lkml/2021/11/3/644
> 
> ---
> 
> Changes since RFC:
>  - Get rid of aesthetic changes that affected performance
>  - Add more documentation
>  - Add better commit messages
>  - Pass sparse tests
>  - Verify this_cpu_*() usage
>  - Performance measurements
> 
> Nicolas Saenz Julienne (2):
>   mm/page_alloc: Access lists in 'struct per_cpu_pages' indirectly
>   mm/page_alloc: Add remote draining support to per-cpu lists
> 
>  include/linux/mmzone.h |  28 +++++-
>  mm/page_alloc.c        | 212 ++++++++++++++++++++++++++---------------
>  mm/vmstat.c            |   6 +-
>  3 files changed, 162 insertions(+), 84 deletions(-)
> 
> 
> -------------------------Performance results-----------------------------
> 
> I'm focusing on mmtests' Page Fault Test (pft), as it's page allocator
> intensive.
> 
> - AMD Daytona Reference System, 2 sockets, AMD EPYC 7742, Zen 2, 64-Core,
>   4 NUMA nodes, x86_64
> 
> pft timings:
>                                      vanilla                    rcu
> Amean     system-1          58.52 (   0.00%)       58.92 *  -0.68%*
> Amean     system-4          61.00 (   0.00%)       61.41 *  -0.67%*
> Amean     system-7          61.55 (   0.00%)       61.74 *  -0.30%*
> Amean     system-12         64.91 (   0.00%)       64.94 *  -0.05%*
> Amean     system-21         98.80 (   0.00%)       99.92 *  -1.13%*
> Amean     system-30        147.68 (   0.00%)      145.83 *   1.25%*
> Amean     system-48        237.04 (   0.00%)      241.29 *  -1.79%*
> Amean     system-79        286.61 (   0.00%)      283.72 *   1.01%*
> Amean     system-110       303.40 (   0.00%)      299.91 *   1.15%*
> Amean     system-128       345.07 (   0.00%)      342.10 *   0.86%*
> Amean     elapsed-1         61.21 (   0.00%)       61.65 *  -0.71%*
> Amean     elapsed-4         15.94 (   0.00%)       16.05 *  -0.69%*
> Amean     elapsed-7          9.24 (   0.00%)        9.28 *  -0.47%*
> Amean     elapsed-12         5.70 (   0.00%)        5.70 *  -0.07%*
> Amean     elapsed-21         5.11 (   0.00%)        5.06 *   1.13%*
> Amean     elapsed-30         5.28 (   0.00%)        5.14 *   2.73%*
> Amean     elapsed-48         5.28 (   0.00%)        5.24 *   0.74%*
> Amean     elapsed-79         4.41 (   0.00%)        4.31 *   2.17%*
> Amean     elapsed-110        3.45 (   0.00%)        3.44 *   0.40%*
> Amean     elapsed-128        2.75 (   0.00%)        2.75 *  -0.28%*
> 
> - AMD Speedway Reference System, 2 sockets, AMD EPYC 7601, Zen 1, 64-core, 8
>   NUMA nodes, x86_64. Lots of variance between tests on this platform. It'll
>   easily swing -+5% on each result. 
> 
> pft timings:
>                                      vanilla                    rcu
> Amean     system-1          69.20 (   0.00%)       66.21 *   4.32%*
> Amean     system-4          70.79 (   0.00%)       69.01 *   2.52%*
> Amean     system-7          71.34 (   0.00%)       69.16 *   3.05%*
> Amean     system-12         74.00 (   0.00%)       72.74 *   1.70%*
> Amean     system-21         86.01 (   0.00%)       85.70 *   0.36%*
> Amean     system-30         89.21 (   0.00%)       89.93 *  -0.80%*
> Amean     system-48         92.39 (   0.00%)       92.43 *  -0.04%*
> Amean     system-79        120.19 (   0.00%)      121.30 *  -0.92%*
> Amean     system-110       172.79 (   0.00%)      179.37 *  -3.81%*
> Amean     system-128       201.70 (   0.00%)      212.57 *  -5.39%*
> Amean     elapsed-1         72.23 (   0.00%)       69.29 *   4.08%*
> Amean     elapsed-4         18.69 (   0.00%)       18.28 *   2.20%*
> Amean     elapsed-7         10.80 (   0.00%)       10.54 *   2.41%*
> Amean     elapsed-12         6.62 (   0.00%)        6.53 *   1.30%*
> Amean     elapsed-21         4.68 (   0.00%)        4.69 *  -0.14%*
> Amean     elapsed-30         3.44 (   0.00%)        3.50 *  -1.66%*
> Amean     elapsed-48         2.40 (   0.00%)        2.42 *  -1.00%*
> Amean     elapsed-79         2.05 (   0.00%)        2.09 *  -1.90%*
> Amean     elapsed-110        1.83 (   0.00%)        1.91 *  -4.60%*
> Amean     elapsed-128        1.75 (   0.00%)        1.85 *  -5.99%*
> 
> - IBM 9006-22C system, 2 sockets, POWER9, 64-Core, 1 NUMA node per cpu,
>   pppc64le.
> 
> pft timings:
>                                      vanilla                    rcu
> Amean     system-1           1.82 (   0.00%)        1.85 *  -1.43%*
> Amean     system-4           2.18 (   0.00%)        2.22 *  -2.02%*
> Amean     system-7           3.27 (   0.00%)        3.28 *  -0.15%*
> Amean     system-12          5.22 (   0.00%)        5.20 *   0.26%*
> Amean     system-21         10.10 (   0.00%)       10.20 *  -1.00%*
> Amean     system-30         15.00 (   0.00%)       14.52 *   3.20%*
> Amean     system-48         26.41 (   0.00%)       25.96 *   1.71%*
> Amean     system-79         29.35 (   0.00%)       29.70 *  -1.21%*
> Amean     system-110        24.01 (   0.00%)       23.40 *   2.54%*
> Amean     system-128        24.57 (   0.00%)       25.32 *  -3.06%*
> Amean     elapsed-1          1.85 (   0.00%)        1.87 *  -1.28%*
> Amean     elapsed-4          0.56 (   0.00%)        0.57 *  -1.72%*
> Amean     elapsed-7          0.51 (   0.00%)        0.50 *   0.07%*
> Amean     elapsed-12         0.51 (   0.00%)        0.51 *   0.06%*
> Amean     elapsed-21         0.54 (   0.00%)        0.54 *   0.06%*
> Amean     elapsed-30         0.54 (   0.00%)        0.53 *   2.22%*
> Amean     elapsed-48         0.58 (   0.00%)        0.57 *   1.73%*
> Amean     elapsed-79         0.49 (   0.00%)        0.48 *   0.89%*
> Amean     elapsed-110        0.37 (   0.00%)        0.37 *  -1.08%*
> Amean     elapsed-128        0.33 (   0.00%)        0.33 *   0.00%*
> 
> - Ampere MtSnow, 1 socket, Neoverse-N1, 80-Cores, 1 NUMA node, arm64.
> 
> pft timings:
>                                     vanilla		       rcu
> Amean     system-1         11.92 (   0.00%)       11.99 *  -0.61%*
> Amean     system-4         13.13 (   0.00%)       13.09 *   0.31%*
> Amean     system-7         13.91 (   0.00%)       13.94 *  -0.20%*
> Amean     system-12        15.77 (   0.00%)       15.69 *   0.48%*
> Amean     system-21        21.32 (   0.00%)       21.42 *  -0.46%*
> Amean     system-30        28.58 (   0.00%)       29.12 *  -1.90%*
> Amean     system-48        47.41 (   0.00%)       46.91 *   1.04%*
> Amean     system-79        76.76 (   0.00%)       77.16 *  -0.52%*
> Amean     system-80        77.98 (   0.00%)       78.23 *  -0.32%*
> Amean     elapsed-1        12.46 (   0.00%)       12.53 *  -0.58%*
> Amean     elapsed-4         3.47 (   0.00%)        3.46 *   0.34%*
> Amean     elapsed-7         2.18 (   0.00%)        2.21 *  -1.58%*
> Amean     elapsed-12        1.41 (   0.00%)        1.42 *  -0.80%*
> Amean     elapsed-21        1.09 (   0.00%)        1.12 *  -2.60%*
> Amean     elapsed-30        0.98 (   0.00%)        1.01 *  -3.08%*
> Amean     elapsed-48        1.08 (   0.00%)        1.10 *  -1.78%*
> Amean     elapsed-79        1.32 (   0.00%)        1.28 *   2.71%*
> Amean     elapsed-80        1.32 (   0.00%)        1.28 *   3.23%*
> 
> - Dell R430, 2 sockets, Intel Xeon E5-2640 v3, Sandy Bridge, 16-Cores, 2 NUMA
>   nodes, x86_64.
> 
> pft timings:
>                                     vanilla		       rcu
> Amean     system-1         11.10 (   0.00%)       11.07 *   0.24%*
> Amean     system-3         11.14 (   0.00%)       11.10 *   0.34%*
> Amean     system-5         11.18 (   0.00%)       11.13 *   0.47%*
> Amean     system-7         11.21 (   0.00%)       11.17 *   0.38%*
> Amean     system-12        11.28 (   0.00%)       11.28 (  -0.03%)
> Amean     system-18        13.24 (   0.00%)       13.25 *  -0.11%*
> Amean     system-24        17.12 (   0.00%)       17.14 (  -0.13%)
> Amean     system-30        21.10 (   0.00%)       21.23 *  -0.60%*
> Amean     system-32        22.31 (   0.00%)       22.47 *  -0.71%*
> Amean     elapsed-1        11.76 (   0.00%)       11.73 *   0.29%*
> Amean     elapsed-3         3.93 (   0.00%)        3.93 *   0.17%*
> Amean     elapsed-5         2.39 (   0.00%)        2.37 *   0.74%*
> Amean     elapsed-7         1.72 (   0.00%)        1.71 *   0.81%*
> Amean     elapsed-12        1.02 (   0.00%)        1.03 (  -0.42%)
> Amean     elapsed-18        1.13 (   0.00%)        1.14 (  -0.18%)
> Amean     elapsed-24        0.87 (   0.00%)        0.88 *  -0.65%*
> Amean     elapsed-30        0.77 (   0.00%)        0.78 *  -0.86%*
> Amean     elapsed-32        0.74 (   0.00%)        0.74 (   0.00%)
> 
> - HPE Apollo 70, 2 sockets, Cavium ThunderX2, 128-Cores, 2 NUMA nodes, arm64.
>   NOTE: The test here only goes up to 128 for some reason, although there are
>   256 CPUs. Maybe a mmtests issue? I didn't investigate.
> 
> pft timings:
>                                      vanilla		        rcu
> Amean     system-1           4.42 (   0.00%)        4.36 *   1.29%*
> Amean     system-4           4.56 (   0.00%)        4.51 *   1.05%*
> Amean     system-7           4.63 (   0.00%)        4.65 *  -0.42%*
> Amean     system-12          5.96 (   0.00%)        6.02 *  -1.00%*
> Amean     system-21         10.97 (   0.00%)       11.01 *  -0.32%*
> Amean     system-30         16.01 (   0.00%)       16.04 *  -0.19%*
> Amean     system-48         26.81 (   0.00%)       26.78 *   0.09%*
> Amean     system-79         30.80 (   0.00%)       30.85 *  -0.16%*
> Amean     system-110        31.87 (   0.00%)       31.93 *  -0.19%*
> Amean     system-128        36.27 (   0.00%)       36.31 *  -0.10%*
> Amean     elapsed-1          4.88 (   0.00%)        4.85 *   0.60%*
> Amean     elapsed-4          1.27 (   0.00%)        1.26 *   1.00%*
> Amean     elapsed-7          0.73 (   0.00%)        0.74 *  -0.46%*
> Amean     elapsed-12         0.55 (   0.00%)        0.55 *   1.09%*
> Amean     elapsed-21         0.59 (   0.00%)        0.60 *  -0.96%*
> Amean     elapsed-30         0.60 (   0.00%)        0.60 *   0.28%*
> Amean     elapsed-48         0.60 (   0.00%)        0.60 *   0.44%*
> Amean     elapsed-79         0.49 (   0.00%)        0.49 *  -0.07%*
> Amean     elapsed-110        0.36 (   0.00%)        0.36 *   0.28%*
> Amean     elapsed-128        0.31 (   0.00%)        0.31 *  -0.43%*
> 
> - Raspberry Pi 4, 1 socket, bcm2711, Cortex-A72, 4-Cores, 1 NUMA node, arm64.
> 
> pft timings:
>                                    vanilla		      rcu
> Amean     system-1         0.67 (   0.00%)        0.67 *  -1.25%*
> Amean     system-3         1.30 (   0.00%)        1.29 *   0.62%*
> Amean     system-4         1.61 (   0.00%)        1.59 *   0.95%*
> Amean     elapsed-1        0.71 (   0.00%)        0.72 *  -1.17%*
> Amean     elapsed-3        0.45 (   0.00%)        0.45 *   0.88%*
> Amean     elapsed-4        0.42 (   0.00%)        0.42 *   1.19%*
> 
> 
