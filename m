Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8C9590D25
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiHLIGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiHLIGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:06:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB329DB6D;
        Fri, 12 Aug 2022 01:06:46 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M3x8Y4CcJz687YW;
        Fri, 12 Aug 2022 16:06:37 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 10:06:43 +0200
Received: from [10.48.157.254] (10.48.157.254) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 09:06:42 +0100
Message-ID: <437abe43-7ddd-6f49-9386-d8ed04c659bf@huawei.com>
Date:   Fri, 12 Aug 2022 09:06:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/6] libsas and drivers: NCQ error handling
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <yangxingui@huawei.com>,
        <chenxiang66@hisilicon.com>, <hare@suse.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1658489049-232850-1-git-send-email-john.garry@huawei.com>
 <d2e27cb7-d90a-2f0a-1848-e1ec8faf7899@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <d2e27cb7-d90a-2f0a-1848-e1ec8faf7899@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.157.254]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On 11/08/2022 19:54, Damien Le Moal wrote:
> On 2022/07/22 4:24, John Garry wrote:
>> As reported in [0], the pm8001 driver NCQ error handling more or less
>> duplicates what libata does in link error handling, as follows:
>> - abort all commands
>> - do autopsy with read log ext 10 command
>> - reset the target to recover
>>
>> Indeed for the hisi_sas driver we want to add similar handling for NCQ
>> errors.
>>
>> This series add a new libsas API - sas_ata_link_abort() - to handle host
>> NCQ errors, and fixes up pm8001 and hisi_sas drivers to use it. As
>> mentioned in the pm8001 changeover patch, I would prefer a better place to
>> locate the SATA ABORT command (rather that nexus reset callback).
>>
>> I would appreciate some testing of the pm8001 change as the read log ext10
>> command mostly hangs on my arm64 machine - these arm64 hangs are a known
>> issue.
> 

Thanks for this!

> I applied this series on top of the current Linus tree and ran some tests: a
> bunch of fio runs and also ran libzbc test suites on a SATA SMR drive as that
> generates many command failures. No problems detected, the tests all pass.
> FYI, messages for failed commands look like this:
> 
> pm80xx0:: mpi_sata_event 2685: SATA EVENT 0x23
> sas: Enter sas_scsi_recover_host busy: 1 failed: 1
> sas: sas_scsi_find_task: aborting task 0x00000000ba62a907
> pm80xx0:: mpi_sata_completion 2292: task null, freeing CCB tag 2
> sas: sas_scsi_find_task: task 0x00000000ba62a907 is aborted
> sas: sas_eh_handle_sas_errors: task 0x00000000ba62a907 is aborted
> ata21.00: exception Emask 0x0 SAct 0x20000000 SErr 0x0 action 0x0
> ata21.00: failed command: WRITE FPDMA QUEUED
> ata21.00: cmd 61/02:00:ff:ff:ea/00:00:02:00:00/40 tag 29 ncq dma 8192 out
> res 43/04:02:ff:ff:ea/00:00:02:00:00/00 Emask 0x400 (NCQ error) <F>
> ata21.00: status: { DRDY SENSE ERR }
> ata21.00: error: { ABRT }
> ata21.00: configured for UDMA/133
> ata21: EH complete
> sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 1 tries: 1
> 

For this specific test we don't seem to run a hardreset after the 
autopsy, but we do seem to be getting an NCQ error. That's interesting.

We have noticed this scenario for hisi_sas NCQ error, whereby the 
autopsy decided a reset is not required or useful, such as a medium 
error. Anyway the pm8001 driver relies on the reset being run always for 
the NCQ error. So I am thinking of tweaking sas_ata_link_abort() as follows:

void sas_ata_link_abort(struct domain_device *device)
{
	struct ata_port *ap = device->sata_dev.ap;
	struct ata_link *link = &ap->link;

	link->eh_info.err_mask |= AC_ERR_DEV;
+	link->eh_info.action |= ATA_EH_RESET;
	ata_link_abort(link);
}

This should force a reset.

Thanks,
John

> Seems all good to me.
> 
>>
>> Finally with these changes we can make the libsas task alloc/free APIs
>> private, which they should always have been.
>>
>> Based on v5.19-rc6
>>
>> [0] https://lore.kernel.org/linux-scsi/8fb3b093-55f0-1fab-81f4-e8519810a978@huawei.com/
>>
>> John Garry (5):
>>    scsi: pm8001: Modify task abort handling for SATA task
>>    scsi: libsas: Add sas_ata_link_abort()
>>    scsi: pm8001: Use sas_ata_link_abort() to handle NCQ errors
>>    scsi: hisi_sas: Don't issue ATA softreset in hisi_sas_abort_task()
>>    scsi: libsas: Make sas_{alloc, alloc_slow, free}_task() private
>>
>> Xingui Yang (1):
>>    scsi: hisi_sas: Add SATA_DISK_ERR bit handling for v3 hw
>>
>>   drivers/scsi/hisi_sas/hisi_sas_main.c  |   5 +-
>>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  22 ++-
>>   drivers/scsi/libsas/sas_ata.c          |  10 ++
>>   drivers/scsi/libsas/sas_init.c         |   3 -
>>   drivers/scsi/libsas/sas_internal.h     |   4 +
>>   drivers/scsi/pm8001/pm8001_hwi.c       | 194 +++++++------------------
>>   drivers/scsi/pm8001/pm8001_sas.c       |  13 ++
>>   drivers/scsi/pm8001/pm8001_sas.h       |   8 +-
>>   drivers/scsi/pm8001/pm80xx_hwi.c       | 177 ++--------------------
>>   include/scsi/libsas.h                  |   4 -
>>   include/scsi/sas_ata.h                 |   5 +
>>   11 files changed, 132 insertions(+), 313 deletions(-)
>>
> 
> 

