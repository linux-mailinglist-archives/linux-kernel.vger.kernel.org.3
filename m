Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF84550D02
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 22:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbiFSUjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 16:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiFSUjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 16:39:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECA4E8C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 13:39:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A51A0B80DFC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 20:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A8AC34114;
        Sun, 19 Jun 2022 20:39:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="O7mN9upz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655671185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PbjEy3T10mht9U/eAe2vRHAkW39M36bd+C1JxaKT8tE=;
        b=O7mN9upzENh4oFT1+IrpnHtIJSKODtIhaGKhzT6Vck7RQmnIc0dHisJm5XeWED18wVvJfb
        em0rq+WuQjhonaOEugGHH5hQ1vMogO39VuO3SPaP6N/PLYBegPcQhzHbL7iiYZLhzSiogj
        x6vNvMBgnLtCa8Rvn1JSmgX8nnq3H+g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bc522312 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 19 Jun 2022 20:39:44 +0000 (UTC)
Date:   Sun, 19 Jun 2022 22:39:42 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] printk: allow direct console printing to be enabled
 always
Message-ID: <Yq+Jjoyn/wj7yzeQ@zx2c4.com>
References: <YqyDqMAPHIxjA/xZ@zx2c4.com>
 <20220617133847.27517-1-Jason@zx2c4.com>
 <87a6a8syk8.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a6a8syk8.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Thanks for your review. I'll have a v2 for you shortly.

On Sun, Jun 19, 2022 at 01:11:43PM +0206, John Ogness wrote:
> > +	printk.always_direct=
> 
> Do we need the word "always" in there? I would prefer the simplied:
> printk.direct=

Sure, no problem. I'll do that for v2.

> 
> > +			Rather than using kthreads for printk output, always
> > +			write to the console immediately. This has performance
> 
> The "best effort" part needs to be in there. Perhaps:
> 
> Rather than using kthreads for printk output, always attempt to write to
> the console immediately.

Ack.

> 
> > +			implications, but will result in a more faithful
> > +			ordering and interleaving with other processes writing
> > +			to the console.
> 
> My main concern is that "direct printing" is not synchronous. Since
> 2.4.10 it has not been printk's goal to be synchronous. Your patch is
> making the issue less likely again, but not solving it. And since this
> is the first time we are documenting the printk printing behavior, we
> should be careful to not mislead users to think it is truly direct.

Sure, that makes sense. The "attempt to" language clarifies that well.

> > +config PRINTK_ALWAYS_DIRECT
> 
> (perhaps)
> config PRINTK_DIRECT

Ack.

> 
> > +	bool "Flush printk output immediately"
> 
> Attempt to flush printk output immediately

Ack.

> 
> > +	depends on PRINTK
> > +	help
> > +	  Rather than using kthreads for printk output, always write to the
> 
> always attempt to write

Ack.

> 
> > +	  console immediately. This has performance implications, but will
> > +	  result in a more faithful ordering and interleaving with other
> > +	  processes writing to the console.
> > +
> > +	  Say N here unless you really need this. This may also be controlled
> > +	  at boot time with printk.always_direct=0/1.
> 
> (perhaps)
> printk.direct=0/1

Ack.

> 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index ea3dd55709e7..d9f419a88429 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -471,6 +479,10 @@ void printk_prefer_direct_exit(void)
> >   */
> >  static inline bool allow_direct_printing(void)
> >  {
> > +	/* If the user has explicitly enabled this to be on always. */
> > +	if (always_direct_printk)
> > +		return true;
> 
> There is no reason to start the threads if they won't be used. Perhaps
> something like this instead:
> 
> -------- BEGIN HUNK -------
> @@ -3602,11 +3610,13 @@ static int __init printk_activate_kthreads(void)
>  {
>  	struct console *con;
>  
> -	console_lock();
> -	printk_kthreads_available = true;
> -	for_each_console(con)
> -		printk_start_kthread(con);
> -	console_unlock();
> +	if (!always_direct_printk) {
> +		console_lock();
> +		printk_kthreads_available = true;
> +		for_each_console(con)
> +			printk_start_kthread(con);
> +		console_unlock();
> +	}
>  
>  	return 0;
>  }
> -------- END HUNK -------

Good thinking. I'll do it like this.

> Direct printing has a lot of technical issues. It is sometimes directly
> responsible for kernels dying. It is sometimes directly responsible for
> preventing important information from being made available at crash
> time. For the fbcon, direct printing is a ticking timebomb. And in many
> cases it isn't even truly doing direct printing anyway.
> 
> Direct printing (in its current form) must be phased out at some
> point. We are working to bring true synchronous console printing
> mainline.
> 
> Aside from my above comments, I have no problems with this patch.

That's a fair point, though it remains a valuable resource for debugging
and CI. The way this patch is written, it defaults to off, and the help
text is kind of discouraging of its use, which is what we want I think.

v2 on its way.

Jason
