Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D224C7B56
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiB1VG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiB1VG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:06:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBD8642A;
        Mon, 28 Feb 2022 13:06:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0FD8B81651;
        Mon, 28 Feb 2022 21:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A58C340F1;
        Mon, 28 Feb 2022 21:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646082374;
        bh=h+Vr0xa4sw719cfJKXXdkWPHmnkmCz7iKEofpmYZuls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ryUW/hps6zMY2vq+o6aVRQ7JS3au1jKNlMCz3lmBRnlpzyglulPdiNzhNLbp/b7uk
         63eOc+hu8s+YtgOZUEWtlzJOTx/Wh8tFGtWhzQgATAUOKjkvvleDmkx4KJvCWKvyKz
         b+FW1S2jAaEdxRoD6xwqhO0I62pHvacfENCPpHaM=
Date:   Mon, 28 Feb 2022 22:06:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Won Chung <wonchung@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb:typec: Add sysfs support for Type C connector's
 physical location
Message-ID: <Yh05QgVw5htyGj+X@kroah.com>
References: <20220228190649.362070-1-wonchung@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220228190649.362070-1-wonchung@google.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 07:06:49PM +0000, Won Chung wrote:
> When ACPI table includes _PLD field for a Type C connector, share _PLD
> values in its sysfs. _PLD stands for physical location of device.
> 
> Currently without connector's location information, when there are
> multiple Type C ports, it is hard to distinguish which connector
> corresponds to which physical port at which location. For example, when
> there are two Type C connectors, it is hard to find out which connector
> corresponds to the Type C port on the left panel versus the Type C port
> on the right panel. With location information provided, we can determine
> which specific device at which location is doing what.
> 
> _PLD output includes much more fields, but only generic fields are added
> and exposed to sysfs, so that non-ACPI devices can also support it in
> the future. The minimal generic fields needed for locating a port are
> the following.
> - panel
> - horizontal_position
> - vertical_position
> - dock
> - lid
> 
> Signed-off-by: Won Chung <wonchung@google.com>
> ---
>  Documentation/ABI/testing/sysfs-class-typec | 43 +++++++++++++++++
>  drivers/usb/typec/class.c                   | 52 +++++++++++++++++++++
>  drivers/usb/typec/class.h                   |  3 ++
>  3 files changed, 98 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index 75088ecad202..2879bc6e6ad2 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -141,6 +141,49 @@ Description:
>  		- "reverse": CC2 orientation
>  		- "unknown": Orientation cannot be determined.
>  
> +What:		/sys/class/typec/<port>/location/panel
> +Date:		February 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		Describes which panel surface of the system’s housing the
> +		Type C port resides on:
> +		0 - Top
> +		1 - Bottom
> +		2 - Left
> +		3 - Right
> +		4 - Front
> +		5 - Back
> +		6 - Unknown (Vertical Position and Horizontal Position will be
> +		ignored)

This is text files, why not say "top", "bottom", and so on?  Why use a
number that means nothing?


> +
> +What:		/sys/class/typec/<port>/location/vertical_position
> +Date:		February 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		0 - Upper
> +		1 - Center
> +		2 - Lower

Same here.


> +
> +What:		/sys/class/typec/<port>/location/horizontal_position
> +Date:		Feb, 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		0 - Left
> +		1 - Center
> +		2 - Right

And here.

> +
> +What:		/sys/class/typec/<port>/location/dock
> +Date:		Feb, 2022

Note that date ends in a few hours :(

> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		Set if the port resides in a docking station or a port replicator.
> +
> +What:		/sys/class/typec/<port>/location/lid
> +Date:		Feb, 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		Set if the port resides on the lid of laptop system.

"set"?  What does that mean?



> +
>  USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
>  
>  What:		/sys/class/typec/<port>-partner/accessory_mode
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 45a6f0c807cb..43b23c221f95 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1579,8 +1579,40 @@ static const struct attribute_group typec_group = {
>  	.attrs = typec_attrs,
>  };
>  
> +#define DEV_ATTR_LOCATION_PROP(prop) \
> +	static ssize_t prop##_show(struct device *dev, struct device_attribute *attr, \
> +		char *buf) \
> +	{ \
> +		struct typec_port *port = to_typec_port(dev); \
> +		if (port->pld) \
> +			return sprintf(buf, "%u\n", port->pld->prop); \
> +		return 0; \
> +	}; \
> +static DEVICE_ATTR_RO(prop)
> +
> +DEV_ATTR_LOCATION_PROP(panel);
> +DEV_ATTR_LOCATION_PROP(vertical_position);
> +DEV_ATTR_LOCATION_PROP(horizontal_position);
> +DEV_ATTR_LOCATION_PROP(dock);
> +DEV_ATTR_LOCATION_PROP(lid);
> +
> +static struct attribute *typec_location_attrs[] = {
> +	&dev_attr_panel.attr,
> +	&dev_attr_vertical_position.attr,
> +	&dev_attr_horizontal_position.attr,
> +	&dev_attr_dock.attr,
> +	&dev_attr_lid.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group typec_location_group = {
> +	.name = "location",
> +	.attrs = typec_location_attrs,
> +};
> +
>  static const struct attribute_group *typec_groups[] = {
>  	&typec_group,
> +	&typec_location_group,
>  	NULL
>  };
>  
> @@ -1614,6 +1646,24 @@ const struct device_type typec_port_dev_type = {
>  	.release = typec_release,
>  };
>  
> +void *get_pld(struct device *dev)

That is a horrible global function name :(

And why a void pointer?  We have real types in the kernel, please use
them.

> +{
> +#ifdef CONFIG_ACPI

No #ifdefs in .c files please.

> +	struct acpi_pld_info *pld;
> +	acpi_status status;
> +
> +	if (!has_acpi_companion(dev))
> +		return NULL;
> +
> +	status = acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld);
> +	if (ACPI_FAILURE(status))
> +		return NULL;
> +	return pld;

See, you return a real type, don't throw that information away.  This
isn't Windows :)

thanks,

gre gk-h
