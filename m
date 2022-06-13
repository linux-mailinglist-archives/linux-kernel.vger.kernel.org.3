Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498E75481CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbiFMIGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiFMIGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:06:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3567D1DA66
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8ffIOw5XsQfPp5hHz5PV6qY3XyAav+N05RmGhN9z6Ps=; b=SINAdsM/DQ9UeRWwaSUKeDaP6d
        uupQQcpR1Zntn2XNgifUeiWUXFaS+Tmt9lYuEHWqemLTXYKxTHbZuasn/oaHvhELKH9E+Ec6uK3mM
        iCE+/35L6vE0RRFzMDMuGJ+kY8WTlnmvmR/JFN/rDwidc7fOR2b8/c5co9aOZwx4Qb9uXp9Ba9AD3
        66Ncl0QNU2H6ZkVodeohuTkbtGMs8wpnYw7c/wvSH5z77DoyftwHYlUSUltxV3PvOEvcoUH+EFRS3
        sdsIHbm+St+aAVFx8ATx67w18dsc8qg+3bqIW/40kkeW1YDyYeSVsC1+5010tTyxToHkxQVbeBmTz
        f3Obi5jg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0f50-007VHj-6I; Mon, 13 Jun 2022 08:05:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6CDF3005B7;
        Mon, 13 Jun 2022 10:05:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1CDE28498CA5; Mon, 13 Jun 2022 10:05:43 +0200 (CEST)
Date:   Mon, 13 Jun 2022 10:05:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking/lockdep: Use sched_clock() for random numbers.
Message-ID: <Yqbv17P9eLH0YdPG@hirez.programming.kicks-ass.net>
References: <YoNn3pTkm5+QzE5k@linutronix.de>
 <YoNwp+9ko89Tf1ep@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoNwp+9ko89Tf1ep@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 11:53:43AM +0200, Jason A. Donenfeld wrote:
> Hi Sebastian,
> 
> Interesting RT consideration. I hope there aren't too many of these
> special cases that would necessitate a general mechanism. Fingers
> crossed this is the only one.
> 
> On Tue, May 17, 2022 at 11:16:14AM +0200, Sebastian Andrzej Siewior wrote:
> > -			cookie.val = 1 + (prandom_u32() >> 16);
> > +			cookie.val = 1 + (sched_clock() & 0xffff);
> >  			hlock->pin_count += cookie.val;
>  
> I have no idea what the requirements here are.

Mostly nothing. It's debug code, and if someone wants to circumvent they
can, but then their code is ugly and stands out like a sort thumb which
then serves its goal as it won't pass review etc..

> What would happen if you
> just did atomic_inc_return(&some_global) instead? That'd be faster
> anyhow, and it's not like 16 bits gives you much variance anyway...

That would in fact be slower, sched_clock() will, on any sane hardware,
be a rdtsc, mul and shr, which are all local.
