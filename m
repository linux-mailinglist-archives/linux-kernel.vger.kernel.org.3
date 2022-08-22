Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA5859CC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbiHVXiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbiHVXiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:38:13 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D6756B90
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:38:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id r15-20020a17090a1bcf00b001fabf42a11cso12922749pjr.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=4amcj+GX6QPImgEMdCvqYYXHYGDFrOu9K0ObHk2MTYc=;
        b=WHubvTiOkYAu7Nf5aMotBC9pntvixu2LQpMcU8UbrqfY4SxY04z9MgPzeDT6nF3Mfw
         CfJ7Ok2m+K7f9YIC9AvrttSyi22Z0b90NYpqqpy9A4mnqyU2qYVIFRUr6bzom9ccCK3K
         B+DdcKpRz6HNPoP5MPQX/YCtFk7hmfHUlso6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=4amcj+GX6QPImgEMdCvqYYXHYGDFrOu9K0ObHk2MTYc=;
        b=R212QWkHccgDV+vG4BvJADNn4G3oNQvLPA6yF9Mge8dupzk8yNC1zbAT7SmTU/GZsM
         QYYxRmanepn8q4RTmtvVNcwr/AHtd766CoAfTz1pZAmGnhhJTI5cZ1Yo7viYv4MCWNai
         LbIVoN8roT8MPWbMa0R7Jz8wZ7eYxtXvN0zdmMQZYi4ClE4Q/r2knSLNXVAf3q2KpzaW
         8vE+LU/V1VncA1rZM3zvtodYeZ3tnNYFHD8BxFPb5T3RySXsqWhAL/RpsuFJmP0Ovrzy
         obYsAAxqArsO7/o9xTFwfPX9n563nAnYLRBZ8mHbGvDJfQ8jioi4WyQCWppyPdclVrr+
         xRBQ==
X-Gm-Message-State: ACgBeo2kks/X7S7Bbc6QlXLMIL/mhfLFIF4C1hKcWNWhGwrYXmPhNG+j
        N81JxayUllyzoHJYeNyzzGOH4A==
X-Google-Smtp-Source: AA6agR4uQOrvHw1S8omS4oV+Fc2IxR7ZkCJqwpG03ELNo9iFW9HaqyzqoUlhM/mgO0FXpyqr3XTUaA==
X-Received: by 2002:a17:90b:2496:b0:1ef:a94:7048 with SMTP id nt22-20020a17090b249600b001ef0a947048mr642677pjb.244.1661211489194;
        Mon, 22 Aug 2022 16:38:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f68-20020a625147000000b0052a297324cbsm9173610pfb.41.2022.08.22.16.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 16:38:08 -0700 (PDT)
Date:   Mon, 22 Aug 2022 16:38:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     ayudutta@amazon.com, brauner@kernel.org, kuni1840@gmail.com,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        syzbot+ab17848fe269b573eb71@syzkaller.appspotmail.com,
        wad@chromium.org
Subject: Re: [PATCH v1] seccomp: Release filter when copy_process() fails.
Message-ID: <202208221636.1DE3D674@keescook>
References: <202208221414.A0E13E7@keescook>
 <20220822214935.29842-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822214935.29842-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 02:49:35PM -0700, Kuniyuki Iwashima wrote:
> From:   Kees Cook <keescook@chromium.org>
> Date:   Mon, 22 Aug 2022 14:16:03 -0700
> > On Mon, Aug 22, 2022 at 01:44:36PM -0700, Kuniyuki Iwashima wrote:
> > > Our syzbot instance reported memory leaks in do_seccomp() [0], similar
> > > to the report [1].  It shows that we miss freeing struct seccomp_filter
> > > and some objects included in it.
> > > 
> > > We can reproduce the issue with the program below [2] which calls one
> > > seccomp() and two clone() syscalls.
> > > 
> > > The first clone()d child exits earlier than its parent and sends a
> > > signal to kill it during the second clone(), more precisely before the
> > > fatal_signal_pending() test in copy_process().  When the parent receives
> > > the signal, it has to destroy the embryonic process and return -EINTR to
> > > user space.  In the failure path, we have to call seccomp_filter_release()
> > > to decrement the filter's ref count.
> > > 
> > > Initially, we called it in free_task() called from the failure path, but
> > > the commit 3a15fb6ed92c ("seccomp: release filter after task is fully
> > > dead") moved it to release_task() to notify user space as early as possible
> > > that the filter is no longer used.
> > > 
> > > To keep the change, let's call seccomp_filter_release() in copy_process()
> > > and add a WARN_ON_ONCE() in free_task() for future debugging.
> > 
> > Thanks for tracking this down! I think I'd prefer to avoid changing the
> > semantics around the existing seccomp refcount lifetime, so what about
> > just moving copy_seccomp() below the last possible error path?
> 
> Actually, I also thought of it but avoid it because it means we move the
> signal check relatively earlier than before, so would-be-killed processes
> could consume more resouces.
> 
> What do you think about this?

There's no allocation happening in copy_seccomp(), just reference
counts being added. Given the lock that is held, the ordering here
doesn't matter as far as I can tell, except for the fact that
copy_seccomp() expects to go through full thread death if something goes
wrong. So, simply moving it later should do the trick here.

-Kees

> 
> > 
> > 
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 90c85b17bf69..e7f4e7f1e01e 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2409,12 +2409,6 @@ static __latent_entropy struct task_struct *copy_process(
> >  
> >  	spin_lock(&current->sighand->siglock);
> >  
> > -	/*
> > -	 * Copy seccomp details explicitly here, in case they were changed
> > -	 * before holding sighand lock.
> > -	 */
> > -	copy_seccomp(p);
> > -
> >  	rv_task_fork(p);
> >  
> >  	rseq_fork(p, clone_flags);
> > @@ -2431,6 +2425,14 @@ static __latent_entropy struct task_struct *copy_process(
> >  		goto bad_fork_cancel_cgroup;
> >  	}
> >  
> > +	/* No more failures paths after this point. */
> > +
> > +	/*
> > +	 * Copy seccomp details explicitly here, in case they were changed
> > +	 * before holding sighand lock.
> > +	 */
> > +	copy_seccomp(p);
> > +
> >  	init_task_pid_links(p);
> >  	if (likely(p->pid)) {
> >  		ptrace_init_task(p, (clone_flags & CLONE_PTRACE) || trace);
> > 
> > 
> > Totally untested, but I think it would fix this?
> > 
> > -Kees
> > 
> > -- 
> > Kees Cook

-- 
Kees Cook
