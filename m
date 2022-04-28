Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E0E5139DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349809AbiD1Qey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344219AbiD1Qew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:34:52 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0F67A986
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:31:36 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id z8so5900571oix.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sSmbmaGlBLXhB73/dVVkOFBzJ9PQ7rU+TmOih7oWfmM=;
        b=S9B0fW8TGUT0x74+qIBRlJyvCSvMKEb9SIAd1rpIgimy74EECECrFRkh9G/SWI95iJ
         Ury/65Hef3qdMoqAqW04hIy1oS5M0/x2cmrwOilx5U5zwCqZpOPKHx3FhdwKlobOGtHR
         1+lZSHkQThJodhUDAWtML/jNxYztPKwlyRIW6h2/jjaR28OnXh19eYB99nTBml9ciDfA
         MJNm7w53Wt7M71y4XJgvrt4eJBSnPVISLLM5thwF65inIeXDBjBf5P7n1GmP/cTTeLp+
         hE0bmGDn36V5CVNLUUNQagkr+XP+li+IhLxZam1000fW3mRha45k76SmN63wFjiNUHqg
         ef8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sSmbmaGlBLXhB73/dVVkOFBzJ9PQ7rU+TmOih7oWfmM=;
        b=VaHMg4Nx9w3kG9BCBQtBhKUnC5YdtEYSb1XKmit+pj/zZtuuTCHghiHrGZ7289g22Z
         p233RgOg+D00Dtj//ZyBOGsn+cyRXGoUJtea3OwGBFy+Z03qQ19zBDeQBErUtSGVibT1
         r4rlmS2s4/NkpZaYx6HTvOEdk3kVMzOmwc1yGWr9KnkmLa562Y7kkZB/ctcLjW/gI2kd
         xc0B4pMEpX2wXcTd4aB+poZ0dQNng89YmiSqY3V+ejm7WQPuMLXkDb5HFcwNTNlaO6TT
         gEVSBmigQBJ1drxV8+y96i2b/0v3dasC30WECBldFqIHXVcfELvSosW47R/Z6bXq/7pp
         ARHQ==
X-Gm-Message-State: AOAM532xRJxLthgzCBBxIA8t1I79xS9Z0UnLnkClJoNA4kdX93fJwjEh
        ljuFk6twGXi4wTKObZ/pFYQ4hxduKeY=
X-Google-Smtp-Source: ABdhPJzSv//ixCCzhCsICGOxUv68wV0rFq6KLe59fG5+AAQXqENljPp5f41ufPqnXuO+AID/7pGD7w==
X-Received: by 2002:a05:6808:23d1:b0:322:97f8:69d7 with SMTP id bq17-20020a05680823d100b0032297f869d7mr20674562oib.241.1651163495425;
        Thu, 28 Apr 2022 09:31:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f15-20020a9d5f0f000000b005e6b67945a3sm162627oti.15.2022.04.28.09.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 09:31:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Apr 2022 09:31:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 66/70] nommu: remove uses of VMA linked list
Message-ID: <20220428163132.GA3124052@roeck-us.net>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426150616.3937571-67-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426150616.3937571-67-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:06:52PM +0000, Liam Howlett wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the maple tree or VMA iterator instead.  This is faster and will allow
> us to shrink the VMA.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

This patch also results in boot failures for m68k:mcf5208evb qemu emulations.
Backtrace and bisect log attached.

Guenter

