Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668DA4A4B26
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379970AbiAaP7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:59:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4569 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbiAaP73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:59:29 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JnXmc1p3Dz67k8Z;
        Mon, 31 Jan 2022 23:58:56 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 16:59:26 +0100
Received: from [10.47.91.239] (10.47.91.239) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 31 Jan
 2022 15:59:26 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 00/16] scsi: libsas and users: Factor out LLDD TMF code
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>
CC:     <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1893d9ef-042b-af3b-74ea-dd4d0210c493@opensource.wdc.com>
 <14df160f-c0f2-cc9f-56d4-8eda67969e0b@huawei.com>
 <a8fae323-1877-058a-b03e-d175a725213f@opensource.wdc.com>
 <a2de1656-b1ec-2fb7-caab-657e27dacb48@huawei.com>
Message-ID: <49da4d80-5cc3-35c3-ccaa-6def8165eb65@huawei.com>
Date:   Mon, 31 Jan 2022 15:58:50 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <a2de1656-b1ec-2fb7-caab-657e27dacb48@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.91.239]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2022 09:09, John Garry wrote:
>> I ran some more tests. In particular, I ran libzbc compliance tests on a
>> 20TB SMR drives. All tests pass with 5.17-rc1, but after applying your
>> series, I see command timeout that take forever to recover from, with
>> the drive revalidation failing after that.
>>
>> [  385.102073] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
>> [  385.108026] sas: sas_scsi_find_task: aborting task 0x000000007068ed73
>> [  405.561099] pm80xx0:: pm8001_exec_internal_task_abort  757:TMF task
>> timeout.
>> [  405.568236] sas: sas_scsi_find_task: task 0x000000007068ed73 is 
>> aborted
>> [  405.574930] sas: sas_eh_handle_sas_errors: task 0x000000007068ed73 is
>> aborted
>> [  411.192602] ata21.00: qc timeout (cmd 0xec)
>> [  431.672122] pm80xx0:: pm8001_exec_internal_task_abort  757:TMF task
>> timeout.
>> [  431.679282] ata21.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>> [  431.685544] ata21.00: revalidation failed (errno=-5)
>> [  441.911948] ata21.00: qc timeout (cmd 0xec)
>> [  462.391545] pm80xx0:: pm8001_exec_internal_task_abort  757:TMF task
>> timeout.
>> [  462.398696] ata21.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>> [  462.404992] ata21.00: revalidation failed (errno=-5)
>> [  492.598769] ata21.00: qc timeout (cmd 0xec)
>> ...
>>
>> So there is a problem. Need to dig into this. I see this issue only with
>> libzbc passthrough tests. fio runs with libaio are fine.
> 
> Thanks for the notice. I think that I also saw a hang, but, IIRC, it 
> happened on mainline for me - but it's hard to know if I broke something 
> if it is already broke in another way. That is why I wanted this card 
> working properly...

Hi Damien,

 From testing mainline, I can see a hang on my arm64 system for SAS 
disks. I think that the reason is the we don't finish some commands in 
EH properly for pm8001:
- In EH, we attempt to abort the task in sas_scsi_find_task() -> 
lldd_abort_task()
The default return from pm8001_exec_internal_tmf_task() is 
-TMF_RESP_FUNC_FAILED, so if the TMF does not execute properly we return 
this value
- sas_scsi_find_task() cannot handle -TMF_RESP_FUNC_FAILED, and returns 
-TMF_RESP_FUNC_FAILED directly to sas_eh_handle_sas_errors(), which, 
again, does not handle -TMF_RESP_FUNC_FAILED. So we don't progress to 
ever finish the comand.

This looks like the correct fix for mainline:

--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -766,7 +766,7 @@ static int pm8001_exec_internal_tmf_task(struct 
domain_device *dev,
pm8001_dev, DS_OPERATIONAL);
wait_for_completion(&completion_setstate);
}
- res = -TMF_RESP_FUNC_FAILED;
+ res = TMF_RESP_FUNC_FAILED;

That's effectively the same as what I have in this series in 
sas_execute_tmf().

However your testing is a SATA device, which I'll check further.

Thanks,
John
