Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290994ADE11
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352116AbiBHQPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbiBHQPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:15:53 -0500
X-Greylist: delayed 17543 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 08:15:50 PST
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EF0C061576;
        Tue,  8 Feb 2022 08:15:50 -0800 (PST)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 0B749DB99D7;
        Tue,  8 Feb 2022 17:15:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1644336948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=beiYUnGsDRVtxVBC1NGXGzh4TXiSTexf+TKx1Nk5pm8=;
        b=r+ez8ddTKjhSE1z57mA3aHTc9FJYVvjZwZEJaHgBYDb28KQxUEnasb2Cddd3I4CwhsWPPe
        FV2WEyMPISklKzo3NXP65EzQTgeJkJc+RxT+8OoAd7gMZWmvNILNWrq1/2+OagQoxZ8XtT
        lThTd853wv3mS0YnshUusKiZrhiJgyQ=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add CPU core voltage
Date:   Tue, 08 Feb 2022 17:15:46 +0100
Message-ID: <11918951.O9o76ZdvQC@natalenko.name>
In-Reply-To: <20220208094244.1106312-1-eugene.shalygin@gmail.com>
References: <20220208094244.1106312-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =C3=BAter=C3=BD 8. =C3=BAnora 2022 10:42:43 CET Eugene Shalygin wrote:
> A user discovered [1] the CPU Core voltage sensor, which spans 2
> registers and provides output in mV. Althroug the discovery was made
> with a X470 chipset, the sensor is present in X570 (tested with C8H).
> For now simply add it to each board with the CPU current sensor present.
>=20
> [1] https://github.com/zeule/asus-ec-sensors/issues/12
>=20
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> ---
>  Documentation/hwmon/asus_ec_sensors.rst |  1 +
>  drivers/hwmon/asus-ec-sensors.c         | 29 ++++++++++++++++---------
>  2 files changed, 20 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmo=
n/asus_ec_sensors.rst
> index 22de1b037cfb..e7e8f1640f45 100644
> --- a/Documentation/hwmon/asus_ec_sensors.rst
> +++ b/Documentation/hwmon/asus_ec_sensors.rst
> @@ -39,6 +39,7 @@ The driver is aware of and reads the following sensors:
>  9. Readings from the "Water flow meter" header (RPM)
>  10. Readings from the "Water In" and "Water Out" temperature headers
>  11. CPU current
> +12. CPU core voltage
> =20
>  Sensor values are read from EC registers, and to avoid race with the boa=
rd
>  firmware the driver acquires ACPI mutex, the one used by the WMI when its
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sens=
ors.c
> index dd7b207d062f..bfac08a5dc57 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -18,6 +18,7 @@
>   * - VRM Heat Sink fan RPM
>   * - Water Flow fan RPM
>   * - CPU current
> + * - CPU core voltage
>   */
> =20
>  #include <linux/acpi.h>
> @@ -100,6 +101,8 @@ enum ec_sensors {
>  	ec_sensor_temp_t_sensor,
>  	/* VRM temperature [=E2=84=83] */
>  	ec_sensor_temp_vrm,
> +	/* CPU Core voltage [mV] */
> +	ec_sensor_in_cpu_core,
>  	/* CPU_Opt fan [RPM] */
>  	ec_sensor_fan_cpu_opt,
>  	/* VRM heat sink fan [RPM] */
> @@ -121,6 +124,7 @@ enum ec_sensors {
>  #define SENSOR_TEMP_MB BIT(ec_sensor_temp_mb)
>  #define SENSOR_TEMP_T_SENSOR BIT(ec_sensor_temp_t_sensor)
>  #define SENSOR_TEMP_VRM BIT(ec_sensor_temp_vrm)
> +#define SENSOR_IN_CPU_CORE BIT(ec_sensor_in_cpu_core)
>  #define SENSOR_FAN_CPU_OPT BIT(ec_sensor_fan_cpu_opt)
>  #define SENSOR_FAN_VRM_HS BIT(ec_sensor_fan_vrm_hs)
>  #define SENSOR_FAN_CHIPSET BIT(ec_sensor_fan_chipset)
> @@ -139,6 +143,8 @@ static const struct ec_sensor_info known_ec_sensors[]=
 =3D {
>  	[ec_sensor_temp_t_sensor] =3D
>  		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
>  	[ec_sensor_temp_vrm] =3D EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e),
> +	[ec_sensor_in_cpu_core] =3D
> +		EC_SENSOR("CPU Core", hwmon_in, 2, 0x00, 0xa2),
>  	[ec_sensor_fan_cpu_opt] =3D
>  		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
>  	[ec_sensor_fan_vrm_hs] =3D EC_SENSOR("VRM HS", hwmon_fan, 2, 0x00, 0xb2=
),
> @@ -172,32 +178,34 @@ static const struct dmi_system_id asus_ec_dmi_table=
[] __initconst =3D {
>  		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "Pro WS X570-ACE",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
> -		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU),
> +		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

on Pro WS X570-ACE:

```
asusec-isa-0000
Adapter: ISA adapter
CPU Core:      1.47 V
=E2=80=A6
```

Thanks.

>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
>  			      "ROG CROSSHAIR VIII DARK HERO",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
>  		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
> -		SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU),
> +		SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
> +		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
>  			      "ROG CROSSHAIR VIII FORMULA",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
>  		SENSOR_TEMP_VRM | SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
> -		SENSOR_CURR_CPU),
> +		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG CROSSHAIR VIII HERO",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
>  		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
>  		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
> -		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU),
> +		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
>  			      "ROG CROSSHAIR VIII HERO (WI-FI)",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
>  		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
>  		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
> -		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU),
> +		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
>  			      "ROG CROSSHAIR VIII IMPACT",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
> -		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU),
> +		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET |
> +		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX B550-E GAMING",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
>  		SENSOR_TEMP_T_SENSOR |
> @@ -205,17 +213,19 @@ static const struct dmi_system_id asus_ec_dmi_table=
[] __initconst =3D {
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX B550-I GAMING",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
>  		SENSOR_TEMP_T_SENSOR |
> -		SENSOR_TEMP_VRM | SENSOR_FAN_VRM_HS | SENSOR_CURR_CPU),
> +		SENSOR_TEMP_VRM | SENSOR_FAN_VRM_HS |
> +		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-E GAMING",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
>  		SENSOR_TEMP_T_SENSOR |
> -		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU),
> +		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET |
> +		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-F GAMING",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
>  		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-I GAMING",
>  		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_VRM_HS |
> -		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU),
> +		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
>  	{}
>  };
> =20
> @@ -467,7 +477,6 @@ static long scale_sensor_value(s32 value, int data_ty=
pe)
>  	switch (data_type) {
>  	case hwmon_curr:
>  	case hwmon_temp:
> -	case hwmon_in:
>  		return value * MILLI;
>  	default:
>  		return value;
>=20


=2D-=20
Oleksandr Natalenko (post-factum)


