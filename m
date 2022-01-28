Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9616C49F4F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347216AbiA1IND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:13:03 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:32127 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbiA1INB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:13:01 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JlVVw0glDz8wNq;
        Fri, 28 Jan 2022 16:10:00 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 28 Jan 2022 16:12:59 +0800
Subject: Re: [PATCH 00/16] scsi: libsas and users: Factor out LLDD TMF code
To:     John Garry <john.garry@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <artur.paszkiewicz@intel.com>,
        <jinpu.wang@cloud.ionos.com>, <Ajish.Koshy@microchip.com>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
CC:     <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>, <damien.lemoal@opensource.wdc.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <8285a1ba-9626-ddcb-d270-d543bf9df50b@hisilicon.com>
Date:   Fri, 28 Jan 2022 16:12:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,


ÔÚ 2022/1/25 19:32, John Garry Ð´µÀ:
> The LLDD TMF code is almost identical between hisi_sas, pm8001, and mvsas
> drivers.
>
> This series factors out that code into libsas, thus reducing much
> duplication and giving a net reduction of ~250 LoC.
>
> There are some subtle differences between the core TMF handler and each
> of the LLDDs old implementation, so any review and testing is appreciated.
>
> Some other minor patches are thrown in:
> - Delete unused macro in hisi_sas driver
> - Delete unused libsas callback
> - Add enum for response frame datapres field
>
> I have another follow-up series to factor out the internal abort code,
> which is common to hisi_sas and pm8001 drivers.
>
> Based on v5.17-rc1

We have a full test on this patchset on KunPeng920 (for hisi_sas part), 
and all of those testcases are passed, so please feel free to add :
Tested-by: liyihang6@hisilicon.com


> John Garry (16):
>    scsi: libsas: Use enum for response frame DATAPRES field
>    scsi: libsas: Delete lldd_clear_aca callback
>    scsi: hisi_sas: Delete unused I_T_NEXUS_RESET_PHYUP_TIMEOUT
>    scsi: libsas: Move SMP task handlers to core
>    scsi: libsas: Add struct sas_tmf_task
>    scsi: libsas: Add sas_task.tmf
>    scsi: libsas: Add sas_execute_tmf()
>    scsi: libsas: Add sas_execute_ssp_tmf()
>    scsi: libsas: Add TMF handler exec complete callback
>    scsi: libsas: Add TMF handler aborted callback
>    scsi: libsas: Add sas_abort_task_set()
>    scsi: libsas: Add sas_clear_task_set()
>    scsi: libsas: Add sas_lu_reset()
>    scsi: libsas: Add sas_query_task()
>    scsi: libsas: Add sas_abort_task()
>    scsi: libsas: Add sas_execute_ata_cmd()
>
>   Documentation/scsi/libsas.rst          |   2 -
>   drivers/scsi/aic94xx/aic94xx.h         |   1 -
>   drivers/scsi/aic94xx/aic94xx_init.c    |   1 -
>   drivers/scsi/aic94xx/aic94xx_tmf.c     |   9 -
>   drivers/scsi/hisi_sas/hisi_sas.h       |   9 +-
>   drivers/scsi/hisi_sas/hisi_sas_main.c  | 235 ++++---------------------
>   drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   2 +-
>   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   9 +-
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |   2 +-
>   drivers/scsi/isci/init.c               |   1 -
>   drivers/scsi/isci/task.c               |  18 --
>   drivers/scsi/isci/task.h               |   4 -
>   drivers/scsi/libsas/sas_ata.c          |   8 +
>   drivers/scsi/libsas/sas_expander.c     |  24 +--
>   drivers/scsi/libsas/sas_internal.h     |   6 +
>   drivers/scsi/libsas/sas_scsi_host.c    | 220 +++++++++++++++++++++++
>   drivers/scsi/libsas/sas_task.c         |  12 +-
>   drivers/scsi/mvsas/mv_defs.h           |   5 -
>   drivers/scsi/mvsas/mv_init.c           |   5 +-
>   drivers/scsi/mvsas/mv_sas.c            | 177 +------------------
>   drivers/scsi/mvsas/mv_sas.h            |   3 -
>   drivers/scsi/pm8001/pm8001_hwi.c       |   4 +-
>   drivers/scsi/pm8001/pm8001_init.c      |   4 +-
>   drivers/scsi/pm8001/pm8001_sas.c       | 180 +++----------------
>   drivers/scsi/pm8001/pm8001_sas.h       |  13 +-
>   include/scsi/libsas.h                  |  23 ++-
>   26 files changed, 353 insertions(+), 624 deletions(-)
>

