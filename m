Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5054C50E49E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242949AbiDYPof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242960AbiDYPmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:42:39 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E5945519;
        Mon, 25 Apr 2022 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=qOtRAEm3C5wG5t8K/Uj9fxf5gkUIVX+YYzhHC9lDMn8=; b=ZRZ7wbJ8Mec5x9CRYfIChtjFB2
        DXGsKWZVcqSrnSKauH9pOgswuCuH3zkxB/UvLb3YcB73zClUt9HCScPt1EFJ8mgwozS0rJ05Cls2E
        crJVoeAa9YTh3ivUqlyT2inWa0pEgfPpI8h+ST5/rEs6sLii8kXlJf+SLdsjF953lZbkYR2zABboF
        v57FMKrMWwFvUSrL2ulSocAOLaLtamH5ZQNaibxkF6YnWpRKzYNSWc/SdiSElyxzrUxGfthhvSSwt
        3ItN6NB0pV9D4iIKpKZcqIw1aXiRPWGL6H7pKE+q0JInlqq13MYz8FCCtSFnxa0rYH9ZJlYfPCozF
        l/NQN9ow==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nj0oE-00GHH4-V3; Mon, 25 Apr 2022 09:39:32 -0600
Message-ID: <8d8fbf24-51b5-a076-b7ad-fcbb7d5c275e@deltatee.com>
Date:   Mon, 25 Apr 2022 09:39:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-CA
To:     Guoqing Jiang <guoqing.jiang@linux.dev>, Xiao Ni <xni@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220420195425.34911-1-logang@deltatee.com>
 <CALTww28fwNpm0O_jc7-2Xr0JSX9i6F1kgoUQ8m_k6ZgPa1XxXw@mail.gmail.com>
 <c14c0103-9cbd-7d0f-486b-344dd33725ab@deltatee.com>
 <4094aed9-d22d-d14f-07a7-5abe599beeab@linux.dev>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <4094aed9-d22d-d14f-07a7-5abe599beeab@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: guoqing.jiang@linux.dev, xni@redhat.com, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 00/12] Improve Raid5 Lock Contention
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-04-24 02:00, Guoqing Jiang wrote:
> 
> 
> On 4/22/22 12:02 AM, Logan Gunthorpe wrote:
>>
>> On 2022-04-21 02:45, Xiao Ni wrote:
>>> Could you share the commands to get the test result (lock contention
>>> and performance)?
>> Sure. The performance we were focused on was large block writes. So we
>> setup raid5 instances with varying number of disks and ran the following
>> fio script directly on the drive.
>>
>> [simple]
>> filename=/dev/md0
>> ioengine=libaio
>> rw=write
>> direct=1
>> size=8G
>> blocksize=2m
>> iodepth=16
>> runtime=30s
>> time_based=1
>> offset_increment=8G
>> numjobs=12
>> ￼
>> (We also played around with tuning this but didn't find substantial
>> changes once the bottleneck was hit)
> 
> Nice, I suppose other IO patterns keep the same performance as before.
> 
>> We tuned md with parameters like:
>>
>> echo 4 > /sys/block/md0/md/group_thread_cnt
>> echo 8192 > /sys/block/md0/md/stripe_cache_size
>>
>> For lock contention stats, we just used lockstat[1]; roughly like:
>>
>> echo 1 > /proc/sys/kernel/lock_stat
>> fio test.fio
>> echo 0 > /proc/sys/kernel/lock_stat
>> cat /proc/lock_stat
>>
>> And compared the before and after.
> 
> Thanks for your effort, besides the performance test, please try to run
> mdadm test suites to avoid regression.

Yeah, is there any documentation for that? I tried to look into it but
couldn't figure out how it's run.

I do know that lkp-tests has run it on this series as I did get an error
from it. But while I'm pretty sure that error has been resolved, I was
never able to figure out how to run them locally.

Thanks,

Logan
