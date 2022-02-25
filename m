Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5254C3CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbiBYDti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiBYDtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:49:36 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3342166E30
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645760945; x=1677296945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+GmEtbJHUXbE+Po2IsyLyIuclbbwW7xPrf0hGwrDUo0=;
  b=dMBG8LUB+77e2ftembpTmUHWw4oYbav8iI5F2MIl0FVtKMugEHr47y25
   1a9OAcE0Ij8nzS9Q/vkgZ4PaeR3zWt2d9SMc5GC9MlZ/RrXrQ/Q0pUxVc
   YHqNaEU+AWA9JiNj8DyaQK0cNco+UQi4Yk2xWXbhrSX8U+xGpVNJCEaDo
   o=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 24 Feb 2022 19:49:05 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 19:49:05 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 24 Feb 2022 19:49:03 -0800
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 24 Feb
 2022 19:49:02 -0800
Date:   Thu, 24 Feb 2022 22:49:00 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 00/71] Introducing the Maple Tree
Message-ID: <YhhRrBpXTFolUAKi@qian>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 02:37:44PM +0000, Liam Howlett wrote:
> The maple tree is an RCU-safe range based B-tree designed to use modern
> processor cache efficiently.  There are a number of places in the kernel
> that a non-overlapping range-based tree would be beneficial, especially
> one with a simple interface.  The first user that is covered in this
> patch set is the vm_area_struct, where three data structures are
> replaced by the maple tree: the augmented rbtree, the vma cache, and the
> linked list of VMAs in the mm_struct.  The long term goal is to reduce
> or remove the mmap_sem contention.
> 
> The tree has a branching factor of 10 for non-leaf nodes and 16 for leaf
> nodes.  With the increased branching factor, it is significantly shorter than
> the rbtree so it has fewer cache misses.  The removal of the linked list
> between subsequent entries also reduces the cache misses and the need to pull
> in the previous and next VMA during many tree alterations.
> 
> This patch is based on v5.17-rc4
> 
> git: https://github.com/oracle/linux-uek/tree/howlett/maple/20220214

Just a heads-up. I noticed an use-after-free in today's linux-next below. I
am running out of time to fully triage this, but I noticed this is the only
series (not sure which revision) heavily touched mm/mmap.c recently there.

 BUG: KASAN: use-after-free in move_vma.isra.0
 Read of size 8 at addr ffff0009ce752ac8 by task systemd-logind/1280

 CPU: 21 PID: 1280 Comm: systemd-logind Not tainted 5.17.0-rc5-next-20220223-dirty #242
 Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  print_address_description.constprop.0
  kasan_report
  __asan_report_load8_noabort
  move_vma.isra.0
  move_vma at /usr/src/linux-next/mm/mremap.c:714
  __do_sys_mremap
  __arm64_sys_mremap
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync

 Allocated by task 1280:
  kasan_save_stack
  __kasan_slab_alloc
  slab_post_alloc_hook
  kmem_cache_alloc
  vm_area_alloc
  vm_area_alloc at /usr/src/linux-next/kernel/fork.c:455
  mmap_region
  mmap_region at /usr/src/linux-next/mm/mmap.c:2585
  do_mmap
  vm_mmap_pgoff
  ksys_mmap_pgoff
  __arm64_sys_mmap
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync

 Freed by task 1280:
  kasan_save_stack
  kasan_set_track
  kasan_set_free_info
  __kasan_slab_free
  kmem_cache_free
  vm_area_free
  remove_vma
  remove_vma at /usr/src/linux-next/mm/mmap.c:187
  do_mas_align_munmap.isra.0
  remove_mt at /usr/src/linux-next/mm/mmap.c:2176
  (inlined by) do_mas_align_munmap at /usr/src/linux-next/mm/mmap.c:2437
  do_mas_munmap
  do_mas_munmap at /usr/src/linux-next/mm/mmap.c:2483
  do_munmap
  move_vma.isra.0
  __do_sys_mremap
  __arm64_sys_mremap
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync

 The buggy address belongs to the object at ffff0009ce752aa8
  which belongs to the cache vm_area_struct of size 144
 The buggy address is located 32 bytes inside of
  144-byte region [ffff0009ce752aa8, ffff0009ce752b38)
 The buggy address belongs to the page:
 page:fffffc002739d400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xa4e750
 head:fffffc002739d400 order:2 compound_mapcount:0 compound_pincount:0
 memcg:ffff0009ce456e01
 flags: 0xbfffc0000010200(slab|head|node=0|zone=2|lastcpupid=0xffff)
 raw: 0bfffc0000010200 fffffc002739f108 fffffc00273a3b08 ffff000800f53380
 raw: 0000000000000000 0000000000210021 00000001ffffffff ffff0009ce456e01
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff0009ce752980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff0009ce752a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 >ffff0009ce752a80: fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb
                                               ^
  ffff0009ce752b00: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
  ffff0009ce752b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
