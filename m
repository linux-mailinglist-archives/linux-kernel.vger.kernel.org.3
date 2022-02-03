Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD884A881D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352035AbiBCP4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:56:05 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4668 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbiBCP4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:56:00 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JqNY72zWQz67MpP;
        Thu,  3 Feb 2022 23:55:23 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Feb 2022 16:55:58 +0100
Received: from [10.47.89.50] (10.47.89.50) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 3 Feb
 2022 15:55:50 +0000
Message-ID: <098f988e-1f12-c412-3111-60393dfe0f0b@huawei.com>
Date:   Thu, 3 Feb 2022 15:55:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
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
 <49da4d80-5cc3-35c3-ccaa-6def8165eb65@huawei.com>
 <59a198a8-1d87-bc09-d2d8-2d495ed74c16@opensource.wdc.com>
In-Reply-To: <59a198a8-1d87-bc09-d2d8-2d495ed74c16@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.89.50]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2022 09:44, Damien Le Moal wrote:

Hi Damien,

>>>> [  385.102073] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
>>>> [  385.108026] sas: sas_scsi_find_task: aborting task 0x000000007068ed73
>>>> [  405.561099] pm80xx0:: pm8001_exec_internal_task_abort  757:TMF task

Contrary to mentioning TMF in the log, this is not a TMF but rather an 
internal abort timing out. I don't think that this should ever happen. 
This command should just abort pending IO commands in the controller and 
not send anything to the target. So for this to timeout means a HW fault 
or driver bug. And I did not touch this code for pm8001.

>>>> timeout.
>>>> [  405.568236] sas: sas_scsi_find_task: task 0x000000007068ed73 is
>>>> aborted
>>>> [  405.574930] sas: sas_eh_handle_sas_errors: task 0x000000007068ed73 is
>>>> aborted
>>>> [  411.192602] ata21.00: qc timeout (cmd 0xec)
>>>> [  431.672122] pm80xx0:: pm8001_exec_internal_task_abort  757:TMF task
>>>> timeout.
>>>> [  431.679282] ata21.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>>>> [  431.685544] ata21.00: revalidation failed (errno=-5)
>>>> [  441.911948] ata21.00: qc timeout (cmd 0xec)
>>>> [  462.391545] pm80xx0:: pm8001_exec_internal_task_abort  757:TMF task
>>>> timeout.
>>>> [  462.398696] ata21.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>>>> [  462.404992] ata21.00: revalidation failed (errno=-5)
>>>> [  492.598769] ata21.00: qc timeout (cmd 0xec)
>>>> ...
>>>>

Do you have a fuller dmesg with my series?

...

>> }
>> - res = -TMF_RESP_FUNC_FAILED;
>> + res = TMF_RESP_FUNC_FAILED;
>>
>> That's effectively the same as what I have in this series in
>> sas_execute_tmf().
>>
>> However your testing is a SATA device, which I'll check further.
> This did not help. Still seeing 100% reproducible hangs.

OK, but I think that we should also have this change as the mainline 
codes looks broken to be begin with:

--->8 ---

[PATCH] scsi: libsas: Handle all errors in sas_scsi_find_task()

LLDD TMFs callbacks may return linux or other error codes instead of TMF
codes. This may cause problems in sas_scsi_find_task() ->
.lldd_query_task(), as only TMF codes are handled there. As such, we may
not return a task_disposition type. Function sas_eh_handle_sas_errors() 
only handles that type, and may exit error
handling early for unrecognised types.

So use TASK_ABORT_FAILED for non-TMF types returned from
.lldd_query_task(), on the assumption that the command may still be 
alive and error handling should be escalated.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/scsi/libsas/sas_scsi_host.c 
b/drivers/scsi/libsas/sas_scsi_host.c
index 53d8b7ede0cd..02274f471308 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -316,8 +316,11 @@ static enum task_disposition 
sas_scsi_find_task(struct sas_task *task)
  				pr_notice("%s: task 0x%p failed to abort\n",
  					  __func__, task);
  				return TASK_ABORT_FAILED;
+			default:
+				pr_notice("%s: task 0x%p result code %d not handled, assuming 
failed\n",
+					  __func__, task, res);
+				return TASK_ABORT_FAILED;
  			}
-
  		}
  	}
  	return res;

---8< ----

> 
> I did a lot of testing/digging today, 

Thanks for the effort!

 > and the hang cause seems to be
 > missing task completions.
> At random, a task times out as its completion

That sounds fimilar to my general issue running this driver on an arm64 
host...

> does not come, and subsequent abort trial for the task fail, revalidate
> fails

I assume SMP IOs fail if revalidation fails - if this is the case, then 
the controller seems to be in bad state.

> and the device is dropped (capacity goes to 0). But at that point,
> doing rmmod/modprobe to reset the device does not work. sync cache
> command issued at rmmod time never completes. I end up needing to power
> cycle the machine every time...
> 
> No clue about the root cause yet, but it definitely seem to be related
> to NCQ/high QD operation. If I force my tests to use non-NCQ commands,
> everything is fine and the tests run to completion without any issue.
> 
> I wonder if their is a tag management bug somewhere...

Maybe. Not sure.

On a related point, Hannes' change here could avoid it:

https://lore.kernel.org/linux-scsi/20210222132405.91369-32-hare@suse.de/

> 
> I did stumble on something very ugly in libsas too: sas_ata_qc_issue()
> drops and retake the ata port lock. No other ATA driver do that since
> the ata completion also take that lock. The ata port lock is taken
> before ata_qc_issue() is called with IRQ disabled (spin_lock_irqsave()).
> So doing a spin_unlock()/spin_lock() in sas_ata_qc_issue() (called from
> ata_qc_issue()) seems like a very bad idea. I removed that and
> everything work the same way (the lld execute does not sleep). But that
> did not solve the hang problem.

I would need to check why this is done again. Before my time...

> 
> Of note is this is all with your libsas patches applied. Without the
> patches, I have KASAN screaming at me about use-after-free in completion
> context. With your patches, KASAN is silent.
> 
> Another thing: this driver does not allow changing the max qd... Very
> annoying.
> 
> echo 1 > /sys/block/sdX/device/queue_depth
> 
> has no effect. QD stays at 32 for an ATA drive. Need to look into that too.

I had a look at this. It seems that we fail in 
__ata_change_queue_depth() -> ata_scsi_find_dev() returning NULL.

Thanks again for your effort, I will continue to look.

john
