Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE0C54CA07
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241515AbiFONlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiFONlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:41:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051F037A3A;
        Wed, 15 Jun 2022 06:41:51 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LNRFp14TFz688JQ;
        Wed, 15 Jun 2022 21:38:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 15:41:48 +0200
Received: from [10.202.227.197] (10.202.227.197) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 14:41:47 +0100
Message-ID: <56cd28b3-da05-7737-c053-3c28459581e4@huawei.com>
Date:   Wed, 15 Jun 2022 14:44:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC v2 02/18] scsi: core: Resurrect
 scsi_{get,free}_host_dev()
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <brking@us.ibm.com>, <hare@suse.de>,
        <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-3-git-send-email-john.garry@huawei.com>
 <b61d3687-70ea-1ab7-63e1-44e381d36012@acm.org>
In-Reply-To: <b61d3687-70ea-1ab7-63e1-44e381d36012@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.197]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2022 20:33, Bart Van Assche wrote:

Hi Bart,

> On 6/9/22 03:29, John Garry wrote:
>> +/**
>> + * scsi_get_host_dev - Create a scsi_device that points to the host 
>> adapter itself
>                                                 
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> What does this mean? That part of the function description is not
> clear to me.
> 

Agreed, this text is just as it was before (it was originally deleted) 
but I can fix it up to make sense.

>> + * @shost: Host that needs a scsi_device
>                                ^^^^^^^^^^^^^
> This is not detailed enough. Consider changing "a scsi_device" into
> "a scsi device for allocating reserved commands from".
> 
>> + *
>> + * Lock status: None assumed.
>> + *
>> + * Returns:     The scsi_device or NULL
>> + *
>> + * Notes:
>> + *    Attach a single scsi_device to the Scsi_Host - this should
>> + *    be made to look like a "pseudo-device" that points to the
>> + *    HA itself.
>> + *
>> + *    Note - this device is not accessible from any high-level
>> + *    drivers (including generics), which is probably not
>> + *    optimal.  We can add hooks later to attach.
> 
> The "which is probably not optimal. We can add hooks later to attach."
> part probably should be moved to the patch description.

ok

> 
>> + */
>> +struct scsi_device *scsi_get_host_dev(struct Scsi_Host *shost)
>> +{
>> +    struct scsi_device *sdev = NULL;
>> +    struct scsi_target *starget;
>> +
>> +    mutex_lock(&shost->scan_mutex);
>> +    if (!scsi_host_scan_allowed(shost))
>> +        goto out;
>> +    starget = scsi_alloc_target(&shost->shost_gendev, 0, 
>> shost->this_id);
>                                                            
> ^^^^^^^^^^^^^^^^^^
> Is it guaranteed that this channel / id combination will not be used for
> any other SCSI device?

Does it matter if the parent device is different?

> 
> What if shost->this_id == -1?
> 
>> +    if (!starget)
>> +        goto out;
>> +
>> +    sdev = scsi_alloc_sdev(starget, 0, NULL);
>> +    if (sdev)
>> +        sdev->borken = 0;
>> +    else
>> +        scsi_target_reap(starget);
>> +    put_device(&starget->dev);
>> + out:
>> +    mutex_unlock(&shost->scan_mutex);
>> +    return sdev;
>> +}
>> +EXPORT_SYMBOL(scsi_get_host_dev);
> 
> Elsewhere in the SCSI core "get..dev" means increment the reference 
> count of
> a SCSI device. Maybe scsi_alloc_host_dev() is a better name?

I think that the intention is to only use this once for a shost, i.e. 
get or allocate that scsi_device once and use it for the lifetime of the 
shost. But I can rename if you think it's better.

> 
>> +/*
>> + * These two functions are used to allocate and free a pseudo device
>> + * which will connect to the host adapter itself rather than any
>> + * physical device.  You must deallocate when you are done with the
>> + * thing.  This physical pseudo-device isn't real and won't be available
>> + * from any high-level drivers.
>> + */
> 
> Please keep function comments in .c files because that makes it more likely
> that the comment and the implementation will remain in sync.
> 

fine, I can relocate this.

Thanks,
John