---
# bad: [bdc61aad77faf67187525028f1f355eff3849f22] Add linux-next specific files for 20220428
# good: [af2d861d4cd2a4da5137f795ee3509e6f944a25b] Linux 5.18-rc4
git bisect start 'HEAD' 'v5.18-rc4'
# good: [a6ffa4aa7e81a54632f3370f4c93fce603160192] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good a6ffa4aa7e81a54632f3370f4c93fce603160192
# good: [cd63f17e3bb63006f9f88bf7f5947b8e1601bcd9] Merge branch 'edac-for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
git bisect good cd63f17e3bb63006f9f88bf7f5947b8e1601bcd9
# good: [cee7bbed3e5cc089b5c364ac8ad4a186c2a28bb6] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
git bisect good cee7bbed3e5cc089b5c364ac8ad4a186c2a28bb6
# good: [d5a23156ea99f10b584221893a6a7d6f6554cde8] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
git bisect good d5a23156ea99f10b584221893a6a7d6f6554cde8
# good: [2f1fde90d983bc404503100c9c4bbbf1e191bcf4] selftests: cgroup: fix alloc_anon_noexit() instantly freeing memory
git bisect good 2f1fde90d983bc404503100c9c4bbbf1e191bcf4
# good: [fca1db6ff251278c532231552e840c7dc36dfa76] Merge branch 'bitmap-for-next' of https://github.com/norov/linux.git
git bisect good fca1db6ff251278c532231552e840c7dc36dfa76
# good: [40b39116fe8e6fb66e3166ea40138eec506dfd91] perf: use VMA iterator
git bisect good 40b39116fe8e6fb66e3166ea40138eec506dfd91
# bad: [33ef257872566922df2b6bcfdb5330b2388aef53] Docs/{ABI,admin-guide}/damon: update for fixed virtual address ranges monitoring
git bisect bad 33ef257872566922df2b6bcfdb5330b2388aef53
# good: [2d8640f244c1ea6c40acde911d339dabc2ac765d] mm/oom_kill: use maple tree iterators instead of vma linked list
git bisect good 2d8640f244c1ea6c40acde911d339dabc2ac765d
# bad: [49d281fa016f2906346f1707e5059b6f7674a948] mm/mmap.c: pass in mapping to __vma_link_file()
git bisect bad 49d281fa016f2906346f1707e5059b6f7674a948
# bad: [487c2c6d922605aebe6f470e1a458eb1425548db] nommu: remove uses of VMA linked list
git bisect bad 487c2c6d922605aebe6f470e1a458eb1425548db
# good: [dc4a1ab575a32e454be953f7b1b0222dcd3d47fa] mm/swapfile: use vma iterator instead of vma linked list
git bisect good dc4a1ab575a32e454be953f7b1b0222dcd3d47fa
# good: [7fffbdd08665ddeeb38768309269fa5b32388c3d] i915: use the VMA iterator
git bisect good 7fffbdd08665ddeeb38768309269fa5b32388c3d
# first bad commit: [487c2c6d922605aebe6f470e1a458eb1425548db] nommu: remove uses of VMA linked list

---

...
page allocation failure: order:7, mode:0xcc0(GFP_KERNEL), nodemask=(null)
CPU: 0 PID: 62 Comm: echo Not tainted 5.18.0-rc4-next-20220428 #1
Stack from 405d9d14:
        405d9d14 40335f43 40335f43 00000000 00000000 402da566 40335f43 400926f6
        00000cc0 00000000 00000000 00000000 405d8000 40906ee0 405d9d6c 40335402
        405d9d4c 405d9df8 40093158 00000cc0 00000000 40335402 00000007 00000007
        000d8000 00000cc0 00000001 00000077 0000006c 00000000 40906ee0 409049a0
        00000000 00000000 00000001 00000000 00000400 41cdad88 00000000 001008c0
        00000000 409830d2 405d4037 283a0000 00004037 283a0000 00000000 00010000
