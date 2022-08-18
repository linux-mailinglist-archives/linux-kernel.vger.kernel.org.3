Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F45C5982F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244544AbiHRMKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbiHRMJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:09:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D4F5851F;
        Thu, 18 Aug 2022 05:09:56 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M7kGC3nF5z688XS;
        Thu, 18 Aug 2022 20:09:39 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 14:09:54 +0200
Received: from [10.48.157.252] (10.48.157.252) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 13:09:53 +0100
Message-ID: <eb3465a2-335e-a605-ba8a-4cce790b5b02@huawei.com>
Date:   Thu, 18 Aug 2022 13:09:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 2/6] scsi: libsas: Add sas_ata_device_link_abort()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <yangxingui@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <hare@suse.de>
References: <1660747934-60059-1-git-send-email-john.garry@huawei.com>
 <1660747934-60059-3-git-send-email-john.garry@huawei.com>
 <0bb6b134-7bad-7c39-ad6d-25d57bd343eb@opensource.wdc.com>
 <018080d5-fbc4-7f04-0d3f-587f2397cd20@huawei.com>
 <baf63982-810c-85eb-b28f-99ab0517c6ba@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <baf63982-810c-85eb-b28f-99ab0517c6ba@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.157.252]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 18:14, Damien Le Moal wrote:
>> The ATA autopsy has a found medium error and decided that reset is not
>> required - this is similar in that regard to the "unaligned write to a
>> sequential write required zone on SMR" error you mentioned from your
>> test previously. The problem in this is that for hisi_sas we depend on
>> disk reset to release driver resources associated with ATA QCs. That is
>> because it is only after reset that we can guarantee that no IO
>> associated with the disk will complete in HW and it is safe to release
>> the resources.
> If you had an error, then you already are guaranteed that you will not see any
> completion at all since the SATA drive is in error mode already. But I see the
> point here. The HBA internal qc resources need to be cleared and that seems to
> be done only with a device reset big hammer.

Yeah, unfortunately

> 
>> But pm8001 seems different here with regards releasing resources. I find
>> that when EH kicks in from NCQ error and libsas tries to abort missing
>> commands, the pm8001_abort_task() -> sas_execute_internal_abort_single()
>> causes the original IO to complete as aborted - this is good, as then we
>> may release the resources there. hisi_sas has no such feature.
>>
>> But the pm8001 manual and current driver indicate that the
>> OPC_INB_SATA_ABORT command should be sent after read log ext when
>> handling NCQ error, regardless of an autopsy. I send OPC_INB_SATA_ABORT
>> in ata_eh_reset() -> pm8001_I_T_nexus_reset() -> pm8001_send_abort_all()
> You lost me: ata_eh_recover() will call ata_eh_reset() only if the ATA_EH_RESET
> action flag is set. So are you saying that even though it is not needed, you
> still need to set ATA_EH_RESET for pm8001 ?

As below, it was the only location I found suitable to call 
pm8001_send_abort_all().

However I am not really sure it is required now. For pm8001 NCQ error 
handling we require 2x steps:
- read log ext
- Send OPC_INB_SATA_ABORT - we do this in pm8001_send_abort_all()

pm8001_send_abort_all() sends OPC_INB_SATA_ABORT in "device abort all" 
mode, meaning any IO in the HBA is aborted for the device. But we are 
also earlier in EH sending OPC_INB_SATA_ABORT for individual IOs in 
sas_eh_handle_sas_errors() -> sas_scsi_find_task() -> 
pm8001_abort_task() -> sas_execute_internal_abort_single() -> ... 
send_abort_task()

So I don't think that the pm8001_send_abort_all() call has any effect, 
as we're already aborting any outstanding IO earlier.

Admittedly the order of the 2x steps is different, but 
OPC_INB_SATA_ABORT does not send any protocol message to the disk, so 
would not affect anything subsequently read with read log ext.

Having said all that, it may be wise to still send 
pm8001_send_abort_all()...

> 
>> As I mentioned before, I saw nowhere better to call
>> pm8001_send_abort_all() for this. I would rather not do it in
>> ata_eh_reset() -> pm8001_I_T_nexus_reset()
> We could add a new op ->eh_link_autopsy which we can call if defined after the
> call to ata_eh_analyze_ncq_error() in ata_eh_link_autopsy(). With that, you can
> set ATA_EH_RESET for the hisi driver and only do pm8001_send_abort_all() for
> pm8001 (that will be done after the read log 10h).

hmmmm.... seems unfortunate if we need to add a new op just for this.

If we supported ata_port_operations.softreset CB for libsas, then it 
seems a good location to issue pm8001_send_abort_all(). However, ATA EH 
always prefers hardreset over softreset if both supported - do you see 
any scope to change this so that we could use softreset?

> 
>> How about this modified approach:
>> - Continue to set ATA_EH_RESET in sas_ata_device_link_abort()
>> - pm8001_I_T_nexus_reset() will only call pm8001_send_abort_all() when
>> the driver is in NCQ error state and not do a hard reset in that case.
>> 	- But I am not sure if that works as the autopsy for NCQ error may have
>> decided that a hardreset was really required. Hmmm..
> See the above. the new op may decided a reset is needed (hisi case) and even if
> the standard autopsy does not make that decision, the flag is set and
> ata_eh_recover() will reset the device. For the pm8001 case, no reset set with
> the new op, only pm8001_send_abort_all(). And even if ata_eh_link_autopsy()
> decides that a reset is needed after calling the new op, that would still be OK
> I think.

I just think that for hisi_sas a reset is always required unfortunately 
- either an ATA softreset or hardreset. For pm8001, as you say, we can 
let autopsy decide whether the big hammer (hard) reset is required.

Thanks,
John
