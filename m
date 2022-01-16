Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B96C48FEAA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 20:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbiAPT3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 14:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiAPT3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 14:29:04 -0500
X-Greylist: delayed 111399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Jan 2022 11:29:03 PST
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07B7C061574;
        Sun, 16 Jan 2022 11:29:03 -0800 (PST)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 2F194D64DC7;
        Sun, 16 Jan 2022 20:29:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1642361341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GIoSTxudl4ORprjRcu++GnE1IFzgu7Qi36PinduD8GM=;
        b=Sdahs2igqjBvlecM/tslBBQJ0uRu18YInEwW24OOIFbu949Ic24DGux3jNRAFnYUyCmoz3
        q9ZNzZ369O8CoiEnYlCGxXLhzoalCRYFxrd87QuI4xa5brnLaVgY2cbpqHhlNuzhwM2TVK
        xjJ6/Bil4wB4YV++v9NcvXc08ut+UUg=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: PATCH v4 ASUS EC Sensors
Date:   Sun, 16 Jan 2022 20:28:59 +0100
Message-ID: <2613330.mvXUDI8C0e@natalenko.name>
In-Reply-To: <20220111180347.1245774-1-eugene.shalygin@gmail.com>
References: <20220111180347.1245774-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =FAter=FD 11. ledna 2022 19:03:43 CET Eugene Shalygin wrote:
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
> Chenges in v5:
>  - Place the sensors bitset directly into the driver_data field of the
> 	 dmi_system_id struct.
>  - Replace doc comments with regular ones.

BTW, is this OK:

```
[   11.104396] asus-ec-sensors PNP0C09:00: board has 6 EC sensors that span=
 7 registers
[   11.104400] asus-ec-sensors PNP0C09:00: hwmon: 'asus-ec-sensors' is not =
a valid name attribute, please fix
```

?

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

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


