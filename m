Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C2A4A6CCA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242966AbiBBITT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:19:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:54667 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231628AbiBBITR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643789957; x=1675325957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8FUTnB+neOfsiAnGwSfgWEkpPzljgOQLUdu2mTTAd70=;
  b=DIEN2TWSRhKH4fLn9vBpa8L8kKMkx0ferOO6+OJJnFAMj6dZPgjWG7HE
   9bLsAa3vhF5pwaj6cUedRmxnJ4+8A3/6FAt7zw3Dg/aPvUqfJbhDrQcli
   WWYNQyhdSrzdDqyjdlqW//EYXTbKQ0xwybzDFvlXQgsInjX1FX/kNFckY
   xebsjPiT55lnRbExuYSZ41rKJi93j/Ops3ewByHRJZxa9AphR4UfUPLRg
   9nUTTF1TCkDhwRtwhAlPq2istDHgBio1LZb8umR8O1OKyQBOVSlka3GEW
   CGZDgzEPjd4+H1iHshYRYHIbvKEy0hA3NURLF1uAhjpk/+M05s9As58qd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="227838065"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="227838065"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 00:19:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="676365354"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Feb 2022 00:19:14 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 02 Feb 2022 10:19:13 +0200
Date:   Wed, 2 Feb 2022 10:19:13 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Won Chung <wonchung@google.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ACPI: device_sysfs: Add sysfs support for _PLD
Message-ID: <Yfo+gYLLOGN69Re1@kuha.fi.intel.com>
References: <20220201015518.3118404-1-wonchung@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220201015518.3118404-1-wonchung@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Won,

On Tue, Feb 01, 2022 at 01:55:18AM +0000, Won Chung wrote:
> When ACPI table includes _PLD fields for a device, create a new
> directory (pld) in sysfs to share _PLD fields.

I think you need to explain what needs this information in user space.

> Signed-off-by: Won Chung <wonchung@google.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-acpi | 107 +++++++++++++++++++++++
>  drivers/acpi/device_sysfs.c              |  55 ++++++++++++
>  include/acpi/acpi_bus.h                  |   1 +
>  3 files changed, 163 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
> index 58abacf59b2a..b8b71c8f3cfd 100644
> --- a/Documentation/ABI/testing/sysfs-bus-acpi
> +++ b/Documentation/ABI/testing/sysfs-bus-acpi
> @@ -96,3 +96,110 @@ Description:
>  		hardware, if the _HRV control method is present.  It is mostly
>  		useful for non-PCI devices because lspci can list the hardware
>  		version for PCI devices.
> +
> +What:		/sys/bus/acpi/devices/.../pld/
> +Date:		Feb, 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		This directory contains the output of the device object's _PLD
> +		control method, if present. This information provides details
> +		on physical location of a device.
> +
> +What:		/sys/bus/acpi/devices/.../pld/revision
> +Date:		Feb, 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		The current revision is 0x2.
> +
> +What:           /sys/bus/acpi/devices/.../pld/group_token
> +Date:           Feb, 2022
> +Contact:        Won Chung <wonchung@google.com>
> +Description:
> +		Unique numerical value identifying a group.
> +
> +What:           /sys/bus/acpi/devices/.../pld/group_position
> +Date:           Feb, 2022
> +Contact:        Won Chung <wonchung@google.com>
> +Description:
> +		Identifies this device connection point’s position in the group.
> +
> +What:           /sys/bus/acpi/devices/.../pld/user_visible
> +Date:           Feb, 2022
> +Contact:        Won Chung <wonchung@google.com>
> +Description:
> +		Set if the device connection point can be seen by the user
> +		without disassembly.
> +
> +What:           /sys/bus/acpi/devices/.../pld/dock
> +Date:           Feb, 2022
> +Contact:        Won Chung <wonchung@google.com>
> +Description:
> +		Set if the device connection point resides in a docking station
> +		or port replicator.
> +
> +What:           /sys/bus/acpi/devices/.../pld/bay
> +Date:           Feb, 2022
> +Contact:        Won Chung <wonchung@google.com>
> +Description:
> +		Set if describing a device in a bay or if device connection
> +		point is a bay.
> +
> +What:           /sys/bus/acpi/devices/.../pld/lid
> +Date:           Feb, 2022
> +Contact:        Won Chung <wonchung@google.com>
> +Description:
> +		Set if this device connection point resides on the lid of
> +		laptop system.
> +
> +What:           /sys/bus/acpi/devices/.../pld/panel
> +Date:           Feb, 2022
> +Contact:        Won Chung <wonchung@google.com>
> +Description:
> +		Describes which panel surface of the system’s housing the
> +		device connection point resides on:
> +		0 - Top
> +		1 - Bottom
> +		2 - Left
> +		3 - Right
> +		4 - Front
> +		5 - Back
> +		6 - Unknown (Vertical Position and Horizontal Position will be
> +		ignored)
> +
> +What:           /sys/bus/acpi/devices/.../pld/vertical_position
> +Date:           Feb, 2022
> +Contact:        Won Chung <wonchung@google.com>
> +Description:
> +		0 - Upper
> +		1 - Center
> +		2 - Lower
> +
> +What:           /sys/bus/acpi/devices/.../pld/horizontal_position
> +Date:           Feb, 2022
> +Contact:        Won Chung <wonchung@google.com>
> +Description:
> +		ACPI specification does not define horizontal position field.
> +		Can be used as either
> +		0 - Left
> +		1 - Center
> +		2 - Right
> +		or
> +		0 - Leftmost
> +		and higher numbers going toward the right.
> +
> +What:           /sys/bus/acpi/devices/.../pld/shape
> +Date:           Feb, 2022
> +Contact:        Won Chung <wonchung@google.com>
> +Description:
> +		Describes the shape of the device connection point.
> +		0 - Round
> +		1 - Oval
> +		2 - Square
> +		3 - Vertical Rectangle
> +		4 - Horizontal Rectangle
> +		5 - Vertical Trapezoid
> +		6 - Horizontal Trapezoid
> +		7 - Unknown - Shape rendered as a Rectangle with dotted lines
> +		8 - Chamfered
> +		15:9 - Reserved
> +
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index d5d6403ba07b..610be93635a0 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -509,6 +509,49 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(status);
>  
> +#define DEV_ATTR_PLD_PROP(prop) \
> +	static ssize_t prop##_show(struct device *dev, struct device_attribute *attr, \
> +		char *buf) \
> +{ \
> +	struct acpi_device *acpi_dev = to_acpi_device(dev); \
> +	if (acpi_dev->pld == NULL) \
> +		return -EIO; \
> +	return sprintf(buf, "%u\n", acpi_dev->pld->prop); \
> +}; \

