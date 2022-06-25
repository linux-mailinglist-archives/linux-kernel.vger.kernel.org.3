Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4817A55AC03
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 21:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiFYSZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 14:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiFYSZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 14:25:43 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686B9D7C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 11:25:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u15so10928369ejc.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 11:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1sO1ws/MZKwL9KLkfXSuGi7R88qOwYnXVh1EIrjSrY=;
        b=ISxJVME02GrBsU5FOg/fWOKziOqTrxvLeknV+yVMk6+SoT6zIeSzfP6F+MJkKiLIRe
         l03OYyl8xShG0EmKvNGqPJ4TEmCNwz+nW8rzmX1UyG/EX0XIb4g6mW+SEog8A1sIEzwM
         ehqdlKfTBC8wDmJsD5tc4cuQ10YnDBaVbkLTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1sO1ws/MZKwL9KLkfXSuGi7R88qOwYnXVh1EIrjSrY=;
        b=BYGu94kpQQAkmuKqCIDxu8XmFvmKoONV8dkmZJIA/x8yN5VUbl3763YW3eMc+BAcYn
         1E+8LtWxGPFgMP7cTxvdoUkpwHdWJb2OO5kFyRQNdZpUaLPLxgqHNtdui7Sq/FbzZ+xn
         /EVzMlOF1qZqb6dW11675i0hpBW1tGJH+ttT71vTCI9Ugbih//KAZ97FIM+Vu1Qi5QXG
         pu8A6r7Ui1Nc4l6wrN68wY9sTV/88ETdK326huA3fRbyX8ZIqjC68tdj9KLntXhfI8uc
         C5eAEGEQBXDC9ZGWEvhNx0DZbSk7K3Z8eLB2BfpUXL8nQsBbe9zw2kQE2BudujGlIFjO
         l5hQ==
X-Gm-Message-State: AJIora+BRX81xo2uXR70HuG/wG+LWpbVFG/nRDsyZprLhHo1jpAXpxCA
        VIz1q3mEtxBv/+7LQVeVXqKhJBkTdqEpO5hH
X-Google-Smtp-Source: AGRyM1vlF9Bjtc0dVRL5E4pp2uPK6qGYdKLgM+CXBwZcN3qC0U5uATEOL4Hitu7x4F3eCeYmBdNrvQ==
X-Received: by 2002:a17:907:c06:b0:701:eb60:ded with SMTP id ga6-20020a1709070c0600b00701eb600dedmr5053218ejc.178.1656181539727;
        Sat, 25 Jun 2022 11:25:39 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id k25-20020a170906971900b00724e6a55d1asm2848180ejx.197.2022.06.25.11.25.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 11:25:38 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so3230530wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 11:25:37 -0700 (PDT)
X-Received: by 2002:a05:600c:354c:b0:39c:7e86:6ff5 with SMTP id
 i12-20020a05600c354c00b0039c7e866ff5mr10129558wmq.145.1656181537671; Sat, 25
 Jun 2022 11:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220622140853.31383-1-pmladek@suse.com> <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com> <874k0863x8.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <874k0863x8.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Jun 2022 11:25:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
Message-ID: <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 10:36 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Let me suggest someone create a new variant of kthread_create that takes
> all of the parameters the workqueue code wants to set.

I suspect the real issue is that that the kthread code simply
shouldn't use the kernel_thread() helper at all.

That helper is literally designed for "start a thread, run this thing".

That's what it *does*.

And that's not at all what the kthread code wants. It wants to set
affinity masks, it wants to create a name for the thread, it wants to
do all those other things.

That code really wants to just do copy_process().

Or maybe it really should just use create_io_thread(), which has a
much better interface, except it has that one oddity in that it sets
the flag that does this:

        if (args->io_thread) {
                /*
                 * Mark us an IO worker, and block any signal that isn't
                 * fatal or STOP
                 */
                p->flags |= PF_IO_WORKER;
                siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
        }

that then has special semantics.

Now, those special semantics may actually be exactly what kthreads
wants, but they are important:

                /*
                 * PF_IO_WORKER threads will catch and exit on fatal signals
                 * themselves. They have cleanup that must be performed, so
                 * we cannot call do_exit() on their behalf.
                 */

which is about that "what happens for fatal signals" thing.

               Linus
