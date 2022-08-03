Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE765890FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbiHCRI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiHCRI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:08:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDB518B13
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:08:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z16so22249882wrh.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 10:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dMyk+vGh97dwFGrHtgjmGaoaeUpNPz+yXvZWtKarsAQ=;
        b=Isv3ghlMDIeIF1lhKbk60FETWFH1rKqXWmJbXrnsX7IkeHypwhcx2rSHRmjoqfxtLA
         MpUyXXHIPf//JWKOQpT1oBGoSUgJggyFPuiY/LVTTVD/cHdvxpK9Bst7rGfsc2Xmx9Y6
         hwW7ocHyPgGVu6BAU0Unu84L7BrtnJaQmjxfLgCQxA2KnXe/868B2j4hIRHFRlHi23sZ
         MolPi4p7M/1XlwvmW247kFUpRkem7BpsXZludRJqaXG5CigiYfRNhFu4YAoDR7jyeKNL
         m3G6XgIYVsVaT6gA6MCtwf1zhV+nW10fGTH8jBCbEz18LSQeGvV/diCiHWhrkrR/Yj0L
         Px6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dMyk+vGh97dwFGrHtgjmGaoaeUpNPz+yXvZWtKarsAQ=;
        b=TptLc8lDw8mUpdEwnWXRuF+LJTHhXJpbPcZQlG6t8uLuj+m9LzA0qPkQrGVLWTfV5W
         coa85Phhn1J7nChRgDzMifbYWzuIhMU0UQ6uywudhDcQejrZAYnrBq1lOLXBR67K6Bfk
         crIs+bNynpd0S21mEkBvLbIcBdUjrADtwX1ZGZVRCRDui8GRqpz8Go4zZQHtkD9sJzt6
         Pp3ZRxd85rYBARoAbUm7f9NFEj2JQTaiaumf3Pj6WI8j2YR954bCeMSGqkRKaVaEHVu7
         nMadcJBPErbyjDVISDS5ILBga26DT3k3EZ8XKAiA1AgbXV9Bj+R5x2qWXnEK+GyPAueP
         I9zQ==
X-Gm-Message-State: ACgBeo0DqzixftciSfjD8SwhgzTQhs5Nsx8I5+H5vXWuXBOKKaj/J5GF
        3xKfjavJpaRxHO0tVI6s/NYmgKzNg4A=
X-Google-Smtp-Source: AA6agR5Cmj1toyThbOFQMulJaWwbyS1GynqdK7FieO+wnvW5tFFwWleXWMztiEZz/V71k0yI7yAMaA==
X-Received: by 2002:adf:e282:0:b0:21e:5546:5a26 with SMTP id v2-20020adfe282000000b0021e55465a26mr17395926wri.77.1659546533515;
        Wed, 03 Aug 2022 10:08:53 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id n36-20020a05600c502400b003a37d8b864esm3237524wmr.30.2022.08.03.10.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:08:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 3 Aug 2022 19:08:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] printk for 5.20
Message-ID: <YuqroyYLQua8y+L3@gmail.com>
References: <YufsTLpighCI7qSf@alley>
 <CAHk-=wie+VC-R5=Hm=Vrg5PLrJxb1XiV67Efx-9Cr1fBKCWHTQ@mail.gmail.com>
 <YuqXkCZEfsSKoIX6@alley>
 <CAHk-=wj0umHOtL1TB_7Tvinoqhxz6BnL-jEC0eQfVihHOmbWjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj0umHOtL1TB_7Tvinoqhxz6BnL-jEC0eQfVihHOmbWjw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Aug 3, 2022 at 8:43 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Tue 2022-08-02 20:19:34, Linus Torvalds wrote:
> > > And printing messages to a console is not some "oh, we'll just stop
> > > doing that because you asked for PREEMPT_RT".
> >
> > My thinking was that PREEMPT_RT was used only by some rather small
> > community that was very well aware of the upstream status. I kind of
> > though that this was their choice.
> 
> Oh, I agree that it probably is a pretty small community.
> 
> And I also think that people who are really into RT are basically
> always going to have extra patches anyway - I think the bulk of the
> core stuff has made it upstream, but not *all* has made it.
> 
> And the "real RT" people tend to also have long lead times - it's not
> just about "we need guaranteed latency", it also tends to be about
> "our hardware is special and stays around for years" too - and likely
> wouldn't ever really use upstream kernels directly anyway.
> 
> In fact, I don't think anybody can currently even enable PREEMPT_RT in
> an upstream kernel anyway without extra patches. Much of the RT
> infrastructure has been merged, but some of the grottier parts are
> literally just "to make it easier to maintain the real external
> patch".
> 
> So I agree with you that in reality it probably wouldn't really affect
> very many people, if any.
> 
> I suspect the most immediate effect would literally be people who want
> to experiment with it, "just because".
> 
> Not the serious RT users who probably have special hardware anyway and
> are likely to also have special debug interfaces (exactly _because_
> they have special latency concerns).

As a side note, Red Hat is productizing -rt, and in general lots of systems 
with non-broken hardware will work mostly fine under -rt. For the really 
hairy hard-realtime usecases a lot of verification is done - often as part 
of the project.

With all the 'edge computing' usecases arising & the automotive industry 
getting much more software-intense, I think it's a safe policy to make -rt 
less special & adhere to the same quality and upstream maintenance 
standards as regular Linux distributions.

In a few years PREEMPT_RT won't be all that special anymore, and working 
consoles are very much part of a usable product.

> So that's why I'd suspect that the actual effect would be on people who 
> just want to tinker with it, and download the necessary RT patches and 
> set up some data acquisition station for their own use or whatever.
> 
> But thinking some more about it, even the "serious RT" people almost 
> certainly don't really want some kind of static "disable it all". Not 
> even if it was a separate Kconfig question like I suggested.
> 
> You'd most likely want it to be dynamic, because things like "log to 
> console" is different at bootup when the system hasn't started yet - you 
> can't really have realtime response when your hardware hasn't even 
> initialized yet - and when things are actually running.
> 
> So I think even then you really just want a "turn off console logging" 
> dynamic flag, not a Kconfig option.
> 
> Which I think we already have, in the form of log levels. No?

Yeah:

  CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
  CONFIG_CONSOLE_LOGLEVEL_QUIET=4

What we could do is to set the default console loglevel really low by on 
PREEMPT_RT - say to 1. Serious crashes would still show up - but random 
console chatter wouldn't.

Thanks,

	Ingo
