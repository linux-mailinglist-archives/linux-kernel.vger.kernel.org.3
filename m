Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2254C3DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbiBYFYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiBYFYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:24:41 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309A722501B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645766645; x=1677302645;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RtATnuIK5n/MUqcI2I8HuYsn15FisZbShtmunvYPTNc=;
  b=dfBNgs1UKLzWdXq9GWGY+5jTfArcxTb/qqOCz/Vp+JhxKKX4Q4Rvh+AX
   m1zNzio2kQpEL6mxRNo5BPsR3E2FmO407O8VilTog2CbwA6rH6Q/cPP5T
   +T7CMyLpFy7pHRcOqeMqDggmNKqAqNfzZ5MtAsG+VPmu1BdRNzzfic+EP
   EDGkvAy8R+vd5hWg+T0KcOyOCpCvBcESuWSch+ryQNNNNxCmT+r8oe+HG
   MCAEDNwkqDdqcxjJ7/Dg5dO8sallAo2aNhTpk+mmJrU6DUx42Lg5CzmLW
   sdz3fhAaw7NTy1aR8dXwim9lisAVzsJUirwJhIw/eQyJUbmqDSXEaT0U7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="233049071"
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="xz'?scan'208";a="233049071"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 21:24:04 -0800
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="xz'?scan'208";a="509148264"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 21:24:01 -0800
Date:   Fri, 25 Feb 2022 13:23:58 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     lkp@lists.01.org, lkp@intel.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [dyndbg]  8d9eb678da: BUG:Bad_page_state_in_process
Message-ID: <20220225052357.GD30182@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Qrgsu6vtpU/OV/zm"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 8d9eb678dac1a6a982248d80e18ac33f53ac7f1a ("dyndbg: dynamic_debug_sites_reclaim() using free_reserved_page()")
https://github.com/jimc/linux.git dd-diet-6b

in testcase: boot

