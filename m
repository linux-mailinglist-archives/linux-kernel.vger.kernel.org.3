Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245255511AD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239467AbiFTHkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiFTHks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:40:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AADFD12;
        Mon, 20 Jun 2022 00:40:47 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LRM323lT0z6H7t5;
        Mon, 20 Jun 2022 15:38:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 20 Jun 2022 09:40:45 +0200
Received: from [10.195.35.72] (10.195.35.72) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 20 Jun
 2022 08:40:44 +0100
Message-ID: <13b24b09-aebd-4cfc-c45a-a08ec6ead2cf@huawei.com>
Date:   Mon, 20 Jun 2022 08:40:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/4] scsi: pm8001: Use non-atomic bitmap ops for tag alloc
 + free
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hannes Reinecke <hare@suse.de>, <jinpu.wang@cloud.ionos.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Ajish.Koshy@microchip.com>
References: <1654879602-33497-1-git-send-email-john.garry@huawei.com>
 <1654879602-33497-4-git-send-email-john.garry@huawei.com>
 <303bbfad-edde-1197-679e-4a09175fb1f3@suse.de>
 <594ac0c9-a55b-bec7-77e3-a6c7e9525f6b@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <594ac0c9-a55b-bec7-77e3-a6c7e9525f6b@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.35.72]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2022 07:07, Damien Le Moal wrote:
> On 6/20/22 15:00, Hannes Reinecke wrote:
>> On 6/10/22 18:46, John Garry wrote:
>>> In pm8001_tag_alloc() we don't require atomic set_bit() as we are already
>>> in atomic context. In pm8001_tag_free() we should use the same host
>>> spinlock to protect clearing the tag (and then don't require the atomic
>>> clear_bit()).
>>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> ---
>>>    drivers/scsi/pm8001/pm8001_sas.c | 10 +++++++---
>>>    1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
>>> index 3a863d776724..8e3f2f9ddaac 100644
>>> --- a/drivers/scsi/pm8001/pm8001_sas.c
>>> +++ b/drivers/scsi/pm8001/pm8001_sas.c
>>> @@ -66,7 +66,11 @@ static int pm8001_find_tag(struct sas_task *task, u32 *tag)
>>>    void pm8001_tag_free(struct pm8001_hba_info *pm8001_ha, u32 tag)
>>>    {
>>>    	void *bitmap = pm8001_ha->tags;
>>> -	clear_bit(tag, bitmap);
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&pm8001_ha->bitmap_lock, flags);
>>> +	__clear_bit(tag, bitmap);
>>> +	spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
>>>    }
>>>    
>> This spin lock is pretty much pointless; clear_bit() is always atomic.
> 
> But __clear_bit() is not atomic. I think it was the point of this patch,
> to not use atomics and use the spinlock instead to protect bitmap.
> 
> Before the patch, pm8001_tag_alloc() takes the spinlock *and* use the
> atomic set_bit(), which is an overkill. pm8001_tag_free() only clears the
> bit using the the atomic clear_bit().

Right, so I could change to use __set_bit() in pm8001_find_tag(), but 
rather use spinlock always.

> 
> After the patch, spinlock guarantees atomicity for both alloc and free.
> 
> Not sure there is any gain from this.

A few more points to note:
- On architectures which do not support atomic operations natively, they 
have to use global spinlocks to create atomic context before doing 
non-atomic bit clearing - see atomic64.c . As such, it's better to use 
the already available pm8001_ha->bitmap_lock.
- spinlock does more than create atomic context, but also has barrier 
semantics, so proper to use consistently for protecting the same region.

Thanks,
John
