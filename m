Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3410D472B68
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbhLMLaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbhLMLap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:30:45 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32984C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 03:30:45 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id s9so14010014qvk.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 03:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPqukJKw+aJBcf7sVwYgzPRYDwCX4VM/xhe1xZEheMA=;
        b=K6HqxFk42efNCxNHGO4jUvpFZ0y56TPdzOc+msGLHuukwbiqUHG1l5tW2GM2TtrTj6
         +5wuhZdV2b1XhGuPHlMvDznWfOGT1V6vZGfbeszPDpWxhVMvXYctFlWrgD1hyrDqAysx
         gkOLd0l3Pp3A/stwcdgKJ5Yc0vDHfwmyTgvjUjszuVj2FP542IuVZ+X1FMvLnGF1c4/G
         7sPk5O4GWGuuS7GwO/WIzlMZ7HpY2iN53bv41590J+YgEXGsY0gLBRSt/Ns8PY7SBGUI
         mX2WxqNLpu06xIuNtLNGgFGZEI/3nL+J6PUOHHYSZC8296DM9VWp8BgmVn6ViMfq8xIp
         QgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPqukJKw+aJBcf7sVwYgzPRYDwCX4VM/xhe1xZEheMA=;
        b=RQdw2tb/ABZf6yVfr782fDLhThMDfuHCkgHn39Qb0OMZI4CpWSi3Jui15/fzULWPv/
         5L2H/BiEotc/OLrDey9RjbKbX0UhkDXVqtv71Oq7KqkrB/GNyvSL8jKNmzJNHdEE91Ay
         rRh+oJsPl/qaUnqdNKW8dtBG9B/Lu+ldAN7dHq+tC500kIxKved5L+KPJlNYcDppB86a
         I16j6DpMl3UF+qqkzJTLl3l9PZnD0s/0cJqAdLtF7JUApYaQCcWrqYSUyhSG4EYXwUyx
         rh81lD39961FHvHO1M1b81poPF2togAqgOaw/GUaxUgZPktnnladMRDEPyshkDzbJ6lH
         v2Xw==
X-Gm-Message-State: AOAM531f3xKBgC/DSB14NsPpCM56egYgImPLsz9Mv11gaCTf4Od4WwiW
        RBHMCdgr6w5KRWIdWqw+yuJ+OAxOhmAntRo5NgHBiA==
X-Google-Smtp-Source: ABdhPJx1aXzbU2HxJNyzGovz3AXrpAZQOQ6O5RVdez48MO4SqNz2fgsb0bWhAFSkk7gge8JddcEQuC3EGfOap3RH2eI=
X-Received: by 2002:a05:6214:410e:: with SMTP id kc14mr42995139qvb.73.1639395044220;
 Mon, 13 Dec 2021 03:30:44 -0800 (PST)
MIME-Version: 1.0
References: <20211212062407.138309-1-marcan@marcan.st> <20211212062407.138309-2-marcan@marcan.st>
 <CABxcv=m4fu8h=FwY7R=thuvd13_ZbFqB9rNNN07QOAd__jdYSQ@mail.gmail.com> <63334964-d63d-7625-e46f-a6e6ec19e908@marcan.st>
In-Reply-To: <63334964-d63d-7625-e46f-a6e6ec19e908@marcan.st>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Mon, 13 Dec 2021 12:30:33 +0100
Message-ID: <CABxcv=kbR5GX3yEfqchKJPkCqpWp_oKWjG=pu7LikBwoSX8W3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] of: Move simple-framebuffer device handling from
 simplefb to of
To:     Hector Martin <marcan@marcan.st>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:46 AM Hector Martin <marcan@marcan.st> wrote:
>
> On 13/12/2021 17.44, Javier Martinez Canillas wrote:
> > Hello Hector,
> >
> > On Sun, Dec 12, 2021 at 7:24 AM Hector Martin <marcan@marcan.st> wrote:
> >>
> >> This code is required for both simplefb and simpledrm, so let's move it
> >> into the OF core instead of having it as an ad-hoc initcall in the
> >> drivers.
> >>
> >> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> Signed-off-by: Hector Martin <marcan@marcan.st>
> >> ---
> >>   drivers/of/platform.c          |  4 ++++
> >>   drivers/video/fbdev/simplefb.c | 21 +--------------------
> >>   2 files changed, 5 insertions(+), 20 deletions(-)
> >>
> >
> > This is indeed a much better approach than what I suggested. I just
> > have one comment.
> >
> >> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> >> index b3faf89744aa..793350028906 100644
> >> --- a/drivers/of/platform.c
> >> +++ b/drivers/of/platform.c
> >> @@ -540,6 +540,10 @@ static int __init of_platform_default_populate_init(void)
> >>                  of_node_put(node);
> >>          }
> >>
> >> +       node = of_get_compatible_child(of_chosen, "simple-framebuffer");
> >
> > You have to check if the node variable is NULL here.
> >
> >> +       of_platform_device_create(node, NULL, NULL);
> >
> > Otherwise this could lead to a NULL pointer dereference if debug
> > output is enabled (the node->full_name is printed).
>
> Where is it printed? I thought I might need a NULL check, but this code

Sorry, I misread of_amba_device_create() as
of_platform_device_create(), which uses the "%pOF" printk format
specifier [0] to print the node's full name as a debug output [1].

[0]: https://elixir.bootlin.com/linux/v5.16-rc5/source/Documentation/core-api/printk-formats.rst#L462
[1]: https://elixir.bootlin.com/linux/v5.16-rc5/source/drivers/of/platform.c#L233

> was suggested verbatim by Rob in v2 without the NULL check and digging
> through I found that the NULL codepath is safe.
>

You are right that passing NULL is a safe code path for now due the
of_device_is_available(node) check, but that seems fragile to me since
just adding a similar debug output to of_platform_device_create()
could trigger the NULL pointer dereference.

Best regards,
Javier
