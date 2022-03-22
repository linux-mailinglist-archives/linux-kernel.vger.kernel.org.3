Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2466A4E3E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiCVMSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiCVMSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:18:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F14B6AA7F;
        Tue, 22 Mar 2022 05:17:08 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KN9R30Xy3z686wW;
        Tue, 22 Mar 2022 20:14:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 13:17:05 +0100
Received: from [10.47.85.68] (10.47.85.68) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 12:17:04 +0000
Message-ID: <9ab30c12-4451-d96a-f3de-5b883a92aed5@huawei.com>
Date:   Tue, 22 Mar 2022 12:17:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC 00/11] blk-mq/libata/scsi: SCSI driver tagging
 improvements
To:     Hannes Reinecke <hare@suse.de>, <axboe@kernel.dk>,
        <damien.lemoal@opensource.wdc.com>, <bvanassche@acm.org>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hch@lst.de>,
        <ming.lei@redhat.com>
CC:     <chenxiang66@hisilicon.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dm-devel@redhat.com>,
        <beanhuo@micron.com>
References: <1647945585-197349-1-git-send-email-john.garry@huawei.com>
 <1537235d-ac22-6914-4b31-4482e9536098@suse.de>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <1537235d-ac22-6914-4b31-4482e9536098@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.85.68]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 11:30, Hannes Reinecke wrote:
> On 3/22/22 11:39, John Garry wrote:
>> Currently SCSI low-level drivers are required to manage tags for commands
>> which do not come via the block layer - libata internal commands would be
>> an example of one of these.
>>
>> There was some work to provide "reserved commands" support in such series
>> as 
>> https://lore.kernel.org/linux-scsi/20211125151048.103910-1-hare@suse.de/
>>
>> This was based on allocating a request for the lifetime of the "internal"
>> command.
>>
>> This series tries to solve that problem by not just allocating the 
>> request
>> but also sending it through the block layer, that being the normal flow
>> for a request. We need to do this as we may only poll completion of
>> requests through the block layer, so would need to do this for poll queue
>> support.
>>
>> There is still scope to allocate commands just to get a tag as token as
>> that may suit some other scenarios, but it's not what we do here.
>>
>> This series extends blk-mq to support a request queue having a custom set
>> of ops. In addition SCSI core code adds support for these type of 
>> requests.
>>
>> This series does not include SCSI core handling for enabling reserved
>> tags per tagset, but that would be easy to add.
>>
>> Based on mkp-scsi 5.18/scsi-staging @ 66daf3e6b993
>>
>> Please consider as an RFC for now. I think that the libata change has the
>> largest scope for improvement...
>>
> 
> Grand seeing that someone is taking it up. Thanks for doing this!
> 
> But:
> Allocating a queue for every request (eg in patch 3) is overkill. If we 
> want to go that route we should be allocating the queue upfront (eg when 
> creating the device itself), and then just referencing it.

For patch #3 I needed to allocate a separate request queue as the scsi 
device is not created by that stage.

And then for other scenarios in which we allocate the separate request 
queue, since the scheme here is to allocate a request queue with 
different ops, we can't use the same scsi_device request queue.

note: As for allocating request queues for the lifetime of the host, we 
need to remember that blk-mq fairly reserves a tag budget per request 
queue, and it would be a waste to keep a budget just for these internal 
commands. So that is why I only keep the request queues temporarily.

> 
> However, can't say I like this approach. I've been playing around with 
> supporting internal commands, and really found two constraints really 
> annoying:
> 
> - The tagset supports only _one_ set of payload via
>    blk_mq_rq_(to,from)_pdu().
> This requires each request to be of the same type, and with that making
> it really hard for re-purposing the request for internal usage. In the
> end I settled by just keeping it and skipping the SCSI command field.

That sounds reasonable.

For this series I am just fixing up libsas, and libsas has a sas_task 
per command already, so we can just allocate the sas_task separately and 
use the host_scribble to point to the sas_task.

> If we could have a distinct PDU type for internal commands I guess 
> things would be easier.

Other drivers can do something similar to above or use the scsi priv data.

> 
> - The number of reserved commands is static.
> With that it's getting really hard using reserved commands with 
> low-queue depth devices like ATA; we only have 31 commands to work with, 
> and setting one or two aside for TMF is really making a difference 
> performance wise. It would be _awesome_ if we could allocate reserved 
> commands dynamically (ie just marking a command as 'reserved' once 
> allocated).

I see. So you want to allocate a request, mark as "internal", and then 
we have a flag which can be used to decide which path we need to send it 
on. eh, maybe scsi_cmnd.submitter could be used

> Sure, it won't have the same guarantees as 'real' reserved commands, but 
> in most cases we don't actually need that.
> 
> Maybe these are some lines we could investigate?
> Hmm?
> 

Thanks,
John
