Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57E3571220
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 08:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiGLGJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 02:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGLGJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:09:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6714CDF39;
        Mon, 11 Jul 2022 23:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657606147; x=1689142147;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=P4m6SUVxnlaXHRWYp8+ffRjw9r45MsMJweHxIvkq51g=;
  b=KWuDejeZVzCz9F+55UMRdxEtwuAmjWqnB0wNIe+F3Fn205EYA7SRGoRi
   Y6uhX6299nSbudPKs91V2zEfoLuRjaQwSOyVgMjW5tO89eEHTzLciLp/y
   pROnt+H5ewXsFiEZco1U8cFYf8pVR3trBMbACiboYnrPQl0hB9UvqYXHt
   cOy4Wrai6PpSIk4nDMga/i7ejy6QvM4kiagwfEifvIOANo8V/fewHSlQD
   LitlczvQ3isqpcJXO+pWwYXYt1OrlDhSgOB6OX37ZrykxWEZnO1dVoxEa
   IO8bZR9YgzeFCW80sNmx0xujXdfEsjC3Zi3+V3zGlPKU7Iq12ZZNZTUl/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="285975928"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="xz'?yaml'?scan'208";a="285975928"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 23:09:06 -0700
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="xz'?yaml'?scan'208";a="622376929"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 23:09:01 -0700
Date:   Tue, 12 Jul 2022 14:08:58 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     0day robot <lkp@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org,
        openrisc@lists.librecores.org, linux-arch@vger.kernel.org,
        lkp@lists.01.org, akpm@linux-foundation.org, rppt@linux.ibm.com,
        willy@infradead.org, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org
Subject: [mm]  0bf5cdf08f: BUG:Bad_page_state_in_process
Message-ID: <Ys0P+ssAhAyfdA56@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hiuBKARmG6iOHIRg"
Content-Disposition: inline
In-Reply-To: <7882bbf467440f9a3ebe41d96ba5b6f384081bb7.1655887440.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hiuBKARmG6iOHIRg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-11):

commit: 0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257 ("[RFC PATCH v2 3/3] mm: Add kernel PTE level pagetable pages account")
url: https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/Add-PUD-and-kernel-PTE-level-pagetable-account/20220622-170051
base: https://git.kernel.org/cgit/linux/kernel/git/arnd/asm-generic.git master
patch link: https://lore.kernel.org/linux-mm/7882bbf467440f9a3ebe41d96ba5b6f384081bb7.1655887440.git.baolin.wang@linux.alibaba.com

in testcase: stress-ng
version: stress-ng-x86_64-0.11-06_20220709
with following parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: xfs
	class: filesystem
	test: dnotify
	cpufreq_governor: performance
	ucode: 0xb000280



on test machine: 96 threads 2 sockets Ice Lake with 256G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):



