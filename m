Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CDE4A37BD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 17:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355573AbiA3Qla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 11:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiA3Ql3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 11:41:29 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CF6C061714;
        Sun, 30 Jan 2022 08:41:28 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id b186so16082508oif.1;
        Sun, 30 Jan 2022 08:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GSJQs/IyzQLIz6D/JkwR/pMK0+5qH35ZqrOipwQfRbE=;
        b=BNEG3sMvVw+5dRyH2NUqiDzBbGLUCbz+EL0qAW1kPVqP2p+3NxMf4dV0gvxGjOG+Dw
         viiqO1czFsd/KNQACN89OA6E9BzoE79XC+6uD5hTL9VQKetlY6i1DTc3LtQkwsXBHIOq
         Djr60foYoV32hsZWbjmtJJMy76hS/Mxvsz/+9HAuwJ9z1zb7Vqd60qbK9ix1OBs0P/Pn
         f0uh0VrunvIQhgR/MhbxTvojwRTsK7UGwn447LDIhfrGCq3mh9CIZ9PQErz0ndNCgt+w
         +YkECkeZ/LN2hoICubEuk46s0fxXw+VloIjeRBCrCyHhPPT9jFlS5WRTS4131qEyGZWQ
         hKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GSJQs/IyzQLIz6D/JkwR/pMK0+5qH35ZqrOipwQfRbE=;
        b=InvS2vx7AjFB2yUAZe+Xt9S1iTzy2DFodCPNQP65iomU8h7YGYPgTe74DGnRrVI46M
         sH+YwysHFRqBYqvv5edPTX8QYd0MqOpyLp73YLGlDd6wjU2QYIOq6NWopqaB52Pj063Z
         UGDcggRZvoMBY7YT2Hf0PNxi9SPN3q2IpuacTeytxreY/UoNqs9YXT5pFqEVgar+V+tP
         WxlzRpZrzfCC5b8JJsYkvoGmhCwY1dFCXpJxVbpkvQqfMESjdVb42tdFLP3PwfElSzce
         qfTkenHrieYvxmi+dTGdrrrZ8VDzBxcjyv1MfSO9dCtQ5yMmjHAdqN6oGsNmt32TkP4P
         MO9w==
X-Gm-Message-State: AOAM531GiVIjy4NwpxEyebYVif2iUxum92VY+zwvQbsx6s0PyaIvxiqb
        aJmYxrTjneqCnihY5f+A0ak=
X-Google-Smtp-Source: ABdhPJzGBiFaEait5pJ4MfY+hwG2HCLBSiW7il/ZXS2ZQbREAEcqeU5cYnn2KTp/XzGwj8WSg7506Q==
X-Received: by 2002:aca:ab0d:: with SMTP id u13mr16126504oie.138.1643560888155;
        Sun, 30 Jan 2022 08:41:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j11sm14457177otj.30.2022.01.30.08.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 08:41:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 30 Jan 2022 08:41:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] acpi: Store CRC-32 hash of the _PLD in struct
 acpi_device
Message-ID: <20220130164126.GA2942650@roeck-us.net>
References: <20211223081620.45479-1-heikki.krogerus@linux.intel.com>
 <20211223081620.45479-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223081620.45479-3-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 11:16:17AM +0300, Heikki Krogerus wrote:
> Storing CRC-32 hash of the Physical Location of Device
> object (_PLD) with devices that have it. The hash is stored
> to a new struct acpi_device member "pld_crc".
> 
> The hash makes it easier to find devices that share a
> location, as there is no need to evaluate the entire object
> every time. Knowledge about devices that share a location
> can be used in device drivers that need to know the
> connections to other components inside a system. USB3 ports
> will for example always share their location with a USB2
> port.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Building ia64:tinyconfig ... failed

ia64-linux-ld: drivers/acpi/scan.o: in function `__acpi_device_add':
scan.c:(.text+0x27e2): undefined reference to `crc32_le'

ACPI now depends on CRC32.

#regzbot introduced: 882c982dada4d5

Guenter

> ---
>  drivers/acpi/scan.c     | 16 ++++++++++++++++
>  include/acpi/acpi_bus.h |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 7ff55a197a583..113414c46b713 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -19,6 +19,7 @@
>  #include <linux/dma-map-ops.h>
>  #include <linux/platform_data/x86/apple.h>
>  #include <linux/pgtable.h>
> +#include <linux/crc32.h>
>  
>  #include "internal.h"
>  
> @@ -667,6 +668,19 @@ static int acpi_tie_acpi_dev(struct acpi_device *adev)
>  	return 0;
>  }
>  
> +static void acpi_store_pld_crc(struct acpi_device *adev)
> +{
> +	struct acpi_pld_info *pld;
> +	acpi_status status;
> +
> +	status = acpi_get_physical_device_location(adev->handle, &pld);
> +	if (ACPI_FAILURE(status))
> +		return;
> +
> +	adev->pld_crc = crc32(~0, pld, sizeof(*pld));
> +	ACPI_FREE(pld);
> +}
> +
>  static int __acpi_device_add(struct acpi_device *device,
>  			     void (*release)(struct device *))
>  {
> @@ -725,6 +739,8 @@ static int __acpi_device_add(struct acpi_device *device,
>  	if (device->wakeup.flags.valid)
>  		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
>  
> +	acpi_store_pld_crc(device);
> +
>  	mutex_unlock(&acpi_device_lock);
>  
>  	if (device->parent)
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 8e87ead2af341..f8c945418df23 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -360,6 +360,7 @@ struct acpi_gpio_mapping;
>  
>  /* Device */
>  struct acpi_device {
> +	u32 pld_crc;
>  	int device_type;
>  	acpi_handle handle;		/* no handle for fixed hardware */
>  	struct fwnode_handle fwnode;