Call Trace: [<402da566>] dump_stack+0xc/0x10
 [<400926f6>] warn_alloc+0xd0/0x1ce
 [<40093158>] __alloc_pages+0x8c6/0xb7e
 [<40046f82>] check_preempt_wakeup+0xce/0x178
 [<400965da>] kmem_cache_alloc+0x22/0x17e
 [<40093ca2>] alloc_pages_exact+0x86/0x14e
 [<4008ddca>] do_mmap+0x3d8/0xa8a
 [<40085ece>] vm_mmap_pgoff+0x5c/0x84
 [<400a486c>] begin_new_exec+0x45e/0x852
 [<400f1ea0>] load_flat_binary+0x5e8/0x878
 [<4009bf94>] kernel_read+0x0/0x98
 [<402d4308>] memset+0x0/0x70
 [<4009e842>] fput+0x0/0x18
 [<400a3638>] bprm_execve+0x188/0x3bc
 [<400a3ab6>] copy_string_kernel+0x0/0x146
 [<400a30ca>] copy_strings+0x0/0x1b4
 [<400a3dce>] do_execveat_common+0x14c/0x220
 [<403768f4>] do_name+0x27a/0x296
 [<403765ec>] do_header+0x1c6/0x21c
 [<403768f4>] do_name+0x27a/0x296
 [<400a4c86>] sys_execve+0x26/0x30
 [<403768f4>] do_name+0x27a/0x296
 [<403765ec>] do_header+0x1c6/0x21c
 [<400a4c60>] sys_execve+0x0/0x30
 [<40022154>] system_call+0x48/0x94
 [<403768f4>] do_name+0x27a/0x296
 [<403765ec>] do_header+0x1c6/0x21c
