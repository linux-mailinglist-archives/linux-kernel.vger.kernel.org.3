Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC8C4AE219
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385945AbiBHTRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385929AbiBHTRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:17:44 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFCBC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:17:42 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y5so158081pfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sCuyH1tysKvS6WO4WltxSdpJ4i3TM/aiR4HA3AbgEZ8=;
        b=lAR07/LDFdCAex9m0qL1lsTnYoF8/c81JAkS0rl5mcOwQ8FmAvGFnsxjdfHhHjEXAg
         lqocg9sSbe+8eU5oM9e3TZMMbb+rvJ+ThEdszSDw4mgprxFN23/wfpMrgRAQRqxiU+72
         nffrZ3gGbc5m8oOeku1/Z19WoO791wNAKqvf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sCuyH1tysKvS6WO4WltxSdpJ4i3TM/aiR4HA3AbgEZ8=;
        b=25m/s69/LEuscD4YrW1iiqBn3HfFVwkgQlml0sQjvm+Zy/bIC9BkBJclUUB6NZ9W9a
         HE62W1YL5+Cr9CQmq9ocAciWyvBFkDiyrBnONAOkrpPZJZn4j4OWsDN0NWo1HR5Qgi6M
         C8Zq8Amhmf1XXQqH8UH6Nqx6frzc2HGukTPZ00yVe79kJ2W6iJTaKFkfhfBxlovsIipg
         NB7AhTGa/Du0ggZBwDJ4m5vj2RQvv/DUyuzuF8kBNgwSvc4MquwtukuB4tSGg+7Qy0j4
         5TsSIW9ywi2R594+2r77KK3YyP8Kiq3zJk5kmORE477NpIxmQLjQ+vwME9pCRdBXgErd
         DmcQ==
X-Gm-Message-State: AOAM530pROC9Jubn6kOUVy2Sgbg2sy1wYjv6WnIcaM0nx2xxiSti+7sY
        zn9ve8Sn4PGfee+jHdYu/e1SXA==
X-Google-Smtp-Source: ABdhPJy9fDM3XKgu8SZBEMGAIkvfHz2vlLlxj86cC8iz2oNnhUDOvRERsojNUhHNojgixhycSW6/Ig==
X-Received: by 2002:a63:2b84:: with SMTP id r126mr4585243pgr.71.1644347861481;
        Tue, 08 Feb 2022 11:17:41 -0800 (PST)
Received: from localhost ([2620:15c:202:201:23dc:d215:b887:777d])
        by smtp.gmail.com with UTF8SMTPSA id b12sm16021854pfm.154.2022.02.08.11.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 11:17:41 -0800 (PST)
Date:   Tue, 8 Feb 2022 11:17:39 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH v20 3/5] usb: misc: Add onboard_usb_hub driver
Message-ID: <YgLB0/aJJvGm3oYR@google.com>
References: <20220119204345.3769662-1-mka@chromium.org>
 <20220119124327.v20.3.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <YgJMX0QK9Koyu/uv@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgJMX0QK9Koyu/uv@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

thanks for the review!

