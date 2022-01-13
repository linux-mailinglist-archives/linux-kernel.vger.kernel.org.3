Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B9748D114
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 04:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiAMDtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 22:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiAMDtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:49:41 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C55DC061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 19:49:41 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id m8-20020a9d4c88000000b00592bae7944bso1745481otf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 19:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=CbBiPOk79gUEzFjZpqqaGXl9mTkbFERlis1glBHSvbc=;
        b=M0PJbsGZf7WEULnIRMYmRKetbnlOx0uraZPyyRrfOS3oywFG8CALZgTzNGWwo0be0J
         YX8tfR9wh2XcBAqUaWwwM1i5yk0Bu35E6qn0Jr/Yy5+ad5OkbKCnKQPEYgL2/dAzatCf
         i0xhqA98H3z8ALQXTNmnQ8T08d1J208QSV/dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=CbBiPOk79gUEzFjZpqqaGXl9mTkbFERlis1glBHSvbc=;
        b=pFIG9XoLMcP3iPaLkSchEPZyXlYmlIkSBeGoq9GZlI+n5/lpI+Eq9abLFrK+nyWmIF
         W8XBokbr6DPgry8sN7OrXmelAClbZVYRAguiZOhsHZT6xdSLcGZzwZozhsck/3U6cvM5
         dtR++Ymiaa0yHg+sU0pAIfsHV3d6nk6UkRqmrtPaTs+H5YQTfO8pXx0egx/TLji23CWA
         /M7LH8bq87Uo7z6mzF4c4vvCEUotZ80Wlcm5vshkIPgnq5eHX758NV+K0QxfrBpYBZ2Z
         GEd4rxxZAhg8Tk7LhXqs7U3gkzxMp7cFkN41zLvIOdjzJN//x2H0rz4KNwtbJFbctnzr
         q8kA==
X-Gm-Message-State: AOAM530eQNeqbL1fLutAXIa8GaNcSKsZQ4HXgMQbuD+ipRFtPlx+44On
        s6fdL4F5b6m+e+VONTjgnG9g2uqGo9TUuvoCVTrnIA==
X-Google-Smtp-Source: ABdhPJzFSfeFn/HwSzPk+K37S57N58yVJdHFZCzEeHgoCWrV3NXTTqhhysKvaVa/l0idojpJzfSFc3QAWoFcuXGNmjc=
X-Received: by 2002:a9d:7451:: with SMTP id p17mr1879536otk.159.1642045780682;
 Wed, 12 Jan 2022 19:49:40 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Jan 2022 19:49:40 -0800
MIME-Version: 1.0
In-Reply-To: <20220112111028.v19.3.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
References: <20220112191048.837236-1-mka@chromium.org> <20220112111028.v19.3.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 12 Jan 2022 19:49:40 -0800
Message-ID: <CAE-0n51+1QQbZ6q4FUgRiw+QNR03_rDp6+e-kKz_KjZ=Y3N6Kw@mail.gmail.com>
Subject: Re: [PATCH v19 3/5] usb: misc: Add onboard_usb_hub driver
To:     Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2022-01-12 11:10:46)
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 8f1144359012..bbced519499a 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -284,3 +284,26 @@ config BRCM_USB_PINMAP
>           This option enables support for remapping some USB external
>           signals, which are typically on dedicated pins on the chip,
>           to any gpio.
> +
> +config USB_ONBOARD_HUB
> +       bool "Onboard USB hub support"
> +       depends on OF || COMPILE_TEST
> +       help
> +         Say Y here if you want to support discrete onboard USB hubs that
> +         don't require an additional control bus for initialization, but
> +         need some nontrivial form of initialization, such as enabling a

s/nontrivial/non-trivial/

