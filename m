Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5F256B779
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbiGHKps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbiGHKpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:45:41 -0400
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8118CBCA2;
        Fri,  8 Jul 2022 03:45:40 -0700 (PDT)
Received: from usmail.veeam.com (colmbx01.amust.local [172.18.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 15FDBCAFE8;
        Fri,  8 Jul 2022 13:45:38 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1657277138;
        bh=k2p6iW/otqptBXt9uJxTJ4gF8hPp0GmsUJIZED0Kuyw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=SgnCWTylYFEM7XR76ykdZWr6D8DR5JvUr6+5ehgeWqloMfenVqjC/jJJ8M3f3l5zM
         K3F52Knpc5ohgX66UT2STyHHgaZT6iwKbYDI6ioQoFYZHXTkSLAT6NcFynPhBjuWgz
         qmrjk8uAAomfVthSHP2o11f9/ZCKosAgMl52IxwVPuNJrKfJUmVjd5CmPdWpBpHbSg
         T/zoL+kWCm14NzEpf97qU56KORa+HbGthQwHFgSse/GaWB0gXbDfBvd3CNdSz8PdwM
         1nD2jMR0Qy243vfcDc62dx8OvB2xjZ6jtjrHaiqMZ4CeCzBXJmdBLzuozGqQOO43TO
         imAfrkj5uyCDg==
Received: from [172.24.11.83] (172.24.11.83) by colmbx01.amust.local
 (172.18.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 8 Jul 2022
 06:45:35 -0400
Message-ID: <aec88137-070e-7c1d-215f-86a1e6d4b10a@veeam.com>
Date:   Fri, 8 Jul 2022 12:45:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/20] block, blk_filter: enable block device filters
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-2-git-send-email-sergei.shtepa@veeam.com>
 <YsWHHcCfSVFklh4M@infradead.org>
 <ff78a1ee-8bc5-6e8e-040f-978cd07eacfe@veeam.com>
 <YscXTGXumE5Ust15@infradead.org>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <YscXTGXumE5Ust15@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.11.83]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 colmbx01.amust.local (172.18.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29078F7554657D6B
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/22 19:26, Christoph Hellwig wrote:
> 
> On Thu, Jul 07, 2022 at 10:26:55AM +0200, Sergei Shtepa wrote:
>> Thank you, Christoph, for your attention to the patch.
>>
>> I am preparing the next version of the patch. In it, I planned to
>> simplify the bdev_filer code.
>> I will make changes in it, in accordance with your comments, and
>> will add your code and check it on my test labs.
>>
>> But I'm not sure if using the blk_mq_freeze_queue() is appropriate.
>> If I understood the code correctly, it is based on the expectation
>> that the counter q->q_usage_counter will decrease to zero.
>> To increase it, a blk_queue_enter() is used. And at the time of
>> calling the filter_bio() in the submit_bio_noacct(), this counter
>> has not yet been increased. I will double check this and try to
>> get rid of the bdev->bd_filter_lock.
> Indeed.  For this to work we'd need to call the filter driver
> later.  Which is brings up another question:  Is there a real
> need to attach the filter driver to the bdev and thus potentially
> partition?  The rest of the block layer operates on the whole disk
> after the intial partition remapping, and besides allowing the
> filter driver to be called under q_usage_counter, this would
> also clean up some concepts.  It would probably also allow to
> remove the repeat return value over just using submit_bio_noacct
> similar to how normal stacking drivers reinject bios.
> 

Thank you Christoph.
This is the most crucial question for the entire patch.
The filtering location sets restrictions for the filter code and
determines its main algorithm.

1. Work at the partition or disk level?
At the user level, programs operate with block devices.
In fact, the "disk" entity makes sense only for the kernel level. 
When the user chooses which block devices to backup and which not,
he operates with mounting points, which are converted into block
devices, partitions. Therefore, it is better to handle bio before
remapping to disk.
If the filtering is performed after remapping, then we will be
forced to apply a filter to the entire disk, or complicate the
filtering algorithm by calculating which range of sectors bio is
addressed to. And if bio is addressed to the partition boundary...
Filtering at the block device level seems to me a simpler solution.
But this is not the biggest problem.

2. Can the filter sleep or postpone bio processing to the worker thread?
The problem is in the implementation of the COW algorithm.
If I send a bio to read a chunk (one bio), and then pass a write bio,
then with some probability I am reading partially overwritten data.
Writing overtakes reading. And flags REQ_SYNC and REQ_PREFLUSH don't help.
Maybe it's a disk driver issue, or a hypervisor, or a NAS, or a RAID,
or maybe normal behavior. I don't know. Although, maybe I'm not working
correctly with flags. I have seen the comments on patch 11/20, but I am
not sure that the fixes will solve this problem.
But because of this, I have to postpone the write until the read completes.

2.1 The easiest way to solve the problem is to block the writer's thread
with a semaphore. And for bio with a flag REQ_NOWAIT, complete processing
with bio_wouldblock_error(). This is the solution currently being used.

2.2 Another solution is possible without putting the thread into a sleep
state, but with placing a write bio in a queue to another thread.
This solution is used in the veeamsnap out-of-tree module and it has
performance issues. I don't like. But when handling make_request_fn,
which was on kernels before 5.10, there was no choice.

The current implementation, when the filtering is performed before
remapping, allows to handle the bio to the partition, and allows to
switch the writer's thread to the sleep state.
I had to pay for it with a reference counter on the filter and a spinlock.
It may be possible to do better with RCU. I haven't tried it yet.

If I am blocked by the q->q_usage_counter counter, then I will not
be able to execute COW in the context of the current thread due to deadlocks.
I will have to use a scheme with an additional worker thread.
Bio filtering will become much more complicated.

From an architectural point of view, I see the filter as an intermediate
layer between the file system and the block layer. If we lower the filter
deep into the block layer, then restrictions will be imposed on its use.

