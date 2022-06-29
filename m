Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9E755FA8B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiF2IaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiF2I36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:29:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1693719011
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:29:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C204121E33;
        Wed, 29 Jun 2022 08:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656491396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IHyLFuUf3RdyGXhrYnMdLaANuV96sYIzvJl/tz37qDU=;
        b=OVDPj70dL/BvwbwDwwsegFN/YQ1viQvqUAxp1IQ+MeZOaah/94fSTsYURx9+vLARDfnMJK
        NzDLfhSJ1V5Jai/peiiJJ4g7aFPbv5nIEZz6Yi4YpS0GRmibbJnIXOqrlb6n07Xgxr8qIq
        OxTLcot60syJQWdD1YXcUjZDJWM/u+k=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 62CFA2C141;
        Wed, 29 Jun 2022 08:29:56 +0000 (UTC)
Date:   Wed, 29 Jun 2022 10:29:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] printk/console: Enable console kthreads only when there
 is no boot console left
Message-ID: <20220629082956.GB3111@pathway.suse.cz>
References: <20220619204949.50d9154d@thinkpad>
 <87r13kwawb.fsf@jogness.linutronix.de>
 <20220620112936.48fcb2a4@thinkpad>
 <YrBdjVwBOVgLfHyb@alley>
 <CAHk-=wgdquXVVE37CZooVK4X+YdSa7XoGtjr71CEYh8UsdKUow@mail.gmail.com>
 <YrCDNqsPrY+Hs9ju@alley>
 <YrCO04oNncE1xF5K@alley>
 <875ykvaqzm.fsf@jogness.linutronix.de>
 <20220624184136.4aab12fb@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624184136.4aab12fb@rorschach.local.home>
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

On Fri 2022-06-24 18:41:36, Steven Rostedt wrote:
> On Tue, 21 Jun 2022 00:57:09 +0206
> John Ogness <john.ogness@linutronix.de> wrote:
> 
> > Since early printing does not use the kernel driver model, I do not see
> > a clear solution at this point. But since using early printing is not a
> > typical use, I am OK with this patch.
> 
> Does this patch still work if you add the "keep" flag to the
> earlyprintk kernel parameter?

It works. If the boot console stays then the console kthreads will
never get enabled.

Well, I hope that we will be able to add the synchronization and remove
this constraint. I think that the port->lock should be usable in
most cases.

Best Regards,
Petr
