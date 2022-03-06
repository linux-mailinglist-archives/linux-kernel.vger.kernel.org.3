Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAD54CEBD0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 15:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiCFOFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 09:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiCFOFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 09:05:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B6640908
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 06:04:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAFF960E9B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 14:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBCBC340EC;
        Sun,  6 Mar 2022 14:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646575486;
        bh=ieZAAuLE2MqhkV1Cof3A6CiHjYoDqDFGjs5NWimG56U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eg3KAjiiC+RhqbG5+9l4LvJigHfOg60eVzgrpsxAk7fWK7nREbGvy9pszmIMyqopM
         9zEIDsNAnl/+B0i9eGB+XDf3Mo7by4FDQ+OzHUJOmFIzfOp6pPFdnjAoccOB+TOc6P
         vq4c1ODjSeWR+dh5feG6yt1LPvLM6WONYiUyjEgc=
Date:   Sun, 6 Mar 2022 15:04:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Won Chung <wonchung@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] driver core: Add sysfs support for physical location
 of a device
Message-ID: <YiS/ei+GFF0bwBSr@kroah.com>
References: <20220305004258.2484798-1-wonchung@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220305004258.2484798-1-wonchung@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 12:42:58AM +0000, Won Chung wrote:
> When ACPI table includes _PLD fields for a device, create a new
> directory (physical_location) in sysfs to share _PLD fields.
> 
> Currently without PLD information, when there are multiple of same
> devices, it is hard to distinguish which device corresponds to which
> physical device at which location. For example, when there are two Type
> C connectors, it is hard to find out which connector corresponds to the
> Type C port on the left panel versus the Type C port on the right panel.
> With PLD information provided, we can determine which specific device at
> which location is doing what.
> 
> _PLD output includes much more fields, but only generic fields are added
> and exposed to sysfs, so that non-ACPI devices can also support it in
> the future. The minimal generic fields needed for locating a device are
> the following.
> - panel
> - vertical_position
> - horizontal_position
> - dock
> - lid
> 
> Signed-off-by: Won Chung <wonchung@google.com>
> ---
> 
> Changes from v2
> - Use sysfs_emit to create files.
> - Correct mix of spaces and tabs.
> 
> Changes from v1
> - Correct directory names in Documentation.
> - Clarify namings in core.c
> 
>  .../testing/sysfs-devices-physical_location   |  42 ++++++
>  drivers/base/core.c                           | 139 ++++++++++++++++++
>  include/linux/device.h                        |  73 +++++++++
>  3 files changed, 254 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-physical_location
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-physical_location b/Documentation/ABI/testing/sysfs-devices-physical_location
> new file mode 100644
> index 000000000000..202324b87083
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-physical_location
> @@ -0,0 +1,42 @@
> +What:		/sys/devices/.../physical_location
> +Date:		March 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		This directory contains information on physical location of
> +		the device connection point with respect to the system's
> +		housing.
> +
> +What:		/sys/devices/.../physical_location/panel
> +Date:		March 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		Describes which panel surface of the system’s housing the
> +		device connection point resides on.
> +
> +What:		/sys/devices/.../physical_location/vertical_position
> +Date:		March 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		Describes vertical position of the device connection point on
> +		the panel surface.
> +
> +What:		/sys/devices/.../physical_location/horizontal_position
> +Date:		March 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		Describes horizontal position of the device connection point on
> +		the panel surface.
> +
> +What:		/sys/devices/.../physical_location/dock
> +Date:		March 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		"Yes" if the device connection point resides in a docking
> +		station or a port replicator. "No" otherwise.
> +
> +What:		/sys/devices/.../physical_location/lid
> +Date:		March 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		"Yes" if the device connection point resides on the lid of
> +		laptop system. "No" otherwise.
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 7bb957b11861..9cfa71ad21f3 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2466,6 +2466,136 @@ static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(removable);
>  
> +static int dev_add_physical_location(struct device *dev)
> +{
> +#if defined(CONFIG_ACPI)
> +	struct acpi_pld_info *pld;
> +	acpi_status status;
> +
> +	if (!has_acpi_companion(dev))
> +		return 0;
> +
> +	status = acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld);
> +	if (ACPI_FAILURE(status) || !pld)
> +		return 0;
> +
> +	dev->location = (struct device_location) {
> +		.panel = pld->panel,
> +		.vertical_position = pld->vertical_position,
> +		.horizontal_position = pld->horizontal_position,
> +		.dock = pld->dock,
> +		.lid = pld->lid,
> +	};