On Tue, Feb 08, 2022 at 11:56:31AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 19, 2022 at 12:43:43PM -0800, Matthias Kaehlcke wrote:
> > The main issue this driver addresses is that a USB hub needs to be
> > powered before it can be discovered. For discrete onboard hubs (an
> > example for such a hub is the Realtek RTS5411) this is often solved
> > by supplying the hub with an 'always-on' regulator, which is kind
> > of a hack. Some onboard hubs may require further initialization
> > steps, like changing the state of a GPIO or enabling a clock, which
> > requires even more hacks. This driver creates a platform device
> > representing the hub which performs the necessary initialization.
> > Currently it only supports switching on a single regulator, support
> > for multiple regulators or other actions can be added as needed.
> > Different initialization sequences can be supported based on the
> > compatible string.
> > 
> > Besides performing the initialization the driver can be configured
> > to power the hub off during system suspend. This can help to extend
> > battery life on battery powered devices which have no requirements
> > to keep the hub powered during suspend. The driver can also be
> > configured to leave the hub powered when a wakeup capable USB device
> > is connected when suspending, and power it off otherwise.
> > 
> > Technically the driver consists of two drivers, the platform driver
> > described above and a very thin USB driver that subclasses the
> > generic driver. The purpose of this driver is to provide the platform
> > driver with the USB devices corresponding to the hub(s) (a hub
> > controller may provide multiple 'logical' hubs, e.g. one to support
> > USB 2.0 and another for USB 3.x).
> > 
> > Note: the current series only supports hubs connected directly to
> > a root hub, support for other configurations could be added if
> > needed.
> > 
> > Co-developed-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > 
> > Changes in v20:
> > - s/nontrivial/non-trivial/ in Kconfig doc
> > - added include of 'export.h'
> > - initialize variable 'power_off' in onboard_hub_suspend() at
> >   declaration time
> > - renamed set_udev_link_name() to get_udev_link_name()
> > - use kzalloc to allocate struct usbdev_node instead of devm_kzalloc()
> > - release the lock in onboard_hub_add_usbdev() before calling
> >   get_udev_link_name()
> > - free struct usbdev_node in onboard_hub_remove_usbdev(), now that
> >   it doesn't used managed memory
> > - make struct onboard_hub const in always_powered_in_suspend_show()
> > - call put_device() if pdev is not bound in _find_onboard_hub()
> > - get driver data before calling put_device() in _find_onboard_hub()
> > - log platform device name when sysfs link creation fails in
> >   onboard_hub_usbdev_probe()
> > - added kernel doc for onboard_hub_create_pdevs() and
> >   onboard_hub_destroy_pdevs()
> > - added 'Reviewed-by' tag from Doug
> > 
> > Changes in v19:
> > - added VID:PID pairs and compatible strings for RTS5414 hub
> > - updated comments with RTS5411 USB versions to reflect those
> >   reported/supported by the hub
> > 
> > Changes in v18:
> > - introduced hidden Kconfig option to align module vs. builtin
> >   choice with CONFIG_USB (thanks Doug!)
> > - refactored onboard_hub_create_pdevs()
> > 
> > Changes in v17:
> > - updated date and kernel version in ABI documentation for
> >   'always_powered_in_suspend' attribute
> > - removed obsolete .yaml entry from MAINTAINERS file
> > - added entry for ABI documentation to MAINTAINERS file
> > - renamed struct 'udev_node' to 'usbdev_node'
> > - changed return logic in onboard_hub_suspend/resume() to
> >   get rid of 'rc' variable
> > - added helper set_udev_link_name() to set link names for
> >   onboard hub USB devices
> > - use of_parse_phandle() instead of of_property_read_u32() +
> >   of_find_node_by_phandle() combo
> > - defer probing in _find_onboard_hub() if the platform device
> >   isn't bound yet
> > - initialize list head passed as parameter to
> >   onboard_hub_create_pdevs() instead of relying on the caller
> >   to do so
> > - don't require the 'companion-hub' property to be specified.
> >   This is needed to support hubs without companion hub
> > - use devm_kzalloc() to allocate platform device list entries
> >   and stop freeing them explicitly
> > - remove unnecessary INIT_LIST_HEAD() of platform device list
> >   entries
> > - use '%pOF' to print DT node name
> > - delete platform device list entries from the list of devices
> >   in onboard_hub_destroy_pdevs(). It shouldn't be strictly
> >   necessary, but better be on the safe side.
> > 
> > Changes in v16:
> > - none
> > 
> > Changes in v15:
> > - none
> > 
> > Changes in v14:
> > - none
> > 
> > Changes in v13:
> > - none
> > 
> > Changes in v12:
> > - use IS_ENABLED(CONFIG_USB_ONBOARD_HUB_MODULE) in onboard_hub.h to
> >   also check for the driver built as module
> > - include onboard_hub.h again from the driver to make sure there are
> >   prototype declarations for the public functions
> > - remove indentation from label in onboard_hub_create_pdevs()
> > 
> > Changes in v11:
> > - added onboard_hub_create/destroy_pdevs() helpers, to support multiple onboard
> >   hubs connected to the same parent hub
> > - don't include ‘onboard_hub.h’ from the onboard hub driver
> > - updated commit message
> > - added ‘Acked-by' from Alan
> > 
> > Changes in v10:
> > - always use of_is_onboard_usb_hub() stub unless ONBOARD_USB_HUB=y/m
> > 
> > Changes in v9:
> > - none
> > 
> > Changes in v8:
> > - none
> > 
> > Changes in v7:
> > - don't declare stub for of_is_onboard_usb_hub() when
> >   CONFIG_COMPILE_TEST is defined
> > 
> > Changes in v6:
> > - use 'companion-hub' to locate the platform device, instead of
> >   scanning through the nodes of the parent
> > - added ABI documentation for 'always_powered_in_suspend'
> > - sysfs_emit() instead of sprintf() in always_powered_in_suspend_show()
> > - register sysfs attribute through driver.dev_groups
> > - evaluate return value of driver_attach() in _probe()
> > - use dev_warn() instead of WARN_ON() in _probe()
> > - include 'onboard_hub.h'
> > 
> > Changes in v5:
> > - the platform device is now instantiated from the same DT node
> >   as the 'primary' USB hub device
> >   - use the USB compatible strings for the platform device
> >   - refactored _find_onboard_hub() to search the parents child
> >     nodes for a platform device with a matching compatible string
> >   - added exported function of_is_onboard_usb_hub() to allow other
> >     drivers (like xhci_plat) to check if one of their child DT nodes
> >     is a supported hub
> > - use late suspend to make sure info about wakeup enabled descendants
> >   is updated
> > - call driver_attach() for the USB driver in onboard_hub_probe() to
> >   make sure the driver is re-attached after the device_release_driver()
> >   calls in onboard_hub_remove()
> > - renamed sysfs attribute 'power_off_in_suspend' to
> >   'always_powered_in_suspend'
> > - added sysfs symlinks between platform device and USB devices
> > - marked 'onboard_hub_pm_ops' as __maybe_unused
> > - removed 'realtek' compatible string which is not needed at this
> >   point
> > - fix log for regulator_disable() failure
> > 
> > Changes in v4:
> > - updated Kconfig documentation
> > - changed the loop in onboard_hub_remove() to release the hub lock
> >   before unbinding the USB device and make self deadlock prevention
> >   less clunky
> > - fixed return value in onboard_hub_usbdev_probe()
> > - added entry to MAINTAINERS file
> > 
> > Changes in v3:
> > - updated the commit message
> > - updated description in Kconfig
> > - remove include of 'core/usb.h'
> > - use 'is_powered_on' flag instead of 'has_wakeup_capable_descendants'
> > - added 'going_away' flag to struct onboard_hub
> >   - don't allow adding new USB devices when the platform device is going away
> >   - don't bother with deleting the list item in onboard_hub_remove_usbdev()
> >     when the platform device is going away
> > - don't assume in onboard_hub_suspend() that all USB hub devices are
> >   connected to the same controller
> > - removed unnecessary devm_kfree() from onboard_hub_remove_usbdev()
> > - fixed error handling in onboard_hub_remove_usbdev()
> > - use kstrtobool() instead of strtobool() in power_off_in_suspend_store()
> > - unbind USB devices in onboard_hub_remove() to avoid dangling references
> >   to the platform device
> > - moved put_device() for platform device to _find_onboard_hub()
> > - changed return value of onboard_hub_remove_usbdev() to void
> > - evaluate return value of onboard_hub_add_usbdev()
> > - register 'power_off_in_suspend' as managed device attribute
> > - use USB_DEVICE macro instead manual initialization
> > - add unwinding to onboard_hub_init()
> > - updated MODULE_DESCRIPTION
> > - use module_init() instead of device_initcall()
> > 
> > Changes in v2:
> > - check wakeup enabled state of the USB controller instead of
> >   using 'wakeup-source' property
> > - use sysfs attribute instead of DT property to determine if
> >   the hub should be powered off at all during system suspend
> > - added missing brace in onboard_hub_suspend()
> > - updated commit message
> > - use pm_ptr for pm_ops as suggested by Alan
> > 
> > Changes in v1:
> > - renamed the driver to 'onboard_usb_hub'
> > - single file for platform and USB driver
> > - USB hub devices register with the platform device
> >   - the DT includes a phandle of the platform device
> > - the platform device now controls when power is turned off
> > - the USB driver became a very thin subclass of the generic USB
> >   driver
> > - enabled autosuspend support
> > 
> >  .../sysfs-bus-platform-onboard-usb-hub        |   8 +
> >  MAINTAINERS                                   |   7 +
> >  drivers/usb/misc/Kconfig                      |  23 +
> >  drivers/usb/misc/Makefile                     |   1 +
> >  drivers/usb/misc/onboard_usb_hub.c            | 511 ++++++++++++++++++
> >  include/linux/usb/onboard_hub.h               |  18 +
> >  6 files changed, 568 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
> >  create mode 100644 drivers/usb/misc/onboard_usb_hub.c
> >  create mode 100644 include/linux/usb/onboard_hub.h
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub b/Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
> > new file mode 100644
> > index 000000000000..39fa2ed29fed
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
> > @@ -0,0 +1,8 @@
> > +What:		/sys/bus/platform/devices/<dev>/always_powered_in_suspend
> > +Date:		November 2021
> > +KernelVersion:	5.17
> > +Contact:	Matthias Kaehlcke <matthias@kaehlcke.net>
> > +		linux-usb@vger.kernel.org
> > +Description:
> > +		(RW) Controls whether the USB hub remains always powered
> > +		during system suspend or not.
> > \ No newline at end of file
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index dd36acc87ce6..68bc6efaad3f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14183,6 +14183,13 @@ S:	Maintained
> >  T:	git git://linuxtv.org/media_tree.git
> >  F:	drivers/media/i2c/ov9734.c
> >  
> > +ONBOARD USB HUB DRIVER
> > +M:	Matthias Kaehlcke <mka@chromium.org>
> > +L:	linux-usb@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
> > +F:	drivers/usb/misc/onboard_usb_hub.c
> > +
> >  ONENAND FLASH DRIVER
> >  M:	Kyungmin Park <kyungmin.park@samsung.com>
> >  L:	linux-mtd@lists.infradead.org
> > diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> > index 8f1144359012..99bc262a41f6 100644
> > --- a/drivers/usb/misc/Kconfig
> > +++ b/drivers/usb/misc/Kconfig
> > @@ -284,3 +284,26 @@ config BRCM_USB_PINMAP
> >  	  This option enables support for remapping some USB external
> >  	  signals, which are typically on dedicated pins on the chip,
> >  	  to any gpio.
> > +
> > +config USB_ONBOARD_HUB
> > +	bool "Onboard USB hub support"
> > +	depends on OF || COMPILE_TEST
> > +	help
> > +	  Say Y here if you want to support discrete onboard USB hubs that
> > +	  don't require an additional control bus for initialization, but
> > +	  need some non-trivial form of initialization, such as enabling a
> > +	  power regulator. An example for such a hub is the Realtek
> > +	  RTS5411.
> > +
> > +	  This driver can be used as a module but its state (module vs
> > +	  builtin) must match the state of the USB subsystem. Enabling
> > +	  this config will enable the driver and it will automatically
> > +	  match the state of the USB subsystem. If this driver is a
> > +	  module it will be called onboard_usb_hub.
> > +
> > +if USB_ONBOARD_HUB
> > +config USB_ONBOARD_HUB_ACTUAL
> > +	tristate
> > +	default m if USB=m
> > +	default y if USB=y
> > +endif
> > diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
> > index 5f4e598573ab..9549b88c2cc1 100644
> > --- a/drivers/usb/misc/Makefile
> > +++ b/drivers/usb/misc/Makefile
> > @@ -32,3 +32,4 @@ obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
> >  obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
> >  obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
> >  obj-$(CONFIG_BRCM_USB_PINMAP)		+= brcmstb-usb-pinmap.o
> > +obj-$(CONFIG_USB_ONBOARD_HUB_ACTUAL)	+= onboard_usb_hub.o
> > diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> > new file mode 100644
> > index 000000000000..e280409aecf5
> > --- /dev/null
> > +++ b/drivers/usb/misc/onboard_usb_hub.c
> > @@ -0,0 +1,511 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Driver for onboard USB hubs
> > + *
> > + * Copyright (c) 2022, Google LLC
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/export.h>
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
> > +#include <linux/usb/of.h>
> > +#include <linux/usb/onboard_hub.h>
> > +
> > +static struct usb_device_driver onboard_hub_usbdev_driver;
> > +
> > +/************************** Platform driver **************************/
> > +
> > +struct usbdev_node {
> > +	struct usb_device *udev;
> > +	struct list_head list;
> > +};
> > +
> > +struct onboard_hub {
> > +	struct regulator *vdd;
> > +	struct device *dev;
> > +	bool always_powered_in_suspend;
> > +	bool is_powered_on;
> > +	bool going_away;
> > +	struct list_head udev_list;
> > +	struct mutex lock;
> > +};
> > +
> > +static int onboard_hub_power_on(struct onboard_hub *hub)
> > +{
> > +	int err;
> > +
> > +	err = regulator_enable(hub->vdd);
> > +	if (err) {
> > +		dev_err(hub->dev, "failed to enable regulator: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	hub->is_powered_on = true;
> > +
> > +	return 0;
> > +}
> > +
> > +static int onboard_hub_power_off(struct onboard_hub *hub)
> > +{
> > +	int err;
> > +
> > +	err = regulator_disable(hub->vdd);
> > +	if (err) {
> > +		dev_err(hub->dev, "failed to disable regulator: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	hub->is_powered_on = false;
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused onboard_hub_suspend(struct device *dev)
> > +{
> > +	struct onboard_hub *hub = dev_get_drvdata(dev);
> > +	struct usbdev_node *node;
> > +	bool power_off = true;
> > +
> > +	if (hub->always_powered_in_suspend)
> > +		return 0;
> > +
> > +	mutex_lock(&hub->lock);
> > +
> > +	list_for_each_entry(node, &hub->udev_list, list) {
> > +		if (!device_may_wakeup(node->udev->bus->controller))
> > +			continue;
> > +
> > +		if (usb_wakeup_enabled_descendants(node->udev)) {
> > +			power_off = false;
> > +			break;
> > +		}
> > +	}
> > +
> > +	mutex_unlock(&hub->lock);
> > +
> > +	if (!power_off)
> > +		return 0;
> > +
> > +	return onboard_hub_power_off(hub);
> > +}
> > +
> > +static int __maybe_unused onboard_hub_resume(struct device *dev)
> > +{
> > +	struct onboard_hub *hub = dev_get_drvdata(dev);
> > +
> > +	if (hub->is_powered_on)
> > +		return 0;
> > +
> > +	return onboard_hub_power_on(hub);
> > +}
> > +
> > +static inline void get_udev_link_name(const struct usb_device *udev, char *buf, size_t size)
> > +{
> > +	snprintf(buf, size, "usb_dev.%s", dev_name(&udev->dev));
> > +}
> > +
> > +static int onboard_hub_add_usbdev(struct onboard_hub *hub, struct usb_device *udev)
> > +{
> > +	struct usbdev_node *node;
> > +	char link_name[64];
> > +	int err;
> > +
> > +	mutex_lock(&hub->lock);
> > +
> > +	if (hub->going_away) {
> > +		err = -EINVAL;
> > +		goto error;
> > +	}
> > +
> > +	node = kzalloc(sizeof(*node), GFP_KERNEL);
> > +	if (!node) {
> > +		err = -ENOMEM;
> > +		goto error;
> > +	}
> > +
> > +	node->udev = udev;
> > +
> > +	list_add(&node->list, &hub->udev_list);
> > +
> > +	mutex_unlock(&hub->lock);
> > +
> > +	get_udev_link_name(udev, link_name, sizeof(link_name));
> > +	WARN_ON(sysfs_create_link(&hub->dev->kobj, &udev->dev.kobj, link_name));
> > +
> > +	return 0;
> > +
> > +error:
> > +	mutex_unlock(&hub->lock);
> > +
> > +	return err;
> > +}
> > +
> > +static void onboard_hub_remove_usbdev(struct onboard_hub *hub, const struct usb_device *udev)
> > +{
> > +	struct usbdev_node *node;
> > +	char link_name[64];
> > +
> > +	get_udev_link_name(udev, link_name, sizeof(link_name));
> > +	sysfs_remove_link(&hub->dev->kobj, link_name);
> > +
> > +	mutex_lock(&hub->lock);
> > +
> > +	list_for_each_entry(node, &hub->udev_list, list) {
> > +		if (node->udev == udev) {
> > +			list_del(&node->list);
> > +			kfree(node);
> > +			break;
> > +		}
> > +	}
> > +
> > +	mutex_unlock(&hub->lock);
> > +}
> > +
> > +static ssize_t always_powered_in_suspend_show(struct device *dev, struct device_attribute *attr,
> > +			   char *buf)
> > +{
> > +	const struct onboard_hub *hub = dev_get_drvdata(dev);
> > +
> > +	return sysfs_emit(buf, "%d\n", hub->always_powered_in_suspend);
> > +}
> > +
> > +static ssize_t always_powered_in_suspend_store(struct device *dev, struct device_attribute *attr,
> > +			    const char *buf, size_t count)
> > +{
> > +	struct onboard_hub *hub = dev_get_drvdata(dev);
> > +	bool val;
> > +	int ret;
> > +
> > +	ret = kstrtobool(buf, &val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	hub->always_powered_in_suspend = val;
> > +
> > +	return count;
> > +}
> > +static DEVICE_ATTR_RW(always_powered_in_suspend);
> > +
> > +static struct attribute *onboard_hub_attrs[] = {
> > +	&dev_attr_always_powered_in_suspend.attr,
> > +	NULL,
> > +};
> > +ATTRIBUTE_GROUPS(onboard_hub);
> > +
> > +static int onboard_hub_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct onboard_hub *hub;
> > +	int err;
> > +
> > +	hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
> > +	if (!hub)
> > +		return -ENOMEM;
> > +
> > +	hub->vdd = devm_regulator_get(dev, "vdd");
> > +	if (IS_ERR(hub->vdd))
> > +		return PTR_ERR(hub->vdd);
> > +
> > +	hub->dev = dev;
> > +	mutex_init(&hub->lock);
> > +	INIT_LIST_HEAD(&hub->udev_list);
> > +
> > +	dev_set_drvdata(dev, hub);
> > +
> > +	err = onboard_hub_power_on(hub);
> > +	if (err)
> > +		return err;
> > +
> > +	/*
> > +	 * The USB driver might have been detached from the USB devices by
> > +	 * onboard_hub_remove(), make sure to re-attach it if needed.
> > +	 */
> > +	err = driver_attach(&onboard_hub_usbdev_driver.drvwrap.driver);
> > +	if (err) {
> > +		onboard_hub_power_off(hub);
> > +		return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int onboard_hub_remove(struct platform_device *pdev)
> > +{
> > +	struct onboard_hub *hub = dev_get_drvdata(&pdev->dev);
> > +	struct usbdev_node *node;
> > +	struct usb_device *udev;
> > +
> > +	hub->going_away = true;
> > +
> > +	mutex_lock(&hub->lock);
> > +
> > +	/* unbind the USB devices to avoid dangling references to this device */
> > +	while (!list_empty(&hub->udev_list)) {
> > +		node = list_first_entry(&hub->udev_list, struct usbdev_node, list);
> > +		udev = node->udev;
> > +
> > +		/*
> > +		 * Unbinding the driver will call onboard_hub_remove_usbdev(),
> > +		 * which acquires hub->lock.  We must release the lock first.
> > +		 */
> > +		get_device(&udev->dev);
> > +		mutex_unlock(&hub->lock);
> > +		device_release_driver(&udev->dev);
> > +		put_device(&udev->dev);
> > +		mutex_lock(&hub->lock);
> > +	}
> > +
> > +	mutex_unlock(&hub->lock);
> > +
> > +	return onboard_hub_power_off(hub);
> > +}
> > +
> > +static const struct of_device_id onboard_hub_match[] = {
> > +	{ .compatible = "usbbda,411" },
> > +	{ .compatible = "usbbda,5411" },
> > +	{ .compatible = "usbbda,414" },
> > +	{ .compatible = "usbbda,5414" },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, onboard_hub_match);
> > +
> > +static bool of_is_onboard_usb_hub(const struct device_node *np)
> > +{
> > +	return !!of_match_node(onboard_hub_match, np);
> > +}
> > +
> > +static const struct dev_pm_ops __maybe_unused onboard_hub_pm_ops = {
> > +	SET_LATE_SYSTEM_SLEEP_PM_OPS(onboard_hub_suspend, onboard_hub_resume)
> > +};
> > +
> > +static struct platform_driver onboard_hub_driver = {
> > +	.probe = onboard_hub_probe,
> > +	.remove = onboard_hub_remove,
> > +
> > +	.driver = {
> > +		.name = "onboard-usb-hub",
> > +		.of_match_table = onboard_hub_match,
> > +		.pm = pm_ptr(&onboard_hub_pm_ops),
> > +		.dev_groups = onboard_hub_groups,
> > +	},
> > +};
> > +
> > +/************************** USB driver **************************/
> > +
> > +#define VENDOR_ID_REALTEK	0x0bda
> > +
> > +/*
> > + * Returns the onboard_hub platform device that is associated with the USB
> > + * device passed as parameter.
> > + */
> > +static struct onboard_hub *_find_onboard_hub(struct device *dev)
> > +{
> > +	struct platform_device *pdev;
> > +	struct device_node *np;
> > +	struct onboard_hub *hub;
> > +
> > +	pdev = of_find_device_by_node(dev->of_node);
> > +	if (!pdev) {
> > +		np = of_parse_phandle(dev->of_node, "companion-hub", 0);
> > +		if (!np) {
> > +			dev_err(dev, "failed to find device node for companion hub\n");
> > +			return ERR_PTR(-EINVAL);
> > +		}
> > +
> > +		pdev = of_find_device_by_node(np);
> > +		of_node_put(np);
> > +
> > +		if (!pdev || !device_is_bound(&pdev->dev)) {
> 
> I don't understand why you need to call device_is_bound() here.  What
> are you wanting to find here?

Whether the platform driver actually probed.

> You found the hub device associated to this usb device, based on the
> of_find_device_by_node() call, so why check it again?  What could have
> happened that this isn't the correct device?

It is the correct platform device, however it might not have finished
probing (this function is called from the USB driver). It's an unlikely
case, but it might happen, especially if the bootloader left the hub
regulator enabled (otherwise it would only be enabled by the platform
driver).

If device_is_bound() is a no-go (as it seems) the function could check
the drvdata instead.

> > +			if (pdev)
> > +				put_device(&pdev->dev);
> > +
> > +			return ERR_PTR(-EPROBE_DEFER);
> 
> What are you deferring to have happen later?

The probe() of the platform device.

> > +		}
> > +	}
> > +
> > +	hub = dev_get_drvdata(&pdev->dev);
> > +	put_device(&pdev->dev);
> > +
> > +	return hub;
> > +}
> > +
> > +static int onboard_hub_usbdev_probe(struct usb_device *udev)
> > +{
> > +	struct device *dev = &udev->dev;
> > +	struct onboard_hub *hub;
> > +	int err;
> > +
> > +	/* ignore supported hubs without device tree node */
> > +	if (!dev->of_node)
> > +		return -ENODEV;
> > +
> > +	hub = _find_onboard_hub(dev);
> > +	if (IS_ERR(hub))
> > +		return PTR_ERR(hub);
> > +
> > +	dev_set_drvdata(dev, hub);
> > +
> > +	err = onboard_hub_add_usbdev(hub, udev);
> > +	if (err)
> > +		return err;
> > +
> > +	err = sysfs_create_link(&udev->dev.kobj, &hub->dev->kobj, "onboard_hub_dev");
> 
> What is this link for?  Messing with sysfs links is a pain and drivers
> really shouldn't be doing them if at all possible.

Alan asked me to add them. It's not strictly needed. I'm fine with removing
them as long as there is no strong opposition to that :)

> > +	if (err)
> > +		dev_warn(&udev->dev, "failed to create symlink to platform device '%s'): %d\n",
> > +			 dev_name(hub->dev), err);
> > +
> > +	return 0;
> 
> So you ignore the error?  That's fine, just odd.

Yes, the links aren't critical for the functioning of the driver.
