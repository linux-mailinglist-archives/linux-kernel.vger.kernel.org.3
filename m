Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420C955E722
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346096AbiF1ORM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346222AbiF1ORI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:17:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1312D2F001
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:17:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 739BE61A33
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACEAC341C6;
        Tue, 28 Jun 2022 14:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656425822;
        bh=fL1myieNVAYQtnZgPBzowFEG66aMVu+/4jt+Cz8DC3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UebpypmwDUMY84khT1esanXceJsfCfCdhnoGpECoHxJKyhhrineaIm1t85bLoreJr
         686lvzF9fF94ESvxmoUzGWxvAALSrgsOVxS5uDt/niCmtnwFT02X0+KAQeDg5kJY6w
         T0viG1FnA1Wmqy9O/CcL3qSiFJHsuRzcvXKPLBtu7A31Tc8thh+2kilOCbsnaEhW/Y
         Dsf5QW+G+S/7/iJwPHsX9Q26gdgtzuC5PDQVde4Itix3e6XJSfIwyzAJrXAPdkpg0E
         56KpMSrSouPcSSoNMSFuI37a0F37+84GUZXTJhLf2c/QcoEi8D9IaU9F5QklwpxPV4
         +KDRfjNilOVGg==
Date:   Tue, 28 Jun 2022 16:16:56 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
Message-ID: <20220628141656.cf2jyrelhcylkpfp@wittgenstein>
References: <20220622140853.31383-1-pmladek@suse.com>
 <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
 <874k0863x8.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
 <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 11:43:15AM -0700, Linus Torvalds wrote:
> On Sat, Jun 25, 2022 at 11:25 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > And that's not at all what the kthread code wants. It wants to set
> > affinity masks, it wants to create a name for the thread, it wants to
> > do all those other things.
> >
> > That code really wants to just do copy_process().
> 
> Honestly, I think kernel/kthread.c should be almost rewritten from scratch.
> 
> I do not understand why it does all those odd keventd games at all,
> and why kthread_create_info exists in the first place.
> 
> Why does kthread_create() not just create the thread directly itself,
> and instead does that odd queue it onto a work function?
> 
> Some of that goes back to before the git history, and very little of
> it seems to make any sense. It's as if the code is meant to be able to
> run from interrupt context, but that can't be it: it's literally doing
> a GFP_KERNEL kmalloc, it's doing spin-locks without irq safety etc.
> 
> So why is it calling kthreadd_task() to create the thread? Purely for
> some crazy odd "make that the parent" reason?
> 
> I dunno.  The code is odd, unexplained, looks buggy, and most fo the
> reasons are probably entirely historical.
> 
> I'm adding Christian to this thread too, since I get the feeling that
> it really should be more tightly integrated with copy_process(), and
> that Christian might have comments.
> 
> Christian, see some context in the thread here:
> 
>   https://lore.kernel.org/all/CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com/
> 
> for some of this.

Sorry, I was at LSS last week.

I honestly didn't touch the code back then because it seemed almost
entirely unrelated to regular task creation apart from kernel_thread()
that I added. I didn't feel comfortable changing a lot of stuff there.

Iirc, just a few months ago io_uring still made us of the kthread
infrastructure and I think that made the limits of the interface more
obvious. Now we soon will have two users that create a version of kernel
generated threads with properties of another process (io_uring and [1]).

In my head, the kthread infra should be able to support generation of
pure kernel threads as well as the creation of users workers instead of
adding specialized interfaces to do this. The fact that it doesn't is a
limitation of the interface that imho shows it hasn't grown to adapt to
the new use-cases we have. And imho we'll see more of those.

In this context it's really worth looking at [1] because to some extent
it duplicates bits we have for the kthread infra whereas I still think
the kthread infra should support both possibly exposing two apis one
to return pure kernel threads and the other returning struct user_worker
or similar. Idk, it might just be a heat-stroke talking...

I don't feel comfortable making strong assertions about the original
implementation of kthreads. I wasn't around and there might be
historical context I'm missing.

One issue that Tejun also mentioned later in the thread and that we run
into is that we have a pattern where we create a kthread and then trust
the caller to handle/activate the new task. This is more problematic
once we start supporting something like [1] where that's exposed to a
driver. (Ideally creation of such a task would generate a unique
callback - I think Peter suggested something like this? - that could
only be used on that task...)

[1]: https://lore.kernel.org/lkml/20220620011357.10646-1-michael.christie@oracle.com
