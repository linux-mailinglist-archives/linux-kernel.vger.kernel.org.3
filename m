Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564E447E438
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348687AbhLWNtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348462AbhLWNtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:49:21 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E36C061401;
        Thu, 23 Dec 2021 05:49:21 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o20so21601282eds.10;
        Thu, 23 Dec 2021 05:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a8pc21NkSc/1sCf2TbA3e1Z5LfEUCkCCBQTMJnlLoNU=;
        b=MlPiAz1j1q137dLS0ou/iOZ8j2sb9j+FoPMuv5cPEalQkl+1G/Cphdksmx+0PNv2ZQ
         ltmcmwBXRlOD+Shts177/Ua+TPy46LxlBEoSjthgoMgEDsOJ0dMNp20rzaq0As28v6la
         3vL1HR5Kye7CanKNiZjrYCNOKXBwveLfaiB6Mvs1eHn1hEHnNd+7KEecDRJZwnHdcyND
         d7Dr6hQslwsuqmtjM1ZsVv3dMppHSWqDV5acjrkdeU5yRNsem3RjUYqpby4fbCbYDiQp
         Qj1i/nO4w3OUBQmiPtedZtjQherkWqbwl2fT/6N6IOtbqrcwCesyz7YKtOraXwpBMvXU
         KAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a8pc21NkSc/1sCf2TbA3e1Z5LfEUCkCCBQTMJnlLoNU=;
        b=AT1+JElglHf1LljwcqLx2Y3h89qYNqYg1MPb2il/l0UerKhcVty+Wql4+DD4neMdkS
         J6MawKUcTrxG2sHsAqzh7Lal7ggE7ztieI6T5iczCURvoxj5XTHLaSjlG6oSrXKwa2zj
         Mw3jQG/r64ZZagFhrPFAdHnyWvKoGLnuhK8mqtvM0LdsmN4b8i636wRAwVapPjv4z+O/
         HuAmHWkwATfwuPHSWzvcm8NNMy75ql3Vs3JztxjE/eGh0PboUB0RmP4JDn3pqeqM3dFS
         vxMZkbt+7D8M77X68yhq7SgQab031OAtUQ1XwPNWFgjboAuC4DS/LAsSPnrTme5FEKAf
         KR0Q==
X-Gm-Message-State: AOAM530QRc7hle0dHN2HuCUTO1kNszNUjvyLwi7ppiHZYaw3F+hZMG1a
        apazKVJkMRhoFrchjqXOcIPrVrVVUyc+6pKsE0M=
X-Google-Smtp-Source: ABdhPJxlsb5v3IhopSwVLpzCwHp9U0/e5ndeOfRq99xX+XKquRHnKZJ7DS7/snud0hf9IBRDQeQpt7AWuUOngLwhlnc=
X-Received: by 2002:a17:907:76d4:: with SMTP id kf20mr2004519ejc.44.1640267360008;
 Thu, 23 Dec 2021 05:49:20 -0800 (PST)
MIME-Version: 1.0
References: <20211103114830.62711-1-alistair@alistair23.me> <20211103114830.62711-2-alistair@alistair23.me>
In-Reply-To: <20211103114830.62711-2-alistair@alistair23.me>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Dec 2021 15:47:21 +0200
Message-ID: <CAHp75Ve3zbbgYQvt2inETv_yuwwQBeG9+sG20e5bjwPigq+4tA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Input: Add driver for Cypress Generation 5 touchscreen
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mylene Josserand <mylene.josserand@free-electrons.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alistair Francis <alistair23@gmail.com>,
        =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 1:49 PM Alistair Francis <alistair@alistair23.me> wr=
ote:

...

> Message-Id: <20180703094309.18514-2-mylene.josserand@bootlin.com>

What is this?

...

> +config TOUCHSCREEN_CYTTSP5
> +       tristate "Cypress TrueTouch Gen5 Touchscreen Driver"

> +       depends on OF && I2C

Is it really OF dependent?

> +       select REGMAP_I2C
> +       select CRC_ITU_T
> +       help
> +         Driver for Parade TrueTouch Standard Product
> +         Generation 5 touchscreen controllers.
> +         I2C bus interface support only.
> +         Say Y here if you have a Cypress Gen5 touchscreen.
> +         If unsure, say N.
> +         To compile this driver as a module, choose M here: the
> +         module will be called cyttsp5.

Utilize lines better, i.e. increase density of the words on them.

...

> +/*
> + * Parade TrueTouch(TM) Standard Product V5 Module.
> + *
> + * Copyright (C) 2015 Parade Technologies
> + * Copyright (C) 2012-2015 Cypress Semiconductor
> + * Copyright (C) 2018 Bootlin
> + *
> + * Authors: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
> + *                Alistair Francis <alistair@alistair23.me>

> + *

Redundant.

> + */

...

