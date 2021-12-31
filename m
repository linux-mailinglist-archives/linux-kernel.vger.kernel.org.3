Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407194825FC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 23:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhLaWCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 17:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhLaWCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 17:02:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84FEC061574;
        Fri, 31 Dec 2021 14:02:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 710D6B81DDB;
        Fri, 31 Dec 2021 22:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F72C36AEC;
        Fri, 31 Dec 2021 22:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640988126;
        bh=A7x7PdWBqcoi+hZ15G3SKeCFjNbydYvYM9peSG35voI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spNqlz1BuwLvllg2l1Cse+pyNFqGdTr0M1Pmlr9E3BvzLZr2VZB44/LbaGjciWC8I
         ie/xInDnFMXUVUEd7bUINzunKQ8qoB45O1O63H7G89HGJzo8DBUNXvYWMk/mp/7jtm
         EESi0EFD6NruNTl/hSuKEJPyC0k7th0HZB1qLBB2KaeZmDc5GyJxyO7dkfingeeE2V
         3JP4oy15bYJAKJd+i37tg5y//M2+orWArVbJQuPMnnhE+uNHzluxcZhQAh64DtkpwO
         QYY6mVPO5eBpD1uh15hzDdjerbAPesBW1ohihloXnJ7Rh37vLtixW3nK5F3/L5tvJ8
         SqyDQFuASuqVw==
Date:   Fri, 31 Dec 2021 15:02:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2] power: reset: ltc2952: Fix use of floating point
 literals
Message-ID: <Yc992ncu+CbDSJJn@archlinux-ax161>
References: <20211105152049.2522250-1-nathan@kernel.org>
 <20211116142614.ofqoox6zpn5erlc3@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116142614.ofqoox6zpn5erlc3@earth.universe>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Tue, Nov 16, 2021 at 03:26:14PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Nov 05, 2021 at 08:20:50AM -0700, Nathan Chancellor wrote:
> > A new commit in LLVM causes an error on the use of 'long double' when
> > '-mno-x87' is used, which the kernel does through an alias,
> > '-mno-80387' (see the LLVM commit below for more details around why it
> > does this).
> > 
> > drivers/power/reset/ltc2952-poweroff.c:162:28: error: expression requires  'long double' type support, but target 'x86_64-unknown-linux-gnu' does not support it
> >         data->wde_interval = 300L * 1E6L;
> >                                   ^
> > drivers/power/reset/ltc2952-poweroff.c:162:21: error: expression requires  'long double' type support, but target 'x86_64-unknown-linux-gnu' does not support it
> >         data->wde_interval = 300L * 1E6L;
> >                            ^
> > drivers/power/reset/ltc2952-poweroff.c:163:41: error: expression requires  'long double' type support, but target 'x86_64-unknown-linux-gnu' does not support it
> >         data->trigger_delay = ktime_set(2, 500L*1E6L);
> >                                                ^
> > 3 errors generated.
> > 
> > This happens due to the use of a 'long double' literal. The 'E6' part of
> > '1E6L' causes the literal to be a 'double' then the 'L' suffix promotes
> > it to 'long double'.
> > 
> > There is no visible reason for floating point values in this driver, as
> > the values are only assigned to integer types. Use NSEC_PER_MSEC, which
> > is the same integer value as '1E6L', to avoid changing functionality but
> > fix the error.
> > 
> > Fixes: 6647156c00cc ("power: reset: add LTC2952 poweroff driver")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1497
> > Link: https://github.com/llvm/llvm-project/commit/a8083d42b1c346e21623a1d36d1f0cadd7801d83
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> 
> Thanks, queued to power-supply's fixes branch.

Is there a timeline for getting this to Linus, since it has been a month
and a half now since this was applied? It breaks several x86_64 configs
with tip of tree clang, which harms our testing of the upcoming release,
and other people are now tripping over this and reporting it on the LLVM
issue tracker:

https://github.com/llvm/llvm-project/issues/52924

Also, I noticed that your fixes branch is not flowing into linux-next,
meaning this is not fixed there either. Would it be possible for you to
ask Stephen Rothwell to add it?

Cheers,
Nathan

> > 
> > v1 -> v2: https://lore.kernel.org/r/20211104215047.663411-1-nathan@kernel.org/
> > 
> > * A separate review pointed out that NSEC_PER_MSEC is a better choice
> >   than USEC_PER_SEC because ktime_t is nanoseconds and the few functions
> >   that take these values work in nanoseconds. The value is the same but
> >   the documentation is better.
> > 
> > * Pick up Nick's review tag.
> > 
> >  drivers/power/reset/ltc2952-poweroff.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
> > index fbb344353fe4..65d9528cc989 100644
> > --- a/drivers/power/reset/ltc2952-poweroff.c
> > +++ b/drivers/power/reset/ltc2952-poweroff.c
> > @@ -159,8 +159,8 @@ static void ltc2952_poweroff_kill(void)
> >  
> >  static void ltc2952_poweroff_default(struct ltc2952_poweroff *data)
> >  {
> > -	data->wde_interval = 300L * 1E6L;
> > -	data->trigger_delay = ktime_set(2, 500L*1E6L);
> > +	data->wde_interval = 300L * NSEC_PER_MSEC;
> > +	data->trigger_delay = ktime_set(2, 500L * NSEC_PER_MSEC);
> >  
> >  	hrtimer_init(&data->timer_trigger, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> >  	data->timer_trigger.function = ltc2952_poweroff_timer_trigger;
> > 
> > base-commit: d4439a1189f93d0ac1eaf0197db8e6b3e197d5c7
> > -- 
> > 2.34.0.rc0
> > 


