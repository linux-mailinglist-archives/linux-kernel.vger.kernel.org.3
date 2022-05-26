Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64609534EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344778AbiEZMJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344593AbiEZMJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:09:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2A7D4117
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:09:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AA118219D8;
        Thu, 26 May 2022 12:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653566969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=phqfNrEIjHjcmSy2NtJdwNwEt4kQ6Q/HthoJupOyo3o=;
        b=nGIlC3xjdQ4uVkeIdZumF59Kw2oHOppe2WhsanwD3ow0nZNY7e2nneWdExM0b3unwVsecT
        tm5k2Doh7ookLckQRrKgtA8pNJGJaWSDNCmgUwhLBjI/YhNSXdQL5g2fZciNeY4uh4hK07
        9rFduEtTi+sgfW3Kjn3BpwCiyg9CPFg=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1B7C82C141;
        Thu, 26 May 2022 12:09:29 +0000 (UTC)
Date:   Thu, 26 May 2022 14:09:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] printk for 5.19
Message-ID: <Yo9t9Vg/DpvMqCs7@alley>
References: <YouKQw72H7y9EJQK@alley>
 <CAHk-=wgC47n_7E6UtFx_agkJtLmWOXGsjdFjybBFYNA1AheQLQ@mail.gmail.com>
 <87pmk1tgmx.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmk1tgmx.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-05-26 00:08:46, John Ogness wrote:
> On 2022-05-25, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > On Mon, May 23, 2022 at 6:21 AM Petr Mladek <pmladek@suse.com> wrote:
> >> There are situations when the kthreads are either not available or
> >> not reliable, for example, early boot, suspend, or panic. In these
> >> situations, printk() uses the legacy mode and tries to handle
> >> consoles immediately.
> >
> > Looking through the commits, I don't see how that "printk: wake up all
> > waiters" makes any sense at all.
> >
> > It *ALREADY* woke up all waiters as far as I can see.
> >
> > Doing a wake_up_interruptible() will stop waking things up only when
> > it hits a *exclusive* waiter, and as far as I can tell, there are no
> > exclusive waiters there.
> 
> You are correct. @log_wait never has exclusive waiters. I will post a
> patch to revert the change in question.

John, Yes, please do so.

> > But when I see something really core like printk() get confused and
> > mis-understand basic wait queue behavior, that makes me go "This is
> > WRONG".

Linus, thanks a lot for catching and explaining the problem.

Yeah, it is a shame. I have met code with exclusive waiters only once,
8 years ago and completely forgot about it. I was curious how it
worked with more log waiters but I put it into TODO list. The new
code looked safe and I was too focused on finding potential problems.

Best Regards,
Petr
