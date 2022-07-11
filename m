Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5666456D312
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiGKCso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKCsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:48:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B48A1CE;
        Sun, 10 Jul 2022 19:48:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b26so5276112wrc.2;
        Sun, 10 Jul 2022 19:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=01yERDotahK77x3i39GPT7OwRklZX2ibfmCwzoKHKsg=;
        b=ljpneFcYifj6eaSxjXTztAuXU2ph8SjMNTDcH7qL7YtkrvprOrMC3rBkrRqVTu8RRz
         +WsT/1H+ulfGHZmRTILTYrZS+scj5zAwbGdwM1hwbXEPOzNJEp3LvoGpOXp6+QlYNjVP
         eLYbkuXmfuz2B9FQChm85lQkzXa07gmv7fAaHvbqC62WDa1XgbGgdL75vYSGZHp8btF9
         8Gd2xVDV4yrAj97KePHlGMsthU7EMqz3B5FM3tHXN5fJQrOmoDVVbV7twn0RFvumhCe8
         mdU53nX2/QiZPGsjopmpmChdAXdKN107S09EYhaX+abAAp2QNVPv6gFQ25ncYLCKxBxC
         Wr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=01yERDotahK77x3i39GPT7OwRklZX2ibfmCwzoKHKsg=;
        b=cqYDMrB9Q4i+ai9wAdBmZcYbb673lVFgN82qGfipDB9JQqjKnnAWzk1U7ncPIQvl0I
         OTRHrRMFHE+xzgBB6PVqZOc9+dkzC4vynqIrlSdiU1LojHmY/YaB+N6aEs+CmWgMYu6J
         KueMHJinbwx2OHMlznnD6TjqHa0AUKL1oVg0K9jEU4nhgZ9srKcmqDbReLYK6Y1/uPLM
         CMnKZGvKrS2ZwpF5ZdBO4eOs2N71KS9yQBboF7/bmictChW77w4reiJAMqbXxwAcNvnE
         a9vq3sK8ucJmD+MEtubTzQnqR/zf1iovgnGKF1FHCEk+RQ6f/5U6vFSKNODe0A/eZzCd
         ZMHA==
X-Gm-Message-State: AJIora8IZU9EqqczcqRkn349i9i8iij3l0IYui3LdFo/hQMuPi6idREl
        cjo5aTi31ElI/m+Oo4nmtti6jennMdSmGhXNquo=
X-Google-Smtp-Source: AGRyM1trDOSUmVt1uoB4ovsYpeqTzBrZfXbnAthKxtF+h5+m055OoXjl2n4436td7qDZhKtdZgzRLyxGT1yaEe4P8lA=
X-Received: by 2002:adf:f90c:0:b0:21a:3dcb:d106 with SMTP id
 b12-20020adff90c000000b0021a3dcbd106mr14432914wrr.448.1657507709377; Sun, 10
 Jul 2022 19:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <1657116702-24161-1-git-send-email-u0084500@gmail.com>
 <1657116702-24161-3-git-send-email-u0084500@gmail.com> <20220707183027.342f6c88@jic23-huawei>
In-Reply-To: <20220707183027.342f6c88@jic23-huawei>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 11 Jul 2022 10:48:17 +0800
Message-ID: <CADiBU3_KQ=WvD-1E4SODkdEY254_b-covw-0SHcAaF3XQqdbaQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: adc: Add rtq6056 support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=888=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E5=87=8C=E6=99=A81:20=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed,  6 Jul 2022 22:11:42 +0800
> cy_huang <u0084500@gmail.com> wrote:
>
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add Richtek rtq6056 supporting.
> >
> > It can be used for the system to monitor load current and power with 16=
-bit
> > resolution.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Various feedback inline.
>
> Thanks,
>
> Jonathan
>
> > ---
> > Since v5
> > - Fix kernel version text for ABI.
> >
> > Since v4
> > - Add '__aligned(8)' for timestamp member in buffer_trigger_handler fun=
ction.
> > - Declare timestamp from 'int64_t' to more unified 's64'.
> >
> > Since v3
> > - Refine pm_runtime API calling order in 'read_channel' API.
> > - Fix vshunt wrong scale for divider.
> > - Refine the comment text.
> > - Use 'devm_add_action_or_reset' to decrease the code usage in probe
> >   function.
> > - Use RUNTIME_PM_OPS to replace SET_RUNTIME_PM_OPS.
> > - minor fix for the comma.
> > - Use pm_ptr to replace the direct assigned pm_ops.
> >
> > Since v2
> > - Rename file from 'rtq6056-adc' to 'rtq6056'.
> > - Refine the ABI, if generic already defined it, remove it and check th=
e channel
> >   report unit.
> > - Add copyright text.
> > - include the correct header.
> > - change the property parsing name.
> > - To use iio_chan_spec address field.
> > - Refine each channel separate and shared_by_all.
> > - Use pm_runtime and pm_runtime_autosuspend.
> > - Remove the shutdown callback. From the HW suggestion, it's not recomm=
ended to
> >   use battery as the power supply.
> > - Check all scale unit (voltage->mV, current->mA, power->milliWatt).
> > - Use the read_avail to provide the interface for attribute value list.
> > - Add comma for the last element in the const integer array.
> > - Refine each ADC label text.
> > - In read_label callback, replace snprintf to sysfs_emit.
> >
> > ---
> >  .../ABI/testing/sysfs-bus-iio-adc-rtq6056          |   6 +
> >  drivers/iio/adc/Kconfig                            |  15 +
> >  drivers/iio/adc/Makefile                           |   1 +
> >  drivers/iio/adc/rtq6056.c                          | 651 +++++++++++++=
++++++++
> >  4 files changed, 673 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> >  create mode 100644 drivers/iio/adc/rtq6056.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056 b/Docu=
mentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> > new file mode 100644
> > index 00000000..e89d15b
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> > @@ -0,0 +1,6 @@
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage0_inte=
gration_time
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage1_inte=
gration_time
> > +KernelVersion:       5.20
> > +Contact:     cy_huang@richtek.com
> > +Description:
> > +             Each voltage conversion time in uS
>
> Please move this entry to sysfs-bus-iio
>
> It's a natural extension of existing standard ABI so doesn't need to be i=
n
> a driver specific documentation file.
>
> However, way back in patch 1 I gave feedback on why we don't normally use=
 integration time
