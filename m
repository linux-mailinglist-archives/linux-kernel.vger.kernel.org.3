Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D26454C2A3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241586AbiFOHcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiFOHcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:32:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2E2473A0;
        Wed, 15 Jun 2022 00:31:58 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LNH7B4jvmz6GD9p;
        Wed, 15 Jun 2022 15:31:50 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 09:31:55 +0200
Received: from [10.195.33.253] (10.195.33.253) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 08:31:54 +0100
Message-ID: <3a27b6ff-e495-8f11-6925-1487c9d14fa9@huawei.com>
Date:   Wed, 15 Jun 2022 08:35:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-4-git-send-email-john.garry@huawei.com>
 <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
 <9e89360d-3325-92af-0436-b34df748f3e2@acm.org>
 <e36bba7e-d78d-27b4-a0e2-9d921bc82f5d@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <e36bba7e-d78d-27b4-a0e2-9d921bc82f5d@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.33.253]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
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

On 15/06/2022 00:43, Damien Le Moal wrote:
> On 6/15/22 03:20, Bart Van Assche wrote:
>> On 6/13/22 00:01, Damien Le Moal wrote:
>>> On 6/9/22 19:29, John Garry wrote:
>>>> +	/*
>>>> +	 * This determines how many commands the HBA will set aside
>>>> +	 * for internal commands. This number will be added to
>>>> +	 * @can_queue to calcumate the maximum number of simultaneous
>>>
>>> s/calcumate/calculate
>>>
>>> But this is weird. For SATA, can_queue is 32. Having reserved commands,
>>> that number needs to stay the same. We cannot have more than 32 tags.
>>> I think keeping can_queue as the max queue depth with at most
>>> nr_reserved_cmds tags reserved is better.
>>>
>>>> +	 * commands sent to the host.
>>>> +	 */
>>>> +	int nr_reserved_cmds;
>>
>> +1 for Damien's request. I also prefer to keep can_queue as the maximum
>> queue depth, whether or not nr_reserved_cmds has been set.
> 
> For non SATA drives, I still think that is a good idea. However, for SATA,
> we always have the internal tag command that is special. With John's
> change, it would have to be reserved but that means we are down to 31 max
> QD,

My intention is to keep regular tag depth at 32 for SATA. We add an 
extra tag as a reserved tag. Indeed, this is called a 'tag', but it's 
just really the placeholder for what will be the ATA_TAG_INTERNAL request.

About how we set scsi_host.can_queue, in this series we set .can_queue 
as max regular tags, and the handling is as follows:

scsi_mq_setup_tags():
tag_set->queue_depth = shost->can_queue + shost->nr_reserved_cmds
tag_set->reserved_tags = shost->nr_reserved_cmds

So we honour the rule that blk_mq_tag_set.queue_depth is the total tag 
depth, including reserved.

Incidentally I think Christoph prefers to keep .can_queue at total max 
tags including reserved:
https://lore.kernel.org/linux-scsi/337339b7-6f4a-a25c-f11c-7f701b42d6a8@suse.de/

> so going backward several years... That internal tag for ATA does not
> need to be reserved since this command is always used when the drive is
> idle and no other NCQ commands are on-going.

So do you mean that ATA_TAG_INTERNAL qc is used for other commands apart 
from internal commands?

> 
> So the solution to all this is a likely a little more complicated if we
> want to keep ATA max QD to 32.
> 

thanks,
John
