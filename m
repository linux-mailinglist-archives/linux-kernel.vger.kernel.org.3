Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944F849F4E0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347161AbiA1IG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:06:27 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30317 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbiA1IGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:06:25 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JlVPl04PVzbk7m;
        Fri, 28 Jan 2022 16:05:31 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 28 Jan 2022 16:06:22 +0800
Subject: Re: [PATCH 06/16] scsi: libsas: Add sas_task.tmf
To:     John Garry <john.garry@huawei.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "artur.paszkiewicz@intel.com" <artur.paszkiewicz@intel.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "Ajish.Koshy@microchip.com" <Ajish.Koshy@microchip.com>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1643110372-85470-7-git-send-email-john.garry@huawei.com>
 <e349aedb-71ad-8bf2-d3c3-920a83a56eae@hisilicon.com>
 <6b31c696-9808-764b-489b-4d2de91051b9@huawei.com>
CC:     yanaijie <yanaijie@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        "Viswas.G@microchip.com" <Viswas.G@microchip.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <b2f04325-f116-8fb4-b8c8-313e19c18ea4@hisilicon.com>
Date:   Fri, 28 Jan 2022 16:06:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <6b31c696-9808-764b-489b-4d2de91051b9@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/1/28 0:01, John Garry 写道:
> On 27/01/2022 12:55, chenxiang (M) wrote:
>>> -    slot->tmf = tmf;
>>> -    slot->is_internal = tmf;
>> In kernel 5.17-rc1(with above two lines on), it seems there is a issue
>> for ata disk reset command as tmf = null while it is internal command.
>
> ok, thanks for the notice. Would this fix it:

Yes, it should fix it, and i just notice that it seems solve the issue 
in the last patch of this patchset (including this fix in the last patch).

>
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c 
> b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index a05ec7aece5a..0e12c9329ee5 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -427,8 +427,6 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
>      cmd_hdr_base = hisi_hba->cmd_hdr[dlvry_queue];
>      slot->cmd_hdr = &cmd_hdr_base[dlvry_queue_slot];
>
> -    slot->tmf = tmf;
> -    slot->is_internal = tmf;
>      task->lldd_task = slot;
>
>      memset(slot->cmd_hdr, 0, sizeof(struct hisi_sas_cmd_hdr));
> @@ -1380,12 +1378,13 @@ static int hisi_sas_softreset_ata_disk(struct 
> domain_device *device)
>      struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
>      struct device *dev = hisi_hba->dev;
>      int s = sizeof(struct host_to_dev_fis);
> +    struct hisi_sas_tmf_task tmf = {};
>
>      ata_for_each_link(link, ap, EDGE) {
>          int pmp = sata_srst_pmp(link);
>
>          hisi_sas_fill_ata_reset_cmd(link->device, 1, pmp, fis);
> -        rc = hisi_sas_exec_internal_tmf_task(device, fis, s, NULL);
> +        rc = hisi_sas_exec_internal_tmf_task(device, fis, s, &tmf);
>          if (rc != TMF_RESP_FUNC_COMPLETE)
>              break;
>      }
> @@ -1396,7 +1395,7 @@ static int hisi_sas_softreset_ata_disk(struct 
> domain_device *device)
>
>              hisi_sas_fill_ata_reset_cmd(link->device, 0, pmp, fis);
>              rc = hisi_sas_exec_internal_tmf_task(device, fis,
> -                                 s, NULL);
> +                                 s, &tmf);
>              if (rc != TMF_RESP_FUNC_COMPLETE)
>                  dev_err(dev, "ata disk %016llx de-reset failed\n",
>                      SAS_ADDR(device->sas_addr));
>
>>
>>>        task->lldd_task = slot;
>
>
>
> .
>

