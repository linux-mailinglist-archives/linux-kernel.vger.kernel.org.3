Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D152247B3E1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhLTTmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhLTTmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:42:17 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF66DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:42:16 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id m1so8550988pfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KoVlv4DwLSYaskk/NiROpawGSL9nBdwY2zIFrfhk2/c=;
        b=Mr0uD14e4FwfkZYuwJQ/bvgsHDaaBhksz+Ycp4dUFSKS+S7UiJVCKyFScEXxiE4Ikk
         44X0xErqxeF2yAXh5hoYWe69MsZBvoA1qskBru68JWeeWNacylz79TcNbUZkA1SBP37G
         Kil6RMkbEvPs70TbLlnHgzXRNryDTjOXy9kxAUoRlxUAf6E3rslFWa2/IYt/ftGx/uMB
         NHGWuAIMX2BMqfGue2lIvekLyyfPcDO3HEMvqqE+WG+wXjZti28rYAggfz/26EEfJn8b
         rJNDSGtmRU2b4DjEopLZ//6hAy85TcG/hro7UCw+CxJRDcXfPp2WpF1RwMNxxlYeIbgD
         tNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KoVlv4DwLSYaskk/NiROpawGSL9nBdwY2zIFrfhk2/c=;
        b=OqzxTJm8s1MyxqGUSAOFi3Khcvr9NkBONw+6cGS1hWNgs49xzGFT72ReEpHLu6OBmH
         ZHs7PgpxUW+kDkM1RVXPRStYl9kPMqaTYXUxOpreGLJ+zCst8VAGBW6JtdOB5QunlHea
         Y/cZ+eCY1gIgkBDO1IsTFFHk6ikzT9apkSOdiOv8gqdkfOg/yqGoaXctKnfS9MigqKcT
         ChhzHt/L3Bp16SQs+cnkQ2vCHiR4J1PQDf3J9FH70cSrC0RvBK5fwYDyFkDXDKfGAlpZ
         /Rhajw4dtwTcwgu06tz09NQQ0M9JmKnA5Per4Wr8pVDqqfr/Ow4ElkomthlEy3pNRGdz
         MNdA==
X-Gm-Message-State: AOAM532OjKHxtPbrhh1ZvV1qQ24qEr9EhMxsCHtofd2z0Y3bgFgIRvyS
        zw6+NWIg7zsKKcaC57XX0Oc=
X-Google-Smtp-Source: ABdhPJy4Hho/V/6Hec97yfxkmXMyfitPiO7PJcxVfn366LGFerPjUTAUdOJ62k38249oy1Sce12aZw==
X-Received: by 2002:a63:6c81:: with SMTP id h123mr16472244pgc.313.1640029336229;
        Mon, 20 Dec 2021 11:42:16 -0800 (PST)
Received: from google.com ([2620:15c:202:201:9632:a1c4:968a:6f66])
        by smtp.gmail.com with ESMTPSA id mw8sm175904pjb.42.2021.12.20.11.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 11:42:14 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
X-Google-Original-From: Dmitry Torokhov <dtor@google.com>
Date:   Mon, 20 Dec 2021 11:42:12 -0800
To:     Rajat Jain <rajatja@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        gwendal@google.com, seanpaul@google.com, marcheau@google.com,
        rajatxjain@gmail.com
Subject: Re: [PATCH v2 1/2] platform/chrome: Add driver for ChromeOS
 privacy-screen
Message-ID: <YcDclHaoiKX8dbXG@google.com>
References: <20211217202850.1967594-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217202850.1967594-1-rajatja@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