If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[   36.465236][ T1887] BUG: Bad page state in process ucfr  pfn:1ed9a9
[   36.465238][ T1887] page:00000000c52990fe refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x1ed9a9
[   36.465244][ T1887] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   36.465248][ T1887] raw: 0017ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   36.465249][ T1887] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   36.465249][ T1887] page dumped because: nonzero mapcount
[   36.465250][ T1887] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   36.465278][ T1887] CPU: 8 PID: 1887 Comm: ucfr Tainted: G S                5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   36.465280][ T1887] Call Trace:
[   36.465283][ T1887]  <TASK>
[ 36.465285][ T1887] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 36.465292][ T1887] bad_page.cold (mm/page_alloc.c:642) 
[ 36.465296][ T1887] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 36.465302][ T1887] free_unref_page (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3459) 
[ 36.465304][ T1887] __mmdrop (arch/x86/include/asm/mmu_context.h:125 (discriminator 3) kernel/fork.c:789 (discriminator 3)) 
[ 36.465307][ T1887] finish_task_switch+0x200/0x2c0 
[ 36.465312][ T1887] schedule_tail (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:5053) 
[ 36.465315][ T1887] ret_from_fork (arch/x86/entry/entry_64.S:289) 
[   36.465320][ T1887]  </TASK>
[   36.465320][ T1887] Disabling lock debugging due to kernel taint
[   37.204107][  T656] BUG: Bad page state in process kworker/7:1  pfn:4067654
[   37.204114][  T656] page:0000000017c1d009 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4067654
[   37.204120][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204126][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204128][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204128][  T656] page dumped because: nonzero mapcount
[   37.204129][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204165][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204168][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204181][  T656] Call Trace:
[   37.204184][  T656]  <TASK>
[ 37.204186][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204193][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204197][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204204][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204205][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204208][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204210][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204213][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204214][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204215][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204216][ T656] kthread (kernel/kthread.c:376) 
[ 37.204219][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204221][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204226][  T656]  </TASK>
[   37.204226][  T656] BUG: Bad page state in process kworker/7:1  pfn:4067655
[   37.204227][  T656] page:00000000c124fe48 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4067655
[   37.204228][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204229][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204230][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204231][  T656] page dumped because: nonzero mapcount
[   37.204231][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204243][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204244][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204245][  T656] Call Trace:
[   37.204246][  T656]  <TASK>
[ 37.204246][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204248][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204249][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204251][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204252][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204254][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204255][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204256][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204257][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204258][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204259][ T656] kthread (kernel/kthread.c:376) 
[ 37.204260][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204262][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204263][  T656]  </TASK>
[   37.204264][  T656] BUG: Bad page state in process kworker/7:1  pfn:4067b8f
[   37.204264][  T656] page:00000000efbe5d9e refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4067b8f
[   37.204265][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204266][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204266][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204267][  T656] page dumped because: nonzero mapcount
[   37.204267][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204279][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204280][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204281][  T656] Call Trace:
[   37.204281][  T656]  <TASK>
[ 37.204281][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204283][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204284][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204286][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204287][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204289][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204290][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204291][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204292][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204293][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204293][ T656] kthread (kernel/kthread.c:376) 
[ 37.204295][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204296][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204298][  T656]  </TASK>
[   37.204298][  T656] BUG: Bad page state in process kworker/7:1  pfn:4067b90
[   37.204299][  T656] page:000000000f7637a5 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4067b90
[   37.204300][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204300][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204301][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204301][  T656] page dumped because: nonzero mapcount
[   37.204302][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204313][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204314][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204315][  T656] Call Trace:
[   37.204315][  T656]  <TASK>
[ 37.204316][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204317][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204318][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204320][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204321][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204323][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204324][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204325][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204326][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204326][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204327][ T656] kthread (kernel/kthread.c:376) 
[ 37.204329][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204330][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204332][  T656]  </TASK>
[   37.204332][  T656] BUG: Bad page state in process kworker/7:1  pfn:4067b91
[   37.204333][  T656] page:00000000f0a96108 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4067b91
[   37.204333][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204334][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204335][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204335][  T656] page dumped because: nonzero mapcount
[   37.204335][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204347][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204348][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204349][  T656] Call Trace:
[   37.204349][  T656]  <TASK>
[ 37.204349][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204350][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204352][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204354][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204355][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204356][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204358][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204358][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204359][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204360][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204361][ T656] kthread (kernel/kthread.c:376) 
[ 37.204362][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204364][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204366][  T656]  </TASK>
[   37.204366][  T656] BUG: Bad page state in process kworker/7:1  pfn:4066c6f
[   37.204366][  T656] page:00000000a3271b36 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4066c6f
[   37.204367][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204368][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204368][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204369][  T656] page dumped because: nonzero mapcount
[   37.204369][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204380][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204381][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204382][  T656] Call Trace:
[   37.204383][  T656]  <TASK>
[ 37.204383][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204384][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204386][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204388][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204388][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204390][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204391][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204392][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204393][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204394][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204395][ T656] kthread (kernel/kthread.c:376) 
[ 37.204396][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204398][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204399][  T656]  </TASK>
[   37.204400][  T656] BUG: Bad page state in process kworker/7:1  pfn:4066c70
[   37.204400][  T656] page:00000000a3dee62d refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4066c70
[   37.204401][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204401][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204402][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204402][  T656] page dumped because: nonzero mapcount
[   37.204403][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204414][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204415][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204416][  T656] Call Trace:
[   37.204416][  T656]  <TASK>
[ 37.204417][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204418][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204419][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204421][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204422][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204424][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204425][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204426][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204427][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204428][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204428][ T656] kthread (kernel/kthread.c:376) 
[ 37.204430][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204431][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204433][  T656]  </TASK>
[   37.204433][  T656] BUG: Bad page state in process kworker/7:1  pfn:4066ea5
[   37.204434][  T656] page:00000000d98b257e refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4066ea5
[   37.204435][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204435][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204436][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204436][  T656] page dumped because: nonzero mapcount
[   37.204436][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204448][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204449][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204450][  T656] Call Trace:
[   37.204450][  T656]  <TASK>
[ 37.204450][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204452][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204453][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204455][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204456][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204458][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204459][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204460][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204460][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204461][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204462][ T656] kthread (kernel/kthread.c:376) 
[ 37.204463][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204465][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204467][  T656]  </TASK>
[   37.204467][  T656] BUG: Bad page state in process kworker/7:1  pfn:4067816
[   37.204467][  T656] page:00000000179212e7 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4067816
[   37.204468][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204469][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204469][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204470][  T656] page dumped because: nonzero mapcount
[   37.204470][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204483][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204483][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204484][  T656] Call Trace:
[   37.204485][  T656]  <TASK>
[ 37.204485][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204486][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204488][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204490][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204490][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204492][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204493][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204494][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204495][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204496][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204496][ T656] kthread (kernel/kthread.c:376) 
[ 37.204498][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204499][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204501][  T656]  </TASK>
[   37.204501][  T656] BUG: Bad page state in process kworker/7:1  pfn:4067817
[   37.204502][  T656] page:00000000a31b444e refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4067817
[   37.204502][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204503][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204504][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204504][  T656] page dumped because: nonzero mapcount
[   37.204504][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204516][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204516][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204518][  T656] Call Trace:
[   37.204518][  T656]  <TASK>
[ 37.204518][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204519][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204521][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204523][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204524][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204526][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204527][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204527][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204528][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204529][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204530][ T656] kthread (kernel/kthread.c:376) 
[ 37.204531][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204533][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204534][  T656]  </TASK>
[   37.204535][  T656] BUG: Bad page state in process kworker/7:1  pfn:4067818
[   37.204535][  T656] page:000000002d93def9 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4067818
[   37.204536][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204537][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204537][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204537][  T656] page dumped because: nonzero mapcount
[   37.204538][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204549][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204550][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204551][  T656] Call Trace:
[   37.204551][  T656]  <TASK>
[ 37.204551][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204553][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204554][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204556][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204557][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204559][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204560][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204561][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204562][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204562][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204563][ T656] kthread (kernel/kthread.c:376) 
[ 37.204565][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204566][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204568][  T656]  </TASK>
[   37.204568][  T656] BUG: Bad page state in process kworker/7:1  pfn:4067819
[   37.204569][  T656] page:0000000068f79cf8 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4067819
[   37.204569][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204570][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204570][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204571][  T656] page dumped because: nonzero mapcount
[   37.204571][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204582][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204583][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204584][  T656] Call Trace:
[   37.204584][  T656]  <TASK>
[ 37.204585][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204586][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204587][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204589][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204590][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204592][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204593][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204594][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204595][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204596][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204596][ T656] kthread (kernel/kthread.c:376) 
[ 37.204598][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204599][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204601][  T656]  </TASK>
[   37.204601][  T656] BUG: Bad page state in process kworker/7:1  pfn:4066d22
[   37.204602][  T656] page:0000000071a65f8d refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4066d22
[   37.204602][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204603][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204604][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204604][  T656] page dumped because: nonzero mapcount
[   37.204604][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204616][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204616][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204617][  T656] Call Trace:
[   37.204618][  T656]  <TASK>
[ 37.204618][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204619][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204621][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204623][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204624][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204625][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204626][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204627][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204628][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204629][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204630][ T656] kthread (kernel/kthread.c:376) 
[ 37.204631][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204633][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204634][  T656]  </TASK>
[   37.204635][  T656] BUG: Bad page state in process kworker/7:1  pfn:4066d23
[   37.204635][  T656] page:000000004b660373 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4066d23
[   37.204636][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204636][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204637][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204637][  T656] page dumped because: nonzero mapcount
[   37.204637][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204649][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204650][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204651][  T656] Call Trace:
[   37.204651][  T656]  <TASK>
[ 37.204651][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204652][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204654][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204656][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204656][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204658][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204659][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204660][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204661][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204662][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204663][ T656] kthread (kernel/kthread.c:376) 
[ 37.204664][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204666][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204667][  T656]  </TASK>
[   37.204668][  T656] BUG: Bad page state in process kworker/7:1  pfn:4066d60
[   37.204668][  T656] page:00000000dc0c1956 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4066d60
[   37.204669][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204669][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204670][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204670][  T656] page dumped because: nonzero mapcount
[   37.204670][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204682][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204683][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204684][  T656] Call Trace:
[   37.204684][  T656]  <TASK>
[ 37.204684][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204686][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204687][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204689][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204690][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204692][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204693][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204694][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204694][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204695][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204696][ T656] kthread (kernel/kthread.c:376) 
[ 37.204697][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204699][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204700][  T656]  </TASK>
[   37.204701][  T656] BUG: Bad page state in process kworker/7:1  pfn:4066d61
[   37.204701][  T656] page:0000000027a09b26 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4066d61
[   37.204702][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204702][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204703][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204703][  T656] page dumped because: nonzero mapcount
[   37.204703][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204715][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204715][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204716][  T656] Call Trace:
[   37.204717][  T656]  <TASK>
[ 37.204717][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204718][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204720][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204722][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204722][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204724][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204725][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204726][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204727][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204728][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204729][ T656] kthread (kernel/kthread.c:376) 
[ 37.204730][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204732][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204733][  T656]  </TASK>
[   37.204733][  T656] BUG: Bad page state in process kworker/7:1  pfn:4066d62
[   37.204734][  T656] page:00000000f8e8af41 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4066d62
[   37.204735][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204735][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204736][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204736][  T656] page dumped because: nonzero mapcount
[   37.204736][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204748][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204749][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204750][  T656] Call Trace:
[   37.204750][  T656]  <TASK>
[ 37.204750][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204751][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204753][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204755][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204755][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204757][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204758][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204759][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204760][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204761][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204762][ T656] kthread (kernel/kthread.c:376) 
[ 37.204763][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204765][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204766][  T656]  </TASK>
[   37.204767][  T656] BUG: Bad page state in process kworker/7:1  pfn:4066d63
[   37.204767][  T656] page:000000005ba5e17d refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4066d63
[   37.204768][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204768][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204769][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204769][  T656] page dumped because: nonzero mapcount
[   37.204769][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204781][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204781][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204783][  T656] Call Trace:
[   37.204783][  T656]  <TASK>
[ 37.204783][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204784][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204786][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204788][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204789][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204790][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204791][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204792][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204793][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204794][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204795][ T656] kthread (kernel/kthread.c:376) 
[ 37.204796][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204798][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204799][  T656]  </TASK>
[   37.204799][  T656] BUG: Bad page state in process kworker/7:1  pfn:4068f3d
[   37.204800][  T656] page:00000000bdd384ea refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4068f3d
[   37.204801][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204801][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204802][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204802][  T656] page dumped because: nonzero mapcount
[   37.204802][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204814][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204815][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204816][  T656] Call Trace:
[   37.204816][  T656]  <TASK>
[ 37.204816][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204818][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204819][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204821][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204822][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204823][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204824][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204825][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204826][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204827][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204828][ T656] kthread (kernel/kthread.c:376) 
[ 37.204829][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204831][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204832][  T656]  </TASK>
[   37.204832][  T656] BUG: Bad page state in process kworker/7:1  pfn:4068f3e
[   37.204833][  T656] page:00000000328356b4 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4068f3e
[   37.204834][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204834][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204835][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204835][  T656] page dumped because: nonzero mapcount
[   37.204835][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204847][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204847][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204848][  T656] Call Trace:
[   37.204849][  T656]  <TASK>
[ 37.204849][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204850][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204852][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204854][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204854][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204856][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204857][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204858][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204859][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204860][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204861][ T656] kthread (kernel/kthread.c:376) 
[ 37.204862][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204864][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204865][  T656]  </TASK>
[   37.204865][  T656] BUG: Bad page state in process kworker/7:1  pfn:4068f3f
[   37.204866][  T656] page:0000000069e8d9d5 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4068f3f
[   37.204866][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204867][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204868][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204868][  T656] page dumped because: nonzero mapcount
[   37.204868][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204880][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204880][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204881][  T656] Call Trace:
[   37.204881][  T656]  <TASK>
[ 37.204882][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204883][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204884][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204886][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204887][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204889][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204890][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204891][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204892][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204892][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204893][ T656] kthread (kernel/kthread.c:376) 
[ 37.204895][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204896][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204898][  T656]  </TASK>
[   37.204898][  T656] BUG: Bad page state in process kworker/7:1  pfn:4068f40
[   37.204898][  T656] page:00000000f3b2ebff refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4068f40
[   37.204899][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204900][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204900][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204901][  T656] page dumped because: nonzero mapcount
[   37.204901][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204912][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204913][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204914][  T656] Call Trace:
[   37.204914][  T656]  <TASK>
[ 37.204915][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204916][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204917][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204919][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204920][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204922][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204923][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204924][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204925][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204926][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204926][ T656] kthread (kernel/kthread.c:376) 
[ 37.204928][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204929][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204931][  T656]  </TASK>
[   37.204932][  T656] BUG: Bad page state in process kworker/7:1  pfn:4066f25
[   37.204932][  T656] page:0000000004321bf1 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4066f25
[   37.204933][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204933][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204934][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204934][  T656] page dumped because: nonzero mapcount
[   37.204934][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204946][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204947][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204948][  T656] Call Trace:
[   37.204948][  T656]  <TASK>
[ 37.204948][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204950][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204951][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204953][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204954][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204956][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204957][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204958][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204958][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204959][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204960][ T656] kthread (kernel/kthread.c:376) 
[ 37.204961][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204963][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204964][  T656]  </TASK>
[   37.204965][  T656] BUG: Bad page state in process kworker/7:1  pfn:4066f26
[   37.204965][  T656] page:0000000052468487 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4066f26
[   37.204966][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.204967][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.204967][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.204968][  T656] page dumped because: nonzero mapcount
[   37.204968][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.204979][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.204980][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.204981][  T656] Call Trace:
[   37.204981][  T656]  <TASK>
[ 37.204981][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.204983][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.204984][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.204986][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.204987][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.204989][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.204990][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.204991][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204991][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.204992][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.204993][ T656] kthread (kernel/kthread.c:376) 
[ 37.204994][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.204996][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.204998][  T656]  </TASK>
[   37.204998][  T656] BUG: Bad page state in process kworker/7:1  pfn:40665c2
[   37.204998][  T656] page:00000000a1e388c5 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x40665c2
[   37.204999][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205000][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205000][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205000][  T656] page dumped because: nonzero mapcount
[   37.205001][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205012][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205013][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205014][  T656] Call Trace:
[   37.205014][  T656]  <TASK>
[ 37.205014][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205016][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205017][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205019][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205020][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205022][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205023][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205024][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205024][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205025][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205026][ T656] kthread (kernel/kthread.c:376) 
[ 37.205028][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205029][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205031][  T656]  </TASK>
[   37.205031][  T656] BUG: Bad page state in process kworker/7:1  pfn:40665c3
[   37.205032][  T656] page:0000000091ff3772 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x40665c3
[   37.205033][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205033][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205034][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205034][  T656] page dumped because: nonzero mapcount
[   37.205034][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205046][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205047][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205048][  T656] Call Trace:
[   37.205048][  T656]  <TASK>
[ 37.205048][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205050][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205051][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205053][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205054][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205056][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205057][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205058][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205059][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205060][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205060][ T656] kthread (kernel/kthread.c:376) 
[ 37.205062][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205063][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205065][  T656]  </TASK>
[   37.205065][  T656] BUG: Bad page state in process kworker/7:1  pfn:40668d3
[   37.205066][  T656] page:000000005d17e497 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x40668d3
[   37.205066][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205067][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205068][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205068][  T656] page dumped because: nonzero mapcount
[   37.205068][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205082][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205083][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205084][  T656] Call Trace:
[   37.205085][  T656]  <TASK>
[ 37.205085][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205086][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205088][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205090][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205091][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205093][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205094][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205095][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205095][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205096][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205097][ T656] kthread (kernel/kthread.c:376) 
[ 37.205099][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205100][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205102][  T656]  </TASK>
[   37.205102][  T656] BUG: Bad page state in process kworker/7:1  pfn:40668d4
[   37.205102][  T656] page:00000000a3531add refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x40668d4
[   37.205103][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205104][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205105][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205105][  T656] page dumped because: nonzero mapcount
[   37.205105][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205120][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205120][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205121][  T656] Call Trace:
[   37.205122][  T656]  <TASK>
[ 37.205122][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205123][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205125][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205127][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205128][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205130][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205131][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205132][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205133][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205133][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205134][ T656] kthread (kernel/kthread.c:376) 
[ 37.205136][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205137][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205139][  T656]  </TASK>
[   37.205139][  T656] BUG: Bad page state in process kworker/7:1  pfn:40668d5
[   37.205140][  T656] page:000000005b09c362 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x40668d5
[   37.205141][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205142][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205142][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205143][  T656] page dumped because: nonzero mapcount
[   37.205143][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205157][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205157][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205158][  T656] Call Trace:
[   37.205159][  T656]  <TASK>
[ 37.205159][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205160][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205162][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205164][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205164][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205166][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205168][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205168][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205169][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205170][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205171][ T656] kthread (kernel/kthread.c:376) 
[ 37.205172][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205174][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205176][  T656]  </TASK>
[   37.205176][  T656] BUG: Bad page state in process kworker/7:1  pfn:40668d6
[   37.205176][  T656] page:00000000db68b558 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x40668d6
[   37.205177][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205178][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205178][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205179][  T656] page dumped because: nonzero mapcount
[   37.205179][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205193][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205194][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205195][  T656] Call Trace:
[   37.205195][  T656]  <TASK>
[ 37.205195][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205197][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205198][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205200][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205201][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205203][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205204][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205205][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205205][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205206][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205207][ T656] kthread (kernel/kthread.c:376) 
[ 37.205208][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205210][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205212][  T656]  </TASK>
[   37.205212][  T656] BUG: Bad page state in process kworker/7:1  pfn:406668a
[   37.205212][  T656] page:00000000dd01072c refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x406668a
[   37.205213][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205214][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205215][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205215][  T656] page dumped because: nonzero mapcount
[   37.205215][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205229][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205230][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205231][  T656] Call Trace:
[   37.205231][  T656]  <TASK>
[ 37.205232][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205233][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205234][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205236][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205237][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205239][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205240][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205241][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205242][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205242][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205243][ T656] kthread (kernel/kthread.c:376) 
[ 37.205245][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205246][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205248][  T656]  </TASK>
[   37.205248][  T656] BUG: Bad page state in process kworker/7:1  pfn:406668b
[   37.205248][  T656] page:00000000a5a9e359 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x406668b
[   37.205249][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205250][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205251][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205251][  T656] page dumped because: nonzero mapcount
[   37.205251][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205265][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205266][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205267][  T656] Call Trace:
[   37.205267][  T656]  <TASK>
[ 37.205268][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205269][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205270][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205272][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205273][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205275][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205276][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205277][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205278][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205279][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205279][ T656] kthread (kernel/kthread.c:376) 
[ 37.205281][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205282][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205284][  T656]  </TASK>
[   37.205284][  T656] BUG: Bad page state in process kworker/7:1  pfn:406625c
[   37.205285][  T656] page:0000000097f2120d refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x406625c
[   37.205285][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205286][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205287][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205287][  T656] page dumped because: nonzero mapcount
[   37.205287][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205301][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205302][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205303][  T656] Call Trace:
[   37.205303][  T656]  <TASK>
[ 37.205303][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205305][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205306][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205308][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205309][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205311][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205312][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205313][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205314][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205314][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205315][ T656] kthread (kernel/kthread.c:376) 
[ 37.205317][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205318][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205320][  T656]  </TASK>
[   37.205320][  T656] BUG: Bad page state in process kworker/7:1  pfn:406625d
[   37.205321][  T656] page:000000005f8c29f3 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x406625d
[   37.205321][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205322][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205323][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205323][  T656] page dumped because: nonzero mapcount
[   37.205323][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205337][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205338][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205339][  T656] Call Trace:
[   37.205339][  T656]  <TASK>
[ 37.205340][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205341][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205342][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205344][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205345][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205347][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205348][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205349][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205350][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205351][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205351][ T656] kthread (kernel/kthread.c:376) 
[ 37.205353][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205354][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205356][  T656]  </TASK>
[   37.205356][  T656] BUG: Bad page state in process kworker/7:1  pfn:406625e
[   37.205357][  T656] page:000000001a87cbf8 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x406625e
[   37.205357][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205358][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205359][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205359][  T656] page dumped because: nonzero mapcount
[   37.205359][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205373][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205374][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205375][  T656] Call Trace:
[   37.205375][  T656]  <TASK>
[ 37.205376][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205377][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205378][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205380][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205381][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205383][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205384][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205385][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205386][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205386][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205387][ T656] kthread (kernel/kthread.c:376) 
[ 37.205389][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205390][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205392][  T656]  </TASK>
[   37.205392][  T656] BUG: Bad page state in process kworker/7:1  pfn:406db5f
[   37.205393][  T656] page:000000006fbf1d82 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x406db5f
[   37.205393][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205394][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205395][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205395][  T656] page dumped because: nonzero mapcount
[   37.205395][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205409][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205410][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205411][  T656] Call Trace:
[   37.205411][  T656]  <TASK>
[ 37.205412][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205413][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205414][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205416][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205417][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205419][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205420][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205421][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205422][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205423][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205423][ T656] kthread (kernel/kthread.c:376) 
[ 37.205425][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205426][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205428][  T656]  </TASK>
[   37.205428][  T656] BUG: Bad page state in process kworker/7:1  pfn:406e140
[   37.205429][  T656] page:00000000536ba97f refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x406e140
[   37.205430][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205430][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205431][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205431][  T656] page dumped because: nonzero mapcount
[   37.205432][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205445][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205446][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205447][  T656] Call Trace:
[   37.205447][  T656]  <TASK>
[ 37.205448][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205449][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205450][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205452][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205453][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205455][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205456][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205457][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205458][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205459][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205459][ T656] kthread (kernel/kthread.c:376) 
[ 37.205461][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205463][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205464][  T656]  </TASK>
[   37.205465][  T656] BUG: Bad page state in process kworker/7:1  pfn:407178a
[   37.205465][  T656] page:000000000b508949 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x407178a
[   37.205466][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205466][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205467][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205467][  T656] page dumped because: nonzero mapcount
[   37.205468][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205482][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205482][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205483][  T656] Call Trace:
[   37.205484][  T656]  <TASK>
[ 37.205484][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205485][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205487][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205489][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205489][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205491][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205492][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205493][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205494][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205495][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205496][ T656] kthread (kernel/kthread.c:376) 
[ 37.205497][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205499][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205500][  T656]  </TASK>
[   37.205501][  T656] BUG: Bad page state in process kworker/7:1  pfn:4062005
[   37.205501][  T656] page:00000000d57e50d7 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4062005
[   37.205502][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205502][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205503][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205503][  T656] page dumped because: nonzero mapcount
[   37.205504][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205518][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205518][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205519][  T656] Call Trace:
[   37.205520][  T656]  <TASK>
[ 37.205520][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205521][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205523][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205525][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205525][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205527][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205528][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205529][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205530][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205531][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205532][ T656] kthread (kernel/kthread.c:376) 
[ 37.205533][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205535][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205536][  T656]  </TASK>
[   37.205537][  T656] BUG: Bad page state in process kworker/7:1  pfn:4062006
[   37.205537][  T656] page:0000000076539381 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4062006
[   37.205538][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205539][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205539][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205540][  T656] page dumped because: nonzero mapcount
[   37.205540][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205554][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205555][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205556][  T656] Call Trace:
[   37.205556][  T656]  <TASK>
[ 37.205556][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205558][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205559][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205561][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205562][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205564][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205565][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205566][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205566][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205567][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205568][ T656] kthread (kernel/kthread.c:376) 
[ 37.205569][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205571][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205573][  T656]  </TASK>
[   37.205573][  T656] BUG: Bad page state in process kworker/7:1  pfn:20a1364
[   37.205573][  T656] page:0000000081b529ac refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x20a1364
[   37.205574][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205575][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205575][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205576][  T656] page dumped because: nonzero mapcount
[   37.205576][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205590][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205591][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205592][  T656] Call Trace:
[   37.205592][  T656]  <TASK>
[ 37.205592][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205594][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205595][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205597][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205598][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205600][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205601][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205602][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205602][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205603][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205604][ T656] kthread (kernel/kthread.c:376) 
[ 37.205605][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205607][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205608][  T656]  </TASK>
[   37.205609][  T656] BUG: Bad page state in process kworker/7:1  pfn:20a1365
[   37.205609][  T656] page:000000008862f28e refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x20a1365
[   37.205610][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205611][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205611][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205612][  T656] page dumped because: nonzero mapcount
[   37.205612][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205626][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205627][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205628][  T656] Call Trace:
[   37.205628][  T656]  <TASK>
[ 37.205629][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205630][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205631][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205633][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205634][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205636][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205637][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205639][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205639][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205641][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205641][ T656] kthread (kernel/kthread.c:376) 
[ 37.205643][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205644][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205646][  T656]  </TASK>
[   37.205646][  T656] BUG: Bad page state in process kworker/7:1  pfn:406b86a
[   37.205647][  T656] page:00000000a2374aed refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x406b86a
[   37.205648][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205648][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205649][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205649][  T656] page dumped because: nonzero mapcount
[   37.205650][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205663][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205664][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205665][  T656] Call Trace:
[   37.205665][  T656]  <TASK>
[ 37.205666][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205667][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205668][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205670][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205671][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205673][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205674][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205675][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205676][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205677][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205678][ T656] kthread (kernel/kthread.c:376) 
[ 37.205679][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205681][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205682][  T656]  </TASK>
[   37.205682][  T656] BUG: Bad page state in process kworker/7:1  pfn:406b86b
[   37.205683][  T656] page:00000000afbb0a14 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x406b86b
[   37.205684][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205684][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205685][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205685][  T656] page dumped because: nonzero mapcount
[   37.205685][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205699][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205700][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205701][  T656] Call Trace:
[   37.205701][  T656]  <TASK>
[ 37.205702][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205703][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205704][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205706][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205707][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205709][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205710][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205711][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205712][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205713][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205713][ T656] kthread (kernel/kthread.c:376) 
[ 37.205715][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205716][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205718][  T656]  </TASK>
[   37.205718][  T656] BUG: Bad page state in process kworker/7:1  pfn:406cc31
[   37.205719][  T656] page:000000007e710142 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x406cc31
[   37.205720][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205720][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205721][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205721][  T656] page dumped because: nonzero mapcount
[   37.205722][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205735][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205736][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205737][  T656] Call Trace:
[   37.205738][  T656]  <TASK>
[ 37.205738][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205739][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205741][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205743][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205743][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205745][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205746][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205747][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205748][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205749][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205750][ T656] kthread (kernel/kthread.c:376) 
[ 37.205751][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205753][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205754][  T656]  </TASK>
[   37.205755][  T656] BUG: Bad page state in process kworker/7:1  pfn:40642e4
[   37.205755][  T656] page:00000000b55044d4 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x40642e4
[   37.205756][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205757][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205757][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205758][  T656] page dumped because: nonzero mapcount
[   37.205758][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205772][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205772][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205773][  T656] Call Trace:
[   37.205774][  T656]  <TASK>
[ 37.205774][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205775][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205777][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205779][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205780][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205782][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205783][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205783][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205784][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205785][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205786][ T656] kthread (kernel/kthread.c:376) 
[ 37.205787][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205789][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205790][  T656]  </TASK>
[   37.205791][  T656] BUG: Bad page state in process kworker/7:1  pfn:4075302
[   37.205791][  T656] page:00000000c471370c refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4075302
[   37.205792][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205793][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205793][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205794][  T656] page dumped because: nonzero mapcount
[   37.205794][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205808][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205809][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205810][  T656] Call Trace:
[   37.205810][  T656]  <TASK>
[ 37.205810][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205812][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205813][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205815][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205816][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205818][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205819][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205820][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205820][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205821][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205822][ T656] kthread (kernel/kthread.c:376) 
[ 37.205823][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205825][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205827][  T656]  </TASK>
[   37.205827][  T656] BUG: Bad page state in process kworker/7:1  pfn:4075303
[   37.205827][  T656] page:000000000847b9ba refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4075303
[   37.205828][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205829][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205829][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205830][  T656] page dumped because: nonzero mapcount
[   37.205830][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205844][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205845][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205846][  T656] Call Trace:
[   37.205846][  T656]  <TASK>
[ 37.205846][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205848][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205849][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205851][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205852][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205854][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205855][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205856][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205856][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205857][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205858][ T656] kthread (kernel/kthread.c:376) 
[ 37.205860][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205861][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205863][  T656]  </TASK>
[   37.205863][  T656] BUG: Bad page state in process kworker/7:1  pfn:4062da8
[   37.205863][  T656] page:000000005c056007 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4062da8
[   37.205864][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205865][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205865][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205866][  T656] page dumped because: nonzero mapcount
[   37.205866][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205880][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205881][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205882][  T656] Call Trace:
[   37.205882][  T656]  <TASK>
[ 37.205882][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205884][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205885][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205887][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205888][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205890][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205891][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205892][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205893][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205893][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205894][ T656] kthread (kernel/kthread.c:376) 
[ 37.205896][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205897][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205899][  T656]  </TASK>
[   37.205899][  T656] BUG: Bad page state in process kworker/7:1  pfn:4062da9
[   37.205899][  T656] page:000000000847cd63 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4062da9
[   37.205900][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205901][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205901][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205902][  T656] page dumped because: nonzero mapcount
[   37.205902][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205916][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205917][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205918][  T656] Call Trace:
[   37.205918][  T656]  <TASK>
[ 37.205918][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205920][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205921][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205923][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205924][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205926][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205927][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205928][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205929][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205929][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205930][ T656] kthread (kernel/kthread.c:376) 
[ 37.205932][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205933][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205935][  T656]  </TASK>
[   37.205935][  T656] BUG: Bad page state in process kworker/7:1  pfn:406e9aa
[   37.205935][  T656] page:000000003d3375b9 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x406e9aa
[   37.205936][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205937][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205938][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205938][  T656] page dumped because: nonzero mapcount
[   37.205938][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205952][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205953][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205954][  T656] Call Trace:
[   37.205954][  T656]  <TASK>
[ 37.205954][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205956][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205957][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205959][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205960][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205962][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205963][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.205964][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205964][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.205965][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.205966][ T656] kthread (kernel/kthread.c:376) 
[ 37.205967][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.205969][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.205971][  T656]  </TASK>
[   37.205971][  T656] BUG: Bad page state in process kworker/7:1  pfn:406e9ab
[   37.205971][  T656] page:00000000a64d972c refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x406e9ab
[   37.205972][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.205973][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.205973][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.205974][  T656] page dumped because: nonzero mapcount
[   37.205974][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.205988][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.205989][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.205990][  T656] Call Trace:
[   37.205990][  T656]  <TASK>
[ 37.205990][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.205992][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.205993][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.205995][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.205996][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.205998][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.205999][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.206000][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.206000][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.206001][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.206002][ T656] kthread (kernel/kthread.c:376) 
[ 37.206004][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.206005][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.206007][  T656]  </TASK>
[   37.206007][  T656] BUG: Bad page state in process kworker/7:1  pfn:407c524
[   37.206008][  T656] page:000000003cff402d refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x407c524
[   37.206008][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.206009][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.206010][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.206010][  T656] page dumped because: nonzero mapcount
[   37.206010][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.206024][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.206025][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.206026][  T656] Call Trace:
[   37.206026][  T656]  <TASK>
[ 37.206027][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.206028][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.206029][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.206031][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.206032][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.206034][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.206035][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.206036][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.206037][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.206038][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.206039][ T656] kthread (kernel/kthread.c:376) 
[ 37.206040][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.206042][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.206043][  T656]  </TASK>
[   37.206044][  T656] BUG: Bad page state in process kworker/7:1  pfn:407c525
[   37.206044][  T656] page:000000001a73627b refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x407c525
[   37.206045][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.206046][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.206046][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.206047][  T656] page dumped because: nonzero mapcount
[   37.206047][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.206061][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.206062][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.206063][  T656] Call Trace:
[   37.206063][  T656]  <TASK>
[ 37.206064][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.206065][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.206067][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.206069][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.206069][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.206071][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.206073][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.206073][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.206074][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.206075][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.206076][ T656] kthread (kernel/kthread.c:376) 
[ 37.206077][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.206079][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.206081][  T656]  </TASK>
[   37.206081][  T656] BUG: Bad page state in process kworker/7:1  pfn:4062212
[   37.206081][  T656] page:00000000840d3847 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4062212
[   37.206082][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.206083][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.206084][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.206084][  T656] page dumped because: nonzero mapcount
[   37.206084][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.206099][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.206099][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.206100][  T656] Call Trace:
[   37.206101][  T656]  <TASK>
[ 37.206101][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.206103][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.206104][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.206106][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.206107][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.206109][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.206110][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.206111][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.206112][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.206113][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.206113][ T656] kthread (kernel/kthread.c:376) 
[ 37.206115][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.206116][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.206118][  T656]  </TASK>
[   37.206118][  T656] BUG: Bad page state in process kworker/7:1  pfn:4043655
[   37.206119][  T656] page:00000000bd17f9db refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4043655
[   37.206120][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.206121][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.206121][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.206122][  T656] page dumped because: nonzero mapcount
[   37.206122][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.206136][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.206137][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.206138][  T656] Call Trace:
[   37.206138][  T656]  <TASK>
[ 37.206139][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.206140][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.206141][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.206143][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.206144][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.206146][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.206147][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.206148][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.206149][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.206150][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.206150][ T656] kthread (kernel/kthread.c:376) 
[ 37.206152][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.206154][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.206155][  T656]  </TASK>
[   37.206156][  T656] BUG: Bad page state in process kworker/7:1  pfn:4043656
[   37.206156][  T656] page:0000000026e2b5d1 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4043656
[   37.206157][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.206158][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.206158][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.206159][  T656] page dumped because: nonzero mapcount
[   37.206159][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.206173][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.206174][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.206175][  T656] Call Trace:
[   37.206175][  T656]  <TASK>
[ 37.206175][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.206177][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.206178][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.206180][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.206181][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.206183][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.206184][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.206185][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.206185][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.206186][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.206187][ T656] kthread (kernel/kthread.c:376) 
[ 37.206189][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.206190][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.206192][  T656]  </TASK>
[   37.206192][  T656] BUG: Bad page state in process kworker/7:1  pfn:40652da
[   37.206192][  T656] page:00000000d1922e4b refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x40652da
[   37.206193][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.206194][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.206194][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.206195][  T656] page dumped because: nonzero mapcount
[   37.206195][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.206209][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.206210][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.206211][  T656] Call Trace:
[   37.206211][  T656]  <TASK>
[ 37.206211][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.206213][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.206214][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.206216][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.206217][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.206219][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.206220][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.206221][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.206221][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.206222][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.206223][ T656] kthread (kernel/kthread.c:376) 
[ 37.206224][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.206226][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.206228][  T656]  </TASK>
[   37.206228][  T656] BUG: Bad page state in process kworker/7:1  pfn:4071d34
[   37.206228][  T656] page:000000008e672cb2 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x4071d34
[   37.206229][  T656] flags: 0x57ffffc0000000(node=1|zone=2|lastcpupid=0x1fffff)
[   37.206230][  T656] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[   37.206230][  T656] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
[   37.206231][  T656] page dumped because: nonzero mapcount
[   37.206231][  T656] Modules linked in: acpi_cpufreq(-) device_dax(+) nd_pmem nd_btt dax_pmem intel_rapl_msr intel_rapl_common btrfs ipmi_ssif x86_pkg_temp_thermal blake2b_generic intel_powerclamp xor raid6_pq coretemp zstd_compress libcrc32c nvme sd_mod ast drm_vram_helper sg drm_ttm_helper nvme_core kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel t10_pi ghash_clmulni_intel ttm rapl drm_kms_helper crc64_rocksoft_generic ahci intel_cstate syscopyarea crc64_rocksoft libahci intel_uncore crc64 sysfillrect ioatdma sysimgblt joydev fb_sys_fops libata dca wmi acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit libnvdimm acpi_pad acpi_power_meter drm fuse ip_tables
[   37.206245][  T656] CPU: 7 PID: 656 Comm: kworker/7:1 Tainted: G S  B             5.19.0-rc2-00013-g0bf5cdf08f32 #1
[   37.206246][  T656] Workqueue: mm_percpu_wq vmstat_update
[   37.206247][  T656] Call Trace:
[   37.206247][  T656]  <TASK>
[ 37.206247][ T656] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 37.206249][ T656] bad_page.cold (mm/page_alloc.c:642) 
[ 37.206250][ T656] free_pcppages_bulk (mm/page_alloc.c:1526) 
[ 37.206252][ T656] drain_zone_pages (arch/x86/include/asm/irqflags.h:137 mm/page_alloc.c:3108) 
[ 37.206253][ T656] refresh_cpu_vm_stats (mm/vmstat.c:876) 
[ 37.206255][ T656] vmstat_update (mm/vmstat.c:1939) 
[ 37.206256][ T656] process_one_work (kernel/workqueue.c:2289) 
[ 37.206257][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.206257][ T656] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 37.206258][ T656] ? process_one_work (kernel/workqueue.c:2379) 
[ 37.206259][ T656] kthread (kernel/kthread.c:376) 
[ 37.206260][ T656] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 37.206262][ T656] ret_from_fork (arch/x86/entry/entry_64.S:302) 
[   37.206264][  T656]  </TASK>
[   37.907325][ T1223] LKP: stdout: 1210: HOSTNAME lkp-icl-2sp1, MAC a4:bf:01:73:ed:da, kernel 5.19.0-rc2-00013-g0bf5cdf08f32 1
[   37.907328][ T1223]
[   38.081784][ T1223] install debs round one: dpkg -i --force-confdef --force-depends /opt/deb/ntpdate_1%3a4.2.8p15+dfsg-1_amd64.deb
[   38.081786][ T1223]
[   38.082481][ T1223] /opt/deb/libssl1.1_1.1.1n-0+deb11u3_amd64.deb
[   38.082482][ T1223]
[   38.082988][ T1223] /opt/deb/libdeflate0_1.7-1_amd64.deb
[   38.082990][ T1223]
[   38.083788][ T1223] /opt/deb/gtk-update-icon-cache_3.24.24-4+deb11u2_amd64.deb
[   38.083789][ T1223]
[   38.084371][ T1223] /opt/deb/libasound2-data_1.2.4-1.1_all.deb
[   38.084372][ T1223]
[   38.084997][ T1223] /opt/deb/ca-certificates-java_20190909_all.deb
[   38.084998][ T1223]
[   38.085523][ T1223] /opt/deb/libatomic1_10.2.1-6_amd64.deb
[   38.085524][ T1223]
[   38.086059][ T1223] /opt/deb/libquadmath0_10.2.1-6_amd64.deb
[   38.086060][ T1223]
[   38.086610][ T1223] /opt/deb/libgcc-10-dev_10.2.1-6_amd64.deb
[   38.086612][ T1223]
[   38.087146][ T1223] /opt/deb/lib32gcc-s1_10.2.1-6_amd64.deb
[   38.087147][ T1223]
[   38.087612][ T1223] /opt/deb/gcc-10_10.2.1-6_amd64.deb
[   38.087613][ T1223]
[   38.088096][ T1223] /opt/deb/gcc_4%3a10.2.1-1_amd64.deb
[   38.088097][ T1223]
[   38.088551][ T1223] /opt/deb/g++-10_10.2.1-6_amd64.deb
[   38.088552][ T1223]
[   38.089007][ T1223] /opt/deb/g++_4%3a10.2.1-1_amd64.deb
[   38.089007][ T1223]
[   38.089561][ T1223] /opt/deb/libatk1.0-data_2.36.0-2_all.deb
[   38.089562][ T1223]
[   38.090077][ T1223] /opt/deb/libatk1.0-0_2.36.0-2_amd64.deb
[   38.090078][ T1223]
[   38.090636][ T1223] /opt/deb/gir1.2-atk-1.0_2.36.0-2_amd64.deb
[   38.090637][ T1223]
[   38.091143][ T1223] /opt/deb/libthai-data_0.1.28-3_all.deb
[   38.091145][ T1223]
[   38.091639][ T1223] /opt/deb/libdatrie1_0.2.13-1_amd64.deb
[   38.091640][ T1223]
[   38.092143][ T1223] /opt/deb/libdpkg-perl_1.20.11_all.deb
[   38.092145][ T1223]
[   38.092696][ T1223] /opt/deb/libglib2.0-data_2.66.8-1_all.deb
[   38.092697][ T1223]
[   38.093257][ T1223] /opt/deb/python3-lib2to3_3.9.2-1_all.deb
[   38.093259][ T1223]
[   38.093827][ T1223] /opt/deb/python3-distutils_3.9.2-1_all.deb
[   38.093828][ T1223]
[   38.094391][ T1223] /opt/deb/libatk1.0-dev_2.36.0-2_amd64.deb
[   38.094392][ T1223]
[   38.095040][ T1223] /opt/deb/libexpat1-dev_2.2.10-2+deb11u3_amd64.deb
[   38.095041][ T1223]
[   38.095591][ T1223] /opt/deb/libdatrie-dev_0.2.13-1_amd64.deb
[   38.095592][ T1223]
[   38.096232][ T1223] /opt/deb/libperl-dev_5.32.1-4+deb11u2_amd64.deb
[   38.096234][ T1223]
[   38.096800][ T1223] /opt/deb/libpython3.9-dev_3.9.2-1_amd64.deb
[   38.096801][ T1223]
[   38.097359][ T1223] /opt/deb/libpython3-dev_3.9.2-3_amd64.deb
[   38.097360][ T1223]
[   38.097986][ T1223] /opt/deb/python3-pkg-resources_52.0.0-4_all.deb
[   38.097987][ T1223]
[   38.098658][ T1223] /opt/deb/python3-pygments_2.7.1+dfsg-2.1_all.deb
[   38.098660][ T1223]
[   38.099190][ T1223] /opt/deb/python3-yaml_5.3.1-5_amd64.deb
[   38.099191][ T1223]
[   38.099612][ T1223] /opt/deb/patch_2.7.6-7_amd64.deb
[   38.099612][ T1223]
[   38.100154][ T1223] /opt/deb/python3.9-dev_3.9.2-1_amd64.deb
[   38.100155][ T1223]
[   38.100657][ T1223] /opt/deb/python3-dev_3.9.2-3_amd64.deb
[   38.100658][ T1223]
[   38.101127][ T1223] /opt/deb/sysstat_12.5.2-2_amd64.deb
[   38.101128][ T1223]
[   38.101692][ T1223] /opt/deb/python3-dnspython_2.0.0-1_all.deb
[   38.101694][ T1223]


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://01.org/lkp



