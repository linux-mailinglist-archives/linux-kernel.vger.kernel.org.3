Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6D84E2729
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347692AbiCUNFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347679AbiCUNEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:04:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3CF21B0;
        Mon, 21 Mar 2022 06:03:29 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22LC415D010632;
        Mon, 21 Mar 2022 13:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=9q5x7jpzH9Kb8+FLz9u89zDvKSGyC1oaIx+i6oW/HNM=;
 b=Op5eDAALkL4ufuldSPM++aY5vqiCWENsrfEPEoSF1kXOQSIDDc6aAPQm+VSFQg1XrXMZ
 Cnw3atW3I5h3aQcHkZnowzfEbpuGCNztHKXAE2/z+t1EFKBphDpbiWBj6L3VBpnuClDW
 D1WR9CYKlT8B5OO4oM5JEaGoHeA7nA8z/rE4oiMppmSLaouz/Y6YMJvlntcunbS2NcLT
 B6LsX05tvOS0lqJ3peHrsWUrBETdVTyWowD0xu5LY/+d6mfcimk9/6bPiTGQwf3xjuZB
 oNnoz6av38QFX01iQHQV09hZN8SqGkstqAKb5FbYkRufuNH5Mr7mf1RAecrD2WBOlsEB pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3exppbm4dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 13:01:58 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22LC5WvT026483;
        Mon, 21 Mar 2022 13:01:57 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3exppbm4cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 13:01:56 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22LCvPKU000463;
        Mon, 21 Mar 2022 13:01:55 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01wdc.us.ibm.com with ESMTP id 3ew6t8ncus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 13:01:55 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22LD1sg016253284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 13:01:54 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A25BBE056;
        Mon, 21 Mar 2022 13:01:54 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AD81BE059;
        Mon, 21 Mar 2022 13:01:39 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.41.132])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 21 Mar 2022 13:01:39 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?utf-8?Q?Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v9 06/14] mm: multi-gen LRU: minimal implementation
In-Reply-To: <20220309021230.721028-7-yuzhao@google.com>
References: <20220309021230.721028-1-yuzhao@google.com>
 <20220309021230.721028-7-yuzhao@google.com>
