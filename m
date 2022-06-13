Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4F1548169
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbiFMILq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239632AbiFMILP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:11:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9DC1E3EC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kQFuI5WIRgEaLqqCH7f6vg31Muj2sr6SY+iwmeaTlAk=; b=hfS+fEIhq4+wL9VkrEjtrb2sBc
        GD2kFn6Wy5AzTLkDRZqZd1zkqEZ5t0tQHZWDJaldPpBwbE7dv4+CVCro1QSVxN1SQDYXXf5kNLUbQ
        scRWzJVQIyVoMMD/G4nYo1GtdURU++YcijicgXISemALtDLz+PhASppmvHoRE0Wx6EVs2fVB/9jWN
        +Uh8qYJLPdwheh9utkj3MG+QGQptxsRrX4mGz/tHgGYrIhbPKeXg/zEpXl77BtCOvZxZfjXDkCPjR
        9GHT3eH6OP7CAg+jHVPlSF37LCrW/WRnQg1lkRqoHjZ+OJBKs/SeeG8s0KzjYxD9nOk/6X3uPxmmG
        Cdux/mJw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0fA7-007VK4-GF; Mon, 13 Jun 2022 08:11:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0EED3300472;
        Mon, 13 Jun 2022 10:11:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED02928498CA5; Mon, 13 Jun 2022 10:11:02 +0200 (CEST)
Date:   Mon, 13 Jun 2022 10:11:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking/lockdep: Use sched_clock() for random numbers.
Message-ID: <YqbxFn7EORqg7nXR@hirez.programming.kicks-ass.net>
References: <YoNn3pTkm5+QzE5k@linutronix.de>
 <YoNwp+9ko89Tf1ep@zx2c4.com>
 <YoNx9w1QocBY/P0I@zx2c4.com>
 <YoOQLJeQtpY9gHMm@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoOQLJeQtpY9gHMm@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 02:08:12PM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-05-17 11:59:19 [+0200], Jason A. Donenfeld wrote:
> > On Tue, May 17, 2022 at 11:53:43AM +0200, Jason A. Donenfeld wrote:
> > > Hi Sebastian,
> 
> Hi Jason,
> 
> > > Interesting RT consideration. I hope there aren't too many of these
> > > special cases that would necessitate a general mechanism. Fingers
> > > crossed this is the only one.
> 
> lockdep is special here. Haven't seen other explosions so far ;)
> 
> > > On Tue, May 17, 2022 at 11:16:14AM +0200, Sebastian Andrzej Siewior wrote:
> > > > -			cookie.val = 1 + (prandom_u32() >> 16);
> > > > +			cookie.val = 1 + (sched_clock() & 0xffff);
> > > >  			hlock->pin_count += cookie.val;
> > >  
> > > I have no idea what the requirements here are. What would happen if you
> > > just did atomic_inc_return(&some_global) instead? That'd be faster
> > > anyhow, and it's not like 16 bits gives you much variance anyway...
> 
> it might work I guess. PeterZ? Would this_cpu_inc_return() work?

Probably. But sched_clock() is plenty fine enough. No need to waste
space on a variable.

> 
> > Also, what is that `1 +` doing there? If the intention is to make sure
> > this is non-zero, you might want the mask to be 0xfffe? Or you're
> > counting on the assigned type being a u32 so it all overflows into the
> > next zone the way you want it? Kinda weird.
> 
> hmm. It used to be 1 before prandom_u32() was introduced and the point
> is probably to have a cookie != 0. val and pin_count are both unsigned
> int/ 32bit so that overflow doesn't matter.

Right, must not be 0.