--hiuBKARmG6iOHIRg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="config-5.19.0-rc2-00013-g0bf5cdf08f32"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.19.0-rc2 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-3) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
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
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

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
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
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

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
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
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
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
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
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
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_CC_HAS_SLS=y
# CONFIG_SLS is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_INTEL_TDX_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_PRMT=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
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

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
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
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
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
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_VM_GET_PAGE_PROT=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER=y
CONFIG_PTE_MARKER_UFFD_WP=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
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
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
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
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
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
CONFIG_ATA_PIIX=m
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
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
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
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
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
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
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
# CONFIG_MSE102X is not set
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
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
# CONFIG_IWLMEI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set

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
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

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
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

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
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_WMI_EC is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SIMPLE_MFD_I2C is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
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
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

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
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_IRQ_REMAP=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

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
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

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
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
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
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
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
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACK_HASH_ORDER=20
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

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
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_OBJTOOL=y
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
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
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
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
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
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--hiuBKARmG6iOHIRg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='stress-ng'
	export testcase='stress-ng'
	export category='benchmark'
	export nr_threads=9
	export testtime=60
	export job_origin='stress-ng-class-filesystem.yaml'
	export queue_cmdline_keys=
	export queue='vip'
	export testbox='lkp-icl-2sp1'
	export tbox_group='lkp-icl-2sp1'
	export submit_id='62cadbec0b9a932810c0bfd5'
	export job_file='/lkp/jobs/scheduled/lkp-icl-2sp1/stress-ng-filesystem-performance-1HDD-xfs-10%-dnotify-60s-ucode=0xb000280-debian-11.1-x86_64-20220510.cgz-0bf5cdf08f32bbb2d5dbc7-20220710-75792-10yf8kh-8.yaml'
	export id='e4508b07465d28aae38ea61065f6b2329a0749e5'
	export queuer_version='/lkp/xsang/.src-20220709-214637'
	export kconfig='x86_64-rhel-8.3'
	export model='Ice Lake'
	export nr_node=2
	export nr_cpu=96
	export memory='256G'
	export nr_hdd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-ST9500530NS_9SP1KLAR-part1'
	export ssd_partitions='/dev/nvme0n1p1'
	export swap_partitions=
	export kernel_cmdline_hw='acpi_rsdp=0x667fd014'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204005K800RGN-part3'
	export need_kconfig='BLK_DEV_SD
