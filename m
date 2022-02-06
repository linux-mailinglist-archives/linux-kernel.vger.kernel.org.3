Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675154AB032
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 16:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243599AbiBFP3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 10:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiBFP3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 10:29:16 -0500
X-Greylist: delayed 567 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 07:29:14 PST
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C10C06173B;
        Sun,  6 Feb 2022 07:29:14 -0800 (PST)
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail-4321.protonmail.ch (Postfix) with ESMTPS id 4JsCcd6vN6z4x1KW;
        Sun,  6 Feb 2022 15:19:45 +0000 (UTC)
Authentication-Results: mail-4321.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="vAorGFCz"
Date:   Sun, 06 Feb 2022 15:19:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1644160779;
        bh=Q3GS/VKPc4pLincK/K+VBkPEvrOk9GpZtL0/xd1Jvow=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=vAorGFCz0i3X9WFo6gFx5Q4BoMBGzgQN6SudO0D7GfMdcRGCYPSB1dCIt67Nsdu5n
         9dKOxkYWSZBECIFxVyx73w9O4DlnOm21mAB1ACCOH59gG1pTriGahmoM4j+sviPYG/
         +IGd1TpJFeDBcWH4itQSIABK0CBy0qikNksCHzc6vCoyuzuYS+0o1FaLTlnd4/EwVb
         +kY09znpJFg0hflhAHn6asC+tPNbpA+iOs5ua89r1Nykl8/w8aICRCC6iYAlJGvocC
         OjSwqK+20BWQNxIaf02utD/ClMbpGN0yrTTQ18X2H4jYSHBAUgZ/ocIdMKWXSH9HUi
         bOgbVihuMbFnQ==
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH] platform/x86: Add Steam Deck driver
Message-ID: <gfQUxZHzyr7uH4TwqJwXGsxCIYa-VvrN955036G3kKr6ligJYTAI3dqhf-FJddyHVBomp3JUUBNFMmmR8rwm7WzSxprlclT9Cbkrr2dknP0=@protonmail.com>
In-Reply-To: <20220206022023.376142-1-andrew.smirnov@gmail.com>
References: <20220206022023.376142-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


2022. febru=C3=A1r 6., vas=C3=A1rnap 3:20 keltez=C3=A9ssel, Andrey Smirnov =
=C3=ADrta:
> Add a driver exposing various bits and pieces of functionality
> provided by Steam Deck specific VLV0100 device presented by EC
> firmware. This includes but not limited to:
>
>     - CPU/device's fan control
>     - Read-only access to DDIC registers
>     - Battery tempreature measurements
>     - Various display related control knobs
>     - USB Type-C connector event notification
>

I think some kind of documentation is missing as to
how the various attributes are supposed to work.


> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-kernel@vger.kernel.org (open list)
> Cc: platform-driver-x86@vger.kernel.org
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>
> This driver is really a kitchen sink of various small bits. Maybe it
> is worth splitting into an MFD + child drivers/devices?

Or maybe using the auxiliary bus?


>
>  drivers/platform/x86/Kconfig     |  15 +
>  drivers/platform/x86/Makefile    |   2 +
>  drivers/platform/x86/steamdeck.c | 523 +++++++++++++++++++++++++++++++
>  3 files changed, 540 insertions(+)
>  create mode 100644 drivers/platform/x86/steamdeck.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index c23612d98126..86f014e78a6e 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1136,6 +1136,21 @@ config SIEMENS_SIMATIC_IPC
>  =09  To compile this driver as a module, choose M here: the module
>  =09  will be called simatic-ipc.
>
> +config STEAMDECK
> +       tristate "Valve Steam Deck platform driver"
> +       depends on X86_64

Should ACPI, EXTCON, HWMON, etc. be also listed here?
E.g. if EXTCON is not available, then `devm_extcon_dev_allocate()` will fai=
l
with ENOSYS and the driver cannot be loaded.


