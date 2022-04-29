Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B68515427
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380182AbiD2TAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380172AbiD2TAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:00:03 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6728D6A2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:56:42 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BF93A6A127F;
        Fri, 29 Apr 2022 18:56:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E2A826A15D0;
        Fri, 29 Apr 2022 18:56:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1651258601; a=rsa-sha256;
        cv=none;
        b=h+YKgCBIErxGxLCOh3DExzO8Dm6owK6OgpFT8p4jh3D92Rl7IfWyLLPSuBcb3XkpL//OEn
        JSYLZFFXja2tZBHX5+GArXnjA/5btbavzLEcxwuxRtr92DEXIIbR4NhY9fpWPWQC7S+Z2a
        bIguA/H1wiRTI7wp3/jYwDE7QON92hm8VMKEvAnP4DMPk20mEex12KdMBXoxw3KA0U2gRo
        IenUnmE3gLM2316ML3Fm6PA1KqRCIc3TSf+mrOM2+/nWd3WFVVQpl7klB7ce35wuYwvQBj
        FJjSchlby9VhTbqFGMaXisw8hs2SfyJTG/0LcL+Jgmn50SrjIe1Wy1j4I/uqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1651258601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=q7GK4tNtUdPsCkIB6AGnkYHFR71fuWyelk2LtXFBMMU=;
        b=nVhx4YrZUrzK/XZ1NJaMjR7/AXqmJZS4+oIaQEKHUSS/aRye545dyQCLcwPAGz6CWUjv2x
        +wLU4AsVhRA8gzjCIJFKgIFvvmRL7AfWsZCwx+xqb/jz+lDY+N+Pvwl8KS0rqMoK5pPQgb
        ZNQl0lE2ccHtuGmT0tnZvTxJ3Zxq3lOqCC7oH5T1RKMs+oAdkgw1sZUAvGUizd1yB5/RU6
        QZ97CwPS/PzC3fB0o7j0wNKiKlBWxLyNXu7YpuGuqvRvTw4N+WOsNRcCUlwDs1Yp0DxFCm
        dQV740EDhIruL5IlVuqvK3k4kDS/YnaQjAn2I9yGBqviOJ+osI1nZ+yPkaIXcQ==
ARC-Authentication-Results: i=1;
        rspamd-847dd8955c-c7snv;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Descriptive-Quick: 6eb74fb32a06ba3c_1651258601427_2688605735
X-MC-Loop-Signature: 1651258601427:646155923
X-MC-Ingress-Time: 1651258601427
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.123.55 (trex/6.7.1);
        Fri, 29 Apr 2022 18:56:41 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4KqhY373Lgz1NJ;
        Fri, 29 Apr 2022 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1651258600;
        bh=q7GK4tNtUdPsCkIB6AGnkYHFR71fuWyelk2LtXFBMMU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=p8msJRphPZ9QAdkC+ArXhVohZPhu8xlkp2RMslXXvlyN2bgm2DX+ESggcBI++TQAJ
         45IDIvAFmoiXtRgrEQSZjhrI334yq2npKbNfc2ozWDUWQlH5T2rAADbMe/QilT4QsU
         wCsMgtTnkFiVWmk1JN158r9U6g6vOwkju6wZD5z8gC70/zO1aZKMVlny0dMihUGSMK
         iVvbfeKJwp5sLaE2N85IOI5JQFrUlcUF6fklOTNTqG7ukB9M0T2gvwblBP/Loy1cAk
         JkrbyfCOoMEOB8pdCb08B6ELcLZYjXjmAC8m7myKJDeqVNgcTVZ0lQJxu/WwzTgLUF
         lX8dXeJS9yqOA==
Date:   Fri, 29 Apr 2022 11:45:13 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] locking/rwsem: Teach contention tracing about optimistic
 spinning
Message-ID: <20220429184513.vftv4pj72fxzrpm2@offworld>
References: <20220427155241.26410-1-dave@stgolabs.net>
 <CAM9d7ciQnUcefR-hLBHSDhu6zZovxXvGYW-CdSBiub_GAOfAiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAM9d7ciQnUcefR-hLBHSDhu6zZovxXvGYW-CdSBiub_GAOfAiA@mail.gmail.com>
User-Agent: NeoMutt/20220408
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply.

On Wed, 27 Apr 2022, Namhyung Kim wrote:

>Hi Davidlohr,
>
>On Wed, Apr 27, 2022 at 9:04 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>>
>> Similar to the mutex counterpart, we can further distinguish the
>> types of contention. Similarly this patch also introduces potentially
>> various _begin() tracepoints with a single respective _end().
>
>Thanks for doing this.  I was thinking about it as well.

I really like your work on this. I've always wanted a low overhead
equivalent-ish of lock_stat, which could be used in production and
look forward to see these tracepoints put to good use.

>> @@ -115,7 +116,8 @@ TRACE_EVENT(contention_begin,
>>                                 { LCB_F_WRITE,          "WRITE" },
>>                                 { LCB_F_RT,             "RT" },
>>                                 { LCB_F_PERCPU,         "PERCPU" },
>> -                               { LCB_F_MUTEX,          "MUTEX" }
>> +                               { LCB_F_MUTEX,          "MUTEX" },
>> +                               { LCB_F_RWSEM,          "RWSEM" }
>>                           ))
>>  );
>
>Well I'm ok with this but it'd be better if we can do this
>without adding a new flag.  Originally a mutex can be
>identified with 0, and a rwsem with either of READ or WRITE.
>
>The MUTEX flag was added to note optimistic spins
>on mutex and now we need something similar for
>rwsem.  Then can we change the MUTEX to OPTIMISTIC
>if it's not too late?

Ok. Perhaps name it OSQ? I had thought of that but at the
time was also thinking about potentially the rtmutex and
rt spinlock spinning too - which don't use osq so the name
would fit in that sense.

While not in Linus' tree, I wouldn't think it's too late.

>>         for (;;) {
>>                 if (rwsem_try_write_lock(sem, &waiter)) {
>> @@ -1161,18 +1167,25 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>>                 if (waiter.handoff_set) {
>>                         enum owner_state owner_state;
>>
>> +                       trace_contention_begin(sem, LCB_F_RWSEM |
>> +                                              LCB_F_WRITE | LCB_F_SPIN);
>>                         preempt_disable();
>>                         owner_state = rwsem_spin_on_owner(sem);
>>                         preempt_enable();
>>
>> -                       if (owner_state == OWNER_NULL)
>> -                               goto trylock_again;
>> +                       if (owner_state == OWNER_NULL) {
>> +                               raw_spin_lock_irq(&sem->wait_lock);
>> +                               if (rwsem_try_write_lock(sem, &waiter))
>> +                                       break;
>> +                               raw_spin_unlock_irq(&sem->wait_lock);
>> +                       }
>> +
>> +                       trace_contention_begin(sem, LCB_F_RWSEM | LCB_F_WRITE);
>
>I'm afraid that it'd generate many contention_begin
>trace events for a single lock acquisition.

You are right, lets just trace the "normal" optimistic spinning
at the start of the write slowpath.

Thanks,
Davidlohr
