Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F109655D34C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbiF0SZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 14:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240238AbiF0SZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 14:25:11 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC2D13D7B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:23:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id cw10so20932668ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z0GjknphkWGhoR5RB3y0Cv/lqmFOhZuN8xbb2n6aFXo=;
        b=DARD8kZ5NWv16d9clLPhlRkbV6/HIsGbnxqz01koy03YjM+WOj25a8kQpmBqQFlVF3
         Xba4oY3SbBrVUyl9OAPdcHtBQr3LIX40TZUimEid4zxOQbETo9ur6wodet2NfIwqo7mf
         lNR6X75kaxr7+n8zWDa8cZKG0Txa8RCyy8ZVqqZKd7qoiL+XizOqzoqV0pvQxHYPci3i
         7ZaqrCC7E3wicWfj3TRAeipnAEmFG7zMjSAb9dkcCf0muwZg2pGwPu2oissZh7RX530W
         lSyUAVjAM9xOmXlKPpYKyfxrR0ezqmyq0fPX3BkH7uyiT9njOjfZuox5skky+pJ0RbN5
         lPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z0GjknphkWGhoR5RB3y0Cv/lqmFOhZuN8xbb2n6aFXo=;
        b=eq3EqBVfnwYe5uAGlXh9LuZn+vKgmC7Z6Bp37WAlnswHf/CyS6ppwqv7vxGhderqD3
         pdSzsVbkDXnHKCJgYC8xDs439gzYJZspEUMvY8C3lSfhkmQUESAmkT5E01JcZrZ1leor
         jhGOKPL359zjhPPvEpzY4KY8/n66yy2qJZ7JZ1PkdmHcn3mGLUyyRUw+HCUdJe5MX13s
         3RCleU2ePx0mry28SqKapa6jV2Py3zwCN5MgcimyPauskbXfATEl5bb4/kzZ+kcAFRYG
         qYJ4xBzUwZU2f8KIG7AHLBTxmMf+PnxslXAtrMeRBSl0rQ0+TCSohV+x1oNi5tcoyA8q
         8EXg==
X-Gm-Message-State: AJIora8FdlJD85D83fltqSy4WgxCdK21OvBQatRkQt/D1JBhqjurI0QM
        GuDSimFr5jC6t9ISCiu1SXrxzqH34rJMJBY=
X-Google-Smtp-Source: AGRyM1uTdRObXadkhKk8dqeBRkPE7nkI8OlKAnAFHGJCVWL1ZmgYKW6yAh1C6mkJHRpUKnzPDiGVUw==
X-Received: by 2002:a17:906:e4c:b0:726:94a0:2701 with SMTP id q12-20020a1709060e4c00b0072694a02701mr9981194eji.360.1656354220511;
        Mon, 27 Jun 2022 11:23:40 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id f26-20020a170906139a00b006ff045d7c9bsm5291852ejc.173.2022.06.27.11.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:23:34 -0700 (PDT)
Date:   Mon, 27 Jun 2022 18:23:25 +0000
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
Message-ID: <Yrn1nQU3h+vHK1nz@google.com>
References: <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
 <874k0863x8.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
 <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
 <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
 <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
 <87y1xkwa28.fsf@email.froward.int.ebiederm.org>
 <YrjxcR2M6AD6S9dW@google.com>
 <YrlYDppYKw6HRP1j@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrlYDppYKw6HRP1j@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 09:11:10AM +0200, Peter Zijlstra wrote:
> Current freezer can thaw at random points in time, even before SMP
> bringup if you're unlucky. And yes, I think it can induce 'spurious'
> wakeups as well.

Thanks, Peter, that's good to know!

> But really; like Linus already said upsteam, every wait loop *MUST*
> already be able to deal with spurious wakeups. This is why pretty much
> every wait primitive we have looks like:
> 
> 	for (;;) {
> 		set_current_state(state);
> 		if (cond)
> 			break;
> 		schedule();
> 	}
> 	__set_current_state(RUNNING);
> 
> Which is immune to random wake-ups since it need @cond to make progress.
> *NEVER* rely on just the wakeup itself for progress, that's buggy as
> heck in lots of ways.

Yes, I wonder how many more instances of this kind of bug we have
lurking around given that this one in core kernel code appears to have
been around for at least 17 years.
