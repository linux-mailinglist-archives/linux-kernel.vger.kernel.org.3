Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2244A3E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 08:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348134AbiAaHdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 02:33:44 -0500
Received: from mga01.intel.com ([192.55.52.88]:14643 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347972AbiAaHdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 02:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643614413; x=1675150413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rWUUeMylw7j7eadB8PUS30HUTqec98BR59N33yGXgSM=;
  b=hWZIwvDkVgjy/4FHaDWlj1ybIZoikOuTf+vhib0kviuBw67QrwULNZoD
   SFn3c2FTAIgkjbZhxk1ZHdX6p5zNQGUwaV3FLEMRp4CF/buogOxHzUQ7W
   nAuK8vDUYVpOneBE0xImosUv3kIgJInDNT1n/H8W5LudztYg1k8SpSIor
   C2TzuqmIqWeD5G0TyE1yrE6OSYSMDHOxgL+BX3vqSdf4ysNHAiIoaknuO
   lYl1Du080CBzQyIhA5r8Xuh8fjvH36VkJ9O2aUB+3WEQGOijSI8ETMmNp
   XNjOs4AB1h/wjEKReuawntqu1CSEw2I2O6ezD572EPiY4k5djX27zbPjY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="271881420"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="271881420"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 23:33:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="675654496"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 30 Jan 2022 23:33:26 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 Jan 2022 09:33:25 +0200
Date:   Mon, 31 Jan 2022 09:33:25 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Won Chung <wonchung@google.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: device_sysfs: Add sysfs support for _PLD
Message-ID: <YfeQxYNzWltRQ7mq@kuha.fi.intel.com>
References: <20220128180832.2329149-1-wonchung@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220128180832.2329149-1-wonchung@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 06:08:32PM +0000, Won Chung wrote:
> When ACPI table includes _PLD fields for a device, create a new file
> (pld) in sysfs to share _PLD fields.
> 
> Signed-off-by: Won Chung <wonchung@google.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-acpi | 53 ++++++++++++++++++++++++
>  drivers/acpi/device_sysfs.c              | 42 +++++++++++++++++++
>  2 files changed, 95 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
> index 58abacf59b2a..3a9c6a4f4603 100644
> --- a/Documentation/ABI/testing/sysfs-bus-acpi
> +++ b/Documentation/ABI/testing/sysfs-bus-acpi
> @@ -96,3 +96,56 @@ Description:
>  		hardware, if the _HRV control method is present.  It is mostly
>  		useful for non-PCI devices because lspci can list the hardware
>  		version for PCI devices.
> +
> +What:		/sys/bus/acpi/devices/.../pld
> +Date:		Jan, 2022
> +Contact:	Won Chung <wonchung@google.com>
> +Description:
> +		This attribute contains the output of the device object's
> +		_PLD control method, if present. This information provides
> +		details on physical location of a port.
> +
> +		Description on each _PLD field from ACPI specification:
> +
> +		===============	============================================
> +		GROUP_TOKEN	Unique numerical value identifying a group.
> +		GROUP_POSITION	Identifies this device connection point’s
> +				position in the group.
> +		USER_VISIBLE	Set if the device connection point can be
> +				seen by the user without disassembly.
> +		DOCK		Set if the device connection point resides
> +				in a docking station or port replicator.
> +		BAY		Set if describing a device in a bay or if
> +				device connection point is a bay.
> +		LID		Set if this device connection point resides
> +				on the lid of laptop system.
> +		PANEL		Describes which panel surface of the system’s
> +				housing the device connection point resides on:
> +				0 - Top
> +				1 - Bottom
> +				2 - Left
> +				3 - Right
> +				4 - Front
> +				5 - Back
> +				6 - Unknown (Vertical Position and Horizontal
> +				Position will be ignored)
> +		HORIZONTAL_	0 - Left
> +		POSITION	1 - Center
> +				2 - Right
> +		VERTICAL_	0 - Upper
> +		POSITION	1 - Center
> +				2 - Lower
> +		SHAPE		Describes the shape of the device connection
> +				point.
> +				0 - Round
> +				1 - Oval
> +				2 - Square
> +				3 - Vertical Rectangle
> +				4 - Horizontal Rectangle
> +				5 - Vertical Trapezoid
> +				6 - Horizontal Trapezoid
> +				7 - Unknown - Shape rendered as a Rectangle
> +				with dotted lines
> +				8 - Chamfered
> +				15:9 - Reserved
> +		===============	===============================================
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index d5d6403ba07b..8d4df5fb1c45 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -509,6 +509,40 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(status);
>  
> +static ssize_t pld_show(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct acpi_device *acpi_dev = to_acpi_device(dev);
> +	acpi_status status;
> +	struct acpi_pld_info *pld;
> +
> +	status = acpi_get_physical_device_location(acpi_dev->handle, &pld);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	return sprintf(buf, "GROUP_TOKEN=%u\n"
> +		"GROUP_POSITION=%u\n"
> +		"USER_VISIBLE=%u\n"
> +		"DOCK=%u\n"
> +		"BAY=%u\n"
> +		"LID=%u\n"
> +		"PANEL=%u\n"
> +		"HORIZONTAL_POSITION=%u\n"
> +		"VERTICAL_POSITION=%u\n"
> +		"SHAPE=%u\n",
> +		pld->group_token,
> +		pld->group_position,
> +		pld->user_visible,
> +		pld->dock,
> +		pld->bay,
> +		pld->lid,
> +		pld->panel,
> +		pld->horizontal_position,
> +		pld->vertical_position,
> +		pld->shape);
> +}
> +static DEVICE_ATTR_RO(pld);

Why not have a pld group (directory) and a separate attribute file for
each field?


thanks,

-- 
heikki
