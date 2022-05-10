Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E9A521C57
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344438AbiEJOfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245481AbiEJOJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:09:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C76D326EC;
        Tue, 10 May 2022 06:44:39 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KyK2d3mmXz67xBy;
        Tue, 10 May 2022 21:41:45 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 15:44:36 +0200
Received: from [10.47.91.186] (10.47.91.186) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 14:44:36 +0100
Message-ID: <9ede7211-ae58-5cd4-4cf6-74c1f508f1a6@huawei.com>
Date:   Tue, 10 May 2022 14:44:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [RFC PATCH 0/2] sbitmap: NUMA node spreading
To:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
References: <1652181274-136198-1-git-send-email-john.garry@huawei.com>
 <1afd2c01-69b3-ab8f-6bfe-118e3e56001c@kernel.dk>
In-Reply-To: <1afd2c01-69b3-ab8f-6bfe-118e3e56001c@kernel.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.186]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 13:50, Jens Axboe wrote:
>> fio config:
>> bs=4096, iodepth=128, numjobs=10, cpus_allowed_policy=split, rw=read,
>> ioscheduler=none
>>
>> Before:
>> 7130K
>>
>> After:
>> 7630K
>>
>> So a +7% IOPS gain.

Thanks for having a look.

> What does the comparison run on a non-NUMA non-shared queue look like?
> Because I bet it'd be slower.

I could test more to get a solid result for that.

> 
> To be honest, I don't like this approach at all. It makes the normal
> case quite a bit slower by having an extra layer of indirection for the
> word, that's quite a bit of extra cost.

Yes, there is the extra load. I would hope that there would be a low 
cost, but I agree that we still want to avoid it. So prob no point in 
testing this more.

> It doesn't seem like a good
> approach for the issue, as it pessimizes the normal fast case.
> 
> Spreading the memory out does probably make sense, but we need to retain
> the fast normal case. Making sbitmap support both, selected at init
> time, would be far more likely to be acceptable imho.

I wanted to keep the code changes minimal for an initial RFC to test the 
water.

My original approach did not introduce the extra load for normal path 
and had some init time selection for a normal word map vs numa word map, 
but the code grew and became somewhat unmanageable. I'll revisit it to 
see how to improve that.

Cheers,
john
