Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DF9484184
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 13:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiADMKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 07:10:24 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31068 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiADMKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 07:10:22 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JSrvL40dPz1DKST;
        Tue,  4 Jan 2022 20:06:54 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 20:10:20 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 20:10:19 +0800
Subject: Re: [PATCH] scsi: Do not break scan luns loop if add single lun
 failed
To:     Steffen Maier <maier@linux.ibm.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Nilesh Javali" <njavali@marvell.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        Hannes Reinecke <hare@suse.de>,
        Martin Wilck <martin.wilck@suse.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Benjamin Block <bblock@linux.ibm.com>,
        Ming Lei <ming.lei@redhat.com>
CC:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Feilong Lin <linfeilong@huawei.com>, Wu Bo <wubo40@huawei.com>
References: <20211225232911.1117843-1-haowenchao@huawei.com>
 <aa72bd76-2af5-202d-8a2c-afb5a700b6c0@linux.ibm.com>
From:   Wenchao Hao <haowenchao@huawei.com>
Message-ID: <3aa3ea7e-334c-6382-88f9-34eaa6b355fe@huawei.com>
Date:   Tue, 4 Jan 2022 20:10:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <aa72bd76-2af5-202d-8a2c-afb5a700b6c0@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/31 1:55, Steffen Maier wrote:
> On 12/26/21 00:29, Wenchao Hao wrote:
>> Failed to add a single lun does not mean all luns are unaccessible,
>> if we break the scan luns loop, the other luns reported by REPORT LUNS
>> command would not be probed any more.
>>
>> In this case, we might loss some luns which are accessible.
> 
> Could you please add more details about the specific use case, where 
> this actually was a problem, for my understanding?
> 

When REPORT LUNS returns 4 luns which are lun0, lun1, lun2 and lun3.
If lun1 becomes inaccessible during the scan flow, 
scsi_probe_and_add_lun() for lun1 would failed, lun2 and lun3 are still 
accessible. scsi_report_lun_scan() would print error log and return 0, 
and scsi_sequential_lun_scan() would not be called.

In this scenario, lun2 and lun3 would not been probed and added any 
more, so we loss them.

>>
>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
>> ---
>>   drivers/scsi/scsi_scan.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
>> index 23e1c0acdeae..fee7ce082103 100644
>> --- a/drivers/scsi/scsi_scan.c
>> +++ b/drivers/scsi/scsi_scan.c
>> @@ -1476,13 +1476,13 @@ static int scsi_report_lun_scan(struct 
>> scsi_target *starget, blist_flags_t bflag
>>                   lun, NULL, NULL, rescan, NULL);
>>               if (res == SCSI_SCAN_NO_RESPONSE) {
>>                   /*
>> -                 * Got some results, but now none, abort.
>> +                 * Got some results, but now none, abort this lun
> 
> abort => skip ?

Yes, "skip" looks better than "abort".

> 
>>                    */
>>                   sdev_printk(KERN_ERR, sdev,
>>                       "Unexpected response"
>>                       " from lun %llu while scanning, scan"
>>                       " aborted\n", (unsigned long long)lun);
> 
> That message would no longer be correct with your change, as it would 
> not abort the scan any more.

I would change "abort" to "skip" which makes it better.

> 
>> -                break;
>> +                continue;
>>               }
>>           }
>>       }
> 
> 
> Wouldn't this change existing semantics for LLDDs intentionally 
> returning -ENXIO from their slave_alloc() callback in certain cases?:
> 
> 

Yes, it would print error message like "Unexpected response ..." for 
every failed lun. I think it's reasonable, so we can know every failed 
lun in one scan flow.

>> static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
> ...
>>     if (shost->hostt->slave_alloc) {
>>         ret = shost->hostt->slave_alloc(sdev);
>>         if (ret) {
>>             /*
>>              * if LLDD reports slave not present, don't clutter
>>              * console with alloc failure messages
>>              */
>>             if (ret == -ENXIO)
>>                 display_failure_msg = 0;
>>             goto out_device_destroy;
> ...
>> out_device_destroy:
>>     __scsi_remove_device(sdev);
>> out:
>>     if (display_failure_msg)
>>         printk(ALLOC_FAILURE_MSG, __func__);
>>     return NULL;
> 
> 
> scsi_probe_and_add_lun() [such as called by scsi_report_lun_scan() for 
> the case at hand] converts this case into a SCSI_SCAN_NO_RESPONSE return 
> value.
> 
>> static int scsi_probe_and_add_lun(struct scsi_target *starget,
> ...
>>     int res = SCSI_SCAN_NO_RESPONSE, result_len = 256;
> ...
>>         sdev = scsi_alloc_sdev(starget, lun, hostdata);
>>     if (!sdev)
>>         goto out;
> ...
>>  out:
>>     return res;
> 
> 
> Such as being used by zfcp:
> 
>> static int zfcp_scsi_slave_alloc(struct scsi_device *sdev)
>> {
> ...
>>     unit = zfcp_unit_find(port, zfcp_scsi_dev_lun(sdev));
>>     if (unit)
>>         put_device(&unit->dev);
>>
>>     if (!unit && !(allow_lun_scan && npiv)) {
>>         put_device(&port->dev);
>>         return -ENXIO;
>                        ^^^^^^
> 
> which implements an initiator-based LUN masking that is necessary for 
> shared HBAs virtualized without NPIV.
> https://www.ibm.com/docs/en/linux-on-systems?topic=devices-manually-configured-fcp-luns 
> 
> 
> While things might still work, as zfcp now "just" gets (much) more 
> callbacks to slave_alloc() it has to end with -ENXIO, the user may get 
> flooded with the error(!) sdev_printk on "Unexpected response from LUN 
> ..." in scsi_report_lun_scan().
> In the worst case, we could get this message now 64k - 1 times in a zfcp 
> scenario connected to IBM DS8000 storage being able to map (all) 64k 
> volumes to a single initiator (HBA), where the user via zfcp sysfs 
> decided to use only the first lun reported (for the vHBA).
> 

64k - 1 times error log seems terrible. While I do not understand what 
"where the user via zfcp sysfs decided to use only the first lun 
reported (for the vHBA)" means.

Why would all luns slave_alloc() failed? This don't seem like a normal 
scenario.

> Other LLLDs also seem to intentionally return -ENXIO from slave_alloc() 
> callbacks, such as but not limited to lpfc or qla2xxx:
> 
>> int fc_slave_alloc(struct scsi_device *sdev)
>> {
>>     struct fc_rport *rport = starget_to_rport(scsi_target(sdev));
>>
>>     if (!rport || fc_remote_port_chkready(rport))
>>         return -ENXIO;
> 
>> static int
>> qla2xxx_slave_alloc(struct scsi_device *sdev)
>> {
>>     struct fc_rport *rport = starget_to_rport(scsi_target(sdev));
>>
>>     if (!rport || fc_remote_port_chkready(rport))
>>         return -ENXIO;
> 
> 

