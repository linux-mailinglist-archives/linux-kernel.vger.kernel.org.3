Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F7B464DE0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349300AbhLAMcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbhLAMce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:32:34 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EB3C061574;
        Wed,  1 Dec 2021 04:29:12 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id 14so30391324ioe.2;
        Wed, 01 Dec 2021 04:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oPd0UapzSuieNo3ybQ5Sv3kUeXIzBQ+sxjuzZ43uvkY=;
        b=Bj3fHDvZ+XRtpjl9nccAUwq54JhEbACvFYNUK8Fo65gv3jd9aXBhJ9Z9fzQuhcl1q5
         OzapxI+aqJK7EEF1s6DFzaZRhNvU43hlI4UxWhqGRlJI5yea2bQpfMdqLNL8Ttr31e9F
         e+obscdmye2ZL59MgxrzuE2uFjV6eEeYw9aPOlIdoW/yr7UlNIUKsNtOQmc6Antz+o9i
         xw6S3zzNXS6NgqIuajsM7goprBswAb4bIEaPUxPgHhiS3w9e2yTmV4lm0cXdPrJ5lQaI
         F3+pma7f+SKVcAvvZDs2Xq3HJ3YAyKAzzAbEqzImTiF6o7nOgkpDCK8NtkKpZLznySeC
         EhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oPd0UapzSuieNo3ybQ5Sv3kUeXIzBQ+sxjuzZ43uvkY=;
        b=RFcj5bLlKDVJYmH+DDLPTKffNzgCpNk88edoeSyEi7rdNWblJEFds4Encc1yuJKhEH
         VJJ55vX0TUx93TjF+y4Gi9GY/J0XI3PwSbm/Z7wV7BeB1233yi9OVw0n3T880BYvxPCa
         FH6oR9qC7nYBYTboCsOSq84QHnzkrHA0nzO+tiUKILuH9FJIOBPzknzeOyRE5R/IIA72
         uVlsfNOVl7f/ruMa8enDBtQtcNoVWKiZQ64xKwLVInjS8nvML7WeB0RY96TS/yZJBlpF
         MYoTNsB/6lgIKMjsI97ZSslrNKEi0tOIXIUgqeIDt/cQhf7VtlBu1Fon37ZeG1itOF+4
         5c/w==
X-Gm-Message-State: AOAM53214NAvYSevrt9OKoH4td6cD7FpsLNvSnkbGeqYiP9bZsEqTiXv
        moVZc2lgYLqX//umCJzdcPvT5WWUzOMqGx3cNPw=
X-Google-Smtp-Source: ABdhPJz2ZWtFIydfbWR/mZO+cr5u2vC+PJccvp+875tG5jVoa6FfSGbDveAOpijW4OWIMkVudOD7tRcuLyS83YhhD38=
X-Received: by 2002:a6b:f212:: with SMTP id q18mr7395007ioh.16.1638361751832;
 Wed, 01 Dec 2021 04:29:11 -0800 (PST)
MIME-Version: 1.0
References: <20211103114830.62711-1-alistair@alistair23.me>
 <20211103114830.62711-2-alistair@alistair23.me> <YYYk/uisKqPNgRu0@google.com>
