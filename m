Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782AB50D062
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 10:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbiDXID3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 04:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbiDXID1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 04:03:27 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F8B3524B;
        Sun, 24 Apr 2022 01:00:27 -0700 (PDT)
Subject: Re: [PATCH v2 00/12] Improve Raid5 Lock Contention
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650787222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gLLGzwk8fcXEWz+exNqSl7CbwMy3y1DnQlR3cQo6pOM=;
        b=kxd5j0CDABqAmfdF5I1+eE0CSu2jldOESNMCBSr5p2ePClJy+932zJZLSSyYPFhc8RpLLH
        sDVHG4pYUhd2jvjUF+y3sybLkSQgSooy1HP0Wi9/GzARheb7uyTNX1CDttD7pFpbkWFBIF
        UVXImihoFCh2w4CJNBGWmxXLUxg/kXI=
To:     Logan Gunthorpe <logang@deltatee.com>, Xiao Ni <xni@redhat.com>
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <4094aed9-d22d-d14f-07a7-5abe599beeab@linux.dev>
Date:   Sun, 24 Apr 2022 16:00:15 +0800
MIME-Version: 1.0
In-Reply-To: <c14c0103-9cbd-7d0f-486b-344dd33725ab@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/22 12:02 AM, Logan Gunthorpe wrote:
>
> On 2022-04-21 02:45, Xiao Ni wrote:
>> Could you share the commands to get the test result (lock contention
>> and performance)?
> Sure. The performance we were focused on was large block writes. So we
> setup raid5 instances with varying number of disks and ran the following
> fio script directly on the drive.
>
> [simple]
> filename=/dev/md0
> ioengine=libaio
> rw=write
> direct=1
> size=8G
> blocksize=2m
> iodepth=16
> runtime=30s
> time_based=1
> offset_increment=8G
> numjobs=12
> ￼
> (We also played around with tuning this but didn't find substantial
> changes once the bottleneck was hit)

Nice, I suppose other IO patterns keep the same performance as before.

> We tuned md with parameters like:
>
> echo 4 > /sys/block/md0/md/group_thread_cnt
> echo 8192 > /sys/block/md0/md/stripe_cache_size
>
> For lock contention stats, we just used lockstat[1]; roughly like:
>
> echo 1 > /proc/sys/kernel/lock_stat
> fio test.fio
> echo 0 > /proc/sys/kernel/lock_stat
> cat /proc/lock_stat
>
> And compared the before and after.

Thanks for your effort, besides the performance test, please try to run
mdadm test suites to avoid regression.

Thanks,
Guoqing
