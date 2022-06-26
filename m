Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C20555AF66
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 08:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiFZGJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 02:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiFZGJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 02:09:23 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A911183F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 23:09:22 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w193so8903139oie.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 23:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ngQRvUiP2qfs10F42aiHdjJqUcSIkLjXxpBqZuzDQiE=;
        b=bgGWzko+bHWBsJ7y0Vk7nsDmTBuMhKWy8nY9aynjFwbLTkHBSbTLZK2fWND4Dum3Je
         yrmYGrVO5YevJUZadlJuASRegN+Kf4uWxlaq2zQj9aYvbhqB3WOz0BSGpSnXqERaeSNR
         q5GpGyy6fXy8/6tfm748UkkUYuT6sqlF+Trta08NHdm1F4C9JIv+1ltm7lNUYUzMSUok
         JG03+bbAPZrDQ/I0mDmXc4PrX+h7LOrQ1PK7LdK9K+uFmeYEn5ab1TWTjqwo17bGqN5R
         21EILL5e0fZABA1znTey1AQ2b9xqZcOz0yRA64k5pBD6MPrBFyHDFrWTfX45WZXyf8gC
         zucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ngQRvUiP2qfs10F42aiHdjJqUcSIkLjXxpBqZuzDQiE=;
        b=M4+0ox/LS3xAvgQfzLsQCeUdMVPQ1RZGz+o1XfcZNNRzuFVO3BikxL84gIJqXvjxV9
         Pd22R+D2dwrBXQ3Q703c8BRVEufQ4NMRvtEA/+oSx0JVrvHNJ+V0r0wrJC/E0+0Zwlfz
         6H9Q9a2u9fXcE+b1G67Fv2m2n2bsWQv9NvfQFoaSoa1shMJRnOwQ9K1yVlZW0ZoABrCk
         MNYD7OB3F8JiyqBFruD/lVCObTDu/uKi7ZOZAoyT8hhBrgq9lToQ6Hzzxb3yYislFiRR
         IIl98EMspKM+34wVcDezrmKuxulSe+5rN4IYvWsplU0Pgfd6HEs0kAjNRV17Rh6Rc+7V
         3EGw==
X-Gm-Message-State: AJIora9pkaLr8RxODqQCxmE4wnSBU8SJCdPHVbOKTMRA78mmiIcTSl7y
        RMwLU2bjIl2/dfZX8M0obac=
X-Google-Smtp-Source: AGRyM1sirbbC3Tu/78msIEzzt+ttGHzjE+6UyOtnzcbFMM2vtHk7+4RP8Bx/3NbzqXrjNNYv51+AAg==
X-Received: by 2002:a05:6808:11c8:b0:335:2198:99a6 with SMTP id p8-20020a05680811c800b00335219899a6mr6942000oiv.6.1656223761705;
        Sat, 25 Jun 2022 23:09:21 -0700 (PDT)
Received: from localhost ([2600:380:b83e:43fa:ba68:31f:1790:3643])
        by smtp.gmail.com with ESMTPSA id s24-20020a0568301c7800b0060be71204casm4231168otg.53.2022.06.25.23.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 23:09:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 26 Jun 2022 15:09:11 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
Message-ID: <Yrf4B8EZnpsbbq5F@mtj.duckdns.org>
References: <20220622140853.31383-1-pmladek@suse.com>
 <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
 <Yre9LO2nj+Hbr67V@mtj.duckdns.org>
 <CAHk-=wjmWUSdK7-LLjpUrH_TX78emb3ajxZ1ueT2HU0_FVJQfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjmWUSdK7-LLjpUrH_TX78emb3ajxZ1ueT2HU0_FVJQfA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Jun 25, 2022 at 07:53:34PM -0700, Linus Torvalds wrote:
...
> Is that the _common_ pattern? It's not *uncommon*. It's maybe not the
> strictly normal wait-queue one, but if you grep for
> "wake_up_process()" you will find quite a lot of them.
...
> > I'm probably missing sometihng. Is it about bespoke wait mechanisms?
> > Can you give a concrete example of an async wakeup scenario?
> 
> Grep for wake_up_process() and just look for them/

Right, for kthreads, custom work list + directed wakeup at the known
handler task is a pattern seen across the code base and that does
affect all other waits the kthread would do.

...
> So you need to always do that in a loop. The wait_event code will do
> that loop for you, but if you do manual wait-queues you are required
> to do the looping yourself.

The reason why this bothered me sometimes is that w/ simple kthread
use cases, there are place where all the legtimate wakeup sources are
clearly known. In those cases, the fact that I can't think of a case
where the looping would be needed creates subtle nagging feeling when
writing them.

...
> Again, none of these are *really* spurious. They are real wakeup
> events. It's just that within the *local* code they look spurious,
> because the locking code, the disk IO code, whatever the code is
> doesn't know or care about all the other things that process is
> involved in.

I see. Yeah, waiting on multiple sources which may not be known to
each wait logic makes sense.

...
> But I don't think that's what's going on here. I think the workqueue
> code is just confused, and should have initielized "worker->pool" much
> earlier.  Because as things are now, when worker_thread() starts
> running, and does that
> 
>   static int worker_thread(void *__worker)
>   {
>         struct worker *worker = __worker;
>         struct worker_pool *pool = worker->pool;
> 
> thing, that can happen *immediately* after that
> 
>    kthread_create_on_node(worker_thread, worker,
> 
> happens. It just so happens that *normally* the create_worker() code
> ends up finishing setup before the new worker has actually finished
> scheduling..
> 
> No?

I'm not sure. Putting aside the always-loop-with-cond-check princicple
for the time being, I can't yet think of a scenario where the
interlocking would break down unless there really is a wakeup which is
coming from an unrelated source.

Just experimented with commenting out that wakeup in create_worker().
Simply commenting it out doesn't break anything but if I wait for
PF_WQ_WORKER to be set by the new worker thread, it doesn't happen.
ie. the initial wakeup is spurious because there is a later wakeup
which comes when a work item is actually dispatched to the new worker.
But the newly created kworker won't start executing its callback
function without at least one extra wakeup, whereever that may be
coming from.

After the initial TASK_NEW handshake, the new kthread notifies
kthread_create_info->done and then goes into an UNINTERRUPTIBLE sleep
and won't start executing the callback function unless somebody wakes
it up. This being a brand new task, it's a pretty sterile wakeup
environment. So, there actually has to be an outside wakeup source
here.

If we say that anyone should expect external wakeups that it has no
direct control over, the kthread_bind interface is broken too cuz
that's making exactly the same assumption that the task is dormant at
that point till the owner sends a wakeup and thus its internal state
can be manipulated safely.

Petr, regardless of how this eventually gets resolved, I'm really
curious where the wakeup that you saw came from. Would it be possible
for you to find out?

Thanks.

-- 
tejun
