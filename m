Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C594EB800
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 03:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241741AbiC3Bzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 21:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiC3Bzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 21:55:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A314BD890;
        Tue, 29 Mar 2022 18:54:06 -0700 (PDT)
Received: from kwepemi100021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KSqF63yszzfYkQ;
        Wed, 30 Mar 2022 09:52:26 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100021.china.huawei.com (7.221.188.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 30 Mar 2022 09:54:04 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 09:54:04 +0800
Subject: Re: [PATCH -next RFC 2/6] block: refactor to split bio thoroughly
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
CC:     <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220329094048.2107094-1-yukuai3@huawei.com>
 <20220329094048.2107094-3-yukuai3@huawei.com>
 <YkMKgwsZ3K8dRVbX@infradead.org>
 <e46db33f-84a6-6d23-9be2-7429fec71046@kernel.dk>
 <YkMabVKr+7Mg53E1@infradead.org>
 <338207c2-e3cd-abc1-6b8c-f08645ef144a@kernel.dk>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <fe6c3d68-3f44-0bf0-b43b-64f57cf83f9c@huawei.com>
Date:   Wed, 30 Mar 2022 09:54:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <338207c2-e3cd-abc1-6b8c-f08645ef144a@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
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

On 2022/03/29 22:41, Jens Axboe wrote:
> On 3/29/22 8:40 AM, Christoph Hellwig wrote:
>> On Tue, Mar 29, 2022 at 08:35:29AM -0600, Jens Axboe wrote:
>>>> But more importantly why does your use case even have splits that get
>>>> submitted together?  Is this a case of Linus' stupidly low default
>>>> max_sectors when the hardware supports more, or is the hardware limited
>>>> to a low number of sectors per request?  Or do we hit another reason
>>>> for the split?
>>>
>>> See the posted use case, it's running 512kb ios on a 128kb device.
Hi,

The problem was first found during kernel upgrade(v3.10 to v4.18), and
we maintain a series of io performance test suites, and one of the test
is fio random rw with large bs. In the environment, the 'max_sectors_kb'
is 256kb, and fio bs is 1m.
>>
>> That is an awfully low limit these days.  I'm really not sure we should
>> optimize the block layer for that.
> 
> That's exactly what my replies have been saying. I don't think this is
> a relevant thing to optimize for.

If the use case that large ios get submitted together is not a common
issue（probably not since it's been a long time without complaining),
I agree that we should not optimize the block layer for that.

Thanks,
Kuai
> 
> Fixing fairness for wakeups seems useful, however.
> 
