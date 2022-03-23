Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058914E4ED5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243020AbiCWJDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbiCWJDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:03:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326116EB0D;
        Wed, 23 Mar 2022 02:01:40 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KNj3b1ngBz67PtB;
        Wed, 23 Mar 2022 16:59:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 23 Mar 2022 10:01:37 +0100
Received: from [10.47.85.68] (10.47.85.68) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 23 Mar
 2022 09:01:36 +0000
Message-ID: <378065de-3cb8-b44f-66e9-747960bcd990@huawei.com>
Date:   Wed, 23 Mar 2022 09:01:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 01/11] blk-mq: Add blk_mq_init_queue_ops()
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>, <ming.lei@redhat.com>,
        <hare@suse.de>
CC:     <chenxiang66@hisilicon.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dm-devel@redhat.com>,
        <beanhuo@micron.com>
References: <1647945585-197349-1-git-send-email-john.garry@huawei.com>
 <1647945585-197349-2-git-send-email-john.garry@huawei.com>
 <e74776f0-505b-8b4f-effd-519bce9bdc79@acm.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <e74776f0-505b-8b4f-effd-519bce9bdc79@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.68]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 02:57, Bart Van Assche wrote:
> On 3/22/22 03:39, John Garry wrote:
>> Add an API to allocate a request queue which accepts a custom set of
>> blk_mq_ops for that request queue.
>>
>> The reason which we may want custom ops is for queuing requests which we
>> don't want to go through the normal queuing path.
> 

Hi Bart,

 > Custom ops shouldn't be required for this. See e.g. how tmf_queue
 > is used in the UFS driver for an example of a queue implementation
 > with custom operations and that does not require changes of the block
 > layer core.

The UFS code uses a private tagset (in ufs_hba.tmf_tag_set) for only 
management of TMF tags/memories. This tagset does not really have any 
custom operations. All it has is a stub of .queue_rq CB in 
ufshcd_queue_tmf() and that is because this CB is compulsory.

As for the idea of having multiple tagsets per shost with real custom 
operations, this idea was mentioned before, but I think managing 
multiple tagsets could be trouble. For a start, it would mean that we 
need a distinct allocation of reserved and regular tags, and sometimes 
we don't want this - as Hannes mentioned earlier, many HBAs have low 
queue depth and cannot afford to permanently carve out a bunch of 
reserved tags.

Thanks,
John
