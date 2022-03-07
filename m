Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A12F4D03C1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240996AbiCGQO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiCGQO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:14:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45AE366B3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:14:03 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 29C22210FE;
        Mon,  7 Mar 2022 16:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646669642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iSqlae7Qt+xrzSg34aB+OB4nZwi3kO0krFdAV9V5I78=;
        b=izbOwzQbedcyzcbLlYdhu+xgxcM6v0RnrWliXnFT5BQhvXL131t39cNMw/HtozzmOH0V7T
        teIqtnsH/rsown6KpiVFozLQZ1DQClubh031/eeHZeQOn/Xt43wKGioF67O+1zZvwZGDkN
        PdIhJR1O9+iPTNZXiygEozR3n7jDcFU=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D046BA3B8C;
        Mon,  7 Mar 2022 16:14:01 +0000 (UTC)
Date:   Mon, 7 Mar 2022 17:14:01 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 03/13] printk: use percpu flag instead of
 cpu_online()
Message-ID: <YiYvSf0FKFyOBF6Z@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-4-john.ogness@linutronix.de>
 <YgaJZtY+EH9JIGyo@alley>
 <YgoGNmYER8xni34K@google.com>
 <YguCuFYeZ52mkr4r@alley>
 <87zgm8h1tt.fsf@jogness.linutronix.de>
 <YiI2x6K5IhsADEmK@alley>
 <YiOYPvleCsTT9vGu@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiOYPvleCsTT9vGu@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-03-05 10:05:02, Jason A. Donenfeld wrote:
> Hi Petr,
> 
> On Fri, Mar 04, 2022 at 04:56:55PM +0100, Petr Mladek wrote:
> 
> > Just for record, the right commit ID in the mainline is
> > 1b710b1b10eff9d466. It used printk_deferred() in _warn_unseeded_randomness():
> > 
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -1687,8 +1687,9 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller,
> >  	print_once = true;
> >  #endif
> >  	if (__ratelimit(&unseeded_warning))
> > -		pr_notice("random: %s called from %pS with crng_init=%d\n",
> > -			  func_name, caller, crng_init);
> > +		printk_deferred(KERN_NOTICE "random: %s called from %pS "
> > +				"with crng_init=%d\n", func_name, caller,
> > +				crng_init);
> >  }
> 
> Are we able to revert this yet? Or is it still required because of
> locking issues? Would gladly take a patch to revert that if the
> non-deferred function is fine for 5.18.

Unfortunately, printk_deferred() will still be needed in 5.18 here.

One thing is that this patchset introducing console kthreads will not
be ready for 5.18.

But more importantly, the kthreads will not be enough to remove the
cyclic dependency. The legacy synchronous printing will still be used
during early boot, panic, etc.

Honestly, I am still not sure if we will be able to get rid of
printk_deferred(). I hope so but some more magic will be necessary.
Anyway, the kthreads should help to achieve this.

Best Regards,
Petr