Date:   Mon, 21 Mar 2022 18:31:36 +0530
Message-ID: <87a6dj793j.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EclEponSA0OxvGCNiA4_beJ9dykZ1kuZ
X-Proofpoint-GUID: cYsxcsw5Zm1m1Yp3PYGmzehV4oBKwLM8
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_05,2022-03-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203210085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> To avoid confusion, the terms "promotion" and "demotion" will be
> applied to the multi-gen LRU, as a new convention; the terms
> "activation" and "deactivation" will be applied to the active/inactive
> LRU, as usual.
>
> The aging produces young generations. Given an lruvec, it increments
> max_seq when max_seq-min_seq+1 approaches MIN_NR_GENS. The aging
> promotes hot pages to the youngest generation when it finds them
> accessed through page tables; the demotion of cold pages happens
> consequently when it increments max_seq. The aging has the complexity
> O(nr_hot_pages), since it is only interested in hot pages. Promotion
> in the aging path does not require any LRU list operations, only the
> updates of the gen counter and lrugen->nr_pages[]; demotion, unless as
> the result of the increment of max_seq, requires LRU list operations,
> e.g., lru_deactivate_fn().
>
> The eviction consumes old generations. Given an lruvec, it increments
> min_seq when the lists indexed by min_seq%MAX_NR_GENS become empty. A
> feedback loop modeled after the PID controller monitors refaults over
> anon and file types and decides which type to evict when both types
> are available from the same generation.
>
> Each generation is divided into multiple tiers. Tiers represent
> different ranges of numbers of accesses through file descriptors. A
> page accessed N times through file descriptors is in tier
> order_base_2(N). Tiers do not have dedicated lrugen->lists[], only
> bits in folio->flags. In contrast to moving across generations, which
> requires the LRU lock, moving across tiers only involves operations on
> folio->flags. The feedback loop also monitors refaults over all tiers
> and decides when to protect pages in which tiers (N>1), using the
> first tier (N=0,1) as a baseline. The first tier contains single-use
> unmapped clean pages, which are most likely the best choices. The
> eviction moves a page to the next generation, i.e., min_seq+1, if the
> feedback loop decides so. This approach has the following advantages:
> 1. It removes the cost of activation in the buffered access path by
>    inferring whether pages accessed multiple times through file
>    descriptors are statistically hot and thus worth protecting in the
>    eviction path.
> 2. It takes pages accessed through page tables into account and avoids
>    overprotecting pages accessed multiple times through file
>    descriptors. (Pages accessed through page tables are in the first
>    tier, since N=0.)
> 3. More tiers provide better protection for pages accessed more than
>    twice through file descriptors, when under heavy buffered I/O
>    workloads.
>
> Server benchmark results:
>   Single workload:
>     fio (buffered I/O): +[47, 49]%
>                 IOPS         BW
>       5.17-rc2: 2242k        8759MiB/s
>       patch1-5: 3321k        12.7GiB/s
>
>   Single workload:
>     memcached (anon): +[101, 105]%
>                 Ops/sec      KB/sec
>       5.17-rc2: 476771.79    18544.31
>       patch1-5: 972526.07    37826.95
>
>   Configurations:
>     CPU: two Xeon 6154
>     Mem: total 256G
>
>     Node 1 was only used as a ram disk to reduce the variance in the
>     results.
>
>     patch drivers/block/brd.c <<EOF
>     99,100c99,100
>     < 	gfp_flags = GFP_NOIO | __GFP_ZERO | __GFP_HIGHMEM;
>     < 	page = alloc_page(gfp_flags);
>     ---
>     > 	gfp_flags = GFP_NOIO | __GFP_ZERO | __GFP_HIGHMEM | __GFP_THISNODE;
>     > 	page = alloc_pages_node(1, gfp_flags, 0);
>     EOF
>
>     cat >>/etc/systemd/system.conf <<EOF
>     CPUAffinity=numa
>     NUMAPolicy=bind
>     NUMAMask=0
>     EOF
>
>     cat >>/etc/memcached.conf <<EOF
>     -m 184320
>     -s /var/run/memcached/memcached.sock
>     -a 0766
>     -t 36
>     -B binary
>     EOF
>
>     cat fio.sh
>     modprobe brd rd_nr=1 rd_size=113246208
>     mkfs.ext4 /dev/ram0
>     mount -t ext4 /dev/ram0 /mnt
>
>     mkdir /sys/fs/cgroup/user.slice/test
>     echo 38654705664 >/sys/fs/cgroup/user.slice/test/memory.max
>     echo $$ >/sys/fs/cgroup/user.slice/test/cgroup.procs
>     fio -name=mglru --numjobs=72 --directory=/mnt --size=1408m \
>       --buffered=1 --ioengine=io_uring --iodepth=128 \
>       --iodepth_batch_submit=32 --iodepth_batch_complete=32 \
>       --rw=randread --random_distribution=random --norandommap \
>       --time_based --ramp_time=10m --runtime=5m --group_reporting
>
>     cat memcached.sh
>     modprobe brd rd_nr=1 rd_size=113246208
>     swapoff -a
>     mkswap /dev/ram0
>     swapon /dev/ram0
>
>     memtier_benchmark -S /var/run/memcached/memcached.sock \
>       -P memcache_binary -n allkeys --key-minimum=1 \
>       --key-maximum=65000000 --key-pattern=P:P -c 1 -t 36 \
>       --ratio 1:0 --pipeline 8 -d 2000
>
>     memtier_benchmark -S /var/run/memcached/memcached.sock \
>       -P memcache_binary -n allkeys --key-minimum=1 \
>       --key-maximum=65000000 --key-pattern=R:R -c 1 -t 36 \
>       --ratio 0:1 --pipeline 8 --randomize --distinct-client-seed
>
> Client benchmark results:
>   kswapd profiles:
>     5.17-rc2
>       38.05%  page_vma_mapped_walk
>       20.86%  lzo1x_1_do_compress (real work)
>        6.16%  do_raw_spin_lock
>        4.61%  _raw_spin_unlock_irq
>        2.20%  vma_interval_tree_iter_next
>        2.19%  vma_interval_tree_subtree_search
>        2.15%  page_referenced_one
>        1.93%  anon_vma_interval_tree_iter_first
>        1.65%  ptep_clear_flush
>        1.00%  __zram_bvec_write
>
>     patch1-5
>       39.73%  lzo1x_1_do_compress (real work)
>       14.96%  page_vma_mapped_walk
>        6.97%  _raw_spin_unlock_irq
>        3.07%  do_raw_spin_lock
>        2.53%  anon_vma_interval_tree_iter_first
>        2.04%  ptep_clear_flush
>        1.82%  __zram_bvec_write
>        1.76%  __anon_vma_interval_tree_subtree_search
>        1.57%  memmove
>        1.45%  free_unref_page_list
>
>   Configurations:
>     CPU: single Snapdragon 7c
>     Mem: total 4G
>
>     Chrome OS MemoryPressure [1]
>
> [1] https://chromium.googlesource.com/chromiumos/platform/tast-tests/
>

In shrink_active_list we do preferential treatment of VM_EXEC pages.
Do we do similar thing with MGLRU? if not why is that not needed? 

	if (page_referenced(page, 0, sc->target_mem_cgroup,
			    &vm_flags)) {
		/*
		 * Identify referenced, file-backed active pages and
		 * give them one more trip around the active list. So
		 * that executable code get better chances to stay in
		 * memory under moderate memory pressure.  Anon pages
		 * are not likely to be evicted by use-once streaming
		 * IO, plus JVM can create lots of anon VM_EXEC pages,
		 * so we ignore them here.
		 */
		if ((vm_flags & VM_EXEC) && page_is_file_lru(page)) {
			nr_rotated += thp_nr_pages(page);
			list_add(&page->lru, &l_active);
			continue;
		}
	}

