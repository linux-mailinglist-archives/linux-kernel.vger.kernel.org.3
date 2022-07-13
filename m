Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3705737CE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbiGMNrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiGMNr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:47:29 -0400
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1B2105;
        Wed, 13 Jul 2022 06:47:28 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 580C9CAFC5;
        Wed, 13 Jul 2022 16:47:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1657720046;
        bh=vOOalNQ9r9QRquMExxnzKYoMS7P4s1dLtt3mNir4PW4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=ANCTOIT4KS7uvUfMlXU2CGXcGYfNwh5Rx/e/jUQUBq5fd640Fwng2rLv5tgnGGYqH
         K16LLp6tw21JrvQ5t+saL3Mn9b4j8NdM0lZjYTojFN6AEz36wfSovmzx3Wqq/Tdiz6
         2e2RcjSc71OELSYb2iZlpqdPeaj+VuJd9I5IdvgWnac/Nw50qLVkUSXJy4JoDYkG5x
         ZG/i2VgeGBkPfz1FMA05Eysy7i3QB7ZuZca4pZRCwHlVr0R35grSiQmw843ay2q+PZ
         n6o0QKUoeBD4Hcl1IrtTK13bWV4GwomlXhwkvx7DolQzGcROK2NTviyyFKJIDkBDt4
         Z3IHqVPGhR3bA==
Received: from [172.24.11.83] (172.24.11.83) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 13 Jul
 2022 15:47:23 +0200
Message-ID: <51e3fc9e-5b46-ab23-bbf8-5d0ad9dada29@veeam.com>
Date:   Wed, 13 Jul 2022 15:47:23 +0200
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
 <aec88137-070e-7c1d-215f-86a1e6d4b10a@veeam.com>
 <Ys6y1AYTl8r/i3UX@infradead.org>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <Ys6y1AYTl8r/i3UX@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.11.83]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.128.102) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50A54647160
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 13:56, Christoph Hellwig wrote:
> 
> On Fri, Jul 08, 2022 at 12:45:33PM +0200, Sergei Shtepa wrote:
>> 1. Work at the partition or disk level?
>> At the user level, programs operate with block devices.
>> In fact, the "disk" entity makes sense only for the kernel level. 
>> When the user chooses which block devices to backup and which not,
>> he operates with mounting points, which are converted into block
>> devices, partitions. Therefore, it is better to handle bio before
>> remapping to disk.
>> If the filtering is performed after remapping, then we will be
>> forced to apply a filter to the entire disk, or complicate the
>> filtering algorithm by calculating which range of sectors bio is
>> addressed to. And if bio is addressed to the partition boundary...
>> Filtering at the block device level seems to me a simpler solution.
>> But this is not the biggest problem.
> Note that bi_bdev stays for the partition things came from.  So we
> could still do filtering after blk_partition_remap has been called,
> the filter driver just needs to be careful on how to interpret the
> sector numbers.

Thanks. I'll check it out.

> 
>> 2. Can the filter sleep or postpone bio processing to the worker thread?
> I think all of te above is fine, just for normal submit_bio based
> drivers.
 
Good. But I'm starting to think that for request-based block devices,
filtering should be different. I need to check it out.

>> The problem is in the implementation of the COW algorithm.
>> If I send a bio to read a chunk (one bio), and then pass a write bio,
>> then with some probability I am reading partially overwritten data.
>> Writing overtakes reading. And flags REQ_SYNC and REQ_PREFLUSH don't help.
>> Maybe it's a disk driver issue, or a hypervisor, or a NAS, or a RAID,
>> or maybe normal behavior. I don't know. Although, maybe I'm not working
>> correctly with flags. I have seen the comments on patch 11/20, but I am
>> not sure that the fixes will solve this problem.
>> But because of this, I have to postpone the write until the read completes.
> In the I/O stack there really isn't any ordering.  While a general
> reordering looks a bit odd to be, it absolutely it always possible.
> 

Thank you!
So this is normal behavior and locking the writing is necessary.
When designing the module, I mistakenly thought that it would be enough
to set the correct order of sending bios.

>> 2.1 The easiest way to solve the problem is to block the writer's thread
>> with a semaphore. And for bio with a flag REQ_NOWAIT, complete processing
>> with bio_wouldblock_error(). This is the solution currently being used.
> This sounds ok.  The other option would be to put the write on hold and
> only queue it up from the read completion (or rather a workqueue kicked
> off from the read completion).  But this is basically the same, just
> without blocking the I/O submitter, so we could do the semaphore first
> and optimize later as needed.
> 
>> If I am blocked by the q->q_usage_counter counter, then I will not
>> be able to execute COW in the context of the current thread due to deadlocks.
>> I will have to use a scheme with an additional worker thread.
>> Bio filtering will become much more complicated.
> q_usage_counter itself doesn't really block you from doing anything.
> You can still sleep inside of it, and most driver do that.
> 
Ok. I will try to lower the handle point under the protection of the
q_usage_counter. Maybe I'm mistaken about deadlocks.

Thank you so much for the review and for the explanatory answers!
I got a lot of useful recommendations.
I have a lot of work to do to improve the patch.