> +#include <asm/unaligned.h>

Can you move it after linux/* ones?

> +#include <linux/crc-itu-t.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>

> +#include <linux/gpio.h>

This is wrong. New code shouldn't include this header.

> +#include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>

...

> +#define CY_BITS_PER_BTN                        1
> +#define CY_NUM_BTN_EVENT_ID                    ((1 << CY_BITS_PER_BTN) -=
 1)

Seems like a mask depending on the amount of bits.
Perhaps GENMASK(1, 0)?

...

> +#define HID_OUTPUT_RESPONSE_CMD_MASK           0x7F

GENMASK()

...

> +#define HID_SYSINFO_BTN_MASK                   0xFF

Ditto.

...

> +/*  Timeout in ms */

Drop this comment and use _MS suffix in the definitions.

> +#define CY_HID_OUTPUT_TIMEOUT                  200
> +#define CY_HID_OUTPUT_GET_SYSINFO_TIMEOUT      3000
> +#define CY_HID_GET_HID_DESCRIPTOR_TIMEOUT      4000

...

> +/* helpers */
> +#define HI_BYTE(x)                             ((u8)(((x) >> 8) & 0xFF))
> +#define LOW_BYTE(x)                            ((u8)((x) & 0xFF))

Why are these needed? Just use them directly.

...

> +enum cyttsp5_tch_abs { /* for ordering within the extracted touch data a=
rray */
> +       CY_TCH_X,       /* X */
> +       CY_TCH_Y,       /* Y */
> +       CY_TCH_P,       /* P (Z) */
> +       CY_TCH_T,       /* TOUCH ID */
> +       CY_TCH_MAJ,     /* TOUCH_MAJOR */
> +       CY_TCH_MIN,     /* TOUCH_MINOR */

> +       CY_TCH_NUM_ABS,

If it is a terminator, drop the comma.

> +};

...

> +/*
> + * For what understood in the datasheet, the register does not

is understood

> + * matter. For consistency, used the Input Register address

use

> + * but it does mean anything to the device. The important data
> + * to send is the I2C address
> + */


> +       /* The hardware wants to receive a frame with the address registe=
r

Be consistent with multi-line comments. Here you need to add a leading
empty line.

> +        * contains in the first two bytes. As the regmap_write function

contained

> +        * add the register adresse in the frame, we use the LOW_BYTE as
> +        * first frame byte for the address register and the first
> +        * data byte is the high register + left of the cmd to send
> +        */

...

> +       for (nbyte =3D 0, *axis =3D 0; nbyte < size; nbyte++)

> +               *axis =3D *axis + ((xy_data[nbyte] >> bofs) << (nbyte * 8=
));

+=3D

...

> +#ifdef CONFIG_OF

Why? You may easily combine the two.

> +static int cyttsp5_parse_dt_key_code(struct device *dev)
> +{
> +       struct cyttsp5 *ts =3D dev_get_drvdata(dev);
> +       struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> +       struct device_node *np;
> +       int i;

> +       np =3D dev->of_node;
> +       if (!np)
> +               return -EINVAL;

Redundant. The of_property_*() will do it anyway.

> +       if (!si->num_btns)
> +               return 0;
> +
> +       /* Initialize the button to RESERVED */

> +       for (i =3D 0; i < si->num_btns; i++)
> +               si->key_code[i] =3D KEY_RESERVED;

memset32() ?

> +       return of_property_read_u32_array(np, "linux,keycodes",
> +                                  si->key_code, si->num_btns);
> +}
> +#else
> +static int cyttsp5_parse_dt_key_code(struct device *dev)
> +{
> +       struct cyttsp5 *ts =3D dev_get_drvdata(dev);
> +       struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> +       int i;
> +
> +       if (!si->num_btns)
> +               return 0;
> +
> +       /* Initialize the button to RESERVED */
> +       for (i =3D 0; i < si->num_btns; i++)
> +               si->key_code[i] =3D KEY_RESERVED;
> +
> +       return 0;
> +}

Combine with the above and get rid of ugly ifdeffery.

> +#endif

...

> +       size =3D get_unaligned_le16(&ts->response_buf[0]);

> +

Redundant blank line.

> +       if (!size)
> +               return 0;

...

> +               crc =3D cyttsp5_compute_crc(&ts->response_buf[4], size - =
7);
> +               if (ts->response_buf[size - 3] !=3D LOW_BYTE(crc) ||
> +                   ts->response_buf[size - 2] !=3D HI_BYTE(crc)) {

What's wrong with a direct comparison with _le16 value?

> +                       dev_err(ts->dev, "HID output response, wrong CRC =
0x%X\n",
> +                               crc);
> +                       return -EPROTO;
> +               }

...

> +       si->num_btns =3D 0;
> +       for (i =3D 0; i < HID_SYSINFO_MAX_BTN; i++) {
> +               if (btns & BIT(i))
> +                       si->num_btns++;
> +       }

