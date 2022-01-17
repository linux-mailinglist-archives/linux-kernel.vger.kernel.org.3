Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC934902E3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbiAQHWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiAQHWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:22:00 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D47FC06173E;
        Sun, 16 Jan 2022 23:22:00 -0800 (PST)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id D52FCD65F61;
        Mon, 17 Jan 2022 08:21:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1642404117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qOHlb7+VIx9AOuvxs7zLpRtZalu6CAyHFVjBEJu2Ono=;
        b=OrVForQuXhMrI+PUqGng0F97r7QPH7DD6aXd2MdBVzq46qyEIdYgOTk5sdE1MfRmQmOGg8
        5FSoJiuI+cxcY96Dsjv/ldZeIBN5IsVe1HFM3KK+k5N482q0Tsw+bZx0aZNnNvFt/F6GlQ
        /e5ZFIFjdWIFi7O4esULkivutEPa2Vw=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [ASUS EC Sensors V6 v6 0/3]
Date:   Mon, 17 Jan 2022 08:21:55 +0100
Message-ID: <2613447.mvXUDI8C0e@natalenko.name>
In-Reply-To: <20220116201843.2301438-1-eugene.shalygin@gmail.com>
References: <20220116201843.2301438-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On ned=C4=9Ble 16. ledna 2022 21:18:38 CET Eugene Shalygin wrote:
> This patchset replaces the HWMON asus_wmi_ec_sensors driver with
> an implementation that does not use WMI but queries the embedded
> controller directly.
>=20
> That provides two enhancements: sensor reading became quicker (on some
> systems or kernel configuration it took almost a full second to read
> all the sensors, that transfers less than 15 bytes of data), the driver
> became more fexible. The driver now relies on ACPI mutex to lock access
> to the EC, in the same way as the WMI DSDT code does.
>=20
> Changes in v6:
>  - Fixed hwmon device name replacing dashes with underscores.
>  - Removed module verion.
>  - Fixed condition for asus_wmi_ec_Sensors in KBuild.

=46or the series:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

> Changes in v5:
>  - Place the sensors bitset directly into the driver_data field of the
>          dmi_system_id struct.
>  - Replace doc comments with regular ones.
>=20
> Changes in v4:
>  - Deprecate the wmi driver rather than removing it.
>=20
> Changes in v3:
>  - Remove BIOS version checks and BIOS version dependent mutex path.
>=20
> Changes in v2:
>  - Replace sensor flags enum with bitset
>  - Replace module init/probe functions with module_platform_driver_probe
>    and ask the platform drivers framework to load the driver when ACPI
>    EC is found (ACPI ID "PNP0C09").
>  - Extend board data with BIOS version attribute for the mutex path to be
>    BIOS version dependent.
>  - Add module parameter to override the mutex path.
>=20
> Eugene Shalygin (3):
>   hwmon: (asus-ec-sensors) add driver for ASUS EC
>   hwmon: (asus-ec-sensors) update documentation
>   hwmon: deprecate asis_wmi_ec_sensors driver
>=20
>  Documentation/hwmon/asus_ec_sensors.rst     |  51 ++
>  Documentation/hwmon/asus_wmi_ec_sensors.rst |  38 --
>  MAINTAINERS                                 |   6 +
>  drivers/hwmon/Kconfig                       |  16 +-
>  drivers/hwmon/Makefile                      |   1 +
>  drivers/hwmon/asus-ec-sensors.c             | 690 ++++++++++++++++++++
>  6 files changed, 763 insertions(+), 39 deletions(-)
>  create mode 100644 Documentation/hwmon/asus_ec_sensors.rst
>  delete mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
>  create mode 100644 drivers/hwmon/asus-ec-sensors.c

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