SCSI
{"BLOCK"=>"y"}
SATA_AHCI
SATA_AHCI_PLATFORM
ATA
{"PCI"=>"y"}
XFS_FS'
	export commit='0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257'
	export ucode='0xb000280'
	export need_kconfig_hw='{"IGB"=>"y"}
{"IXGBE"=>"y"}
SATA_AHCI'
	export bisect_dmesg=true
	export enqueue_time='2022-07-10 22:02:21 +0800'
	export _id='62cadbed0b9a932810c0bfdd'
	export _rt='/result/stress-ng/filesystem-performance-1HDD-xfs-10%-dnotify-60s-ucode=0xb000280/lkp-icl-2sp1/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='a3333012d60e2c65e3f7e62eabc3b097ae7b7796'
	export base_commit='88084a3df1672e131ddc1b4e39eeacfd39864acf'
	export branch='linux-review/Baolin-Wang/Add-PUD-and-kernel-PTE-level-pagetable-account/20220622-170051'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export result_root='/result/stress-ng/filesystem-performance-1HDD-xfs-10%-dnotify-60s-ucode=0xb000280/lkp-icl-2sp1/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257/19'
	export scheduler_version='/lkp/lkp/.src-20220708-234704'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/stress-ng/filesystem-performance-1HDD-xfs-10%-dnotify-60s-ucode=0xb000280/lkp-icl-2sp1/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257/19
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257/vmlinuz-5.19.0-rc2-00013-g0bf5cdf08f32
branch=linux-review/Baolin-Wang/Add-PUD-and-kernel-PTE-level-pagetable-account/20220622-170051
job=/lkp/jobs/scheduled/lkp-icl-2sp1/stress-ng-filesystem-performance-1HDD-xfs-10%-dnotify-60s-ucode=0xb000280-debian-11.1-x86_64-20220510.cgz-0bf5cdf08f32bbb2d5dbc7-20220710-75792-10yf8kh-8.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3
commit=0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257
acpi_rsdp=0x667fd014
max_uptime=2100
LKP_SERVER=internal-lkp-server
nokaslr
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-11/0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/stress-ng_20220709.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/stress-ng-x86_64-0.11-06_20220709.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/mpstat_20220516.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/turbostat_20220514.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/turbostat-x86_64-210e04ff7681-1_20220518.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/perf_20220709.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/perf-x86_64-b1c428b6c368-1_20220709.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/sar-x86_64-c5bb321-1_20220518.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220216.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.17.0'
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-11/0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257/vmlinuz-5.19.0-rc2-00013-g0bf5cdf08f32'
	export dequeue_time='2022-07-11 01:10:53 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-icl-2sp1/stress-ng-filesystem-performance-1HDD-xfs-10%-dnotify-60s-ucode=0xb000280-debian-11.1-x86_64-20220510.cgz-0bf5cdf08f32bbb2d5dbc7-20220710-75792-10yf8kh-8.cgz'

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

	run_setup nr_hdd=1 $LKP_SRC/setup/disk

	run_setup fs='xfs' $LKP_SRC/setup/fs

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor lite_mode=1 $LKP_SRC/monitors/wrapper perf-sched
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor debug_mode=0 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor pmeter_server='lkp-nhm-dp2' pmeter_device='yokogawa-wt310' $LKP_SRC/monitors/wrapper pmeter
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test class='filesystem' test='dnotify' $LKP_SRC/tests/wrapper stress-ng
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env class='filesystem' test='dnotify' $LKP_SRC/stats/wrapper stress-ng
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	env lite_mode=1 $LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	env debug_mode=0 $LKP_SRC/stats/wrapper perf-profile
	env pmeter_server='lkp-nhm-dp2' pmeter_device='yokogawa-wt310' $LKP_SRC/stats/wrapper pmeter

	$LKP_SRC/stats/wrapper time stress-ng.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--hiuBKARmG6iOHIRg
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
phVxwK3OscRn+wIAAAAABFla

