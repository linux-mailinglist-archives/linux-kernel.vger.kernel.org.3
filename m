Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65574B75E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241087AbiBOSDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:03:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240552AbiBOSDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:03:02 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA529CEA2B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:02:49 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id d3so15441213ilr.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vHlV/LtgGXNiZ7zK5zIyGJOfGAkSpkjLSX123D9TpgA=;
        b=lZlLqVCF5x50Bw2WI0EmXhOEjbmCR23f3VzzrlMJALYbhC7MgI5zF3t2kRSeFNXgm/
         rDDMLTaPP0dhqmJLiYSNIqgNUUb+sVxvFZnMVM65kctrFrm+2wfIdNizm8DuNZ7Ndxu9
         +T0TtFxp1mv9GBEgCqd/+joe9Uwyn5DSCKRbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHlV/LtgGXNiZ7zK5zIyGJOfGAkSpkjLSX123D9TpgA=;
        b=P5h+h71ZM//9jTQeQos8O718+8CiLG+Mibq4U3oIJI9LQjne7BIYxLv0b9CE5wIXd1
         QKYGx4eNNGWGwHIpB3RbaZkaeD+dgAoBQ8neerNcC0lIBe7xdTF/vFKtJVfWU91xVAmb
         slrFon/EX2F2YT0UTBKbkc9xTK7EXOv2pIpKWUJmcCXs1lyMp03FywkrZdXNxyo4/+O7
         F0OV4Nk+GTPEAxAN/QFC5K78q84jn4ZVN1CFvonLPTLCO3caQVDJPLDgEdJ2mscsELsD
         QJyhvUizY+ZDOji6p6wixFFqLHwVQIFuF2+6kO/ZMyjONh4cIxo68B80dcvUN8X9Cuv/
         MnSg==
X-Gm-Message-State: AOAM532VALmHdhG6NBwoDyoAc6fRWSD514BNtPcx3R6zxnTxg52aBJaC
        5eenUkp5+ecrN2UeJBzg2KOv6EvIT8RhbA==
X-Google-Smtp-Source: ABdhPJw0PQMD+Dxcrm82KOyT/bHH+lUnbJpC8VXaLLIRZu5KL7AULyTQZErqjnAA4d3dE/c8ktUdWg==
X-Received: by 2002:a05:6e02:180f:: with SMTP id a15mr185970ilv.8.1644948169400;
        Tue, 15 Feb 2022 10:02:49 -0800 (PST)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id k10sm11346763ilo.8.2022.02.15.10.02.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 10:02:49 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id r8so2513530ioc.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:02:49 -0800 (PST)
X-Received: by 2002:a05:6638:4810:: with SMTP id cp16mr51427jab.207.1644948168679;
 Tue, 15 Feb 2022 10:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20220119204345.3769662-1-mka@chromium.org> <20220119124327.v20.3.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <YgJMX0QK9Koyu/uv@kroah.com> <YgLB0/aJJvGm3oYR@google.com>
In-Reply-To: <YgLB0/aJJvGm3oYR@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 15 Feb 2022 10:02:36 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VJmb_P9Rnn0ooNAkf3ese-BEWZr8z-Vc0RMdF=gHmNvw@mail.gmail.com>
Message-ID: <CAD=FV=VJmb_P9Rnn0ooNAkf3ese-BEWZr8z-Vc0RMdF=gHmNvw@mail.gmail.com>
Subject: Re: [PATCH v20 3/5] usb: misc: Add onboard_usb_hub driver
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 8, 2022 at 11:17 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > +/*
> > > + * Returns the onboard_hub platform device that is associated with the USB
> > > + * device passed as parameter.
> > > + */
> > > +static struct onboard_hub *_find_onboard_hub(struct device *dev)
> > > +{
> > > +   struct platform_device *pdev;
> > > +   struct device_node *np;
> > > +   struct onboard_hub *hub;
> > > +
> > > +   pdev = of_find_device_by_node(dev->of_node);
> > > +   if (!pdev) {
> > > +           np = of_parse_phandle(dev->of_node, "companion-hub", 0);
> > > +           if (!np) {
> > > +                   dev_err(dev, "failed to find device node for companion hub\n");
> > > +                   return ERR_PTR(-EINVAL);
> > > +           }
> > > +
> > > +           pdev = of_find_device_by_node(np);
> > > +           of_node_put(np);
> > > +
> > > +           if (!pdev || !device_is_bound(&pdev->dev)) {
> >
> > I don't understand why you need to call device_is_bound() here.  What
> > are you wanting to find here?
>
> Whether the platform driver actually probed.
>
> > You found the hub device associated to this usb device, based on the
> > of_find_device_by_node() call, so why check it again?  What could have
> > happened that this isn't the correct device?
>
> It is the correct platform device, however it might not have finished
> probing (this function is called from the USB driver). It's an unlikely
> case, but it might happen, especially if the bootloader left the hub
> regulator enabled (otherwise it would only be enabled by the platform
> driver).
>
> If device_is_bound() is a no-go (as it seems) the function could check
> the drvdata instead.

So IMO the answer here is to send a v21:

1. Switch to use drvdata just to you can avoid the controversial
device_is_bound() export.

2. Add a comment here explaining _why_ you are checking the drvdata
and return -EPROBE_DEFER. In general if it's confusing to someone
during a code review it will be confusing to someone later and so
deserves a comment. Something along the lines of: "Just to be
paranoid, we check that the drvdata is set which indicates that the
platform driver has finished probing. This handles the case where
(conceivably) we could be running at the exact same time as the
platform driver's probe. If we detect the race we request probe
deferral and we'll come back and try again."


> > > +   err = onboard_hub_add_usbdev(hub, udev);
> > > +   if (err)
> > > +           return err;
> > > +
> > > +   err = sysfs_create_link(&udev->dev.kobj, &hub->dev->kobj, "onboard_hub_dev");
> >
> > What is this link for?  Messing with sysfs links is a pain and drivers
> > really shouldn't be doing them if at all possible.
>
> Alan asked me to add them. It's not strictly needed. I'm fine with removing
> them as long as there is no strong opposition to that :)

I don't personally care either way. I'd say remove them and they can
be added back later?


> > > +   if (err)
> > > +           dev_warn(&udev->dev, "failed to create symlink to platform device '%s'): %d\n",
> > > +                    dev_name(hub->dev), err);
> > > +
> > > +   return 0;
> >
> > So you ignore the error?  That's fine, just odd.
>
> Yes, the links aren't critical for the functioning of the driver.

If you keep the links in, this is another good place for a comment,
even something as simple as what you just said above about the links
not being critical for the driver to function.

-Doug
