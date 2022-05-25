Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3347253462A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345066AbiEYWC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiEYWCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:02:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604EC666B9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:02:54 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653516167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ko3tVBSTvXmk/EJ63Xa6wkbIGpFeqWXJmZYiv5w7gsE=;
        b=zWL1+xn9tGuKoGNgX9h/92eiBQWYEolUJ1Og04+18wvN5A6uf2BeavHw7NaCzG2PFm9Mio
        bS78G+Dpf7cdeSwsOGd5k56NG9KD1Trqz2xakCWFiAbGnJKY2JqGq5U38R+ZdkvcTw0n0E
        4AzYHZ3ysIpvjgz46Yk8szXcdI2AKXqLWSrp6Qym2mEW+TrD+ZM5Hn/6G5tyzv926/Nk/h
        NB4UEGYSOpDEeNz/N0mcSFASjM5YUe7RFeGWyzXcWIgV0XJE9g+y5KP/EX1U1fFDRrpnfJ
        XK1cuHIV4bcjNSfOfiLl+gThRetI5Cw7WLCZ8zyOBLejdkAbSY4pbWP5WLdhww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653516167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ko3tVBSTvXmk/EJ63Xa6wkbIGpFeqWXJmZYiv5w7gsE=;
        b=CO6+5Oz/7S35pvsSlVQZP4iIWCSLpHyZ5ii8ZtrZ3erMaZKe/btURKj+zzJhGhdcKtqVqN
        p63ywilq9VY/NKBg==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] printk for 5.19
In-Reply-To: <CAHk-=wgC47n_7E6UtFx_agkJtLmWOXGsjdFjybBFYNA1AheQLQ@mail.gmail.com>
References: <YouKQw72H7y9EJQK@alley>
 <CAHk-=wgC47n_7E6UtFx_agkJtLmWOXGsjdFjybBFYNA1AheQLQ@mail.gmail.com>
Date:   Thu, 26 May 2022 00:08:46 +0206
Message-ID: <87pmk1tgmx.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-25, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, May 23, 2022 at 6:21 AM Petr Mladek <pmladek@suse.com> wrote:
>> There are situations when the kthreads are either not available or
>> not reliable, for example, early boot, suspend, or panic. In these
>> situations, printk() uses the legacy mode and tries to handle
>> consoles immediately.
>
> Let's see how this works out, but I do have one complaint/query about
> the series.
>
> Looking through the commits, I don't see how that "printk: wake up all
> waiters" makes any sense at all.
>
> It *ALREADY* woke up all waiters as far as I can see.
>
> Doing a wake_up_interruptible() will stop waking things up only when
> it hits a *exclusive* waiter, and as far as I can tell, there are no
> exclusive waiters there.

You are correct. @log_wait never has exclusive waiters. I will post a
patch to revert the change in question.

Until now, I never took the time to investigate if there were any
exclusive waiters. I just wanted to be sure that all waiters wake up,
regardless of their type. But obviously the patch is unnecessary with
the currently implemented waiters.

> That "all()" form is only for when there are exclusive waiters (that
> are expected to handle the situation entirely, or wake up the next
> waiter if they don't), *and* you have some exceptional thing that then
> causes *ALL* waiters to need to be woken up.
>
> For example, a "read()" might be an exclusive wait, so that multiple
> potential concurrent readers don't cause a scheduling herd of
> processes all to wake up when somebody writes to the socket or pipe or
> whatever.
>
> So in that situation a write() uses a regular wakeup, so that we only
> wake up the one waiter that will take care of things.
>
> But then a *shutdown* event obviously does affect everybody, so that
> would cause a "wake_up_interruptible_all()".

Thank you for taking the time to clarify the use case for all(). Such a
use case currently does not exist for printk.

> I'm sure we have lots of drivers that are confused about core things
> like this, and I don't really care.
>
> But when I see something really core like printk() get confused and
> mis-understand basic wait queue behavior, that makes me go "This is
> WRONG".

You are correct to question a series when something like this in core
code is found. I cannot guarantee that every line is perfect, but this
series does have a great deal of dedicated review, discussion, revision,
and heavy testing behind it.

Petr has done a great job of requiring these kinds of changes as
separate commits, which certainly helps to identify any false steps.

Thank you for taking extra time to scrutinize this series.

John Ogness
