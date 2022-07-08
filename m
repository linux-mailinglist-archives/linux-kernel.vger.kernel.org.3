Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AFF56B2B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbiGHGWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiGHGWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:22:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633A52CE3D;
        Thu,  7 Jul 2022 23:22:00 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LfNPd5KfxzTgRl;
        Fri,  8 Jul 2022 14:18:13 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 14:21:51 +0800
CC:     <yangyicong@hisilicon.com>, <corbet@lwn.net>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, <darren@os.amperecomputing.com>,
        <huzhanyuan@oppo.com>, <lipeifeng@oppo.com>,
        <zhangshiming@oppo.com>, <guojian@oppo.com>, <realmz6@gmail.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 4/4] arm64: support batched/deferred tlb shootdown during
 page reclamation
To:     Barry Song <21cnbao@gmail.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <x86@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20220707125242.425242-1-21cnbao@gmail.com>
 <20220707125242.425242-5-21cnbao@gmail.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <b41ce185-38c0-7fdb-fb19-2b219aab7e0f@huawei.com>
Date:   Fri, 8 Jul 2022 14:21:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220707125242.425242-5-21cnbao@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barry,

On 2022/7/7 20:52, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> on x86, batched and deferred tlb shootdown has lead to 90%
> performance increase on tlb shootdown. on arm64, HW can do
> tlb shootdown without software IPI. But sync tlbi is still
> quite expensive.
> 
> Even running a simplest program which requires swapout can
> prove this is true,
>  #include <sys/types.h>
>  #include <unistd.h>
>  #include <sys/mman.h>
>  #include <string.h>
> 
>  int main()
>  {
>  #define SIZE (1 * 1024 * 1024)
>          volatile unsigned char *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>                                           MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> 
>          memset(p, 0x88, SIZE);
> 
>          for (int k = 0; k < 10000; k++) {
>                  /* swap in */
>                  for (int i = 0; i < SIZE; i += 4096) {
>                          (void)p[i];
>                  }
> 
>                  /* swap out */
>                  madvise(p, SIZE, MADV_PAGEOUT);
>          }
>  }
> 
> Perf result on snapdragon 888 with 8 cores by using zRAM
> as the swap block device.
> 
>  ~ # perf record taskset -c 4 ./a.out
>  [ perf record: Woken up 10 times to write data ]
>  [ perf record: Captured and wrote 2.297 MB perf.data (60084 samples) ]
>  ~ # perf report
>  # To display the perf.data header info, please use --header/--header-only options.
>  # To display the perf.data header info, please use --header/--header-only options.
>  #
>  #
>  # Total Lost Samples: 0
>  #
>  # Samples: 60K of event 'cycles'
>  # Event count (approx.): 35706225414
>  #
>  # Overhead  Command  Shared Object      Symbol
>  # ........  .......  .................  .............................................................................
>  #
>     21.07%  a.out    [kernel.kallsyms]  [k] _raw_spin_unlock_irq
>      8.23%  a.out    [kernel.kallsyms]  [k] _raw_spin_unlock_irqrestore
>      6.67%  a.out    [kernel.kallsyms]  [k] filemap_map_pages
>      6.16%  a.out    [kernel.kallsyms]  [k] __zram_bvec_write
>      5.36%  a.out    [kernel.kallsyms]  [k] ptep_clear_flush
>      3.71%  a.out    [kernel.kallsyms]  [k] _raw_spin_lock
>      3.49%  a.out    [kernel.kallsyms]  [k] memset64
>      1.63%  a.out    [kernel.kallsyms]  [k] clear_page
>      1.42%  a.out    [kernel.kallsyms]  [k] _raw_spin_unlock
>      1.26%  a.out    [kernel.kallsyms]  [k] mod_zone_state.llvm.8525150236079521930
>      1.23%  a.out    [kernel.kallsyms]  [k] xas_load
>      1.15%  a.out    [kernel.kallsyms]  [k] zram_slot_lock
> 
> ptep_clear_flush() takes 5.36% CPU in the micro-benchmark
> swapping in/out a page mapped by only one process. If the
> page is mapped by multiple processes, typically, like more
> than 100 on a phone, the overhead would be much higher as
> we have to run tlb flush 100 times for one single page.
> Plus, tlb flush overhead will increase with the number
> of CPU cores due to the bad scalability of tlb shootdown
> in HW, so those ARM64 servers should expect much higher
> overhead.
> 
> Further perf annonate shows 95% cpu time of ptep_clear_flush
> is actually used by the final dsb() to wait for the completion
> of tlb flush. This provides us a very good chance to leverage
> the existing batched tlb in kernel. The minimum modification
> is that we only send async tlbi in the first stage and we send
> dsb while we have to sync in the second stage.
> 
> With the above simplest micro benchmark, collapsed time to
> finish the program decreases around 5%.
> 
> Typical collapsed time w/o patch:
>  ~ # time taskset -c 4 ./a.out
>  0.21user 14.34system 0:14.69elapsed
> w/ patch:
>  ~ # time taskset -c 4 ./a.out
>  0.22user 13.45system 0:13.80elapsed
> 

