Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E59B4A5520
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 03:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiBACDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 21:03:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11086 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232332AbiBACDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:03:42 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VLZf40010052;
        Tue, 1 Feb 2022 02:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=drxk5oEYLxxWikk1+TDaKvNPOKmjAnMKtkAedlJW994=;
 b=nWHes1jezO/TqgqIB3oOJuYKmaRoo63iB8TY9kbnZsKP+n4RbXgvvqz7gaaVIwUdtdjU
 1FLdjA7vAD1iSdnA+ADg1c57ex113jrBIdtqqreOue2XZh8bzyGK1E5sfMk5AvAwIMaA
 VCPRq6p3SxxhAP7G4SnKdDqUzzTQn2tJwJG0xUer2vYBIQeP5ke0YZ06Az0vcs12DlQr
 Ox8iTAcyA5SiEjd7CdU7xQtzpVSeLr5L1+B5LS2wG++Kvda3rFwO/5uXsNcP/CDmLxx/
 TXyBYV8P/Pje5bZhqQEJrmcmL7xjHgo55tVXfJ5wjRwsDtk1c5zyqjA9e2OwxtP1/iW4 mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac1fg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 02:03:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2111tJqA078954;
        Tue, 1 Feb 2022 02:03:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3dvtpy6w70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 02:03:28 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21123EPf096319;
        Tue, 1 Feb 2022 02:03:27 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3dvtpy6w3w-3;
        Tue, 01 Feb 2022 02:03:27 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jinpu.wang@cloud.ionos.com, Ajish.Koshy@microchip.com,
        jejb@linux.ibm.com, damien.lemoal@opensource.wdc.com,
        John Garry <john.garry@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        chenxiang66@hisilicon.com, Viswas.G@microchip.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] scsi: pm8001: Documentation and use-after-free fixes
Date:   Mon, 31 Jan 2022 21:03:21 -0500
Message-Id: <164368097302.23346.11566808732978746802.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1643289172-165636-1-git-send-email-john.garry@huawei.com>
References: <1643289172-165636-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9SY32YKq6pSnEHoycecqu2y-WafPYh8i
X-Proofpoint-ORIG-GUID: 9SY32YKq6pSnEHoycecqu2y-WafPYh8i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 21:12:49 +0800, John Garry wrote:

> A few fixes:
> - Remedy make W=1 warning for undescribed param
> - 2x use-after-free fixes for these KASAN warnings:
> 
> TMF timeout:
> 389.780822] ==================================================================
> [  389.780828] BUG: KASAN: use-after-free in mpi_ssp_completion+0xb8/0xd20
> [  389.780845] Read of size 8 at addr ffff0020ccb50268 by task swapper/6/0
> [  389.780851]
> [  389.780854] CPU: 6 PID: 0 Comm: swapper/6 Not tainted 5.17.0-rc1-11819-gb4fa2357aff7 #1077
> [  389.780862] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC0 - V1.16.01 03/15/2019
> [  389.780867] Call trace:
> [  389.780870]  dump_backtrace.part.0+0x1d4/0x1e0
> [  389.780880]  show_stack+0x1c/0x6c
> [  389.780888]  dump_stack_lvl+0x68/0x84
> [  389.780897]  print_address_description.constprop.0+0x74/0x2d8
> [  389.780905]  kasan_report+0x1e4/0x250
> [  389.780913]  __asan_load8+0x98/0xd4
> [  389.780920]  mpi_ssp_completion+0xb8/0xd20
> [  389.780927]  process_oq+0x7ec/0x3fec
> [  389.780935]  pm80xx_chip_isr+0x74/0xe0
> [  389.780942]  pm8001_tasklet+0x64/0x80
> [  389.780948]  tasklet_action_common.constprop.0+0x1c4/0x1d0
> [  389.780957]  tasklet_action+0x2c/0x40
> [  389.780964]  __do_softirq+0x1b0/0x3f8
> [  389.780969]  __irq_exit_rcu+0x160/0x180
> [  389.780976]  irq_exit_rcu+0x14/0x20
> [  389.780983]  el1_interrupt+0x38/0x80
> [  389.780992]  el1h_64_irq_handler+0x1c/0x2c
> [  389.780998]  el1h_64_irq+0x78/0x7c
> [  389.781004]  arch_local_irq_enable+0xc/0x20
> [  389.781012]  default_idle_call+0x30/0x6c
> [  389.781020]  do_idle+0x2ec/0x370
> [  389.781027]  cpu_startup_entry+0x2c/0x80
> [  389.781034]  secondary_start_kernel+0x240/0x28c
> [  389.781041]  __secondary_switched+0x94/0x98
> [  389.781051]
> [  389.781053] Allocated by task 629:
> [  389.781057]  kasan_save_stack+0x30/0x60
> [  389.781065]  __kasan_slab_alloc+0x70/0x94
> [  389.781071]  kmem_cache_alloc+0x16c/0x2fc
> [  389.781078]  sas_alloc_slow_task+0x38/0x250
> [  389.781086]  pm8001_exec_internal_tmf_task.constprop.0+0xf0/0x430
> [  389.781093]  pm8001_abort_task+0x59c/0x810
> [  389.781100]  sas_scsi_recover_host+0xafc/0x1090
> [  389.781108]  scsi_error_handler+0x138/0x5f0
> [  389.781114]  kthread+0x18c/0x194
> [  389.781123]  ret_from_fork+0x10/0x20
> [  389.781129]
> [  389.781131] Freed by task 629:
> [  389.781134]  kasan_save_stack+0x30/0x60
> [  389.781141]  kasan_set_track+0x30/0x44
> [  389.781147]  kasan_set_free_info+0x2c/0x50
> [  389.781155]  __kasan_slab_free+0xf0/0x140
> [  389.781161]  slab_free_freelist_hook+0x70/0x1f0
> [  389.781167]  kmem_cache_free+0xb4/0x2e0
> [  389.781173]  sas_free_task+0x3c/0x50
> [  389.781179]  pm8001_exec_internal_tmf_task.constprop.0+0x2b4/0x430
> [  389.781186]  pm8001_abort_task+0x59c/0x810
> [  389.781193]  sas_scsi_recover_host+0xafc/0x1090
> [  389.781201]  scsi_error_handler+0x138/0x5f0
> [  389.781207]  kthread+0x18c/0x194
> [  389.781213]  ret_from_fork+0x10/0x20
> 
> [...]

Applied to 5.17/scsi-fixes, thanks!

[1/3] scsi: pm8001: Fix warning for undescribed param in process_one_iomb()
      https://git.kernel.org/mkp/scsi/c/0aed75fd30da
[2/3] scsi: pm8001: Fix use-after-free for aborted TMF sas_task
      https://git.kernel.org/mkp/scsi/c/61f162aa4381
[3/3] scsi: pm8001: Fix use-after-free for aborted SSP/STP sas_task
      https://git.kernel.org/mkp/scsi/c/df7abcaa1246

-- 
Martin K. Petersen	Oracle Linux Engineering