On Fri, Dec 17, 2021 at 12:28:49PM -0800, Rajat Jain wrote:
> This adds the ACPI driver for the ChromeOS privacy screen that is
> present on some chromeos devices.
> 
> Note that ideally, we'd want this privacy screen driver to be probed
> BEFORE the drm probe in order to avoid a drm probe deferral:
> https://hansdegoede.livejournal.com/25948.html
> 
> In practise, I found that ACPI drivers are bound to their devices AFTER
> the drm probe on chromebooks. So on chromebooks with privacy-screen,
> this patch along with the next one in this series results in a probe
> deferral of about 250ms for i915 driver. However, it did not result in
> any user noticeable delay of splash screen in my personal experience.
> 
> In future if this probe deferral turns out to be an issue, we can
> consider turning this ACPI driver into something that is probed
> earlier than the drm drivers.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v2: * Reword the commit log
>     * Make the Kconfig into a tristate
>     * Reorder the patches in the series.
> 
>  drivers/platform/chrome/Kconfig              |   9 ++
>  drivers/platform/chrome/Makefile             |   1 +
>  drivers/platform/chrome/chromeos_priv_scrn.c | 132 +++++++++++++++++++
>  3 files changed, 142 insertions(+)
>  create mode 100644 drivers/platform/chrome/chromeos_priv_scrn.c
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index ccc23d8686e8..d1c209a45a62 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -243,6 +243,15 @@ config CROS_USBPD_NOTIFY
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cros_usbpd_notify.
>  
> +config CHROMEOS_PRIVACY_SCREEN
> +	tristate "ChromeOS Privacy Screen support"
> +	depends on ACPI
> +	depends on DRM
> +	select DRM_PRIVACY_SCREEN
> +	help
> +	  This driver provides the support needed for the in-built electronic
> +	  privacy screen that is present on some ChromeOS devices.
> +
>  source "drivers/platform/chrome/wilco_ec/Kconfig"
>  
>  endif # CHROMEOS_PLATFORMS
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index f901d2e43166..cfa0bb4e9e34 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -4,6 +4,7 @@
>  CFLAGS_cros_ec_trace.o:=		-I$(src)
>  
>  obj-$(CONFIG_CHROMEOS_LAPTOP)		+= chromeos_laptop.o
> +obj-$(CONFIG_CHROMEOS_PRIVACY_SCREEN)	+= chromeos_priv_scrn.o
>  obj-$(CONFIG_CHROMEOS_PSTORE)		+= chromeos_pstore.o
>  obj-$(CONFIG_CHROMEOS_TBMC)		+= chromeos_tbmc.o
>  obj-$(CONFIG_CROS_EC)			+= cros_ec.o
> diff --git a/drivers/platform/chrome/chromeos_priv_scrn.c b/drivers/platform/chrome/chromeos_priv_scrn.c
> new file mode 100644
> index 000000000000..a4cbf5c79c2a
> --- /dev/null
> +++ b/drivers/platform/chrome/chromeos_priv_scrn.c

I think we can spare a few more characters :) chromeos_privacy_screen.c
maybe?

And also see if maybe variables in the code are not that unseemly long
even if not abbreviated?

> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + *  chromeos_priv_scrn.c - ChromeOS Privacy Screen support

I'd avoid mentioning file name as those tend to change.

> + *
> + * Copyright (C) 2022 The Chromium OS Authors

This is not correct copyright for kernel contributions. It should be
attributed to "Google LLC". Note that it is different from CrOS
userspace.

