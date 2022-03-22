Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F934E3E84
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiCVMcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbiCVMcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:32:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD43B7DAA9;
        Tue, 22 Mar 2022 05:30:47 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KN9kp4dxgz6H6rn;
        Tue, 22 Mar 2022 20:28:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 22 Mar 2022 13:30:44 +0100
Received: from [10.47.85.68] (10.47.85.68) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 12:30:44 +0000
Message-ID: <a5e42012-c1fc-082e-e636-594abc07dd70@huawei.com>
Date:   Tue, 22 Mar 2022 12:30:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 01/11] blk-mq: Add blk_mq_init_queue_ops()
To:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <ming.lei@redhat.com>,
        <chenxiang66@hisilicon.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dm-devel@redhat.com>,
        <beanhuo@micron.com>
References: <1647945585-197349-1-git-send-email-john.garry@huawei.com>
 <1647945585-197349-2-git-send-email-john.garry@huawei.com>
 <20220322111848.GA29270@lst.de>
 <cacc3f7b-c8be-0f72-1c52-562c15b468a4@huawei.com>
 <b5df2ef1-2d6d-340e-e4b4-09132dc0516b@suse.de>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <b5df2ef1-2d6d-340e-e4b4-09132dc0516b@suse.de>
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

On 22/03/2022 12:16, Hannes Reinecke wrote:
> On 3/22/22 12:33, John Garry wrote:
>> On 22/03/2022 11:18, Christoph Hellwig wrote:
>>> On Tue, Mar 22, 2022 at 06:39:35PM +0800, John Garry wrote:
>>>> Add an API to allocate a request queue which accepts a custom set of
>>>> blk_mq_ops for that request queue.
>>>>
>>>> The reason which we may want custom ops is for queuing requests 
>>>> which we
>>>> don't want to go through the normal queuing path.
>>>
>>> Eww.  I really do not think we should do separate ops per queue, as that
>>> is going to get us into a deep mess eventually.
>>>
>>
>> Yeah... so far (here) it works out quite nicely, as we don't need to 
>> change the SCSI blk mq ops nor allocate a scsi_device - everything is 
>> just separate.
>>
>> The other method mentioned previously was to add the request 
>> "reserved" flag and add new paths in scsi_queue_rq() et al to handle 
>> this, but that gets messy.
>>
>> Any other ideas ...?
>>
> 
> As outlined in the other mail, I think might be useful is to have a 
> _third_ type of requests (in addition to the normal and the reserved ones).
> That one would be allocated from the normal I/O pool (and hence could 
> fail if the pool is exhausted), but would be able to carry a different 
> payload (type) than the normal requests.

As mentioned in the cover letter response, it just seems best to keep 
the normal scsi_cmnd payload but have other means to add on the internal 
command data, like using host_scribble or scsi_cmnd priv data.

> And we could have a separate queue_rq for these requests, as we can 
> differentiate them in the block layer.

I don't know, let me think about it. Maybe we could add an "internal" 
blk flag, which uses a separate "internal" queue_rq callback.

Thanks,
John
