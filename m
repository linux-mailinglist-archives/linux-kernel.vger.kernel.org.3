Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720234AD993
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356775AbiBHNVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359783AbiBHMyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:54:05 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C36CC03FECA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:54:04 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id s13so51894923ejy.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=EdOABUNENMY5hYtYPGRPZmVz5tXWbGx6V9rHvVTwsTo=;
        b=KgFzVhnS+WwfF4ySk8R2/5G/qaN9zSc7f1Btrik8l3ywATzIA1H3npms8IV/EEj2KI
         IEWyrGEr/Q+oBaB+rZIL/nu2xrfklQucAehi0E2n5WYRj0scoAYhI4cerIdykx1YxOFA
         bOMwE/D9+192GSVfQxod36C2LT3HZ1niWajoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=EdOABUNENMY5hYtYPGRPZmVz5tXWbGx6V9rHvVTwsTo=;
        b=eyTprKEQRbzCbd1CcNQ0RgpAx3/hjath6W7bCC++9wSrOzyWGUeFkcuv6FdqvrAzc1
         Ga4QPlB6Q0D37+NmceZ1WlCFusx60j3EZjAlrkxQN02icL/qTGPFbCm7pLEjCqdFpzAV
         IaA6kW9t8L5Re/cl9nj8kq/y/LmkDBiF99gRwUe7vW80rh9AAvDpAlzxd56XgNZjZkfo
         t46MHzEXMQ0xDo9zvJhraeCIofSwr6D4xMZ/a5Bc7ZKfVXBKAR45Cyocl/S+TFYtWkAo
         ABJ6bpC0X+wlRjJQq6gC4x1mJ1AewuCPCI2W9bD6OEYHdh84GI/BtU6P6Fi0fhFAN3XR
         SaeQ==
X-Gm-Message-State: AOAM533txU0lyfTfHsH4/oZ8ggqATrVgKfEhSKT4iemadR/smXii4Q0+
        lFOeAs6dmRX4TiO9gu8huN+pdstUYA/BVA==
X-Google-Smtp-Source: ABdhPJyjoXx7TZnQW6xw4xjBqA0XWuDhxN1WRj0W2ugU65gZDBqDw0EPp6tl28mczrKVDEoZQx+16g==
X-Received: by 2002:a17:906:94e:: with SMTP id j14mr3514523ejd.369.1644324842613;
        Tue, 08 Feb 2022 04:54:02 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d18sm4740261ejd.95.2022.02.08.04.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:54:01 -0800 (PST)
Date:   Tue, 8 Feb 2022 13:53:59 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v6 02/35] component: Introduce the aggregate bus_type
Message-ID: <YgJn57s8u2OsBGnW@phenom.ffwll.local>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
References: <20220127200141.1295328-1-swboyd@chromium.org>
 <20220127200141.1295328-3-swboyd@chromium.org>
 <YffoqgmeUdxZ56zB@kroah.com>
 <CAKMK7uFYyQ9siB5ENHku+yVPWWM1H=TEn-NZofEKqpJnuEvMmw@mail.gmail.com>
 <YfgPkliOLorgXwVE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfgPkliOLorgXwVE@kroah.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 05:34:26PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 31, 2022 at 04:15:09PM +0100, Daniel Vetter wrote:
