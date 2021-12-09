Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D3F46E959
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbhLINuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:50:04 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4238 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238154AbhLINuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:50:00 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J8wJ241Gpz67xjc;
        Thu,  9 Dec 2021 21:44:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 14:46:24 +0100
Received: from [10.47.91.245] (10.47.91.245) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 9 Dec
 2021 13:46:23 +0000
Subject: Re: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
To:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <Viswas.G@microchip.com>, <Ajish.Koshy@microchip.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1637940933-107862-1-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a93da7a3-9cbe-b278-36ce-1ac860ad43d6@huawei.com>
Date:   Thu, 9 Dec 2021 13:46:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1637940933-107862-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.245]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2021 15:35, John Garry wrote:
>   	/*
> @@ -4280,8 +4283,9 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>   		pm8001_ha->smp_exp_mode = SMP_INDIRECT;
>   
>   
> -	tmp_addr = cpu_to_le64((u64)sg_dma_address(&task->smp_task.smp_req));
> -	preq_dma_addr = (char *)phys_to_virt(tmp_addr);
> +	smp_req = &task->smp_task.smp_req;
> +	to = kmap(sg_page(smp_req));

This should be a kmap_atomic() as well, as I see the following for when 
CONFIG_DEBUG_ATOMIC_SLEEP is enabled:

[   27.222116]  dump_backtrace+0x0/0x2b4
[   27.225774]  show_stack+0x1c/0x30
[   27.229084]  dump_stack_lvl+0x68/0x84
[   27.232741]  dump_stack+0x20/0x3c
[   27.236049]  __might_resched+0x1d4/0x240
[   27.239967]  __might_sleep+0x70/0xd0
[   27.243536]  pm80xx_chip_smp_req+0x2c4/0x56c
[   27.247802]  pm8001_task_exec.constprop.0+0x718/0x770
[   27.252848]  pm8001_queue_command+0x1c/0x2c
[   27.257026]  smp_execute_task_sg+0x1e8/0x370
[   27.261289]  sas_ex_phy_discover+0x29c/0x31c
[   27.265553]  smp_ata_check_ready+0x74/0x190
[   27.269729]  ata_wait_ready+0xd0/0x224
[   27.273474]  ata_wait_after_reset+0x78/0xac
[   27.277652]  sas_ata_hard_reset+0xf0/0x18c
[   27.281742]  ata_do_reset.constprop.0+0x80/0x9c
[   27.286266]  ata_eh_reset+0xba4/0x1170
[   27.290008]  ata_eh_recover+0x4b0/0x1b40
[   27.293924]  ata_do_eh+0x8c/0x110
[   27.297232]  ata_std_error_handler+0x80/0xb0
[   27.301495]  ata_scsi_port_error_handler+0x3d4/0x9d0
[   27.306454]  async_sas_ata_eh+0x70/0xf8
[   27.310285]  async_run_entry_fn+0x5c/0x1e0
[   27.314375]  process_one_work+0x378/0x630
[   27.318379]  worker_thread+0xa8/0x6bc
[   27.322033]  kthread+0x214/0x230
[   27.325256]  ret_from_fork+0x10/0x20
[   27.328825] pm80xx0:: pm80xx_chip_smp_req  4292:SMP REQUEST INDIRECT MODE

But I don't think that this is the problem which causes error handling 
to kick in later, as discussed in this thread.

> +	payload = to + smp_req->offset;
>   
>   	/* INDIRECT MODE command settings. Use DMA */
>   	if (pm8001_ha->smp_exp_mode == SMP_INDIRECT) {
> @@ -4289,7 +4293,7 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>   		/* for SPCv indirect mode. Place the top 4 bytes of
>   		 * SMP Request header here. */
>   		for (i = 0; i < 4; i++)
> -			smp_cmd.smp_req16[i] = *(preq_dma_addr + i);
> +			smp_cmd.smp_req16[i] = *(payload + i);

