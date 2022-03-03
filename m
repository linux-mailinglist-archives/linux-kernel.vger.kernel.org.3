Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D214CBED8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiCCN2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiCCN2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:28:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C133887BE;
        Thu,  3 Mar 2022 05:27:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 28FAE1F383;
        Thu,  3 Mar 2022 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646314066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FbQGutOAmDCcaaQzmGDSVnv3FmYOs+gyUtGPuTxEh3c=;
        b=byO7yCMxfX/wc02G+wRTrj+WjjEpiA3aTQqWJiqc6j9lzPIJjOlvLEXfM3/SB3Mkcdf+lB
        iRGrWz/cUJjZ50Fs/PdC5atldIKSjBjVXmw6qRakRcziAQjxY6p2BzSHyPcPpohGkmLa+W
        gwIfsLWpHSDFmXUPH9NJaTh51CuVCpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646314066;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FbQGutOAmDCcaaQzmGDSVnv3FmYOs+gyUtGPuTxEh3c=;
        b=2YFSu4Gf3sIxOXTsEoaSXz1hWPC6YtE59KhBNV9+LbR9osNx/nMNHipLJPbR6ueN9/Hofx
        0hHtx4mrG4QB2iAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E90C213C23;
        Thu,  3 Mar 2022 13:27:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CG4jOFHCIGIxWwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 03 Mar 2022 13:27:45 +0000
Message-ID: <ad999259-0ea9-06f4-eec0-bba5372bbb0a@suse.cz>
Date:   Thu, 3 Mar 2022 14:27:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, mtosatti@redhat.com,
        mgorman@suse.de, linux-rt-users@vger.kernel.org, cl@linux.com,
        paulmck@kernel.org, willy@infradead.org
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220208100750.1189808-1-nsaenzju@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 11:07, Nicolas Saenz Julienne wrote:
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

For completeness, what was the fate of the approach to have pcp->high = 0
for NOHZ cpus? [1] It would be nice to have documented why it wasn't
feasible. Too much overhead for when these CPUs eventually do allocate, or
some other unforeseen issue? Thanks.

[1]
https://lore.kernel.org/all/43462fe11258395f4e885c3d594a3ed1b604b858.camel@redhat.com/

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

