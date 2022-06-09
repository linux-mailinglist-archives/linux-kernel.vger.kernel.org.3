Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DCC544B24
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244915AbiFIL7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242926AbiFIL7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:59:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292361A398
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:59:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F82660C93
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CF2C34114;
        Thu,  9 Jun 2022 11:59:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="qAkHwz2j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654775941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RJORkAj3NYvpFmB7Va3TCC7yJxwVqGg4INvFsRsC1Dc=;
        b=qAkHwz2jr4oCqOOVRj78DuuxoJkmmUX4fPRZKXfsz4meQuqHLz4LN0u/rjJFW5FdSmeY2Y
        CDTcMkoCYHq1luCGXvyHiVS5q3V+ByoO9LplbfpB90MaDetyPd5tE6XSQfZQB8ydr2Vt6c
        U7H+8O/1A8YthKJqeNeHEigJDa+s9/w=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5cfe460d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 9 Jun 2022 11:59:00 +0000 (UTC)
Date:   Thu, 9 Jun 2022 13:58:44 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
Message-ID: <YqHgdECTYFNJgdGc@zx2c4.com>
References: <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com>
 <Ymjy3rHRenba7r7R@alley>
 <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
 <87fslyv6y3.fsf@jogness.linutronix.de>
 <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
 <87k0b6blz2.fsf@jogness.linutronix.de>
 <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com>
 <87y1zkkrjy.fsf@jogness.linutronix.de>
 <CAMuHMdVmoj3Tqz65VmSuVL2no4+bGC=qdB8LWoB=vyASf9vS+g@mail.gmail.com>
 <87fske3wzw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fske3wzw.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Thu, Jun 09, 2022 at 01:25:15PM +0206, John Ogness wrote:
> (Added RANDOM NUMBER DRIVER and KFENCE people.)

Thanks.

> I am guessing you have CONFIG_PROVE_RAW_LOCK_NESTING enabled?
> 
> We are seeing a spinlock (base_crng.lock) taken while holding a
> raw_spinlock (meta->lock).
> 
> kfence_guarded_alloc()
>   raw_spin_trylock_irqsave(&meta->lock, flags)
>     prandom_u32_max()
>       prandom_u32()
>         get_random_u32()
>           get_random_bytes()
>             _get_random_bytes()
>               crng_make_state()
>                 spin_lock_irqsave(&base_crng.lock, flags);
> 
> I expect it is allowed to create kthreads via kthread_run() in
> early_initcalls.

AFAIK, CONFIG_PROVE_RAW_LOCK_NESTING is useful for teasing out cases
where RT's raw spinlocks will nest wrong with RT's sleeping spinlocks.
But nobody who wants an RT kernel will be using KFENCE. So this seems
like a non-issue? Maybe just add a `depends on !KFENCE` to
PROVE_RAW_LOCK_NESTING?

Jason
