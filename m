Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09819588F94
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbiHCPnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbiHCPnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:43:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63319638D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:43:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 361D31FA85;
        Wed,  3 Aug 2022 15:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659541396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UAStwIGdqe/A5SzN5E32d+euHKColmkL6Q4xDWBX7Z4=;
        b=mux3gyoG+/sDUb//KthsMzndMmpXAnNTBz9WER5RBn5wsZJiyZ1XcO2beypdnwkuUDoUiw
        L7BSDQgrPIfbGpvEuHddYOHoNdteXzeWEn8CISSNZ0xpYxOKnHrgG3HJEpa4FSOVjGoLV1
        /c0RPYounzRGlZ4rx3P+koTqy8jVA20=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BAF712C141;
        Wed,  3 Aug 2022 15:43:15 +0000 (UTC)
Date:   Wed, 3 Aug 2022 17:43:12 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] printk for 5.20
Message-ID: <YuqXkCZEfsSKoIX6@alley>
References: <YufsTLpighCI7qSf@alley>
 <CAHk-=wie+VC-R5=Hm=Vrg5PLrJxb1XiV67Efx-9Cr1fBKCWHTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wie+VC-R5=Hm=Vrg5PLrJxb1XiV67Efx-9Cr1fBKCWHTQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-08-02 20:19:34, Linus Torvalds wrote:
> On Mon, Aug 1, 2022 at 8:08 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > - Completely disable printing on consoles with CONFIG_RT.
> 
> I don't think this is acceptable.
> 
> We don't suddenly change behavior just because some random developer
> has decided "this is the RightThing(tm) to do".
> 
> Users matter.

I fully agree.


> For all we know, there may be random users who are playing around with
> PREEMPT_RT. They don't *have* to, but they want to.
>
> Just saying "you get no console because you wanted to try it out" is
> simply not acceptable.

This is where I probably made a mistake. I know that PREEMPT_RT is not
production ready in upstream. And I am not sure what people playing
with it expect.

My first reaction was that the patch was a joke. I tried to
formulate the concerns somehow, see
https://lore.kernel.org/all/Yt6MzEEFfpyTBIIj@alley/

Hmm, I ignored my intuition and let people familiar with PREEMPT_RT
decide. I knew that John was working on the proper solution so
it was not supposed to be final one.


> Seriously, even if you have strict RT requirements, you may also have
> strict debugging requirements, and if something goes wrong, you want
> to KNOW ABOUT IT. At that point, your RT rules may well fly out the
> window, because you have more serious problems.
>
> End result: no way will I accept this kind of completely arbitrary and
> frankly not very intelligent patch.
> 
> If people want to disable console printing, that's THEIR CHOICE. It
> could be a new config variable where you ASK people about what they
> want. Not this kind of idiotic tying together of things.
> 
> And guys, I want to make it really clear how disappointed I am with
> the printk tree lately. There seems to be some kind of hardline
> religious fervor having taken over to make these kinds of "this is how
> it has to be done, screw any sanity or common sense".
>
> There is exactly one thing you should hold sacred: don't break
> people's setups. All the rest is just engineering, and a HUGE part of
> "engineering" is to realize that everything is a trade-off.
>
> Linux kernel development is a pragmatic thing where existing users and
> existing code matters, and you don't get to just throw it all away
> because you have some odd personal hangup.
>
> And printing messages to a console is not some "oh, we'll just stop
> doing that because you asked for PREEMPT_RT".

My thinking was that PREEMPT_RT was used only by some rather small
community that was very well aware of the upstream status. I kind of
though that this was their choice.

I think that I underestimated political and human influences.


> Put another way: not only am I not pulling this, I'm concerned that I
> will not be pulling printk patches in the future either because of
> where these pull requests seem to be trending.

I admit that _I did a big mistake_ by this "disable consoles on RT"
patch. It broke many principles and it was a real hack.

On the positive side. My intuition told me that it was very controversial.
This is why I clearly described the effect. And it was the very first
sentence in the commit message. I think that I made it _very visible_.

The previous merge window was different. We tried to get into mainline
a feature that many people wanted for years (since 2012). We though
that it was ready but it wasn't and we took it back in time.


Otherwise, I think that I am quite demanding maintainer. I focus on
that the change must make sense, must not break existing behavior,
any user interface must be sane, the code must be readable and
maintainable.

I do mistakes. But I have learned big lessons last and this merge
window. I am going to believe more into my intuition and be more
strict.

I am going to take a break and think twice before sending any
further pull request.

Best Regards,
Petr
