Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0093449E331
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241631AbiA0NSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:18:32 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4525 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiA0NSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:18:31 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jl1Nr253cz686Hf;
        Thu, 27 Jan 2022 21:18:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 27 Jan 2022 14:18:28 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 13:18:26 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>,
        <Ajish.Koshy@microchip.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Viswas.G@microchip.com>, <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/3] scsi: pm8001: Documentation and use-after-free fixes
Date:   Thu, 27 Jan 2022 21:12:49 +0800
Message-ID: <1643289172-165636-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few fixes:
- Remedy make W=1 warning for undescribed param
- 2x use-after-free fixes for these KASAN warnings:

TMF timeout:
389.780822] ==================================================================
[  389.780828] BUG: KASAN: use-after-free in mpi_ssp_completion+0xb8/0xd20
[  389.780845] Read of size 8 at addr ffff0020ccb50268 by task swapper/6/0
[  389.780851]
[  389.780854] CPU: 6 PID: 0 Comm: swapper/6 Not tainted 5.17.0-rc1-11819-gb4fa2357aff7 #1077
[  389.780862] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC0 - V1.16.01 03/15/2019 
[  389.780867] Call trace:
[  389.780870]  dump_backtrace.part.0+0x1d4/0x1e0
[  389.780880]  show_stack+0x1c/0x6c 
[  389.780888]  dump_stack_lvl+0x68/0x84 
[  389.780897]  print_address_description.constprop.0+0x74/0x2d8 
[  389.780905]  kasan_report+0x1e4/0x250 
[  389.780913]  __asan_load8+0x98/0xd4
[  389.780920]  mpi_ssp_completion+0xb8/0xd20
[  389.780927]  process_oq+0x7ec/0x3fec   
[  389.780935]  pm80xx_chip_isr+0x74/0xe0
[  389.780942]  pm8001_tasklet+0x64/0x80 
[  389.780948]  tasklet_action_common.constprop.0+0x1c4/0x1d0
[  389.780957]  tasklet_action+0x2c/0x40 
[  389.780964]  __do_softirq+0x1b0/0x3f8 
[  389.780969]  __irq_exit_rcu+0x160/0x180
[  389.780976]  irq_exit_rcu+0x14/0x20
[  389.780983]  el1_interrupt+0x38/0x80   
[  389.780992]  el1h_64_irq_handler+0x1c/0x2c
[  389.780998]  el1h_64_irq+0x78/0x7c
[  389.781004]  arch_local_irq_enable+0xc/0x20
[  389.781012]  default_idle_call+0x30/0x6c   
[  389.781020]  do_idle+0x2ec/0x370   
[  389.781027]  cpu_startup_entry+0x2c/0x80   
[  389.781034]  secondary_start_kernel+0x240/0x28c
[  389.781041]  __secondary_switched+0x94/0x98
[  389.781051]
[  389.781053] Allocated by task 629:
[  389.781057]  kasan_save_stack+0x30/0x60
[  389.781065]  __kasan_slab_alloc+0x70/0x94 
[  389.781071]  kmem_cache_alloc+0x16c/0x2fc 
[  389.781078]  sas_alloc_slow_task+0x38/0x250
[  389.781086]  pm8001_exec_internal_tmf_task.constprop.0+0xf0/0x430 
[  389.781093]  pm8001_abort_task+0x59c/0x810
[  389.781100]  sas_scsi_recover_host+0xafc/0x1090
[  389.781108]  scsi_error_handler+0x138/0x5f0
[  389.781114]  kthread+0x18c/0x194   
[  389.781123]  ret_from_fork+0x10/0x20   
[  389.781129]
[  389.781131] Freed by task 629:
[  389.781134]  kasan_save_stack+0x30/0x60
[  389.781141]  kasan_set_track+0x30/0x44
[  389.781147]  kasan_set_free_info+0x2c/0x50
[  389.781155]  __kasan_slab_free+0xf0/0x140 
[  389.781161]  slab_free_freelist_hook+0x70/0x1f0
[  389.781167]  kmem_cache_free+0xb4/0x2e0
[  389.781173]  sas_free_task+0x3c/0x50   
[  389.781179]  pm8001_exec_internal_tmf_task.constprop.0+0x2b4/0x430
[  389.781186]  pm8001_abort_task+0x59c/0x810
[  389.781193]  sas_scsi_recover_host+0xafc/0x1090
[  389.781201]  scsi_error_handler+0x138/0x5f0
[  389.781207]  kthread+0x18c/0x194   
[  389.781213]  ret_from_fork+0x10/0x20   

