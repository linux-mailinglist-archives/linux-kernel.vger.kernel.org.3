Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB9E5AFDA0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiIGHfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIGHfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:35:31 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC3F696D2;
        Wed,  7 Sep 2022 00:35:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t14so11668238wrx.8;
        Wed, 07 Sep 2022 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=G7xwTind6N9o2m8bAirX5kUmP0tC0+8Cc5QcO/CVIY0=;
        b=JMwU0xpnmep6WLrllYxoPua3Ovtq7qcu4SIxCUl/63Gh8ppaxqJzS/j8XPiCCgr2gB
         Bt7/A//nysa8L6hK5wbqg4M2Flc82nqfQ2g2X1GHZKuIYzaVTRV1i16kWeeXnaOqiDhh
         F8HcnGFfk2xlgQZeOV4wPUNPzYEwP0cly33iOSbv9E5qCAW39JYuimxu2YfQM8H/iOqq
         5EGCp5b1nRHh/1XHZ85kCsXbotKmgxAF55iUOswrPlQPZiViBIOPvULx89JrrEI7HKdY
         0gKU6YcDsj2AhxY1XzLTzqxo9uHXRbCZyGXHwnqdKgIt6UCJQrOxf2djYMRhJKKcVDMn
         jetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=G7xwTind6N9o2m8bAirX5kUmP0tC0+8Cc5QcO/CVIY0=;
        b=wIjY3guUxOXVpQSUMssfs7MEIoBrJk2qKShIp1TIKyWW0m7z63QU+v97mmqd7f0U7C
         /fFq1jPeKLT8UAirMHOePaSiVZPqi+Ocm/8VxON+zqr2rhwlfnL0IUDybfQtUFfrn+NB
         3rJbnDyYnFV0/lMVBGre7MASHIKI4P1QoOaU3zNVFP84z2mqEmOTnamCnIcqptJZf1LY
         Z8eydbD6nRaRWotbT0oDiqgVDCfMpm9NwoY55CvKoBhybnNIYyRBZ4MEOVHtOr8M1WOe
         oTUYuUnL/tuEUXwoBWGlcEzYaIzmfkXiSpcf65VnGe5MigRFSziKxcNtRO1usyScG+MV
         pzxQ==
X-Gm-Message-State: ACgBeo1yFJj9BqBCDvoIhr/gFTlA2znYm9cqjhfP8aHcu6OM9uW/xL1/
        AY8Wb9ADP73WBZD7b3Ke4n8=
X-Google-Smtp-Source: AA6agR7Qe9YPlr8euWF6gaEF/FFBA7YwmCbHiB6lyheaSEd3izGNCOXAdCkLXxavmTZ6mvPAc7U9rA==
X-Received: by 2002:a5d:6c6f:0:b0:226:f30d:95ba with SMTP id r15-20020a5d6c6f000000b00226f30d95bamr1222905wrz.170.1662536124584;
        Wed, 07 Sep 2022 00:35:24 -0700 (PDT)
Received: from gmail.com (1F2EF41B.nat.pool.telekom.hu. [31.46.244.27])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d4302000000b0021e51c039c5sm15836032wrq.80.2022.09.07.00.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 00:35:23 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 7 Sep 2022 09:35:20 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/6] sched/completion: Add wait_for_completion_state()
Message-ID: <YxhJuHMvTgv4s1pV@gmail.com>
References: <20220822111816.760285417@infradead.org>
 <20220822114648.922711674@infradead.org>
 <YxSB85+BamWFj5xw@gmail.com>
 <Yxcfx/NvzMm3wRTU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxcfx/NvzMm3wRTU@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Sep 04, 2022 at 12:46:11PM +0200, Ingo Molnar wrote:
> > 
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > Allows waiting with a custom @state.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  include/linux/completion.h |    1 +
> > >  kernel/sched/completion.c  |    9 +++++++++
> > >  2 files changed, 10 insertions(+)
> > > 
> > > --- a/include/linux/completion.h
> > > +++ b/include/linux/completion.h
> > > @@ -103,6 +103,7 @@ extern void wait_for_completion(struct c
> > >  extern void wait_for_completion_io(struct completion *);
> > >  extern int wait_for_completion_interruptible(struct completion *x);
> > >  extern int wait_for_completion_killable(struct completion *x);
> > > +extern int wait_for_completion_state(struct completion *x, unsigned int state);
> > >  extern unsigned long wait_for_completion_timeout(struct completion *x,
> > >  						   unsigned long timeout);
> > >  extern unsigned long wait_for_completion_io_timeout(struct completion *x,
> > > --- a/kernel/sched/completion.c
> > > +++ b/kernel/sched/completion.c
> > > @@ -247,6 +247,15 @@ int __sched wait_for_completion_killable
> > >  }
> > >  EXPORT_SYMBOL(wait_for_completion_killable);
> > >  
> > > +int __sched wait_for_completion_state(struct completion *x, unsigned int state)
> > > +{
> > > +	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, state);
> > > +	if (t == -ERESTARTSYS)
> > > +		return t;
> > > +	return 0;
> > 
> > Nit: newline missing after local variable definition.
> 
> Yah, I know, but all the other similar functions there have the same
> defect. I don't much like whitespace patches, so I figured I'd be
> consistent and let it all be for now.

That's not actually true: there's ~7 functions in kernel/sched/completion.c 
with local variables, and only ~2 have this minor stylistic inconsistency 
right now AFAICS. Scheduler-wide the ratio is even lower.

So even if a patch doesn't entirely remove the residual noise, let's not 
add to it, please?

Thanks,

	Ingo
