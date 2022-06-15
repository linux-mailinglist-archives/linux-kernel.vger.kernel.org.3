Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F019B54D17C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbiFOTUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbiFOTUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:20:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDA43ED16;
        Wed, 15 Jun 2022 12:20:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DDCAE21AB8;
        Wed, 15 Jun 2022 19:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655320837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5XqRKdwqzkoEs3gZYQHX7eS05tMGf3VU2LSgLCmE/jM=;
        b=F1AJkr9skRupqowd/XDIH5I4YmXy8U7D6FufHjWhAoLbDgWLr/RXc4WLwFqwd7PKg71aua
        I7bHl+3jIatG0SzBdlSop+fvcFrjvPKm9ZHyBHsIAWPSwA5Ho78OKA2F85KGwYtd2u4WQk
        VL8RQqHzgKfy+3crzWXzVTKSiVE1daQ=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 511AA2C141;
        Wed, 15 Jun 2022 19:20:36 +0000 (UTC)
Date:   Wed, 15 Jun 2022 21:20:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>, zhouzhouyi@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, linux-rockchip@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] printk: Block console kthreads when direct printing
 will be required
Message-ID: <YqoxAUwGx0AtxDXd@alley>
References: <20220615162805.27962-1-pmladek@suse.com>
 <20220615162805.27962-2-pmladek@suse.com>
 <CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-06-15 10:47:14, Linus Torvalds wrote:
> On Wed, Jun 15, 2022 at 9:28 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > BugLink: https://lore.kernel.org/r/20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1
> > BugLink: https://lore.kernel.org/r/CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com
> 
> Other thread discussion about this exact thing:
> 
>    https://lore.kernel.org/all/CAHk-=wgzRUT1fBpuz3xcN+YdsX0SxqOzHWRtj0ReHpUBb5TKbA@mail.gmail.com/
> 
> please stop making up random tags that make no sense.
> 
> Just use "Link:"
> 
> Look at that first one (I didn't even bother following the second
> one). The "bug" part is not even the most important part.
> 
> The reason to follow that link is all the discussion, the test-patch,
> and the confirmation from Paul that "yup, that patch solves the
> problem for me".
> 
> It's extra context to the commit, in case somebody wants to know the
> history. The "bug" part is (and always should be) already explained in
> the commit message, there's absolutely no point in adding soem extra
> noise to the "Link:" tag.
> 
> And if the only reason for "BugLink:" to exist is to show "look, this
> tag actually contains relevant and interesting information", then the
> solution to THAT problem is to not have the links that are useless and
> pointless in the first place.
> 
> Put another way: if you want to distinguish useless links from useful
> ones, just do it by not including the useless ones.
> 
> Ok?

Got it! I am going to use "Link:" instead.

I just see how the discussion evolved at
https://lore.kernel.org/all/CAHk-=wgzRUT1fBpuz3xcN+YdsX0SxqOzHWRtj0ReHpUBb5TKbA@mail.gmail.com/

It is actually this exact discussion that confused me. I got the
impression that BugLink was a commonly used tag. I see that
I was too fast.

Thanks for stopping me.

Best Regards,
Petr
