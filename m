Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32942551F91
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241861AbiFTPAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238566AbiFTPAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:00:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2C91FA5C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:24:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C9DC021B76;
        Mon, 20 Jun 2022 14:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655735095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/q0ykzEzb2Ka6Wwx1sX3/NYsdKetMuOrwPKReHc+sBk=;
        b=NHLjlgMBSMSRk1NMsO1TDhMGHtNCQCmF3zAAWHITrLoHws7x6YagxPndmaYWtoflylsgBj
        ENmbyJeO5mOQEJ6WzOx2CmPTlXeBaMRu0zaVQwEIIrlEGrMkOlnPvygNLFPsNnBWgenP2P
        1p4x+0DONBqh8n6sejx7TqDFijYDkxY=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 417B42C141;
        Mon, 20 Jun 2022 14:24:55 +0000 (UTC)
Date:   Mon, 20 Jun 2022 16:24:54 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: Boot stall regression from "printk for 5.19" merge
Message-ID: <YrCDNqsPrY+Hs9ju@alley>
References: <20220619204949.50d9154d@thinkpad>
 <87r13kwawb.fsf@jogness.linutronix.de>
 <20220620112936.48fcb2a4@thinkpad>
 <YrBdjVwBOVgLfHyb@alley>
 <CAHk-=wgdquXVVE37CZooVK4X+YdSa7XoGtjr71CEYh8UsdKUow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgdquXVVE37CZooVK4X+YdSa7XoGtjr71CEYh8UsdKUow@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-06-20 08:48:29, Linus Torvalds wrote:
> On Mon, Jun 20, 2022 at 6:44 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > Both early console and proper console driver has its own kthread.
> >
> > >    1.166486] f0512000.serial: ttyS0 at MMIO 0xf0512000 (irq = 22, base_baud = 12500000) is a 16550A
> >
> > The line is malformed. I wonder if both early console and proper
> > console used the same port in parallel.
> 
> Honestly, I get the feeling that we need to just revert the whole
> "console from thread" thing.
> 
> Because:
> 
> > So, it looks like that con->write() code is not correctly serialized
> > between the early and normal console.
> > [ ... ]
> > I am going to check the driver...
> 
> We really cannot be in the situation that some random driver that used
> to work no longer does, and causes oopses and/or memory corruption
> just because it's now entered differently from how it traditionally
> has been.
>
> The traditional console write code has always been very careful to get
> exclusive access, and it sounds like that is just plain broken now.
> 
> So I don't think this is a "driver is broken".

I see what you think. There might be so many problems with the drivers
because they were never used this way. It looks like we opened a can
of worms. It is even more problematic because it causes silent boot
crashes and it is hard to debug.

I kind of agree with this and I have started looking at some more
generic solution.

All these boot crashes were in exactly the same situation when the
proper console was initialized and registered while there was
the early console used at the same time. It is a problem because
they use the same port.

The parallel use of different consoles should be much more
safe because they are much more independent.

There are the following possibilities:

1. Enable the kthreads later after the early consoles are gone.
   This is easy and should fix all known boot problems.

2. Temporary stop the kthreads and use direct printing when
   the proper consoles are registered. Well, this might be
   more complicated because the port might be accessed
   also before register_console() is called.

3. Another solution would be to use the global conosle_lock()
   also to synchronize the kthreads against each other. But
   it would be unfortunate.

I am going to prepare 1st solution.

Best Regards,
Petr
