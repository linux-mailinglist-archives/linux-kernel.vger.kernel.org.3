Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60AD4FE5B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355689AbiDLQXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357541AbiDLQXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:23:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7075D197
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:20:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649780440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6yP5J8nxyQra9M+hDPLnlcwcmCfGna/5XejuacIZlIg=;
        b=N1oK5VzI2sa6RgXreww7KwtqF40d6u/LCoCgJFgO8kafu/rANPi3P9s/Mv64JAZy/2SHx1
        wkfMklYPg/2vXD1//kKVQHg0oQE9e0vuDChQsCjyR/4aEn+wEZouXcrhEroIX9kvV61I8b
        DSgCQN+54Ys47eIJ+kdXZS+YAeknOvhEs/5sJ9A71pYM/sGrL2DY6M8IR/FelMLZxaZnYT
        y0xHcebe9vmiJBBv/QzFCCOXaO/Jm76Yt1VZYAmyiaFpKXHsiRivefq5lLg7eIfPgSFXSM
        VGxMc10744do/HfRWfGRsABriLu7wy16abYLSZJug8pbv684H027vRV1DxM2KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649780440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6yP5J8nxyQra9M+hDPLnlcwcmCfGna/5XejuacIZlIg=;
        b=H9k4MA+4/IG3seXGL3Q1NlTEfYreQBmGC4uAirVJ2d42xxjgyVPlQfkkl1u3wl9HV6/izf
        2uVUBgNLY/T64lAA==
To:     Nico Pache <npache@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
In-Reply-To: <1a7944c7-d717-d5af-f71d-92326f7bb7f6@redhat.com>
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
 <ee07a31c-c514-4a88-599f-14a30e93f32e@redhat.com> <87k0bzk7e5.ffs@tglx>
 <1a7944c7-d717-d5af-f71d-92326f7bb7f6@redhat.com>
Date:   Tue, 12 Apr 2022 18:20:40 +0200
Message-ID: <87h76yff3b.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11 2022 at 19:51, Nico Pache wrote:
> On 4/8/22 09:54, Thomas Gleixner wrote:
>> The below reproduces the problem nicely, i.e. the lock() in the parent
>> times out. So why would the OOM killer fail to cause the same problem
>> when it reaps the private anon mapping where the private futex sits?
>> 
>> If you revert the lock order in the child the robust muck works.
>
> Thanks for the reproducer Thomas :)
>
> I think I need to re-up my knowledge around COW and how it effects
> that stack. There are increased oddities when you add the pthread
> library that I cant fully wrap my head around at the moment.

The pthread library functions are just conveniance so I did not have to
hand code the futex and robust list handling.

> My confusion lies in how the parent/child share a robust list here, but they
> obviously do. In my mind the mut_s would be different in the child/parent after
> the fork and pthread_mutex_init (and friends) are done in the child.

They don't share a robust list, each thread has it's own.

The shared mutex mut_s is initialized in the parent before fork and it's
the same address in the child and it's not COWed because the mapping is
MAP_SHARED.

The child allocates private memory and initializes the private mutex in
that private mapping.

So now child does:

   pthread_mutex_lock(mut_s);

That's the mutex in the memory shared with the parent. After that the
childs robusts list head points to mut_s::robust_list.

Now it does:

   pthread_mutex_lock(mut_p);

after that the childs robust list head points to mut_p::robust_list and
mut_p::robust_list points to mut_s::robust_list.

So now the child unmaps the private memory and exists.

The kernel tries to walk the robust list pointer and faults when trying
to access mut_p. End of walk and mut_s stays locked.

So now think about the OOM case. The killed process has a shared mapping
with some other unrelated process (file, shmem) where mut_p sits.

It gets killed after:
		pthread_mutex_lock(mut_s);
		pthread_mutex_lock(mut_p);

So the OOM reaper rips the VMA which contains mut_p and therefore breaks
the chain which is necessary to reach mut_p.

See?

Thanks,

        tglx



