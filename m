Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8551748DDC2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbiAMSiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237560AbiAMSiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:38:20 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A0EC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 10:38:20 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 78so652893pfu.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 10:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LfqGZyXCNXa/AnmwBwCorU7YL3clKgn41SOvn2cR5bo=;
        b=JprhPsBPdubaUkkv1eBzn/Alk/hr60xN2pp1Rugr8FdXyn8GJIB/K1PCBYpLXlRwfs
         DO3E5wLZH8jAWtRaDCEL4fygzZtbwEV30PWWtkUSSSwUrGATlSIuFI6aO8rqBOCXhJm2
         dX0jhiDEftK7ioqISokGam3DXsj2Kta6c9Vxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LfqGZyXCNXa/AnmwBwCorU7YL3clKgn41SOvn2cR5bo=;
        b=LSqqxHCyALyTBo3PRljkDfP+4FaHnQEkVLdeNuXb1d/4S7PbhpqAgLNmJcDFhYKcKw
         TRa5WYqOsswgGt37IBzGQvu1PaPRchUgqWNgNQcFmNOaPJo57bCWWVzorOgn5dmRX/OA
         xmXhQRryhdS0RpQFEJDCiAED9R/6VW+Aw88bHTEw+2Xp5HkLyWd24EoHuWD4Ixyzk3zQ
         sSh23xGdu5GgR/8MQAiyL6xTAb+IyKG1b5y+u9ckcQ5qRU3JPvfGINWsuZ/0oahvTgkA
         FbCC37mZpQLKYxqC8kA+MLNHZ8PeRRD8vydG3+X1CBH6Q229r7izoR0Xjn10zLbN1pU9
         5D8w==
X-Gm-Message-State: AOAM530qI0YcXoAkMGHdBDJcjVDVtzj2HHQR3PGGU24Ab8Y6awdepk+x
        2tJT88EQ+LbfUzgdtbAeLgdf8Q==
X-Google-Smtp-Source: ABdhPJyo9D9eC6NpVoIxM6mGIOnPCru3/sX+WXSZrSxbWZwAVds1zjcvKi2hi6uAfuDA7DzHSrOyBw==
X-Received: by 2002:a63:9242:: with SMTP id s2mr4952774pgn.316.1642099099013;
        Thu, 13 Jan 2022 10:38:19 -0800 (PST)
Received: from localhost ([2620:15c:202:201:d9fc:bf52:3ca:199b])
        by smtp.gmail.com with UTF8SMTPSA id m6sm758094pff.112.2022.01.13.10.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 10:38:17 -0800 (PST)
Date:   Thu, 13 Jan 2022 10:38:15 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v19 3/5] usb: misc: Add onboard_usb_hub driver
Message-ID: <YeBxl0lCcXo3GVVp@google.com>
References: <20220112191048.837236-1-mka@chromium.org>
 <20220112111028.v19.3.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <CAE-0n51+1QQbZ6q4FUgRiw+QNR03_rDp6+e-kKz_KjZ=Y3N6Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE-0n51+1QQbZ6q4FUgRiw+QNR03_rDp6+e-kKz_KjZ=Y3N6Kw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

thanks for the review!

On Wed, Jan 12, 2022 at 07:49:40PM -0800, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2022-01-12 11:10:46)
> > diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> > index 8f1144359012..bbced519499a 100644
> > --- a/drivers/usb/misc/Kconfig
> > +++ b/drivers/usb/misc/Kconfig
> > @@ -284,3 +284,26 @@ config BRCM_USB_PINMAP
> >           This option enables support for remapping some USB external
> >           signals, which are typically on dedicated pins on the chip,
> >           to any gpio.
> > +
> > +config USB_ONBOARD_HUB
> > +       bool "Onboard USB hub support"
> > +       depends on OF || COMPILE_TEST
> > +       help
> > +         Say Y here if you want to support discrete onboard USB hubs that
> > +         don't require an additional control bus for initialization, but
> > +         need some nontrivial form of initialization, such as enabling a
> 
> s/nontrivial/non-trivial/

ack

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
> > diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> > new file mode 100644
> > index 000000000000..4e88e3089def
> > --- /dev/null
> > +++ b/drivers/usb/misc/onboard_usb_hub.c
> > @@ -0,0 +1,494 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + *  Driver for onboard USB hubs
> > + *
> > + * Copyright (c) 2020, Google LLC
> > + */
> > +
> > +#include <linux/device.h>
> 
> Add export.h for EXPORT_SYMBOL_GPL usage

will do

> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/suspend.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/usb.h>
> > +#include <linux/usb/hcd.h>
> 
> Is this include used?

Yes, it is needed for calling usb_wakeup_enabled_descendants()

