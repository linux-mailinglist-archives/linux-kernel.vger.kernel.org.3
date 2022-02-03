Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D6F4A8403
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350607AbiBCMon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:44:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53022 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239402AbiBCMom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:44:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4221B83418
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 12:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF7BC340E4;
        Thu,  3 Feb 2022 12:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643892280;
        bh=ycOvpaH55x2fpR3ZTsVK1M0+GDvSlgHze9LNMIUPl58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hsnENGkzQnni1T8e6x5zQ9aEf9+x2IVNkh+AVzofNhBm/EUnsHPUsH9lZZWsZXSoY
         +oQNIzmQEKtLGlZ8ISntSJwxgIoihguReJiU4e60PrzrwBgIMUEgRRdbF9YzZJh4EG
         JLaVHlhV3vbHOJKJH5Pw2tcXX+oZgBFEbhFAEWK4=
Date:   Thu, 3 Feb 2022 13:44:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v2 1/3] firmware: Add boot information to sysfs
Message-ID: <YfvONCxvTTuWqI+J@kroah.com>
References: <20220203115344.267159-1-joel@jms.id.au>
 <20220203115344.267159-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203115344.267159-2-joel@jms.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 10:23:42PM +1030, Joel Stanley wrote:
> Machines often have firmware that perform some action before Linux is
> loaded. It's useful to know how this firmware is configured, so create a
> sysfs directory and some properties that a system can choose to expose
> to describe how the system was started.
> 
> Currently the intended use describes five files, relating to hardware
> root of trust configuration.
> 
> These properties are populated by platform code at startup. Using fixed
> values is suitable as the state that the system booted in will not
> change after firmware has handed over.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2:
>  - Rewrite so properties are present in common code and are exposed based
>    on the is_visible callback.
>  - Use sysfs_emit
> ---
>  .../ABI/testing/sysfs-firmware-bootinfo       | 43 +++++++++
>  drivers/base/firmware.c                       | 90 +++++++++++++++++++
>  include/linux/firmware_bootinfo.h             | 22 +++++
>  3 files changed, 155 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-firmware-bootinfo
>  create mode 100644 include/linux/firmware_bootinfo.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-firmware-bootinfo b/Documentation/ABI/testing/sysfs-firmware-bootinfo
> new file mode 100644
> index 000000000000..cd6c42316345
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-firmware-bootinfo
> @@ -0,0 +1,43 @@
> +What:		/sys/firmware/bootinfo/*
> +Date:		Jan 2022
> +Description:
> +		A system can expose information about how it was started in
> +		this directory.
> +
> +		This information is agnostic as to the firmware implementation.
> +
> +		A system may expose a subset of these properties as applicable.
> +
> +
> +What:		/sys/firmware/bootinfo/secure_boot
> +Date:		Jan 2022
> +Description:
> +		Indicates the system was started with secure boot enabled in
> +		the firmware.
> +
> +
> +What:		/sys/firmware/bootinfo/abr_image
> +Date:		Jan 2022
> +Description:
> +		Indicates the system was started from the alternate image
> +		loaded from an Alternate Boot Region. Often this is a result of
> +		the primary firmware image failing to start the system.
> +
> +
> +What:		/sys/firmware/bootinfo/low_security_key
> +Date:		Jan 2022
> +Description:
> +		Indicates the system's secure boot was verified with a low
> +		security or development key.
> +
> +What:		/sys/firmware/bootinfo/otp_protected
> +Date:		Jan 2022
> +Description:
> +		Indicates the system's boot configuration region is write
> +		protected and cannot be modified.
> +
> +What:		/sys/firmware/bootinfo/uart_boot
> +Date:		Jan 2022
> +Description:
> +		Indicates the system firmware was loaded from a UART instead of
> +		an internal boot device.
> diff --git a/drivers/base/firmware.c b/drivers/base/firmware.c
> index 8dff940e0db9..24b931232eb2 100644
> --- a/drivers/base/firmware.c
> +++ b/drivers/base/firmware.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/device.h>
> +#include <linux/firmware_bootinfo.h>
>  
>  #include "base.h"
>  
> @@ -24,3 +25,92 @@ int __init firmware_init(void)
>  		return -ENOMEM;
>  	return 0;
>  }
> +
> +/*
> + * Exposes attributes documented in Documentation/ABI/testing/sysfs-firmware-bootinfo
> + */
> +static struct bootinfo bootinfo;
> +
> +static ssize_t abr_image_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", bootinfo.abr_image.val);
> +}
> +static DEVICE_ATTR_RO(abr_image);
> +
> +static ssize_t low_security_key_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", bootinfo.low_security_key.val);
> +}
> +static DEVICE_ATTR_RO(low_security_key);
> +
> +static ssize_t otp_protected_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", bootinfo.otp_protected.val);
> +}
> +static DEVICE_ATTR_RO(otp_protected);
> +
> +static ssize_t secure_boot_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", bootinfo.secure_boot.val);
> +}
> +static DEVICE_ATTR_RO(secure_boot);
> +
> +static ssize_t uart_boot_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", bootinfo.uart_boot.val);
> +}
> +static DEVICE_ATTR_RO(uart_boot);
> +
> +#define ATTR_ENABLED(a) ((attr == &dev_attr_##a.attr) && bootinfo.a.en)
> +
> +static umode_t bootinfo_attr_mode(struct kobject *kobj, struct attribute *attr, int index)
> +{
> +	if (ATTR_ENABLED(abr_image))
> +		return 0444;
> +
> +	if (ATTR_ENABLED(otp_protected))
> +		return 0444;
> +
> +	if (ATTR_ENABLED(low_security_key))
> +		return 0444;
> +
> +	if (ATTR_ENABLED(otp_protected))
> +		return 0444;
> +
> +	if (ATTR_ENABLED(low_security_key))
> +		return 0444;
> +
> +	if (ATTR_ENABLED(secure_boot))
> +		return 0444;
> +
> +	if (ATTR_ENABLED(uart_boot))
> +		return 0444;
> +
> +	return 0;
> +}
> +
> +static struct attribute *bootinfo_attrs[] = {
> +	&dev_attr_abr_image.attr,
> +	&dev_attr_low_security_key.attr,
> +	&dev_attr_otp_protected.attr,
> +	&dev_attr_secure_boot.attr,
> +	&dev_attr_uart_boot.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group bootinfo_attr_group = {
> +	.attrs = bootinfo_attrs,
> +	.is_visible = bootinfo_attr_mode,
> +};
> +
> +int __init firmware_bootinfo_init(struct bootinfo *bootinfo_init)
> +{
> +	struct kobject *kobj = kobject_create_and_add("bootinfo", firmware_kobj);
> +	if (!kobj)
> +		return -ENOMEM;
> +
> +	memcpy(&bootinfo, bootinfo_init, sizeof(bootinfo));
> +
> +	return sysfs_create_group(kobj, &bootinfo_attr_group);
> +}
> +EXPORT_SYMBOL_GPL(firmware_bootinfo_init);
> diff --git a/include/linux/firmware_bootinfo.h b/include/linux/firmware_bootinfo.h
> new file mode 100644
> index 000000000000..3fe630b061b9
> --- /dev/null
> +++ b/include/linux/firmware_bootinfo.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

I have to ask, do you really mean "or later"?


> +/* Copyright 2022 IBM Corp. */
> +
> +#include <linux/sysfs.h>
> +#include <linux/init.h>
> +
> +#define BOOTINFO_SET(b, n, v) b.n.en = true; b.n.val = v

Please use a while {} loop around these two statements.

Didn't checkpatch warn you about that?

> +struct bootinfo_entry {
> +	bool en;

What does "en" mean?  "enabled"?  If so, please spell it out.

> +	bool val;

How can a "value" have a boolean?  Is this "valid"?  Again, please spell
it out, we have no lack of letters to use here to keep people from being
confused.

Can you please use kernel-doc comments to describe this structure?


> +};
> +
> +struct bootinfo {
> +	struct bootinfo_entry abr_image;
> +	struct bootinfo_entry low_security_key;
> +	struct bootinfo_entry otp_protected;
> +	struct bootinfo_entry secure_boot;
> +	struct bootinfo_entry uart_boot;
> +};

Same here, please use kernel-doc

> +
> +int __init firmware_bootinfo_init(struct bootinfo *bootinfo_init);

__init is not needed on a function definition like this.

thanks,

greg k-h