--hiuBKARmG6iOHIRg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=stress-ng

2022-07-10 17:12:22 mkdir -p /mnt/stress-ng
2022-07-10 17:12:22 mount /dev/sda1 /mnt/stress-ng
2022-07-10 17:12:24 stress-ng --timeout 60 --times --verify --metrics-brief --dnotify 9
stress-ng: info:  [5403] setting to a 60 second run per stressor
stress-ng: info:  [5403] dispatching hogs: 9 dnotify
stress-ng: info:  [5403] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
stress-ng: info:  [5403]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
stress-ng: info:  [5403] dnotify         1236071     60.00      6.00      6.00     20600.55      417591.55
stress-ng: info:  [5403] for a 60.00s run time:
stress-ng: info:  [5403]    5760.28s available CPU time
stress-ng: info:  [5403]       9.82s user time   (  0.17%)
stress-ng: info:  [5403]     292.84s system time (  5.08%)
stress-ng: info:  [5403]     302.66s total time  (  5.25%)
stress-ng: info:  [5403] load average: 9.93 3.02 1.06
stress-ng: info:  [5403] successful run completed in 60.00s (1 min, 0.00 secs)

--hiuBKARmG6iOHIRg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/stress-ng-class-filesystem.yaml:
suite: stress-ng
testcase: stress-ng
category: benchmark
nr_threads: 10%
disk: 1HDD
testtime: 60s
fs: xfs
stress-ng:
  class: filesystem
  test: dnotify