> > ...
> >
> > +static int __maybe_unused onboard_hub_suspend(struct device *dev)
> > +{
> > +       struct onboard_hub *hub = dev_get_drvdata(dev);
> > +       struct usbdev_node *node;
> > +       bool power_off;
> > +
> > +       if (hub->always_powered_in_suspend)
> > +               return 0;
> > +
> > +       power_off = true;
> 
> Nitpick: Move this up to the declaration.

ok

> > ...
> >
> > +static int __maybe_unused onboard_hub_resume(struct device *dev)
> > +{
> > +       struct onboard_hub *hub = dev_get_drvdata(dev);
> > +
> > +       if (hub->is_powered_on)
> > +               return 0;
> > +
> > +       return onboard_hub_power_on(hub);
> > +}
> > +
> > +static inline void set_udev_link_name(struct usb_device *udev, char *buf, size_t size)
> 
> const udev?

ack

> > +{
> > +       snprintf(buf, size, "usb_dev.%s", dev_name(&udev->dev));
> > +}
> > +
> > +static int onboard_hub_add_usbdev(struct onboard_hub *hub, struct usb_device *udev)
> > +{
> > +       struct usbdev_node *node;
> > +       char link_name[64];
> > +       int ret = 0;
> > +
> > +       mutex_lock(&hub->lock);
> > +
> > +       if (hub->going_away) {
> > +               ret = -EINVAL;
> > +               goto unlock;
> > +       }
> > +
> > +       node = devm_kzalloc(hub->dev, sizeof(*node), GFP_KERNEL);
> > +       if (!node) {
> > +               ret = -ENOMEM;
> > +               goto unlock;
> > +       }
> > +
> > +       node->udev = udev;
> > +
> > +       list_add(&node->list, &hub->udev_list);
> > +
> > +       set_udev_link_name(udev, link_name, sizeof(link_name));
> 
> It feels like udev is being modified by the name of the function. Maybe
> get_udev_link_name() is better or set_link_name_from_udev() or pass
> link_name first instead of udev?

Agreed, the name be confusing, I'll change it to get_udev_link_name().

> > +       WARN_ON(sysfs_create_link(&hub->dev->kobj, &udev->dev.kobj, link_name));
> 
> Does this need to be done underneath the 'hub->lock'? It would be nice
> to only hold the mutex while modifying the 'udev_list'. Same applies for
> calling set_udev_link_name().

Not strictly speaking, it just makes the code flow a bit simpler and there
shouldn't be much contention. I can change the code to have a dedicated
error path instead.

> > +
> > +unlock:
> > +       mutex_unlock(&hub->lock);
> > +
> > +       return ret;
> > +}
> > +
> > +static void onboard_hub_remove_usbdev(struct onboard_hub *hub, struct usb_device *udev)
> 
> const udev?

ok

> > +{
> > +       struct usbdev_node *node;
> > +       char link_name[64];
> > +
> > +       set_udev_link_name(udev, link_name, sizeof(link_name));
> > +       sysfs_remove_link(&hub->dev->kobj, link_name);
> > +
> > +       mutex_lock(&hub->lock);
> > +
> > +       list_for_each_entry(node, &hub->udev_list, list) {
> > +               if (node->udev == udev) {
> > +                       list_del(&node->list);
> 
> Maybe worth noting here that we don't free 'node' because it will be
> freed when the hub platform driver is unbound. Of course, we could shave
> some bytes and free the node here instead of later by not using devm.

Before adding a comment I prefer not to use devm and free the node here.

> > +                       break;
> > +               }
> > +       }
> > +
> > +       mutex_unlock(&hub->lock);
> > +}
> > +
> > +static ssize_t always_powered_in_suspend_show(struct device *dev, struct device_attribute *attr,
> > +                          char *buf)
> > +{
> > +       struct onboard_hub *hub = dev_get_drvdata(dev);
> 
> const?

will change

> > ...
> >
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
> > +        */
> > +       err = driver_attach(&onboard_hub_usbdev_driver.drvwrap.driver);
> > +       if (err) {
> > +               onboard_hub_power_off(hub);
> > +               return err;
> 
> drop return
> 
> > +       }
> > +
> > +       return 0;
> 
> and then
> 
> 	return err;

I would prefer to keep things as they are, IMO the code flow is clearer and
the fact that the function has one statement less doesn't have any impact in
practice.

> > ...
> >
> > +/*
> > + * Returns the onboard_hub platform device that is associated with the USB
> > + * device passed as parameter.
> > + */
> > +static struct onboard_hub *_find_onboard_hub(struct device *dev)
> > +{
> > +       struct platform_device *pdev;
> > +       struct device_node *np;
> > +
> > +       pdev = of_find_device_by_node(dev->of_node);
> > +       if (!pdev) {
> > +               np = of_parse_phandle(dev->of_node, "companion-hub", 0);
> > +               if (!np) {
> > +                       dev_err(dev, "failed to find device node for companion hub\n");
> > +                       return ERR_PTR(-EINVAL);
> > +               }
> > +
> > +               pdev = of_find_device_by_node(np);
> > +               of_node_put(np);
> > +
> > +               if (!pdev || !device_is_bound(&pdev->dev))
> 
> Should we put_device(pdev) if !device_is_bound()?

ack

> 
> > +                       return ERR_PTR(-EPROBE_DEFER);
> > +       }
> > +
> > +       put_device(&pdev->dev);
> > +
> > +       return dev_get_drvdata(&pdev->dev);
> 
> Should we hold pdev reference until we extract driver data out of it?
> i.e.
> 
> 	ret = dev_get_drvdata(&pdev->dev);
> 	put_device(&pdev->dev);
> 
> 	return ret;

will change as suggested

> > +}
> > +
> > +static int onboard_hub_usbdev_probe(struct usb_device *udev)
> > +{
> > +       struct device *dev = &udev->dev;
> > +       struct onboard_hub *hub;
> > +       int err;
> > +
> > +       /* ignore supported hubs without device tree node */
> > +       if (!dev->of_node)
> > +               return -ENODEV;
> > +
> > +       hub = _find_onboard_hub(dev);
> > +       if (IS_ERR(hub))
> > +               return PTR_ERR(hub);
> > +
> > +       dev_set_drvdata(dev, hub);
> > +
> > +       err = onboard_hub_add_usbdev(hub, udev);
> > +       if (err)
> > +               return err;
> > +
> > +       err = sysfs_create_link(&udev->dev.kobj, &hub->dev->kobj, "onboard_hub_dev");
> > +       if (err)
> > +               dev_warn(&udev->dev, "failed to create symlink to platform device: %d\n", err);
> 
> Might be useful to know which platform device this is trying to link to.
> Can the devname(hub->dev) be printed as well?

Ok, I'll add the device name

> > +
> > +       return 0;
> > +}
> > +
> > +static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
> > +{
> > +       struct onboard_hub *hub = dev_get_drvdata(&udev->dev);
> > +
> > +       sysfs_remove_link(&udev->dev.kobj, "onboard_hub_dev");
> > +
> > +       onboard_hub_remove_usbdev(hub, udev);
> > +}
> > +
> > +static const struct usb_device_id onboard_hub_id_table[] = {
> > +       { USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
> > +       { USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
> > +       { USB_DEVICE(VENDOR_ID_REALTEK, 0x0414) }, /* RTS5414 USB 3.2 */
> > +       { USB_DEVICE(VENDOR_ID_REALTEK, 0x5414) }, /* RTS5414 USB 2.1 */
> > +       {},
> 
> Nitpick: Drop comma so nothing can come after without a compile error.

ok

> 
> > +};
> > +
> 
> Nitpick: Drop newline here.

ok

> > ...
> >
> > +/*
> > + * Creates a platform device for each supported onboard hub that is connected to
> > + * the given parent hub. To keep track of the platform devices they are added to
> > + * a list that is owned by the parent hub.
> > + */
> 
> As this is an exported symbol can you please add kernel doc?

will add

> > +void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *pdev_list)
> 
> Can parent_hub be const?

That would make the compiler unhappy, since usb_of_get_device_node() and
of_platform_device_create() expect non-const parameters.

> > +{
> > +       int i;
> > +       struct device_node *np, *npc;
> > +       struct platform_device *pdev = NULL;
> > +       struct pdev_list_entry *pdle;
> > +
> > +       INIT_LIST_HEAD(pdev_list);
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
> > +                       pdev = of_find_device_by_node(npc);
> > +                       of_node_put(npc);
> > +               }
> > +
> > +               if (pdev) {
> > +                       /* the companion hub already has a platform device, nothing to do here */
> > +                       put_device(&pdev->dev);
> > +                       goto node_put;
> > +               }
> > +
> > +               pdev = of_platform_device_create(np, NULL, &parent_hub->dev);
> > +               if (!pdev) {
> > +                       dev_err(&parent_hub->dev,
> > +                               "failed to create platform device for onboard hub '%pOF'\n", np);
> > +                       goto node_put;
> > +               }
> > +
> > +               pdle = devm_kzalloc(&pdev->dev, sizeof(*pdle), GFP_KERNEL);
> > +               if (!pdle) {
> > +                       of_platform_device_destroy(&pdev->dev, NULL);
> > +                       goto node_put;
> > +               }
> > +
> > +               pdle->pdev = pdev;
> > +               list_add(&pdle->node, pdev_list);
> > +
> > +node_put:
> > +               of_node_put(np);
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(onboard_hub_create_pdevs);
> > +
> > +/*
> > + * Destroys the platform devices in the given list and frees the memory associated
> > + * with the list entry.
> 
> kerneldoc?

will add

> > + */
> > +void onboard_hub_destroy_pdevs(struct list_head *pdev_list)
> > +{
> > +       struct pdev_list_entry *pdle, *tmp;
> > +
> > +       list_for_each_entry_safe(pdle, tmp, pdev_list, node) {
> > +               list_del(&pdle->node);
> > +               of_platform_device_destroy(&pdle->pdev->dev, NULL);
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(onboard_hub_destroy_pdevs);
> > +
