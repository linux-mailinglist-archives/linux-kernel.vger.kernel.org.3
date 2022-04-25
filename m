Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1913550E2FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242343AbiDYO0b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Apr 2022 10:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiDYO03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:26:29 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDDA220E2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:23:24 -0700 (PDT)
Received: (Authenticated sender: christophe@dinechin.org)
        by mail.gandi.net (Postfix) with ESMTPSA id A8EAA1BF205;
        Mon, 25 Apr 2022 14:23:18 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 1/3] sched/headers: Fix compilation error with GCC 12
From:   Christophe de Dinechin <christophe@dinechin.org>
In-Reply-To: <20220414133050.b820fa45d42de4cfc24db82b@linux-foundation.org>
Date:   Mon, 25 Apr 2022 16:23:17 +0200
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Christophe de Dinechin <dinechin@redhat.com>,
        trivial@kernel.org, Ben Segall <bsegall@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <6139D443-68FC-4A8D-9401-4FA5CDA158AD@dinechin.org>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-2-dinechin@redhat.com>
 <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
 <20220414133050.b820fa45d42de4cfc24db82b@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 14 Apr 2022, at 22:30, Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> On Thu, 14 Apr 2022 17:21:01 +0200 Peter Zijlstra <peterz@infradead.org> wrote:
> 
>>> +/* The + 1 below places the pointers within the range of their array */
>>> #define for_class_range(class, _from, _to) \
>>> -	for (class = (_from); class != (_to); class--)
>>> +	for (class = (_from); class + 1 != (_to) + 1; class--)
>> 
>> Urgh, so now we get less readable code, just because GCC is being
>> stupid?
>> 
>> What's wrong with negative array indexes? memory is memory, stuff works.
> 
> What's more, C is C.  Glorified assembly language in which people do odd
> stuff.

Notably since the advent of clang, we moved a bit beyond glorified assembly language.
There is no 1 on 1 correspondence between what you write and the generated
assembly anymore, by a long shot. I’m sure you know that ;-), but that’s an
opportunity to plug Jason Turner’s conference on writing a C64 pong game using C++17
(https://www.youtube.com/watch?v=zBkNBP00wJE). That demonstrates,
in a funny way, just how far compilers go these days to massage your code.

> 
> But this is presumably a released gcc version and we need to do
> something.  And presumably, we need to do a backportable something, so
> people can compile older kernels with gcc-12.

Hmm, I must admit I had not considered the backporting implications.

> 
> Is it possible to suppress just this warning with a gcc option? And if
> so, are we confident that this warning will never be useful in other
> places in the kernel?

I would advise against it, and not just because of warnings.

With GCC’s ability to track pointers to individual C objects, you can expect
that they will soon start optimising based on that collected knowledge.

An example of useful optimisation based on that knowledge is to
avoid memory reloads, The idea is that a write in array B[] does
not force you to reload all data you already fetched from array A[].
But that requires the compiler to prove that pointers to A[] stay in A[]
and that you don’t purposely build negative indexes from B[] or
anything weird like that.


> If no||no then we'll need to add workarounds such as these?

It is definitely possible to silence that warning. I would still recommend
adding this kind of changes, which I would personally describe more as
“accurate description intended of memory accesses” rather than “workarounds”.
To me, it’s on the same level as putting memory fences, for example.

> 

