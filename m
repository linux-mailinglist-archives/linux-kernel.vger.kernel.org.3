Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CF7515168
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379446AbiD2RSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379100AbiD2RR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:17:59 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFB45EDC6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:14:40 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id r17so4391786iln.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cX0NiBN/CCJrlkMPWV999pJdK+WS9wSu4FXPabVPzBE=;
        b=CO4nbr5Gh5ZG2PI9QNv28iRmrVEqXqZWN8JGMwCEDHfQUoXkpMAYWE0VfxYtrIbmKF
         3i38zQpBTsmrPC/OoMLbapA97cEpOK0D3dYW5qcrzl98i/r7fcdYfHm6v9oRqJqqPvxm
         yafEem6H/ucvvFyl752kB3x5Qby6T5Wl9VoP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cX0NiBN/CCJrlkMPWV999pJdK+WS9wSu4FXPabVPzBE=;
        b=2qq4msg4NpluNzifT2g83QzADr/67U2z/g4mvx/9Fa/8hZkqJskNMxL9EEsGrVFzlJ
         WsE3cN+InTKccUEETbV4wrRBehlYYlo0v13Lz36j52xatcIenNuhuoGdaLKSC0lsUOqW
         xvitw67DVuDsZ9RqdAVC5coJfpKI+W+NSv+YD4JRrOKyfRcs/XNqiT76+ejzAX/LMoHd
         +KoAJJi52q2CKQAg3I7dtBToMv6mgVk4VTxH6eRjZt0O7AKZeBIDJfzbOd0y0alPeRZI
         uBt5KlBSRIAmsUR4BHvwcDYtkg2ILnYRYof4+W2QFGcT8UdKNdevudiG6H4D9J9qE+DC
         3KAg==
X-Gm-Message-State: AOAM533zzS3YZFvlIDK3NjmEPmuD7SVgHUH+KZbgDQFszpifhKKzpLY1
        RFatioB3svIqknAq6cs5i0gDOg==
X-Google-Smtp-Source: ABdhPJwyIsfzzHI9nzL5YI7bYVXXt4/x4kC28yGge6+2SlA2+WNDxvw9bd4JwLIJ67ShVO9WOxviBQ==
X-Received: by 2002:a05:6e02:1547:b0:2cd:6214:e8f5 with SMTP id j7-20020a056e02154700b002cd6214e8f5mr151639ilu.220.1651252479279;
        Fri, 29 Apr 2022 10:14:39 -0700 (PDT)
Received: from ircssh-3.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id k24-20020a02a718000000b0032b3a781778sm713410jam.60.2022.04.29.10.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 10:14:38 -0700 (PDT)
Date:   Fri, 29 Apr 2022 17:14:37 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Rodrigo Campos <rodrigo@kinvolk.io>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alban Crequy <alban@kinvolk.io>
Subject: Re: [PATCH v3 1/2] seccomp: Add wait_killable semantic to seccomp
 user notifier
Message-ID: <20220429171437.GA1267404@ircssh-3.c.rugged-nimbus-611.internal>
References: <20220429023113.74993-1-sargun@sargun.me>
 <20220429023113.74993-2-sargun@sargun.me>
 <CACaBj2bW8XkENHoLNXEprQ_d8=_aLT_XQdjCZtSOiPJis8G_pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACaBj2bW8XkENHoLNXEprQ_d8=_aLT_XQdjCZtSOiPJis8G_pQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 11:42:15AM +0200, Rodrigo Campos wrote:
> On Fri, Apr 29, 2022 at 4:32 AM Sargun Dhillon <sargun@sargun.me> wrote:
> > the concept is searchable. If the notifying process is signaled prior
> > to the notification being received by the userspace agent, it will
> > be handled as normal.
> 
> Why is that? Why not always handle in the same way (if wait killable
> is set, wait like that)
> 

The goal is to avoid two things:
1. Unncessary work - Often times, we see workloads that implement techniques
   like hedging (Also known as request racing[1]). In fact, RFC3484
   (destination address selection) gets implemented where the DNS library
   will connect to many backend addresses and whichever one comes back first
   "wins".
2. Side effects - We don't want a situation where a syscall is in progress
   that is non-trivial to rollback (mount), and from user space's perspective
   this syscall never completed.

Blocking before the syscall even starts is excessive. When we looked at this
we found that with runtimes like Golang, they can get into a bad situation
if they have many (1000s) of threads that are in the middle of a syscall
because all of them need to elide prior to GC. In this case the runtime
prioritizes the liveness of GC vs. the syscalls.

That being said, there may be some syscalls in a filter that need the suggested 
behaviour. I can imagine introducing a new flag
(say SECCOMP_FILTER_FLAG_WAIT_KILLABLE) that applies to all states.
Alternatively, in one implementation, I put the behaviour in the data
field of the return from the BPF filter.


> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index db10e73d06e0..9291b0843cb2 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -1081,6 +1088,12 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd, struct seccomp_kn
> >         complete(&addfd->completion);
> >  }
> >
> > +static bool should_sleep_killable(struct seccomp_filter *match,
> > +                                 struct seccomp_knotif *n)
> > +{
> > +       return match->wait_killable_recv && n->state == SECCOMP_NOTIFY_SENT;
> 
> Here for some reason we check the notification state to be SENT.
> 
Because we don't want to block unless the notification has been received
by userspace.

> > +}
> > +
> >  static int seccomp_do_user_notification(int this_syscall,
> >                                         struct seccomp_filter *match,
> >                                         const struct seccomp_data *sd)
> > @@ -1111,11 +1124,25 @@ static int seccomp_do_user_notification(int this_syscall,
> >          * This is where we wait for a reply from userspace.
> >          */
> >         do {
> > +               bool wait_killable = should_sleep_killable(match, &n);
> > +
> 
> So here, the first time this runs this will be false even if the
> wait_killable flag was used in the filter (because that function
> checks the notification state to be sent, that is not true the first
> time)
> 
> Why not just do wait_for_completion_killable if match->wait_killable
> and wait_for_completion_interruptible otherwise? Am I missing
> something?
Again, this is to allow for the notification to be able to be preempted
prior to being received by the supervisor.

> 
> 
> 
> Best,
> Rodrigo
[1]: https://research.google/pubs/pub40801/