> +       help
> +         Driver exposing various bits and pieces of functionality
> +=09 provided by Steam Deck specific VLV0100 device presented by
> +=09 EC firmware. This includes but not limited to:
> +=09     - CPU/device's fan control
> +=09     - Read-only access to DDIC registers
> +=09     - Battery tempreature measurements
> +=09     - Various display related control knobs
> +=09     - USB Type-C connector event notification
> +
> +=09 Say N unless you are running on a Steam Deck.
> +
>  endif # X86_PLATFORM_DEVICES
>
>  config PMC_ATOM
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index c12a9b044fd8..2eb965e14ced 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -129,3 +129,5 @@ obj-$(CONFIG_PMC_ATOM)=09=09=09+=3D pmc_atom.o
>
>  # Siemens Simatic Industrial PCs
>  obj-$(CONFIG_SIEMENS_SIMATIC_IPC)=09+=3D simatic-ipc.o
> +
> +obj-$(CONFIG_STEAMDECK)=09=09=09+=3D steamdeck.o
> diff --git a/drivers/platform/x86/steamdeck.c b/drivers/platform/x86/stea=
mdeck.c
> new file mode 100644
> index 000000000000..77a6677ec19e
> --- /dev/null
> +++ b/drivers/platform/x86/steamdeck.c
> @@ -0,0 +1,523 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * Steam Deck ACPI platform driver
> + *
> + * Copyright (C) 2021-2022 Valve Corporation
> + *
> + */
> +#include <linux/acpi.h>
> +#include <linux/hwmon.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/extcon-provider.h>
> +
> +#define ACPI_STEAMDECK_NOTIFY_STATUS=090x80
> +
> +/* 0 - port connected, 1 -port disconnected */
> +#define ACPI_STEAMDECK_PORT_CONNECT=09BIT(0)
> +/* 0 - Upstream Facing Port, 1 - Downdstream Facing Port */
> +#define ACPI_STEAMDECK_CUR_DATA_ROLE=09BIT(3)
> +/*
> + * Debouncing delay to allow negotiation process to settle. 2s value
> + * was arrived at via trial and error.
> + */
> +#define STEAMDECK_ROLE_SWITCH_DELAY=09(msecs_to_jiffies(2000))
> +
> +struct steamdeck {
> +=09struct acpi_device *adev;
> +=09struct device *hwmon;
> +=09void *regmap;
> +=09long fan_target;
> +=09struct delayed_work role_work;
> +=09struct extcon_dev *edev;
> +=09struct device *dev;
> +};
> +
> +static ssize_t
> +steamdeck_simple_store(struct device *dev, const char *buf, size_t count=
,
> +=09=09       const char *method,
> +=09=09       unsigned long upper_limit)
> +{
> +=09struct steamdeck *fan =3D dev_get_drvdata(dev);
> +=09unsigned long value;
> +
> +=09if (kstrtoul(buf, 10, &value) || value >=3D upper_limit)

Is it not `value > upper_limit` by design?


> +=09=09return -EINVAL;
> +
> +=09if (ACPI_FAILURE(acpi_execute_simple_method(fan->adev->handle,
> +=09=09=09=09=09=09    (char *)method, value)))
> +=09=09return -EIO;
> +
> +=09return count;
> +}
> +
> +#define STEAMDECK_ATTR_WO(_name, _method, _upper_limit)=09=09=09\
> +=09static ssize_t _name##_store(struct device *dev,=09=09\
> +=09=09=09=09     struct device_attribute *attr,=09\
> +=09=09=09=09     const char *buf, size_t count)=09\
> +=09{=09=09=09=09=09=09=09=09\
> +=09=09return steamdeck_simple_store(dev, buf, count,=09=09\
> +=09=09=09=09=09    _method,=09=09=09\
> +=09=09=09=09=09    _upper_limit);=09=09\
> +=09}=09=09=09=09=09=09=09=09\
> +=09static DEVICE_ATTR_WO(_name)
> +
> +STEAMDECK_ATTR_WO(target_cpu_temp, "STCT", U8_MAX / 2);
> +STEAMDECK_ATTR_WO(gain, "SGAN", U16_MAX);
> +STEAMDECK_ATTR_WO(ramp_rate, "SFRR", U8_MAX);
> +STEAMDECK_ATTR_WO(hysteresis, "SHTS",  U16_MAX);
> +STEAMDECK_ATTR_WO(maximum_battery_charge_rate, "CHGR", U16_MAX);
> +STEAMDECK_ATTR_WO(recalculate, "SCHG", U16_MAX);
> +
> +STEAMDECK_ATTR_WO(led_brightness, "CHBV", U8_MAX);
> +STEAMDECK_ATTR_WO(content_adaptive_brightness, "CABC", U8_MAX);
> +STEAMDECK_ATTR_WO(gamma_set, "GAMA", U8_MAX);
> +STEAMDECK_ATTR_WO(display_brightness, "WDBV", U8_MAX);
> +STEAMDECK_ATTR_WO(ctrl_display, "WCDV", U8_MAX);
> +STEAMDECK_ATTR_WO(cabc_minimum_brightness, "WCMB", U8_MAX);
> +STEAMDECK_ATTR_WO(memory_data_access_control, "MDAC", U8_MAX);
> +
> +#define STEAMDECK_ATTR_WO_NOARG(_name, _method)=09=09=09=09\
> +=09static ssize_t _name##_store(struct device *dev,=09=09\
> +=09=09=09=09     struct device_attribute *attr,=09\
> +=09=09=09=09     const char *buf, size_t count)=09\
> +=09{=09=09=09=09=09=09=09=09\
> +=09=09struct steamdeck *fan =3D dev_get_drvdata(dev);=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09=09if (ACPI_FAILURE(acpi_evaluate_object(fan->adev->handle, \
> +=09=09=09=09=09=09      _method, NULL, NULL))) \
> +=09=09=09return -EIO;=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09=09return count;=09=09=09=09=09=09\
> +=09}=09=09=09=09=09=09=09=09\
> +=09static DEVICE_ATTR_WO(_name)
> +
> +STEAMDECK_ATTR_WO_NOARG(power_cycle_display, "DPCY");
> +STEAMDECK_ATTR_WO_NOARG(display_normal_mode_on, "NORO");
> +STEAMDECK_ATTR_WO_NOARG(display_inversion_off, "INOF");
> +STEAMDECK_ATTR_WO_NOARG(display_inversion_on, "INON");
> +STEAMDECK_ATTR_WO_NOARG(idle_mode_on, "WRNE");
> +
> +#define STEAMDECK_ATTR_RO(_name, _method)=09=09=09=09\
> +=09static ssize_t _name##_show(struct device *dev,=09=09=09\
> +=09=09=09=09    struct device_attribute *attr,=09\
> +=09=09=09=09    char *buf)=09=09=09=09\
> +=09{=09=09=09=09=09=09=09=09\
> +=09=09struct steamdeck *jup =3D dev_get_drvdata(dev);=09=09\

It's a small thing, but I am curious why is it named `jup` here when it is =
mostly
referred to as `sd` in other places?


> +=09=09unsigned long long val;=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09=09if (ACPI_FAILURE(acpi_evaluate_integer(=09=09=09\
> +=09=09=09=09=09 jup->adev->handle,=09=09\
> +=09=09=09=09=09 _method, NULL, &val)))=09=09\
> +=09=09=09return -EIO;=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09\
> +=09=09return sprintf(buf, "%llu\n", val);=09=09=09\

You can use `sysfs_emit()`.


> +=09}=09=09=09=09=09=09=09=09\
> +=09static DEVICE_ATTR_RO(_name)
> +
> +STEAMDECK_ATTR_RO(firmware_version, "PDFW");
> +STEAMDECK_ATTR_RO(board_id, "BOID");
> +STEAMDECK_ATTR_RO(pdcs, "PDCS");
> +
> +static umode_t
> +steamdeck_is_visible(struct kobject *kobj, struct attribute *attr, int i=
ndex)
> +{
> +=09return attr->mode;
> +}
> +
> +static struct attribute *steamdeck_attributes[] =3D {
> +=09&dev_attr_target_cpu_temp.attr,
> +=09&dev_attr_gain.attr,
> +=09&dev_attr_ramp_rate.attr,
> +=09&dev_attr_hysteresis.attr,
> +=09&dev_attr_maximum_battery_charge_rate.attr,
> +=09&dev_attr_recalculate.attr,
> +=09&dev_attr_power_cycle_display.attr,
> +
> +=09&dev_attr_led_brightness.attr,

Have you considered using a led class device instead? I think that should
work even without the ability to query the brightness.


> +=09&dev_attr_content_adaptive_brightness.attr,
> +=09&dev_attr_gamma_set.attr,
> +=09&dev_attr_display_brightness.attr,

Have you considered using a backlight class device?


> +=09&dev_attr_ctrl_display.attr,
> +=09&dev_attr_cabc_minimum_brightness.attr,
> +=09&dev_attr_memory_data_access_control.attr,
> +
> +=09&dev_attr_display_normal_mode_on.attr,
> +=09&dev_attr_display_inversion_off.attr,
> +=09&dev_attr_display_inversion_on.attr,
> +=09&dev_attr_idle_mode_on.attr,
> +
> +=09&dev_attr_firmware_version.attr,
> +=09&dev_attr_board_id.attr,
> +=09&dev_attr_pdcs.attr,
> +
> +=09NULL
> +};
> +
> +static const struct attribute_group steamdeck_group =3D {
> +=09.attrs =3D steamdeck_attributes,
> +=09.is_visible =3D steamdeck_is_visible,
> +};
> +
> +static const struct attribute_group *steamdeck_groups[] =3D {
> +=09&steamdeck_group,
> +=09NULL
> +};
> +
> +static int steamdeck_read_fan_speed(struct steamdeck *jup, long *speed)
> +{
> +=09unsigned long long val;
> +
> +=09if (ACPI_FAILURE(acpi_evaluate_integer(jup->adev->handle,
> +=09=09=09=09=09       "FANR", NULL, &val)))
> +=09=09return -EIO;
> +
> +=09*speed =3D val;
> +=09return 0;
> +}
> +
> +static int
> +steamdeck_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +=09=09     u32 attr, int channel, long *out)
> +{
> +=09struct steamdeck *sd =3D dev_get_drvdata(dev);
> +=09unsigned long long val;
> +
> +=09switch (type) {
> +=09case hwmon_temp:
> +=09=09if (attr !=3D hwmon_temp_input)
> +=09=09=09return -EOPNOTSUPP;
> +
> +=09=09if (ACPI_FAILURE(acpi_evaluate_integer(sd->adev->handle,
> +=09=09=09=09=09=09       "BATT", NULL, &val)))
> +=09=09=09return -EIO;
> +=09=09/*
> +=09=09 * Assuming BATT returns deg C we need to mutiply it
> +=09=09 * by 1000 to convert to mC
> +=09=09 */
> +=09=09*out =3D val * 1000;
> +=09=09break;
> +=09case hwmon_fan:
> +=09=09switch (attr) {
> +=09=09case hwmon_fan_input:
> +=09=09=09return steamdeck_read_fan_speed(sd, out);
> +=09=09case hwmon_fan_target:
> +=09=09=09*out =3D sd->fan_target;
> +=09=09=09break;
> +=09=09case hwmon_fan_fault:
> +=09=09=09if (ACPI_FAILURE(acpi_evaluate_integer(
> +=09=09=09=09=09=09 sd->adev->handle,
> +=09=09=09=09=09=09 "FANC", NULL, &val)))
> +=09=09=09=09return -EIO;
> +=09=09=09/*
> +=09=09=09 * FANC (Fan check):
> +=09=09=09 * 0: Abnormal
> +=09=09=09 * 1: Normal
> +=09=09=09 */
> +=09=09=09*out =3D !val;
> +=09=09=09break;
> +=09=09default:
> +=09=09=09return -EOPNOTSUPP;
> +=09=09}
> +=09=09break;
> +=09default:
> +=09=09return -EOPNOTSUPP;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static int
> +steamdeck_hwmon_read_string(struct device *dev, enum hwmon_sensor_types =
type,
> +=09=09=09    u32 attr, int channel, const char **str)
> +{
> +=09switch (type) {
> +=09case hwmon_temp:
> +=09=09*str =3D "Battery Temp";
> +=09=09break;
> +=09case hwmon_fan:
> +=09=09*str =3D "System Fan";
> +=09=09break;
> +=09default:
> +=09=09return -EOPNOTSUPP;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static int
> +steamdeck_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
> +=09=09      u32 attr, int channel, long val)
> +{
> +=09struct steamdeck *sd =3D dev_get_drvdata(dev);
> +
> +=09if (type !=3D hwmon_fan ||
> +=09    attr !=3D hwmon_fan_target)
> +=09=09return -EOPNOTSUPP;
> +
> +=09if (val > U16_MAX)
> +=09=09return -EINVAL;

What if `val < 0` ?


> +
> +=09sd->fan_target =3D val;
> +
> +=09if (ACPI_FAILURE(acpi_execute_simple_method(sd->adev->handle,
> +=09=09=09=09=09=09    "FANS", val)))
> +=09=09return -EIO;
> +
> +=09return 0;
> +}
> +
> +static umode_t
> +steamdeck_hwmon_is_visible(const void *data, enum hwmon_sensor_types typ=
e,
> +=09=09=09   u32 attr, int channel)
> +{
> +=09if (type =3D=3D hwmon_fan &&
> +=09    attr =3D=3D hwmon_fan_target)
> +=09=09return 0644;
> +
> +=09return 0444;
> +}
> +
> +static const struct hwmon_channel_info *steamdeck_info[] =3D {
> +=09HWMON_CHANNEL_INFO(temp,
> +=09=09=09   HWMON_T_INPUT | HWMON_T_LABEL),
> +=09HWMON_CHANNEL_INFO(fan,
> +=09=09=09   HWMON_F_INPUT | HWMON_F_LABEL |
> +=09=09=09   HWMON_F_TARGET | HWMON_F_FAULT),
> +=09NULL
> +};
> +
> +static const struct hwmon_ops steamdeck_hwmon_ops =3D {
> +=09.is_visible =3D steamdeck_hwmon_is_visible,
> +=09.read =3D steamdeck_hwmon_read,
> +=09.read_string =3D steamdeck_hwmon_read_string,
> +=09.write =3D steamdeck_hwmon_write,
> +};
> +
> +static const struct hwmon_chip_info steamdeck_chip_info =3D {
> +=09.ops =3D &steamdeck_hwmon_ops,
> +=09.info =3D steamdeck_info,
> +};
> +
> +#define STEAMDECK_STA_OK=09=09=09\
> +=09(ACPI_STA_DEVICE_ENABLED |=09=09\
> +=09 ACPI_STA_DEVICE_PRESENT |=09=09\
> +=09 ACPI_STA_DEVICE_FUNCTIONING)
> +
> +static int
> +steamdeck_ddic_reg_read(void *context, unsigned int reg, unsigned int *v=
al)
> +{
> +=09union acpi_object obj =3D { .type =3D ACPI_TYPE_INTEGER };
> +=09struct acpi_object_list arg_list =3D { .count =3D 1, .pointer =3D &ob=
j, };
> +=09struct steamdeck *sd =3D context;
> +=09unsigned long long _val;
> +
> +=09obj.integer.value =3D reg;
> +
> +=09if (ACPI_FAILURE(acpi_evaluate_integer(sd->adev->handle,
> +=09=09=09=09=09       "RDDI", &arg_list, &_val)))
> +=09=09return -EIO;
> +
> +=09*val =3D _val;
> +=09return 0;
> +}
> +
> +static int steamdeck_read_pdcs(struct steamdeck *sd, unsigned long long =
*pdcs)
> +{
> +=09acpi_status status;
> +
> +=09status =3D acpi_evaluate_integer(sd->adev->handle, "PDCS", NULL, pdcs=
);
> +=09if (ACPI_FAILURE(status)) {
> +=09=09dev_err(sd->dev, "PDCS evaluation failed: %s\n",
> +=09=09=09acpi_format_exception(status));
> +=09=09return -EIO;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static void steamdeck_usb_role_work(struct work_struct *work)
> +{
> +=09struct steamdeck *sd =3D
> +=09=09container_of(work, struct steamdeck, role_work.work);
> +=09unsigned long long pdcs;
> +=09bool usb_host;
> +
> +=09if (steamdeck_read_pdcs(sd, &pdcs))
> +=09=09return;
> +
> +=09/*
> +=09 * We only care about these two
> +=09 */
> +=09pdcs &=3D ACPI_STEAMDECK_PORT_CONNECT | ACPI_STEAMDECK_CUR_DATA_ROLE;
> +
> +=09/*
> +=09 * For "connect" events our role is determined by a bit in
> +=09 * PDCS, for "disconnect" we switch to being a gadget
> +=09 * unconditionally. The thinking for the latter is we don't
> +=09 * want to start acting as a USB host until we get
> +=09 * confirmation from the firmware that we are a USB host
> +=09 */
> +=09usb_host =3D (pdcs & ACPI_STEAMDECK_PORT_CONNECT) ?
> +=09=09pdcs & ACPI_STEAMDECK_CUR_DATA_ROLE : false;
> +
> +=09WARN_ON(extcon_set_state_sync(sd->edev, EXTCON_USB_HOST,
> +=09=09=09=09      usb_host));
> +=09dev_dbg(sd->dev, "USB role is %s\n", usb_host ? "host" : "device");
> +}
> +
> +static void steamdeck_notify(acpi_handle handle, u32 event, void *contex=
t)
> +{
> +=09struct device *dev =3D context;
> +=09struct steamdeck *sd =3D dev_get_drvdata(dev);
> +=09unsigned long long pdcs;
> +=09unsigned long delay;
> +
> +=09switch (event) {
> +=09case ACPI_STEAMDECK_NOTIFY_STATUS:
> +=09=09if (steamdeck_read_pdcs(sd, &pdcs))
> +=09=09=09return;
> +=09=09/*
> +=09=09 * We process "disconnect" events immediately and
> +=09=09 * "connect" events with a delay to give the HW time
> +=09=09 * to settle. For example attaching USB hub (at least
> +=09=09 * for HW used for testing) will generate intermediary
> +=09=09 * event with "host" bit not set, followed by the one
> +=09=09 * that does have it set.
> +=09=09 */
> +=09=09delay =3D (pdcs & ACPI_STEAMDECK_PORT_CONNECT) ?
> +=09=09=09STEAMDECK_ROLE_SWITCH_DELAY : 0;
> +
> +=09=09queue_delayed_work(system_long_wq, &sd->role_work, delay);
> +=09=09break;
> +=09default:
> +=09=09dev_err(dev, "Unsupported event [0x%x]\n", event);

Since this is not fatal, I think `dev_warn()` would be better.


> +=09}
> +}
> +
> +static void steamdeck_remove_notify_handler(void *data)
> +{
> +=09struct steamdeck *sd =3D data;
> +
> +=09acpi_remove_notify_handler(sd->adev->handle, ACPI_DEVICE_NOTIFY,
> +=09=09=09=09   steamdeck_notify);
> +=09cancel_delayed_work_sync(&sd->role_work);
> +}
> +
> +static const unsigned int steamdeck_extcon_cable[] =3D {
> +=09EXTCON_USB,
> +=09EXTCON_USB_HOST,
> +=09EXTCON_CHG_USB_SDP,
> +=09EXTCON_CHG_USB_CDP,
> +=09EXTCON_CHG_USB_DCP,
> +=09EXTCON_CHG_USB_ACA,
> +=09EXTCON_NONE,
> +};
> +
> +static int steamdeck_probe(struct platform_device *pdev)
> +{
> +=09struct device *dev =3D &pdev->dev;
> +=09struct steamdeck *sd;
> +=09acpi_status status;
> +=09unsigned long long sta;
> +=09int ret;
> +
> +=09static const struct regmap_config regmap_config =3D {
> +=09=09.reg_bits =3D 8,
> +=09=09.val_bits =3D 8,
> +=09=09.max_register =3D 255,
> +=09=09.cache_type =3D REGCACHE_NONE,
> +=09=09.reg_read =3D steamdeck_ddic_reg_read,
> +=09};
> +
> +=09sd =3D devm_kzalloc(dev, sizeof(*sd), GFP_KERNEL);
> +=09if (!sd)
> +=09=09return -ENOMEM;
> +=09sd->adev =3D ACPI_COMPANION(&pdev->dev);
> +=09sd->dev =3D dev;
> +=09platform_set_drvdata(pdev, sd);
> +=09INIT_DELAYED_WORK(&sd->role_work, steamdeck_usb_role_work);
> +
> +=09status =3D acpi_evaluate_integer(sd->adev->handle, "_STA",
> +=09=09=09=09       NULL, &sta);
> +=09if (ACPI_FAILURE(status)) {
> +=09=09dev_err(dev, "Status check failed (0x%x)\n", status);
> +=09=09return -EINVAL;
> +=09}
> +
> +=09if ((sta & STEAMDECK_STA_OK) !=3D STEAMDECK_STA_OK) {
> +=09=09dev_err(dev, "Device is not ready\n");
> +=09=09return -EINVAL;
> +=09}
> +
> +=09/*
> +=09 * Our ACPI interface doesn't expose a method to read current
> +=09 * fan target, so we use current fan speed as an
> +=09 * approximation.
> +=09 */
> +=09if (steamdeck_read_fan_speed(sd, &sd->fan_target))
> +=09=09dev_warn(dev, "Failed to read fan speed");
> +
> +=09sd->hwmon =3D devm_hwmon_device_register_with_info(dev,
> +=09=09=09=09=09=09=09 "steamdeck",
> +=09=09=09=09=09=09=09 sd,
> +=09=09=09=09=09=09=09 &steamdeck_chip_info,
> +=09=09=09=09=09=09=09 steamdeck_groups);
> +=09if (IS_ERR(sd->hwmon)) {
> +=09=09dev_err(dev, "Failed to register HWMON device");
> +=09=09return PTR_ERR(sd->hwmon);
> +=09}
> +
> +=09sd->regmap =3D devm_regmap_init(dev, NULL, sd, &regmap_config);
> +=09if (IS_ERR(sd->regmap))
> +=09=09dev_err(dev, "Failed to register REGMAP");
> +
> +=09sd->edev =3D devm_extcon_dev_allocate(dev, steamdeck_extcon_cable);
> +=09if (IS_ERR(sd->edev))
> +=09=09return -ENOMEM;

Maybe

  return PTR_ERR(sd->edev)

would be better?


> +
> +=09ret =3D devm_extcon_dev_register(dev, sd->edev);
> +=09if (ret < 0) {
> +=09=09dev_err(dev, "Failed to register extcon device: %d\n", ret);
> +=09=09return ret;
> +=09}
> +
> +=09/*
> +=09 * Set initial role value
> +=09 */
> +=09queue_delayed_work(system_long_wq, &sd->role_work, 0);
> +=09flush_delayed_work(&sd->role_work);
> +
> +=09status =3D acpi_install_notify_handler(sd->adev->handle,
> +=09=09=09=09=09     ACPI_DEVICE_NOTIFY,
> +=09=09=09=09=09     steamdeck_notify,
> +=09=09=09=09=09     dev);
> +=09if (ACPI_FAILURE(status)) {
> +=09=09dev_err(dev, "Error installing ACPI notify handler\n");
> +=09=09return -EIO;
> +=09}
> +
> +=09ret =3D devm_add_action_or_reset(dev, steamdeck_remove_notify_handler=
,
> +=09=09=09=09       sd);
> +=09return ret;
> +}
> +
> +static const struct acpi_device_id steamdeck_device_ids[] =3D {
> +=09{ "VLV0100", 0 },
> +=09{ "", 0 },
> +};
> +MODULE_DEVICE_TABLE(acpi, steamdeck_device_ids);
> +
> +static struct platform_driver steamdeck_driver =3D {
> +=09.probe =3D steamdeck_probe,
> +=09.driver =3D {
> +=09=09.name =3D "steamdeck",
> +=09=09.acpi_match_table =3D steamdeck_device_ids,
> +=09},
> +};
> +module_platform_driver(steamdeck_driver);
> +
> +MODULE_AUTHOR("Andrey Smirnov <andrew.smirnov@gmail.com>");
> +MODULE_DESCRIPTION("Steam Deck ACPI platform driver");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1
>


Regards,
Barnab=C3=A1s P=C5=91cze
