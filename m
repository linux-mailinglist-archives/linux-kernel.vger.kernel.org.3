Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE79586CD9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiHAOaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiHAOaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7245613D1C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BD866135A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B0AC433C1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:30:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VXSUTBbC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659364216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T5od+pWTdZT31c35bBpOeiRZ1hQtQn5soCMPTxgNgyc=;
        b=VXSUTBbCSVCUy3k+XCCmcREMlmA9tuQhtEoa7rDnGWPjjeRUHZJMkzrWEL9oFmB0CTTxWy
        u4wzZqBBjqXEA88V4bV67+wZzcuqqeY5BXKwGWJRfaZK0vYyv92L2jX40diZFsno1TIsjD
        txwaMAQNcX9e8a1R/JCx5EcdqTD3PO4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 57a3b324 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 1 Aug 2022 14:30:16 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id 204so18010718yba.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 07:30:15 -0700 (PDT)
X-Gm-Message-State: ACgBeo0IG+ss2Stjxj8NzfQPRW+hB5XBOiRyUDibx6MosNYRJ8Cz0EnW
        TIkKPVW0Kf/Ir6fIxXDiGg6CSD9RieVyh6hijEk=
X-Google-Smtp-Source: AA6agR593IG9cSeAyRQ2sWXiCmrDxP1l301ogdBxGPy1fvWoLjmaNC2PAyCx/9eZop+uujAdmeG5PLPzR++vqKli25Q=
X-Received: by 2002:a25:504c:0:b0:671:794d:5171 with SMTP id
 e73-20020a25504c000000b00671794d5171mr11412490ybb.231.1659364214665; Mon, 01
 Aug 2022 07:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <YufHN7fF0dROMETj@zx2c4.com> <20220801123945.43081-1-Jason@zx2c4.com>
 <YufLK6hio/v1gfmq@linutronix.de> <YufW4G/A3eQKpdjj@zx2c4.com>
 <YufYlRWneJkvIpr7@zx2c4.com> <YufiYOOvnnioHK/1@linutronix.de>
In-Reply-To: <YufiYOOvnnioHK/1@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 1 Aug 2022 16:30:03 +0200
X-Gmail-Original-Message-ID: <CAHmME9qPVszZqgDBhUUMMhnbg8y1-1rVC+rikPuwt+B-=7P4Lw@mail.gmail.com>
Message-ID: <CAHmME9qPVszZqgDBhUUMMhnbg8y1-1rVC+rikPuwt+B-=7P4Lw@mail.gmail.com>
Subject: Re: [PATCH v4] lib/vsprintf: defer filling siphash key on RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Mon, Aug 1, 2022 at 4:25 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-08-01 15:44:12 [+0200], Jason A. Donenfeld wrote:
> > Hey again,
> Hi Jason,
>
> > By the way, another option that would be fine with me would be to make
> > random.c use all raw spinlocks. From a non-RT perspective, that wouldn't
> > change the codegen at all, so it doesn't make a huge difference to me.
> > From an RT perspective, it would presumably fix a lot of these issues,
> > and enable randomness to be available in any context, which is maybe
> > what we want anyway. From an RT-safety point of view, I suspect doing
> > this might actually be okay, because the locks are only ever protecting
> > operations that are fixed duration CPU-bound, like generating a chacha
> > block or something, not waiting for some I/O.
> >
> > Thoughts on that?
>
> That random-core change regarding random numbers broke lockdep, kasan (I
> think) and now printk's %p. Each one of them appears to be exceptional
> since we don't have _that_ many users asking for random numbers in
> atomic context.

Actually, the printk %p case was caused by something different than
the other. This used to be initialized with a clunky notifier callback
mechanism, which I got rid of, replacing it with this direct thing.
It's this direct thing that's now causing problems on RT.

> Making the locks raw would indeed solve all the issues at once. Last
> time I was looking into this, would include three locks and I tried to
> trigger the worst-case via "re-seed" and this was visible back then.
> After the rework you did back thinks looked good.

I actually just sent a patch for that to you a second ago:
https://lore.kernel.org/lkml/20220801142530.133007-1-Jason@zx2c4.com/

It's only two locks, and usage seems pretty constrained in a good way.
So okay, if you're on board, let's just do that, and then printk can
stay the same.

Jason
