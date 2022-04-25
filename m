Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B73C50DBA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiDYIyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbiDYIyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:54:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095E61835F;
        Mon, 25 Apr 2022 01:51:28 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KmzFT6VJyz67yRq;
        Mon, 25 Apr 2022 16:48:45 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 10:51:26 +0200
Received: from [10.47.92.213] (10.47.92.213) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 09:51:25 +0100
Message-ID: <2843b52d-8848-45d9-13f2-2821d79689dd@huawei.com>
Date:   Mon, 25 Apr 2022 09:51:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/4] scsi: libsas: Add sas_execute_internal_abort_single()
To:     Hannes Reinecke <hare@suse.de>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Ajish.Koshy@microchip.com>, <linuxarm@huawei.com>,
        <Viswas.G@microchip.com>, <hch@lst.de>, <liuqi115@huawei.com>,
        <chenxiang66@hisilicon.com>
References: <1646309930-138960-1-git-send-email-john.garry@huawei.com>
 <1646309930-138960-2-git-send-email-john.garry@huawei.com>
 <929aede0-9e58-9c3d-5951-6151a3281edd@suse.de>
 <83328d95-5d5e-f311-952c-ce627cb035ea@huawei.com>
 <39975d62-b706-7d03-01a8-f6095c7af4ac@suse.de>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <39975d62-b706-7d03-01a8-f6095c7af4ac@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.92.213]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 09:34, Hannes Reinecke wrote:
>>>> +/* LLDDs rely on these values */
>>>> +enum sas_internal_abort {
>>>> +    SAS_INTERNAL_ABORT_SINGLE    = 0,
>>>> +};
>>>> +
>>>
>>> Why don't you use the existing TMF_XXX values here?
>>> Your 'single' method pretty much _is_ a TMF_ABORT_TASK, and the 
>>> 'device' method _is_ a TMF_ABORT_TASK_SET, no?
>>
>> Sure, they are doing the same as TMFs and there is equivalence in the 
>> 'single' and 'device' methods, as you say.
>>
>> However, as mentioned in the comment, the LLDDs rely on the values in 
>> enum sas_internal_abort, which do not match the values in 
>> TMF_ABORT{_TASK, _TASK_SET}.
>>
> How can they rely on a value which you just introduced?

I am relying on no one changing those values in enum sas_internal_abort.

Both hisi_sas and pm8001 use value of 0 for single abort and 1 for 
device abort in their own internal abort HW frames structs.

And if some other controller comes along which wants to support this 
feature and the values in enum sas_internal_abort don't match then they 
would need to do some translation.

I could use TMF values and do the translation in hisi_sas and pm8001 
drivers today, but I don't see much much gain in that.

Thanks,
John
