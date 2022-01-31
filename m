Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1774A4AA5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379729AbiAaPd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379665AbiAaPdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:33:15 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62179C061714;
        Mon, 31 Jan 2022 07:33:15 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 03CE21447;
        Mon, 31 Jan 2022 16:33:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643643193;
        bh=eMAheiDAIWDxrcMKCOAT+TMinkKp+mNuDD2YkGykmEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBaZx92jmIQ7yqnZiQLYizdQiTlGCn6AdWkP7elcXV9pe4j8FFi5kNz8+n1pBi7vU
         XLeOlunA+ixdDCKWBcEy7jaGXPvuRXBnFtOcdBOx2zkkgDsKwGRuPO7LH+b9z0EnTd
         4Z5dMSOvUrQmHhP7JAcOU1e+ArXmA64MvoNyUFH0=
Date:   Mon, 31 Jan 2022 17:32:50 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v6 02/35] component: Introduce the aggregate bus_type
Message-ID: <YfgBIgqbCVSNGjfv@pendragon.ideasonboard.com>
References: <20220127200141.1295328-1-swboyd@chromium.org>
 <20220127200141.1295328-3-swboyd@chromium.org>
 <YffoqgmeUdxZ56zB@kroah.com>
 <CAKMK7uFYyQ9siB5ENHku+yVPWWM1H=TEn-NZofEKqpJnuEvMmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKMK7uFYyQ9siB5ENHku+yVPWWM1H=TEn-NZofEKqpJnuEvMmw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Jan 31, 2022 at 04:15:09PM +0100, Daniel Vetter wrote:
> On Mon, Jan 31, 2022 at 2:48 PM Greg Kroah-Hartman wrote:
> > On Thu, Jan 27, 2022 at 12:01:08PM -0800, Stephen Boyd wrote:
> > > The component framework only provides 'bind' and 'unbind' callbacks to
> > > tell the host driver that it is time to assemble the aggregate driver
> > > now that all the components have probed. The component framework doesn't
> > > attempt to resolve runtime PM or suspend/resume ordering, and explicitly
> > > mentions this in the code. This lack of support leads to some pretty
> > > gnarly usages of the 'prepare' and 'complete' power management hooks in
> > > drivers that host the aggregate device, and it fully breaks down when
> > > faced with ordering shutdown between the various components, the
> > > aggregate driver, and the host driver that registers the whole thing.
> > >
> > > In a concrete example, the MSM display driver at drivers/gpu/drm/msm is
> > > using 'prepare' and 'complete' to call the drm helpers
> > > drm_mode_config_helper_suspend() and drm_mode_config_helper_resume()
> > > respectively, so that it can move the aggregate driver suspend/resume
> > > callbacks to be before and after the components that make up the drm
> > > device call any suspend/resume hooks they have. This only works as long
> > > as the component devices don't do anything in their own 'prepare' and
> > > 'complete' callbacks. If they did, then the ordering would be incorrect
> > > and we would be doing something in the component drivers before the
> > > aggregate driver could do anything. Yuck!
> > >
> > > Similarly, when trying to add shutdown support to the MSM driver we run
> > > across a problem where we're trying to shutdown the drm device via
> > > drm_atomic_helper_shutdown(), but some of the devices in the encoder
> > > chain have already been shutdown. This time, the component devices
> > > aren't the problem (although they could be if they did anything in their
> > > shutdown callbacks), but there's a DSI to eDP bridge in the encoder
> > > chain that has already been shutdown before the driver hosting the
> > > aggregate device runs shutdown. The ordering of driver probe is like
> > > this:
> > >
> > >  1. msm_pdev_probe() (host driver)
> > >  2. DSI bridge
> > >  3. aggregate bind
> > >
> > > When it comes to shutdown we have this order:
> > >
> > >  1. DSI bridge
> > >  2. msm_pdev_shutdown() (host driver)
> > >
> > > and so the bridge is already off, but we want to communicate to it to
> > > turn things off on the display during msm_pdev_shutdown(). Double yuck!
> > > Unfortunately, this time we can't split shutdown into multiple phases
> > > and swap msm_pdev_shutdown() with the DSI bridge.
> > >
> > > Let's make the component_master_ops into an actual device driver that has
> > > probe/remove/shutdown functions. The driver will only be bound to the
> > > aggregate device once all component drivers have called component_add()
> > > to indicate they're ready to assemble the aggregate driver. This allows
> > > us to attach shutdown logic (and in the future runtime PM logic) to the
> > > aggregate driver so that it runs the hooks in the correct order.
> >
> > I know I asked before, but I can not remember the answer.
> >
> > This really looks like it is turning into the aux bus code.  Why can't
> > you just use that instead here for this type of thing?  You are creating
> > another bus and drivers for that bus that are "fake" which is great, but
> > that's what the aux bus code was supposed to help out with, so we
> > wouldn't have to write more of these.
> >
> > So, if this really is different, can you document it here so I remember
> > next time you resend this patch series?
> 
> aux takes a device and splits it into a lot of sub-devices, each with
> their own driver.
> 
> This takes a pile of devices, and turns it into a single logical
> device with a single driver.
> 
> So aux is 1:N, component is N:1.
> 
> And yes you asked this already, I typed this up already :-)

That's clear, but I'm still not sure why we need a bus for this :-) I'm
not very enthousiastic about that. Some of our problems come from the
fact we need to coordinate many devices, adding new ones hardly seem to
be a solution to that. Granted, the components framework doesn't work
nicely, and is in dire need of love (and documentation), or possibly
better a complete replacement. I'll try to review the series this week
and see if alternatives would be possible.

-- 
Regards,

Laurent Pinchart
