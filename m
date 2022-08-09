Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B509458DD3A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245222AbiHIRcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245343AbiHIRbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:31:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AD724BDA;
        Tue,  9 Aug 2022 10:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 769C3CE1717;
        Tue,  9 Aug 2022 17:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF0AC433D6;
        Tue,  9 Aug 2022 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660066303;
        bh=WSWMb0ids8DeK23Wy4CcOG0tMlGvQCT4qwkRsZMZU3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xud3U0vrPHT4SeMEdhA4rINYqkk2ErBQC/bsab/89/32NCX12KOkiZQk26Py7i43Z
         xrfM4c0w0IkejSN1D+TOueIDooqHPlxk5BMuYAQdYyviDlu8S7ffrDb1iG1oK4dNO0
         /wOpe38KTuieHBgcKqkUoMoEM2sBH5Xx8Bah5sUY=
Date:   Tue, 9 Aug 2022 19:31:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Arend van Spriel <aspriel@gmail.com>, marcel@holtmann.org,
        luiz.dentz@gmail.com, chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Won Chung <wonchung@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] devcoredump: Add per device sysfs entry to
 enable/disable coredump
Message-ID: <YvKZ/Wu3HR3ha/FC@kroah.com>
References: <20220809083112.v4.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
 <20220809083112.v4.2.Ief1110784c6c1c3ac0ee5677c2d28d785af8686d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809083112.v4.2.Ief1110784c6c1c3ac0ee5677c2d28d785af8686d@changeid>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 08:35:24AM -0700, Manish Mandlik wrote:
> The /sys/class/devcoredump/disabled provides only one-way disable
> functionality. Also, disabling devcoredump using it disables the
> devcoredump functionality for everyone who is using it.
> 
> Provide a way to selectively enable/disable devcoredump for the device
> which is bound to a driver that implements the '.coredump()' callback.
> 
> This adds the 'coredump_disabled' driver attribute. When the driver
> implements the '.coredump()' callback, 'coredump_disabled' file is added
> along with the 'coredump' file in the sysfs folder of the device upon
> driver binding. The file is removed when the driver is unbound.
> 
> Drivers can use this attribute to enable/disable devcoredump and the
> userspace can write 0 or 1 to /sys/devices/.../coredump_disabled sysfs
> entry to control enabling/disabling of devcoredump for that device.
> 
> Signed-off-by: Manish Mandlik <mmandlik@google.com>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> Changes in v4:
> - New patch in the series
> 
>  drivers/base/dd.c          | 43 +++++++++++++++++++++++++++++++++++---
>  drivers/base/devcoredump.c |  2 +-
>  include/linux/device.h     |  4 ++++
>  3 files changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 11b0fb6414d3..c76d1145c6d9 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -426,6 +426,31 @@ static ssize_t coredump_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_WO(coredump);
>  
> +static ssize_t coredump_disabled_show(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	return scnprintf(buf, 3, "%d\n", dev->coredump_disabled);

Also, please use sysfs_emit() for any sysfs file output.  It's in all
active kernels for a very long time now.

> +}
> +
> +static ssize_t coredump_disabled_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t count)
> +{
> +	long coredump_disabled;
> +
> +	if (!kstrtol(buf, 10, &coredump_disabled)) {
> +		/* Consider any non-zero value as true */

We have a "Y/N/0/1/y/n" check function for sysfs store callbacks that
you should use instead.



> +		if (coredump_disabled)
> +			dev->coredump_disabled = true;
> +		else
> +			dev->coredump_disabled = false;
> +	}
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(coredump_disabled);
> +
>  static int driver_sysfs_add(struct device *dev)
>  {
>  	int ret;
> @@ -448,9 +473,19 @@ static int driver_sysfs_add(struct device *dev)
>  		return 0;
>  
>  	ret = device_create_file(dev, &dev_attr_coredump);
> -	if (!ret)
> -		return 0;
> +	if (ret)
> +		goto rm_driver;
> +
> +	ret = device_create_file(dev, &dev_attr_coredump_disabled);

Please use an attribute group now that you have multiple files.



> +	if (ret)
> +		goto rm_coredump;
>  
> +	return 0;
> +
> +rm_coredump:
> +	device_remove_file(dev, &dev_attr_coredump);
> +
> +rm_driver:
>  	sysfs_remove_link(&dev->kobj, "driver");
>  
>  rm_dev:
> @@ -466,8 +501,10 @@ static void driver_sysfs_remove(struct device *dev)
>  	struct device_driver *drv = dev->driver;
>  
>  	if (drv) {
> -		if (drv->coredump)
> +		if (drv->coredump) {
> +			device_remove_file(dev, &dev_attr_coredump_disabled);
>  			device_remove_file(dev, &dev_attr_coredump);
> +		}
>  		sysfs_remove_link(&drv->p->kobj, kobject_name(&dev->kobj));
>  		sysfs_remove_link(&dev->kobj, "driver");
>  	}
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index f4d794d6bb85..c5e9af9f3181 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -255,7 +255,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>  	struct devcd_entry *devcd;
>  	struct device *existing;
>  
> -	if (devcd_disabled)
> +	if (devcd_disabled || dev->coredump_disabled)
>  		goto free;
>  
>  	existing = class_find_device(&devcd_class, NULL, dev,
> diff --git a/include/linux/device.h b/include/linux/device.h
> index dc941997795c..120dd656f99d 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -469,6 +469,8 @@ struct device_physical_location {
>   * 		This identifies the device type and carries type-specific
>   * 		information.
>   * @mutex:	Mutex to synchronize calls to its driver.
> + * @coredump_disabled: Can be used by drivers to selectively enable/disable the
> + *		coredump for a particular device via sysfs entry.
>   * @bus:	Type of bus device is on.
>   * @driver:	Which driver has allocated this
>   * @platform_data: Platform data specific to the device.
> @@ -561,6 +563,8 @@ struct device {
>  	const char		*init_name; /* initial name of the device */
>  	const struct device_type *type;
>  
> +	bool			coredump_disabled;
> +

That just hosed the alignment in this structure :(

Please be aware of how memory layouts for common kernel structures are
managed, and try not to add holes when you do not need to.

thanks,

greg k-h
