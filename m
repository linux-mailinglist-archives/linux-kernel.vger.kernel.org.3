Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE60586CC5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiHAOZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiHAOZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:25:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD51237D1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:25:40 -0700 (PDT)
Date:   Mon, 1 Aug 2022 16:25:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659363938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hhwJ1F3WVpTSQJ8rrhv/hn2pNa9HKmdJf5hwgaR8bOY=;
        b=c9NHSJZR9vw3IkH5dBl3uSg+HjOJOFuiteB4t5HfV3PVy4Hh2qQdGZy9/kjorjKG16YV9f
        yVi+BDvQOLkiRerE7LrbxxxUI4d9SjFahYePrORb/Z+ibLo8cOAvSkjS2C+hm8VvXxjN6I
        7no5Twe4JJOKHvn+JyNVBiMmemSfEYcBzEC1cu+HNwDCC+JXw9xsq37VruM/oLzOClCzn2
        kvy8LKHH8lKNe5RUdqsgO3D1MWalmIrUhv6+2d0ILo+SFw7tcQajGyLMIHbJVFk8gLVAtO
        /bkGfjdMePF0PjQ2pC1fyrogkWHUw4ZM5vmGWHpd5HeruSR2YqEPj4BhQ6VJww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659363938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hhwJ1F3WVpTSQJ8rrhv/hn2pNa9HKmdJf5hwgaR8bOY=;
        b=qPL5iuWwNg4fP3K5SGihD5bCcj7ttOG5n1n9yFg42WKq8P+qSx1FYh0Ae4+EX8E6flwRwW
        +HvzVAzeALDp1gAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4] lib/vsprintf: defer filling siphash key on RT
Message-ID: <YufiYOOvnnioHK/1@linutronix.de>
References: <YufHN7fF0dROMETj@zx2c4.com>
 <20220801123945.43081-1-Jason@zx2c4.com>
 <YufLK6hio/v1gfmq@linutronix.de>
 <YufW4G/A3eQKpdjj@zx2c4.com>
 <YufYlRWneJkvIpr7@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YufYlRWneJkvIpr7@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-01 15:44:12 [+0200], Jason A. Donenfeld wrote:
> Hey again,
Hi Jason,

> By the way, another option that would be fine with me would be to make
> random.c use all raw spinlocks. From a non-RT perspective, that wouldn't
> change the codegen at all, so it doesn't make a huge difference to me.
> From an RT perspective, it would presumably fix a lot of these issues,
> and enable randomness to be available in any context, which is maybe
> what we want anyway. From an RT-safety point of view, I suspect doing
> this might actually be okay, because the locks are only ever protecting
> operations that are fixed duration CPU-bound, like generating a chacha
> block or something, not waiting for some I/O.
> 
> Thoughts on that?

That random-core change regarding random numbers broke lockdep, kasan (I
think) and now printk's %p. Each one of them appears to be exceptional
since we don't have _that_ many users asking for random numbers in
atomic context.
Making the locks raw would indeed solve all the issues at once. Last
time I was looking into this, would include three locks and I tried to
trigger the worst-case via "re-seed" and this was visible back then.
After the rework you did back thinks looked good.

> Jason

Sebastian
