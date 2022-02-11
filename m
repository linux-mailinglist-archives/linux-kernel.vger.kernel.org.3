Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970054B1BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 03:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbiBKCE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 21:04:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344360AbiBKCEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:04:53 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90585F9B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:04:53 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so8673351ooi.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=ckXTKi5wrQ12rsy1drWcexp/vZy9HXxvAT6VdDX39mA=;
        b=G0KBhkL5dswwE9ogGoP/YzevamYiCcVJw2jhHM2I/yQ1Xlc+hMCFSS9VyR/TQJoRK0
         JV142KMhTczzCOUOlPZHLr9VqNoEJ5DxteB0dcaqGeP1a2gIHVgGXBUL1gXUl6+3TSxn
         IfXY6Zi6qCRXYTybnbe4lmN5IpHQaobPmyA0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=ckXTKi5wrQ12rsy1drWcexp/vZy9HXxvAT6VdDX39mA=;
        b=m9toAjchWifffCkAOVqLCTikxBjmzDTYRZntd7NdJUg9GntQsYlMt/+hCxggHjLvj3
         QB1KtDpvMnvp9/clc8i8AhyQCpiCUG0v/IRNJAgT5h1ZIXuMG9yXv91O877YJwihc5kN
         QqjpwmvG8BjNJFtZR3gV9KX7l7WJxpq/KfaQLmF8rQLif1Rb65n6pDsiarUngnZx0Ylb
         gFchSkusxLjca6T81zbNfrJAINEj8uMNIvKm6JD9iatFInLtcRws+ypBGHIOSHPJ41f6
         WHBajOx8ZL8/YO92eHkrrLaPEAW113yEfs4zrM9HUtq3+Bfq+9E1YSrEAESM66ooCN2A
         BRCw==
X-Gm-Message-State: AOAM533VyMWobOMrM+U0rXGexqf6ulhKVImksBOsicce1X66CMQkAjgN
        BAfXqmuOYNZkQN5UPsz4181PtvBGOn+nyuDYq+2P+A==
X-Google-Smtp-Source: ABdhPJxq4nfeeCfBWTKHOc4ecxgYoSuUG37YTIEnWQO+blgjdb1baXIsHJRAckIH92DctYWp5BmP6w+x7bfNWc6wpaY=
X-Received: by 2002:a05:6870:d413:: with SMTP id i19mr78933oag.54.1644545092930;
 Thu, 10 Feb 2022 18:04:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Feb 2022 18:04:52 -0800
MIME-Version: 1.0
In-Reply-To: <YgJn57s8u2OsBGnW@phenom.ffwll.local>
References: <20220127200141.1295328-1-swboyd@chromium.org> <20220127200141.1295328-3-swboyd@chromium.org>
 <YffoqgmeUdxZ56zB@kroah.com> <CAKMK7uFYyQ9siB5ENHku+yVPWWM1H=TEn-NZofEKqpJnuEvMmw@mail.gmail.com>
 <YfgPkliOLorgXwVE@kroah.com> <YgJn57s8u2OsBGnW@phenom.ffwll.local>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 10 Feb 2022 18:04:52 -0800
