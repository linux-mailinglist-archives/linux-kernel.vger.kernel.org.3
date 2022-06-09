Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BF0544B95
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245329AbiFIMS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245324AbiFIMS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:18:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFBD1F2DA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:18:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50BBF617E4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CBFC34114;
        Thu,  9 Jun 2022 12:18:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nPButqce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654777131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QcC0C5Avs6rzR+CXyutM5LVS60s9Gr59fufuQSrdYzU=;
        b=nPButqceNog3QoAuGe+Xo1aWY+jmFC0oKkdxJA/HlfNn5gyJSkY048+8YUEgC5k/QiUqka
        snl7ctXLVINTE8vFcoeFAQb+YNAb3GmPZvMNxB0d88MsS4gqQYLDYtvFL343DDZUwFyRY9
        nzxx5xl+dUBR8Me2Q1rFhIsG3eVBFbQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id de5c4ac3 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 9 Jun 2022 12:18:51 +0000 (UTC)
Date:   Thu, 9 Jun 2022 14:18:44 +0200
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
Message-ID: <YqHlJDh1MSYJWBnu@zx2c4.com>
References: <Ymjy3rHRenba7r7R@alley>
 <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
 <87fslyv6y3.fsf@jogness.linutronix.de>
 <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
 <87k0b6blz2.fsf@jogness.linutronix.de>
 <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com>
 <87y1zkkrjy.fsf@jogness.linutronix.de>
 <CAMuHMdVmoj3Tqz65VmSuVL2no4+bGC=qdB8LWoB=vyASf9vS+g@mail.gmail.com>
 <87fske3wzw.fsf@jogness.linutronix.de>
 <YqHgdECTYFNJgdGc@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqHgdECTYFNJgdGc@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again,

On Thu, Jun 09, 2022 at 01:58:44PM +0200, Jason A. Donenfeld wrote:
> Hi John,
> 
> On Thu, Jun 09, 2022 at 01:25:15PM +0206, John Ogness wrote:
> > (Added RANDOM NUMBER DRIVER and KFENCE people.)
> 
> Thanks.
> 
> > I am guessing you have CONFIG_PROVE_RAW_LOCK_NESTING enabled?
> > 
> > We are seeing a spinlock (base_crng.lock) taken while holding a
> > raw_spinlock (meta->lock).
> > 
> > kfence_guarded_alloc()
> >   raw_spin_trylock_irqsave(&meta->lock, flags)
> >     prandom_u32_max()
> >       prandom_u32()
> >         get_random_u32()
> >           get_random_bytes()
> >             _get_random_bytes()
> >               crng_make_state()
> >                 spin_lock_irqsave(&base_crng.lock, flags);
> > 
> > I expect it is allowed to create kthreads via kthread_run() in
> > early_initcalls.
> 
> AFAIK, CONFIG_PROVE_RAW_LOCK_NESTING is useful for teasing out cases
> where RT's raw spinlocks will nest wrong with RT's sleeping spinlocks.
> But nobody who wants an RT kernel will be using KFENCE. So this seems
> like a non-issue? Maybe just add a `depends on !KFENCE` to
> PROVE_RAW_LOCK_NESTING?

On second thought, the fix is trivial:
https://lore.kernel.org/lkml/20220609121709.12939-1-Jason@zx2c4.com/

Jason
