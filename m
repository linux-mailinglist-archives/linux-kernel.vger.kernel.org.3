Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C3E4B5428
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355609AbiBNPGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:06:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355601AbiBNPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:06:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31036B84F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:06:41 -0800 (PST)
Date:   Mon, 14 Feb 2022 16:06:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644851199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ffmDmCgww43CwxuLJqy8ALswx+JnwgUCL+VZyLzQiE=;
        b=pZxVjmSngLvK43Shu4+ZvEImk75UAlp6+SguISjrMd67DF/fqREqAydfxQUMiSCKyQT5/K
        w1CemAhF82jFYTvMdGDI6wk54BegMmhsEZfI9rBKNwj4yfiPqH8orjM1u8TL8IeR0Q5rlV
        VP6KJn4nEJhT8DUodFSp4TmrTZvvBjQctIT8/o+AQpEPPRPowePKdXFx/UTYgsJlcgIGA0
        NJpwdXkEw5NF/L0RopRBqAbp8HKNFHrLZTdfULAg97UAOmMRrTkSV1XLhMXZkp4kSXp/0p
        gOeI6fo+YSNrWVnss19NwzZXwqpRSgKsoo94R80YyceDlA6gN8931hN66UiTlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644851199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ffmDmCgww43CwxuLJqy8ALswx+JnwgUCL+VZyLzQiE=;
        b=T5tNRo2pHZmK/Ij4qjMvCldM5bz7MzZRbKfHjxs5IBGGjr+tDI5asSmKtSvMaXPPgwt7UO
        U/2jL4EXtXMU8oBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] random: set fast pool count to zero in cpuhp teardown
Message-ID: <Ygpv/kLWCmTzUTki@linutronix.de>
References: <CAHmME9rAnh6nSRNYo56Ty6VSrY17ej35AoNkSjunFO0AQp1D9Q@mail.gmail.com>
 <20220214133735.966528-1-Jason@zx2c4.com>
 <Ygpkej/vnMvUDIlP@linutronix.de>
 <CAHmME9ruM85U+dp4coBRJUBdk=iHXFZq3ZvHSiDXmpV+BoZEVw@mail.gmail.com>
 <Ygpr9Xg0I+ZVzp9v@linutronix.de>
 <CAHmME9rp+O3+yjX_q-BS8y06PigbkEgi4vn=nzLACnBAWZt-vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9rp+O3+yjX_q-BS8y06PigbkEgi4vn=nzLACnBAWZt-vA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-14 15:52:34 [+0100], Jason A. Donenfeld wrote:
> On Mon, Feb 14, 2022 at 3:49 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2022-02-14 15:42:50 [+0100], Jason A. Donenfeld wrote:
> > > Hi Sebastian,
> > Hi Jason,
> >
> > > If we move this to startup, is there a phase during which no interrupt
> > > will arrive? That is, can this happen very very early in startup, so
> > > that zeroing out count happens *before* ++count?
> >
> > Interrupts will arrive starting with CPUHP_AP_ONLINE_IDLE from the CPU
> > HP point of view. My suggestion had a check for upper most bit and only
> > clear count if that bit was seen. So we wouldn't clear the counter if we
> > wouldn't suspect one of the rare corner cases.
> 
> That doesn't work for the other use cases I have for this (see the other patch).

But you acked my question regarding boot-up? So the teardown callback
won't happen during boot-up.

> So I think it seems better to keep it before CPUHP_TIMERS_PREPARE, but
> do it on startup rather than teardown. Seem reasonable? Would that
> mean we zero out before IRQs are enabled?
I would only zero it if the upper-most bit is there.
If you need (want) to reset the get_random_uXX() pools and such, there
is nothing wrong with having an early notifier at CPU up time before the
CPU gets active (say CPUHP_RANDOM_PREPARE) where you make sure that the
pools will re-fill during first usage.
And then have another one after CPUHP_AP_WORKQUEUE_ONLINE to ensure that
a possible scheduled worker between CPUHP_AP_ONLINE_IDLE and
CPUHP_AP_WORKQUEUE_ONLINE runs on the correct CPU. And this covers also
the rollback problem.

Sebastian