> for voltage channels and I thought you were changing this...
>
I didn't intend to change this. Just cannot find any suitable
attribute for this feature.
From the IC interrnal, there's only one set of ADC.
And the conversion order is bus/shunt......, average sample count to
control the sample update interval.
That' why the sample frequency is calculated by one second to divide
[(bus_ct + shunt_ct) *  average sample bit] (us)

If it's not suitable for this attribute, I think it's better to change
it as file attribute, not IIO channel attribute.

How do you think?
> ...
>
> > +static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
> > +                                 struct iio_chan_spec const *ch,
> > +                                 int *val)
> > +{
> > +     struct device *dev =3D priv->dev;
> > +     unsigned int addr =3D ch->address;
> > +     unsigned int regval;
> > +     int ret;
> > +
> > +     pm_runtime_get_sync(dev);
> > +     ret =3D regmap_read(priv->regmap, addr, &regval);
> > +     pm_runtime_mark_last_busy(dev);
> > +     pm_runtime_put(dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Power and VBUS is unsigned 16-bit, others are signed 16-bit */
> > +     if (addr =3D=3D RTQ6056_REG_BUSVOLT || addr =3D=3D RTQ6056_REG_PO=
WER)
> > +             *val =3D regval;
> > +     else
> > +             *val =3D sign_extend32(regval, 16);
> > +
>
> One blank line only.
>
> > +
> > +     return IIO_VAL_INT;
> > +}
> > +
> ...
>
>
> > +
> > +static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
> > +                              struct iio_chan_spec const *chan, int va=
l,
> > +                              int val2, long mask)
> > +{
> > +     struct rtq6056_priv *priv =3D iio_priv(indio_dev);
> > +
> > +     if (iio_buffer_enabled(indio_dev))
>
> This is racy as can enter buffered mode immediately after this check.
> Use iio_device_claim_direct_mode() to avoid any races around this.
>
for the shunt resistor attribute write, also?
> > +             return -EBUSY;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_INT_TIME:
> > +             return rtq6056_adc_set_conv_time(priv, chan, val);
> > +     case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > +             return rtq6056_adc_set_average(priv, val);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
>
>
> > +
> > +static void rtq6056_remove(void *dev)
> > +{
> > +     pm_runtime_dont_use_autosuspend(dev);
> > +     pm_runtime_disable(dev);
> > +     pm_runtime_set_suspended(dev);
>
> There isn't anything here to push the device into a suspend state, so why
> does calling pm_runtime_set_suspended() make sense?
>
As I know, It is needed, at least 'pm_runtime_set_suspended' must be kept.

To think one case, adc is reading, module is removing.
Who  will change the IC state to off?

pm_runtime is already disabled, the IC will be kept in 'active', right?
> > +}
> > +
> >
> > +
> > +static int rtq6056_probe(struct i2c_client *i2c)
> > +{
> > +     struct iio_dev *indio_dev;
> > +     struct rtq6056_priv *priv;
> > +     struct device *dev =3D &i2c->dev;
> > +     struct regmap *regmap;
> > +     unsigned int vendor_id, shunt_resistor_uohm;
> > +     int ret;
> > +
> > +     if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WORD_DA=
TA))
> > +             return -EOPNOTSUPP;
> > +
> > +     indio_dev =3D devm_iio_device_alloc(dev, sizeof(*priv));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     priv =3D iio_priv(indio_dev);
> > +     priv->dev =3D dev;
> > +     priv->vshuntct_us =3D priv->vbusct_us =3D 1037;
> > +     priv->avg_sample =3D 1;
> > +     i2c_set_clientdata(i2c, priv);
> > +
> > +     regmap =3D devm_regmap_init_i2c(i2c, &rtq6056_regmap_config);
> > +     if (IS_ERR(regmap))
> > +             return dev_err_probe(dev, PTR_ERR(regmap),
> > +                                  "Failed to init regmap\n");
> > +
> > +     priv->regmap =3D regmap;
> > +
> > +     ret =3D regmap_read(regmap, RTQ6056_REG_MANUFACTID, &vendor_id);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret,
> > +                                  "Failed to get manufacturer info\n")=
;
> > +
> > +     if (vendor_id !=3D RTQ6056_VENDOR_ID)
> > +             return dev_err_probe(dev, -ENODEV,
> > +                                  "Invalid vendor id 0x%04x\n", vendor=
_id);
> > +
> > +     ret =3D devm_regmap_field_bulk_alloc(dev, regmap, priv->rm_fields=
,
> > +                                        rtq6056_reg_fields, F_MAX_FIEL=
DS);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Failed to init regmap fie=
ld\n");
> > +
> > +     /*
> > +      * By default, configure average sample as 1, bus and shunt conve=
rsion
> > +      * timea as 1037 microsecond, and operating mode to all on.
> > +      */
> > +     ret =3D regmap_write(regmap, RTQ6056_REG_CONFIG, RTQ6056_DEFAULT_=
CONFIG);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret,
> > +                                  "Failed to enable continuous sensing=
\n");
> > +
> > +     pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
> > +     pm_runtime_use_autosuspend(dev);
> > +     pm_runtime_set_active(dev);
> > +     pm_runtime_mark_last_busy(dev);
> > +     pm_runtime_enable(dev);
>
> Look at whether you can use devm_pm_runtime_enable()
> Note it handles disabling autosuspend for you.
>
> When using runtime_pm() you want to ensure that the device works without
> runtime pm support being enabled.  As such, you turn the device on before
> enabling runtime_pm() and (this is missing I think) turn it off after dis=
abling
> runtime pm.  So I'd expect a devm_add_action_or_reset() call to unwind
> setting the device into continuous sending above.
>
If so, I think it's better to configure the device keep in off state
in probe stage.
The calling order may need to be changed as below
devm_add_action_or_reset...

