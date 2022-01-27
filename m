Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF3B49DE3B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbiA0JkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiA0JkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:40:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C189C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 01:40:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6FCD61BD9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDB1C340E4;
        Thu, 27 Jan 2022 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643276421;
        bh=oZk/EdgdfkOy1kExMELMAb6CiEXmluwroF41hJpXOSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wcKpVFaUMn7Gzyx3hflUItcaeY4XQHPCIsm3n0Ruo6hKjl4k0N2KPUhxS0OMgZB8t
         JRJNnjOed0t824jmrz4lITaMl9m8oOPiIjXWCi1+dixxhyjHX2NH5IVawpPHT+mwEP
         +ZSUf/rlxirJIcAou0G3TZn3fZ+eCwjeeSEJkMJU=
Date:   Thu, 27 Jan 2022 10:40:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sami =?iso-8859-1?Q?Ky=F6stil=E4?= <skyostil@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, dtor@chromium.org,
        evanbenn@chromium.org, arnd@arndb.de
Subject: Re: [PATCH 1/2] drivers/misc: add a driver for HPS
Message-ID: <YfJogh+yk1FHWSMC@kroah.com>
References: <20220127083545.1020423-1-skyostil@chromium.org>
 <20220127083545.1020423-2-skyostil@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220127083545.1020423-2-skyostil@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 07:35:44PM +1100, Sami Kyöstilä wrote:
> This patch introduces a driver for the ChromeOS snooping protection
> sensor (aka. HPS). The driver supports a sensor connected to the I2C bus
> and identified as "GOOG0020" in the ACPI tables.
> 
> When loaded, the driver exports the sensor to userspace through a
> character device. This initial version of the device only supports power
> management, i.e., communicating with the sensor must be done through I2C
> from userspace.
> 
> Power management is implemented by enabling the respective power GPIO
> while at least one userspace process holds an open fd on the character
> device. By default, the device is powered down if there are no active
> clients.
> 
> Note that the driver makes no effort to preserve the state of the sensor
> between power down and power up events. Userspace is responsible for
> reinitializing any needed state once power has been restored.
> 
> The device firmware, I2C protocol and other documentation is available
> at https://chromium.googlesource.com/chromiumos/platform/hps-firmware.

How about a userspace tool that interacts with this new ioctl interface
as well so that we can understand how the driver is supposed to work?


> 
> Signed-off-by: Sami Kyöstilä <skyostil@chromium.org>
> ---
> 
>  MAINTAINERS            |   6 ++
>  drivers/misc/Kconfig   |  10 ++
>  drivers/misc/Makefile  |   1 +
>  drivers/misc/hps-i2c.c | 223 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 240 insertions(+)
>  create mode 100644 drivers/misc/hps-i2c.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..9dea4b8c2ab5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8798,6 +8798,12 @@ S:	Maintained
>  W:	http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
>  F:	fs/hpfs/
>  
> +HPS (ChromeOS snooping protection sensor) DRIVER
> +M:	Sami Kyöstilä <skyostil@chromium.org>
> +R:	Evan Benn <evanbenn@chromium.org>
> +S:	Maintained
> +F:	drivers/misc/hps-i2c.c
> +
>  HSI SUBSYSTEM
>  M:	Sebastian Reichel <sre@kernel.org>
>  S:	Maintained
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 0f5a49fc7c9e..b48b7803f537 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -244,6 +244,16 @@ config HP_ILO
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called hpilo.
>  
> +config HPS_I2C
> +	tristate "ChromeOS HPS device support"
> +	depends on HID && I2C && PM
> +	help
> +	  Say Y here if you want to enable support for the ChromeOS
> +	  anti-snooping sensor (HPS), attached via I2C. The driver supports a
> +	  sensor connected to the I2C bus and exposes it as a character device.
> +	  To save power, the sensor is automatically powered down when no
> +	  clients are accessing it.
> +
>  config QCOM_COINCELL
>  	tristate "Qualcomm coincell charger support"
>  	depends on MFD_SPMI_PMIC || COMPILE_TEST
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index a086197af544..162a7d530dab 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_SGI_GRU)		+= sgi-gru/
>  obj-$(CONFIG_CS5535_MFGPT)	+= cs5535-mfgpt.o
>  obj-$(CONFIG_GEHC_ACHC)		+= gehc-achc.o
>  obj-$(CONFIG_HP_ILO)		+= hpilo.o
> +obj-$(CONFIG_HPS_I2C)		+= hps-i2c.o
>  obj-$(CONFIG_APDS9802ALS)	+= apds9802als.o
>  obj-$(CONFIG_ISL29003)		+= isl29003.o
>  obj-$(CONFIG_ISL29020)		+= isl29020.o
> diff --git a/drivers/misc/hps-i2c.c b/drivers/misc/hps-i2c.c
> new file mode 100644
> index 000000000000..fe9f073b0352
> --- /dev/null
> +++ b/drivers/misc/hps-i2c.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for the ChromeOS anti-snooping sensor (HPS), attached via I2C.
> + *
> + * The driver exposes HPS as a character device, although currently no read or
> + * write operations are supported. Instead, the driver only controls the power
> + * state of the sensor, keeping it on only while userspace holds an open file
> + * descriptor to the HPS device.
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/cdev.h>
> +#include <linux/fs.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +
> +#define HPS_ACPI_ID		"GOOG0020"
> +#define HPS_MAX_DEVICES		1
> +
> +struct hps_drvdata {
> +	struct i2c_client *client;
> +
> +	struct cdev cdev;
> +	struct class *cdev_class;

As you only have 1 device, please just use the miscdev interface, not
the chardev interface.  Makes your code much smaller and easier to
review and maintain over time and does not "burn" a whole major number
for this tiny driver.

thanks,

greg k-h
