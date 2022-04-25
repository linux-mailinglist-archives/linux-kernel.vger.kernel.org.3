Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00E750E488
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242884AbiDYPkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239039AbiDYPkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:40:12 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5FE1C118;
        Mon, 25 Apr 2022 08:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=WSBP0lL4ZxsD/S52QMFKfvBtMxzOVM8DW0FzyMIL2N0=; b=ZPT8mymtViz6khblRWZPsoAZ+S
        fhl9v5tQMg2oGPBmwHYwb6DMdkGEUop1DTvDlWqi/gcFT/LPsRehwEQqAa7SfhL323lqGqfzdwu3B
        eAEG5qVNNoqVe2XtCeAUE0tX7FWIdqoj0ZsGk6EYDJLzCX7WxOb9oyAjWSGxypylFtrIW1JL7bzQG
        5lJCdXPr5zSzcbYjvjdRf0LUA5ed2ELD9qJ53KaFzFr4LU4B4wOOcn9R4qBmQii48tn/YDMLuX1y6
        W1mLjctHrX82SxLkw5hPcVrxWC5TPqvmCUbtp9JZ93gLDf2JJQlyWxThkmOLP63bAmRGK2fac89a/
        BGAjLgLQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nj0lr-00GHEE-H9; Mon, 25 Apr 2022 09:37:04 -0600
Message-ID: <7d69497a-cd2a-bf4e-c185-ebdba70e9937@deltatee.com>
Date:   Mon, 25 Apr 2022 09:37:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-CA
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220420195425.34911-1-logang@deltatee.com>
 <243b3e7f-1fa1-700c-a850-caaf45d95cde@linux.dev>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <243b3e7f-1fa1-700c-a850-caaf45d95cde@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: guoqing.jiang@linux.dev, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
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



On 2022-04-24 01:53, Guoqing Jiang wrote:
> 
> 
> On 4/21/22 3:54 AM, Logan Gunthorpe wrote:
>> Hi,
>>
>> This is v2 of this series which addresses Christoph's feedback and
>> fixes some bugs. The first posting is at [1]. A git branch is
>> available at [2].
>>
>> --
>>
>> I've been doing some work trying to improve the bulk write performance
>> of raid5 on large systems with fast NVMe drives. The bottleneck appears
>> largely to be lock contention on the hash_lock and device_lock. This
>> series improves the situation slightly by addressing a couple of low
>> hanging fruit ways to take the lock fewer times in the request path.
>>
>> Patch 9 adjusts how batching works by keeping a reference to the
>> previous stripe_head in raid5_make_request(). Under most situtations,
>> this removes the need to take the hash_lock in stripe_add_to_batch_list()
>> which should reduce the number of times the lock is taken by a factor of
>> about 2.
>>
>> Patch 12 pivots the way raid5_make_request() works. Before the patch, the
>> code must find the stripe_head for every 4KB page in the request, so each
>> stripe head must be found once for every data disk. The patch changes this
>> so that all the data disks can be added to a stripe_head at once and the
>> number of times the stripe_head must be found (and thus the number of
>> times the hash_lock is taken) should be reduced by a factor roughly equal
>> to the number of data disks.
>>
>> The remaining patches are just cleanup and prep patches for those two
>> patches.
>>
>> Doing apples to apples testing this series on a small VM with 5 ram
>> disks, I saw a bandwidth increase of roughly 14% and lock contentions
>> on the hash_lock (as reported by lock stat) reduced by more than a factor
>> of 5 (though it is still significantly contended).
>>
>> Testing on larger systems with NVMe drives saw similar small bandwidth
>> increases from 3% to 20% depending on the parameters. Oddly small arrays
>> had larger gains, likely due to them having lower starting bandwidths; I
>> would have expected larger gains with larger arrays (seeing there
>> should have been even fewer locks taken in raid5_make_request()).
>>
>> Logan
>>
>> [1] https://lkml.kernel.org/r/20220407164511.8472-1-logang@deltatee.com
>> [2] https://github.com/sbates130272/linux-p2pmem raid5_lock_cont_v2
>>
>> --
>>
>> Changes since v1:
>>    - Rebased on current md-next branch (190a901246c69d79)
>>    - Added patch to create a helper for checking if a sector
>>      is ahead of the reshape (per Christoph)
>>    - Reworked the __find_stripe() patch to create a find_get_stripe()
>>      helper (per Christoph)
>>    - Added more patches to further refactor raid5_make_request() and
>>      pull most of the loop body into a helper function (per Christoph)
>>    - A few other minor cleanups (boolean return, droping casting when
>>      printing sectors, commit message grammar) as suggested by Christoph.
>>    - Fixed two uncommon but bad data corruption bugs in that were found.
>>
>> --
>>
>> Logan Gunthorpe (12):
>>    md/raid5: Factor out ahead_of_reshape() function
>>    md/raid5: Refactor raid5_make_request loop
>>    md/raid5: Move stripe_add_to_batch_list() call out of add_stripe_bio()
>>    md/raid5: Move common stripe count increment code into __find_stripe()
>>    md/raid5: Factor out helper from raid5_make_request() loop
>>    md/raid5: Drop the do_prepare flag in raid5_make_request()
>>    md/raid5: Move read_seqcount_begin() into make_stripe_request()
>>    md/raid5: Refactor for loop in raid5_make_request() into while loop
>>    md/raid5: Keep a reference to last stripe_head for batch
>>    md/raid5: Refactor add_stripe_bio()
>>    md/raid5: Check all disks in a stripe_head for reshape progress
>>    md/raid5: Pivot raid5_make_request()
> 
> Generally, I don't object the cleanup patches since the code looks more 
> cleaner.
> But my concern is that since some additional function calls are added to 
> hot path
> (raid5_make_request), could the performance be affected?

There's a bit of logic added to the raid5_make_requests but it is all
local and should be fast, and it reduces the amount of calls to the slow
contended locks.

> And I think patch 9 and patch 12 are helpful for performance 
> improvement,  did
> you measure the performance without those cleanup patches?

Yes, I compared performance with and without this entire series.

Logan
