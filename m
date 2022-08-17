Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046135974A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241154AbiHQQzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241132AbiHQQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:55:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581C277EAD;
        Wed, 17 Aug 2022 09:54:59 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M7DXC24cZz67GqC;
        Thu, 18 Aug 2022 00:50:03 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 18:54:57 +0200
Received: from [10.48.158.152] (10.48.158.152) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 17:54:56 +0100
Message-ID: <018080d5-fbc4-7f04-0d3f-587f2397cd20@huawei.com>
Date:   Wed, 17 Aug 2022 17:54:56 +0100
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
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <0bb6b134-7bad-7c39-ad6d-25d57bd343eb@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.158.152]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On 17/08/2022 17:04, Damien Le Moal wrote:
> On 2022/08/17 7:52, John Garry wrote:
>> Similar to how AHCI handles NCQ errors in ahci_error_intr() ->
>> ata_port_abort() -> ata_do_link_abort(), add an NCQ error handler for LLDDs
>> to call to initiate a link abort.
>>
>> This will mark all outstanding QCs as failed and kick-off EH.
>>
>> Note:
>> The ATA_EH_RESET flag is set for following reasons:
>> - For hisi_sas, SATA device resources during error handling will only be
>>    released during reset for ATA EH.
>>    ATA EH could decide during autopsy that EH would not be required, so
>>    ensure that it happens (by setting the flag).
>> - Similar to hisi_sas, pm8001 NCQ error handling requires a hardreset to
>>    ensure necessary recovery commands are sent (so again we require flag
>>    ATA_EH_RESET to be set as an insurance policy).
>>
>> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/scsi/libsas/sas_ata.c | 11 +++++++++++
>>   include/scsi/sas_ata.h        |  5 +++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
>> index d35c9296f738..9daae64be37e 100644
>> --- a/drivers/scsi/libsas/sas_ata.c
>> +++ b/drivers/scsi/libsas/sas_ata.c
>> @@ -861,6 +861,17 @@ void sas_ata_wait_eh(struct domain_device *dev)
>>   	ata_port_wait_eh(ap);
>>   }
>>   
>> +void sas_ata_device_link_abort(struct domain_device *device)
>> +{
>> +	struct ata_port *ap = device->sata_dev.ap;
>> +	struct ata_link *link = &ap->link;
>> +
>> +	link->eh_info.err_mask |= AC_ERR_DEV;
>> +	link->eh_info.action |= ATA_EH_RESET;
> 

Hi Damien,

Warning: I'm going to write a bit of an essay here... :)

> I am still not convinced that we should set this here. ata_eh_link_autopsy() and
> ata_eh_analyze_serror() are supposed to set the action based on the error. Can't
> you reuse the link autopsy function ?

The link autopsy code works ok, but it may not decide to do the reset 
which we may rely on.

For hisi_sas, consider this log from an NCQ error:

174.385322] ata10.00: failed command: READ FPDMA QUEUED
[ 174.385336] ata10.00: cmd 60/08:00:11:27:00/00:00:00:00:00/40 tag 0 
ncq dma 4096 in
res 41/40:08:11:27:00/00:00:00:00:00/00 Emask 0x409 (media error) <F>
[ 174.385339] ata10.00: status: { DRDY ERR }
[ 174.385343] ata10.00: error: { UNC }
[ 174.385641] ata10.00: configured for UDMA/133
[ 174.385697] sd 6:0:1:0: [sdb] tag#701 FAILED Result: hostbyte=DID_OK 
driverbyte=DRIVER_SENSE
[ 174.385710] sd 6:0:1:0: [sdb] tag#701 Sense Key : Medium Error [current]
[ 174.385726] sd 6:0:1:0: [sdb] tag#701 Add. Sense: Unrecovered read 
error - auto reallocate failed
[ 174.385740] sd 6:0:1:0: [sdb] tag#701 CDB: Read(10) 28 00 00 00 27 11 
00 00 08 00
[ 174.385745] print_req_error: I/O error, dev sdb, sector 10001
[ 174.385827] ata10: EH complete

The ATA autopsy has a found medium error and decided that reset is not 
required - this is similar in that regard to the "unaligned write to a 
sequential write required zone on SMR" error you mentioned from your 
test previously. The problem in this is that for hisi_sas we depend on 
disk reset to release driver resources associated with ATA QCs. That is 
because it is only after reset that we can guarantee that no IO 
associated with the disk will complete in HW and it is safe to release 
the resources.

But pm8001 seems different here with regards releasing resources. I find 
that when EH kicks in from NCQ error and libsas tries to abort missing 
commands, the pm8001_abort_task() -> sas_execute_internal_abort_single() 
causes the original IO to complete as aborted - this is good, as then we 
may release the resources there. hisi_sas has no such feature.

But the pm8001 manual and current driver indicate that the 
OPC_INB_SATA_ABORT command should be sent after read log ext when 
handling NCQ error, regardless of an autopsy. I send OPC_INB_SATA_ABORT 
in ata_eh_reset() -> pm8001_I_T_nexus_reset() -> pm8001_send_abort_all()

As I mentioned before, I saw nowhere better to call 
pm8001_send_abort_all() for this. I would rather not do it in 
ata_eh_reset() -> pm8001_I_T_nexus_reset()

How about this modified approach:
- Continue to set ATA_EH_RESET in sas_ata_device_link_abort()
- pm8001_I_T_nexus_reset() will only call pm8001_send_abort_all() when 
the driver is in NCQ error state and not do a hard reset in that case.
	- But I am not sure if that works as the autopsy for NCQ error may have 
decided that a hardreset was really required. Hmmm..

Thanks,
John


> 
>> +	ata_link_abort(link);
>> +}
>> +EXPORT_SYMBOL_GPL(sas_ata_device_link_abort);
>> +
>>   int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
>>   {
>>   	struct sas_tmf_task tmf_task = {};
>> diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
>> index a1df4f9d57a3..cad0b33064a5 100644
>> --- a/include/scsi/sas_ata.h
>> +++ b/include/scsi/sas_ata.h
>> @@ -32,6 +32,7 @@ void sas_probe_sata(struct asd_sas_port *port);
>>   void sas_suspend_sata(struct asd_sas_port *port);
>>   void sas_resume_sata(struct asd_sas_port *port);
>>   void sas_ata_end_eh(struct ata_port *ap);
>> +void sas_ata_device_link_abort(struct domain_device *dev);
>>   int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
>>   			int force_phy_id);
>>   int sas_ata_wait_after_reset(struct domain_device *dev, unsigned long deadline);
>> @@ -87,6 +88,10 @@ static inline void sas_ata_end_eh(struct ata_port *ap)
>>   {
>>   }
>>   
>> +static inline void sas_ata_device_link_abort(struct domain_device *dev)
>> +{
>> +}
>> +
>>   static inline int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
>>   				      int force_phy_id)
>>   {
> 
> 

