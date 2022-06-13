Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD15481C3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiFMIQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiFMIQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:16:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20546405
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:16:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4165A6116D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24C6C34114;
        Mon, 13 Jun 2022 08:16:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VGc7c2pg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655108180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=377RJOU6sXmw8TRA4z22hZDpm5Qe1b35ciygwf8mWh8=;
        b=VGc7c2pggzQFgNam+ItHc86Py3E3NFOjNxxHpgJNl4Oy3SF/ICFvrPrtFZchTrvLPMpN6L
        VYkGM5/2erILMOsDo7p08lbhi2XrCl0K7zbB4itCvDEiXh/lbkUw92XRdWUDjKq8X3EUag
        vIC+zEl2ArCaOYX0nyCfrjIWt3bhZao=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 94c0e31d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 13 Jun 2022 08:16:19 +0000 (UTC)
Date:   Mon, 13 Jun 2022 10:16:17 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking/lockdep: Use sched_clock() for random numbers.
Message-ID: <YqbyUfp8e4CZoFBT@zx2c4.com>
References: <YoNn3pTkm5+QzE5k@linutronix.de>
 <YoNwp+9ko89Tf1ep@zx2c4.com>
 <Yqbv17P9eLH0YdPG@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yqbv17P9eLH0YdPG@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:05:43AM +0200, Peter Zijlstra wrote:
> On Tue, May 17, 2022 at 11:53:43AM +0200, Jason A. Donenfeld wrote:
> > Hi Sebastian,
> > 
> > Interesting RT consideration. I hope there aren't too many of these
> > special cases that would necessitate a general mechanism. Fingers
> > crossed this is the only one.
> > 
> > On Tue, May 17, 2022 at 11:16:14AM +0200, Sebastian Andrzej Siewior wrote:
> > > -			cookie.val = 1 + (prandom_u32() >> 16);
> > > +			cookie.val = 1 + (sched_clock() & 0xffff);
> > >  			hlock->pin_count += cookie.val;
> >  
> > I have no idea what the requirements here are.
> 
> Mostly nothing. It's debug code, and if someone wants to circumvent they
> can, but then their code is ugly and stands out like a sort thumb which
> then serves its goal as it won't pass review etc..
> 
> > What would happen if you
> > just did atomic_inc_return(&some_global) instead? That'd be faster
> > anyhow, and it's not like 16 bits gives you much variance anyway...
> 
> That would in fact be slower, sched_clock() will, on any sane hardware,
> be a rdtsc, mul and shr, which are all local.

Fine by me. Given Sasha's comment, we should probably get this queued up
in somebody's tree asap?

Jason
