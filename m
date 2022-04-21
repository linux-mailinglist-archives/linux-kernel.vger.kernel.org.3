Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9A650AA41
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392533AbiDUUqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349411AbiDUUqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:46:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55104E391
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:43:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650573788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3UrvlJKlRiA3m0EXXHhSv7iD9kIffu4f0EGmLxSXPIk=;
        b=ztR2NfvZSvxu/uagLed4yJhw6bpakHq6GeSfdN4jwD/F2tFpS55DzkGnegRCl8hWSShKMq
        /+5bvzRBuQVdDp2G/3XnZCLH5dZLzs6u/4Mi1UkcWhxC/qWyJ2yJk7KoFIsgSeiWfnszHL
        5VMnzIvK+dDYit12PAjzrTsLZZdQTEDUgbIvlDLpVBoUTwYZ0Cn01p8PBM2JgOVotCC5Xf
        Ldg4v0V1RW2YrHU2gFhj3AJrkN3C8J3lzBkN10m33tGumKbk9XX3AYLmpvUJADviYH67ve
        aFEQP5OZvWjgMeCdbKVwtHdfE63a1xXlxbwhZJOgqsiPFU4DJuRyRCm+XOu49Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650573788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3UrvlJKlRiA3m0EXXHhSv7iD9kIffu4f0EGmLxSXPIk=;
        b=/85QIqA89yp1qYgcrfqmxPZVhd77+bk+Hs6XBh5HWyg9iW645ZxNS9WK/IXxqsSwHwBiQA
        NN0/MJYQs3ZHoqAA==
To:     Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
Subject: Re: [PATCH v9] oom_kill.c: futex: Delay the OOM reaper to allow
 time for proper futex cleanup
In-Reply-To: <5653e751-f81d-f64e-b4b5-b251949d13d9@redhat.com>
References: <20220414144042.677008-1-npache@redhat.com>
 <874k2mts8p.ffs@tglx> <5653e751-f81d-f64e-b4b5-b251949d13d9@redhat.com>
Date:   Thu, 21 Apr 2022 22:43:07 +0200
Message-ID: <87tuamrwv8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21 2022 at 12:25, Nico Pache wrote:
> On 4/21/22 10:40, Thomas Gleixner wrote:
>>> Reproducer: https://gitlab.com/jsavitz/oom_futex_reproducer
>>>
>>> [1] https://elixir.bootlin.com/glibc/latest/source/nptl/allocatestack.c#L370
>> 
>> A link to the original discussion about this would be more useful than a
>> code reference which is stale tomorrow. The above explanation is good
>> enough to describe the problem.
>
> Hi Andrew,
>
> can you please update the link when you add the ACKs.
>
> Here is a more stable link:
> [1] https://elixir.bootlin.com/glibc/glibc-2.35/source/nptl/allocatestack.c#L370

That link is still uninteresting and has nothing to do with what I was
asking for, i.e. replacing it with a link to the original discussion
which led to this patch.

Thanks,

        tglx