Message-ID: <CAE-0n51_RPmS+yuMKTGczA4J6SAE7xddMsjtNk88jtax9QX_EA@mail.gmail.com>
Subject: Re: [PATCH v6 02/35] component: Introduce the aggregate bus_type
To:     Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Vetter (2022-02-08 04:53:59)
> On Mon, Jan 31, 2022 at 05:34:26PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Jan 31, 2022 at 04:15:09PM +0100, Daniel Vetter wrote:
> > > On Mon, Jan 31, 2022 at 2:48 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Jan 27, 2022 at 12:01:08PM -0800, Stephen Boyd wrote:
> > > > > The component framework only provides 'bind' and 'unbind' callbacks to
> > > > > tell the host driver that it is time to assemble the aggregate driver
> > > > > now that all the components have probed. The component framework doesn't
> > > > > attempt to resolve runtime PM or suspend/resume ordering, and explicitly
> > > > > mentions this in the code. This lack of support leads to some pretty
> > > > > gnarly usages of the 'prepare' and 'complete' power management hooks in
> > > > > drivers that host the aggregate device, and it fully breaks down when
> > > > > faced with ordering shutdown between the various components, the
> > > > > aggregate driver, and the host driver that registers the whole thing.
> > > > >
> > > > > In a concrete example, the MSM display driver at drivers/gpu/drm/msm is
> > > > > using 'prepare' and 'complete' to call the drm helpers
> > > > > drm_mode_config_helper_suspend() and drm_mode_config_helper_resume()
> > > > > respectively, so that it can move the aggregate driver suspend/resume
> > > > > callbacks to be before and after the components that make up the drm
> > > > > device call any suspend/resume hooks they have. This only works as long
> > > > > as the component devices don't do anything in their own 'prepare' and
> > > > > 'complete' callbacks. If they did, then the ordering would be incorrect
> > > > > and we would be doing something in the component drivers before the
> > > > > aggregate driver could do anything. Yuck!
> > > > >
> > > > > Similarly, when trying to add shutdown support to the MSM driver we run
> > > > > across a problem where we're trying to shutdown the drm device via
> > > > > drm_atomic_helper_shutdown(), but some of the devices in the encoder
> > > > > chain have already been shutdown. This time, the component devices
> > > > > aren't the problem (although they could be if they did anything in their
> > > > > shutdown callbacks), but there's a DSI to eDP bridge in the encoder
> > > > > chain that has already been shutdown before the driver hosting the
> > > > > aggregate device runs shutdown. The ordering of driver probe is like
> > > > > this:
> > > > >
> > > > >  1. msm_pdev_probe() (host driver)
> > > > >  2. DSI bridge
> > > > >  3. aggregate bind
> > > > >
> > > > > When it comes to shutdown we have this order:
> > > > >
> > > > >  1. DSI bridge
> > > > >  2. msm_pdev_shutdown() (host driver)
> > > > >
> > > > > and so the bridge is already off, but we want to communicate to it to
> > > > > turn things off on the display during msm_pdev_shutdown(). Double yuck!
> > > > > Unfortunately, this time we can't split shutdown into multiple phases
> > > > > and swap msm_pdev_shutdown() with the DSI bridge.
> > > > >
> > > > > Let's make the component_master_ops into an actual device driver that has
> > > > > probe/remove/shutdown functions. The driver will only be bound to the
> > > > > aggregate device once all component drivers have called component_add()
> > > > > to indicate they're ready to assemble the aggregate driver. This allows
> > > > > us to attach shutdown logic (and in the future runtime PM logic) to the
> > > > > aggregate driver so that it runs the hooks in the correct order.
> > > >
> > > > I know I asked before, but I can not remember the answer.
> > > >
> > > > This really looks like it is turning into the aux bus code.  Why can't
> > > > you just use that instead here for this type of thing?  You are creating
> > > > another bus and drivers for that bus that are "fake" which is great, but
> > > > that's what the aux bus code was supposed to help out with, so we
> > > > wouldn't have to write more of these.
> > > >
> > > > So, if this really is different, can you document it here so I remember
> > > > next time you resend this patch series?
> > >
> > > aux takes a device and splits it into a lot of sub-devices, each with
> > > their own driver.
> > >
> > > This takes a pile of devices, and turns it into a single logical
> > > device with a single driver.
> > >
> > > So aux is 1:N, component is N:1.
> > >
> > > And yes you asked this already, I typed this up already :-)
> >
> > Ok, thanks.  But then why is a bus needed if there's a single driver?
> > I guess a bus for that driver?  So one bus, one driver, and one device?
>
> Maybe? I have honestly no idea how this should be best modelled in the
> linux device model.

There can be one driver and multiple aggregate devices attached to that
driver. This happens for the MediaTek SMMU (IOMMU) code that has two
aggregate devices.

We need a bus to have a driver and attach power management operations
and a shutdown hook to that driver that knows about the entire graphics
card/encoder chain. Otherwise there's not a good place to insert the
function call that walks the display hardware and shuts down devices,
drm_atomic_helper_shutdown(). We have a problem where an i2c device for
a display bridge can't be turned off because we've already shut down the
whole i2c bus before we call drm_atomic_helper_shutdown() due to the
platform device that calls it probing far before the i2c bridge probes.

Could we attach a shutdown hook and dev_pm_ops to the drm class
structure and then have some DRM API that lets us opt into using the
simple shutdown helper? That would avoid making yet another bus and
driver as my high level understanding of 'struct class drm_class' is
that it represents the graphics card and it isn't created until the
entire display pipeline devices have probed and checked in with the
component layer.

>
> > I think we need better documentation here...
>
> https://dri.freedesktop.org/docs/drm/driver-api/component.html?highlight=component_del#component-helper-for-aggregate-drivers
>
> There's a kerneldoc overview for component, but it's for driver authors
> that want to use component to glue different hw pieces into a logical
> driver, so it skips over these internals.
>
> And I'm honestly not sure how we want to leak implementation internals
> like the bus/driver/device structure ot users of component.c.

What are the next steps here? Do I need to document the component code
further in kernel-doc? I can add kernel-doc for the things like
component_match_array and aggregate_device structure and highlight how
it is different from the aux bus.