NIH for_each_set_bit(), but do one more step to see that this is
actually a Hamming weight. We have functions. Hence, make it one line
with one simple call.

...

> +       struct cyttsp5_sensing_conf_data_dev *scd_dev =3D

> +               (struct cyttsp5_sensing_conf_data_dev *)

Why casting?

> +               &ts->response_buf[HID_SYSINFO_SENSING_OFFSET];

...

> +       si->xy_data =3D devm_kzalloc(ts->dev, scd->max_tch * TOUCH_REPORT=
_SIZE,
> +                                  GFP_KERNEL);

Use _kcalloc().

> +       if (!si->xy_data)
> +               return -ENOMEM;

...

> +       cmd[0] =3D LOW_BYTE(HID_OUTPUT_GET_SYSINFO_SIZE);
> +       cmd[1] =3D HI_BYTE(HID_OUTPUT_GET_SYSINFO_SIZE);

Use put_unaligned_le16() instead.

...

> +       rc =3D wait_event_timeout(ts->wait_q, (ts->hid_cmd_state =3D=3D H=
ID_CMD_DONE),
> +                               msecs_to_jiffies(CY_HID_OUTPUT_GET_SYSINF=
O_TIMEOUT));
> +       if (!rc) {
> +               dev_err(ts->dev, "HID output cmd execution timed out\n");

> +               rc =3D -ETIME;

What is this supposed to mean?

> +               goto error;
> +       }

...

> +       cmd[0] =3D LOW_BYTE(HID_OUTPUT_BL_LAUNCH_APP_SIZE);
> +       cmd[1] =3D HI_BYTE(HID_OUTPUT_BL_LAUNCH_APP_SIZE);

put_unaligned_le16()

...

> +       cmd[6] =3D 0x0; /* Low bytes of data */
> +       cmd[7] =3D 0x0; /* Hi bytes of data */

Ditto.

...

> +       crc =3D cyttsp5_compute_crc(&cmd[4], 4);
> +       cmd[8] =3D LOW_BYTE(crc);
> +       cmd[9] =3D HI_BYTE(crc);

Ditto.

...

> +       rc =3D wait_event_timeout(ts->wait_q, (ts->hid_cmd_state =3D=3D H=
ID_CMD_DONE),
> +                               msecs_to_jiffies(CY_HID_OUTPUT_TIMEOUT));
> +       if (!rc) {
> +               dev_err(ts->dev, "HID output cmd execution timed out\n");

> +               rc =3D -ETIME;

???

> +               goto error;
> +       }

...

> +       memcpy(desc, ts->response_buf, sizeof(struct cyttsp5_hid_desc));

sizeof(*desc) ?

...

> +       rc =3D regmap_bulk_read(ts->regmap, HID_INPUT_REG, buf, 2);

sizeof(buf)

> +       if (rc < 0)
> +               return rc;

...

> +#ifdef CONFIG_OF

Drop this. It usually brings more pain than helps.

> +static const struct of_device_id cyttsp5_of_match[] =3D {
> +       { .compatible =3D "cypress,tt21000", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, cyttsp5_of_match);
> +#endif
> +
> +static const struct i2c_device_id cyttsp5_i2c_id[] =3D {
> +       { CYTTSP5_NAME, 0, },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, cyttsp5_i2c_id);

Move both closer to their users (below).

...

> +               dev_set_drvdata(dev, NULL);

No need to repeat what device core does for everybody for the last 10+ year=
s.

...

> +               dev_set_drvdata(dev, NULL);

Ditto.

...

> +       /* Reset the gpio to be in a reset state */
> +       ts->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OU=
T_LOW);
> +       if (IS_ERR(ts->reset_gpio)) {
> +               rc =3D PTR_ERR(ts->reset_gpio);
> +               dev_err(dev, "Failed to request reset gpio, error %d\n", =
rc);
> +               return rc;
> +       }

No minimum reset timeout?

> +       gpiod_set_value(ts->reset_gpio, 1);

Or what does this all mean? Shouldn't you simply use _OUT_HIGH above?

> +       /* Need a delay to have device up */
> +       msleep(20);

...

> +static struct i2c_driver cyttsp5_i2c_driver =3D {
> +       .driver =3D {
> +               .name =3D CYTTSP5_NAME,

> +               .of_match_table =3D of_match_ptr(cyttsp5_of_match),

Drop of_match_ptr() as well.

> +       },
> +       .probe =3D cyttsp5_i2c_probe,
> +       .remove =3D cyttsp5_i2c_remove,
> +       .id_table =3D cyttsp5_i2c_id,
> +};

> +

Redundant blank line.

> +module_i2c_driver(cyttsp5_i2c_driver);

--
With Best Regards,
Andy Shevchenko