Tested with benchmark in the commit on Kunpeng920 arm64 server, observed an improvement
around 12.5% with command `time ./swap_bench`.
	w/o		w/
real	0m13.460s	0m11.771s
user	0m0.248s	0m0.279s
sys	0m12.039s	0m11.458s

Originally it's noticed a 16.99% overhead of ptep_clear_flush() which has been eliminated
by this patch:

[root@localhost yang]# perf record -- ./swap_bench && perf report
[...]
    16.99%  swap_bench  [kernel.kallsyms]  [k] ptep_clear_flush

Feel free to add:
Tested-by: Yicong Yang <yangyicong@hisilicon.com>


> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Nadav Amit <namit@vmware.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  Documentation/features/vm/TLB/arch-support.txt |  2 +-
>  arch/arm64/Kconfig                             |  1 +
>  arch/arm64/include/asm/tlbbatch.h              | 12 ++++++++++++
>  arch/arm64/include/asm/tlbflush.h              | 13 +++++++++++++
>  4 files changed, 27 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/tlbbatch.h
> 
> diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
> index 1c009312b9c1..2caf815d7c6c 100644
> --- a/Documentation/features/vm/TLB/arch-support.txt
> +++ b/Documentation/features/vm/TLB/arch-support.txt
> @@ -9,7 +9,7 @@
>      |       alpha: | TODO |
>      |         arc: | TODO |
>      |         arm: | TODO |
> -    |       arm64: | TODO |
> +    |       arm64: |  ok  |
>      |        csky: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1652a9800ebe..e94913a0b040 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -93,6 +93,7 @@ config ARM64
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>  	select ARCH_SUPPORTS_NUMA_BALANCING
>  	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
> +	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
>  	select ARCH_WANT_DEFAULT_BPF_JIT
>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> diff --git a/arch/arm64/include/asm/tlbbatch.h b/arch/arm64/include/asm/tlbbatch.h
> new file mode 100644
> index 000000000000..fedb0b87b8db
> --- /dev/null
> +++ b/arch/arm64/include/asm/tlbbatch.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ARCH_ARM64_TLBBATCH_H
> +#define _ARCH_ARM64_TLBBATCH_H
> +
> +struct arch_tlbflush_unmap_batch {
> +	/*
> +	 * For arm64, HW can do tlb shootdown, so we don't
> +	 * need to record cpumask for sending IPI
> +	 */
> +};
> +
> +#endif /* _ARCH_ARM64_TLBBATCH_H */
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 412a3b9a3c25..b3ed163267ca 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -272,6 +272,19 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
>  	dsb(ish);
>  }
>  
> +static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
> +					struct mm_struct *mm,
> +					struct vm_area_struct *vma,
> +					unsigned long uaddr)
> +{
> +	flush_tlb_page_nosync(vma, uaddr);
> +}
> +
> +static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> +{
> +	dsb(ish);
> +}
> +
>  /*
>   * This is meant to avoid soft lock-ups on large TLB flushing ranges and not
>   * necessarily a performance improvement.
> 
