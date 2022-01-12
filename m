Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8713948C437
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353279AbiALMvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:51:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4405 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiALMvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:51:37 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JYnRy4gY2z67vyB;
        Wed, 12 Jan 2022 20:48:46 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 13:51:35 +0100
Received: from [10.47.88.157] (10.47.88.157) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 12 Jan
 2022 12:51:33 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH -next v4] blk-mq: fix tag_get wait task can't be awakened
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        QiuLaibin <qiulaibin@huawei.com>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>,
        <johannes.thumshirn@wdc.com>, <bvanassche@acm.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220111140216.1858823-1-qiulaibin@huawei.com>
 <Yd2Q6LyJUDAU54Dt@smile.fi.intel.com>
 <d7f51067-f5a8-e78c-5ece-c1ef132b9b9a@huawei.com>
 <Yd7J4XbkdIm52bVw@smile.fi.intel.com>
Message-ID: <3d386998-d810-5036-a87e-50aba9f56639@huawei.com>
Date:   Wed, 12 Jan 2022 12:51:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <Yd7J4XbkdIm52bVw@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.88.157]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2022 12:30, Andy Shevchenko wrote:
>>>> +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
>>>> +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {
>>> Whoever wrote this code did too much defensive programming, because the first
>>> conditional doesn't make much sense here. Am I right?
>>>
>> I think because this judgement is in the general IO process, there are also
>> some performance considerations here.
> I didn't buy this. Is there any better argument why you need redundant
> test_bit() call?
> 

I think that the idea is that test_bit() is fast and test_and_set_bit() 
is slow; as such, if we generally expect the bit to be set, then there 
is no need to do the slower test_and_set_bit() always.
