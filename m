Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B814E4A4A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348252AbiAaPP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379400AbiAaPPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:15:50 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77279C061775
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 07:15:21 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id q14-20020a05683022ce00b005a6162a1620so514858otc.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 07:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ZgU+vGjwoubJ875RGR9zEt1v4kg3PV5cuvMBbMqjDc=;
        b=esqX2L3zl905Y4V/EzdVPP2sl+6fanA8uZ9ay50GWGhwYUlJoITrs+ppFlantEW6nQ
         TxuuQOowDZ9PnlFKUR4rVmQGHsl+e+8CHke645UitiKHGeSY1tYZDgUvktOzj+QZLJBv
         9UzdTBOt3eE3dDx3B9kDvC5z1rjSzIUUF1lzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ZgU+vGjwoubJ875RGR9zEt1v4kg3PV5cuvMBbMqjDc=;
        b=moozQBz/yoquwSIIWTbbQaGf9uYJw2yIoStlgK5v9U3RNDD3o/5/tJWLTPpqTdQfii
         OBs2n9dIoF5+HXWeAcEZBNdlrJ4ycObJbQYz6FfykOI7laC1k/w7RuibNZfHH39XwdB9
         d6cb177qEX9gm/a8GV0yLu2oiDQdO9umD+ngYg0aYr6jCPY10eWEDv4iNoHT1/gf8vAj
         iy+Z/LOI55jA9LTjKTnsT53gaXWT0ZWS33h11+2jB9vz/Fq1DxSVm0fhTRy/A9qmQV/d
         Av8uZksx6K1sNkgeXzNPyjndaoBU9mlOI/rbd+H0qa32HrDZBAN29iwbTgGdA9zWxRI3
         +pXA==
X-Gm-Message-State: AOAM530IBynwBksXW86NJuUbtGfbWzrzlD7euORzNBqgHOiaUDCzpnre
        bzfhVsFyYKOROLgc4iJRBOzBu1zvs6xmP+j112jRew==
X-Google-Smtp-Source: ABdhPJyTs7vnJHqxyqBQfChzS9rKUYFzQoYfVDVbHfBXsz/Jv0Pkicsb6xNwHUpx979UIH6aBlsgh3d/tVOt+pEg2C8=
X-Received: by 2002:a05:6830:1153:: with SMTP id x19mr11310437otq.321.1643642120656;
 Mon, 31 Jan 2022 07:15:20 -0800 (PST)
MIME-Version: 1.0
References: <20220127200141.1295328-1-swboyd@chromium.org> <20220127200141.1295328-3-swboyd@chromium.org>
 <YffoqgmeUdxZ56zB@kroah.com>
In-Reply-To: <YffoqgmeUdxZ56zB@kroah.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 31 Jan 2022 16:15:09 +0100
Message-ID: <CAKMK7uFYyQ9siB5ENHku+yVPWWM1H=TEn-NZofEKqpJnuEvMmw@mail.gmail.com>
Subject: Re: [PATCH v6 02/35] component: Introduce the aggregate bus_type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 2:48 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 27, 2022 at 12:01:08PM -0800, Stephen Boyd wrote:
> > The component framework only provides 'bind' and 'unbind' callbacks to
> > tell the host driver that it is time to assemble the aggregate driver
> > now that all the components have probed. The component framework doesn't
> > attempt to resolve runtime PM or suspend/resume ordering, and explicitly
> > mentions this in the code. This lack of support leads to some pretty
> > gnarly usages of the 'prepare' and 'complete' power management hooks in
> > drivers that host the aggregate device, and it fully breaks down when
> > faced with ordering shutdown between the various components, the
> > aggregate driver, and the host driver that registers the whole thing.
> >
> > In a concrete example, the MSM display driver at drivers/gpu/drm/msm is
> > using 'prepare' and 'complete' to call the drm helpers
> > drm_mode_config_helper_suspend() and drm_mode_config_helper_resume()
> > respectively, so that it can move the aggregate driver suspend/resume
> > callbacks to be before and after the components that make up the drm
> > device call any suspend/resume hooks they have. This only works as long
> > as the component devices don't do anything in their own 'prepare' and
> > 'complete' callbacks. If they did, then the ordering would be incorrect
> > and we would be doing something in the component drivers before the
> > aggregate driver could do anything. Yuck!
> >
> > Similarly, when trying to add shutdown support to the MSM driver we run
> > across a problem where we're trying to shutdown the drm device via
> > drm_atomic_helper_shutdown(), but some of the devices in the encoder
> > chain have already been shutdown. This time, the component devices
> > aren't the problem (although they could be if they did anything in their
> > shutdown callbacks), but there's a DSI to eDP bridge in the encoder
> > chain that has already been shutdown before the driver hosting the
> > aggregate device runs shutdown. The ordering of driver probe is like
> > this:
> >
> >  1. msm_pdev_probe() (host driver)
> >  2. DSI bridge
> >  3. aggregate bind
> >
> > When it comes to shutdown we have this order:
> >
> >  1. DSI bridge
> >  2. msm_pdev_shutdown() (host driver)
> >
> > and so the bridge is already off, but we want to communicate to it to
> > turn things off on the display during msm_pdev_shutdown(). Double yuck!
> > Unfortunately, this time we can't split shutdown into multiple phases
> > and swap msm_pdev_shutdown() with the DSI bridge.
> >
> > Let's make the component_master_ops into an actual device driver that has
> > probe/remove/shutdown functions. The driver will only be bound to the
> > aggregate device once all component drivers have called component_add()
> > to indicate they're ready to assemble the aggregate driver. This allows
> > us to attach shutdown logic (and in the future runtime PM logic) to the
> > aggregate driver so that it runs the hooks in the correct order.
>
> I know I asked before, but I can not remember the answer.
>
> This really looks like it is turning into the aux bus code.  Why can't
> you just use that instead here for this type of thing?  You are creating
> another bus and drivers for that bus that are "fake" which is great, but
> that's what the aux bus code was supposed to help out with, so we
> wouldn't have to write more of these.
>
> So, if this really is different, can you document it here so I remember
> next time you resend this patch series?

aux takes a device and splits it into a lot of sub-devices, each with
their own driver.

This takes a pile of devices, and turns it into a single logical
device with a single driver.

So aux is 1:N, component is N:1.

And yes you asked this already, I typed this up already :-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
