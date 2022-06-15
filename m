Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C177954D52F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 01:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346541AbiFOXWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 19:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347671AbiFOXWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 19:22:41 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AC1CC1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:22:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h1so11639174plf.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kKgcATlotasIlfDoEE4GaADueihF7oAvsbAbuWsLV+I=;
        b=dl2bFEl7QiTxf5UiajZyTkczzJ5etN3Au+wvti8M6/02D5soc0cUrXFWglb9TwEmbV
         2nkDcWvLC5+BCkRKxleuBJEusp+G/5rmPaNKkYfeHUvXuNzrN4ZznY2v12puJRDK2ufq
         TftXl18G63Om9JajfB3AfQy7MFlXDO6aK3D24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kKgcATlotasIlfDoEE4GaADueihF7oAvsbAbuWsLV+I=;
        b=amniJvMYUKGr+gNI1HRg8fgjLg9+1NFys0WxaXrX8zi+DJ9QXSa6t6ofemHGX6kJTg
         9EU5zp+DytE2LIkegAcRIJngS/dTRtSvs/M9K5Bip5pE1to6B0Gi2dV4/C+tgSUSQV+y
         6y6UZWI6flMTLcvfFuB3NHg9bLNeOGIlvuG2fKmguEpEvfNbvl3HD5NAGLt5vml1oFVp
         wuxvzo99asx4rvoipl9UMze3IvIcMiamKkiKbErNfNnEeZUD3Pd1HF67EFrUBN4NdK0m
         mFzKuSwAqHdJtRWZ5+E+stjDFiNU1+HzQ0otpiezNz43zU0ucehcwbCRQJv4nk1AhIHv
         Rarg==
X-Gm-Message-State: AJIora97P6k7udobsMseMFkPKGB10L+XRKbAqYw5pl6G1UULccgOw6OY
        iyk/xbutYgCn0xVKi8BM/GJuWA==
X-Google-Smtp-Source: AGRyM1uzV4pGgVgdvUkLB9seYtAeFhHJEicUYl/4Iz512ptPwn8c0JBJ0OEi2NFH8ig3n0SWr2vBGg==
X-Received: by 2002:a17:903:1cd:b0:168:e97b:54be with SMTP id e13-20020a17090301cd00b00168e97b54bemr2011709plh.163.1655335352461;
        Wed, 15 Jun 2022 16:22:32 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:c2dd:1130:d31f:3b25])
        by smtp.gmail.com with UTF8SMTPSA id p127-20020a62d085000000b0051b9a2d639dsm195416pfg.43.2022.06.15.16.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 16:22:31 -0700 (PDT)
Date:   Wed, 15 Jun 2022 16:22:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>,
        Peter Chen <peter.chen@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: Re: [PATCH v22 2/3] usb: misc: Add onboard_usb_hub driver
Message-ID: <YqpprpUHmlD62YzI@google.com>
References: <20220609192000.990763-1-mka@chromium.org>
 <20220609121838.v22.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <CAD=FV=W6erE8ByabmYSL_OWJPKYGqysDMGYQX6j7_PSEYGZ4YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=W6erE8ByabmYSL_OWJPKYGqysDMGYQX6j7_PSEYGZ4YQ@mail.gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Thanks for the review!

On Wed, Jun 15, 2022 at 02:09:43PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 9, 2022 at 12:20 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > @@ -11,6 +11,7 @@ usbcore-y += phy.o port.o
> >  usbcore-$(CONFIG_OF)           += of.o
> >  usbcore-$(CONFIG_USB_PCI)              += hcd-pci.o
> >  usbcore-$(CONFIG_ACPI)         += usb-acpi.o
> > +usbcore-$(CONFIG_USB_ONBOARD_HUB)      += ../misc/onboard_usb_hub_pdevs.o
> 
> I'm OK with this solution of just linking the code into the "usbcore"
> if USB folks are. Thinking about it, I guess another way to solve the
> circular dependency is to somehow create some type of generic
> notification scheme where the USB hub driver subscribes to "a hub has
> appeared" notification. ...but I don't personally have any intuition
> about whether people would like that better than your solution.

Not sure if it would be better (if feasible). In any case it would require
the hub to be powered (to be enumerated) which is precisely what the
onboard_usb_hub driver intends to do.

> > +config USB_ONBOARD_HUB
> > +       bool "Onboard USB hub support"
> > +       depends on OF || COMPILE_TEST
> > +       help
> > +         Say Y here if you want to support discrete onboard USB hubs that
> > +         don't require an additional control bus for initialization, but
> > +         need some non-trivial form of initialization, such as enabling a
> > +         power regulator. An example for such a hub is the Realtek
> > +         RTS5411.
> > +
> > +         This driver can be used as a module but its state (module vs
> > +         builtin) must match the state of the USB subsystem. Enabling
> > +         this config will enable the driver and it will automatically
> > +         match the state of the USB subsystem. If this driver is a
> > +         module it will be called onboard_usb_hub.
> > +
> > +if USB_ONBOARD_HUB
> > +config USB_ONBOARD_HUB_ACTUAL
> > +       tristate
> > +       default m if USB=m
> > +       default y if USB=y
> > +endif
> 
> Do you still need to play the games with "_ACTUAL"? The USB core no
> longer calls the hub directly. I think that means you can just "depend
> on USB" and be done with the mess. That allows USB to be builtin and
> USB_ONBOARD_HUB can be a module, right?

Good point, with the pdev creation inside the USB core it shouldn't be
needed anymore.