pm_runtime_set_autosuspend_delay
pm_runtime_use_auto_suspend
devm_pm_runtime_enable

> > +
> > +     ret =3D devm_add_action_or_reset(dev, rtq6056_remove, dev);
>
> The callback naming is too generic. It should give some indication
> of what it is undoing (much of probe is handled by other devm_ callbacks)=
.
>
How about to change the name to 'rtq6056_enter_shutdown_state'?
And in this function, to change the device state in shutdown with
'pm_runtime_set_suspended' API.
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* By default, use 2000 micro-ohm resistor */
> > +     shunt_resistor_uohm =3D 2000;
> > +     device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> > +                              &shunt_resistor_uohm);
> > +
> > +     ret =3D rtq6056_set_shunt_resistor(priv, shunt_resistor_uohm);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret,
> > +                                  "Failed to init shunt resistor\n");
> > +
> > +     indio_dev->name =3D "rtq6056";
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +     indio_dev->channels =3D rtq6056_channels;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(rtq6056_channels);
> > +     indio_dev->info =3D &rtq6056_info;
> > +
> > +     ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +                                           rtq6056_buffer_trigger_hand=
ler,
> > +                                           NULL);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret,
> > +                                  "Failed to allocate iio trigger buff=
er\n");
> > +
> > +     return devm_iio_device_register(dev, indio_dev);
> > +}
>
> > +
> > +static const struct dev_pm_ops rtq6056_pm_ops =3D {
> > +     RUNTIME_PM_OPS(rtq6056_runtime_suspend, rtq6056_runtime_resume, N=
ULL)
>
> Is there any reason we can't use these same ops to achieve at least some =
power
> saving in suspend?  i.e. use DEFINE_RUNTIME_PM_OPS()
                                                 ~~~~~~~~~~~~~~~~~~~~~~~
                                                 Where can I find this?
>
> I have tidying this up in existing drivers on my todo list as I think it =
is almost
> always a good idea.  Note this is why there isn't a define to create the
> particular combination you have here.
>
If there's no combination like as that one, why  not unify it  to
'_DEFINE_DEV_PM_OPS'?
> > +};
> > +
>
