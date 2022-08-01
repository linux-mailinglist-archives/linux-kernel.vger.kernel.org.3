Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F4B5865AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 09:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiHAHcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 03:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHAHcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 03:32:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C18D2C122
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 00:32:51 -0700 (PDT)
Date:   Mon, 1 Aug 2022 09:32:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659339169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0lWex5vw1JdCmlOGVBXm1q0/d6SAMz/GZdYiASXTbCA=;
        b=4TGAW4OhyUhnniMGUlzZG/SIrYsZp3hnCND8w/0nR7/vwo3U/qyOI6MlKypTz4cgn8/0Bm
        scY89HO+dDGDr9e8Q8pfF9adpx9AZFjj8xsIn+Il9g+g2WVXEsnKTV4gPLkeAjFH8QDUGQ
        04Fo3a9OjapbZEvjR5CjG1OZrcoq5LK+aqBT8Uw7MCqKQM51zRGotyAzgWGs1vfG0eWWv8
        x+i+7ilG0dPwdONsQeiBSJHBDEtkw6WMkIlKabh86DVAZ5NvLKL3vRyc0nS9KnIahGzpn9
        MPfbQOj4iKX27sojdYwNdxzi3Rh3DiQzMJIaH+nuCQbn3k0wsWYdYvAO7rRsXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659339169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0lWex5vw1JdCmlOGVBXm1q0/d6SAMz/GZdYiASXTbCA=;
        b=d3Jn4OIXU9r3zbMWktHVp1exeOqYAnzQ3zwisw5LX2PZLSFgGUhhsRwG+5f8TTYGp6t1kd
        jO4j8j1PW3YGudCg==
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
Subject: Re: [PATCH 2/2 v2] lib/vsprintf: Initialize vsprintf's pointer hash
 once the random core is ready.
Message-ID: <YueBnnnnvpxxjE4N@linutronix.de>
References: <20220729154716.429964-1-bigeasy@linutronix.de>
 <20220729154716.429964-3-bigeasy@linutronix.de>
 <YuRtSGCfe2qxHrqT@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuRtSGCfe2qxHrqT@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-30 01:29:12 [+0200], Jason A. Donenfeld wrote:
> On Fri, Jul 29, 2022 at 05:47:16PM +0200, Sebastian Andrzej Siewior wrote:
> > +static void fill_ptr_key_workfn(struct work_struct *work)
> > +{
> > +	int ret;
> > +
> > +	ret = get_random_bytes_wait(&ptr_key, sizeof(ptr_key));
> 
> > +static int vsprintf_init_hashval(void)
> > +{
> > +	static DECLARE_WORK(fill_ptr_key_work, fill_ptr_key_workfn);
> > +
> > +	queue_work(system_unbound_wq, &fill_ptr_key_work);
> > +	return 0;
> > +}
> > +subsys_initcall(vsprintf_init_hashval)
> 
> I'm unsure how good of an idea this is; it'll wind up setting off the
> jitter entropy thing very early in init. It's probably a better idea to
> just schedule the worker the first time that the RNG is already
> initialized by some other means. Check `in_hardirq()` or something if
> you're worried about missing the first message.

I'm aware of in_hardirq() and this not the only I have to worry about.
The same is true for interrupts-off, preempt-off, BH-disabled, rcu-read
section.
If you don't want me to use get_random_bytes_wait(), would you prefer to
delay it to late_initcall() or would you rather prefer to schedule a worker
every other second until the RNG is ready?

> Jason

Sebastian
