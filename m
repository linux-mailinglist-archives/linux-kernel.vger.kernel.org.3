Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AC7521E17
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345495AbiEJPXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345883AbiEJPVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:21:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86DF25C4;
        Tue, 10 May 2022 08:03:10 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KyLmc46Lfz686j6;
        Tue, 10 May 2022 22:59:44 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 17:03:08 +0200
Received: from [10.47.91.186] (10.47.91.186) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 16:03:07 +0100
Message-ID: <342e131c-6906-bff8-d5ac-1c345ef81283@huawei.com>
Date:   Tue, 10 May 2022 16:03:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 0/2] sbitmap: NUMA node spreading
To:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
References: <1652181274-136198-1-git-send-email-john.garry@huawei.com>
 <1afd2c01-69b3-ab8f-6bfe-118e3e56001c@kernel.dk>
 <9ede7211-ae58-5cd4-4cf6-74c1f508f1a6@huawei.com>
 <ae314168-4cb8-cdcf-1e13-2c5f30f8f96c@kernel.dk>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <ae314168-4cb8-cdcf-1e13-2c5f30f8f96c@kernel.dk>
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

On 10/05/2022 15:34, Jens Axboe wrote:
>> Yes, there is the extra load. I would hope that there would be a low
>> cost, but I agree that we still want to avoid it. So prob no point in
>> testing this more.
> I don't think that's low cost at all. It's the very hot path, and you're
> now not only doing an extra load, it's a dependent load - you need to
> load both to make any progress. On top of that, it's not like it's two
> loads from the same cacheline or even page. The most important thing for
> performance these days is having good cache utilization, the patch as it
> stands very much makes that a lot worse.

Understood. Essentially patch #1/2 points in the wrong direction.

I have to admit that I was a bit blinkered by seeing how much I could 
improve the NUMA case.

> 
> Besides, for any kind of performance work like that, it's customary to
> showcase both the situation that is supposedly fixed or improved with
> the change, but also to test that it didn't regress the existing
> common/fast case.

Right, I should have done that.

> 
>>> It doesn't seem like a good
>>> approach for the issue, as it pessimizes the normal fast case.
>>>
>>> Spreading the memory out does probably make sense, but we need to retain
>>> the fast normal case. Making sbitmap support both, selected at init
>>> time, would be far more likely to be acceptable imho.
>> I wanted to keep the code changes minimal for an initial RFC to test
>> the water.
>>
>> My original approach did not introduce the extra load for normal path
>> and had some init time selection for a normal word map vs numa word
>> map, but the code grew and became somewhat unmanageable. I'll revisit
>> it to see how to improve that.
> Probably just needs some clean refactoring first, so that the actual
> change can be pretty small.

I think that it may be just a case of separating out the handling of 
evaluating the sbitmap_word ptr as that is that common struct which we 
deal with.

Thanks,
John