> > +static int onboard_hub_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct onboard_hub *hub;
> > +       int err;
> > +
> > +       hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
> > +       if (!hub)
> > +               return -ENOMEM;
> > +
> > +       hub->vdd = devm_regulator_get(dev, "vdd");
> > +       if (IS_ERR(hub->vdd))
> > +               return PTR_ERR(hub->vdd);
> > +
> > +       hub->dev = dev;
> > +       mutex_init(&hub->lock);
> > +       INIT_LIST_HEAD(&hub->udev_list);
> > +
> > +       dev_set_drvdata(dev, hub);
> > +
> > +       err = onboard_hub_power_on(hub);
> > +       if (err)
> > +               return err;
> > +
> > +       /*
> > +        * The USB driver might have been detached from the USB devices by
> > +        * onboard_hub_remove(), make sure to re-attach it if needed.
> > +        *
> > +        * This needs to be done deferred to avoid self-deadlocks on systems
> > +        * with nested onboard hubs.
> > +        */
> > +       INIT_WORK(&hub->attach_usb_driver_work, onboard_hub_attach_usb_driver);
> > +       schedule_work(&hub->attach_usb_driver_work);
> 
> I'm sure that the above is totally necessary but it's been long enough
> since I looked at this code last that I've totally forgotten why. Any
> chance you could add comments to say under what situation
> onboard_hub_remove() would have detached the USB driver? Is this
> something where you unbind the platform driver and then bind it again?

Yes, that's the scenario in which I encountered that the hub USB
devices wouldn't be bound to the onboard_hub_driver again.

> ...and why does that cause the driver to be detached?

We call device_release_driver(udev) in onboard_hub_remove() to
make sure the USB devices don't keep a reference to the platform
device after it is removed.

> > +/**
> > + * onboard_hub_create_pdevs -- create platform devices for onboard USB hubs
> > + * @parent_hub : parent hub to scan for connected onboard hubs
> > + * @pdev_list  : list of onboard hub platform devices owned by the parent hub
> > + *
> > + * Creates a platform device for each supported onboard hub that is connected to
> > + * the given parent hub. To keep track of the platform devices they are added to
> > + * a list that is owned by the parent hub.
> 
> I'm ashamed to admit how long it took me to remember why exactly we
> needed a platform device to begin with and why the normal USB devices
> weren't enough (it's because we won't enumerate the USB devices until
> we're powered and so the platform device is in charge of powering
> things up). Finally I re-read the commit message and then it made
> sense, but someone looking at the code later might not think to look
> at the commit message for a while. Maybe remind people in the comments
> for this function? Even if it's somewhere else in the code and I
> missed it, I wouldn't mind a tiny blurb here.

Ok, I can add a short note.

> > +void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *pdev_list)
> > +{
> > +       int i;
> > +       struct usb_hcd *hcd = bus_to_hcd(parent_hub->bus);
> > +       struct device_node *np, *npc;
> > +       struct platform_device *pdev = NULL;
> > +       struct pdev_list_entry *pdle;
> > +
> > +       if (!parent_hub->dev.of_node)
> > +               return;
> > +
> > +       for (i = 1; i <= parent_hub->maxchild; i++) {
> > +               np = usb_of_get_device_node(parent_hub, i);
> > +               if (!np)
> > +                       continue;
> > +
> > +               if (!of_is_onboard_usb_hub(np))
> > +                       goto node_put;
> > +
> > +               npc = of_parse_phandle(np, "companion-hub", 0);
> > +               if (npc) {
> > +                       /*
> > +                        * Hubs with companions share the same platform device.
> > +                        * Create the plaform device only for the hub that is
> > +                        * connected to the primary HCD (directly or through
> > +                        * other hubs).
> > +                        */
> > +                       if (!usb_hcd_is_primary_hcd(hcd)) {
> > +                               of_node_put(npc);
> > +                               goto node_put;
> > +                       }
> > +
> > +                       pdev = of_find_device_by_node(npc);
> > +                       of_node_put(npc);
> > +               } else {
> > +                       /*
> > +                        * For root hubs this function can be called multiple times
> > +                        * for the same root hub node (the HCD node). Make sure only
> > +                        * one platform device is created for this hub.
> > +                        */
> > +                       if (!parent_hub->parent && !usb_hcd_is_primary_hcd(hcd))
> > +                               goto node_put;
> 
> I don't understand the "else" case above. What case exactly are we
> handling again? This is when:
> * the hub is presumably just a 2.0 hub since there is no companion.
> * our parent is the root hub and the USB 2.0 hub we're looking at is
> not the primary

The 'else' case can be entered for hubs connected to a root hub or to another
hub further down in the tree, but we bail out only for first level hubs.

> ...but that doesn't make a lot of sense to me? I must have missed something...

It's not super-obvious, this bit is important: "this function can be called
multiple times for the same root hub node". For any first level hub we only
create a pdev if this function is called on behalf of the primary HCD. That
is also true of a hub connected to the secondary HCD. We only want to create
one pdev and there is supposedly always a primary HCD.

Maybe it would be slightly clearer if the function returned before the loop
if this condition is met. Unfortunately we can't just always ignore the
secondary HCD because:

> In general though, do we even need to look at the "companion-hub"
> property? If this node matches an onboard USB hub and it's the primary
> HCD then we want a platform dev. Otherwise we don't, right?

This wouldn't work for some topologies like:

3.x root hub
  <nothing connected>

2.x root hub
  2.x-only hub

no platform device would be created for the 2.x-only hub since it isn't
connected to the primary HCD

or

3.x root hub
  3.x hub

2.x root hub
  2.x hub
    2.x-only hub

The first level hub would have a platform device for being a companion hub
of the 3.x hub, however no pdev would be created for the second level hub
since the 2.x root hub isn't primary.
