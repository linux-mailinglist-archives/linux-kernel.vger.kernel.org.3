Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C1049AFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457219AbiAYJOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455337AbiAYJE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:04:26 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574A3C061362;
        Tue, 25 Jan 2022 00:48:21 -0800 (PST)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id F0923D845E3;
        Tue, 25 Jan 2022 09:48:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1643100497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DNGmSgajX3AV7tac/NHRSny7ZKSXgCu8THN38jSPcJY=;
        b=uVvpTJENujv89DwH1ydCqmX64nzGHF10t5qSormK78RR5uxmWBRxvlAfQ21pylsjVvnGcj
        aJkXQBxb0eQeHVnNpV92VFOlITkBIXclTAiMTKakcLGVGwF+iYqN8UZacbblUxxCdtzqZJ
        K6KFOu0kypEE5l0r6etqlVkwq6mr7Mk=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ASUS EC Sensors v8 2/3] hwmon: (asus-ec-sensors) update documentation
Date:   Tue, 25 Jan 2022 09:48:15 +0100
Message-ID: <5534652.DvuYhMxLoT@natalenko.name>
In-Reply-To: <20220124015658.687309-3-eugene.shalygin@gmail.com>
References: <20220124015658.687309-1-eugene.shalygin@gmail.com> <20220124015658.687309-3-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On pond=C4=9Bl=C3=AD 24. ledna 2022 2:56:44 CET Eugene Shalygin wrote:
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

I believe some commit message is desired here.

> ---
>  Documentation/hwmon/asus_ec_sensors.rst     | 52 +++++++++++++++++++++
>  Documentation/hwmon/asus_wmi_ec_sensors.rst | 38 ---------------
>  2 files changed, 52 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/hwmon/asus_ec_sensors.rst
>  delete mode 100644 Documentation/hwmon/asus_wmi_ec_sensors.rst
>=20
> diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmo=
n/asus_ec_sensors.rst
> new file mode 100644
> index 000000000000..b12ac7ebeb1a
> --- /dev/null
> +++ b/Documentation/hwmon/asus_ec_sensors.rst
> @@ -0,0 +1,52 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver asus_ec_sensors
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Supported boards:
> + * PRIME X570-PRO,
> + * Pro WS X570-ACE,
> + * ROG CROSSHAIR VIII DARK HERO,
> + * ROG CROSSHAIR VIII FORMULA,
> + * ROG CROSSHAIR VIII HERO,
> + * ROG CROSSHAIR VIII IMPACT,
> + * ROG STRIX B550-E GAMING,
> + * ROG STRIX B550-I GAMING,
> + * ROG STRIX X570-E GAMING,
> + * ROG STRIX X570-F GAMING,
> + * ROG STRIX X570-I GAMING
> +
> +Authors:
> +    - Eugene Shalygin <eugene.shalygin@gmail.com>
> +
> +Description:
> +------------
> +ASUS mainboards publish hardware monitoring information via Super I/O
> +chip and the ACPI embedded controller (EC) registers. Some of the sensors
> +are only available via the EC.
> +
> +The driver is aware of and reads the following sensors:
> +
> +1. Chipset (PCH) temperature
> +2. CPU package temperature
> +3. Motherboard temperature
> +4. Readings from the T_Sensor header
> +5. VRM temperature
> +6. CPU_Opt fan RPM
> +7. VRM heatsink fan RPM
> +8. Chipset fan RPM
> +9. Readings from the "Water flow meter" header (RPM)
> +10. Readings from the "Water In" and "Water Out" temperature headers
> +11. CPU current
> +
> +Sensor values are read from EC registers, and to avoid race with the boa=
rd
> +firmware the driver acquires ACPI mutex, the one used by the WMI when its
> +methods access the EC.
> +
> +Module Parameters
> +-----------------
> + * mutex_path: string
> +		The driver holds path to the ACPI mutex for each board (actually,
> +		the path is mostly identical for them). If ASUS changes this path
> +		in a future BIOS update, this parameter can be used to override
> +		the stored in the driver value until it gets updated.
> diff --git a/Documentation/hwmon/asus_wmi_ec_sensors.rst b/Documentation/=
hwmon/asus_wmi_ec_sensors.rst
> deleted file mode 100644
> index 1b287f229e86..000000000000
> --- a/Documentation/hwmon/asus_wmi_ec_sensors.rst
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0-or-later
> -
> -Kernel driver asus_wmi_ec_sensors
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Supported boards:
> - * PRIME X570-PRO,
> - * Pro WS X570-ACE,
> - * ROG CROSSHAIR VIII DARK HERO,
> - * ROG CROSSHAIR VIII FORMULA,
> - * ROG CROSSHAIR VIII HERO,
> - * ROG STRIX B550-E GAMING,
> - * ROG STRIX B550-I GAMING,
> - * ROG STRIX X570-E GAMING.
> -
> -Authors:
> -    - Eugene Shalygin <eugene.shalygin@gmail.com>
> -
> -Description:
> -------------
> -ASUS mainboards publish hardware monitoring information via Super I/O
> -chip and the ACPI embedded controller (EC) registers. Some of the sensors
> -are only available via the EC.
> -
> -ASUS WMI interface provides a method (BREC) to read data from EC registe=
rs,
> -which is utilized by this driver to publish those sensor readings to the
> -HWMON system. The driver is aware of and reads the following sensors:
> -
> -1. Chipset (PCH) temperature
> -2. CPU package temperature
> -3. Motherboard temperature
> -4. Readings from the T_Sensor header
> -5. VRM temperature
> -6. CPU_Opt fan RPM
> -7. Chipset fan RPM
> -8. Readings from the "Water flow meter" header (RPM)
> -9. Readings from the "Water In" and "Water Out" temperature headers
> -10. CPU current
>=20


=2D-=20
Oleksandr Natalenko (post-factum)


