Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9166357BB73
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiGTQfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiGTQfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:35:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E853DFC8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:35:38 -0700 (PDT)
Date:   Wed, 20 Jul 2022 18:35:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658334937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SzYRnD31ArqphC0obldOfpyK/WHzS0mU3rD8NaHRSIA=;
        b=MhXKKELCiFUtQIMxk+GCPPNViSq49vf098g8smouuZ3hUsvVqPI49oErJ+SDFegV6U5ZYw
        oX3Nx6iphsBoRvAJIkae9Mc+otT7n0kQg1FYrUVkZnpDmlfF1ZlLRNPJ1Nj9exnmdtMGzO
        MfuPEZTTqLAKPMVdsU2Swv9yOyYkB9IhCE2cRRQi30HNbYSBKjDkRWYtIkwxnLwewPdVx3
        N0GEssXYrFU3JEJgWqgnTld8TRIUomuDHfNA4KV0mZAqkAdJuvB0EldHyJ9ZwPflD2sXbj
        w9qHy/HP0khHp4m9gJBwkj34m8BQGMZgp7l9DOuHR8nrdTfLrRCk29ZlI3idpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658334937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SzYRnD31ArqphC0obldOfpyK/WHzS0mU3rD8NaHRSIA=;
        b=OcgVu/JKmKE6YV2ebfi/ypQst3f+wFcmfEncR0VVX6d477EuUbEU2eXDHyx53ciEnjKQXT
        dzvAThb8HYMNQrDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] printk: Skip console drivers on PREEMPT_RT.
Message-ID: <Ytgu17hATM8iqdGC@linutronix.de>
References: <YtgjtfjYVMQrzFTK@linutronix.de>
 <87y1wn3g3g.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1wn3g3g.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-20 18:32:43 [+0206], John Ogness wrote:
> Hi Sebastian,
Hi,

> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2843,6 +2843,16 @@ void console_unlock(void)
> >  	}
> >  
> >  	/*
> > +	 * On PREEMPT_RT it is not possible to invoke console drivers with
> > +	 * disabled interrupts and or preemption. Therefore all drivers are
> > +	 * skipped and the output can be retrieved from the buffer.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > +		up_console_sem();
> 
> This should be:
> 
>                 __console_unlock();

Why?

> > +		return;
> > +	}
> 
> Note that if @console_may_schedule is 1, then we are in a sleepable
> context and could print. But since that is not very often, it is
> probably better to just have it off all the time as you propose.

No we can't coz printk disables interrupts before invoking the console
drivers.

> John Ogness

Sebastian
