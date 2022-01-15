Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003FA48F6DD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 13:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiAOMdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 07:33:21 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:39142 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiAOMdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 07:33:19 -0500
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 60ACAD61A7C;
        Sat, 15 Jan 2022 13:33:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1642249997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6DDMq+kOIM3eBMuExHo6fnz97SHa50JInjXzsuEnUY=;
        b=FJK+sKn+te4/LKJ2ojErjnythnO7RtQhXkWSz3pZY/uwfLdZRUwGsET+hiiaTtXO9kBzJl
        MiFSoaoxzuCTOGA8bFPk/IqtFjWJAMmKsDfhKXVgXuGxtw2zJJdgoRQUQC35Khd9JYGjxU
        cARvQajQDIA1UYlFjW8lsEMwzmlb8lU=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-hwmon@vger.kernel.org, Zev Weiss <zev@bewilderbeest.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        linux-kernel@vger.kernel.org, Zev Weiss <zev@bewilderbeest.net>,
        Renze Nicolai <renze@rnplus.nl>
Subject: Re: [PATCH v4] hwmon: (nct6775) add support for TSI temperature registers
Date:   Sat, 15 Jan 2022 13:33:15 +0100
Message-ID: <5531877.DvuYhMxLoT@natalenko.name>
In-Reply-To: <20220113164629.21924-1-zev@bewilderbeest.net>
References: <20220113164629.21924-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =C4=8Dtvrtek 13. ledna 2022 17:46:29 CET Zev Weiss wrote:
> These registers report CPU temperatures (and, depending on the system,
> sometimes chipset temperatures) via the TSI interface on AMD systems.
> They're distinct from most of the other Super-IO temperature readings
> (CPUTIN, SYSTIN, etc.) in that they're not a selectable source for
> monitoring and are in a different (higher resolution) format, but can
> still provide useful temperature data.
>=20
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Tested-by: Renze Nicolai <renze@rnplus.nl>
> ---
>=20
> This patch has been tested on NCT6779 and NCT6798[0] hardware on
> (respectively) ASRock Rack ROMED8HM3 and X570D4U boards, and seems to
> work as expected; the implementation for the other chips supported by
> the driver is purely based on the datasheets and has not been tested
> (for lack of available hardware).
>=20
> [0] Or at least, its chip ID registers identify it as an NCT6798 and
> it seems to behave consistently with that, though it's actually
> physically labeled as an NCT6796.
>=20
> Changes since v3 [1]:
>  - removed "unknown number of TSI temp registers" warning
>=20
> Changes since v2 [2]:
>  - fixed a pair of <=3D that should have been < in is_word_sized()
>  - fixed nct6116 switch case mistakenly referencing NCT6106_REG_TSI_TEMP
>=20
> Changes since v1 [3]:
>  - simplified logic in is_word_sized()
>=20
> [1] https://lore.kernel.org/linux-hwmon/20220112034824.3467-1-zev@bewilde=
rbeest.net/
> [2] https://lore.kernel.org/linux-hwmon/20211226051438.5081-1-zev@bewilde=
rbeest.net/
> [3] https://lore.kernel.org/linux-hwmon/Yb7RVu6fQc+tLIAg@hatter.bewilderb=
eest.net/
>=20
>  drivers/hwmon/nct6775.c | 129 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 123 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index fd3f91cb01c6..6c1ad82ad54b 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -308,6 +308,7 @@ static void superio_exit(struct nct6775_sio_data *sio=
_data)
> =20
>  #define NUM_TEMP	10	/* Max number of temp attribute sets w/ limits*/
>  #define NUM_TEMP_FIXED	6	/* Max number of fixed temp attribute sets */
> +#define NUM_TSI_TEMP	8	/* Max number of TSI temp register pairs */
> =20
>  #define NUM_REG_ALARM	7	/* Max number of alarm registers */
>  #define NUM_REG_BEEP	5	/* Max number of beep registers */
> @@ -498,6 +499,8 @@ static const u16 NCT6775_REG_TEMP_CRIT[32] =3D {
>  	[11] =3D 0xa07
>  };
> =20
> +static const u16 NCT6775_REG_TSI_TEMP[] =3D { 0x669 };
> +
>  /* NCT6776 specific data */
> =20
>  /* STEP_UP_TIME and STEP_DOWN_TIME regs are swapped for all chips but NC=
T6775 */
> @@ -581,6 +584,9 @@ static const u16 NCT6776_REG_TEMP_CRIT[32] =3D {
>  	[12] =3D 0x70a,
>  };
> =20
> +static const u16 NCT6776_REG_TSI_TEMP[] =3D {
> +	0x409, 0x40b, 0x40d, 0x40f, 0x411, 0x413, 0x415, 0x417 };
> +
>  /* NCT6779 specific data */
> =20
>  static const u16 NCT6779_REG_IN[] =3D {
> @@ -864,6 +870,8 @@ static const char *const nct6796_temp_label[] =3D {
>  #define NCT6796_TEMP_MASK	0xbfff0ffe
>  #define NCT6796_VIRT_TEMP_MASK	0x80000c00
> =20
> +static const u16 NCT6796_REG_TSI_TEMP[] =3D { 0x409, 0x40b };
> +
>  static const char *const nct6798_temp_label[] =3D {
>  	"",
>  	"SYSTIN",
> @@ -1005,6 +1013,8 @@ static const u16 NCT6106_REG_TEMP_CRIT[32] =3D {
>  	[12] =3D 0x205,
>  };
> =20
> +static const u16 NCT6106_REG_TSI_TEMP[] =3D { 0x59, 0x5b, 0x5d, 0x5f, 0x=
61, 0x63, 0x65, 0x67 };
> +
>  /* NCT6112D/NCT6114D/NCT6116D specific data */
> =20
>  static const u16 NCT6116_REG_FAN[] =3D { 0x20, 0x22, 0x24, 0x26, 0x28 };
> @@ -1069,6 +1079,8 @@ static const s8 NCT6116_BEEP_BITS[] =3D {
>  	34, -1				/* intrusion0, intrusion1 */
>  };
> =20
> +static const u16 NCT6116_REG_TSI_TEMP[] =3D { 0x59, 0x5b };
> +
>  static enum pwm_enable reg_to_pwm_enable(int pwm, int mode)
>  {
>  	if (mode =3D=3D 0 && pwm =3D=3D 255)
> @@ -1169,6 +1181,12 @@ static inline u8 in_to_reg(u32 val, u8 nr)
>  	return clamp_val(DIV_ROUND_CLOSEST(val * 100, scale_in[nr]), 0, 255);
>  }
> =20
> +/* TSI temperatures are in 8.3 format */
> +static inline unsigned int tsi_temp_from_reg(unsigned int reg)
> +{
> +	return (reg >> 5) * 125;
> +}
> +
>  /*
>   * Data structures and manipulation thereof
>   */
> @@ -1179,7 +1197,7 @@ struct nct6775_data {
>  	enum kinds kind;
>  	const char *name;
> =20
> -	const struct attribute_group *groups[6];
> +	const struct attribute_group *groups[7];
> =20
>  	u16 reg_temp[5][NUM_TEMP]; /* 0=3Dtemp, 1=3Dtemp_over, 2=3Dtemp_hyst,
>  				    * 3=3Dtemp_crit, 4=3Dtemp_lcrit
> @@ -1240,6 +1258,8 @@ struct nct6775_data {
>  	const u16 *REG_ALARM;
>  	const u16 *REG_BEEP;
> =20
> +	const u16 *REG_TSI_TEMP;
> +
>  	unsigned int (*fan_from_reg)(u16 reg, unsigned int divreg);
>  	unsigned int (*fan_from_reg_min)(u16 reg, unsigned int divreg);
> =20
> @@ -1267,6 +1287,7 @@ struct nct6775_data {
>  	s8 temp_offset[NUM_TEMP_FIXED];
>  	s16 temp[5][NUM_TEMP]; /* 0=3Dtemp, 1=3Dtemp_over, 2=3Dtemp_hyst,
>  				* 3=3Dtemp_crit, 4=3Dtemp_lcrit */
> +	s16 tsi_temp[NUM_TSI_TEMP];
>  	u64 alarms;
>  	u64 beeps;
> =20
> @@ -1315,6 +1336,7 @@ struct nct6775_data {
> =20
>  	u16 have_temp;
>  	u16 have_temp_fixed;
> +	u16 have_tsi_temp;
>  	u16 have_in;
> =20
>  	/* Remember extra register values over suspend/resume */
> @@ -1464,13 +1486,15 @@ static bool is_word_sized(struct nct6775_data *da=
ta, u16 reg)
>  	switch (data->kind) {
>  	case nct6106:
>  		return reg =3D=3D 0x20 || reg =3D=3D 0x22 || reg =3D=3D 0x24 ||
> +		  (reg >=3D 0x59 && reg < 0x69 && (reg & 1)) ||
>  		  reg =3D=3D 0xe0 || reg =3D=3D 0xe2 || reg =3D=3D 0xe4 ||
>  		  reg =3D=3D 0x111 || reg =3D=3D 0x121 || reg =3D=3D 0x131;
>  	case nct6116:
>  		return reg =3D=3D 0x20 || reg =3D=3D 0x22 || reg =3D=3D 0x24 ||
> -		  reg =3D=3D 0x26 || reg =3D=3D 0x28 || reg =3D=3D 0xe0 || reg =3D=3D =
0xe2 ||
> -		  reg =3D=3D 0xe4 || reg =3D=3D 0xe6 || reg =3D=3D 0xe8 || reg =3D=3D =
0x111 ||
> -		  reg =3D=3D 0x121 || reg =3D=3D 0x131 || reg =3D=3D 0x191 || reg =3D=
=3D 0x1a1;
> +		  reg =3D=3D 0x26 || reg =3D=3D 0x28 || reg =3D=3D 0x59 || reg =3D=3D =
0x5b ||
> +		  reg =3D=3D 0xe0 || reg =3D=3D 0xe2 || reg =3D=3D 0xe4 || reg =3D=3D =
0xe6 ||
> +		  reg =3D=3D 0xe8 || reg =3D=3D 0x111 || reg =3D=3D 0x121 || reg =3D=
=3D 0x131 ||
> +		  reg =3D=3D 0x191 || reg =3D=3D 0x1a1;
>  	case nct6775:
>  		return (((reg & 0xff00) =3D=3D 0x100 ||
>  		    (reg & 0xff00) =3D=3D 0x200) &&
> @@ -1479,7 +1503,7 @@ static bool is_word_sized(struct nct6775_data *data=
, u16 reg)
>  		    (reg & 0x00ff) =3D=3D 0x55)) ||
>  		  (reg & 0xfff0) =3D=3D 0x630 ||
>  		  reg =3D=3D 0x640 || reg =3D=3D 0x642 ||
> -		  reg =3D=3D 0x662 ||
> +		  reg =3D=3D 0x662 || reg =3D=3D 0x669 ||
>  		  ((reg & 0xfff0) =3D=3D 0x650 && (reg & 0x000f) >=3D 0x06) ||
>  		  reg =3D=3D 0x73 || reg =3D=3D 0x75 || reg =3D=3D 0x77;
>  	case nct6776:
> @@ -1490,6 +1514,7 @@ static bool is_word_sized(struct nct6775_data *data=
, u16 reg)
>  		    (reg & 0x00ff) =3D=3D 0x55)) ||
>  		  (reg & 0xfff0) =3D=3D 0x630 ||
>  		  reg =3D=3D 0x402 ||
> +		  (reg >=3D 0x409 && reg < 0x419 && (reg & 1)) ||
>  		  reg =3D=3D 0x640 || reg =3D=3D 0x642 ||
>  		  ((reg & 0xfff0) =3D=3D 0x650 && (reg & 0x000f) >=3D 0x06) ||
>  		  reg =3D=3D 0x73 || reg =3D=3D 0x75 || reg =3D=3D 0x77;
> @@ -1504,6 +1529,7 @@ static bool is_word_sized(struct nct6775_data *data=
, u16 reg)
>  		return reg =3D=3D 0x150 || reg =3D=3D 0x153 || reg =3D=3D 0x155 ||
>  		  (reg & 0xfff0) =3D=3D 0x4c0 ||
>  		  reg =3D=3D 0x402 ||
> +		  (reg >=3D 0x409 && reg < 0x419 && (reg & 1)) ||
>  		  reg =3D=3D 0x63a || reg =3D=3D 0x63c || reg =3D=3D 0x63e ||
>  		  reg =3D=3D 0x640 || reg =3D=3D 0x642 || reg =3D=3D 0x64a ||
>  		  reg =3D=3D 0x64c ||
> @@ -1987,6 +2013,12 @@ static struct nct6775_data *nct6775_update_device(=
struct device *dev)
>  								   data->REG_TEMP_OFFSET[i]);
>  		}
> =20
> +		for (i =3D 0; i < NUM_TSI_TEMP; i++) {
> +			if (!(data->have_tsi_temp & BIT(i)))
> +				continue;
> +			data->tsi_temp[i] =3D data->read_value(data, data->REG_TSI_TEMP[i]);
> +		}
> +
>  		data->alarms =3D 0;
>  		for (i =3D 0; i < NUM_REG_ALARM; i++) {
>  			u8 alarm;
> @@ -2670,6 +2702,44 @@ static const struct sensor_template_group nct6775_=
temp_template_group =3D {
>  	.base =3D 1,
>  };
> =20
> +static ssize_t show_tsi_temp(struct device *dev, struct device_attribute=
 *attr, char *buf)
> +{
> +	struct nct6775_data *data =3D nct6775_update_device(dev);
> +	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
> +
> +	return sysfs_emit(buf, "%u\n", tsi_temp_from_reg(data->tsi_temp[sattr->=
index]));
> +}
> +
> +static ssize_t show_tsi_temp_label(struct device *dev, struct device_att=
ribute *attr, char *buf)
> +{
> +	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
> +
> +	return sysfs_emit(buf, "TSI%d_TEMP\n", sattr->index);
> +}
> +
> +SENSOR_TEMPLATE(tsi_temp_input, "temp%d_input", 0444, show_tsi_temp, NUL=
L, 0);
> +SENSOR_TEMPLATE(tsi_temp_label, "temp%d_label", 0444, show_tsi_temp_labe=
l, NULL, 0);
> +
> +static umode_t nct6775_tsi_temp_is_visible(struct kobject *kobj, struct =
attribute *attr,
> +					       int index)
> +{
> +	struct device *dev =3D kobj_to_dev(kobj);
> +	struct nct6775_data *data =3D dev_get_drvdata(dev);
> +	int temp =3D index / 2;
> +
> +	return (data->have_tsi_temp & BIT(temp)) ? attr->mode : 0;
> +}
> +
> +/*
> + * The index calculation in nct6775_tsi_temp_is_visible() must be kept in
> + * sync with the size of this array.
> + */
> +static struct sensor_device_template *nct6775_tsi_temp_template[] =3D {
> +	&sensor_dev_template_tsi_temp_input,
> +	&sensor_dev_template_tsi_temp_label,
> +	NULL
> +};
> +
>  static ssize_t
>  show_pwm_mode(struct device *dev, struct device_attribute *attr, char *b=
uf)
>  {
> @@ -3948,10 +4018,11 @@ static int nct6775_probe(struct platform_device *=
pdev)
>  	const u16 *reg_temp, *reg_temp_over, *reg_temp_hyst, *reg_temp_config;
>  	const u16 *reg_temp_mon, *reg_temp_alternate, *reg_temp_crit;
>  	const u16 *reg_temp_crit_l =3D NULL, *reg_temp_crit_h =3D NULL;
> -	int num_reg_temp, num_reg_temp_mon;
> +	int num_reg_temp, num_reg_temp_mon, num_reg_tsi_temp;
>  	u8 cr2a;
>  	struct attribute_group *group;
>  	struct device *hwmon_dev;
> +	struct sensor_template_group tsi_temp_tg;
>  	int num_attr_groups =3D 0;
> =20
>  	if (sio_data->access =3D=3D access_direct) {
> @@ -4043,11 +4114,13 @@ static int nct6775_probe(struct platform_device *=
pdev)
>  		data->ALARM_BITS =3D NCT6106_ALARM_BITS;
>  		data->REG_BEEP =3D NCT6106_REG_BEEP;
>  		data->BEEP_BITS =3D NCT6106_BEEP_BITS;
> +		data->REG_TSI_TEMP =3D NCT6106_REG_TSI_TEMP;
> =20
>  		reg_temp =3D NCT6106_REG_TEMP;
>  		reg_temp_mon =3D NCT6106_REG_TEMP_MON;
>  		num_reg_temp =3D ARRAY_SIZE(NCT6106_REG_TEMP);
>  		num_reg_temp_mon =3D ARRAY_SIZE(NCT6106_REG_TEMP_MON);
> +		num_reg_tsi_temp =3D ARRAY_SIZE(NCT6106_REG_TSI_TEMP);
>  		reg_temp_over =3D NCT6106_REG_TEMP_OVER;
>  		reg_temp_hyst =3D NCT6106_REG_TEMP_HYST;
>  		reg_temp_config =3D NCT6106_REG_TEMP_CONFIG;
> @@ -4116,11 +4189,13 @@ static int nct6775_probe(struct platform_device *=
pdev)
>  		data->ALARM_BITS =3D NCT6116_ALARM_BITS;
>  		data->REG_BEEP =3D NCT6106_REG_BEEP;
>  		data->BEEP_BITS =3D NCT6116_BEEP_BITS;
> +		data->REG_TSI_TEMP =3D NCT6116_REG_TSI_TEMP;
> =20
>  		reg_temp =3D NCT6106_REG_TEMP;
>  		reg_temp_mon =3D NCT6106_REG_TEMP_MON;
>  		num_reg_temp =3D ARRAY_SIZE(NCT6106_REG_TEMP);
>  		num_reg_temp_mon =3D ARRAY_SIZE(NCT6106_REG_TEMP_MON);
> +		num_reg_tsi_temp =3D ARRAY_SIZE(NCT6116_REG_TSI_TEMP);
>  		reg_temp_over =3D NCT6106_REG_TEMP_OVER;
>  		reg_temp_hyst =3D NCT6106_REG_TEMP_HYST;
>  		reg_temp_config =3D NCT6106_REG_TEMP_CONFIG;
> @@ -4191,11 +4266,13 @@ static int nct6775_probe(struct platform_device *=
pdev)
>  		data->REG_WEIGHT_TEMP[2] =3D NCT6775_REG_WEIGHT_TEMP_BASE;
>  		data->REG_ALARM =3D NCT6775_REG_ALARM;
>  		data->REG_BEEP =3D NCT6775_REG_BEEP;
> +		data->REG_TSI_TEMP =3D NCT6775_REG_TSI_TEMP;
> =20
>  		reg_temp =3D NCT6775_REG_TEMP;
>  		reg_temp_mon =3D NCT6775_REG_TEMP_MON;
>  		num_reg_temp =3D ARRAY_SIZE(NCT6775_REG_TEMP);
>  		num_reg_temp_mon =3D ARRAY_SIZE(NCT6775_REG_TEMP_MON);
> +		num_reg_tsi_temp =3D ARRAY_SIZE(NCT6775_REG_TSI_TEMP);
>  		reg_temp_over =3D NCT6775_REG_TEMP_OVER;
>  		reg_temp_hyst =3D NCT6775_REG_TEMP_HYST;
>  		reg_temp_config =3D NCT6775_REG_TEMP_CONFIG;
> @@ -4264,11 +4341,13 @@ static int nct6775_probe(struct platform_device *=
pdev)
>  		data->REG_WEIGHT_TEMP[2] =3D NCT6775_REG_WEIGHT_TEMP_BASE;
>  		data->REG_ALARM =3D NCT6775_REG_ALARM;
>  		data->REG_BEEP =3D NCT6776_REG_BEEP;
> +		data->REG_TSI_TEMP =3D NCT6776_REG_TSI_TEMP;
> =20
>  		reg_temp =3D NCT6775_REG_TEMP;
>  		reg_temp_mon =3D NCT6775_REG_TEMP_MON;
>  		num_reg_temp =3D ARRAY_SIZE(NCT6775_REG_TEMP);
>  		num_reg_temp_mon =3D ARRAY_SIZE(NCT6775_REG_TEMP_MON);
> +		num_reg_tsi_temp =3D ARRAY_SIZE(NCT6776_REG_TSI_TEMP);
>  		reg_temp_over =3D NCT6775_REG_TEMP_OVER;
>  		reg_temp_hyst =3D NCT6775_REG_TEMP_HYST;
>  		reg_temp_config =3D NCT6776_REG_TEMP_CONFIG;
> @@ -4341,11 +4420,13 @@ static int nct6775_probe(struct platform_device *=
pdev)
>  		data->REG_WEIGHT_TEMP[2] =3D NCT6775_REG_WEIGHT_TEMP_BASE;
>  		data->REG_ALARM =3D NCT6779_REG_ALARM;
>  		data->REG_BEEP =3D NCT6776_REG_BEEP;
> +		data->REG_TSI_TEMP =3D NCT6776_REG_TSI_TEMP;
> =20
>  		reg_temp =3D NCT6779_REG_TEMP;
>  		reg_temp_mon =3D NCT6779_REG_TEMP_MON;
>  		num_reg_temp =3D ARRAY_SIZE(NCT6779_REG_TEMP);
>  		num_reg_temp_mon =3D ARRAY_SIZE(NCT6779_REG_TEMP_MON);
> +		num_reg_tsi_temp =3D ARRAY_SIZE(NCT6776_REG_TSI_TEMP);
>  		reg_temp_over =3D NCT6779_REG_TEMP_OVER;
>  		reg_temp_hyst =3D NCT6779_REG_TEMP_HYST;
>  		reg_temp_config =3D NCT6779_REG_TEMP_CONFIG;
> @@ -4460,6 +4541,24 @@ static int nct6775_probe(struct platform_device *p=
dev)
>  			data->REG_BEEP =3D NCT6776_REG_BEEP;
>  		else
>  			data->REG_BEEP =3D NCT6792_REG_BEEP;
> +		switch (data->kind) {
> +		case nct6791:
> +		case nct6792:
> +		case nct6793:
> +			data->REG_TSI_TEMP =3D NCT6776_REG_TSI_TEMP;
> +			num_reg_tsi_temp =3D ARRAY_SIZE(NCT6776_REG_TSI_TEMP);
> +			break;
> +		case nct6795:
> +		case nct6796:
> +		case nct6797:
> +		case nct6798:
> +			data->REG_TSI_TEMP =3D NCT6796_REG_TSI_TEMP;
> +			num_reg_tsi_temp =3D ARRAY_SIZE(NCT6796_REG_TSI_TEMP);
> +			break;
> +		default:
> +			num_reg_tsi_temp =3D 0;
> +			break;
> +		}
> =20
>  		reg_temp =3D NCT6779_REG_TEMP;
>  		num_reg_temp =3D ARRAY_SIZE(NCT6779_REG_TEMP);
> @@ -4659,6 +4758,12 @@ static int nct6775_probe(struct platform_device *p=
dev)
>  	}
>  #endif /* USE_ALTERNATE */
> =20
> +	/* Check which TSIx_TEMP registers are active */
> +	for (i =3D 0; i < num_reg_tsi_temp; i++) {
> +		if (data->read_value(data, data->REG_TSI_TEMP[i]))
> +			data->have_tsi_temp |=3D BIT(i);
> +	}
> +
>  	/* Initialize the chip */
>  	nct6775_init_device(data);
> =20
> @@ -4766,6 +4871,18 @@ static int nct6775_probe(struct platform_device *p=
dev)
>  		return PTR_ERR(group);
> =20
>  	data->groups[num_attr_groups++] =3D group;
> +
> +	if (data->have_tsi_temp) {
> +		tsi_temp_tg.templates =3D nct6775_tsi_temp_template;
> +		tsi_temp_tg.is_visible =3D nct6775_tsi_temp_is_visible;
> +		tsi_temp_tg.base =3D fls(data->have_temp) + 1;
> +		group =3D nct6775_create_attr_group(dev, &tsi_temp_tg, fls(data->have_=
tsi_temp));
> +		if (IS_ERR(group))
> +			return PTR_ERR(group);
> +
> +		data->groups[num_attr_groups++] =3D group;
> +	}
> +
>  	data->groups[num_attr_groups++] =3D &nct6775_group_other;
> =20
>  	hwmon_dev =3D devm_hwmon_device_register_with_groups(dev, data->name,
>=20

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

on ASUS Pro WS X570-ACE.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