> > On Mon, Jan 31, 2022 at 2:48 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Jan 27, 2022 at 12:01:08PM -0800, Stephen Boyd wrote:
> > > > The component framework only provides 'bind' and 'unbind' callbacks to
> > > > tell the host driver that it is time to assemble the aggregate driver
> > > > now that all the components have probed. The component framework doesn't
> > > > attempt to resolve runtime PM or suspend/resume ordering, and explicitly
> > > > mentions this in the code. This lack of support leads to some pretty
> > > > gnarly usages of the 'prepare' and 'complete' power management hooks in
> > > > drivers that host the aggregate device, and it fully breaks down when
> > > > faced with ordering shutdown between the various components, the
> > > > aggregate driver, and the host driver that registers the whole thing.
> > > >
> > > > In a concrete example, the MSM display driver at drivers/gpu/drm/msm is
> > > > using 'prepare' and 'complete' to call the drm helpers
> > > > drm_mode_config_helper_suspend() and drm_mode_config_helper_resume()
> > > > respectively, so that it can move the aggregate driver suspend/resume
> > > > callbacks to be before and after the components that make up the drm
> > > > device call any suspend/resume hooks they have. This only works as long
> > > > as the component devices don't do anything in their own 'prepare' and
> > > > 'complete' callbacks. If they did, then the ordering would be incorrect
> > > > and we would be doing something in the component drivers before the
> > > > aggregate driver could do anything. Yuck!
> > > >
> > > > Similarly, when trying to add shutdown support to the MSM driver we run
> > > > across a problem where we're trying to shutdown the drm device via
> > > > drm_atomic_helper_shutdown(), but some of the devices in the encoder
> > > > chain have already been shutdown. This time, the component devices
> > > > aren't the problem (although they could be if they did anything in their
> > > > shutdown callbacks), but there's a DSI to eDP bridge in the encoder
> > > > chain that has already been shutdown before the driver hosting the
> > > > aggregate device runs shutdown. The ordering of driver probe is like
> > > > this:
> > > >
> > > >  1. msm_pdev_probe() (host driver)
> > > >  2. DSI bridge
> > > >  3. aggregate bind
> > > >
> > > > When it comes to shutdown we have this order:
> > > >
> > > >  1. DSI bridge
> > > >  2. msm_pdev_shutdown() (host driver)
> > > >
> > > > and so the bridge is already off, but we want to communicate to it to
> > > > turn things off on the display during msm_pdev_shutdown(). Double yuck!
> > > > Unfortunately, this time we can't split shutdown into multiple phases
> > > > and swap msm_pdev_shutdown() with the DSI bridge.
> > > >
> > > > Let's make the component_master_ops into an actual device driver that has
> > > > probe/remove/shutdown functions. The driver will only be bound to the
> > > > aggregate device once all component drivers have called component_add()
> > > > to indicate they're ready to assemble the aggregate driver. This allows
> > > > us to attach shutdown logic (and in the future runtime PM logic) to the
> > > > aggregate driver so that it runs the hooks in the correct order.
> > >
> > > I know I asked before, but I can not remember the answer.
> > >
> > > This really looks like it is turning into the aux bus code.  Why can't
> > > you just use that instead here for this type of thing?  You are creating
> > > another bus and drivers for that bus that are "fake" which is great, but
> > > that's what the aux bus code was supposed to help out with, so we
> > > wouldn't have to write more of these.
> > >
> > > So, if this really is different, can you document it here so I remember
> > > next time you resend this patch series?
> > 
> > aux takes a device and splits it into a lot of sub-devices, each with
> > their own driver.
> > 
> > This takes a pile of devices, and turns it into a single logical
> > device with a single driver.
> > 
> > So aux is 1:N, component is N:1.
> > 
> > And yes you asked this already, I typed this up already :-)
> 
> Ok, thanks.  But then why is a bus needed if there's a single driver?
> I guess a bus for that driver?  So one bus, one driver, and one device?

Maybe? I have honestly no idea how this should be best modelled in the
linux device model.

> I think we need better documentation here...

https://dri.freedesktop.org/docs/drm/driver-api/component.html?highlight=component_del#component-helper-for-aggregate-drivers

There's a kerneldoc overview for component, but it's for driver authors
that want to use component to glue different hw pieces into a logical
driver, so it skips over these internals.

And I'm honestly not sure how we want to leak implementation internals
like the bus/driver/device structure ot users of component.c.
-Daniel

> 
> thanks,
> 
> greg k-h

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
