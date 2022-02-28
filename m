Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AF24C6B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbiB1L5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiB1L5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:57:20 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CCC5B3F9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646049402; x=1677585402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+0XJMpTQuFH0VJSwFHXpr/awYVOvnpS9A2LO0Th8n7g=;
  b=RPEE6Az6Cz5FHGZjENqZObaYq1CO6JviHFRzUw3GzqfpLHrGADy2TNGy
   kMm2rpv3mQlW9tI3lSp+1dVmWYu2IEZJeJAixJBoTpjL8CK5O3F8FjM0I
   uexGThw6kFnb8NSdMDmFK9rUv8k7IBAbfOEnbFlkaSK4hMvrztqgmlO/y
   I=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 28 Feb 2022 03:56:41 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 03:56:41 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 28 Feb 2022 03:56:40 -0800
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 28 Feb
 2022 03:56:39 -0800
Date:   Mon, 28 Feb 2022 06:56:37 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     Nathan Chancellor <nathan@kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 00/71] Introducing the Maple Tree
Message-ID: <Yhy4dXi1WxcKYBJH@qian>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <YhhRrBpXTFolUAKi@qian>
 <20220225190846.u4fwebimd5ejfdpd@revolver>
 <20220225202334.bsw5t3retcchpn2e@revolver>
 <YhlAPOquxUICyGsR@qian>
 <Yhlfkk/gTz6a/hOD@archlinux-ax161>
 <20220226015803.h4w6y3doe3om2sbc@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220226015803.h4w6y3doe3om2sbc@revolver>
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

On Sat, Feb 26, 2022 at 01:58:09AM +0000, Liam Howlett wrote:
> Maybe?  I'm trying to figure out why it's having issues.. I've not been
> able to reproduce it with just my maple tree branch.  Steven Rostedt
> found a bad commit that has been fixed in either 20220224, I believe
> [1].  It might be best to try next-20220225 and see if you have better
> luck if that's an option.

Same thing for next-20220225. I just need to boot it and it will crash
shortly after.

BUG: KASAN: use-after-free in move_vma.isra.0
 Read of size 8 at addr ffff00088f74c7e8 by task apt-check/2331

 CPU: 2 PID: 2331 Comm: apt-check Tainted: G        W         5.17.0-rc5-next-20220225 #245
 Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  print_address_description.constprop.0
  kasan_report
  __asan_report_load8_noabort
  move_vma.isra.0
  __do_sys_mremap
  __arm64_sys_mremap
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync

 Allocated by task 2331:
  kasan_save_stack
  __kasan_slab_alloc
  slab_post_alloc_hook
  kmem_cache_alloc
  vm_area_dup
  __split_vma
  do_mas_align_munmap.isra.0
  do_mas_munmap
  __vm_munmap
  __arm64_sys_munmap
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync

 Freed by task 2331:
  kasan_save_stack
  kasan_set_track
  kasan_set_free_info
  __kasan_slab_free
  kmem_cache_free
  vm_area_free
  remove_vma
  do_mas_align_munmap.isra.0
  do_mas_munmap
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

 The buggy address belongs to the object at ffff00088f74c7c8
  which belongs to the cache vm_area_struct of size 144
 The buggy address is located 32 bytes inside of
  144-byte region [ffff00088f74c7c8, ffff00088f74c858)
 The buggy address belongs to the physical page:
 page:fffffc00223dd300 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x90f74c
 head:fffffc00223dd300 order:2 compound_mapcount:0 compound_pincount:0
 memcg:ffff000884a75001
 flags: 0xbfffc0000010200(slab|head|node=0|zone=2|lastcpupid=0xffff)
 raw: 0bfffc0000010200 fffffc00223dd008 fffffc0021e6bc08 ffff000800f5b380
 raw: 0000000000000000 0000000000210021 00000001ffffffff ffff000884a75001
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff00088f74c680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff00088f74c700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 >ffff00088f74c780: fc fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb
                                                           ^
  ffff00088f74c800: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
  ffff00088f74c880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ==================================================================
 Disabling lock debugging due to kernel taint
 Unable to handle kernel paging request at virtual address dfff800000000004
 KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
 Mem abort info:
   ESR = 0x96000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000004
   CM = 0, WnR = 0
 [dfff800000000004] address between user and kernel address ranges
 Internal error: Oops: 96000004 [#1] PREEMPT SMP
 Modules linked in: ipmi_devintf ipmi_msghandler cppc_cpufreq drm ip_tables x_tables ipv6 btrfs blake2b_generic libcrc32c xor xor_neon raid6_pq zstd_compress dm_mod crct10dif_ce nvme mlx5_core mpt3sas nvme_core raid_class
 CPU: 2 PID: 2331 Comm: apt-check Tainted: G    B   W         5.17.0-rc5-next-20220225 #245
 Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : move_vma.isra.0
 lr : move_vma.isra.0
 sp : ffff800016df7ad0
 x29: ffff800016df7ad0 x28: ffff00088c7ba6c8 x27: 0000000000000001
 x26: 0000ffffad180000 x25: ffff00088bea1c40 x24: ffff00088bea1dc8
 x23: ffff00088c988040 x22: 0000000001800000 x21: 0000ffffab82d000
 x20: 0000000000000000 x19: 1ffff00002dbef6c x18: 0000000000000066
 x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
 x14: 0000000000000000 x13: 0000000000001490 x12: 0000000000000001
 x11: 0000000000000009 x10: 0000000000000000 x9 : ffff800008445544
 x8 : 000000003fffffff x7 : ffff80000928fbc4 x6 : 00000000f1f1f1f1
 x5 : dfff800000000000 x4 : ffff700002dbef18 x3 : 0000000041b58ab3
 x2 : 0000000000000004 x1 : dfff800000000000 x0 : 0000000000000020
 Call trace:
  move_vma.isra.0
  __do_sys_mremap
  __arm64_sys_mremap
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync
 Code: 91008000 d2d00001 f2fbffe1 d343fc02 (38e16841)
 ---[ end trace 0000000000000000 ]---
 Kernel panic - not syncing: Oops: Fatal exception
 SMP: stopping secondary CPUs
 Kernel Offset: 0x160000 from 0xffff800008000000
 PHYS_OFFSET: 0x80000000
 CPU features: 0x00,00000942,40000846
 Memory Limit: none
 ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---
