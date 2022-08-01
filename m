Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFF5586C31
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiHANo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiHANoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:44:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A85795BB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:44:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7831B8119C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 13:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B59DC433C1;
        Mon,  1 Aug 2022 13:44:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="W/O0C4j5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659361458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AhoIl2LdEiU3EgVGZTGhOwseEVER6qH2H/xWKoB/EPQ=;
        b=W/O0C4j5e6b8ggtJVIpd+5tl1dnQXle7vVV6E5+qRjkGbSy7l7OM+C3gTQ4PERSmouM0xO
        2HEN0mgKegen4CSAJkrSJFQwhcgDlS2XREwm0o1RViXVGwOfS+qQwHPrt2nTUWYVvP4vTj
        wm9zRH1KCAqJPOupsTzOWBzPz957UH8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 48b358dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Aug 2022 13:44:17 +0000 (UTC)
Date:   Mon, 1 Aug 2022 15:44:12 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <YufYlRWneJkvIpr7@zx2c4.com>
References: <YufHN7fF0dROMETj@zx2c4.com>
 <20220801123945.43081-1-Jason@zx2c4.com>
 <YufLK6hio/v1gfmq@linutronix.de>
 <YufW4G/A3eQKpdjj@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YufW4G/A3eQKpdjj@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again,

On Mon, Aug 01, 2022 at 03:36:32PM +0200, Jason A. Donenfeld wrote:
> Hi Sebastian,
> 
> On Mon, Aug 01, 2022 at 02:46:35PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2022-08-01 14:39:46 [+0200], Jason A. Donenfeld wrote:
> > > On RT, we can't call get_random_bytes() from inside of the raw locks
> > > that callers of vsprintf might take, because get_random_bytes() takes
> > > normal spinlocks. So on those RT systems, defer the siphash key
> > > generation to a worker.
> > > 
> > > Also, avoid using a static_branch, as this isn't the fast path.
> > > Using static_branch_likely() to signal that ptr_key has been filled is a
> > > bit much given that it is not a fast path.
> > > 
> > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Reported-by: Mike Galbraith <efault@gmx.de>
> > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > > ---
> > > Sebastian - feel free to take this and tweak it as needed. Sending this
> > > mostly as something illustrative of what the "simpler" thing would be
> > > that I had in mind. -Jason
> > 
> > Can have the same behaviour regardless of CONFIG_PREEMPT_RT? Here
> > lockdep _may_ yell with !RT because it is broken for RT.
> > If we agree that we drop the first %p print here, can we do this on
> > both (regardless of CONFIG_PREEMPT_RT)?
> 
> "Lockdep may yell" -- but this would be when lockdep is turned on to
> catch RT bugs, not to catch non-RT bugs. The actual bug only exists on
> RT. This is an RT problem. Stop pretending that this is a real issue
> outside of RT. It isn't. This is *only* an RT issue. So why would we
> make things worse for an issue that doesn't actually exist on non-RT?
> 
> I too generally prefer having only one code path and not two. But the
> way this patch is written, the worker function just gets reused with a
> straight call on the non-RT case, so it doesn't actually require
> duplicating code.
> 
> Jason

By the way, another option that would be fine with me would be to make
random.c use all raw spinlocks. From a non-RT perspective, that wouldn't
change the codegen at all, so it doesn't make a huge difference to me.
From an RT perspective, it would presumably fix a lot of these issues,
and enable randomness to be available in any context, which is maybe
what we want anyway. From an RT-safety point of view, I suspect doing
this might actually be okay, because the locks are only ever protecting
operations that are fixed duration CPU-bound, like generating a chacha
block or something, not waiting for some I/O.

Thoughts on that?

Jason
