Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44070523007
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbiEKJ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiEKJ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:57:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58BB55206;
        Wed, 11 May 2022 02:57:34 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kyqvy2VTTz67bNK;
        Wed, 11 May 2022 17:52:46 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 11 May 2022 11:57:32 +0200
Received: from [10.47.91.186] (10.47.91.186) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 10:57:31 +0100
Message-ID: <40fd1cc9-15b9-719c-8b8d-118cb156729f@huawei.com>
Date:   Wed, 11 May 2022 10:57:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 0/2] sbitmap: NUMA node spreading
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
References: <1652181274-136198-1-git-send-email-john.garry@huawei.com>
 <1afd2c01-69b3-ab8f-6bfe-118e3e56001c@kernel.dk>
 <9ede7211-ae58-5cd4-4cf6-74c1f508f1a6@huawei.com> <YnsaRXzKR5FKjC66@T590>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <YnsaRXzKR5FKjC66@T590>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.186]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 03:07, Ming Lei wrote:

Hi Ming,

>>> Spreading the memory out does probably make sense, but we need to retain
>>> the fast normal case. Making sbitmap support both, selected at init
>>> time, would be far more likely to be acceptable imho.
>> I wanted to keep the code changes minimal for an initial RFC to test the
>> water.
>>
>> My original approach did not introduce the extra load for normal path and
>> had some init time selection for a normal word map vs numa word map, but the
>> code grew and became somewhat unmanageable. I'll revisit it to see how to
>> improve that.
> I understand this approach just splits shared sbitmap into per-numa-node
> part, but what if all IOs are just from CPUs in one same numa node? Doesn't
> this way cause tag starvation and waste?
> 

We would not do this. If we can't find a free bit in one node then we 
need to check the others before giving up. This is some of the added 
complexity which I hinted at. And things like batch get or RR support 
become more complex.

Alternatively we could have the double pointer for numa spreading only, 
which would make things simpler. I need to check which is overall 
better. Adding the complexity for dealing with numa node sub-arrays may 
affect performance also.

Thanks,
John
