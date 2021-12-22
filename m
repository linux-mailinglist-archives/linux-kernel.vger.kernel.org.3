Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D4947D1BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbhLVMeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:34:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4320 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240438AbhLVMeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:34:17 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JJt4n5wLhz67p89;
        Wed, 22 Dec 2021 20:32:25 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 13:34:14 +0100
Received: from [10.195.32.222] (10.195.32.222) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 12:34:14 +0000
Subject: Re: [PATCH RFT] blk-mq: optimize queue tag busy iter for shared_tags
To:     Kashyap Desai <kashyap.desai@broadcom.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
References: <20211221123157.14052-1-kashyap.desai@broadcom.com>
 <e9174a89-b3a4-d737-c5a9-ff3969053479@huawei.com>
 <7028630054e9cd0e8c84670a27c2b164@mail.gmail.com>
 <e7288bcd-cc4d-8f57-a0c8-eadd53732177@huawei.com>
 <c26b40bac76ec1bfbab2419aece544ca@mail.gmail.com>
 <e50cfdcd-110b-d778-6e3f-edfed9b1c5a4@huawei.com>
 <c3bfc0c83a3a4727b364505e4a4f1332@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <40a72c28-dd49-b1d6-59aa-79399a3d66c9@huawei.com>
Date:   Wed, 22 Dec 2021 12:34:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <c3bfc0c83a3a4727b364505e4a4f1332@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.195.32.222]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2021 12:06, Kashyap Desai wrote:
>> But I did not think that my patch would help mpi3mr since it does not use
>> host_tagset.
> Internally we are testing performance check for mpi3mr. We want to make sure
> performance is not impacted due to shared host_tagset before we apply the
> feature.

Hmmm... I thought that you said previously that it was not necessary for 
this HW. But I am not familiar with the driver or HW.

As an aside, I assume that this driver uses none IO sched by default, 
but drivers using host_tagset use mq-deadline – I’m not sure if that is 
what you want.

> 
>>> We can drop
>>> request of this RFT since I tested above series and it serve the same
>>> purpose.
>> ok, fine.
>>
>> And just to confirm, do you now think that we need to fix any older kernel
>> with some backport of my changes? I think that we would just need to
>> consider 5.16 (when it becomes stable), 5.15, and and 5.10
> It need full patch set (below) + associated fixes.
> [1] " blk-mq: Use shared tags for shared sbitmap support" Commit -
> e155b0c238b20f0a866f4334d292656665836c8a
> 
> Below commit cannot go to stable without [1].
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.17/block&id=fea9f92f1748083cb82049ed503be30c3d3a9b69
> 
> I am not sure if stable requirement fits in this case. I mean large
> patch-set is OK ?

The two other patches in the series wouldn't need to be backported, so 
it should be possible. You would just need a very good reason, though. 
And we would need to know whether 5.10 and 5.15 are required - they use 
shared sbitmap. As I mentioned a few times, contention in 
blk_mq_queue_tag_busy_iter() and callees would not be so high as 
blk_mq_tags.lock and blk_mq_tags.rqs are not shared there.

Thanks,
John