Is this a memcpy()?  Ick, that's odd.

> +
> +	return 1;

Kernel functions do not return "1" as success.  Or as an error.
Positive numbers are ONLY for when to return the number of bytes
consumed/written or the like.

> +#else

I have asked multiple times to not put #ifdef in .c files.  I can't take
this patch for that fact alone (also big hint, if acpi is not enabled,
loads of these functions and the structure itself should not be present
at all...)





> +	return 0;
> +#endif
> +}
> +
> +static ssize_t panel_show(struct device *dev, struct device_attribute *attr,
> +	char *buf)
> +{
> +	const char *panel;
> +
> +	switch (dev->location.panel) {
> +	case DEVICE_PANEL_TOP:
> +		panel = "top";
> +		break;
> +	case DEVICE_PANEL_BOTTOM:
> +		panel = "bottom";
> +		break;
> +	case DEVICE_PANEL_LEFT:
> +		panel = "left";
> +		break;
> +	case DEVICE_PANEL_RIGHT:
> +		panel = "right";
> +		break;
> +	case DEVICE_PANEL_FRONT:
> +		panel = "front";
> +		break;
> +	case DEVICE_PANEL_BACK:
> +		panel = "back";
> +		break;
> +	default:
> +		panel = "unknown";
> +	}
> +	return sysfs_emit(buf, "%s\n", panel);
> +}
> +static DEVICE_ATTR_RO(panel);
> +
> +static ssize_t vertical_position_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	const char *vertical_position;
> +
> +	switch (dev->location.vertical_position) {
> +	case DEVICE_VERT_POS_UPPER:
> +		vertical_position = "upper";
> +		break;
> +	case DEVICE_VERT_POS_CENTER:
> +		vertical_position = "center";
> +		break;
> +	case DEVICE_VERT_POS_LOWER:
> +		vertical_position = "lower";
> +		break;
> +	default:
> +		vertical_position = "unknown";
> +	}
> +	return sysfs_emit(buf, "%s\n", vertical_position);
> +}
> +static DEVICE_ATTR_RO(vertical_position);
> +
> +static ssize_t horizontal_position_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	const char *horizontal_position;
> +
> +	switch (dev->location.horizontal_position) {
> +	case DEVICE_HORI_POS_LEFT:
> +		horizontal_position = "left";
> +		break;
> +	case DEVICE_HORI_POS_CENTER:
> +		horizontal_position = "center";
> +		break;
> +	case DEVICE_HORI_POS_RIGHT:
> +		horizontal_position = "right";
> +		break;
> +	default:
> +		horizontal_position = "unknown";
> +	}
> +	return sysfs_emit(buf, "%s\n", horizontal_position);
> +}
> +static DEVICE_ATTR_RO(horizontal_position);
> +
> +static ssize_t dock_show(struct device *dev, struct device_attribute *attr,
> +	char *buf)

Did you run your patch through checkpatch.pl?

Please do so.