Ah, you are storing the _PLD below. Before there were concerns about
the memory that the cached _PLD information would consume. Another way
of doing this would be to just always evaluate the _PLD here.

Rafael needs to comment on this. My personal opinion is that let's
just store the thing.

> +static DEVICE_ATTR_RO(prop)
> +
> +DEV_ATTR_PLD_PROP(revision);
> +DEV_ATTR_PLD_PROP(group_token);
> +DEV_ATTR_PLD_PROP(group_position);
> +DEV_ATTR_PLD_PROP(user_visible);
> +DEV_ATTR_PLD_PROP(dock);
> +DEV_ATTR_PLD_PROP(bay);
> +DEV_ATTR_PLD_PROP(lid);
> +DEV_ATTR_PLD_PROP(panel);
> +DEV_ATTR_PLD_PROP(vertical_position);
> +DEV_ATTR_PLD_PROP(horizontal_position);
> +DEV_ATTR_PLD_PROP(shape);
> +
> +static struct attribute *dev_attr_pld[] = {
> +	&dev_attr_revision.attr,
> +	&dev_attr_group_token.attr,
> +	&dev_attr_group_position.attr,
> +	&dev_attr_user_visible.attr,
> +	&dev_attr_dock.attr,
> +	&dev_attr_bay.attr,
> +	&dev_attr_lid.attr,
> +	&dev_attr_panel.attr,
> +	&dev_attr_vertical_position.attr,
> +	&dev_attr_horizontal_position.attr,
> +	&dev_attr_shape.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group dev_attr_pld_group = {
> +	.name = "pld",
> +	.attrs = dev_attr_pld,
> +};
> +
>  /**
>   * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
>   * @dev: ACPI device object.
> @@ -595,6 +638,16 @@ int acpi_device_setup_files(struct acpi_device *dev)
>  						    &dev_attr_real_power_state);
>  	}
>  
> +	if (acpi_has_method(dev->handle, "_PLD")) {
> +		status = acpi_get_physical_device_location(dev->handle,
> +			&dev->pld);
> +		if (ACPI_FAILURE(status))
> +			goto end;
> +		result = device_add_group(&dev->dev, &dev_attr_pld_group);
> +		if (result)
> +			goto end;
> +	}

You probable want to store the pld in acpi_store_pld_crc(). Perhaps
also rename that function to just acpi_store_pld() at the same time.

Here you just want to create the sysfs group.

>  	acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
>  
>  end:
> @@ -645,4 +698,6 @@ void acpi_device_remove_files(struct acpi_device *dev)
>  		device_remove_file(&dev->dev, &dev_attr_status);
>  	if (dev->handle)
>  		device_remove_file(&dev->dev, &dev_attr_path);
> +	if (acpi_has_method(dev->handle, "_PLD"))
> +		device_remove_group(&dev->dev, &dev_attr_pld_group);
>  }
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index ca88c4706f2b..929e726a666b 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -381,6 +381,7 @@ struct acpi_device {
>  	struct acpi_hotplug_context *hp;
>  	struct acpi_driver *driver;
>  	const struct acpi_gpio_mapping *driver_gpios;
> +	struct acpi_pld_info *pld;
>  	void *driver_data;
>  	struct device dev;
>  	unsigned int physical_node_count;
> -- 

thanks,

-- 
heikki
