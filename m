Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B5650B0CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444361AbiDVGt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243302AbiDVGt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:49:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC550E05
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A860B82A8A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6513FC385A4;
        Fri, 22 Apr 2022 06:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650609992;
        bh=7gsZlAIVM/CFRk6YIEwoQibG0Pg10GVRy4KYyJ2xy/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=coNNqA4a2dfxTaTFKZ1QwoFti1E9zqs/jua8BE9LCxjn43eolKiQSUVqNB03XN6LO
         DYedPyj3r886XJqr3LRH7VgYqRWtmfJEEvuhK5KLeU2mmmsTRfA94U0o1umegZysdl
         H/Sxs6GpdmRWUo3GFyLdYSfuV32FJTdDce8tR0xY=
Date:   Fri, 22 Apr 2022 08:46:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v3 1/3] firmware: Add boot information to sysfs
Message-ID: <YmJPRPhfA4Cki85S@kroah.com>
References: <20220204072234.304543-1-joel@jms.id.au>
 <20220204072234.304543-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204072234.304543-2-joel@jms.id.au>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 05:52:32PM +1030, Joel Stanley wrote:
> Machines often have firmware that perform some action before Linux is
> loaded. It's useful to know how this firmware is configured, so create a
> sysfs directory and some properties that a system can choose to expose
> to describe how the system was started.
> 
> Currently the intended use describes four files, relating to hardware
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
> v3:
>  - drop uart_boot
>  - Add kerneldoc to header
>  - Rename en -> present
>  - Rename val -> value
>  - Drop unncessary __init from header
>  - Wrap macro in do { } while(0)
> ---
>  .../ABI/testing/sysfs-firmware-bootinfo       | 37 +++++++++
>  drivers/base/firmware.c                       | 80 +++++++++++++++++++
>  include/linux/firmware_bootinfo.h             | 48 +++++++++++
>  3 files changed, 165 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-firmware-bootinfo
>  create mode 100644 include/linux/firmware_bootinfo.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-firmware-bootinfo b/Documentation/ABI/testing/sysfs-firmware-bootinfo
> new file mode 100644
> index 000000000000..cd8eeaa49a00
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-firmware-bootinfo
> @@ -0,0 +1,37 @@
> +What:		/sys/firmware/bootinfo/*
> +Date:		Jan 2022

It isn't January anymore :)

> +Description:
> +		A system can expose information about how it was started in
> +		this directory.

I do not understand what you mean by "how it was started".

> +		This information is agnostic as to the firmware implementation.

How?  This should be very firmware specific.

> +
> +		A system may expose a subset of these properties as applicable.
> +
> +
> +What:		/sys/firmware/bootinfo/secure_boot
> +Date:		Jan 2022
> +Description:
> +		Indicates the system was started with secure boot enabled in
> +		the firmware.

What are the valid values of this file?

If this file is not present what does that mean?

> +
> +
> +What:		/sys/firmware/bootinfo/abr_image
> +Date:		Jan 2022
> +Description:
> +		Indicates the system was started from the alternate image
> +		loaded from an Alternate Boot Region. Often this is a result of
> +		the primary firmware image failing to start the system.

What are the valid values here?


> +
> +
> +What:		/sys/firmware/bootinfo/low_security_key
> +Date:		Jan 2022
> +Description:
> +		Indicates the system's secure boot was verified with a low
> +		security or development key.

What is a "low security" key?  What is a "development key"?  What are
the valid values here?

> +
> +What:		/sys/firmware/bootinfo/otp_protected
> +Date:		Jan 2022
> +Description:
> +		Indicates the system's boot configuration region is write
> +		protected and cannot be modified.

What are the valid values here?


> diff --git a/drivers/base/firmware.c b/drivers/base/firmware.c
> index 8dff940e0db9..8d1a7a36784c 100644
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
> @@ -24,3 +25,82 @@ int __init firmware_init(void)
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
> +	return sysfs_emit(buf, "%d\n", bootinfo.abr_image.value);
> +}
> +static DEVICE_ATTR_RO(abr_image);
> +
> +static ssize_t low_security_key_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", bootinfo.low_security_key.value);
> +}
> +static DEVICE_ATTR_RO(low_security_key);
> +
> +static ssize_t otp_protected_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", bootinfo.otp_protected.value);
> +}
> +static DEVICE_ATTR_RO(otp_protected);
> +
> +static ssize_t secure_boot_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", bootinfo.secure_boot.value);
> +}
> +static DEVICE_ATTR_RO(secure_boot);
> +
> +#define ATTR_ENABLED(a) ((attr == &dev_attr_##a.attr) && bootinfo.a.present)
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
> +	return 0;
> +}
> +
> +static struct attribute *bootinfo_attrs[] = {
> +	&dev_attr_abr_image.attr,
> +	&dev_attr_low_security_key.attr,
> +	&dev_attr_otp_protected.attr,
> +	&dev_attr_secure_boot.attr,
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

If creating the group fails, shouldn't you remove the kobject?

thanks,

greg k-h