> + *
> + */
> +
> +#include <linux/acpi.h>
> +#include <drm/drm_privacy_screen_driver.h>
> +
> +/*
> + * The DSM (Define Specific Method) constants below are the agreed API with
> + * the firmware team, on how to control privacy screen using ACPI methods.
> + */
> +#define PRIV_SCRN_DSM_REVID		1	/* DSM version */
> +#define PRIV_SCRN_DSM_FN_GET_STATUS	1	/* Get privacy screen status */
> +#define PRIV_SCRN_DSM_FN_ENABLE		2	/* Enable privacy screen */
> +#define PRIV_SCRN_DSM_FN_DISABLE	3	/* Disable privacy screen */
> +
> +static const guid_t chromeos_priv_scrn_dsm_guid =
> +		    GUID_INIT(0xc7033113, 0x8720, 0x4ceb,
> +			      0x90, 0x90, 0x9d, 0x52, 0xb3, 0xe5, 0x2d, 0x73);
> +
> +static void
> +chromeos_priv_scrn_get_hw_state(struct drm_privacy_screen *drm_priv_scrn)
> +{
> +	union acpi_object *obj;
> +	acpi_handle handle;
> +	struct device *priv_scrn = drm_priv_scrn->dev.parent;

This is really bad that we need to poke into internals of
drm_privacy_screen to get to "our" device. I think there is only one
consume of the privacy screen API at the moment, the thinkpad driver, so
maybe it is not too late to change drm_privacy_screen_register() to
either accept instance of struct drm_privacy_screen (which then could be
embedded into something) or accept a void pointer to attach arbitrary
data to it, and then add drm_privacy_screen_get_drvdata() to get to that
pointer.

> +
> +	if (!priv_scrn)
> +		return;

This should not happen regardless.

> +
> +	handle = acpi_device_handle(to_acpi_device(priv_scrn));
> +	obj = acpi_evaluate_dsm(handle, &chromeos_priv_scrn_dsm_guid,
> +				PRIV_SCRN_DSM_REVID,
> +				PRIV_SCRN_DSM_FN_GET_STATUS, NULL);
> +	if (!obj) {
> +		dev_err(priv_scrn, "_DSM failed to get privacy-screen state\n");

Can we do something about it? A dedicated status? Also, can we print
ACPI-specific error?

> +		return;
> +	}
> +
> +	if (obj->type != ACPI_TYPE_INTEGER)
> +		dev_err(priv_scrn, "Bad _DSM to get privacy-screen state\n");

Same here.

> +	else if (obj->integer.value == 1)
> +		drm_priv_scrn->hw_state = drm_priv_scrn->sw_state =
> +			PRIVACY_SCREEN_ENABLED;
> +	else
> +		drm_priv_scrn->hw_state = drm_priv_scrn->sw_state =
> +			PRIVACY_SCREEN_DISABLED;
> +
> +	ACPI_FREE(obj);
> +}
> +
> +static int
> +chromeos_priv_scrn_set_sw_state(struct drm_privacy_screen *drm_priv_scrn,
> +				enum drm_privacy_screen_status state)
> +{
> +	union acpi_object *obj = NULL;
> +	acpi_handle handle;
> +	struct device *priv_scrn = drm_priv_scrn->dev.parent;
> +
> +	if (!priv_scrn)
> +		return -ENODEV;

This should not happen regardless.

> +
> +	handle = acpi_device_handle(to_acpi_device(priv_scrn));
> +
> +	if (state == PRIVACY_SCREEN_DISABLED) {
> +		obj = acpi_evaluate_dsm(handle,	&chromeos_priv_scrn_dsm_guid,
> +					PRIV_SCRN_DSM_REVID,
> +					PRIV_SCRN_DSM_FN_DISABLE, NULL);
> +	} else if (state == PRIVACY_SCREEN_ENABLED) {
> +		obj = acpi_evaluate_dsm(handle,	&chromeos_priv_scrn_dsm_guid,
> +					PRIV_SCRN_DSM_REVID,
> +					PRIV_SCRN_DSM_FN_ENABLE, NULL);
> +	} else {
> +		dev_err(priv_scrn, "Bad attempt to set privacy-screen status\n");
> +		return -EINVAL;

Print state to aid in tracking bugs?

> +	}
> +
> +	if (!obj) {
> +		dev_err(priv_scrn, "_DSM failed to set privacy-screen state\n");

Can we print ACPI-specific error?

> +		return -EIO;
> +	}
> +
> +	drm_priv_scrn->hw_state = drm_priv_scrn->sw_state = state;
> +	ACPI_FREE(obj);
> +	return 0;
> +}
> +
> +static const struct drm_privacy_screen_ops chromeos_priv_scrn_ops = {
> +	.get_hw_state = chromeos_priv_scrn_get_hw_state,
> +	.set_sw_state = chromeos_priv_scrn_set_sw_state,
> +};
> +
> +static int chromeos_priv_scrn_add(struct acpi_device *adev)
> +{
> +	struct drm_privacy_screen *drm_priv_scrn =
> +		drm_privacy_screen_register(&adev->dev, &chromeos_priv_scrn_ops);
> +
> +	if (IS_ERR(drm_priv_scrn)) {
> +		dev_err(&adev->dev, "Error registering privacy-screen\n");
> +		return PTR_ERR(drm_priv_scrn);
> +	}
> +
> +	dev_info(&adev->dev, "registered privacy-screen '%s'\n",
> +		 dev_name(&drm_priv_scrn->dev));

I don't think we need be this noisy.

> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id chromeos_priv_scrn_device_ids[] = {
> +	{"GOOG0010", 0}, /* Google's electronic privacy screen for eDP-1 */
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, chromeos_priv_scrn_device_ids);
> +
> +static struct acpi_driver chromeos_priv_scrn_driver = {
> +	.name = "chromeos_priv_scrn_drvr",
> +	.class = "ChromeOS",
> +	.ids = chromeos_priv_scrn_device_ids,
> +	.ops = {
> +		.add = chromeos_priv_scrn_add,

We don't need any cleanup?

> +	},
> +};
> +
> +module_acpi_driver(chromeos_priv_scrn_driver);
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ChromeOS ACPI Privacy Screen driver");
> +MODULE_AUTHOR("Rajat Jain <rajatja@google.com>");
> -- 
> 2.34.1.307.g9b7440fafd-goog
> 

Thanks.

-- 
Dmitry