Regular task timeout:
[   85.361540] Allocated by task 829:  
[   85.366754] CPU: 23 PID: 0 Comm: swapper/23 Not tainted 5.17.0-rc1-11821-g49f9b9c16c23 #1079
[   85.373181]  kasan_save_stack+0x30/0x60 
[   85.379401] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 251 tries: 1   
[   85.379522] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC0 - V1.16.01 03/15/2019   
[   85.386384]  __kasan_slab_alloc+0x70/0x94   
[   85.391598] Call trace: 
[   85.398025]  kmem_cache_alloc+0x18c/0x4dc   
[   85.404713]  dump_backtrace.part.0+0x1d8/0x1ec  
[   85.409665]  sas_alloc_task+0x28/0x70   
[   85.411145]  show_stack+0x1c/0x6c   
[   85.416097]  sas_queuecommand+0x174/0x360   
[   85.422699]  dump_stack_lvl+0x8c/0xb8   
[   85.429822]  scsi_queue_rq+0x848/0x11c0 
[   85.435035]  dump_stack+0x20/0x3c   
[   85.441463]  blk_mq_dispatch_rq_list+0x328/0xd10
[   85.447804]  spin_dump+0xd4/0xec
[   85.454667]  __blk_mq_sched_dispatch_requests+0x14c/0x224   
[   85.459879]  do_raw_spin_lock+0x204/0x230   
[   85.466307]  blk_mq_sched_dispatch_requests+0x60/0xa0   
[   85.472648]  _raw_spin_lock_irqsave+0xb4/0x110  
[   85.479510]  __blk_mq_run_hw_queue+0xc8/0x230   
[   85.484723]  mpi_ssp_completion+0x264/0xd00 
[   85.491151]  blk_mq_run_work_fn+0x30/0x40   
[   85.497492]  process_oq+0x7e4/0x3f14
[   85.504354]  process_one_work+0x508/0xbdc   
[   85.509567]  pm80xx_chip_isr+0x74/0xe0  
[   85.515994]  worker_thread+0xac/0x760   
[   85.522335]  pm8001_tasklet+0x64/0x7c   
[   85.529197]  kthread+0x1a4/0x1b0
[   85.534410]  tasklet_action_common.constprop.0+0x1c8/0x1e0  
[   85.540837]  ret_from_fork+0x10/0x20
[   85.547178]  tasklet_action+0x2c/0x40   
[   85.554040] 
[   85.559252]  __do_softirq+0x2a4/0x890   
[   85.565680] Freed by task 630:  
[   85.572021]  __irq_exit_rcu+0x248/0x280 
[   85.578883]  kasan_save_stack+0x30/0x60 
[   85.584095]  irq_exit_rcu+0x18/0x4c 
[   85.590523]  kasan_set_track+0x30/0x44  
[   85.596864]  el1_interrupt+0x38/0x80
[   85.603726]  kasan_set_free_info+0x2c/0x50  
[   85.608938]  el1h_64_irq_handler+0x1c/0x30  
[   85.615366]  __kasan_slab_free+0xf0/0x140   
[   85.621708]  el1h_64_irq+0x78/0x7c  
[   85.628570]  slab_free_freelist_hook+0x70/0x20c 
[   85.633782]  arch_local_irq_enable+0xc/0x20 
[   85.640210]  kmem_cache_free+0x100/0x420
[   85.646550]  default_idle_call+0x74/0x114   
[   85.653412]  sas_free_task+0x3c/0x50
[   85.658624]  do_idle+0x314/0x3a0
[   85.665052]  sas_end_task+0x8c/0x200
[   85.671392]  cpu_startup_entry+0x28/0x90
[   85.678254]  sas_eh_finish_cmd+0x6c/0x108   
[   85.683466]  secondary_start_kernel+0x248/0x29c 
[   85.689894]  sas_scsi_recover_host+0xb6c/0x10ac 
[   85.696235]  __secondary_switched+0x94/0x98 
[   85.703097]  scsi_error_handler+0x16c/0x644 
[   92.741029]  kthread+0x1a4/0x1b0
[   92.744253]  ret_from_fork+0x10/0x20

Patch 1/3 conflicts with [0]. I will update that series to support the
changes here.

[0] https://lore.kernel.org/linux-scsi/b49f8c20-355b-42f4-1910-4cb7b8e1b7fb@opensource.wdc.com/T/#mb2dd87f254e9318c4139805acd1b008b011e3075

John Garry (3):
  scsi: pm8001: Fix warning for undescribed param in process_one_iomb()
  scsi: pm8001: Fix use-after-free for aborted TMF sas_task
  scsi: pm8001: Fix use-after-free for aborted SSP/STP sas_task

 drivers/scsi/pm8001/pm8001_sas.c | 5 +++++
 drivers/scsi/pm8001/pm80xx_hwi.c | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.26.2