> +         power regulator. An example for such a hub is the Realtek
> +         RTS5411.
> +
> +         This driver can be used as a module but its state (module vs
> +         builtin) must match the state of the USB subsystem. Enabling
> +         this config will enable the driver and it will automatically
> +         match the state of the USB subsystem. If this driver is a
> +         module it will be called onboard_usb_hub.
> +
> +if USB_ONBOARD_HUB
> +config USB_ONBOARD_HUB_ACTUAL
> +       tristate
> +       default m if USB=m
> +       default y if USB=y
> +endif
> diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> new file mode 100644
> index 000000000000..4e88e3089def
> --- /dev/null
> +++ b/drivers/usb/misc/onboard_usb_hub.c
> @@ -0,0 +1,494 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  Driver for onboard USB hubs
> + *
> + * Copyright (c) 2020, Google LLC
> + */
> +
> +#include <linux/device.h>

Add export.h for EXPORT_SYMBOL_GPL usage

> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/suspend.h>
> +#include <linux/sysfs.h>
> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>

Is this include used?

> +#include <linux/usb/of.h>
> +#include <linux/usb/onboard_hub.h>
> +
> +static struct usb_device_driver onboard_hub_usbdev_driver;
> +
> +/************************** Platform driver **************************/
> +
> +struct usbdev_node {
> +       struct usb_device *udev;
> +       struct list_head list;
> +};
> +
> +struct onboard_hub {
> +       struct regulator *vdd;
> +       struct device *dev;
> +       bool always_powered_in_suspend;
> +       bool is_powered_on;
> +       bool going_away;
> +       struct list_head udev_list;
> +       struct mutex lock;
> +};
> +
> +static int onboard_hub_power_on(struct onboard_hub *hub)
> +{
> +       int err;
> +
> +       err = regulator_enable(hub->vdd);
> +       if (err) {
> +               dev_err(hub->dev, "failed to enable regulator: %d\n", err);
> +               return err;
> +       }
> +
> +       hub->is_powered_on = true;
> +
> +       return 0;
> +}
> +
> +static int onboard_hub_power_off(struct onboard_hub *hub)
> +{
> +       int err;
> +
> +       err = regulator_disable(hub->vdd);
> +       if (err) {
> +               dev_err(hub->dev, "failed to disable regulator: %d\n", err);
> +               return err;
> +       }
> +
> +       hub->is_powered_on = false;
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused onboard_hub_suspend(struct device *dev)
> +{
> +       struct onboard_hub *hub = dev_get_drvdata(dev);
> +       struct usbdev_node *node;
> +       bool power_off;
> +
> +       if (hub->always_powered_in_suspend)
> +               return 0;
> +
> +       power_off = true;

Nitpick: Move this up to the declaration.

> +
> +       mutex_lock(&hub->lock);
> +
> +       list_for_each_entry(node, &hub->udev_list, list) {
> +               if (!device_may_wakeup(node->udev->bus->controller))
> +                       continue;
> +
> +               if (usb_wakeup_enabled_descendants(node->udev)) {
> +                       power_off = false;
> +                       break;
> +               }
> +       }
> +
> +       mutex_unlock(&hub->lock);
> +
> +       if (!power_off)
> +               return 0;
> +
> +       return onboard_hub_power_off(hub);
> +}
> +
> +static int __maybe_unused onboard_hub_resume(struct device *dev)
> +{
> +       struct onboard_hub *hub = dev_get_drvdata(dev);
> +
> +       if (hub->is_powered_on)
> +               return 0;
> +
> +       return onboard_hub_power_on(hub);
> +}
> +
> +static inline void set_udev_link_name(struct usb_device *udev, char *buf, size_t size)

const udev?

> +{
> +       snprintf(buf, size, "usb_dev.%s", dev_name(&udev->dev));
> +}
> +
> +static int onboard_hub_add_usbdev(struct onboard_hub *hub, struct usb_device *udev)
> +{
> +       struct usbdev_node *node;
> +       char link_name[64];
> +       int ret = 0;
> +
> +       mutex_lock(&hub->lock);
> +
> +       if (hub->going_away) {
> +               ret = -EINVAL;
> +               goto unlock;
> +       }
> +
> +       node = devm_kzalloc(hub->dev, sizeof(*node), GFP_KERNEL);
> +       if (!node) {
> +               ret = -ENOMEM;
> +               goto unlock;
> +       }
> +
> +       node->udev = udev;
> +
> +       list_add(&node->list, &hub->udev_list);
> +
> +       set_udev_link_name(udev, link_name, sizeof(link_name));

It feels like udev is being modified by the name of the function. Maybe
get_udev_link_name() is better or set_link_name_from_udev() or pass
link_name first instead of udev?

> +       WARN_ON(sysfs_create_link(&hub->dev->kobj, &udev->dev.kobj, link_name));

Does this need to be done underneath the 'hub->lock'? It would be nice
to only hold the mutex while modifying the 'udev_list'. Same applies for
calling set_udev_link_name().

> +
> +unlock:
> +       mutex_unlock(&hub->lock);
> +
> +       return ret;
> +}
> +
> +static void onboard_hub_remove_usbdev(struct onboard_hub *hub, struct usb_device *udev)

const udev?

> +{
> +       struct usbdev_node *node;
> +       char link_name[64];
> +
> +       set_udev_link_name(udev, link_name, sizeof(link_name));
> +       sysfs_remove_link(&hub->dev->kobj, link_name);
> +
> +       mutex_lock(&hub->lock);
> +
> +       list_for_each_entry(node, &hub->udev_list, list) {
> +               if (node->udev == udev) {
> +                       list_del(&node->list);

Maybe worth noting here that we don't free 'node' because it will be
freed when the hub platform driver is unbound. Of course, we could shave
some bytes and free the node here instead of later by not using devm.

> +                       break;
> +               }
> +       }
> +
> +       mutex_unlock(&hub->lock);
> +}
> +
> +static ssize_t always_powered_in_suspend_show(struct device *dev, struct device_attribute *attr,
> +                          char *buf)
> +{
> +       struct onboard_hub *hub = dev_get_drvdata(dev);

const?

> +
> +       return sysfs_emit(buf, "%d\n", hub->always_powered_in_suspend);
> +}
> +
> +static ssize_t always_powered_in_suspend_store(struct device *dev, struct device_attribute *attr,
> +                           const char *buf, size_t count)
> +{
> +       struct onboard_hub *hub = dev_get_drvdata(dev);
> +       bool val;
> +       int ret;
> +
> +       ret = kstrtobool(buf, &val);
> +       if (ret < 0)
> +               return ret;
> +
> +       hub->always_powered_in_suspend = val;
> +
> +       return count;
> +}
> +static DEVICE_ATTR_RW(always_powered_in_suspend);
> +
> +static struct attribute *onboard_hub_attrs[] = {
> +       &dev_attr_always_powered_in_suspend.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(onboard_hub);
> +
> +static int onboard_hub_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct onboard_hub *hub;
> +       int err;
> +
> +       hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
> +       if (!hub)
> +               return -ENOMEM;
> +
> +       hub->vdd = devm_regulator_get(dev, "vdd");
> +       if (IS_ERR(hub->vdd))
> +               return PTR_ERR(hub->vdd);
> +
> +       hub->dev = dev;
> +       mutex_init(&hub->lock);
> +       INIT_LIST_HEAD(&hub->udev_list);
> +
> +       dev_set_drvdata(dev, hub);
> +
> +       err = onboard_hub_power_on(hub);
> +       if (err)
> +               return err;
> +
> +       /*
> +        * The USB driver might have been detached from the USB devices by
> +        * onboard_hub_remove(), make sure to re-attach it if needed.
> +        */
> +       err = driver_attach(&onboard_hub_usbdev_driver.drvwrap.driver);
> +       if (err) {
> +               onboard_hub_power_off(hub);
> +               return err;

drop return

> +       }
> +
> +       return 0;

and then

	return err;

> +}
> +
> +static int onboard_hub_remove(struct platform_device *pdev)
> +{
> +       struct onboard_hub *hub = dev_get_drvdata(&pdev->dev);
> +       struct usbdev_node *node;
> +       struct usb_device *udev;
> +
> +       hub->going_away = true;
> +
> +       mutex_lock(&hub->lock);
> +
> +       /* unbind the USB devices to avoid dangling references to this device */
> +       while (!list_empty(&hub->udev_list)) {
> +               node = list_first_entry(&hub->udev_list, struct usbdev_node, list);
> +               udev = node->udev;
> +
> +               /*
> +                * Unbinding the driver will call onboard_hub_remove_usbdev(),
> +                * which acquires hub->lock.  We must release the lock first.
> +                */
> +               get_device(&udev->dev);
> +               mutex_unlock(&hub->lock);
> +               device_release_driver(&udev->dev);
> +               put_device(&udev->dev);
> +               mutex_lock(&hub->lock);
> +       }
> +
> +       mutex_unlock(&hub->lock);
> +
> +       return onboard_hub_power_off(hub);
> +}
> +
> +static const struct of_device_id onboard_hub_match[] = {
> +       { .compatible = "usbbda,411" },
> +       { .compatible = "usbbda,5411" },
> +       { .compatible = "usbbda,414" },
> +       { .compatible = "usbbda,5414" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, onboard_hub_match);
> +
> +static bool of_is_onboard_usb_hub(const struct device_node *np)
> +{
> +       return !!of_match_node(onboard_hub_match, np);
> +}
> +
> +static const struct dev_pm_ops __maybe_unused onboard_hub_pm_ops = {
> +       SET_LATE_SYSTEM_SLEEP_PM_OPS(onboard_hub_suspend, onboard_hub_resume)
> +};
> +
> +static struct platform_driver onboard_hub_driver = {
> +       .probe = onboard_hub_probe,
> +       .remove = onboard_hub_remove,
> +
> +       .driver = {
> +               .name = "onboard-usb-hub",
> +               .of_match_table = onboard_hub_match,
> +               .pm = pm_ptr(&onboard_hub_pm_ops),
> +               .dev_groups = onboard_hub_groups,
> +       },
> +};
> +
> +/************************** USB driver **************************/
> +
> +#define VENDOR_ID_REALTEK      0x0bda
> +
> +/*
> + * Returns the onboard_hub platform device that is associated with the USB
> + * device passed as parameter.
> + */
> +static struct onboard_hub *_find_onboard_hub(struct device *dev)
> +{
> +       struct platform_device *pdev;
> +       struct device_node *np;
> +
> +       pdev = of_find_device_by_node(dev->of_node);
> +       if (!pdev) {
> +               np = of_parse_phandle(dev->of_node, "companion-hub", 0);
> +               if (!np) {
> +                       dev_err(dev, "failed to find device node for companion hub\n");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +
> +               pdev = of_find_device_by_node(np);
> +               of_node_put(np);
> +
> +               if (!pdev || !device_is_bound(&pdev->dev))

Should we put_device(pdev) if !device_is_bound()?

> +                       return ERR_PTR(-EPROBE_DEFER);
> +       }
> +
> +       put_device(&pdev->dev);
> +
> +       return dev_get_drvdata(&pdev->dev);

Should we hold pdev reference until we extract driver data out of it?
i.e.

	ret = dev_get_drvdata(&pdev->dev);
	put_device(&pdev->dev);

	return ret;

> +}
> +
> +static int onboard_hub_usbdev_probe(struct usb_device *udev)
> +{
> +       struct device *dev = &udev->dev;
> +       struct onboard_hub *hub;
> +       int err;
> +
> +       /* ignore supported hubs without device tree node */
> +       if (!dev->of_node)
> +               return -ENODEV;
> +
> +       hub = _find_onboard_hub(dev);
> +       if (IS_ERR(hub))
> +               return PTR_ERR(hub);
> +
> +       dev_set_drvdata(dev, hub);
> +
> +       err = onboard_hub_add_usbdev(hub, udev);
> +       if (err)
> +               return err;
> +
> +       err = sysfs_create_link(&udev->dev.kobj, &hub->dev->kobj, "onboard_hub_dev");
> +       if (err)
> +               dev_warn(&udev->dev, "failed to create symlink to platform device: %d\n", err);

Might be useful to know which platform device this is trying to link to.
Can the devname(hub->dev) be printed as well?

> +
> +       return 0;
> +}
> +
> +static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
> +{
> +       struct onboard_hub *hub = dev_get_drvdata(&udev->dev);
> +
> +       sysfs_remove_link(&udev->dev.kobj, "onboard_hub_dev");
> +
> +       onboard_hub_remove_usbdev(hub, udev);
> +}
> +
> +static const struct usb_device_id onboard_hub_id_table[] = {
> +       { USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
> +       { USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
> +       { USB_DEVICE(VENDOR_ID_REALTEK, 0x0414) }, /* RTS5414 USB 3.2 */
> +       { USB_DEVICE(VENDOR_ID_REALTEK, 0x5414) }, /* RTS5414 USB 2.1 */
> +       {},

Nitpick: Drop comma so nothing can come after without a compile error.

> +};
> +

Nitpick: Drop newline here.

> +MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
> +
> +static struct usb_device_driver onboard_hub_usbdev_driver = {
> +       .name = "onboard-usb-hub",
> +       .probe = onboard_hub_usbdev_probe,
> +       .disconnect = onboard_hub_usbdev_disconnect,
> +       .generic_subclass = 1,
> +       .supports_autosuspend = 1,
> +       .id_table = onboard_hub_id_table,
> +};
> +
> +/*** Helpers for creating/destroying platform devices for onboard hubs ***/
> +
> +struct pdev_list_entry {
> +       struct platform_device *pdev;
> +       struct list_head node;
> +};
> +
> +/*
> + * Creates a platform device for each supported onboard hub that is connected to
> + * the given parent hub. To keep track of the platform devices they are added to
> + * a list that is owned by the parent hub.
> + */

As this is an exported symbol can you please add kernel doc?

> +void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *pdev_list)

Can parent_hub be const?

> +{
> +       int i;
> +       struct device_node *np, *npc;
> +       struct platform_device *pdev = NULL;
> +       struct pdev_list_entry *pdle;
> +
> +       INIT_LIST_HEAD(pdev_list);
> +
> +       for (i = 1; i <= parent_hub->maxchild; i++) {
> +               np = usb_of_get_device_node(parent_hub, i);
> +               if (!np)
> +                       continue;
> +
> +               if (!of_is_onboard_usb_hub(np))
> +                       goto node_put;
> +
> +               npc = of_parse_phandle(np, "companion-hub", 0);
> +               if (npc) {
> +                       pdev = of_find_device_by_node(npc);
> +                       of_node_put(npc);
> +               }
> +
> +               if (pdev) {
> +                       /* the companion hub already has a platform device, nothing to do here */
> +                       put_device(&pdev->dev);
> +                       goto node_put;
> +               }
> +
> +               pdev = of_platform_device_create(np, NULL, &parent_hub->dev);
> +               if (!pdev) {
> +                       dev_err(&parent_hub->dev,
> +                               "failed to create platform device for onboard hub '%pOF'\n", np);
> +                       goto node_put;
> +               }
> +
> +               pdle = devm_kzalloc(&pdev->dev, sizeof(*pdle), GFP_KERNEL);
> +               if (!pdle) {
> +                       of_platform_device_destroy(&pdev->dev, NULL);
> +                       goto node_put;
> +               }
> +
> +               pdle->pdev = pdev;
> +               list_add(&pdle->node, pdev_list);
> +
> +node_put:
> +               of_node_put(np);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(onboard_hub_create_pdevs);
> +
> +/*
> + * Destroys the platform devices in the given list and frees the memory associated
> + * with the list entry.

kerneldoc?

> + */
> +void onboard_hub_destroy_pdevs(struct list_head *pdev_list)
> +{
> +       struct pdev_list_entry *pdle, *tmp;
> +
> +       list_for_each_entry_safe(pdle, tmp, pdev_list, node) {
> +               list_del(&pdle->node);
> +               of_platform_device_destroy(&pdle->pdev->dev, NULL);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(onboard_hub_destroy_pdevs);
> +