In-Reply-To: <YYYk/uisKqPNgRu0@google.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 1 Dec 2021 22:27:46 +1000
Message-ID: <CAKmqyKOFZOLpjMY+kj2CLibFhYJ3-tL+9+cKEVzgSn9Mzq30gw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Input: Add driver for Cypress Generation 5 touchscreen
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mylene Josserand <mylene.josserand@free-electrons.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Nov 6, 2021 at 4:47 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Alistair,
>
> On Wed, Nov 03, 2021 at 09:48:27PM +1000, Alistair Francis wrote:
> > From: Myl=C4=8Dne Josserand <mylene.josserand@bootlin.com>
> >
...
> > +
> > +/*
> > + * For what understood in the datasheet, the register does not
> > + * matter. For consistency, used the Input Register address
> > + * but it does mean anything to the device. The important data
> > + * to send is the I2C address
> > + */
> > +static int cyttsp5_read(struct cyttsp5 *ts, u8 *buf, u32 max)
> > +{
> > +     int rc;
>
> Please call this "error". Also elsewhere, variables that hold either
> error code or success (0) should be called "error".
>
> > +     u32 size;
> > +     u8 temp[2];
> > +
> > +     if (!buf)
> > +             return -EINVAL;
>
> This is an internal function. How can it be called with NULL buffer?

I have removed the check

>
> > +
> > +     /* Read the frame to retrieve the size */
> > +     rc =3D regmap_bulk_read(ts->regmap, HID_INPUT_REG, temp, 2);
>
> sizeof(temp)
>
> > +     if (rc < 0)
>
> regmap_bulk_read() retirns 0 on success, so the check should be
>
>         if (error)
>
> > +             return rc;
> > +
> > +     size =3D get_unaligned_le16(temp);
> > +     if (!size || size =3D=3D 2)
> > +             return 0;
> > +
> > +     if (size > max)
> > +             return -EINVAL;
> > +
> > +     /* Get the real value */
> > +     return regmap_bulk_read(ts->regmap, HID_INPUT_REG, buf, size);
> > +}
> > +
> > +static int cyttsp5_write(struct cyttsp5 *ts, unsigned int reg, u8 *dat=
a,
> > +                      size_t size)
> > +{
> > +     u8 cmd[HID_OUTPUT_MAX_CMD_SIZE];
> > +
> > +     if (size + 1 > HID_OUTPUT_MAX_CMD_SIZE) {
> > +             return -ENOMEM;
>
> Maybe -E2BIG or -EINVAL.
>
> > +     }
>
> Unnecessary curly braces.
>
> > +
> > +     /* High bytes of register address needed as first byte of cmd */
> > +     cmd[0] =3D HI_BYTE(reg);
> > +
> > +     /* Copy the rest of the data */
> > +     if (data)
> > +             memcpy(&cmd[1], data, size);
> > +
> > +     /* The hardware wants to receive a frame with the address registe=
r
> > +      * contains in the first two bytes. As the regmap_write function
> > +      * add the register adresse in the frame, we use the LOW_BYTE as
> > +      * first frame byte for the address register and the first
> > +      * data byte is the high register + left of the cmd to send
> > +      */
> > +     return regmap_bulk_write(ts->regmap, LOW_BYTE(reg), cmd, size + 1=
);
> > +}
> > +
> > +static void cyttsp5_final_sync(struct input_dev *input, int max_slots,
> > +                            unsigned long *ids)
> > +{
> > +     int t;
> > +
> > +     for (t =3D 0; t < max_slots; t++) {
> > +             if (test_bit(t, ids))
> > +                     continue;
> > +             input_mt_slot(input, t);
> > +             input_mt_report_slot_state(input, MT_TOOL_FINGER, false);
> > +     }
> > +
> > +     input_sync(input);
> > +}
> > +
> > +static void cyttsp5_report_slot_liftoff(struct cyttsp5 *ts, int max_sl=
ots)
> > +{
> > +     int t;
> > +
> > +     if (ts->num_prv_rec =3D=3D 0)
> > +             return;
> > +
> > +     for (t =3D 0; t < max_slots; t++) {
> > +             input_mt_slot(ts->input, t);
> > +             input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, fal=
se);
> > +     }
> > +}
> > +
> > +static void cyttsp5_mt_lift_all(struct cyttsp5 *ts)
> > +{
> > +     struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> > +     int max =3D si->tch_abs[CY_TCH_T].max;
> > +
> > +     if (ts->num_prv_rec !=3D 0) {
> > +             cyttsp5_report_slot_liftoff(ts, max);
> > +             input_sync(ts->input);
> > +             ts->num_prv_rec =3D 0;
> > +     }
> > +}
> > +
> > +static void cyttsp5_get_touch_axis(int *axis, int size, int max, u8 *x=
y_data,
> > +                                int bofs)
> > +{
> > +     int nbyte;
> > +
> > +     for (nbyte =3D 0, *axis =3D 0; nbyte < size; nbyte++)
> > +             *axis =3D *axis + ((xy_data[nbyte] >> bofs) << (nbyte * 8=
));
> > +
> > +     *axis &=3D max - 1;
>
> Can it be that max is not power of 2?

Not that I have seen.

>
> > +}
> > +
> > +static void cyttsp5_get_touch_record(struct cyttsp5 *ts,
> > +                                  struct cyttsp5_touch *touch, u8 *xy_=
data)
> > +{
> > +     struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> > +     enum cyttsp5_tch_abs abs;
> > +
> > +     for (abs =3D CY_TCH_X; abs < CY_TCH_NUM_ABS; abs++) {
> > +             cyttsp5_get_touch_axis(&touch->abs[abs],
> > +                                    si->tch_abs[abs].size,
> > +                                    si->tch_abs[abs].max,
> > +                                    xy_data + si->tch_abs[abs].ofs,
> > +                                    si->tch_abs[abs].bofs);
> > +     }
>
> Unnecessary curly braces.
>
> > +}
> > +
> > +static void cyttsp5_get_mt_touches(struct cyttsp5 *ts,
> > +                                struct cyttsp5_touch *tch, int num_cur=
_tch)
> > +{
> > +     struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> > +     int i, t =3D 0;
> > +     DECLARE_BITMAP(ids, MAX_CY_TCH_T_IDS);
> > +     u8 *tch_addr;
> > +     int tmp;
> > +
> > +     bitmap_zero(ids, MAX_CY_TCH_T_IDS);
> > +     memset(tch->abs, 0, sizeof(tch->abs));
> > +
> > +     for (i =3D 0; i < num_cur_tch; i++) {
> > +             tch_addr =3D si->xy_data + (i * TOUCH_REPORT_SIZE);
> > +             cyttsp5_get_touch_record(ts, tch, tch_addr);
> > +
> > +             /* Convert MAJOR/MINOR from mm to resolution */
> > +             tmp =3D tch->abs[CY_TCH_MAJ] * 100 * si->sensing_conf_dat=
a.res_x;
> > +             tch->abs[CY_TCH_MAJ] =3D tmp / si->sensing_conf_data.len_=
x;
> > +             tmp =3D tch->abs[CY_TCH_MIN] * 100 * si->sensing_conf_dat=
a.res_x;
> > +             tch->abs[CY_TCH_MIN] =3D tmp / si->sensing_conf_data.len_=
x;
> > +
> > +             t =3D tch->abs[CY_TCH_T];
> > +             input_mt_slot(ts->input, t);
> > +             input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, tru=
e);
> > +             __set_bit(t, ids);
> > +
> > +             /* position and pressure fields */
> > +             input_report_abs(ts->input, ABS_MT_POSITION_X,
> > +                              tch->abs[CY_TCH_X]);
> > +             input_report_abs(ts->input, ABS_MT_POSITION_Y,
> > +                              tch->abs[CY_TCH_Y]);
> > +             input_report_abs(ts->input, ABS_MT_PRESSURE,
> > +                              tch->abs[CY_TCH_P]);
> > +
> > +             /* Get the extended touch fields */
> > +             input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR,
> > +                              tch->abs[CY_TCH_MAJ]);
> > +             input_report_abs(ts->input, ABS_MT_TOUCH_MINOR,
> > +                              tch->abs[CY_TCH_MIN]);
> > +
> > +             touchscreen_report_pos(ts->input, &ts->prop,
> > +                                    tch->abs[CY_TCH_X], tch->abs[CY_TC=
H_Y],
> > +                                    true);
>
> I have no idea why you first report position manually (without applying
> transformation) and then finally use touchscreen_report_pos() to report
> is again, now properly.

