Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAB25A7CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiHaL7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiHaL7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:59:43 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C75D2763;
        Wed, 31 Aug 2022 04:59:41 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9C85F61EA1935;
        Wed, 31 Aug 2022 13:59:38 +0200 (CEST)
Message-ID: <39f59994-cf2e-f8c4-fd57-988e8c7e05e5@molgen.mpg.de>
Date:   Wed, 31 Aug 2022 13:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next 0/3] md/raid10: reduce lock contention for io
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <70172016-8ae5-92b8-2a43-8f0d4a2f6668@molgen.mpg.de>
 <0e22c51b-d36a-2216-4bfd-522049d3ed44@huaweicloud.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <0e22c51b-d36a-2216-4bfd-522049d3ed44@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Yu,


Am 30.08.22 um 03:09 schrieb Yu Kuai:

> 在 2022/08/29 21:58, Paul Menzel 写道:

>> Am 29.08.22 um 15:14 schrieb Yu Kuai:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> patch 1 is a small problem found by code review.
>>> patch 2 avoid holding resync_lock in fast path.
>>> patch 3 avoid holding lock in wake_up() in fast path.
>>>
>>> Test environment:
>>>
>>> Architecture: aarch64
>>> Cpu: Huawei KUNPENG 920, there are four numa nodes
>>>
>>> Raid10 initialize:
>>> mdadm --create /dev/md0 --level 10 --bitmap none --raid-devices 4 
>>> /dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1
>>>
>>> Test cmd:
>>> fio -name=0 -ioengine=libaio -direct=1 -group_reporting=1 
>>> -randseed=2022 -rwmixread=70 -refill_buffers -filename=/dev/md0 
>>> -numjobs=16 -runtime=60s -bs=4k -iodepth=256 -rw=randread
>>>
>>> Test result:
>>> before this patchset:    2.9 GiB/s
>>> after this patchset:    6.6 Gib/s
>>
>> Could you please give more details about the test setup, like the 
>> drives used?
> 
> test setup is described above, four nvme disks is used.

I was wondering about the model to be able to reproduce it.

>> Did you use some tools like ftrace to figure out the bottleneck?
> 
> Yes, I'm sure the bottleneck is spin_lock(), specifically threads from
> multiple nodes try to grab the same lock. By the way, if I bind the
> threads to the same node, performance can also improve to 6.6 Gib/s
> without this patchset.

Interesting. Maybe you could add all that to the commit message of the 
second patch.


Kind regards,

Paul


>>> Please noted that in kunpeng-920, memory access latency is very bad
>>> accross nodes compare to local node, and in other architecture
>>> performance improvement might not be significant.
>>>
>>> Yu Kuai (3):
>>>    md/raid10: fix improper BUG_ON() in raise_barrier()
>>>    md/raid10: convert resync_lock to use seqlock
>>>    md/raid10: prevent unnecessary calls to wake_up() in fast path
>>>
>>>   drivers/md/raid10.c | 88 +++++++++++++++++++++++++++++----------------
>>>   drivers/md/raid10.h |  2 +-
>>>   2 files changed, 59 insertions(+), 31 deletions(-)
