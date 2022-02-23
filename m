Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E6B4C17D7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242496AbiBWP4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiBWP4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:56:17 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1528FC2495
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:55:49 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 660C9DD;
        Wed, 23 Feb 2022 16:55:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1645631746;
        bh=Irbe3VgYiYwYob48RTsSLHlSNEUtPPegRXKorIZbeuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iIESGm04BYuL/brZ68hUeqzr3M6+xHF+6OoC8vcWXYUk7sNr+lqV6bBNpEzWNRt3A
         m+HS3M/8WOT/NChLVHu+h5Q1kJpqW2auwhz5aVwKH+FuA+X6GR3g2u6a7uhGi1Agr8
         Xmgi5T6+ED9bWvrmaSOJi21ffmzaAWDAX712dQAU=
Date:   Wed, 23 Feb 2022 17:55:36 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Brian Norris <briannorris@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Properly undo autosuspend
Message-ID: <YhZY+FLTlv7V5BIB@pendragon.ideasonboard.com>
References: <20220222141838.1.If784ba19e875e8ded4ec4931601ce6d255845245@changeid>
 <CACRpkdbQ9U22afR74YiZs95qCm7dnLb2k4_nT3Le__hJPpDGUw@mail.gmail.com>
 <YhXBIxbx63IXBU7L@pendragon.ideasonboard.com>
 <CAD=FV=UV+3PNF=O8Zv4UJK50gvDx=WHbamLLhH5ANZUBeCxjdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=UV+3PNF=O8Zv4UJK50gvDx=WHbamLLhH5ANZUBeCxjdQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Wed, Feb 23, 2022 at 07:43:27AM -0800, Doug Anderson wrote:
> On Tue, Feb 22, 2022 at 9:08 PM Laurent Pinchart wrote:
> > On Tue, Feb 22, 2022 at 11:44:54PM +0100, Linus Walleij wrote:
> > > On Tue, Feb 22, 2022 at 11:19 PM Douglas Anderson wrote:
> > > >
> > > > The PM Runtime docs say:
> > > >   Drivers in ->remove() callback should undo the runtime PM changes done
> > > >   in ->probe(). Usually this means calling pm_runtime_disable(),
> > > >   pm_runtime_dont_use_autosuspend() etc.
> > > >
> > > > We weren't doing that for autosuspend. Let's do it.
> > > >
> > > > Fixes: 9bede63127c6 ("drm/bridge: ti-sn65dsi86: Use pm_runtime autosuspend")
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > >
> > > Hm. I know a few places in drivers where I don't do this :/
> >
> > It seems to be a very common problem indeed, I haven't seen any driver
> > yet that uses pm_runtime_dont_use_autosuspend(). We could play a game of
> > whack-a-mole, but we'll never win. Could this be solved in the runtime
> > PM framework instead ? pm_runtime_disable() could disable auto-suspend.
> > If there are legitimate use cases for disabling runtime PM temporarily
> > without disabling auto-suspend, then a new function designed
> > specifically for remove() that would take care of cleaning everything up
> > could be another option.
> 
> Yeah, it would be good. It's probably not a yak I have time to shave
> right now, though. :(

I don't insist on shaving that yak right now :-) This patch is fine.

> I _suspect_ that there are legitimate reasons we can't just magically
> do it in pm_runtime_disable(). If nothing else I believe there are
> legitimate code paths during normal operation that look like this:
> 
>   pm_runtime_disable();
>   do_something_that_needs_pm_runtime_disabled();
>   pm_runtime_enable();
> 
> Also: if it were really a simple problem to solve one would have
> thought that it would have been solved initially instead of adding
> documentation particularly mentioning
> pm_runtime_dont_use_autosuspend()

I'm not sure, look at how long it took for us to get
pm_runtime_resume_and_get(). The problem has been considered for years
as a non-issue by the runtime PM developers. It feels like the API is
developed without considering its users.

> How about a middle ground, though: we could add a devm function that
> does all the magic. Somewhat recently devm_pm_runtime_enable() was
> added. What if we add a variant for those that use autosuspend, like:
> 
> devm_pm_runtime_enable_with_autosuspend(dev, initial_delay)
> 
> That would:
> * pm_runtime_enable()
> * pm_runtime_set_autosuspend_delay()
> * pm_runtime_use_autosuspend()
> * Use devm_add_action_or_reset() to undo everything.
> 
> Assuming that the pm_runtime folks are OK with that, we could
> transition things over to the new function once it rolls into
> mainline.
> 
> So this doesn't magically fix all existing code but provides a path to
> make this more discoverable.

Sounds like a good idea. I wonder if this could be handled by
devm_pm_runtime_enable() actually. If a driver calls
devm_pm_runtime_enable() and then enables auto-suspend, can't the
runtime PM core reasonably expect that auto-suspend should be disabled
at .remove() time ? The pm_runtime_disable_action() function could
disable auto-suspend unconditionally (assuming
pm_runtime_use_autosuspend() and pm_runtime_dont_use_autosuspend() don't
need to be balanced, if they do, then I'll just go cry in a corner).

-- 
Regards,

Laurent Pinchart