Mem-Info:
active_anon:0 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:0 isolated_file:0
 unevictable:606 dirty:0 writeback:0
 slab_reclaimable:62 slab_unreclaimable:152
 mapped:0 shmem:0 pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1071 free_pcp:0 free_cma:0
Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:216kB pagetables:0kB all_unreclaimable? no
DMA free:8568kB boost:0kB min:664kB low:824kB high:984kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0
DMA: 1*8kB (U) 1*16kB (U) 9*32kB (U) 7*64kB (U) 21*128kB (U) 8*256kB (U) 6*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 8568kB
613 total pagecache pages
4096 pages RAM
0 pages HighMem/MovableOnly
476 pages reserved
nommu: Allocation of length 884736 from process 62 (echo) failed
active_anon:0 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:0 isolated_file:0
 unevictable:606 dirty:0 writeback:0
 slab_reclaimable:62 slab_unreclaimable:152
 mapped:0 shmem:0 pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1071 free_pcp:0 free_cma:0
Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:216kB pagetables:0kB all_unreclaimable? no
DMA free:8568kB boost:0kB min:664kB low:824kB high:984kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0
DMA: 1*8kB (U) 1*16kB (U) 9*32kB (U) 7*64kB (U) 21*128kB (U) 8*256kB (U) 6*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 8568kB
613 total pagecache pages
binfmt_flat: Unable to allocate RAM for process text/data, errno -12
nommu: Allocation of length 884736 from process 63 (echo) failed
active_anon:0 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:0 isolated_file:0
 unevictable:606 dirty:0 writeback:0
 slab_reclaimable:62 slab_unreclaimable:153
 mapped:0 shmem:0 pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1409 free_pcp:0 free_cma:0
Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:176kB pagetables:0kB all_unreclaimable? no
DMA free:11272kB boost:0kB min:664kB low:824kB high:984kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0
DMA: 5*8kB (U) 6*16kB (U) 12*32kB (U) 10*64kB (U) 21*128kB (U) 11*256kB (U) 9*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 11272kB
614 total pagecache pages
binfmt_flat: Unable to allocate RAM for process text/data, errno -12
nommu: Allocation of length 884736 from process 64 ([) failed
active_anon:0 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:0 isolated_file:0
 unevictable:606 dirty:0 writeback:0
 slab_reclaimable:62 slab_unreclaimable:153
 mapped:0 shmem:0 pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1409 free_pcp:0 free_cma:0
Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:176kB pagetables:0kB all_unreclaimable? no
DMA free:11272kB boost:0kB min:664kB low:824kB high:984kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0
DMA: 5*8kB (U) 6*16kB (U) 12*32kB (U) 10*64kB (U) 21*128kB (U) 11*256kB (U) 9*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 11272kB
614 total pagecache pages
binfmt_flat: Unable to allocate RAM for process text/data, errno -12
nommu: Allocation of length 884736 from process 65 ([) failed
active_anon:0 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:0 isolated_file:0
 unevictable:606 dirty:0 writeback:0
 slab_reclaimable:62 slab_unreclaimable:153
 mapped:0 shmem:0 pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1415 free_pcp:0 free_cma:0
Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:168kB pagetables:0kB all_unreclaimable? no
DMA free:11320kB boost:0kB min:664kB low:824kB high:984kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0
DMA: 11*8kB (U) 6*16kB (U) 12*32kB (U) 10*64kB (U) 21*128kB (U) 11*256kB (U) 9*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 11320kB
614 total pagecache pages
binfmt_flat: Unable to allocate RAM for process text/data, errno -12
nommu: Allocation of length 884736 from process 66 (S20urandom) failed
active_anon:0 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:0 isolated_file:0
 unevictable:606 dirty:0 writeback:0
 slab_reclaimable:62 slab_unreclaimable:153
 mapped:0 shmem:0 pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1415 free_pcp:0 free_cma:0
Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:168kB pagetables:0kB all_unreclaimable? no
DMA free:11320kB boost:0kB min:664kB low:824kB high:984kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0
DMA: 11*8kB (U) 6*16kB (U) 12*32kB (U) 10*64kB (U) 21*128kB (U) 11*256kB (U) 9*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 11320kB
614 total pagecache pages
binfmt_flat: Unable to allocate RAM for process text/data, errno -12
nommu: Allocation of length 884736 from process 67 ([) failed
active_anon:0 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:0 isolated_file:0
 unevictable:606 dirty:0 writeback:0
 slab_reclaimable:62 slab_unreclaimable:153
 mapped:0 shmem:0 pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1415 free_pcp:0 free_cma:0
Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:168kB pagetables:0kB all_unreclaimable? no
DMA free:11320kB boost:0kB min:664kB low:824kB high:984kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0
DMA: 11*8kB (U) 6*16kB (U) 12*32kB (U) 10*64kB (U) 21*128kB (U) 11*256kB (U) 9*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 11320kB
614 total pagecache pages
binfmt_flat: Unable to allocate RAM for process text/data, errno -12
nommu: Allocation of length 884736 from process 68 (S40network) failed
active_anon:0 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:0 isolated_file:0
 unevictable:606 dirty:0 writeback:0
 slab_reclaimable:62 slab_unreclaimable:153
 mapped:0 shmem:0 pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1415 free_pcp:0 free_cma:0
Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:168kB pagetables:0kB all_unreclaimable? no
DMA free:11320kB boost:0kB min:664kB low:824kB high:984kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0
DMA: 11*8kB (U) 6*16kB (U) 12*32kB (U) 10*64kB (U) 21*128kB (U) 11*256kB (U) 9*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 11320kB
614 total pagecache pages
binfmt_flat: Unable to allocate RAM for process text/data, errno -12
nommu: Allocation of length 884736 from process 69 ([) failed
active_anon:0 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:0 isolated_file:0
 unevictable:606 dirty:0 writeback:0
 slab_reclaimable:62 slab_unreclaimable:153
 mapped:0 shmem:0 pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1415 free_pcp:0 free_cma:0
Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:168kB pagetables:0kB all_unreclaimable? no
DMA free:11320kB boost:0kB min:664kB low:824kB high:984kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0
DMA: 11*8kB (U) 6*16kB (U) 12*32kB (U) 10*64kB (U) 21*128kB (U) 11*256kB (U) 9*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 11320kB
614 total pagecache pages
binfmt_flat: Unable to allocate RAM for process text/data, errno -12
nommu: Allocation of length 884736 from process 70 (S55runtest) failed
active_anon:0 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:0 isolated_file:0
 unevictable:606 dirty:0 writeback:0
 slab_reclaimable:62 slab_unreclaimable:153
 mapped:0 shmem:0 pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:1415 free_pcp:0 free_cma:0
Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:168kB pagetables:0kB all_unreclaimable? no
DMA free:11320kB boost:0kB min:664kB low:824kB high:984kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 0
DMA: 11*8kB (U) 6*16kB (U) 12*32kB (U) 10*64kB (U) 21*128kB (U) 11*256kB (U) 9*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 11320kB
614 total pagecache pages
binfmt_flat: Unable to allocate RAM for process text/data, errno -12
