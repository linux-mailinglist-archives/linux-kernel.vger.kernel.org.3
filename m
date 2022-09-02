Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0A25AB664
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiIBQT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiIBQTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:19:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107641ED;
        Fri,  2 Sep 2022 09:19:42 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MK34v1YjTz67NHg;
        Sat,  3 Sep 2022 00:18:55 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Sep 2022 18:19:40 +0200
Received: from [10.195.34.23] (10.195.34.23) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 2 Sep
 2022 17:19:39 +0100
Message-ID: <4b471300-a912-c3c0-ead4-7165c57cbbf8@huawei.com>
Date:   Fri, 2 Sep 2022 17:19:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
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
 <eb3465a2-335e-a605-ba8a-4cce790b5b02@huawei.com>
In-Reply-To: <eb3465a2-335e-a605-ba8a-4cce790b5b02@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.34.23]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

Hi Damien,

>>>
>>> But the pm8001 manual and current driver indicate that the
>>> OPC_INB_SATA_ABORT command should be sent after read log ext when
>>> handling NCQ error, regardless of an autopsy. I send OPC_INB_SATA_ABORT
>>> in ata_eh_reset() -> pm8001_I_T_nexus_reset() -> pm8001_send_abort_all()
>> You lost me: ata_eh_recover() will call ata_eh_reset() only if the 
>> ATA_EH_RESET
>> action flag is set. So are you saying that even though it is not 
>> needed, you
>> still need to set ATA_EH_RESET for pm8001 ?
> 
> As below, it was the only location I found suitable to call 
> pm8001_send_abort_all().
> 
> However I am not really sure it is required now. For pm8001 NCQ error 
> handling we require 2x steps:
> - read log ext
> - Send OPC_INB_SATA_ABORT - we do this in pm8001_send_abort_all()
> 
> pm8001_send_abort_all() sends OPC_INB_SATA_ABORT in "device abort all" 
> mode, meaning any IO in the HBA is aborted for the device. But we are 
> also earlier in EH sending OPC_INB_SATA_ABORT for individual IOs in 
> sas_eh_handle_sas_errors() -> sas_scsi_find_task() -> 
> pm8001_abort_task() -> sas_execute_internal_abort_single() -> ... 
> send_abort_task()
> 
> So I don't think that the pm8001_send_abort_all() call has any effect, 
> as we're already aborting any outstanding IO earlier.
> 
> Admittedly the order of the 2x steps is different, but 
> OPC_INB_SATA_ABORT does not send any protocol message to the disk, so 
> would not affect anything subsequently read with read log ext.
> 
> Having said all that, it may be wise to still send 
> pm8001_send_abort_all()..

Have you had a chance to consider all this yet?

I am now starting to think that it is not necessary to call 
pm8001_send_abort_all(), and instead rely only on 
sas_eh_handle_sas_errors() -> sas_scsi_find_task() -> 
pm8001_abort_task() -> sas_execute_internal_abort_single() -> ... -> 
send_abort_task() to abort each outstanding IO. Then we would not have 
the issue of forcing the reset in $subject (to lead to calling 
pm8001_send_abort_all()).

This idea could simply be tested by stubbing pm8001_send_abort_all()
(and dropping the |= ATA_EH_RESET in $subject).

Thanks,
John

