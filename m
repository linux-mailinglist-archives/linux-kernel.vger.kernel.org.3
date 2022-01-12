Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F2B48CE08
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiALVvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:51:41 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:39046 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiALVvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:51:39 -0500
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 00646D59451;
        Wed, 12 Jan 2022 22:51:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1642024297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=25IAkErrFr1ccaRZjrAbrG8i4dQFzpeYU1020VUxahU=;
        b=Qcdis82Q7TdWLqbXYlHCsZWnsHfq4Yc+G2Fr39LchB5mVMc3M3UVo0pUuFRkkEBMQghwjj
        AGYVfxL+tiT1xedph5CjXkctnzv9Wp3w7Bq+YuojV29gtTQyTF/7pXyv3qjescIfI8iN/C
        kYodJhNadNnl+1JHZYDd9ESMcpZFWWs=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5 3/3] hwmon: deprecate asis_wmi_ec_sensors driver
Date:   Wed, 12 Jan 2022 22:51:35 +0100
Message-ID: <2224186.ElGaqSPkdT@natalenko.name>
In-Reply-To: <20220111180347.1245774-4-eugene.shalygin@gmail.com>
References: <20220111180347.1245774-1-eugene.shalygin@gmail.com> <20220111180347.1245774-4-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =FAter=FD 11. ledna 2022 19:03:46 CET Eugene Shalygin wrote:
> ---
>  drivers/hwmon/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 2c16b19d2c03..5e693c93d43a 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2243,13 +2243,16 @@ config SENSORS_ASUS_WMI
> =20
>  config SENSORS_ASUS_WMI_EC
>  	tristate "ASUS WMI B550/X570"
> -	depends on ACPI_WMI
> +	depends on ACPI_WMI && !SENSORS_ASUS_EC

Not sure how it handles `SENSORS_ASUS_EC=3Dm`. Probably, it should be:

```
depends on ACPI_WMI && SENSORS_ASUS_EC=3Dn
```

?

>  	help
>  	  If you say yes here you get support for the ACPI embedded controller
>  	  hardware monitoring interface found in B550/X570 ASUS motherboards.
>  	  This driver will provide readings of fans, voltages and temperatures
>  	  through the system firmware.
> =20
> +	  This driver is deprecated in favor of the ASUS EC Sensors driver
> +	  which provides fully compatible output.
> +
>  	  This driver can also be built as a module. If so, the module
>  	  will be called asus_wmi_sensors_ec.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