on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+------------------------------------------+------------+------------+
|                                          | f06f7778f6 | 8d9eb678da |
+------------------------------------------+------------+------------+
| boot_successes                           | 19         | 0          |
| boot_failures                            | 0          | 19         |
| BUG:Bad_page_state_in_process            | 0          | 19         |
| kernel_BUG_at_lib/list_debug.c           | 0          | 19         |
| invalid_opcode:#[##]                     | 0          | 19         |
| EIP:__list_add_valid.cold                | 0          | 10         |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 19         |
| EIP:__list_del_entry_valid.cold          | 0          | 9          |
+------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[   17.676649][    T1] BUG: Bad page state in process swapper/0  pfn:40400
[   17.677826][    T1] page:f470d000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x40400
[   17.679219][    T1] flags: 0x80000000(zone=2)
[   17.679932][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   17.681365][    T1] raw: 00000000 00000000
[   17.682120][    T1] page dumped because: nonzero mapcount
[   17.683062][    T1] Modules linked in:
[   17.684355][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc4-00041-g8d9eb678dac1 #1
[   17.685738][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   17.687159][    T1] Call Trace:
[ 17.687686][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 17.688442][ T1] dump_stack (lib/dump_stack.c:114) 
[ 17.689079][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 17.689845][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 17.690690][ T1] free_unref_page_commit+0x125/0x150 
[ 17.691754][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 17.692532][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 17.693343][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 17.694095][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 17.694985][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 17.695886][ T1] do_one_initcall (init/main.c:1300) 
[ 17.696700][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 17.697592][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 17.698468][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 17.699326][ T1] ? rest_init (init/main.c:1494) 
[ 17.700087][ T1] kernel_init (init/main.c:1504) 
[ 17.700851][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 17.701661][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   17.702370][    T1] Disabling lock debugging due to kernel taint
[   17.705184][    T1] BUG: Bad page state in process swapper/0  pfn:40800
[   17.706221][    T1] page:f4717000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x40800
[   17.707635][    T1] flags: 0x80000000(zone=2)
[   17.708378][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   17.709752][    T1] raw: 00000000 00000000
[   17.710443][    T1] page dumped because: nonzero mapcount
[   17.712032][    T1] Modules linked in:
[   17.712732][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   17.714331][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   17.715830][    T1] Call Trace:
[ 17.716421][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 17.717125][ T1] dump_stack (lib/dump_stack.c:114) 
[ 17.717770][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 17.718515][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 17.719353][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 17.720164][ T1] free_unref_page_commit+0x125/0x150 
[ 17.721143][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 17.721900][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 17.722721][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 17.723440][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 17.724333][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 17.725270][ T1] do_one_initcall (init/main.c:1300) 
[ 17.726065][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 17.726931][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 17.727817][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 17.728701][ T1] ? rest_init (init/main.c:1494) 
[ 17.729442][ T1] kernel_init (init/main.c:1504) 
[ 17.730125][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 17.730955][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   17.733522][    T1] BUG: Bad page state in process swapper/0  pfn:40c00
[   17.734634][    T1] page:f4721000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x40c00
[   17.736057][    T1] flags: 0x80000000(zone=2)
[   17.736802][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   17.738151][    T1] raw: 00000000 00000000
[   17.738859][    T1] page dumped because: nonzero mapcount
[   17.739733][    T1] Modules linked in:
[   17.740377][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   17.741944][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   17.743420][    T1] Call Trace:
[ 17.743973][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 17.744657][ T1] dump_stack (lib/dump_stack.c:114) 
[ 17.745327][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 17.745927][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 17.746583][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 17.747302][ T1] free_unref_page_commit+0x125/0x150 
[ 17.748168][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 17.748956][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 17.749718][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 17.750443][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 17.751471][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 17.752506][ T1] do_one_initcall (init/main.c:1300) 
[ 17.753279][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 17.754139][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 17.755077][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 17.755936][ T1] ? rest_init (init/main.c:1494) 
[ 17.756694][ T1] kernel_init (init/main.c:1504) 
[ 17.757419][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 17.758249][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   17.760711][    T1] BUG: Bad page state in process swapper/0  pfn:41000
[   17.761837][    T1] page:f472b000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x41000
[   17.763329][    T1] flags: 0x80000000(zone=2)
[   17.764114][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   17.765565][    T1] raw: 00000000 00000000
[   17.766276][    T1] page dumped because: nonzero mapcount
[   17.767190][    T1] Modules linked in:
[   17.767862][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   17.769361][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   17.781875][    T1] Call Trace:
[ 17.782488][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 17.783312][ T1] dump_stack (lib/dump_stack.c:114) 
[ 17.783988][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 17.784695][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 17.785438][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 17.786134][ T1] free_unref_page_commit+0x125/0x150 
[ 17.787041][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 17.787827][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 17.788585][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 17.789330][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 17.790223][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 17.791120][ T1] do_one_initcall (init/main.c:1300) 
[ 17.791906][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 17.792731][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 17.793606][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 17.794475][ T1] ? rest_init (init/main.c:1494) 
[ 17.795205][ T1] kernel_init (init/main.c:1504) 
[ 17.795917][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 17.796719][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   17.799774][    T1] BUG: Bad page state in process swapper/0  pfn:41400
[   17.800961][    T1] page:f4735000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x41400
[   17.802376][    T1] flags: 0x80000000(zone=2)
[   17.803188][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   17.804647][    T1] raw: 00000000 00000000
[   17.805359][    T1] page dumped because: nonzero mapcount
[   17.806229][    T1] Modules linked in:
[   17.806851][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   17.808267][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   17.809698][    T1] Call Trace:
[ 17.810290][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 17.811003][ T1] dump_stack (lib/dump_stack.c:114) 
[ 17.811685][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 17.812396][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 17.813190][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 17.813929][ T1] free_unref_page_commit+0x125/0x150 
[ 17.814870][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 17.815547][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 17.816327][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 17.817059][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 17.817874][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 17.818769][ T1] do_one_initcall (init/main.c:1300) 
[ 17.819546][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 17.820445][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 17.821335][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 17.822105][ T1] ? rest_init (init/main.c:1494) 
[ 17.822832][ T1] kernel_init (init/main.c:1504) 
[ 17.823531][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 17.824332][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   17.826831][    T1] BUG: Bad page state in process swapper/0  pfn:41800
[   17.827934][    T1] page:f473f000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x41800
[   17.829367][    T1] flags: 0x80000000(zone=2)
[   17.830120][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   17.831603][    T1] raw: 00000000 00000000
[   17.832325][    T1] page dumped because: nonzero mapcount
[   17.833246][    T1] Modules linked in:
[   17.833894][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   17.835491][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   17.836972][    T1] Call Trace:
[ 17.837559][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 17.838341][ T1] dump_stack (lib/dump_stack.c:114) 
[ 17.839020][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 17.839711][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 17.840498][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 17.841244][ T1] free_unref_page_commit+0x125/0x150 
[ 17.842199][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 17.842974][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 17.843769][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 17.844493][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 17.845410][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 17.846278][ T1] do_one_initcall (init/main.c:1300) 
[ 17.847065][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 17.847921][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 17.848767][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 17.849563][ T1] ? rest_init (init/main.c:1494) 
[ 17.850220][ T1] kernel_init (init/main.c:1504) 
[ 17.850910][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 17.851704][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   17.854228][    T1] BUG: Bad page state in process swapper/0  pfn:41c00
[   17.855333][    T1] page:f4749000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x41c00
[   17.856717][    T1] flags: 0x80000000(zone=2)
[   17.857481][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   17.858847][    T1] raw: 00000000 00000000
[   17.859567][    T1] page dumped because: nonzero mapcount
[   17.860419][    T1] Modules linked in:
[   17.861089][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   17.862633][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   17.863967][    T1] Call Trace:
[ 17.864530][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 17.865293][ T1] dump_stack (lib/dump_stack.c:114) 
[ 17.865964][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 17.866716][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 17.867577][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 17.868381][ T1] free_unref_page_commit+0x125/0x150 
[ 17.869364][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 17.870104][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 17.870886][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 17.871645][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 17.872561][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 17.873530][ T1] do_one_initcall (init/main.c:1300) 
[ 17.874357][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 17.875227][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 17.876125][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 17.876949][ T1] ? rest_init (init/main.c:1494) 
[ 17.877656][ T1] kernel_init (init/main.c:1504) 
[ 17.878392][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 17.880050][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   17.882595][    T1] BUG: Bad page state in process swapper/0  pfn:42000
[   17.883646][    T1] page:f4753000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x42000
[   17.885173][    T1] flags: 0x80000000(zone=2)
[   17.886064][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   17.887438][    T1] raw: 00000000 00000000
[   17.888101][    T1] page dumped because: nonzero mapcount
[   17.888967][    T1] Modules linked in:
[   17.889591][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   17.891187][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   17.892624][    T1] Call Trace:
[ 17.893171][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 17.893875][ T1] dump_stack (lib/dump_stack.c:114) 
[ 17.894526][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 17.895259][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 17.896065][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 17.896839][ T1] free_unref_page_commit+0x125/0x150 
[ 17.897809][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 17.898574][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 17.899391][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 17.900115][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 17.901041][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 17.901953][ T1] do_one_initcall (init/main.c:1300) 
[ 17.902746][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 17.903666][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 17.904541][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 17.905367][ T1] ? rest_init (init/main.c:1494) 
[ 17.906028][ T1] kernel_init (init/main.c:1504) 
[ 17.906713][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 17.907522][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   17.910627][    T1] BUG: Bad page state in process swapper/0  pfn:42400
[   17.911764][    T1] page:f475d000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x42400
[   17.913255][    T1] flags: 0x80000000(zone=2)
[   17.914025][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   17.915508][    T1] raw: 00000000 00000000
[   17.916233][    T1] page dumped because: nonzero mapcount
[   17.917130][    T1] Modules linked in:
[   17.917796][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   17.919420][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   17.920857][    T1] Call Trace:
[ 17.921423][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 17.922160][ T1] dump_stack (lib/dump_stack.c:114) 
[ 17.922890][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 17.923636][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 17.924426][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 17.925207][ T1] free_unref_page_commit+0x125/0x150 
[ 17.926172][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 17.926916][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 17.927727][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 17.928458][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 17.929363][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 17.930246][ T1] do_one_initcall (init/main.c:1300) 
[ 17.931010][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 17.931870][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 17.943693][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 17.944527][ T1] ? rest_init (init/main.c:1494) 
[ 17.945221][ T1] kernel_init (init/main.c:1504) 
[ 17.945915][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 17.946705][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   17.949302][    T1] BUG: Bad page state in process swapper/0  pfn:42800
[   17.950371][    T1] page:f4767000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x42800
[   17.951788][    T1] flags: 0x80000000(zone=2)
[   17.952498][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   17.953935][    T1] raw: 00000000 00000000
[   17.954667][    T1] page dumped because: nonzero mapcount
[   17.955557][    T1] Modules linked in:
[   17.956192][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   17.957659][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   17.959054][    T1] Call Trace:
[ 17.959622][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 17.960378][ T1] dump_stack (lib/dump_stack.c:114) 
[ 17.961092][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 17.961870][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 17.962746][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 17.963503][ T1] free_unref_page_commit+0x125/0x150 
[ 17.964505][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 17.965266][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 17.966130][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 17.966890][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 17.967798][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 17.968665][ T1] do_one_initcall (init/main.c:1300) 
[ 17.969435][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 17.970287][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 17.971202][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 17.972089][ T1] ? rest_init (init/main.c:1494) 
[ 17.972863][ T1] kernel_init (init/main.c:1504) 
[ 17.973658][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 17.974525][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   17.977142][    T1] BUG: Bad page state in process swapper/0  pfn:42c00
[   17.978244][    T1] page:f4771000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x42c00
[   17.979746][    T1] flags: 0x80000000(zone=2)
[   17.980526][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   17.981983][    T1] raw: 00000000 00000000
[   17.982753][    T1] page dumped because: nonzero mapcount
[   17.983687][    T1] Modules linked in:
[   17.984333][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   17.986004][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   17.987400][    T1] Call Trace:
[ 17.987931][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 17.988677][ T1] dump_stack (lib/dump_stack.c:114) 
[ 17.989364][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 17.990105][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 17.990962][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 17.991713][ T1] free_unref_page_commit+0x125/0x150 
[ 17.992653][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 17.993423][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 17.994195][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 17.994878][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 17.995721][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 17.996600][ T1] do_one_initcall (init/main.c:1300) 
[ 17.997347][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 17.998224][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 17.999097][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 17.999951][ T1] ? rest_init (init/main.c:1494) 
[ 18.000667][ T1] kernel_init (init/main.c:1504) 
[ 18.001363][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.002146][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.004679][    T1] BUG: Bad page state in process swapper/0  pfn:43000
[   18.005750][    T1] page:f477b000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x43000
[   18.007199][    T1] flags: 0x80000000(zone=2)
[   18.007897][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.009208][    T1] raw: 00000000 00000000
[   18.009875][    T1] page dumped because: nonzero mapcount
[   18.010723][    T1] Modules linked in:
[   18.011404][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.013007][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.014454][    T1] Call Trace:
[ 18.015021][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.015743][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.016390][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.017071][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.017826][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.018574][ T1] free_unref_page_commit+0x125/0x150 
[ 18.019532][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.020308][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.021110][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.021842][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.022732][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.023655][ T1] do_one_initcall (init/main.c:1300) 
[ 18.024393][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.025243][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.026149][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.026908][ T1] ? rest_init (init/main.c:1494) 
[ 18.027616][ T1] kernel_init (init/main.c:1504) 
[ 18.028300][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.029140][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.031672][    T1] BUG: Bad page state in process swapper/0  pfn:43400
[   18.032753][    T1] page:f4785000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x43400
[   18.034254][    T1] flags: 0x80000000(zone=2)
[   18.035066][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.036510][    T1] raw: 00000000 00000000
[   18.037202][    T1] page dumped because: nonzero mapcount
[   18.038055][    T1] Modules linked in:
[   18.038664][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.040194][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.041582][    T1] Call Trace:
[ 18.042146][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.042836][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.043499][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.044229][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.045017][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.045783][ T1] free_unref_page_commit+0x125/0x150 
[ 18.046713][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.047504][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.048256][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.048944][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.049824][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.050724][ T1] do_one_initcall (init/main.c:1300) 
[ 18.051467][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.052337][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.053238][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.054041][ T1] ? rest_init (init/main.c:1494) 
[ 18.054769][ T1] kernel_init (init/main.c:1504) 
[ 18.055499][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.056299][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.059420][    T1] BUG: Bad page state in process swapper/0  pfn:43800
[   18.060522][    T1] page:f478f000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x43800
[   18.061937][    T1] flags: 0x80000000(zone=2)
[   18.062666][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.064178][    T1] raw: 00000000 00000000
[   18.064898][    T1] page dumped because: nonzero mapcount
[   18.065779][    T1] Modules linked in:
[   18.066438][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.068052][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.069475][    T1] Call Trace:
[ 18.070103][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.070915][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.071677][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.072468][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.073302][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.074085][ T1] free_unref_page_commit+0x125/0x150 
[ 18.075014][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.075795][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.076633][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.077362][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.078304][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.079470][ T1] do_one_initcall (init/main.c:1300) 
[ 18.080257][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.081166][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.082088][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.082915][ T1] ? rest_init (init/main.c:1494) 
[ 18.083642][ T1] kernel_init (init/main.c:1504) 
[ 18.084362][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.085187][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.087684][    T1] BUG: Bad page state in process swapper/0  pfn:43c00
[   18.088787][    T1] page:f4799000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x43c00
[   18.090264][    T1] flags: 0x80000000(zone=2)
[   18.090997][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.092389][    T1] raw: 00000000 00000000
[   18.093106][    T1] page dumped because: nonzero mapcount
[   18.093958][    T1] Modules linked in:
[   18.094594][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.106874][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.108320][    T1] Call Trace:
[ 18.108888][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.109604][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.110256][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.111006][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.111874][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.112672][ T1] free_unref_page_commit+0x125/0x150 
[ 18.113605][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.114347][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.115113][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.115860][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.116720][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.117597][ T1] do_one_initcall (init/main.c:1300) 
[ 18.118382][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.119245][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.120112][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.120946][ T1] ? rest_init (init/main.c:1494) 
[ 18.121642][ T1] kernel_init (init/main.c:1504) 
[ 18.122320][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.123117][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.125725][    T1] BUG: Bad page state in process swapper/0  pfn:44000
[   18.126793][    T1] page:f47a3000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x44000
[   18.128349][    T1] flags: 0x80000000(zone=2)
[   18.129172][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.130597][    T1] raw: 00000000 00000000
[   18.131321][    T1] page dumped because: nonzero mapcount
[   18.132210][    T1] Modules linked in:
[   18.132883][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.134465][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.135967][    T1] Call Trace:
[ 18.136540][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.137322][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.138036][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.138768][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.139612][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.140336][ T1] free_unref_page_commit+0x125/0x150 
[ 18.141334][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.142124][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.142911][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.143629][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.144525][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.145467][ T1] do_one_initcall (init/main.c:1300) 
[ 18.146204][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.147026][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.147949][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.148763][ T1] ? rest_init (init/main.c:1494) 
[ 18.149488][ T1] kernel_init (init/main.c:1504) 
[ 18.150201][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.151040][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.153612][    T1] BUG: Bad page state in process swapper/0  pfn:44400
[   18.154629][    T1] page:f47ad000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x44400
[   18.156394][    T1] flags: 0x80000000(zone=2)
[   18.157139][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.158515][    T1] raw: 00000000 00000000
[   18.159249][    T1] page dumped because: nonzero mapcount
[   18.160102][    T1] Modules linked in:
[   18.160750][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.162310][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.163702][    T1] Call Trace:
[ 18.164250][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.164956][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.165639][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.166348][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.167183][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.167957][ T1] free_unref_page_commit+0x125/0x150 
[ 18.168877][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.169638][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.170449][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.171160][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.172041][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.172974][ T1] do_one_initcall (init/main.c:1300) 
[ 18.173736][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.174600][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.175542][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.176355][ T1] ? rest_init (init/main.c:1494) 
[ 18.177023][ T1] kernel_init (init/main.c:1504) 
[ 18.177740][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.178560][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.181673][    T1] BUG: Bad page state in process swapper/0  pfn:44800
[   18.182734][    T1] page:f47b7000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x44800
[   18.184251][    T1] flags: 0x80000000(zone=2)
[   18.185052][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.186504][    T1] raw: 00000000 00000000
[   18.187202][    T1] page dumped because: nonzero mapcount
[   18.188064][    T1] Modules linked in:
[   18.188712][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.190182][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.191601][    T1] Call Trace:
[ 18.192213][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.193025][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.193685][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.194415][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.195257][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.196030][ T1] free_unref_page_commit+0x125/0x150 
[ 18.196967][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.197721][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.198509][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.199304][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.200217][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.201196][ T1] do_one_initcall (init/main.c:1300) 
[ 18.201955][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.202846][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.203746][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.204629][ T1] ? rest_init (init/main.c:1494) 
[ 18.205361][ T1] kernel_init (init/main.c:1504) 
[ 18.206102][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.206856][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.209426][    T1] BUG: Bad page state in process swapper/0  pfn:44c00
[   18.210568][    T1] page:f47c1000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x44c00
[   18.212066][    T1] flags: 0x80000000(zone=2)
[   18.212832][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.214256][    T1] raw: 00000000 00000000
[   18.214990][    T1] page dumped because: nonzero mapcount
[   18.215937][    T1] Modules linked in:
[   18.216603][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.218151][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.219624][    T1] Call Trace:
[ 18.220231][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.220974][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.221653][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.222392][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.223237][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.224019][ T1] free_unref_page_commit+0x125/0x150 
[ 18.224941][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.225671][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.226407][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.227116][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.228777][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.229667][ T1] do_one_initcall (init/main.c:1300) 
[ 18.230463][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.231378][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.232368][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.233277][ T1] ? rest_init (init/main.c:1494) 
[ 18.234015][ T1] kernel_init (init/main.c:1504) 
[ 18.234733][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.235615][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.238106][    T1] BUG: Bad page state in process swapper/0  pfn:45000
[   18.239042][    T1] page:f47cb000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x45000
[   18.240507][    T1] flags: 0x80000000(zone=2)
[   18.241237][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.242616][    T1] raw: 00000000 00000000
[   18.243310][    T1] page dumped because: nonzero mapcount
[   18.244172][    T1] Modules linked in:
[   18.244781][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.246352][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.247709][    T1] Call Trace:
[ 18.248295][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.249046][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.249790][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.250582][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.251457][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.252274][ T1] free_unref_page_commit+0x125/0x150 
[ 18.253268][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.254121][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.254952][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.255742][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.256639][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.268047][ T1] do_one_initcall (init/main.c:1300) 
[ 18.268809][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.269657][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.270579][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.271445][ T1] ? rest_init (init/main.c:1494) 
[ 18.272159][ T1] kernel_init (init/main.c:1504) 
[ 18.272832][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.273667][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.276186][    T1] BUG: Bad page state in process swapper/0  pfn:45400
[   18.277187][    T1] page:f47d5000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x45400
[   18.278566][    T1] flags: 0x80000000(zone=2)
[   18.279331][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.280740][    T1] raw: 00000000 00000000
[   18.281493][    T1] page dumped because: nonzero mapcount
[   18.282407][    T1] Modules linked in:
[   18.283070][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.286113][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.287629][    T1] Call Trace:
[ 18.288253][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.289021][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.289693][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.290408][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.291238][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.292045][ T1] free_unref_page_commit+0x125/0x150 
[ 18.293010][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.293794][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.294571][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.295279][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.296215][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.297120][ T1] do_one_initcall (init/main.c:1300) 
[ 18.297843][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.298632][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.299492][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.300301][ T1] ? rest_init (init/main.c:1494) 
[ 18.301008][ T1] kernel_init (init/main.c:1504) 
[ 18.301718][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.302548][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.305075][    T1] BUG: Bad page state in process swapper/0  pfn:45800
[   18.306118][    T1] page:f47df000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x45800
[   18.307645][    T1] flags: 0x80000000(zone=2)
[   18.308429][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.309874][    T1] raw: 00000000 00000000
[   18.310569][    T1] page dumped because: nonzero mapcount
[   18.311483][    T1] Modules linked in:
[   18.312188][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.313814][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.315337][    T1] Call Trace:
[ 18.315911][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.316636][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.317351][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.318111][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.318940][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.319756][ T1] free_unref_page_commit+0x125/0x150 
[ 18.320693][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.321455][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.322187][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.322957][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.323818][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.324687][ T1] do_one_initcall (init/main.c:1300) 
[ 18.325410][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.326224][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.327076][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.327930][ T1] ? rest_init (init/main.c:1494) 
[ 18.328679][ T1] kernel_init (init/main.c:1504) 
[ 18.329383][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.330133][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.333371][    T1] BUG: Bad page state in process swapper/0  pfn:45c00
[   18.334517][    T1] page:f47e9000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x45c00
[   18.335982][    T1] flags: 0x80000000(zone=2)
[   18.336758][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.338121][    T1] raw: 00000000 00000000
[   18.338853][    T1] page dumped because: nonzero mapcount
[   18.339749][    T1] Modules linked in:
[   18.340434][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.342055][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.343747][    T1] Call Trace:
[ 18.344334][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.345082][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.345743][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.346460][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.347297][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.348002][ T1] free_unref_page_commit+0x125/0x150 
[ 18.348856][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.349591][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.350369][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.351039][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.351949][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.352889][ T1] do_one_initcall (init/main.c:1300) 
[ 18.353666][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.354538][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.355423][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.356212][ T1] ? rest_init (init/main.c:1494) 
[ 18.356901][ T1] kernel_init (init/main.c:1504) 
[ 18.357609][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.358422][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.360934][    T1] BUG: Bad page state in process swapper/0  pfn:46000
[   18.361934][    T1] page:f47f3000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x46000
[   18.363351][    T1] flags: 0x80000000(zone=2)
[   18.364082][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.365483][    T1] raw: 00000000 00000000
[   18.366194][    T1] page dumped because: nonzero mapcount
[   18.367081][    T1] Modules linked in:
[   18.367773][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.369394][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.370847][    T1] Call Trace:
[ 18.371447][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.372200][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.372888][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.373625][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.374440][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.375196][ T1] free_unref_page_commit+0x125/0x150 
[ 18.376156][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.376933][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.377726][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.378446][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.379365][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.380274][ T1] do_one_initcall (init/main.c:1300) 
[ 18.381038][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.381919][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.382801][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.383644][ T1] ? rest_init (init/main.c:1494) 
[ 18.384379][ T1] kernel_init (init/main.c:1504) 
[ 18.385103][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.385920][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.388407][    T1] BUG: Bad page state in process swapper/0  pfn:46400
[   18.389449][    T1] page:f47fd000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x46400
[   18.390784][    T1] flags: 0x80000000(zone=2)
[   18.391538][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.392966][    T1] raw: 00000000 00000000
[   18.393634][    T1] page dumped because: nonzero mapcount
[   18.394463][    T1] Modules linked in:
[   18.395181][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.396756][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.398198][    T1] Call Trace:
[ 18.398787][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.399562][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.400268][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.401032][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.401818][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.402566][ T1] free_unref_page_commit+0x125/0x150 
[ 18.403523][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.404305][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.405093][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.405789][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.406655][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.407572][ T1] do_one_initcall (init/main.c:1300) 
[ 18.408329][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.409208][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.410055][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.410892][ T1] ? rest_init (init/main.c:1494) 
[ 18.411673][ T1] kernel_init (init/main.c:1504) 
[ 18.412431][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.413203][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.415727][    T1] BUG: Bad page state in process swapper/0  pfn:46800
[   18.416760][    T1] page:f4807000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x46800
[   18.418232][    T1] flags: 0x80000000(zone=2)
[   18.418844][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.420037][    T1] raw: 00000000 00000000
[   18.431667][    T1] page dumped because: nonzero mapcount
[   18.432585][    T1] Modules linked in:
[   18.433253][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.434780][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.436162][    T1] Call Trace:
[ 18.436694][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.437375][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.438031][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.438731][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.439534][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.440301][ T1] free_unref_page_commit+0x125/0x150 
[ 18.441229][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.441983][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.442776][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.443505][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.444385][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.445283][ T1] do_one_initcall (init/main.c:1300) 
[ 18.446048][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.446902][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.447919][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.448759][ T1] ? rest_init (init/main.c:1494) 
[ 18.449503][ T1] kernel_init (init/main.c:1504) 
[ 18.450244][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.451064][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.454223][    T1] BUG: Bad page state in process swapper/0  pfn:46c00
[   18.455316][    T1] page:f4811000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x46c00
[   18.456735][    T1] flags: 0x80000000(zone=2)
[   18.457498][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.458911][    T1] raw: 00000000 00000000
[   18.459635][    T1] page dumped because: nonzero mapcount
[   18.460536][    T1] Modules linked in:
[   18.461209][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.462790][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.464313][    T1] Call Trace:
[ 18.464892][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.465636][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.466346][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.467095][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.467935][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.468717][ T1] free_unref_page_commit+0x125/0x150 
[ 18.469625][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.470377][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.471190][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.471953][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.472829][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.473719][ T1] do_one_initcall (init/main.c:1300) 
[ 18.474563][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.475452][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.476364][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.477214][ T1] ? rest_init (init/main.c:1494) 
[ 18.477980][ T1] kernel_init (init/main.c:1504) 
[ 18.478734][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.479553][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.482100][    T1] BUG: Bad page state in process swapper/0  pfn:47000
[   18.483260][    T1] page:f481b000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x47000
[   18.484692][    T1] flags: 0x80000000(zone=2)
[   18.485483][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.486860][    T1] raw: 00000000 00000000
[   18.487581][    T1] page dumped because: nonzero mapcount
[   18.488462][    T1] Modules linked in:
[   18.489146][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.490738][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.492229][    T1] Call Trace:
[ 18.492823][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.493597][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.494323][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.495027][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.495872][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.496643][ T1] free_unref_page_commit+0x125/0x150 
[ 18.497645][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.498460][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.499256][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.499994][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.500916][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.501826][ T1] do_one_initcall (init/main.c:1300) 
[ 18.502611][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.503499][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.504358][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.505168][ T1] ? rest_init (init/main.c:1494) 
[ 18.505941][ T1] kernel_init (init/main.c:1504) 
[ 18.506697][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.507556][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.510121][    T1] BUG: Bad page state in process swapper/0  pfn:47400
[   18.511262][    T1] page:f4825000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x47400
[   18.512763][    T1] flags: 0x80000000(zone=2)
[   18.513555][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.515040][    T1] raw: 00000000 00000000
[   18.515714][    T1] page dumped because: nonzero mapcount
[   18.516570][    T1] Modules linked in:
[   18.517199][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.518744][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.520228][    T1] Call Trace:
[ 18.520832][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.521593][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.522297][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.523023][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.523804][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.524567][ T1] free_unref_page_commit+0x125/0x150 
[ 18.525494][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.526259][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.527088][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.527835][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.528738][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.529663][ T1] do_one_initcall (init/main.c:1300) 
[ 18.530404][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.531248][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.532125][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.532970][ T1] ? rest_init (init/main.c:1494) 
[ 18.533709][ T1] kernel_init (init/main.c:1504) 
[ 18.534436][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.535282][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.537819][    T1] BUG: Bad page state in process swapper/0  pfn:47800
[   18.538912][    T1] page:f482f000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x47800
[   18.540406][    T1] flags: 0x80000000(zone=2)
[   18.541157][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.542595][    T1] raw: 00000000 00000000
[   18.543321][    T1] page dumped because: nonzero mapcount
[   18.544179][    T1] Modules linked in:
[   18.544858][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.546465][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.547969][    T1] Call Trace:
[ 18.548564][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.549335][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.550032][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.550776][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.551641][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.552438][ T1] free_unref_page_commit+0x125/0x150 
[ 18.553356][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.554110][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.554926][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.555679][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.556581][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.557528][ T1] do_one_initcall (init/main.c:1300) 
[ 18.558290][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.559187][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.560090][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.560936][ T1] ? rest_init (init/main.c:1494) 
[ 18.561697][ T1] kernel_init (init/main.c:1504) 
[ 18.562434][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.563297][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.566396][    T1] BUG: Bad page state in process swapper/0  pfn:47c00
[   18.567521][    T1] page:f4839000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x47c00
[   18.568974][    T1] flags: 0x80000000(zone=2)
[   18.569733][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.571089][    T1] raw: 00000000 00000000
[   18.571799][    T1] page dumped because: nonzero mapcount
[   18.572666][    T1] Modules linked in:
[   18.573290][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.574833][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.576322][    T1] Call Trace:
[ 18.576917][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.577674][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.578376][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.579150][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.579972][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.580758][ T1] free_unref_page_commit+0x125/0x150 
[ 18.581723][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.582508][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.594339][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.595146][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.596059][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.596997][ T1] do_one_initcall (init/main.c:1300) 
[ 18.597782][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.598653][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.599530][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.600365][ T1] ? rest_init (init/main.c:1494) 
[ 18.601107][ T1] kernel_init (init/main.c:1504) 
[ 18.601868][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.602724][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.605269][    T1] BUG: Bad page state in process swapper/0  pfn:48000
[   18.606424][    T1] page:f4843000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x48000
[   18.607888][    T1] flags: 0x80000000(zone=2)
[   18.608662][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.610114][    T1] raw: 00000000 00000000
[   18.610835][    T1] page dumped because: nonzero mapcount
[   18.611752][    T1] Modules linked in:
[   18.612432][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.614010][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.615501][    T1] Call Trace:
[ 18.616105][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.616876][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.617600][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.618360][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.619214][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.619954][ T1] free_unref_page_commit+0x125/0x150 
[ 18.620913][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.621717][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.622504][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.623271][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.624184][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.625113][ T1] do_one_initcall (init/main.c:1300) 
[ 18.625912][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.626735][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.627609][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.628482][ T1] ? rest_init (init/main.c:1494) 
[ 18.629255][ T1] kernel_init (init/main.c:1504) 
[ 18.630001][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.630826][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.633380][    T1] BUG: Bad page state in process swapper/0  pfn:48400
[   18.634424][    T1] page:f484d000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x48400
[   18.635854][    T1] flags: 0x80000000(zone=2)
[   18.636640][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.638019][    T1] raw: 00000000 00000000
[   18.638738][    T1] page dumped because: nonzero mapcount
[   18.639644][    T1] Modules linked in:
[   18.640317][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.641941][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.643422][    T1] Call Trace:
[ 18.644003][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.644771][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.645459][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.646207][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.647035][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.647809][ T1] free_unref_page_commit+0x125/0x150 
[ 18.648806][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.649616][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.650419][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.651166][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.652067][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.652916][ T1] do_one_initcall (init/main.c:1300) 
[ 18.653671][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.654566][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.655483][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.656346][ T1] ? rest_init (init/main.c:1494) 
[ 18.657103][ T1] kernel_init (init/main.c:1504) 
[ 18.657836][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.658686][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.661258][    T1] BUG: Bad page state in process swapper/0  pfn:48800
[   18.662351][    T1] page:f4857000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x48800
[   18.663801][    T1] flags: 0x80000000(zone=2)
[   18.664561][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.665997][    T1] raw: 00000000 00000000
[   18.666711][    T1] page dumped because: nonzero mapcount
[   18.667610][    T1] Modules linked in:
[   18.668262][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.669865][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.671333][    T1] Call Trace:
[ 18.671852][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.672584][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.673278][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.674005][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.674849][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.675615][ T1] free_unref_page_commit+0x125/0x150 
[ 18.676602][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.677392][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.678178][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.678937][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.680434][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.681366][ T1] do_one_initcall (init/main.c:1300) 
[ 18.682149][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.683004][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.683909][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.684774][ T1] ? rest_init (init/main.c:1494) 
[ 18.685495][ T1] kernel_init (init/main.c:1504) 
[ 18.686256][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.687093][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.689718][    T1] BUG: Bad page state in process swapper/0  pfn:48c00
[   18.690841][    T1] page:f4861000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x48c00
[   18.692264][    T1] flags: 0x80000000(zone=2)
[   18.693049][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.694451][    T1] raw: 00000000 00000000
[   18.695177][    T1] page dumped because: nonzero mapcount
[   18.696051][    T1] Modules linked in:
[   18.696723][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.698318][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.699788][    T1] Call Trace:
[ 18.700359][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.701111][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.701839][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.702585][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.703433][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.704211][ T1] free_unref_page_commit+0x125/0x150 
[ 18.705206][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.705987][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.706792][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.707525][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.708396][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.709287][ T1] do_one_initcall (init/main.c:1300) 
[ 18.710034][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.710928][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.711840][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.712684][ T1] ? rest_init (init/main.c:1494) 
[ 18.713455][ T1] kernel_init (init/main.c:1504) 
[ 18.714136][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.714961][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.718171][    T1] BUG: Bad page state in process swapper/0  pfn:49000
[   18.719218][    T1] page:f486b000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x49000
[   18.720584][    T1] flags: 0x80000000(zone=2)
[   18.721359][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.722741][    T1] raw: 00000000 00000000
[   18.723474][    T1] page dumped because: nonzero mapcount
[   18.724342][    T1] Modules linked in:
[   18.724986][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.726540][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.727963][    T1] Call Trace:
[ 18.728543][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.729249][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.729933][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.730675][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.731508][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.732285][ T1] free_unref_page_commit+0x125/0x150 
[ 18.733253][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.734018][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.734805][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.735585][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.736481][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.737392][ T1] do_one_initcall (init/main.c:1300) 
[ 18.738123][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.738988][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.739913][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.740730][ T1] ? rest_init (init/main.c:1494) 
[ 18.741482][ T1] kernel_init (init/main.c:1504) 
[ 18.742174][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.742992][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.745589][    T1] BUG: Bad page state in process swapper/0  pfn:49400
[   18.746662][    T1] page:f4875000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x49400
[   18.748129][    T1] flags: 0x80000000(zone=2)
[   18.759906][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.761411][    T1] raw: 00000000 00000000
[   18.762146][    T1] page dumped because: nonzero mapcount
[   18.763059][    T1] Modules linked in:
[   18.763723][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.765365][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.766859][    T1] Call Trace:
[ 18.767480][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.768272][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.768985][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.769722][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.770559][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.771372][ T1] free_unref_page_commit+0x125/0x150 
[ 18.772364][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.773175][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.774017][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.774772][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.775676][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.776554][ T1] do_one_initcall (init/main.c:1300) 
[ 18.777291][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.778139][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.779009][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.779868][ T1] ? rest_init (init/main.c:1494) 
[ 18.780552][ T1] kernel_init (init/main.c:1504) 
[ 18.781210][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.782018][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.784572][    T1] BUG: Bad page state in process swapper/0  pfn:49800
[   18.785687][    T1] page:f487f000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x49800
[   18.787164][    T1] flags: 0x80000000(zone=2)
[   18.787928][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.789362][    T1] raw: 00000000 00000000
[   18.790091][    T1] page dumped because: nonzero mapcount
[   18.790970][    T1] Modules linked in:
[   18.791602][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.793100][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.794527][    T1] Call Trace:
[ 18.795103][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.795841][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.796517][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.797221][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.798041][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.798791][ T1] free_unref_page_commit+0x125/0x150 
[ 18.799725][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.800485][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.801274][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.801966][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.802873][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.803792][ T1] do_one_initcall (init/main.c:1300) 
[ 18.804511][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.805308][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.806170][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.806946][ T1] ? rest_init (init/main.c:1494) 
[ 18.807674][ T1] kernel_init (init/main.c:1504) 
[ 18.808382][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.809131][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.811634][    T1] BUG: Bad page state in process swapper/0  pfn:49c00
[   18.812656][    T1] page:f4889000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x49c00
[   18.814058][    T1] flags: 0x80000000(zone=2)
[   18.814812][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.816166][    T1] raw: 00000000 00000000
[   18.816837][    T1] page dumped because: nonzero mapcount
[   18.817538][    T1] Modules linked in:
[   18.817992][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.819293][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.820739][    T1] Call Trace:
[ 18.821297][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.822030][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.822747][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.823500][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.824270][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.825027][ T1] free_unref_page_commit+0x125/0x150 
[ 18.825925][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.826658][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.827439][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.828139][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.829001][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.829892][ T1] do_one_initcall (init/main.c:1300) 
[ 18.830633][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.831535][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.832378][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.833213][ T1] ? rest_init (init/main.c:1494) 
[ 18.833968][ T1] kernel_init (init/main.c:1504) 
[ 18.834643][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.835479][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.838546][    T1] BUG: Bad page state in process swapper/0  pfn:4a000
[   18.839631][    T1] page:f4893000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4a000
[   18.841035][    T1] flags: 0x80000000(zone=2)
[   18.841739][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.843066][    T1] raw: 00000000 00000000
[   18.843788][    T1] page dumped because: nonzero mapcount
[   18.844686][    T1] Modules linked in:
[   18.845345][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.846862][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.848272][    T1] Call Trace:
[ 18.848828][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.849574][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.850264][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.850861][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.851671][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.852406][ T1] free_unref_page_commit+0x125/0x150 
[ 18.853338][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.854122][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.854902][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.855619][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.856502][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.857410][ T1] do_one_initcall (init/main.c:1300) 
[ 18.858181][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.859081][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.859979][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.860815][ T1] ? rest_init (init/main.c:1494) 
[ 18.861591][ T1] kernel_init (init/main.c:1504) 
[ 18.862303][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.863200][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.865771][    T1] BUG: Bad page state in process swapper/0  pfn:4a400
[   18.866818][    T1] page:f489d000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4a400
[   18.868279][    T1] flags: 0x80000000(zone=2)
[   18.869032][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.870444][    T1] raw: 00000000 00000000
[   18.871174][    T1] page dumped because: nonzero mapcount
[   18.872053][    T1] Modules linked in:
[   18.872701][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.874319][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.875831][    T1] Call Trace:
[ 18.876430][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.877226][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.877896][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.878597][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.879385][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.880153][ T1] free_unref_page_commit+0x125/0x150 
[ 18.881094][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.881872][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.882680][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.883409][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.884315][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.885227][ T1] do_one_initcall (init/main.c:1300) 
[ 18.886013][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.886885][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.887800][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.888657][ T1] ? rest_init (init/main.c:1494) 
[ 18.889433][ T1] kernel_init (init/main.c:1504) 
[ 18.890158][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.891015][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.893603][    T1] BUG: Bad page state in process swapper/0  pfn:4a800
[   18.894679][    T1] page:f48a7000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4a800
[   18.896114][    T1] flags: 0x80000000(zone=2)
[   18.896856][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.898290][    T1] raw: 00000000 00000000
[   18.898972][    T1] page dumped because: nonzero mapcount
[   18.899852][    T1] Modules linked in:
[   18.900526][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.902098][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.903626][    T1] Call Trace:
[ 18.904235][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.904983][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.905681][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.906432][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.907252][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.918867][ T1] free_unref_page_commit+0x125/0x150 
[ 18.919846][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.920643][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.921455][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.922203][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.923106][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.924007][ T1] do_one_initcall (init/main.c:1300) 
[ 18.924740][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.925592][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.926453][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.927336][ T1] ? rest_init (init/main.c:1494) 
[ 18.928097][ T1] kernel_init (init/main.c:1504) 
[ 18.928843][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.929702][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.932289][    T1] BUG: Bad page state in process swapper/0  pfn:4ac00
[   18.933391][    T1] page:f48b1000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4ac00
[   18.934719][    T1] flags: 0x80000000(zone=2)
[   18.935478][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.936886][    T1] raw: 00000000 00000000
[   18.937600][    T1] page dumped because: nonzero mapcount
[   18.938456][    T1] Modules linked in:
[   18.939126][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.940685][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.942064][    T1] Call Trace:
[ 18.942598][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.943333][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.944000][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.944685][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.945487][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.946235][ T1] free_unref_page_commit+0x125/0x150 
[ 18.947169][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.947903][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.948673][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.949260][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.950074][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.950936][ T1] do_one_initcall (init/main.c:1300) 
[ 18.952668][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.953516][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.954384][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.955233][ T1] ? rest_init (init/main.c:1494) 
[ 18.955937][ T1] kernel_init (init/main.c:1504) 
[ 18.956652][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.957472][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.960564][    T1] BUG: Bad page state in process swapper/0  pfn:4b000
[   18.961686][    T1] page:f48bb000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4b000
[   18.962660][    T1] flags: 0x80000000(zone=2)
[   18.963383][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.964786][    T1] raw: 00000000 00000000
[   18.965461][    T1] page dumped because: nonzero mapcount
[   18.966105][    T1] Modules linked in:
[   18.966775][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.968410][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.969801][    T1] Call Trace:
[ 18.970282][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.970918][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.971545][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.972245][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.973014][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 18.973746][ T1] free_unref_page_commit+0x125/0x150 
[ 18.974673][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 18.975403][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 18.976178][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 18.976892][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 18.977759][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 18.978439][ T1] do_one_initcall (init/main.c:1300) 
[ 18.978998][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 18.979844][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 18.980700][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 18.981440][ T1] ? rest_init (init/main.c:1494) 
[ 18.982124][ T1] kernel_init (init/main.c:1504) 
[ 18.982843][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 18.983652][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   18.986169][    T1] BUG: Bad page state in process swapper/0  pfn:4b400
[   18.987285][    T1] page:f48c5000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4b400
[   18.988730][    T1] flags: 0x80000000(zone=2)
[   18.989505][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   18.990938][    T1] raw: 00000000 00000000
[   18.991652][    T1] page dumped because: nonzero mapcount
[   18.992518][    T1] Modules linked in:
[   18.993172][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   18.994800][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   18.996237][    T1] Call Trace:
[ 18.996801][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 18.997603][ T1] dump_stack (lib/dump_stack.c:114) 
[ 18.998320][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 18.999059][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 18.999898][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 19.000646][ T1] free_unref_page_commit+0x125/0x150 
[ 19.001611][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 19.002391][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 19.003210][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 19.003968][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 19.004841][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 19.005775][ T1] do_one_initcall (init/main.c:1300) 
[ 19.006570][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 19.007445][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 19.008318][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 19.009164][ T1] ? rest_init (init/main.c:1494) 
[ 19.009878][ T1] kernel_init (init/main.c:1504) 
[ 19.010617][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 19.011443][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   19.013997][    T1] BUG: Bad page state in process swapper/0  pfn:4b800
[   19.015135][    T1] page:f48cf000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4b800
[   19.016595][    T1] flags: 0x80000000(zone=2)
[   19.017379][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   19.018814][    T1] raw: 00000000 00000000
[   19.019510][    T1] page dumped because: nonzero mapcount
[   19.020425][    T1] Modules linked in:
[   19.021100][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   19.022687][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   19.024118][    T1] Call Trace:
[ 19.024667][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 19.025433][ T1] dump_stack (lib/dump_stack.c:114) 
[ 19.026088][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 19.026828][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 19.027669][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 19.028457][ T1] free_unref_page_commit+0x125/0x150 
[ 19.029361][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 19.030113][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 19.030914][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 19.031652][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 19.032507][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 19.033394][ T1] do_one_initcall (init/main.c:1300) 
[ 19.034147][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 19.034983][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 19.035883][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 19.036724][ T1] ? rest_init (init/main.c:1494) 
[ 19.037447][ T1] kernel_init (init/main.c:1504) 
[ 19.038168][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 19.038958][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   19.041460][    T1] BUG: Bad page state in process swapper/0  pfn:4bc00
[   19.042524][    T1] page:f48d9000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4bc00
[   19.043955][    T1] flags: 0x80000000(zone=2)
[   19.044702][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   19.046186][    T1] raw: 00000000 00000000
[   19.046925][    T1] page dumped because: nonzero mapcount
[   19.047804][    T1] Modules linked in:
[   19.048456][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   19.049996][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   19.051475][    T1] Call Trace:
[ 19.052100][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 19.052839][ T1] dump_stack (lib/dump_stack.c:114) 
[ 19.053513][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 19.054261][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 19.055064][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 19.055798][ T1] free_unref_page_commit+0x125/0x150 
[ 19.056732][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 19.057512][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 19.058293][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 19.059031][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 19.059933][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 19.060835][ T1] do_one_initcall (init/main.c:1300) 
[ 19.061643][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 19.062544][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 19.063559][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 19.064366][ T1] ? rest_init (init/main.c:1494) 
[ 19.065095][ T1] kernel_init (init/main.c:1504) 
[ 19.065821][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 19.066685][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   19.069301][    T1] BUG: Bad page state in process swapper/0  pfn:4c000
[   19.081210][    T1] page:f48e3000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4c000
[   19.082628][    T1] flags: 0x80000000(zone=2)
[   19.083381][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   19.084711][    T1] raw: 00000000 00000000
[   19.085386][    T1] page dumped because: nonzero mapcount
[   19.086207][    T1] Modules linked in:
[   19.086844][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   19.088365][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   19.089781][    T1] Call Trace:
[ 19.090346][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 19.091062][ T1] dump_stack (lib/dump_stack.c:114) 
[ 19.091733][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 19.092427][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 19.093216][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 19.093943][ T1] free_unref_page_commit+0x125/0x150 
[ 19.094839][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 19.095655][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 19.096434][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 19.097140][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 19.097975][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 19.098802][ T1] do_one_initcall (init/main.c:1300) 
[ 19.099583][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 19.100446][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 19.101285][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 19.102096][ T1] ? rest_init (init/main.c:1494) 
[ 19.102800][ T1] kernel_init (init/main.c:1504) 
[ 19.103494][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 19.104260][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   19.107285][    T1] BUG: Bad page state in process swapper/0  pfn:4c400
[   19.108375][    T1] page:f48ed000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4c400
[   19.109821][    T1] flags: 0x80000000(zone=2)
[   19.110567][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   19.111931][    T1] raw: 00000000 00000000
[   19.112631][    T1] page dumped because: nonzero mapcount
[   19.113483][    T1] Modules linked in:
[   19.114092][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   19.115631][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   19.117052][    T1] Call Trace:
[ 19.117618][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 19.118310][ T1] dump_stack (lib/dump_stack.c:114) 
[ 19.118947][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 19.119690][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 19.120491][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 19.121306][ T1] free_unref_page_commit+0x125/0x150 
[ 19.122190][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 19.122907][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 19.123723][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 19.124426][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 19.125321][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 19.126208][ T1] do_one_initcall (init/main.c:1300) 
[ 19.126945][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 19.127760][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 19.128583][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 19.129437][ T1] ? rest_init (init/main.c:1494) 
[ 19.130222][ T1] kernel_init (init/main.c:1504) 
[ 19.130917][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 19.131694][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   19.134185][    T1] BUG: Bad page state in process swapper/0  pfn:4c800
[   19.135199][    T1] page:f48f7000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4c800
[   19.136539][    T1] flags: 0x80000000(zone=2)
[   19.137272][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   19.138689][    T1] raw: 00000000 00000000
[   19.139421][    T1] page dumped because: nonzero mapcount
[   19.140324][    T1] Modules linked in:
[   19.141020][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   19.142539][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   19.143888][    T1] Call Trace:
[ 19.144463][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 19.145230][ T1] dump_stack (lib/dump_stack.c:114) 
[ 19.145896][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 19.146604][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 19.147372][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 19.148100][ T1] free_unref_page_commit+0x125/0x150 
[ 19.149021][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 19.149770][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 19.150566][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 19.151276][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 19.152144][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 19.153023][ T1] do_one_initcall (init/main.c:1300) 
[ 19.153750][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 19.154595][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 19.155468][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 19.156329][ T1] ? rest_init (init/main.c:1494) 
[ 19.157053][ T1] kernel_init (init/main.c:1504) 
[ 19.157779][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 19.158597][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   19.161165][    T1] BUG: Bad page state in process swapper/0  pfn:4cc00
[   19.162216][    T1] page:f4901000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4cc00
[   19.163679][    T1] flags: 0x80000000(zone=2)
[   19.164420][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   19.165804][    T1] raw: 00000000 00000000
[   19.166509][    T1] page dumped because: nonzero mapcount
[   19.167409][    T1] Modules linked in:
[   19.168026][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   19.169490][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   19.170936][    T1] Call Trace:
[ 19.171522][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 19.172267][ T1] dump_stack (lib/dump_stack.c:114) 
[ 19.172957][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 19.173707][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 19.174476][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 19.175221][ T1] free_unref_page_commit+0x125/0x150 
[ 19.176153][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 19.176928][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 19.177702][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 19.178403][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 19.179298][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 19.180125][ T1] do_one_initcall (init/main.c:1300) 
[ 19.180851][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 19.181677][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 19.182517][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 19.183403][ T1] ? rest_init (init/main.c:1494) 
[ 19.184168][ T1] kernel_init (init/main.c:1504) 
[ 19.184926][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 19.185701][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   19.188110][    T1] BUG: Bad page state in process swapper/0  pfn:4d000
[   19.189176][    T1] page:f490b000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4d000
[   19.190481][    T1] flags: 0x80000000(zone=2)
[   19.191197][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   19.192526][    T1] raw: 00000000 00000000
[   19.193220][    T1] page dumped because: nonzero mapcount
[   19.194055][    T1] Modules linked in:
[   19.194723][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   19.196303][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   19.197732][    T1] Call Trace:
[ 19.198297][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 19.199037][ T1] dump_stack (lib/dump_stack.c:114) 
[ 19.199626][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 19.200345][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 19.201177][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 19.201948][ T1] free_unref_page_commit+0x125/0x150 
[ 19.202887][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 19.203672][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 19.204450][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 19.205174][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 19.206062][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 19.206954][ T1] do_one_initcall (init/main.c:1300) 
[ 19.207724][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 19.208427][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 19.209214][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 19.209901][ T1] ? rest_init (init/main.c:1494) 
[ 19.210635][ T1] kernel_init (init/main.c:1504) 
[ 19.211357][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 19.212197][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   19.215279][    T1] BUG: Bad page state in process swapper/0  pfn:4d400
[   19.216348][    T1] page:f4915000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4d400
[   19.217878][    T1] flags: 0x80000000(zone=2)
[   19.218667][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   19.220171][    T1] raw: 00000000 00000000
[   19.220888][    T1] page dumped because: nonzero mapcount
[   19.221776][    T1] Modules linked in:
[   19.222460][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   19.224037][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   19.225568][    T1] Call Trace:
[ 19.226180][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 19.226911][ T1] dump_stack (lib/dump_stack.c:114) 
[ 19.238464][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 19.239227][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 19.240055][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 19.240790][ T1] free_unref_page_commit+0x125/0x150 
[ 19.241703][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 19.242442][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 19.243222][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 19.243929][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 19.244778][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 19.245670][ T1] do_one_initcall (init/main.c:1300) 
[ 19.246435][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 19.247283][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 19.248097][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 19.248875][ T1] ? rest_init (init/main.c:1494) 
[ 19.249581][ T1] kernel_init (init/main.c:1504) 
[ 19.250278][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 19.251074][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   19.253588][    T1] BUG: Bad page state in process swapper/0  pfn:4d800
[   19.254636][    T1] page:f491f000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4d800
[   19.256070][    T1] flags: 0x80000000(zone=2)
[   19.256835][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   19.258278][    T1] raw: 00000000 00000000
[   19.258977][    T1] page dumped because: nonzero mapcount
[   19.259830][    T1] Modules linked in:
[   19.260466][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   19.262008][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   19.263441][    T1] Call Trace:
[ 19.264001][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 19.264634][ T1] dump_stack (lib/dump_stack.c:114) 
[ 19.265283][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 19.265981][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 19.266570][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 19.267357][ T1] free_unref_page_commit+0x125/0x150 
[ 19.268281][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 19.269044][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 19.269810][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 19.270481][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 19.271337][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 19.272229][ T1] do_one_initcall (init/main.c:1300) 
[ 19.272922][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 19.273732][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 19.274631][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 19.275491][ T1] ? rest_init (init/main.c:1494) 
[ 19.276229][ T1] kernel_init (init/main.c:1504) 
[ 19.276920][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 19.277682][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   19.280243][    T1] BUG: Bad page state in process swapper/0  pfn:4dc00
[   19.281342][    T1] page:f4929000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4dc00
[   19.282815][    T1] flags: 0x80000000(zone=2)
[   19.283617][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   19.285062][    T1] raw: 00000000 00000000
[   19.285787][    T1] page dumped because: nonzero mapcount
[   19.286689][    T1] Modules linked in:
[   19.287384][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   19.289007][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   19.290478][    T1] Call Trace:
[ 19.291061][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 19.291841][ T1] dump_stack (lib/dump_stack.c:114) 
[ 19.292536][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 19.293292][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 19.294137][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 19.294899][ T1] free_unref_page_commit+0x125/0x150 
[ 19.295832][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 19.296563][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 19.297310][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 19.298023][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 19.298859][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 19.299765][ T1] do_one_initcall (init/main.c:1300) 
[ 19.300542][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 19.301339][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 19.302179][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 19.302973][ T1] ? rest_init (init/main.c:1494) 
[ 19.303727][ T1] kernel_init (init/main.c:1504) 
[ 19.304458][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 19.305264][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   19.307818][    T1] BUG: Bad page state in process swapper/0  pfn:4e000
[   19.308914][    T1] page:f4933000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4e000
[   19.310400][    T1] flags: 0x80000000(zone=2)
[   19.311175][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   19.312530][    T1] raw: 00000000 00000000
[   19.313283][    T1] page dumped because: nonzero mapcount
[   19.314191][    T1] Modules linked in:
[   19.314822][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   19.316452][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   19.317917][    T1] Call Trace:
[ 19.318507][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 19.319280][ T1] dump_stack (lib/dump_stack.c:114) 
[ 19.319981][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 19.320716][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 19.321519][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 19.322270][ T1] free_unref_page_commit+0x125/0x150 
[ 19.323240][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 19.324019][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 19.324812][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 19.325539][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 19.326420][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 19.327296][ T1] do_one_initcall (init/main.c:1300) 
[ 19.328058][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 19.328880][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 19.329710][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 19.330535][ T1] ? rest_init (init/main.c:1494) 
[ 19.331281][ T1] kernel_init (init/main.c:1504) 
[ 19.332001][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 19.332762][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   19.335772][    T1] BUG: Bad page state in process swapper/0  pfn:4e400
[   19.336901][    T1] page:f493d000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4e400
[   19.338244][    T1] flags: 0x80000000(zone=2)
[   19.338941][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   19.340406][    T1] raw: 00000000 00000000
[   19.341107][    T1] page dumped because: nonzero mapcount
[   19.341982][    T1] Modules linked in:
[   19.342668][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   19.344269][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   19.345560][    T1] Call Trace:
[ 19.346158][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 19.346891][ T1] dump_stack (lib/dump_stack.c:114) 
[ 19.347595][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 19.348322][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 19.349127][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 19.349925][ T1] free_unref_page_commit+0x125/0x150 
[ 19.350864][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 19.351653][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 19.352458][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 19.352997][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 19.353684][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 19.354594][ T1] do_one_initcall (init/main.c:1300) 
[ 19.355427][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 19.356305][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 19.357187][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 19.358009][ T1] ? rest_init (init/main.c:1494) 
[ 19.358702][ T1] kernel_init (init/main.c:1504) 
[ 19.359441][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 19.360347][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   19.362997][    T1] BUG: Bad page state in process swapper/0  pfn:4e800
[   19.364124][    T1] page:f4947000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4e800
[   19.365506][    T1] flags: 0x80000000(zone=2)
[   19.366187][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   19.367590][    T1] raw: 00000000 00000000
[   19.368305][    T1] page dumped because: nonzero mapcount
[   19.369232][    T1] Modules linked in:
[   19.369917][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   19.371471][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   19.372871][    T1] Call Trace:
[ 19.373449][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 19.374195][ T1] dump_stack (lib/dump_stack.c:114) 
[ 19.374901][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 19.375640][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 19.376402][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 19.377174][ T1] free_unref_page_commit+0x125/0x150 
[ 19.378156][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 19.378927][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 19.379702][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 19.380389][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 19.381319][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 19.382237][ T1] do_one_initcall (init/main.c:1300) 
[ 19.383016][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 19.384009][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 19.384983][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 19.385811][ T1] ? rest_init (init/main.c:1494) 
[ 19.386522][ T1] kernel_init (init/main.c:1504) 
[ 19.398028][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 19.398905][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   19.401520][    T1] BUG: Bad page state in process swapper/0  pfn:4ec00
[   19.402575][    T1] page:f4951000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4ec00
[   19.403985][    T1] flags: 0x80000000(zone=2)
[   19.404760][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   19.406111][    T1] raw: 00000000 00000000
[   19.406817][    T1] page dumped because: nonzero mapcount
[   19.407640][    T1] Modules linked in:
[   19.408287][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   19.409837][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   19.411271][    T1] Call Trace:
[ 19.411834][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 19.412501][ T1] dump_stack (lib/dump_stack.c:114) 
[ 19.413190][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 19.413940][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 19.414746][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 19.415542][ T1] free_unref_page_commit+0x125/0x150 
[ 19.416472][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 19.417215][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 19.418029][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 19.418773][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 19.419739][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 19.420653][ T1] do_one_initcall (init/main.c:1300) 
[ 19.421417][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 19.422289][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 19.423202][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 19.424072][ T1] ? rest_init (init/main.c:1494) 
[ 19.424832][ T1] kernel_init (init/main.c:1504) 
[ 19.425570][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 19.426361][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   19.428961][    T1] BUG: Bad page state in process swapper/0  pfn:4f000
[   19.430033][    T1] page:f495b000 refcount:0 mapcount:-128 mapping:00000000 index:0x1 pfn:0x4f000
[   19.431520][    T1] flags: 0x80000000(zone=2)
[   19.432288][    T1] raw: 80000000 00000100 00000122 00000000 00000001 0000000a ffffff7f 00000000
[   19.433719][    T1] raw: 00000000 00000000
[   19.434408][    T1] page dumped because: nonzero mapcount
[   19.435249][    T1] Modules linked in:
[   19.435887][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   19.437265][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   19.438637][    T1] Call Trace:
[ 19.439235][ T1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 19.440006][ T1] dump_stack (lib/dump_stack.c:114) 
[ 19.440657][ T1] bad_page.cold (mm/page_alloc.c:655) 
[ 19.441334][ T1] free_pcppages_bulk (mm/page_alloc.c:1518) 
[ 19.442089][ T1] ? migrate_enable (arch/x86/include/asm/preempt.h:80 kernel/sched/core.c:2195) 
[ 19.442847][ T1] free_unref_page_commit+0x125/0x150 
[ 19.443822][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 19.444592][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 19.445390][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 19.446081][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 19.446930][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 19.447840][ T1] do_one_initcall (init/main.c:1300) 
[ 19.448539][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 19.449412][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 19.450280][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 19.451137][ T1] ? rest_init (init/main.c:1494) 
[ 19.451885][ T1] kernel_init (init/main.c:1504) 
[ 19.452628][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 19.453475][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   20.281059][    T1] list_add corruption. next->prev should be prev (d607a72c), but was 00000122. (next=f5a51674).
[   20.282725][    T1] ------------[ cut here ]------------
[   20.283626][    T1] kernel BUG at lib/list_debug.c:23!
[   20.284445][    T1] invalid opcode: 0000 [#1] SMP
[   20.285254][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.17.0-rc4-00041-g8d9eb678dac1 #1
[   20.286828][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[ 20.288284][ T1] EIP: __list_add_valid.cold (lib/list_debug.c:23 (discriminator 3)) 
[ 20.289180][ T1] Code: e8 ea c8 02 00 b8 ea ff ff ff e9 34 6c 44 ff 89 5c 24 0c 8b 43 04 89 7c 24 04 c7 04 24 c8 23 8b d5 89 44 24 08 e8 58 01 fb ff <0f> 0b 89 7c 24 0c 8b 45 f0 89 74 24 08 c7 04 24 70 24 8b d5 89 44
All code
========
   0:	e8 ea c8 02 00       	callq  0x2c8ef
   5:	b8 ea ff ff ff       	mov    $0xffffffea,%eax
   a:	e9 34 6c 44 ff       	jmpq   0xffffffffff446c43
   f:	89 5c 24 0c          	mov    %ebx,0xc(%rsp)
  13:	8b 43 04             	mov    0x4(%rbx),%eax
  16:	89 7c 24 04          	mov    %edi,0x4(%rsp)
  1a:	c7 04 24 c8 23 8b d5 	movl   $0xd58b23c8,(%rsp)
  21:	89 44 24 08          	mov    %eax,0x8(%rsp)
  25:	e8 58 01 fb ff       	callq  0xfffffffffffb0182
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	89 7c 24 0c          	mov    %edi,0xc(%rsp)
  30:	8b 45 f0             	mov    -0x10(%rbp),%eax
  33:	89 74 24 08          	mov    %esi,0x8(%rsp)
  37:	c7 04 24 70 24 8b d5 	movl   $0xd58b2470,(%rsp)
  3e:	89                   	.byte 0x89
  3f:	44                   	rex.R

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	89 7c 24 0c          	mov    %edi,0xc(%rsp)
   6:	8b 45 f0             	mov    -0x10(%rbp),%eax
   9:	89 74 24 08          	mov    %esi,0x8(%rsp)
   d:	c7 04 24 70 24 8b d5 	movl   $0xd58b2470,(%rsp)
  14:	89                   	.byte 0x89
  15:	44                   	rex.R
[   20.291984][    T1] EAX: 0000005d EBX: f5a51674 ECX: 00000000 EDX: 00000000
[   20.293046][    T1] ESI: 00000122 EDI: d607a72c EBP: c184de2c ESP: c184de0c
[   20.294121][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010086
[   20.295369][    T1] CR0: 80050033 CR2: b7f3a844 CR3: 162d4000 CR4: 000406d0
[   20.296471][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   20.297586][    T1] DR6: fffe0ff0 DR7: 00000400
[   20.298363][    T1] Call Trace:
[ 20.298956][ T1] free_pcppages_bulk (include/linux/list.h:69 include/linux/list.h:88 mm/page_alloc.c:979 mm/page_alloc.c:1156 mm/page_alloc.c:1546) 
[ 20.299832][ T1] free_unref_page_commit+0x125/0x150 
[ 20.300788][ T1] free_unref_page (mm/page_alloc.c:3425) 
[ 20.301537][ T1] ? free_unref_page (mm/page_alloc.c:3423 (discriminator 3)) 
[ 20.302344][ T1] __free_pages (mm/page_alloc.c:5478) 
[ 20.303067][ T1] dynamic_debug_sites_reclaim (include/linux/mm.h:2479 (discriminator 3) lib/dynamic_debug.c:1458 (discriminator 3)) 
[ 20.303945][ T1] ? dynamic_debug_init_control (lib/dynamic_debug.c:1446) 
[ 20.304864][ T1] do_one_initcall (init/main.c:1300) 
[ 20.305625][ T1] ? kernel_init_freeable (init/main.c:1383 init/main.c:1408 init/main.c:1613) 
[ 20.306416][ T1] ? rcu_read_lock_sched_held (include/linux/lockdep.h:283 kernel/rcu/update.c:125) 
[ 20.307222][ T1] kernel_init_freeable (init/main.c:1372 init/main.c:1389 init/main.c:1408 init/main.c:1613) 
[ 20.307981][ T1] ? rest_init (init/main.c:1494) 
[ 20.308661][ T1] kernel_init (init/main.c:1504) 
[ 20.309313][ T1] ? schedule_tail_wrapper (arch/x86/entry/entry_32.S:737) 
[ 20.310118][ T1] ret_from_fork (arch/x86/entry/entry_32.S:772) 
[   20.310838][    T1] Modules linked in:
[   20.311502][    T1] ---[ end trace 0000000000000000 ]---
[ 20.312351][ T1] EIP: __list_add_valid.cold (lib/list_debug.c:23 (discriminator 3)) 
[ 20.313162][ T1] Code: e8 ea c8 02 00 b8 ea ff ff ff e9 34 6c 44 ff 89 5c 24 0c 8b 43 04 89 7c 24 04 c7 04 24 c8 23 8b d5 89 44 24 08 e8 58 01 fb ff <0f> 0b 89 7c 24 0c 8b 45 f0 89 74 24 08 c7 04 24 70 24 8b d5 89 44
All code
========
   0:	e8 ea c8 02 00       	callq  0x2c8ef
   5:	b8 ea ff ff ff       	mov    $0xffffffea,%eax
   a:	e9 34 6c 44 ff       	jmpq   0xffffffffff446c43
   f:	89 5c 24 0c          	mov    %ebx,0xc(%rsp)
  13:	8b 43 04             	mov    0x4(%rbx),%eax
  16:	89 7c 24 04          	mov    %edi,0x4(%rsp)
  1a:	c7 04 24 c8 23 8b d5 	movl   $0xd58b23c8,(%rsp)
  21:	89 44 24 08          	mov    %eax,0x8(%rsp)
  25:	e8 58 01 fb ff       	callq  0xfffffffffffb0182
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	89 7c 24 0c          	mov    %edi,0xc(%rsp)
  30:	8b 45 f0             	mov    -0x10(%rbp),%eax
  33:	89 74 24 08          	mov    %esi,0x8(%rsp)
  37:	c7 04 24 70 24 8b d5 	movl   $0xd58b2470,(%rsp)
  3e:	89                   	.byte 0x89
  3f:	44                   	rex.R

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	89 7c 24 0c          	mov    %edi,0xc(%rsp)
   6:	8b 45 f0             	mov    -0x10(%rbp),%eax
   9:	89 74 24 08          	mov    %esi,0x8(%rsp)
   d:	c7 04 24 70 24 8b d5 	movl   $0xd58b2470,(%rsp)
  14:	89                   	.byte 0x89
  15:	44                   	rex.R


To reproduce:

        # build kernel
	cd linux
	cp config-5.17.0-rc4-00041-g8d9eb678dac1 .config
	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.17.0-rc4-00041-g8d9eb678dac1"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.17.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23502
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23502
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
# CONFIG_UAPI_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_WATCH_QUEUE=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
# CONFIG_TIME_KUNIT_TEST is not set

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# CONFIG_BPF_JIT is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_NOCB_CPU=y
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_TIME_NS=y
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_SLUB_CPU_PARTIAL is not set
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_FORCE_DYNAMIC_FTRACE=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=512
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_BIGSMP=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_CPU_SUP_VORTEX_32=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=64
CONFIG_NR_CPUS_DEFAULT=32
CONFIG_NR_CPUS=32
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
# CONFIG_SCHED_MC_PRIO is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_ANCIENT_MCE=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_PERF_EVENTS_AMD_UNCORE=y
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
# CONFIG_X86_IOPL_IOPERM is not set
# CONFIG_TOSHIBA is not set
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_HIGHPTE=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
# end of Processor type and features

CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_SCx200 is not set
# CONFIG_OLPC is not set
# CONFIG_ALIX is not set
CONFIG_NET5501=y
# CONFIG_GEOS is not set
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR_STRONG is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SPLIT_ARG64=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
# CONFIG_MSDOS_PARTITION is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_SYSV68_PARTITION=y
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_COMPACTION is not set
CONFIG_PAGE_REPORTING=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
# CONFIG_CMA is not set
CONFIG_ZPOOL=y
# CONFIG_ZBUD is not set
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ZONE_DMA=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_KUNIT_TEST=y
# CONFIG_DAMON_VADDR is not set
# CONFIG_DAMON_PADDR is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
# CONFIG_NETDEV_ADDR_LIST_TEST is not set

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
CONFIG_TCIC=y
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_DRIVER_PE_KUNIT_TEST=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SOUNDWIRE=y
CONFIG_REGMAP_SOUNDWIRE_MBQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_REGMAP_I3C=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
# CONFIG_MHI_BUS_DEBUG is not set
# CONFIG_MHI_BUS_PCI_GENERIC is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
CONFIG_GOOGLE_COREBOOT_TABLE=y
CONFIG_GOOGLE_MEMCONSOLE=y
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT=y
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=y
# CONFIG_GOOGLE_VPD is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=y
# CONFIG_GNSS_USB is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y
# CONFIG_MTD_OF_PARTS is not set
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=y
CONFIG_NFTL=y
# CONFIG_NFTL_RW is not set
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
CONFIG_SM_FTL=y
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
CONFIG_MTD_MAP_BANK_WIDTH_16=y
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_I4=y
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_SBC_GXX is not set
CONFIG_MTD_AMD76XROM=y
# CONFIG_MTD_ICHXROM is not set
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
CONFIG_MTD_PCMCIA=y
CONFIG_MTD_PCMCIA_ANONYMOUS=y
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_RAW_NAND=y

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=y
# CONFIG_MTD_NAND_DENALI_PCI is not set
CONFIG_MTD_NAND_DENALI_DT=y
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_CS553X=y
# CONFIG_MTD_NAND_MXIC is not set
CONFIG_MTD_NAND_GPIO=y
# CONFIG_MTD_NAND_PLATFORM is not set
# CONFIG_MTD_NAND_CADENCE is not set
CONFIG_MTD_NAND_ARASAN=y
# CONFIG_MTD_NAND_INTEL_LGM is not set

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=y
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
CONFIG_MTD_NAND_ECC_SW_BCH=y
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_UBI is not set
# CONFIG_MTD_HYPERBUS is not set
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_BLK_DEV_RBD is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=y
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_PASSTHRU=y
CONFIG_NVME_TARGET_LOOP=y
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_HI6421V600_IRQ=y
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
CONFIG_SRAM=y
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
CONFIG_HISI_HIKEY_USB=y
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
CONFIG_UACCE=y
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_BLK_DEV_BSG is not set
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_ENCLOSURE=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_ATA=y
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AHA152X=y
CONFIG_SCSI_AHA1542=y
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
CONFIG_SCSI_ADVANSYS=y
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
CONFIG_SCSI_FDOMAIN=y
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_FDOMAIN_ISA=y
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_VIRTIO is not set
CONFIG_SCSI_LOWLEVEL_PCMCIA=y
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_AHCI_CEVA=y
CONFIG_AHCI_QORIQ=y
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
# CONFIG_ATA_PIIX is not set
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CS5535 is not set
# CONFIG_PATA_CS5536 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
CONFIG_PATA_PCMCIA=y
# CONFIG_PATA_QDI is not set
# CONFIG_PATA_RZ1000 is not set
CONFIG_PATA_WINBOND_VLB=y

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
# CONFIG_ATA_GENERIC is not set
CONFIG_PATA_LEGACY=y
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
# CONFIG_TCM_FILEIO is not set
# CONFIG_TCM_PSCSI is not set
# CONFIG_TCM_USER2 is not set
# CONFIG_LOOPBACK_TARGET is not set
# CONFIG_ISCSI_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_MHI_NET is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0_ISA is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_SMC9194 is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
# CONFIG_KEYBOARD_LM8323 is not set
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
# CONFIG_KEYBOARD_MCS is not set
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=y
# CONFIG_KEYBOARD_OPENCORES is not set
CONFIG_KEYBOARD_SAMSUNG=y
CONFIG_KEYBOARD_STOWAWAY=y
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_KEYBOARD_IQS62X=y
# CONFIG_KEYBOARD_OMAP4 is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_XTKBD=y
CONFIG_KEYBOARD_CAP11XX=y
CONFIG_KEYBOARD_BCM=y
CONFIG_KEYBOARD_MTK_PMIC=y
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADC=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_USB=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=y
# CONFIG_JOYSTICK_MAGELLAN is not set
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
CONFIG_JOYSTICK_XPAD=y
CONFIG_JOYSTICK_XPAD_FF=y
# CONFIG_JOYSTICK_XPAD_LEDS is not set
CONFIG_JOYSTICK_PXRC=y
# CONFIG_JOYSTICK_QWIIC is not set
# CONFIG_JOYSTICK_FSIA6B is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
CONFIG_TABLET_USB_AIPTEK=y
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
CONFIG_TOUCHSCREEN_ADC=y
CONFIG_TOUCHSCREEN_AR1021_I2C=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_BU21029=y
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMA140=y
CONFIG_TOUCHSCREEN_CY8CTMG110=y
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP_I2C is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=y
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX=y
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_ILITEK is not set
CONFIG_TOUCHSCREEN_S6SY761=y
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=y
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
# CONFIG_TOUCHSCREEN_MAX11801 is not set
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=y
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
# CONFIG_TOUCHSCREEN_MSG2638 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_HTCPEN=y
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
CONFIG_TOUCHSCREEN_TOUCHWIN=y
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_PIXCIR=y
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
CONFIG_TOUCHSCREEN_WM831X=y
CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
CONFIG_TOUCHSCREEN_USB_EGALAX=y
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
CONFIG_TOUCHSCREEN_USB_GOTOP=y
CONFIG_TOUCHSCREEN_USB_JASTEC=y
CONFIG_TOUCHSCREEN_USB_ELO=y
CONFIG_TOUCHSCREEN_USB_E2I=y
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
CONFIG_TOUCHSCREEN_TSC2007=y
CONFIG_TOUCHSCREEN_TSC2007_IIO=y
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=y
# CONFIG_TOUCHSCREEN_ZFORCE is not set
CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_TOUCHSCREEN_IQS5XX=y
CONFIG_TOUCHSCREEN_ZINITIX=y
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_88PM80X_ONKEY is not set
CONFIG_INPUT_AD714X=y
CONFIG_INPUT_AD714X_I2C=y
CONFIG_INPUT_ATC260X_ONKEY=y
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=y
# CONFIG_INPUT_PCSPKR is not set
CONFIG_INPUT_MAX8925_ONKEY=y
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=y
CONFIG_INPUT_GPIO_BEEPER=y
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_WISTRON_BTNS=y
# CONFIG_INPUT_ATLAS_BTNS is not set
CONFIG_INPUT_ATI_REMOTE2=y
CONFIG_INPUT_KEYSPAN_REMOTE=y
CONFIG_INPUT_KXTJ9=y
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=y
CONFIG_INPUT_CM109=y
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
# CONFIG_INPUT_TPS65218_PWRBUTTON is not set
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_RK805_PWRKEY is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
# CONFIG_INPUT_DA7280_HAPTICS is not set
CONFIG_INPUT_WM831X_ON=y
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=y
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
CONFIG_INPUT_CMA3000=y
CONFIG_INPUT_CMA3000_I2C=y
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
CONFIG_INPUT_DRV260X_HAPTICS=y
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=y
# CONFIG_INPUT_STPMIC1_ONKEY is not set
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_CS=y
CONFIG_SERIAL_8250_MEN_MCB=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SIFIVE=y
CONFIG_SERIAL_SIFIVE_CONSOLE=y
CONFIG_SERIAL_LANTIQ=y
CONFIG_SERIAL_LANTIQ_CONSOLE=y
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
CONFIG_SERIAL_SC16IS7XX_I2C=y
CONFIG_SERIAL_TIMBERDALE=y
CONFIG_SERIAL_BCM63XX=y
# CONFIG_SERIAL_BCM63XX_CONSOLE is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
# CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE is not set
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_SPRD=y
CONFIG_SERIAL_SPRD_CONSOLE=y
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
CONFIG_NULL_TTY=y
CONFIG_HVC_DRIVER=y
# CONFIG_RPMSG_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_HW_RANDOM_CCTRNG=y
CONFIG_HW_RANDOM_XIPHERA=y
CONFIG_DTLK=y
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=y
# CONFIG_CARDMAN_4000 is not set
CONFIG_CARDMAN_4040=y
# CONFIG_SCR24X is not set
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

CONFIG_MWAVE=y
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
CONFIG_DEVMEM=y
# CONFIG_NVRAM is not set
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C_CR50=y
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=y
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TELCLOCK=y
CONFIG_XILLYBUS_CLASS=y
# CONFIG_XILLYBUS is not set
CONFIG_XILLYUSB=y
CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_GPMUX is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_PINCTRL is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=y
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=y
CONFIG_I2C_TAOS_EVM=y
CONFIG_I2C_TINY_USB=y
# CONFIG_I2C_VIPERBOARD is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_PCA_ISA is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_FSI is not set
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
CONFIG_DW_I3C_MASTER=y
CONFIG_SVC_I3C_MASTER=y
# CONFIG_MIPI_I3C_HCI is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
CONFIG_SPMI_HISI3670=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=y
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_EQUILIBRIUM=y
CONFIG_PINCTRL_MAX77620=y
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_RK805 is not set
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_STMFX=y
CONFIG_PINCTRL_SX150X=y
# CONFIG_PINCTRL_LOCHNAGAR is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L35=y

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_LOGICVC=y
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MENZ127 is not set
CONFIG_GPIO_SAMA5D2_PIOBU=y
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SIOX=y
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_WCD934X=y
CONFIG_GPIO_XILINX=y
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_IT87 is not set
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=y
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_DLN2=y
CONFIG_GPIO_MADERA=y
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TPS65086=y
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=y
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=y
CONFIG_MAX8925_POWER=y
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
CONFIG_TEST_POWER=y
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_ACT8945A is not set
# CONFIG_BATTERY_CW2015 is not set
CONFIG_BATTERY_DS2760=y
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_ISP1704=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_LTC4162L=y
CONFIG_CHARGER_MAX14577=y
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
# CONFIG_CHARGER_MAX77976 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=y
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65217=y
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
# CONFIG_CHARGER_UCS1002 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_RN5T618_POWER=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AQUACOMPUTER_D5NEXT=y
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_CORSAIR_CPRO=y
# CONFIG_SENSORS_CORSAIR_PSU is not set
CONFIG_SENSORS_DRIVETEMP=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_GSC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LOCHNAGAR=y
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX127 is not set
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_MLXREG_FAN is not set
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_MR75203=y
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_NZXT_KRAKEN2=y
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
CONFIG_SENSORS_ADM1266=y
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_BEL_PFE=y
CONFIG_SENSORS_BPA_RS600=y
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
CONFIG_SENSORS_FSP_3Y=y
# CONFIG_SENSORS_IBM_CFFPS is not set
CONFIG_SENSORS_DPS920AB=y
CONFIG_SENSORS_INSPUR_IPSPS=y
CONFIG_SENSORS_IR35221=y
# CONFIG_SENSORS_IR36021 is not set
CONFIG_SENSORS_IR38064=y
# CONFIG_SENSORS_IR38064_REGULATOR is not set
CONFIG_SENSORS_IRPS5401=y
CONFIG_SENSORS_ISL68137=y
CONFIG_SENSORS_LM25066=y
CONFIG_SENSORS_LTC2978=y
CONFIG_SENSORS_LTC2978_REGULATOR=y
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX16601=y
CONFIG_SENSORS_MAX20730=y
CONFIG_SENSORS_MAX20751=y
# CONFIG_SENSORS_MAX31785 is not set
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
CONFIG_SENSORS_PIM4328=y
# CONFIG_SENSORS_PM6764TR is not set
CONFIG_SENSORS_PXE1610=y
CONFIG_SENSORS_Q54SJ108A2=y
CONFIG_SENSORS_STPDDC60=y
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_XDPE122=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_SBTSI=y
# CONFIG_SENSORS_SBRMI is not set
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHT4x=y
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=y
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_TMP513 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM831X=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
CONFIG_MAX77620_THERMAL=y

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
# CONFIG_X86_PKG_TEMP_THERMAL is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_INTEL_TCC_COOLING=y
# CONFIG_INTEL_MENLOW is not set
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=y
CONFIG_MFD_AS3711=y
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
CONFIG_MFD_CS47L15=y
CONFIG_MFD_CS47L35=y
# CONFIG_MFD_CS47L85 is not set
# CONFIG_MFD_CS47L90 is not set
# CONFIG_MFD_CS47L92 is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=y
CONFIG_MFD_GATEWORKS_GSC=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_MP2629=y
CONFIG_MFD_HI6421_PMIC=y
CONFIG_MFD_HI6421_SPMI=y
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77650 is not set
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_NTXEC=y
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT4831=y
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TI_LP87565 is not set
# CONFIG_MFD_TPS65218 is not set
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_LOCHNAGAR=y
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_MFD_ROHM_BD718XX=y
# CONFIG_MFD_ROHM_BD71828 is not set
CONFIG_MFD_ROHM_BD957XMUF=y
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
CONFIG_MFD_WCD934X=y
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
# CONFIG_MFD_QCOM_PM8008 is not set
# CONFIG_MFD_RSMU_I2C is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_ACT8945A=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ARIZONA_LDO1=y
CONFIG_REGULATOR_ARIZONA_MICSUPP=y
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_ATC260X=y
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD718XX=y
# CONFIG_REGULATOR_BD957XMUF is not set
CONFIG_REGULATOR_DA9121=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_FAN53880 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_HI6421V600=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LOCHNAGAR=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8893 is not set
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77686=y
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MCP16502=y
# CONFIG_REGULATOR_MP5416 is not set
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MP886X=y
CONFIG_REGULATOR_MPQ7920=y
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6315=y
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6358=y
# CONFIG_REGULATOR_MT6359 is not set
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PCA9450=y
# CONFIG_REGULATOR_PF8X00 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_QCOM_USB_VBUS=y
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_RK808=y
# CONFIG_REGULATOR_RN5T618 is not set
CONFIG_REGULATOR_ROHM=y
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT4831=y
CONFIG_REGULATOR_RT6160=y
CONFIG_REGULATOR_RT6245=y
# CONFIG_REGULATOR_RTQ2134 is not set
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_RTQ6752=y
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SKY81452=y
# CONFIG_REGULATOR_SLG51000 is not set
CONFIG_REGULATOR_STPMIC1=y
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=y
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65086 is not set
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=y
# CONFIG_REGULATOR_TPS6586X is not set
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8994=y
CONFIG_REGULATOR_QCOM_LABIBB=y
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
# CONFIG_LIRC is not set
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=y
# CONFIG_IR_ENE is not set
CONFIG_IR_HIX5HD2=y
CONFIG_IR_IMON=y
CONFIG_IR_IMON_RAW=y
CONFIG_IR_MCEUSB=y
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
CONFIG_IR_REDRAT3=y
CONFIG_IR_STREAMZAP=y
# CONFIG_IR_WINBOND_CIR is not set
CONFIG_IR_IGORPLUGUSB=y
CONFIG_IR_IGUANA=y
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=y
# CONFIG_IR_GPIO_CIR is not set
# CONFIG_IR_SERIAL is not set
CONFIG_RC_XBOX_DVD=y
# CONFIG_IR_TOY is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FLASH_LED_CLASS=y
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=y
# CONFIG_DVB_PLATFORM_DRIVERS is not set
CONFIG_SDR_PLATFORM_DRIVERS=y
# CONFIG_V4L_TEST_DRIVERS is not set
CONFIG_DVB_TEST_DRIVERS=y
CONFIG_DVB_VIDTV=y
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=y

#
# audio, video and radio I2C drivers auto-selected by 'Autoselect ancillary drivers'
#

#
# Video and audio decoders
#

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_CCS_PLL=y
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_IMX208 is not set
# CONFIG_VIDEO_IMX214 is not set
CONFIG_VIDEO_IMX219=y
CONFIG_VIDEO_IMX258=y
CONFIG_VIDEO_IMX274=y
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
CONFIG_VIDEO_IMX334=y
# CONFIG_VIDEO_IMX335 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_IMX412 is not set
CONFIG_VIDEO_OV02A10=y
# CONFIG_VIDEO_OV2640 is not set
CONFIG_VIDEO_OV2659=y
CONFIG_VIDEO_OV2680=y
CONFIG_VIDEO_OV2685=y
# CONFIG_VIDEO_OV2740 is not set
CONFIG_VIDEO_OV5640=y
CONFIG_VIDEO_OV5645=y
CONFIG_VIDEO_OV5647=y
CONFIG_VIDEO_OV5648=y
CONFIG_VIDEO_OV6650=y
CONFIG_VIDEO_OV5670=y
CONFIG_VIDEO_OV5675=y
# CONFIG_VIDEO_OV5693 is not set
CONFIG_VIDEO_OV5695=y
# CONFIG_VIDEO_OV7251 is not set
CONFIG_VIDEO_OV772X=y
CONFIG_VIDEO_OV7640=y
# CONFIG_VIDEO_OV7670 is not set
CONFIG_VIDEO_OV7740=y
CONFIG_VIDEO_OV8856=y
CONFIG_VIDEO_OV8865=y
# CONFIG_VIDEO_OV9282 is not set
CONFIG_VIDEO_OV9640=y
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_OV13B10 is not set
CONFIG_VIDEO_VS6624=y
CONFIG_VIDEO_MT9M001=y
CONFIG_VIDEO_MT9M032=y
CONFIG_VIDEO_MT9M111=y
CONFIG_VIDEO_MT9P031=y
CONFIG_VIDEO_MT9T001=y
CONFIG_VIDEO_MT9T112=y
CONFIG_VIDEO_MT9V011=y
CONFIG_VIDEO_MT9V032=y
CONFIG_VIDEO_MT9V111=y
CONFIG_VIDEO_SR030PC30=y
# CONFIG_VIDEO_NOON010PC30 is not set
CONFIG_VIDEO_M5MOLS=y
CONFIG_VIDEO_MAX9271_LIB=y
# CONFIG_VIDEO_RDACM20 is not set
CONFIG_VIDEO_RDACM21=y
CONFIG_VIDEO_RJ54N1=y
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
CONFIG_VIDEO_S5K4ECGX=y
CONFIG_VIDEO_S5K5BAF=y
CONFIG_VIDEO_CCS=y
CONFIG_VIDEO_ET8EK8=y
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=y
CONFIG_VIDEO_AK7375=y
# CONFIG_VIDEO_DW9714 is not set
CONFIG_VIDEO_DW9768=y
CONFIG_VIDEO_DW9807_VCM=y
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
CONFIG_VIDEO_LM3560=y
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

CONFIG_MEDIA_TUNER=y

#
# Tuner drivers auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MC44S803=y

#
# DVB Frontend drivers auto-selected by 'Autoselect ancillary drivers'
#

#
# Multistandard (satellite) frontends
#

#
# Multistandard (cable + terrestrial) frontends
#

#
# DVB-S (satellite) frontends
#

#
# DVB-T (terrestrial) frontends
#

#
# DVB-C (cable) frontends
#

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#

#
# ISDB-T (terrestrial) frontends
#

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#

#
# Digital terrestrial only tuners/PLL
#

#
# SEC control devices for DVB-S
#

#
# Common Interface (EN50221) controller drivers
#

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_FB_N411=y
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=y
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
CONFIG_FB_SM501=y
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_MAX8925 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_RT4831=y
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP8860=y
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_SKY81452 is not set
# CONFIG_BACKLIGHT_TPS65217 is not set
CONFIG_BACKLIGHT_AS3711=y
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_LED=y
# end of Backlight & LCD device support

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# CONFIG_FRAMEBUFFER_CONSOLE is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
# CONFIG_SND_PCM_XRUN_DEBUG is not set
# CONFIG_SND_CTL_VALIDATION is not set
CONFIG_SND_JACK_INJECTION_DEBUG=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_SEQ_MIDI=y
CONFIG_SND_SEQ_MIDI_EMUL=y
CONFIG_SND_SEQ_VIRMIDI=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_OPL4_LIB=y
CONFIG_SND_OPL3_LIB_SEQ=y
CONFIG_SND_OPL4_LIB_SEQ=y
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_WSS_LIB=y
CONFIG_SND_SB_COMMON=y
CONFIG_SND_SB8_DSP=y
CONFIG_SND_SB16_DSP=y
CONFIG_SND_ISA=y
CONFIG_SND_ADLIB=y
# CONFIG_SND_AD1816A is not set
CONFIG_SND_AD1848=y
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT1605 is not set
# CONFIG_SND_AZT2316 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8328 is not set
CONFIG_SND_CMI8330=y
# CONFIG_SND_CS4231 is not set
CONFIG_SND_CS4236=y
CONFIG_SND_ES1688=y
# CONFIG_SND_ES18XX is not set
CONFIG_SND_SC6000=y
CONFIG_SND_GUSCLASSIC=y
# CONFIG_SND_GUSEXTREME is not set
CONFIG_SND_GUSMAX=y
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
CONFIG_SND_JAZZ16=y
CONFIG_SND_OPL3SA2=y
CONFIG_SND_OPTI92X_AD1848=y
# CONFIG_SND_OPTI92X_CS4231 is not set
CONFIG_SND_OPTI93X=y
CONFIG_SND_MIRO=y
CONFIG_SND_SB8=y
CONFIG_SND_SB16=y
CONFIG_SND_SBAWE=y
CONFIG_SND_SBAWE_SEQ=y
CONFIG_SND_SB16_CSP=y
CONFIG_SND_SSCAPE=y
CONFIG_SND_WAVEFRONT=y
# CONFIG_SND_MSND_PINNACLE is not set
CONFIG_SND_MSND_CLASSIC=y
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SIS7019 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
# end of HD-Audio

CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=y
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=y
# CONFIG_SND_USB is not set
# CONFIG_SND_PCMCIA is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_ACPI=y
# CONFIG_SND_SOC_ADI is not set
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_SOC_AMD_ACP5x is not set
# CONFIG_SND_SOC_AMD_ACP6x is not set
# CONFIG_SND_AMD_ACP_CONFIG is not set
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
# CONFIG_SND_ATMEL_SOC is not set
CONFIG_SND_BCM63XX_I2S_WHISTLER=y
CONFIG_SND_DESIGNWARE_I2S=y
CONFIG_SND_DESIGNWARE_PCM=y

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=y
CONFIG_SND_SOC_FSL_SAI=y
# CONFIG_SND_SOC_FSL_MQS is not set
CONFIG_SND_SOC_FSL_AUDMIX=y
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_SPDIF=y
CONFIG_SND_SOC_FSL_ESAI=y
CONFIG_SND_SOC_FSL_MICFIL=y
CONFIG_SND_SOC_FSL_EASRC=y
CONFIG_SND_SOC_FSL_XCVR=y
CONFIG_SND_SOC_FSL_RPMSG=y
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=y
CONFIG_SND_SOC_IMG=y
# CONFIG_SND_SOC_IMG_I2S_IN is not set
# CONFIG_SND_SOC_IMG_I2S_OUT is not set
CONFIG_SND_SOC_IMG_PARALLEL_OUT=y
CONFIG_SND_SOC_IMG_SPDIF_IN=y
CONFIG_SND_SOC_IMG_SPDIF_OUT=y
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=y
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
# CONFIG_SND_SOC_INTEL_CATPT is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=y
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=y
# CONFIG_SND_SOC_INTEL_SKYLAKE is not set
# CONFIG_SND_SOC_INTEL_SKL is not set
# CONFIG_SND_SOC_INTEL_APL is not set
# CONFIG_SND_SOC_INTEL_KBL is not set
# CONFIG_SND_SOC_INTEL_GLK is not set
# CONFIG_SND_SOC_INTEL_CNL is not set
# CONFIG_SND_SOC_INTEL_CFL is not set
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_ACPI_INTEL_MATCH=y
CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
CONFIG_SND_SOC_MTK_BTCVSD=y
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

CONFIG_SND_SOC_XILINX_I2S=y
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
CONFIG_SND_SOC_XILINX_SPDIF=y
CONFIG_SND_SOC_XTFPGA_I2S=y
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
CONFIG_SND_SOC_ADAU_UTILS=y
CONFIG_SND_SOC_ADAU1372=y
CONFIG_SND_SOC_ADAU1372_I2C=y
CONFIG_SND_SOC_ADAU1701=y
CONFIG_SND_SOC_ADAU17X1=y
CONFIG_SND_SOC_ADAU1761=y
CONFIG_SND_SOC_ADAU1761_I2C=y
# CONFIG_SND_SOC_ADAU7002 is not set
CONFIG_SND_SOC_ADAU7118=y
CONFIG_SND_SOC_ADAU7118_HW=y
# CONFIG_SND_SOC_ADAU7118_I2C is not set
CONFIG_SND_SOC_AK4118=y
# CONFIG_SND_SOC_AK4375 is not set
# CONFIG_SND_SOC_AK4458 is not set
CONFIG_SND_SOC_AK4554=y
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
CONFIG_SND_SOC_AK5386=y
CONFIG_SND_SOC_AK5558=y
CONFIG_SND_SOC_ALC5623=y
CONFIG_SND_SOC_BD28623=y
# CONFIG_SND_SOC_BT_SCO is not set
CONFIG_SND_SOC_CS35L32=y
CONFIG_SND_SOC_CS35L33=y
CONFIG_SND_SOC_CS35L34=y
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS35L41_I2C is not set
CONFIG_SND_SOC_CS42L42=y
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
CONFIG_SND_SOC_CS42L56=y
CONFIG_SND_SOC_CS42L73=y
# CONFIG_SND_SOC_CS4234 is not set
CONFIG_SND_SOC_CS4265=y
CONFIG_SND_SOC_CS4270=y
CONFIG_SND_SOC_CS4271=y
CONFIG_SND_SOC_CS4271_I2C=y
CONFIG_SND_SOC_CS42XX8=y
CONFIG_SND_SOC_CS42XX8_I2C=y
CONFIG_SND_SOC_CS43130=y
CONFIG_SND_SOC_CS4341=y
CONFIG_SND_SOC_CS4349=y
CONFIG_SND_SOC_CS53L30=y
CONFIG_SND_SOC_CX2072X=y
# CONFIG_SND_SOC_DA7213 is not set
CONFIG_SND_SOC_DMIC=y
CONFIG_SND_SOC_ES7134=y
CONFIG_SND_SOC_ES7241=y
CONFIG_SND_SOC_ES8316=y
# CONFIG_SND_SOC_ES8328_I2C is not set
CONFIG_SND_SOC_GTM601=y
# CONFIG_SND_SOC_ICS43432 is not set
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_LOCHNAGAR_SC is not set
CONFIG_SND_SOC_MAX98088=y
# CONFIG_SND_SOC_MAX98357A is not set
CONFIG_SND_SOC_MAX98504=y
CONFIG_SND_SOC_MAX9867=y
CONFIG_SND_SOC_MAX98927=y
# CONFIG_SND_SOC_MAX98520 is not set
CONFIG_SND_SOC_MAX98373=y
CONFIG_SND_SOC_MAX98373_I2C=y
CONFIG_SND_SOC_MAX98373_SDW=y
CONFIG_SND_SOC_MAX98390=y
CONFIG_SND_SOC_MAX9860=y
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=y
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=y
# CONFIG_SND_SOC_PCM1681 is not set
CONFIG_SND_SOC_PCM1789=y
CONFIG_SND_SOC_PCM1789_I2C=y
# CONFIG_SND_SOC_PCM179X_I2C is not set
CONFIG_SND_SOC_PCM186X=y
CONFIG_SND_SOC_PCM186X_I2C=y
CONFIG_SND_SOC_PCM3060=y
CONFIG_SND_SOC_PCM3060_I2C=y
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
CONFIG_SND_SOC_PCM5102A=y
# CONFIG_SND_SOC_PCM512x_I2C is not set
CONFIG_SND_SOC_RK3328=y
CONFIG_SND_SOC_RK817=y
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RT1308_SDW=y
CONFIG_SND_SOC_RT1316_SDW=y
CONFIG_SND_SOC_RT5616=y
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=y
CONFIG_SND_SOC_RT5659=y
CONFIG_SND_SOC_RT5682=y
CONFIG_SND_SOC_RT5682_SDW=y
CONFIG_SND_SOC_RT700=y
CONFIG_SND_SOC_RT700_SDW=y
# CONFIG_SND_SOC_RT711_SDW is not set
CONFIG_SND_SOC_RT711_SDCA_SDW=y
CONFIG_SND_SOC_RT715=y
CONFIG_SND_SOC_RT715_SDW=y
CONFIG_SND_SOC_RT715_SDCA_SDW=y
# CONFIG_SND_SOC_RT9120 is not set
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_I2C=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
CONFIG_SND_SOC_SIMPLE_MUX=y
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SSM2305=y
CONFIG_SND_SOC_SSM2518=y
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=y
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
CONFIG_SND_SOC_TAS2552=y
CONFIG_SND_SOC_TAS2562=y
CONFIG_SND_SOC_TAS2764=y
CONFIG_SND_SOC_TAS2770=y
CONFIG_SND_SOC_TAS5086=y
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
CONFIG_SND_SOC_TAS6424=y
# CONFIG_SND_SOC_TDA7419 is not set
CONFIG_SND_SOC_TFA9879=y
CONFIG_SND_SOC_TFA989X=y
# CONFIG_SND_SOC_TLV320ADC3XXX is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
CONFIG_SND_SOC_TLV320AIC31XX=y
CONFIG_SND_SOC_TLV320AIC32X4=y
CONFIG_SND_SOC_TLV320AIC32X4_I2C=y
# CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
CONFIG_SND_SOC_TLV320ADCX140=y
CONFIG_SND_SOC_TS3A227E=y
CONFIG_SND_SOC_TSCS42XX=y
# CONFIG_SND_SOC_TSCS454 is not set
CONFIG_SND_SOC_UDA1334=y
# CONFIG_SND_SOC_WCD9335 is not set
# CONFIG_SND_SOC_WCD934X is not set
# CONFIG_SND_SOC_WCD938X_SDW is not set
CONFIG_SND_SOC_WM8510=y
# CONFIG_SND_SOC_WM8523 is not set
CONFIG_SND_SOC_WM8524=y
CONFIG_SND_SOC_WM8580=y
CONFIG_SND_SOC_WM8711=y
# CONFIG_SND_SOC_WM8728 is not set
CONFIG_SND_SOC_WM8731=y
CONFIG_SND_SOC_WM8737=y
CONFIG_SND_SOC_WM8741=y
# CONFIG_SND_SOC_WM8750 is not set
CONFIG_SND_SOC_WM8753=y
CONFIG_SND_SOC_WM8776=y
CONFIG_SND_SOC_WM8782=y
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
CONFIG_SND_SOC_WM8903=y
CONFIG_SND_SOC_WM8904=y
CONFIG_SND_SOC_WM8960=y
CONFIG_SND_SOC_WM8962=y
CONFIG_SND_SOC_WM8974=y
# CONFIG_SND_SOC_WM8978 is not set
CONFIG_SND_SOC_WM8985=y
CONFIG_SND_SOC_WSA881X=y
CONFIG_SND_SOC_MAX9759=y
CONFIG_SND_SOC_MT6351=y
# CONFIG_SND_SOC_MT6358 is not set
CONFIG_SND_SOC_MT6660=y
CONFIG_SND_SOC_NAU8315=y
CONFIG_SND_SOC_NAU8540=y
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8821 is not set
CONFIG_SND_SOC_NAU8822=y
CONFIG_SND_SOC_NAU8824=y
CONFIG_SND_SOC_TPA6130A2=y
CONFIG_SND_SOC_LPASS_WSA_MACRO=y
CONFIG_SND_SOC_LPASS_VA_MACRO=y
CONFIG_SND_SOC_LPASS_RX_MACRO=y
CONFIG_SND_SOC_LPASS_TX_MACRO=y
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=y
CONFIG_SND_SIMPLE_CARD=y
# CONFIG_SND_AUDIO_GRAPH_CARD is not set
# CONFIG_SND_AUDIO_GRAPH_CARD2 is not set
# CONFIG_SND_TEST_COMPONENT is not set
CONFIG_SND_X86=y
CONFIG_SND_SYNTH_EMUX=y
# CONFIG_SND_VIRTIO is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACCUTOUCH=y
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=y
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=y
# CONFIG_HID_BELKIN is not set
CONFIG_HID_BETOP_FF=y
CONFIG_HID_BIGBEN_FF=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
CONFIG_HID_CORSAIR=y
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=y
CONFIG_HID_PRODIKEYS=y
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CP2112=y
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELAN=y
# CONFIG_HID_ELECOM is not set
CONFIG_HID_ELO=y
CONFIG_HID_EZKEY=y
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
CONFIG_HID_HOLTEK=y
CONFIG_HOLTEK_FF=y
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_UCLOGIC=y
CONFIG_HID_WALTOP=y
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
# CONFIG_HID_LETSKETCH is not set
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=y
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PENMOUNT=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PLAYSTATION=y
CONFIG_PLAYSTATION_FF=y
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=y
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=y
CONFIG_HID_MCP2221=y
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set
CONFIG_I2C_HID_OF_GOODIX=y
# end of I2C HID support

CONFIG_I2C_HID_CORE=y
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
CONFIG_USB_FEW_INIT_RETRIES=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_DBGCAP=y
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PCI_RENESAS=y
CONFIG_USB_XHCI_PLATFORM=y
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=y
# CONFIG_USB_SL811_HCD_ISO is not set
CONFIG_USB_SL811_CS=y
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
# CONFIG_USB_STORAGE is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS_SUPPORT=y
CONFIG_USB_CDNS3=y
CONFIG_USB_CDNS3_GADGET=y
# CONFIG_USB_CDNS3_HOST is not set
CONFIG_USB_CDNS3_PCI_WRAP=y
# CONFIG_USB_CDNSP_PCI is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_ULPI=y
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
CONFIG_USB_DWC3_OF_SIMPLE=y
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
# CONFIG_USB_DWC2_DUAL_ROLE is not set
# CONFIG_USB_DWC2_PCI is not set
# CONFIG_USB_DWC2_DEBUG is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_CHIPIDEA is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
CONFIG_USB_ISP1760_GADGET_ROLE=y
# CONFIG_USB_ISP1760_DUAL_ROLE is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_LEGOTOWER=y
# CONFIG_USB_LCD is not set
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=y
CONFIG_APPLE_MFI_FASTCHARGE=y
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=y
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
# CONFIG_USB_HSIC_USB3503 is not set
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_CHAOSKEY=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
CONFIG_USB_ISP1301=y
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
CONFIG_U_SERIAL_CONSOLE=y

#
# USB Peripheral Controller
#
CONFIG_USB_FUSB300=y
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
CONFIG_USB_PXA27X=y
# CONFIG_USB_MV_UDC is not set
CONFIG_USB_MV_U3D=y
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
CONFIG_USB_M66592=y
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_GADGET_XILINX is not set
CONFIG_USB_DUMMY_HCD=y
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_ACM=y
CONFIG_USB_F_SS_LB=y
CONFIG_USB_U_SERIAL=y
CONFIG_USB_U_AUDIO=y
CONFIG_USB_F_SERIAL=y
CONFIG_USB_F_OBEX=y
CONFIG_USB_F_UAC1=y
CONFIG_USB_F_MIDI=y
CONFIG_USB_F_HID=y
CONFIG_USB_F_PRINTER=y
CONFIG_USB_F_TCM=y
CONFIG_USB_CONFIGFS=y
CONFIG_USB_CONFIGFS_SERIAL=y
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
# CONFIG_USB_CONFIGFS_MASS_STORAGE is not set
CONFIG_USB_CONFIGFS_F_LB_SS=y
# CONFIG_USB_CONFIGFS_F_FS is not set
# CONFIG_USB_CONFIGFS_F_UAC1 is not set
# CONFIG_USB_CONFIGFS_F_UAC1_LEGACY is not set
# CONFIG_USB_CONFIGFS_F_UAC2 is not set
# CONFIG_USB_CONFIGFS_F_MIDI is not set
CONFIG_USB_CONFIGFS_F_HID=y
# CONFIG_USB_CONFIGFS_F_UVC is not set
# CONFIG_USB_CONFIGFS_F_PRINTER is not set
CONFIG_USB_CONFIGFS_F_TCM=y

#
# USB Gadget precomposed configurations
#
# CONFIG_USB_ZERO is not set
CONFIG_USB_AUDIO=y
CONFIG_GADGET_UAC1=y
# CONFIG_GADGET_UAC1_LEGACY is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
CONFIG_USB_GADGETFS=y
# CONFIG_USB_FUNCTIONFS is not set
# CONFIG_USB_MASS_STORAGE is not set
CONFIG_USB_GADGET_TARGET=y
CONFIG_USB_G_SERIAL=y
CONFIG_USB_MIDI_GADGET=y
CONFIG_USB_G_PRINTER=y
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
CONFIG_USB_G_HID=y
CONFIG_USB_G_DBGP=y
# CONFIG_USB_G_DBGP_PRINTK is not set
CONFIG_USB_G_DBGP_SERIAL=y
# CONFIG_USB_G_WEBCAM is not set
# CONFIG_USB_RAW_GADGET is not set
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
# CONFIG_TYPEC_UCSI is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_HD3SS3220 is not set
CONFIG_TYPEC_STUSB160X=y

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=y
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_APU=y
# CONFIG_LEDS_AW2013 is not set
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_LM3692X is not set
# CONFIG_LEDS_MT6323 is not set
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=y
# CONFIG_LEDS_LM3697 is not set
CONFIG_LEDS_LM36274=y
CONFIG_LEDS_TPS6105X=y
CONFIG_LEDS_LGM=y

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AAT1290=y
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_KTD2692=y
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_RT4505=y
CONFIG_LEDS_RT8515=y
CONFIG_LEDS_SGM3140=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
CONFIG_LEDS_TRIGGER_TTY=y

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I7CORE is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_DW_AXI_DMAC=y
CONFIG_FSL_EDMA=y
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_PCH_DMA is not set
# CONFIG_PLX_DMA is not set
CONFIG_XILINX_ZYNQMP_DPDMA=y
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
CONFIG_INTEL_LDMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
CONFIG_DMABUF_MOVE_NOTIFY=y
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
CONFIG_DMABUF_SYSFS_STATS=y
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI is not set
CONFIG_VFIO_MDEV=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_BALLOON is not set
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=y
CONFIG_VHOST=y
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_SCSI=y
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=y
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=y
CONFIG_COMEDI_TEST=y
CONFIG_COMEDI_PARPORT=y
CONFIG_COMEDI_SSV_DNP=y
# CONFIG_COMEDI_ISA_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_PCMCIA_DRIVERS=y
CONFIG_COMEDI_CB_DAS16_CS=y
# CONFIG_COMEDI_DAS08_CS is not set
CONFIG_COMEDI_NI_DAQ_700_CS=y
# CONFIG_COMEDI_NI_DAQ_DIO24_CS is not set
# CONFIG_COMEDI_NI_LABPC_CS is not set
CONFIG_COMEDI_NI_MIO_CS=y
CONFIG_COMEDI_QUATECH_DAQP_CS=y
CONFIG_COMEDI_USB_DRIVERS=y
CONFIG_COMEDI_DT9812=y
CONFIG_COMEDI_NI_USB6501=y
# CONFIG_COMEDI_USBDUX is not set
CONFIG_COMEDI_USBDUXFAST=y
# CONFIG_COMEDI_USBDUXSIGMA is not set
# CONFIG_COMEDI_VMK80XX is not set
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
# CONFIG_COMEDI_TESTS is not set
# CONFIG_STAGING is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
CONFIG_MLXREG_IO=y
# CONFIG_MLXREG_LC is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_MAX9485=y
CONFIG_COMMON_CLK_RK808=y
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CDCE925=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_LAN966X is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
CONFIG_COMMON_CLK_AXI_CLKGEN=y
# CONFIG_COMMON_CLK_LOCHNAGAR is not set
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_BD718XX=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_LGM_CGU is not set
CONFIG_XILINX_VCU=y
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_CLKSRC_MMIO=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
CONFIG_MAILBOX_TEST=y
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
# CONFIG_SOUNDWIRE_INTEL is not set
CONFIG_SOUNDWIRE_QCOM=y

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# CONFIG_LITEX_SOC_CONTROLLER is not set
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
# CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND is not set
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_FSA9480=y
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_MAX77843 is not set
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_TUSB320=y
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
# CONFIG_ADXL313_I2C is not set
# CONFIG_ADXL355_I2C is not set
CONFIG_ADXL372=y
CONFIG_ADXL372_I2C=y
# CONFIG_BMA180 is not set
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_DA280=y
CONFIG_DA311=y
CONFIG_DMARD06=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
CONFIG_FXLS8962AF=y
CONFIG_FXLS8962AF_I2C=y
CONFIG_IIO_ST_ACCEL_3AXIS=y
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
CONFIG_KXSD9=y
CONFIG_KXSD9_I2C=y
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=y
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=y
# CONFIG_MXC6255 is not set
CONFIG_STK8312=y
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7091R5=y
CONFIG_AD7291=y
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
# CONFIG_AD799X is not set
# CONFIG_ADI_AXI_ADC is not set
# CONFIG_CC10001_ADC is not set
CONFIG_DLN2_ADC=y
# CONFIG_ENVELOPE_DETECTOR is not set
CONFIG_HX711=y
# CONFIG_LTC2471 is not set
CONFIG_LTC2485=y
# CONFIG_LTC2497 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
CONFIG_MCP3422=y
CONFIG_MEN_Z188_ADC=y
# CONFIG_MP2629_ADC is not set
CONFIG_NAU7802=y
CONFIG_QCOM_SPMI_IADC=y
# CONFIG_QCOM_SPMI_VADC is not set
# CONFIG_QCOM_SPMI_ADC5 is not set
CONFIG_RN5T618_ADC=y
CONFIG_SD_ADC_MODULATOR=y
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADS1015=y
# CONFIG_TI_AM335X_ADC is not set
CONFIG_VF610_ADC=y
CONFIG_VIPERBOARD_ADC=y
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_HMC425=y
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_ATLAS_EZO_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SCD30_CORE is not set
# CONFIG_SCD4X is not set
CONFIG_SENSIRION_SGP30=y
CONFIG_SENSIRION_SGP40=y
CONFIG_SPS30=y
CONFIG_SPS30_I2C=y
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5380=y
CONFIG_AD5446=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
CONFIG_AD5686=y
CONFIG_AD5696_I2C=y
CONFIG_DPOT_DAC=y
CONFIG_DS4424=y
CONFIG_M62332=y
CONFIG_MAX517=y
CONFIG_MAX5821=y
CONFIG_MCP4725=y
CONFIG_TI_DAC5571=y
CONFIG_VF610_DAC=y
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Filters
#
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
CONFIG_MAX30100=y
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
# CONFIG_HDC100X is not set
CONFIG_HDC2010=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_BMI160_I2C is not set
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
CONFIG_KMX61=y
CONFIG_INV_ICM42600=y
CONFIG_INV_ICM42600_I2C=y
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_I3C=y
CONFIG_IIO_ST_LSM9DS0=y
CONFIG_IIO_ST_LSM9DS0_I2C=y
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
# CONFIG_AS73211 is not set
CONFIG_BH1750=y
CONFIG_BH1780=y
CONFIG_CM32181=y
CONFIG_CM3232=y
CONFIG_CM3323=y
# CONFIG_CM3605 is not set
CONFIG_CM36651=y
# CONFIG_GP2AP002 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_IQS621_ALS is not set
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=y
CONFIG_ISL29125=y
CONFIG_JSA1212=y
# CONFIG_RPR0521 is not set
CONFIG_LTR501=y
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
CONFIG_MAX44009=y
CONFIG_NOA1305=y
CONFIG_OPT3001=y
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
# CONFIG_TSL2583 is not set
CONFIG_TSL2591=y
CONFIG_TSL2772=y
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
CONFIG_VEML6030=y
# CONFIG_VEML6070 is not set
CONFIG_VL6180=y
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_MAG3110=y
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
CONFIG_YAMAHA_YAS530=y
# end of Magnetometer sensors

#
# Multiplexers
#
# CONFIG_IIO_MUX is not set
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

CONFIG_IIO_TEST_FORMAT=y

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=y
CONFIG_AD5272=y
CONFIG_DS1803=y
# CONFIG_MAX5432 is not set
CONFIG_MCP4018=y
# CONFIG_MCP4531 is not set
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
# CONFIG_DLHL60D is not set
CONFIG_DPS310=y
CONFIG_HP03=y
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL3115=y
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_T5403=y
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=y
CONFIG_MB1232=y
CONFIG_PING=y
CONFIG_RFD77402=y
CONFIG_SRF04=y
CONFIG_SX9310=y
CONFIG_SX9500=y
# CONFIG_SRF08 is not set
CONFIG_VCNL3020=y
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=y
CONFIG_MLX90614=y
CONFIG_MLX90632=y
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TMP117=y
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_TI_SYSCON=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_USB_LGM_PHY=y
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
CONFIG_PHY_CADENCE_DPHY=y
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_CADENCE_SALVO=y
CONFIG_PHY_FSL_IMX8MQ_USB=y
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
# CONFIG_PHY_FSL_IMX8M_PCIE is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_LAN966X_SERDES is not set
CONFIG_PHY_CPCAP_USB=y
CONFIG_PHY_MAPPHONE_MDM6600=y
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=y
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_TUSB1210=y
CONFIG_PHY_INTEL_LGM_COMBO=y
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_INTEL_RAPL is not set
CONFIG_IDLE_INJECT=y
# CONFIG_DTPM is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_STM_SOURCE_FTRACE=y
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
CONFIG_FSI_MASTER_GPIO=y
CONFIG_FSI_MASTER_HUB=y
# CONFIG_FSI_MASTER_ASPEED is not set
# CONFIG_FSI_SCOM is not set
CONFIG_FSI_SBEFIFO=y
CONFIG_FSI_OCC=y
CONFIG_TEE=y

#
# TEE drivers
#
# end of TEE drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
CONFIG_MOST=y
CONFIG_MOST_USB_HDM=y
# CONFIG_MOST_CDEV is not set
# CONFIG_MOST_SND is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_SECURITY is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
# CONFIG_XFS_ASSERT_FATAL is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
CONFIG_F2FS_FS_SECURITY=y
CONFIG_F2FS_CHECK_FS=y
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_F2FS_IOSTAT is not set
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_FAT_KUNIT_TEST=y
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y
CONFIG_NTFS3_FS=y
CONFIG_NTFS3_LZX_XPRESS=y
CONFIG_NTFS3_FS_POSIX_ACL=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=y
# CONFIG_ECRYPT_FS is not set
CONFIG_HFS_FS=y
CONFIG_HFSPLUS_FS=y
CONFIG_BEFS_FS=y
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
CONFIG_JFFS2_SUMMARY=y
# CONFIG_JFFS2_FS_XATTR is not set
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_LZO=y
# CONFIG_JFFS2_RTIME is not set
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_JFFS2_CMODE_NONE is not set
# CONFIG_JFFS2_CMODE_PRIORITY is not set
# CONFIG_JFFS2_CMODE_SIZE is not set
CONFIG_JFFS2_CMODE_FAVOURLZO=y
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
# CONFIG_SQUASHFS_XATTR is not set
# CONFIG_SQUASHFS_ZLIB is not set
CONFIG_SQUASHFS_LZ4=y
# CONFIG_SQUASHFS_LZO is not set
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
CONFIG_QNX6FS_DEBUG=y
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS=y
CONFIG_PSTORE_LZ4_COMPRESS=y
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_FTRACE=y
# CONFIG_PSTORE_RAM is not set
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_EROFS_FS=y
# CONFIG_EROFS_FS_DEBUG is not set
# CONFIG_EROFS_FS_XATTR is not set
CONFIG_EROFS_FS_ZIP=y
# CONFIG_EROFS_FS_ZIP_LZMA is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
CONFIG_SECURITY_LOADPIN=y
# CONFIG_SECURITY_LOADPIN_ENFORCE is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
# CONFIG_IMA_TEMPLATE is not set
# CONFIG_IMA_NG_TEMPLATE is not set
CONFIG_IMA_SIG_TEMPLATE=y
CONFIG_IMA_DEFAULT_TEMPLATE="ima-sig"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
# CONFIG_IMA_DEFAULT_HASH_SM3 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_DISABLE_HTABLE=y
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
# CONFIG_CRYPTO_RSA is not set
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=y
# CONFIG_CRYPTO_SM2 is not set
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_BLAKE2S=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
# CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
# CONFIG_CRYPTO_DEV_GEODE is not set
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=y
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
CONFIG_CRYPTO_DEV_CCREE=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG=y
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_LIB_SM4=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_POOL=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
CONFIG_DYNAMIC_DEBUG_CORE=y
# CONFIG_SYMBOLIC_ERRNAME is not set
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_UNREACHABLE is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SLUB_DEBUG_ON=y
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_DEBUG_KMAP_LOCAL is not set
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
CONFIG_KFENCE=y
CONFIG_KFENCE_SAMPLE_INTERVAL=100
CONFIG_KFENCE_NUM_OBJECTS=255
CONFIG_KFENCE_STRESS_TEST_FAULTS=0
# CONFIG_KFENCE_KUNIT_TEST is not set
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_OSNOISE_TRACER=y
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_BRANCH_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
CONFIG_TRACE_EVENT_INJECT=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=y
CONFIG_TRACE_EVAL_MAP_FILE=y
CONFIG_FTRACE_RECORD_RECURSION=y
CONFIG_FTRACE_RECORD_RECURSION_SIZE=128
CONFIG_RING_BUFFER_RECORD_RECURSION=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_SAMPLES=y
CONFIG_SAMPLE_AUXDISPLAY=y
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_PRINTK is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
CONFIG_SAMPLE_KOBJECT=y
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_RPMSG_CLIENT is not set
# CONFIG_SAMPLE_CONFIGFS is not set
CONFIG_SAMPLE_HIDRAW=y
# CONFIG_SAMPLE_LANDLOCK is not set
# CONFIG_SAMPLE_PIDFD is not set
# CONFIG_SAMPLE_TIMER is not set
CONFIG_SAMPLE_UHID=y
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
CONFIG_SAMPLE_ANDROID_BINDERFS=y
# CONFIG_SAMPLE_VFS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_SAMPLE_WATCH_QUEUE=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
# CONFIG_KUNIT_ALL_TESTS is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage
# end of Kernel hacking

--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='boot-300s.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='vm-snb-i386-50'
	export tbox_group='vm-snb-i386'
	export branch='linux-devel/devel-hourly-20220224-180900'
	export commit='8d9eb678dac1a6a982248d80e18ac33f53ac7f1a'
	export kconfig='i386-randconfig-a011-20211019'
	export nr_vm=160
	export submit_id='62181cbd762079105742825e'
	export job_file='/lkp/jobs/scheduled/vm-snb-i386-50/boot-300-openwrt-i386-generic-20190428.cgz-8d9eb678dac1a6a982248d80e18ac33f53ac7f1a-20220225-69719-1uu4vs5-0.yaml'
	export id='a8406611e6b6d24ad177b1d2fb4d8e765f92dd8f'
	export queuer_version='/lkp-src'
	export model='qemu-system-i386 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='4G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23400
	export kernel_cmdline='vmalloc=128M initramfs_async=0 page_owner=on'
	export rootfs='openwrt-i386-generic-20190428.cgz'
	export compiler='gcc-9'
	export enqueue_time='2022-02-25 08:03:09 +0800'
	export _id='62181cbd762079105742825e'
	export _rt='/result/boot/300/vm-snb-i386/openwrt-i386-generic-20190428.cgz/i386-randconfig-a011-20211019/gcc-9/8d9eb678dac1a6a982248d80e18ac33f53ac7f1a'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/300/vm-snb-i386/openwrt-i386-generic-20190428.cgz/i386-randconfig-a011-20211019/gcc-9/8d9eb678dac1a6a982248d80e18ac33f53ac7f1a/8'
	export scheduler_version='/lkp/lkp/.src-20220224-234557'
	export arch='i386'
	export max_uptime=600
	export initrd='/osimage/openwrt/openwrt-i386-generic-20190428.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/300/vm-snb-i386/openwrt-i386-generic-20190428.cgz/i386-randconfig-a011-20211019/gcc-9/8d9eb678dac1a6a982248d80e18ac33f53ac7f1a/8
BOOT_IMAGE=/pkg/linux/i386-randconfig-a011-20211019/gcc-9/8d9eb678dac1a6a982248d80e18ac33f53ac7f1a/vmlinuz-5.17.0-rc4-00041-g8d9eb678dac1
branch=linux-devel/devel-hourly-20220224-180900
job=/lkp/jobs/scheduled/vm-snb-i386-50/boot-300-openwrt-i386-generic-20190428.cgz-8d9eb678dac1a6a982248d80e18ac33f53ac7f1a-20220225-69719-1uu4vs5-0.yaml
user=lkp
ARCH=i386
kconfig=i386-randconfig-a011-20211019
commit=8d9eb678dac1a6a982248d80e18ac33f53ac7f1a
vmalloc=128M initramfs_async=0 page_owner=on
max_uptime=600
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/i386-randconfig-a011-20211019/gcc-9/8d9eb678dac1a6a982248d80e18ac33f53ac7f1a/modules.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export kernel='/pkg/linux/i386-randconfig-a011-20211019/gcc-9/8d9eb678dac1a6a982248d80e18ac33f53ac7f1a/vmlinuz-5.17.0-rc4-00041-g8d9eb678dac1'
	export dequeue_time='2022-02-25 08:28:03 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-i386-50/boot-300-openwrt-i386-generic-20190428.cgz-8d9eb678dac1a6a982248d80e18ac33f53ac7f1a-20220225-69719-1uu4vs5-0.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 300
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--Qrgsu6vtpU/OV/zm
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--Qrgsu6vtpU/OV/zm--
