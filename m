Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED4E5AA4CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbiIBBBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbiIBBBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:01:09 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F28A59A7;
        Thu,  1 Sep 2022 18:00:59 -0700 (PDT)
Subject: Re: [PATCH -next 2/3] md/raid10: convert resync_lock to use seqlock
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662080457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7yAk3VxuKsLyw3p8RI9MaAyfnhE92URrz7dok6zTmk=;
        b=r/3L/CJXqUjk7tUdlFTR7a8Ot2uYLZ8hw4MOvErI29cFz8cWZyOYUQp5eL0ym5Rtg8CIru
        3PFZMgb3d+J+h5gzAVF3gaqWG/jRZIEJhmdxSfyRoSD7dTZw/mi13E6mHbjxd7h71cMI7m
        vlmOWZkjGksba7d5LUuCo/NU1/uapJs=
To:     Logan Gunthorpe <logang@deltatee.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <20220829131502.165356-3-yukuai1@huaweicloud.com>
 <04128618-962f-fd4e-64a9-09ecf7f83776@deltatee.com>
 <917c01c1-1e2b-66f9-69f1-ed706b7ffc8f@linux.dev>
 <cd0170a7-86ab-ebb3-0aed-93b2e18be432@deltatee.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <8b21f188-78ef-edbb-d2eb-3a9d74a6e84d@linux.dev>
Date:   Fri, 2 Sep 2022 09:00:54 +0800
MIME-Version: 1.0
In-Reply-To: <cd0170a7-86ab-ebb3-0aed-93b2e18be432@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/22 8:56 AM, Logan Gunthorpe wrote:
>
> On 2022-09-01 18:49, Guoqing Jiang wrote:
>>
>> On 9/2/22 2:41 AM, Logan Gunthorpe wrote:
>>> Hi,
>>>
>>> On 2022-08-29 07:15, Yu Kuai wrote:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> Currently, wait_barrier() will hold 'resync_lock' to read
>>>> 'conf->barrier',
>>>> and io can't be dispatched until 'barrier' is dropped.
>>>>
>>>> Since holding the 'barrier' is not common, convert 'resync_lock' to use
>>>> seqlock so that holding lock can be avoided in fast path.
>>>>
>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> I've found some lockdep issues starting with this patch in md-next while
>>> running mdadm tests (specifically 00raid10 when run about 10 times in a
>>> row).
>>>
>>> I've seen a couple different lock dep errors. The first seems to be
>>> reproducible on this patch, then it possibly changes to the second on
>>> subsequent patches. Not sure exactly.
>> That's why I said "try mdadm test suites too to avoid regression." ...
> You may have to run it multiple times, a single run tends not to catch
> all errors. I had to loop the noted test 10 times to be sure I hit this
> every time when I did the simple bisect.
>
> And ensure that all the debug options are on when you run it (take a
> look at the Kernel Hacking section in menuconfig). You won't hit this
> bug without at least CONFIG_PROVE_LOCKING=y.

Yes,  we definitely need to enable the option to test change for locking 
stuffs.

Thanks,
Guoqing