> +{
> +	return sysfs_emit(buf, "%s\n", dev->location.dock ? "yes" : "no");
> +}
> +static DEVICE_ATTR_RO(dock);
> +
> +static ssize_t lid_show(struct device *dev, struct device_attribute *attr,
> +	char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", dev->location.lid ? "yes" : "no");
> +}
> +static DEVICE_ATTR_RO(lid);
> +
> +static struct attribute *dev_attr_physical_location[] = {
> +	&dev_attr_panel.attr,
> +	&dev_attr_vertical_position.attr,
> +	&dev_attr_horizontal_position.attr,
> +	&dev_attr_dock.attr,
> +	&dev_attr_lid.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group dev_attr_physical_location_group = {
> +	.name = "physical_location",

I'm all for being verbose, but why not just "location"?  What other type
of location is there for a device?

> +	.attrs = dev_attr_physical_location,
> +};
> +
>  int device_add_groups(struct device *dev, const struct attribute_group **groups)
>  {
>  	return sysfs_create_groups(&dev->kobj, groups);
> @@ -2649,8 +2779,17 @@ static int device_add_attrs(struct device *dev)
>  			goto err_remove_dev_waiting_for_supplier;
>  	}
>  
> +	if (dev_add_physical_location(dev)) {
> +		error = device_add_group(dev,
> +			&dev_attr_physical_location_group);
> +		if (error)
> +			goto err_remove_dev_physical_location;
> +	}
> +
>  	return 0;
>  
> + err_remove_dev_physical_location:
> +	device_remove_group(dev, &dev_attr_physical_location_group);
>   err_remove_dev_waiting_for_supplier:
>  	device_remove_file(dev, &dev_attr_waiting_for_supplier);
>   err_remove_dev_online:
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 93459724dcde..424be9cb735e 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -386,6 +386,75 @@ struct dev_msi_info {
>  #endif
>  };
>  
> +/**
> + * enum device_location_panel - Describes which panel surface of the system's
> + * housing the device connection point resides on.
> + * @DEVICE_PANEL_TOP: Device connection point is on the top panel.
> + * @DEVICE_PANEL_BOTTOM: Device connection point is on the bottom panel.
> + * @DEVICE_PANEL_LEFT: Device connection point is on the left panel.
> + * @DEVICE_PANEL_RIGHT: Device connection point is on the right panel.
> + * @DEVICE_PANEL_FRONT: Device connection point is on the front panel.
> + * @DEVICE_PANEL_BACK: Device connection point is on the back panel.
> + * @DEVICE_PANEL_UNKNOWN: The panel with device connection point is unknown.
> + */
> +enum device_location_panel {
> +	DEVICE_PANEL_TOP,
> +	DEVICE_PANEL_BOTTOM,
> +	DEVICE_PANEL_LEFT,
> +	DEVICE_PANEL_RIGHT,
> +	DEVICE_PANEL_FRONT,
> +	DEVICE_PANEL_BACK,
> +	DEVICE_PANEL_UNKNOWN,
> +};
> +
> +/**
> + * enum device_location_vertical_position - Describes vertical position of the
> + * device connection point on the panel surface.
> + * @DEVICE_VERT_POS_UPPER: Device connection point is at upper part of panel.
> + * @DEVICE_VERT_POS_CENTER: Device connection point is at center part of panel.
> + * @DEVICE_VERT_POS_LOWER: Device connection point is at lower part of panel.
> + */
> +enum device_location_vertical_position {
> +	DEVICE_VERT_POS_UPPER,
> +	DEVICE_VERT_POS_CENTER,
> +	DEVICE_VERT_POS_LOWER,
> +};
> +
> +/**
> + * enum device_location_horizontal_position - Describes horizontal position of
> + * the device connection point on the panel surface.
> + * @DEVICE_HORI_POS_LEFT: Device connection point is at left part of panel.
> + * @DEVICE_HORI_POS_CENTER: Device connection point is at center part of panel.
> + * @DEVICE_HORI_POS_RIGHT: Device connection point is at right part of panel.
> + */
> +enum device_location_horizontal_position {
> +	DEVICE_HORI_POS_LEFT,
> +	DEVICE_HORI_POS_CENTER,
> +	DEVICE_HORI_POS_RIGHT,
> +};

Why do these enum values need to be in device.h?  Can they just live in
drivers/base/ somewhere?


> +
> +/**
> + * struct device_location - Device data related to physical location of the
> + * device connection point.
> + * @panel: Panel surface of the system's housing that the device connection
> + *         point resides on.
> + * @vertical_position: Vertical position of the device connection point within
> + *                     the panel.
> + * @horizontal_position: Horizontal position of the device connection point
> + *                       within the panel.
> + * @dock: Set if the device connection point resides in a docking station or
> + *        port replicator.
> + * @lid: Set if this device connection point resides on the lid of laptop
> + *       system.
> + */
> +struct device_location {
> +	enum device_location_panel panel;
> +	enum device_location_vertical_position vertical_position;
> +	enum device_location_horizontal_position horizontal_position;
> +	bool dock;
> +	bool lid;

How badly did you just inflate all device structures in the kernel?  Did
you use 'pahole' to see if you added padding or not?

> +};
> +
>  /**
>   * struct device - The basic device structure
>   * @parent:	The device's "parent" device, the device to which it is attached.
> @@ -456,6 +525,8 @@ struct dev_msi_info {
>   * @removable:  Whether the device can be removed from the system. This
>   *              should be set by the subsystem / bus driver that discovered
>   *              the device.
> + * @location:	Describes physical location of the device connection point in
> + *		the system housing.
>   *
>   * @offline_disabled: If set, the device is permanently online.
>   * @offline:	Set after successful invocation of bus type's .offline().
> @@ -569,6 +640,8 @@ struct device {
>  
>  	enum device_removable	removable;
>  
> +	struct device_location	location;

See, you just call it "location" here, not "physical_location", so why
does userspace get a bigger name than the kernel does?  :)

thanks,

greg k-h
