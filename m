Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924C04A97E9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358039AbiBDKg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:36:56 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4670 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiBDKgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:36:55 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JqsKf45tSz67bMy;
        Fri,  4 Feb 2022 18:32:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 11:36:52 +0100
Received: from [10.47.87.24] (10.47.87.24) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Feb
 2022 10:36:45 +0000
Message-ID: <e8af9d55-bf36-faa0-defb-3a9a4931826e@huawei.com>
Date:   Fri, 4 Feb 2022 10:36:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
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
 <098f988e-1f12-c412-3111-60393dfe0f0b@huawei.com>
 <f3362c6f-b4b6-2914-0652-d786e19b6b03@opensource.wdc.com>
 <62e56609-7026-93a1-a446-a6fd68328653@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <62e56609-7026-93a1-a446-a6fd68328653@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2022 03:02, Damien Le Moal wrote:
>> The inconsistency is this line says:
>> [  137.193944] pm80xx0:: pm80xx_chip_sata_req  4581:no data
>> Which seems to be sensical for NCQ_NON_DATA command, but then, this line
>> seems wrong:
>> [  137.228015] pm80xx0:: mpi_sata_completion  2515:FPDMA len = 8
>>
>> I need to go and check the specs what the FIS reply format is for
>> NCQ_NON_DATA.
>>
>>
>> [  137.187184] pm80xx0:: pm8001_queue_command  408:pm8001_task_exec device
>> [  137.193944] pm80xx0:: pm80xx_chip_sata_req  4581:no data
>> [  137.199339] pm80xx0:: pm80xx_chip_sata_req  4682:Sending Normal SATA
>> command 0x63 inb 4
>> [  137.207577] pm80xx0:: pm8001_mpi_msg_consume  1446:: CI=46 PI=47
>> msgHeader=8104200d
>> [  137.215399] pm80xx0:: mpi_sata_completion  2481:IO_SUCCESS
>> [  137.220961] pm80xx0:: mpi_sata_completion  2503:SAS_PROTO_RESPONSE
>> len = 20
>> [  137.228015] pm80xx0:: mpi_sata_completion  2515:FPDMA len = 8
>> [  137.233878] pm80xx0:: pm8001_mpi_msg_free_set  1403: CI=47 PI=47
>> [  137.236696] pm80xx0:: pm8001_queue_command  408:pm8001_task_exec device
>> [  137.247102] pm80xx0:: pm80xx_chip_sata_req  4585:DMA
>> [  137.252186] pm80xx0:: pm80xx_chip_sata_req  4593:FPDMA
>> [  137.257400] pm80xx0:: pm80xx_chip_sata_req  4682:Sending Normal SATA
>> command 0x65 inb f
>> [  167.506280] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
>> [  167.512363] sas: sas_scsi_find_task: aborting task 0x00000000aa372627
>> [  167.519049] pm80xx0:: pm8001_chip_abort_task  4607:cmd_tag = 2, abort
>> task tag = 0x1
>> [  187.969173] pm80xx0:: pm8001_exec_internal_task_abort  753:TMF task
>> timeout.

As I mentioned, having this fail is a red flag. If I was pushed to guess 
what has happened, I'd say the FW is faulting due to some erroneous 
driver behaviour.

>> [  187.976450] sas: sas_scsi_find_task: task 0x00000000aa372627 is aborted
>> [  187.983244] sas: sas_eh_handle_sas_errors: task 0x00000000aa372627 is
>> aborted



>>
>> After these messages, the tests exit on failure (drive dropped) and
>> there are no more messages. Doing rmmod or anything else get stuck too.
>> I have to reset the machine to get back to a good state.
>>
>> I am starting to think that NCQ NON DATA command is being very badly
>> handled... Switching the tests to run with all non-NCQ commands is
>> working fine, albeit horribly slow (much slower than with other HBAs,
>> e.g. Broadcom).
>>
>> Digging...
> I missed a KASAN splat during device scan on boot:
> 
>     33.725184]
> ==================================================================
> [   33.746168] BUG: KASAN: use-after-free in __lock_acquire+0x41a5/0x5b50
> [   33.764181] Read of size 8 at addr ffff88818a318660 by task
> kworker/u64:6/583

...

> ==================================================================
> 
> This is the submission path, not completion. The code is:
> 
> (gdb) list *(pm8001_queue_command+0x842)
> 0x3d42 is in pm8001_queue_command (drivers/scsi/pm8001/pm8001_sas.c:491).
> 486				atomic_dec(&pm8001_dev->running_req);
> 487				goto err_out_tag;
> 488			}
> 489			/* TODO: select normal or high priority */
> 490			spin_lock(&t->task_state_lock);
> 491			t->task_state_flags |= SAS_TASK_AT_INITIATOR;
> 492			spin_unlock(&t->task_state_lock);
> 493		} while (0);
> 494		rc = 0;
> 495		goto out_done;
> 
> So the task is already completed when the submission path tries to set
> the state flag ? Debugging...

Yeah, that's how it looks.

I already mentioned this problem here:

https://lore.kernel.org/linux-scsi/0cc0c435-b4f2-9c76-258d-865ba50a29dd@huawei.com/

Maybe we should just fix it now to rule it out of possibly causing other 
issues... I was reluctant to fix it as many places seems to need to be 
touched. Let me check it.

Thanks,
John