job_origin: stress-ng-class-filesystem.yaml
:#! queue options:
queue_cmdline_keys: []
queue: vip
testbox: lkp-icl-2sp1
tbox_group: lkp-icl-2sp1
submit_id: 62cadbec0b9a932810c0bfd5
job_file: "/lkp/jobs/scheduled/lkp-icl-2sp1/stress-ng-filesystem-performance-1HDD-xfs-10%-dnotify-60s-ucode=0xb000280-debian-11.1-x86_64-20220510.cgz-0bf5cdf08f32bbb2d5dbc7-20220710-75792-10yf8kh-16.yaml"
id: a7ca01bd1d6c18b8ddaa25a23c379f43df03beaf
queuer_version: "/lkp/xsang/.src-20220709-214637"
kconfig: x86_64-rhel-8.3
:#! hosts/lkp-icl-2sp1:
model: Ice Lake
nr_node: 2
nr_cpu: 96
memory: 256G
nr_hdd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-ST9500530NS_9SP1KLAR-part1"
ssd_partitions: "/dev/nvme0n1p1"
swap_partitions:
kernel_cmdline_hw: acpi_rsdp=0x667fd014
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204005K800RGN-part3"
:#! include/category/benchmark:
kmsg:
boot-time:
uptime:
iostat:
heartbeat:
vmstat:
numa-numastat:
numa-vmstat:
numa-meminfo:
proc-vmstat:
proc-stat:
meminfo:
slabinfo:
interrupts:
lock_stat:
perf-sched:
  lite_mode: 1
