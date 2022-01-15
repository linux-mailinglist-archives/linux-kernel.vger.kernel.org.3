Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA8948F6DB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 13:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiAOMc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 07:32:27 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:39140 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiAOMc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 07:32:26 -0500
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id E7C13D61A6F;
        Sat, 15 Jan 2022 13:32:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1642249940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=23WmGWgngXycJzPXUeyJefpoZ2lrYTw10W0ixnvWPy4=;
        b=jsFluq6b8wsA9ztfCdQL+w3BiXzAvaYocna06XxA6DvGVLtQwiCbTva8Keei5wZtr5K0Zi
        nz3Hp+8mKo3psL9L/EojohtdxXgpM6UoxY+W/ow/z+gZJPsjwjpJlSyGRhaiS6yVhUMLqy
        St5MikKm3gReqNhfCXjS07W6sl3+OTs=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5 3/3] hwmon: deprecate asis_wmi_ec_sensors driver
Date:   Sat, 15 Jan 2022 13:32:18 +0100
Message-ID: <2613306.mvXUDI8C0e@natalenko.name>
In-Reply-To: <a95919c0-6a89-18bc-e8ba-2165414e096b@roeck-us.net>
References: <20220111180347.1245774-1-eugene.shalygin@gmail.com> <2224186.ElGaqSPkdT@natalenko.name> <a95919c0-6a89-18bc-e8ba-2165414e096b@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =C4=8Dtvrtek 13. ledna 2022 3:51:47 CET Guenter Roeck wrote:
> On 1/12/22 1:51 PM, Oleksandr Natalenko wrote:
> > Hello.
> >=20
> > On =C3=BAter=C3=BD 11. ledna 2022 19:03:46 CET Eugene Shalygin wrote:
> >> ---
> >>   drivers/hwmon/Kconfig | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> >> index 2c16b19d2c03..5e693c93d43a 100644
> >> --- a/drivers/hwmon/Kconfig
> >> +++ b/drivers/hwmon/Kconfig
> >> @@ -2243,13 +2243,16 @@ config SENSORS_ASUS_WMI
> >>  =20
> >>   config SENSORS_ASUS_WMI_EC
> >>   	tristate "ASUS WMI B550/X570"
> >> -	depends on ACPI_WMI
> >> +	depends on ACPI_WMI && !SENSORS_ASUS_EC
> >=20
> > Not sure how it handles `SENSORS_ASUS_EC=3Dm`. Probably, it should be:
> >=20
> > ```
> > depends on ACPI_WMI && SENSORS_ASUS_EC=3Dn
> > ```
> >=20
>=20
> Odd language, and good catch. If I understand correctly, the result
> of !SENSORS_ASUS_EC is 'm' if SENSORS_ASUS_EC=3Dm. So, yes, it looks
> like this needs to be "ACPI_WMI && SENSORS_ASUS_EC=3Dn".

With this change:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

on ASUS Pro WS X570-ACE.

>=20
> Guenter
>=20
> > ?
> >=20
> >>   	help
> >>   	  If you say yes here you get support for the ACPI embedded control=
ler
> >>   	  hardware monitoring interface found in B550/X570 ASUS motherboard=
s.
> >>   	  This driver will provide readings of fans, voltages and temperatu=
res
> >>   	  through the system firmware.
> >>  =20
> >> +	  This driver is deprecated in favor of the ASUS EC Sensors driver
> >> +	  which provides fully compatible output.
> >> +
> >>   	  This driver can also be built as a module. If so, the module
> >>   	  will be called asus_wmi_sensors_ec.
> >=20
> > Thanks.
> >=20
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)