Fixed!

>
> > +     }
> > +
> > +     cyttsp5_final_sync(ts->input, si->tch_abs[CY_TCH_T].max, ids);
>
> I think if you use INPUT_MT_DROP_UNUSED when initializing slots and call
> input_mt_sync_frame() then cyttsp5_final_sync() will not be needed.

Yep, I have removed cyttsp5_final_sync()

>
> > +
> > +     ts->num_prv_rec =3D num_cur_tch;
> > +}
> > +
> > +/* read xy_data for all current touches */
> > +static int cyttsp5_xy_worker(struct cyttsp5 *ts)
> > +{
> > +     struct device *dev =3D ts->dev;
> > +     struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> > +     int max_tch =3D si->sensing_conf_data.max_tch;
> > +     struct cyttsp5_touch tch;
> > +     u8 num_cur_tch;
> > +
> > +     cyttsp5_get_touch_axis(&tch.hdr, si->tch_hdr.size,
>
> I am struggling to understand why this member is called "hdr" and why it
> is a part of cyttsp5_touch.

Good point, removed.

>
> > +                            si->tch_hdr.max,
> > +                            si->xy_mode + 3 + si->tch_hdr.ofs,
> > +                            si->tch_hdr.bofs);
> > +
> > +     num_cur_tch =3D tch.hdr;
> > +     if (num_cur_tch > max_tch) {
> > +             dev_err(dev, "Num touch err detected (n=3D%d)\n", num_cur=
_tch);
> > +             num_cur_tch =3D max_tch;
> > +     }
> > +
> > +     if (num_cur_tch =3D=3D 0 && ts->num_prv_rec =3D=3D 0)
> > +             return 0;
> > +
> > +     /* extract xy_data for all currently reported touches */
> > +     if (num_cur_tch)
> > +             cyttsp5_get_mt_touches(ts, &tch, num_cur_tch);
> > +     else
> > +             cyttsp5_mt_lift_all(ts);
>
> Not needed with INPUT_MT_DROP_UNUSED.

I tried INPUT_MT_DROP_UNUSED and I still need this function

>
> > +
> > +     return 0;
> > +}
> > +
> > +static int cyttsp5_mt_attention(struct device *dev)
> > +{
> > +     struct cyttsp5 *ts =3D dev_get_drvdata(dev);
> > +     struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> > +     int rc;
> > +
> > +     if (si->xy_mode[2] !=3D HID_TOUCH_REPORT_ID)
> > +             return 0;
>
> It is only ever called with this condition, why do we need to check
> this again?

Removed.

>
> > +
> > +     /* core handles handshake */
> > +     rc =3D cyttsp5_xy_worker(ts);
> > +     if (rc < 0)
> > +             dev_err(dev, "xy_worker error r=3D%d\n", rc);
> > +
> > +     return rc;
> > +}
> > +
> > +static int cyttsp5_setup_input_device(struct device *dev)
> > +{
> > +     struct cyttsp5 *ts =3D dev_get_drvdata(dev);
> > +     struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> > +     int max_x, max_y, max_p;
> > +     int max_x_tmp, max_y_tmp;
> > +     int rc;
> > +
> > +     __set_bit(EV_ABS, ts->input->evbit);
>
> input_set_abs_params() does this I believe.

Removed

>
> > +     __set_bit(EV_REL, ts->input->evbit);
>
> I do not believe the driver emits any EV_REL events.

If I delete this my userspace program doesn't start.

>
> > +     __set_bit(EV_KEY, ts->input->evbit);
>
> I think I saw it done elsewhere already.

Yep, removed.

>
> > +
> > +     max_x_tmp =3D si->sensing_conf_data.res_x;
> > +     max_y_tmp =3D si->sensing_conf_data.res_y;
> > +     max_x =3D max_x_tmp - 1;
> > +     max_y =3D max_y_tmp - 1;
> > +     max_p =3D si->sensing_conf_data.max_z;
> > +
> > +     input_mt_init_slots(ts->input, si->tch_abs[CY_TCH_T].max, 0);
>
> Error handling. You also want to use INPUT_MT_POINTER and potentially
> INPUT_MT_DROP_UNUSED.

Done!

>
> > +
> > +     __set_bit(ABS_MT_POSITION_X, ts->input->absbit);
> > +     __set_bit(ABS_MT_POSITION_Y, ts->input->absbit);
> > +     __set_bit(ABS_MT_PRESSURE, ts->input->absbit);
>
> These 3 are not needed.
>
> > +
> > +     input_set_abs_params(ts->input, ABS_MT_POSITION_X, 0, max_x, 0, 0=
);
> > +     input_set_abs_params(ts->input, ABS_MT_POSITION_Y, 0, max_y, 0, 0=
);
> > +     input_set_abs_params(ts->input, ABS_MT_PRESSURE, 0, max_p, 0, 0);
> > +
> > +     input_set_abs_params(ts->input, ABS_MT_TOUCH_MAJOR, 0, MAX_AREA, =
0, 0);
> > +     input_set_abs_params(ts->input, ABS_MT_TOUCH_MINOR, 0, MAX_AREA, =
0, 0);
> > +
> > +     rc =3D input_register_device(ts->input);
> > +     if (rc < 0)
> > +             dev_err(dev, "Error, failed register input device r=3D%d\=
n", rc);
> > +
> > +     return rc;
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static int cyttsp5_parse_dt_key_code(struct device *dev)
> > +{
> > +     struct cyttsp5 *ts =3D dev_get_drvdata(dev);
> > +     struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> > +     struct device_node *np;
> > +     int i;
> > +
> > +     np =3D dev->of_node;
> > +     if (!np)
> > +             return -EINVAL;
> > +
> > +     if (!si->num_btns)
> > +             return 0;
> > +
> > +     /* Initialize the button to RESERVED */
> > +     for (i =3D 0; i < si->num_btns; i++)
> > +             si->key_code[i] =3D KEY_RESERVED;
> > +
> > +     return of_property_read_u32_array(np, "linux,keycodes",
> > +                                si->key_code, si->num_btns);
>
> I would use device_property_read_u32_array() instead and did not make it
> limited to OF.
>
> > +}
> > +#else
> > +static int cyttsp5_parse_dt_key_code(struct device *dev)
> > +{
> > +     struct cyttsp5 *ts =3D dev_get_drvdata(dev);
> > +     struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> > +     int i;
> > +
> > +     if (!si->num_btns)
> > +             return 0;
> > +
> > +     /* Initialize the button to RESERVED */
> > +     for (i =3D 0; i < si->num_btns; i++)
> > +             si->key_code[i] =3D KEY_RESERVED;
> > +
> > +     return 0;
> > +}
> > +#endif
> > +
> > +static int cyttsp5_btn_attention(struct device *dev)
> > +{
> > +     struct cyttsp5 *ts =3D dev_get_drvdata(dev);
> > +     struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> > +     int cur_btn;
> > +     int cur_btn_state;
> > +
> > +     if (si->xy_mode[2] !=3D HID_BTN_REPORT_ID || !si->num_btns)
> > +             return 0;
> > +
> > +     /* extract button press/release touch information */
> > +     for (cur_btn =3D 0; cur_btn < si->num_btns; cur_btn++) {
> > +             /* Get current button state */
> > +             cur_btn_state =3D (si->xy_data[0] >> (cur_btn * CY_BITS_P=
ER_BTN))
> > +                     & CY_NUM_BTN_EVENT_ID;
> > +
> > +             input_report_key(ts->input, si->key_code[cur_btn],
> > +                              cur_btn_state);
> > +             input_sync(ts->input);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static u16 cyttsp5_compute_crc(u8 *buf, u32 size)
> > +{
> > +     u16 remainder =3D 0xFFFF;
> > +     u16 xor_mask =3D 0x0000;
> > +     u32 index;
> > +     u32 byte_value;
> > +     u32 table_index;
> > +     u32 crc_bit_width =3D sizeof(u16) * 8;
> > +
> > +     /* Divide the message by polynomial, via the table. */
> > +     for (index =3D 0; index < size; index++) {
> > +             byte_value =3D buf[index];
> > +             table_index =3D ((byte_value >> 4) & 0x0F)
> > +                     ^ (remainder >> (crc_bit_width - 4));
> > +             remainder =3D crc_itu_t_table[table_index]
> > +                     ^ (remainder << 4);
> > +             table_index =3D (byte_value & 0x0F)
> > +                     ^ (remainder >> (crc_bit_width - 4));
> > +             remainder =3D crc_itu_t_table[table_index]
> > +                     ^ (remainder << 4);
> > +     }
> > +
> > +     /* Perform the final remainder CRC. */
> > +     return remainder ^ xor_mask;
>
> Do we have matching implementation in lib/crc* by any chance?

Yep, it seems that we do.

>
> > +}
> > +
> > +static int cyttsp5_validate_cmd_response(struct cyttsp5 *ts, u8 code)
> > +{
> > +     u16 size, crc;
> > +     u8 status, offset;
> > +     int command_code;
> > +
> > +     size =3D get_unaligned_le16(&ts->response_buf[0]);
> > +
> > +     if (!size)
> > +             return 0;
> > +
> > +     offset =3D ts->response_buf[HID_OUTPUT_RESPONSE_REPORT_OFFSET];
>
> This is definitely not an "offset".
>
> > +
> > +     if (offset =3D=3D HID_BL_RESPONSE_REPORT_ID) {
>
>         switch (report_id) {
>
> > +             if (ts->response_buf[4] !=3D HID_OUTPUT_BL_SOP) {
> > +                     dev_err(ts->dev, "HID output response, wrong SOP\=
n");
> > +                     return -EPROTO;
> > +             }
> > +
> > +             if (ts->response_buf[size - 1] !=3D HID_OUTPUT_BL_EOP) {
> > +                     dev_err(ts->dev, "HID output response, wrong EOP\=
n");
> > +                     return -EPROTO;
> > +             }
> > +
> > +             crc =3D cyttsp5_compute_crc(&ts->response_buf[4], size - =
7);
> > +             if (ts->response_buf[size - 3] !=3D LOW_BYTE(crc) ||
> > +                 ts->response_buf[size - 2] !=3D HI_BYTE(crc)) {
> > +                     dev_err(ts->dev, "HID output response, wrong CRC =
0x%X\n",
> > +                             crc);
> > +                     return -EPROTO;
> > +             }
> > +
> > +             status =3D ts->response_buf[5];
> > +             if (status) {
> > +                     dev_err(ts->dev, "HID output response, ERROR:%d\n=
",
> > +                             status);
> > +                     return -EPROTO;
> > +             }
> > +     }
> > +
> > +     if (offset =3D=3D HID_APP_RESPONSE_REPORT_ID) {
> > +             command_code =3D ts->response_buf[HID_OUTPUT_RESPONSE_CMD=
_OFFSET]
> > +                     & HID_OUTPUT_RESPONSE_CMD_MASK;
> > +             if (command_code !=3D code) {
> > +                     dev_err(ts->dev,
> > +                             "HID output response, wrong command_code:=
%X\n",
> > +                             command_code);
> > +                     return -EPROTO;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void cyttsp5_si_get_btn_data(struct cyttsp5 *ts)
> > +{
> > +     struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> > +     int i;
> > +     unsigned int btns =3D ts->response_buf[HID_SYSINFO_BTN_OFFSET]
> > +             & HID_SYSINFO_BTN_MASK;
> > +
> > +     si->num_btns =3D 0;
> > +     for (i =3D 0; i < HID_SYSINFO_MAX_BTN; i++) {
> > +             if (btns & BIT(i))
> > +                     si->num_btns++;
> > +     }
>
>         hweight*()?

Fixed!

>
> > +}
> > +
> > +static int cyttsp5_get_sysinfo_regs(struct cyttsp5 *ts)
> > +{
> > +     struct cyttsp5_sensing_conf_data *scd =3D &ts->sysinfo.sensing_co=
nf_data;
> > +     struct cyttsp5_sensing_conf_data_dev *scd_dev =3D
> > +             (struct cyttsp5_sensing_conf_data_dev *)
> > +             &ts->response_buf[HID_SYSINFO_SENSING_OFFSET];
> > +     struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> > +
> > +     cyttsp5_si_get_btn_data(ts);
> > +
> > +     scd->max_tch =3D scd_dev->max_num_of_tch_per_refresh_cycle;
> > +     scd->res_x =3D get_unaligned_le16(&scd_dev->res_x);
> > +     scd->res_y =3D get_unaligned_le16(&scd_dev->res_y);
> > +     scd->max_z =3D get_unaligned_le16(&scd_dev->max_z);
> > +     scd->len_x =3D get_unaligned_le16(&scd_dev->len_x);
> > +     scd->len_y =3D get_unaligned_le16(&scd_dev->len_y);
> > +
> > +     si->xy_data =3D devm_kzalloc(ts->dev, scd->max_tch * TOUCH_REPORT=
_SIZE,
> > +                                GFP_KERNEL);
>
> What it the absolute maximum for tracked contacts? I wonder if it makes
> sense to allocate this buffer separately.

I have removed this as well and just use the input_buf.

>
> > +     if (!si->xy_data)
> > +             return -ENOMEM;
> > +
> > +     si->xy_mode =3D devm_kzalloc(ts->dev, TOUCH_INPUT_HEADER_SIZE,
> > +                                GFP_KERNEL);
> > +     if (!si->xy_mode)
> > +             return -ENOMEM;
>
> Why do we need to allocate 7 bytes separately?

I have removed this.

>
> > +
> > +     return 0;
> > +}
> > +
...
> > +
> > +static int move_touch_data(struct cyttsp5 *ts, struct cyttsp5_sysinfo =
*si)
> > +{
> > +     int max_tch =3D si->sensing_conf_data.max_tch;
> > +     int num_cur_tch;
> > +     int length;
> > +     struct cyttsp5_tch_abs_params *tch =3D &si->tch_hdr;
> > +
> > +     memcpy(si->xy_mode, ts->input_buf, TOUCH_INPUT_HEADER_SIZE);
> > +
> > +     cyttsp5_get_touch_axis(&num_cur_tch, tch->size,
> > +                            tch->max, si->xy_mode + 3 + tch->ofs, tch-=
>bofs);
> > +     if (unlikely(num_cur_tch > max_tch))
> > +             num_cur_tch =3D max_tch;
> > +
> > +     length =3D num_cur_tch * TOUCH_REPORT_SIZE;
> > +
> > +     memcpy(si->xy_data, &ts->input_buf[TOUCH_INPUT_HEADER_SIZE], leng=
th);
>
> Why do we need to do all these moves? Can we parse the date directly
> from the input buffer?

We don't need the moves. I have removed them.

>
> > +
> > +     return 0;
> > +}
> > +
> > +static irqreturn_t cyttsp5_handle_irq(int irq, void *handle)
> > +{
> > +     struct cyttsp5 *ts =3D handle;
> > +     int report_id;
> > +     int size;
> > +     int rc;
> > +
> > +     rc =3D cyttsp5_read(ts, ts->input_buf, CY_MAX_INPUT);
> > +     if (rc)
> > +             return IRQ_HANDLED;
> > +
> > +     size =3D get_unaligned_le16(&ts->input_buf[0]);
> > +
> > +     /* check reset */
> > +     if (size =3D=3D 0) {
> > +             memcpy(ts->response_buf, ts->input_buf, 2);
> > +
> > +             mutex_lock(&ts->system_lock);
>
> Why is this lock needed exactly?

I don't think it is, I have removed it.

>
> > +             ts->hid_cmd_state =3D HID_CMD_DONE;
> > +             mutex_unlock(&ts->system_lock);
> > +             wake_up(&ts->wait_q);
> > +             return IRQ_HANDLED;
> > +     }
> > +
> > +     report_id =3D ts->input_buf[2];
>
> I'd probably do:
>
>         if (size =3D=3D 0) {
>                 /* reset */
>                 report_id =3D HID_EMPTY_RESPONSE_ID; /* =3D 0 */
>                 size =3D 2;
>         } else {
>                 report_id =3D ts->input_buf[2];
>         }
>
> > +
> > +     if (report_id =3D=3D HID_TOUCH_REPORT_ID) {
>
>         switch (report_id) {

Good idea, fixed.

>
> > +             move_touch_data(ts, &ts->sysinfo);
> > +             cyttsp5_mt_attention(ts->dev);
> > +     } else if (report_id =3D=3D HID_BTN_REPORT_ID) {
> > +             move_button_data(ts, &ts->sysinfo);
> > +             cyttsp5_btn_attention(ts->dev);
> > +     } else {
> > +             /* It is not an input but a command response */
> > +             memcpy(ts->response_buf, ts->input_buf, size);
> > +
> > +             mutex_lock(&ts->system_lock);
> > +             ts->hid_cmd_state =3D HID_CMD_DONE;
> > +             mutex_unlock(&ts->system_lock);
> > +             wake_up(&ts->wait_q);
> > +     }
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int cyttsp5_deassert_int(struct cyttsp5 *ts)
> > +{
> > +     u16 size;
> > +     u8 buf[2];
> > +     int rc;
> > +
> > +     rc =3D regmap_bulk_read(ts->regmap, HID_INPUT_REG, buf, 2);
> > +     if (rc < 0)
> > +             return rc;
> > +
> > +     size =3D get_unaligned_le16(&buf[0]);
> > +     if (size =3D=3D 2 || size =3D=3D 0)
> > +             return 0;
>
> If you were to use level interrupts this probably would not be needed.

I have tried with/without this and I still can't get level interrupts worki=
ng.

>
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int cyttsp5_fill_all_touch(struct cyttsp5 *ts)
> > +{
> > +     struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> > +
> > +     fill_tch_abs(&si->tch_abs[CY_TCH_X], REPORT_SIZE_16,
> > +                  TOUCH_REPORT_DESC_X);
> > +     fill_tch_abs(&si->tch_abs[CY_TCH_Y], REPORT_SIZE_16,
> > +                  TOUCH_REPORT_DESC_Y);
> > +     fill_tch_abs(&si->tch_abs[CY_TCH_P], REPORT_SIZE_8,
> > +                  TOUCH_REPORT_DESC_P);
> > +     fill_tch_abs(&si->tch_abs[CY_TCH_T], REPORT_SIZE_5,
> > +                  TOUCH_REPORT_DESC_CONTACTID);
> > +     fill_tch_abs(&si->tch_hdr, REPORT_SIZE_5,
> > +                  TOUCH_REPORT_DESC_HDR_CONTACTCOUNT);
> > +     fill_tch_abs(&si->tch_abs[CY_TCH_MAJ], REPORT_SIZE_8,
> > +                  TOUCH_REPORT_DESC_MAJ);
> > +     fill_tch_abs(&si->tch_abs[CY_TCH_MIN], REPORT_SIZE_8,
> > +                  TOUCH_REPORT_DESC_MIN);
> > +
> > +     return 0;
> > +}
> > +
> > +static int cyttsp5_startup(struct cyttsp5 *ts)
> > +{
> > +     int rc;
> > +
> > +     rc =3D cyttsp5_deassert_int(ts);
> > +     if (rc) {
> > +             dev_err(ts->dev, "Error on deassert int r=3D%d\n", rc);
> > +             return -ENODEV;
> > +     }
> > +
> > +     /*
> > +      * Launch the application as the device starts in bootloader mode
> > +      * because of a power-on-reset
> > +      */
> > +     rc =3D cyttsp5_hid_output_bl_launch_app(ts);
> > +     if (rc < 0) {
> > +             dev_err(ts->dev, "Error on launch app r=3D%d\n", rc);
> > +             return rc;
> > +     }
> > +
> > +     rc =3D cyttsp5_get_hid_descriptor(ts, &ts->hid_desc);
> > +     if (rc < 0) {
> > +             dev_err(ts->dev, "Error on getting HID descriptor r=3D%d\=
n", rc);
> > +             return rc;
> > +     }
> > +
> > +     rc =3D cyttsp5_fill_all_touch(ts);
> > +     if (rc < 0) {
> > +             dev_err(ts->dev, "Error on report descriptor r=3D%d\n", r=
c);
> > +             return rc;
> > +     }
> > +
> > +     rc =3D cyttsp5_hid_output_get_sysinfo(ts);
> > +     if (rc) {
> > +             dev_err(ts->dev, "Error on getting sysinfo r=3D%d\n", rc)=
;
> > +             return rc;
> > +     }
> > +
> > +     return rc;
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id cyttsp5_of_match[] =3D {
> > +     { .compatible =3D "cypress,tt21000", },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, cyttsp5_of_match);
> > +#endif
> > +
> > +static const struct i2c_device_id cyttsp5_i2c_id[] =3D {
> > +     { CYTTSP5_NAME, 0, },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, cyttsp5_i2c_id);
> > +
> > +static int cyttsp5_probe(struct device *dev, struct regmap *regmap, in=
t irq,
> > +                      const char *name)
> > +{
> > +     struct cyttsp5 *ts;
> > +     struct cyttsp5_sysinfo *si;
> > +     int rc =3D 0, i;
> > +
> > +     ts =3D devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> > +     if (!ts)
> > +             return -ENOMEM;
> > +
> > +     /* Initialize device info */
> > +     ts->regmap =3D regmap;
> > +     ts->dev =3D dev;
> > +     si =3D &ts->sysinfo;
> > +     dev_set_drvdata(dev, ts);
> > +
> > +     /* Initialize mutexes and spinlocks */
> > +     mutex_init(&ts->system_lock);
> > +
> > +     /* Initialize wait queue */
> > +     init_waitqueue_head(&ts->wait_q);
> > +
> > +     /* Power up the device */
> > +     ts->vdd =3D regulator_get(dev, "vdd");
>
> Do not mix managed an unmanaged resources. You are leaking this
> regulator.

I'm not clear what I should do differently here.

>
> > +     if (IS_ERR(ts->vdd)) {
> > +             rc =3D PTR_ERR(ts->vdd);
> > +             dev_set_drvdata(dev, NULL);
> > +             kfree(ts);
> > +             return rc;
> > +     }
> > +
> > +     rc =3D regulator_enable(ts->vdd);
> > +     if (rc) {
> > +             regulator_put(ts->vdd);
> > +             dev_set_drvdata(dev, NULL);
> > +             kfree(ts);
> > +             return rc;
> > +     }
> > +
> > +     /* Reset the gpio to be in a reset state */
> > +     ts->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OU=
T_LOW);
> > +     if (IS_ERR(ts->reset_gpio)) {
> > +             rc =3D PTR_ERR(ts->reset_gpio);
> > +             dev_err(dev, "Failed to request reset gpio, error %d\n", =
rc);
> > +             return rc;
> > +     }
> > +     gpiod_set_value(ts->reset_gpio, 1);
> > +
> > +     /* Need a delay to have device up */
> > +     msleep(20);
> > +
> > +     rc =3D devm_request_threaded_irq(dev, irq, NULL, cyttsp5_handle_i=
rq,
> > +                                    IRQF_TRIGGER_FALLING | IRQF_ONESHO=
T,
>
> Please do not override platform setup with hardcoded triggers. Also, it
> is strongly recommended to use level interrupts for these peripherals.
>
> This is also likely unsafe if controller is not completely shut off and
> is capable of generating interrupts given input device is not yet
> allocated.

I have dropped the `IRQF_TRIGGER_FALLING |`

I have tried to use level interrupts, but I can't get the device
working with them.

>
> > +                                    name, ts);
> > +     if (rc) {
> > +             dev_err(dev, "unable to request IRQ\n");
> > +             return rc;
> > +     }
> > +
> > +     rc =3D cyttsp5_startup(ts);
> > +     if (rc) {
> > +             dev_err(ts->dev, "Fail initial startup r=3D%d\n", rc);
> > +             return rc;
> > +     }
> > +
> > +     rc =3D cyttsp5_parse_dt_key_code(dev);
> > +     if (rc < 0) {
> > +             dev_err(ts->dev, "Error while parsing dts %d\n", rc);
> > +             return rc;
> > +     }
> > +
> > +     ts->input =3D devm_input_allocate_device(dev);
> > +     if (!ts->input) {
> > +             dev_err(dev, "Error, failed to allocate input device\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     ts->input->name =3D "cyttsp5";
> > +     scnprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev))=
;
> > +     ts->input->phys =3D ts->phys;
> > +     ts->input->dev.parent =3D ts->dev;
>
> No need to do this, devm_input_allocate_device() sets up parent.
>
> > +     input_set_drvdata(ts->input, ts);
> > +
> > +     touchscreen_parse_properties(ts->input, true, &ts->prop);
> > +
> > +     __set_bit(EV_KEY, ts->input->evbit);
> > +     __set_bit(ABS_X, ts->input->absbit);
> > +     __set_bit(ABS_Y, ts->input->absbit);
> > +     __set_bit(BTN_TOUCH, ts->input->keybit);
>
> These 3 should not be needed.
>
> > +     for (i =3D 0; i < si->num_btns; i++)
> > +             __set_bit(si->key_code[i], ts->input->keybit);
> > +
> > +     return cyttsp5_setup_input_device(dev);
> > +}
> > +
> > +static int cyttsp5_i2c_probe(struct i2c_client *client,
> > +                          const struct i2c_device_id *id)
> > +{
> > +     struct regmap *regmap;
> > +     static const struct regmap_config config =3D {
> > +             .reg_bits =3D 8,
> > +             .val_bits =3D 8,
> > +     };
> > +
> > +     regmap =3D devm_regmap_init_i2c(client, &config);
> > +     if (IS_ERR(regmap)) {
> > +             dev_err(&client->dev, "regmap allocation failed: %ld\n",
> > +                     PTR_ERR(regmap));
> > +             return PTR_ERR(regmap);
> > +     }
> > +
> > +     return cyttsp5_probe(&client->dev, regmap, client->irq, client->n=
ame);
> > +}
> > +
> > +static int cyttsp5_remove(struct device *dev)
> > +{
> > +     struct cyttsp5 *ts =3D dev_get_drvdata(dev);
> > +
> > +     input_unregister_device(ts->input);
>
> This is not needed as input device is devm managed. This entire function
> can be dropped.

Removed

>
> > +
> > +     return 0;
> > +}
> > +
> > +static int cyttsp5_i2c_remove(struct i2c_client *client)
> > +{
> > +     struct device *dev =3D &client->dev;
> > +
> > +     return cyttsp5_remove(dev);
> > +}
> > +
> > +static struct i2c_driver cyttsp5_i2c_driver =3D {
> > +     .driver =3D {
> > +             .name =3D CYTTSP5_NAME,
> > +             .of_match_table =3D of_match_ptr(cyttsp5_of_match),
> > +     },
> > +     .probe =3D cyttsp5_i2c_probe,
> > +     .remove =3D cyttsp5_i2c_remove,
> > +     .id_table =3D cyttsp5_i2c_id,
> > +};
> > +
> > +module_i2c_driver(cyttsp5_i2c_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("Touchscreen driver for Cypress TrueTouch Gen 5 Pro=
duct");
> > +MODULE_AUTHOR("Myl=C4=8Dne Josserand <mylene.josserand@bootlin.com>");
> > --
> > 2.31.1
> >
>
> Thanks.

Thanks for the in depth review.

I have addressed all of the issues that I didn't comment on.

Alistair

>
> --
> Dmitry
