Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DC0553099
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiFULT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348927AbiFULTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:19:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9072E2A26D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:19:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3759821B6D;
        Tue, 21 Jun 2022 11:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655810361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mjLwPmpJnhDmfPFonZ2bEdmvEUUUxw2WLPLCTpbJgCQ=;
        b=eAcpnsUCpFz5owZAKas2AsZMY7TGKDykmDZTyrLoICMlF+6V/mBKwE+VJzBTM/jrhHtjVc
        VvE2OgdBh1mPxPTra6rPZt7d1BidVTsTI3G1+dp/rXMQzWneIMcxhb6b50PTsQ00/+ByCB
        VB7r+BoRHYbC9OZjnig4tUbPHpN2N5o=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DBA812C141;
        Tue, 21 Jun 2022 11:19:19 +0000 (UTC)
Date:   Tue, 21 Jun 2022 13:19:19 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] printk/console: Enable console kthreads only when
 there is no boot console left
Message-ID: <20220621111919.GD7891@pathway.suse.cz>
References: <20220621090900.GB7891@pathway.suse.cz>
 <YrGMYk0LsbKewzPU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrGMYk0LsbKewzPU@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-06-21 18:16:18, Sergey Senozhatsky wrote:
> On (22/06/21 11:09), Petr Mladek wrote:
> > Threaded console printing does not take into consideration that boot
> > consoles may be accessing the same hardware as normal consoles and thus
> > must not be called in parallel.
> > 
> > Since it is currently not possible to identify which consoles are
> > accessing the same hardware, delay threaded console printing activation
> > until it is known that there are no boot consoles registered.
> > 
> > Link: https://lore.kernel.org/r/20220619204949.50d9154d@thinkpad
> > Link: https://lore.kernel.org/r/2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com
> > Link: https://lore.kernel.org/r/20220619204949.50d9154d@thinkpad
> > Reported-by: Marek Behún <kabel@kernel.org>
> > [john.ogness@linutronix.de: Better description of the problem.]
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > Tested-by: Marek Behún <kabel@kernel.org>
> 
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Thanks.

> > -static int __init printk_activate_kthreads(void)
> > -{
> > -	struct console *con;
> >  
> > -	console_lock();
> > -	printk_kthreads_available = true;
> > -	for_each_console(con)
> > -		printk_start_kthread(con);
> > -	console_unlock();
> > +	/*
> > +	 * Boot consoles may be accessing the same hardware as normal
> > +	 * consoles and thus must not be called in parallel. Therefore
> > +	 * only activate threaded console printing if it is known that
> > +	 * there are no boot consoles registered.
> > +	 */
> > +	if (no_bootcon)
> > +		printk_activate_kthreads();
> 
> A quick question. Here we still can have bootcon which can unregistered
> later, right? Do you think it'll make sense to check if printing kthreads
> can be safely started and start them if so (if no CON_BOOT found and kthreads
> are not already created) at the end of unregister_console()?

Yeah, that's my plan how to optimize it in the future. I just
wanted to do something simple and be on the safe side for 5.19.

Best Regards,
Petr