softirqs:
bdi_dev_mapping:
diskstats:
nfsstat:
cpuidle:
cpufreq-stats:
turbostat:
sched_debug:
perf-stat:
mpstat:
perf-profile:
  debug_mode: 0
:#! include/category/ALL:
cpufreq_governor: performance
:#! include/disk/nr_hdd:
need_kconfig:
- BLK_DEV_SD
- SCSI
- BLOCK: y
- SATA_AHCI
- SATA_AHCI_PLATFORM
- ATA
- PCI: y
- XFS_FS
:#! include/stress-ng:
:#! include/queue/cyclic:
commit: 0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257
:#! include/testbox/lkp-icl-2sp1:
ucode: '0xb000280'
need_kconfig_hw:
- IGB: y
- IXGBE: y
- SATA_AHCI
pmeter:
  pmeter_server: lkp-nhm-dp2
  pmeter_device: yokogawa-wt310
bisect_dmesg: true
:#! include/fs/OTHERS:
enqueue_time: 2022-07-10 22:02:21.002926562 +08:00
_id: 62cadbed0b9a932810c0bfe5
_rt: "/result/stress-ng/filesystem-performance-1HDD-xfs-10%-dnotify-60s-ucode=0xb000280/lkp-icl-2sp1/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257"
:#! schedule options:
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: a3333012d60e2c65e3f7e62eabc3b097ae7b7796
base_commit: 88084a3df1672e131ddc1b4e39eeacfd39864acf
branch: linux-review/Baolin-Wang/Add-PUD-and-kernel-PTE-level-pagetable-account/20220622-170051
rootfs: debian-11.1-x86_64-20220510.cgz
result_root: "/result/stress-ng/filesystem-performance-1HDD-xfs-10%-dnotify-60s-ucode=0xb000280/lkp-icl-2sp1/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257/0"
scheduler_version: "/lkp/lkp/.src-20220708-234704"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/stress-ng/filesystem-performance-1HDD-xfs-10%-dnotify-60s-ucode=0xb000280/lkp-icl-2sp1/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257/vmlinuz-5.19.0-rc2-00013-g0bf5cdf08f32
- branch=linux-review/Baolin-Wang/Add-PUD-and-kernel-PTE-level-pagetable-account/20220622-170051
- job=/lkp/jobs/scheduled/lkp-icl-2sp1/stress-ng-filesystem-performance-1HDD-xfs-10%-dnotify-60s-ucode=0xb000280-debian-11.1-x86_64-20220510.cgz-0bf5cdf08f32bbb2d5dbc7-20220710-75792-10yf8kh-16.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- commit=0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257
- acpi_rsdp=0x667fd014
- max_uptime=2100
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-11/0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257/modules.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/stress-ng_20220709.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/stress-ng-x86_64-0.11-06_20220709.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/mpstat_20220516.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/turbostat_20220514.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/turbostat-x86_64-210e04ff7681-1_20220518.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/perf_20220709.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/perf-x86_64-b1c428b6c368-1_20220709.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/sar-x86_64-c5bb321-1_20220518.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220216.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /cephfs/db/releases/20220708234348/lkp-src/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.19.0-rc2-00012-gf64284dadd01
schedule_notify_address:
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-11/0bf5cdf08f32bbb2d5dbc794fe609e1d97ca5257/vmlinuz-5.19.0-rc2-00013-g0bf5cdf08f32"
dequeue_time: 2022-07-10 23:06:58.017808675 +08:00
job_state: finished
loadavg: 8.55 2.91 1.04 1/996 8264
start_time: '1657465703'
end_time: '1657465765'
version: "/lkp/lkp/.src-20220708-234740:d013857b6:a8c488bdc"

--hiuBKARmG6iOHIRg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

dmsetup remove_all
wipefs -a --force /dev/sda1
mkfs -t xfs -f -mreflink=0 /dev/sda1
mkdir -p /fs/sda1
modprobe xfs
mount -t xfs -o inode64 /dev/sda1 /fs/sda1

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "mkdir" "-p" "/mnt/stress-ng"
 "mount" "/dev/sda1" "/mnt/stress-ng"
 "stress-ng" "--timeout" "60" "--times" "--verify" "--metrics-brief" "--dnotify" "9"

--hiuBKARmG6iOHIRg--
