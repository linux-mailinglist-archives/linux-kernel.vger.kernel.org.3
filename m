Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C3057705E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 19:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiGPR2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 13:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGPR2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 13:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6901B7AA;
        Sat, 16 Jul 2022 10:27:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3FF2611CA;
        Sat, 16 Jul 2022 17:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C91C34114;
        Sat, 16 Jul 2022 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657992478;
        bh=2afeDttOmm60hnx34rTpfzx2xBQ+5FSyhDPGdmZkTxk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tI4/UDHtI9+DjRZ0KIkIS6AmlPn2KNlj8I2d4jolrSXDOKzIfkCGebU+r3DPVwFrt
         ouQiB8essL2rwuuf1AfLAwQEgOhrk4p8/KBfBqkiroWZhHOGuDIB27RnVXuKQ92eUT
         ti09S11uruYagJX8uFPaThbWa/Kd5fOoVTcUakfjbIRnjLhG0C745yQdrP9AwPkr7v
         /T7ibX9ORaYFsB4ziU+tguXHkgQDQQ2eGcVkDD9GT6AKGHG5rYUJtxUfL4ZGF8SN9/
         IHJGl35CibYoarRzXUmxIejGmyDvFj2+hbRH/rA9ciFq2jLRInAc0G7tHAdmVv2p7S
         AFuCEugmT7QQQ==
Date:   Sat, 16 Jul 2022 18:37:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] iio: adc: Add rtq6056 support
Message-ID: <20220716183750.311f449c@jic23-huawei>
In-Reply-To: <CADiBU3_KQ=WvD-1E4SODkdEY254_b-covw-0SHcAaF3XQqdbaQ@mail.gmail.com>
References: <1657116702-24161-1-git-send-email-u0084500@gmail.com>
        <1657116702-24161-3-git-send-email-u0084500@gmail.com>
        <20220707183027.342f6c88@jic23-huawei>
        <CADiBU3_KQ=WvD-1E4SODkdEY254_b-covw-0SHcAaF3XQqdbaQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 10:48:17 +0800
ChiYuan Huang <u0084500@gmail.com> wrote:

> Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=888=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E5=87=8C=E6=99=A81:20=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Wed,  6 Jul 2022 22:11:42 +0800
> > cy_huang <u0084500@gmail.com> wrote:
> > =20
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > Add Richtek rtq6056 supporting.
> > >
> > > It can be used for the system to monitor load current and power with =
16-bit
> > > resolution.
> > >
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com> =20
> >
> > Various feedback inline.
> >
> > Thanks,
> >
> > Jonathan
> > =20
> > > ---
> > > Since v5
> > > - Fix kernel version text for ABI.
> > >
> > > Since v4
> > > - Add '__aligned(8)' for timestamp member in buffer_trigger_handler f=
unction.
> > > - Declare timestamp from 'int64_t' to more unified 's64'.
> > >
> > > Since v3
> > > - Refine pm_runtime API calling order in 'read_channel' API.
> > > - Fix vshunt wrong scale for divider.
> > > - Refine the comment text.
> > > - Use 'devm_add_action_or_reset' to decrease the code usage in probe
> > >   function.
> > > - Use RUNTIME_PM_OPS to replace SET_RUNTIME_PM_OPS.
> > > - minor fix for the comma.
> > > - Use pm_ptr to replace the direct assigned pm_ops.
> > >
> > > Since v2
> > > - Rename file from 'rtq6056-adc' to 'rtq6056'.
> > > - Refine the ABI, if generic already defined it, remove it and check =
the channel
> > >   report unit.
> > > - Add copyright text.
> > > - include the correct header.
> > > - change the property parsing name.
> > > - To use iio_chan_spec address field.
> > > - Refine each channel separate and shared_by_all.
> > > - Use pm_runtime and pm_runtime_autosuspend.
> > > - Remove the shutdown callback. From the HW suggestion, it's not reco=
mmended to
> > >   use battery as the power supply.
> > > - Check all scale unit (voltage->mV, current->mA, power->milliWatt).
> > > - Use the read_avail to provide the interface for attribute value lis=
t.
> > > - Add comma for the last element in the const integer array.
> > > - Refine each ADC label text.
> > > - In read_label callback, replace snprintf to sysfs_emit.
> > >
> > > ---
> > >  .../ABI/testing/sysfs-bus-iio-adc-rtq6056          |   6 +
> > >  drivers/iio/adc/Kconfig                            |  15 +
> > >  drivers/iio/adc/Makefile                           |   1 +
> > >  drivers/iio/adc/rtq6056.c                          | 651 +++++++++++=
++++++++++
> > >  4 files changed, 673 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-rtq60=
56
> > >  create mode 100644 drivers/iio/adc/rtq6056.c
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056 b/Do=
cumentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> > > new file mode 100644
> > > index 00000000..e89d15b
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> > > @@ -0,0 +1,6 @@
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage0_in=
tegration_time
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltage1_in=
tegration_time
> > > +KernelVersion:       5.20
> > > +Contact:     cy_huang@richtek.com
> > > +Description:
> > > +             Each voltage conversion time in uS =20
> >
> > Please move this entry to sysfs-bus-iio
> >
> > It's a natural extension of existing standard ABI so doesn't need to be=
 in
> > a driver specific documentation file.
> >
> > However, way back in patch 1 I gave feedback on why we don't normally u=
se integration time
> > for voltage channels and I thought you were changing this...
> > =20
> I didn't intend to change this. Just cannot find any suitable
> attribute for this feature.
> From the IC interrnal, there's only one set of ADC.
> And the conversion order is bus/shunt......, average sample count to
> control the sample update interval.
> That' why the sample frequency is calculated by one second to divide
> [(bus_ct + shunt_ct) *  average sample bit] (us)
>=20
> If it's not suitable for this attribute, I think it's better to change
> it as file attribute, not IIO channel attribute.
>=20
> How do you think?

As mentioned in patch 1 discussion, we've done this before (IIRC) by defini=
ng per channel
sampling frequencies and not providing a general one.

We might want to consider improving the documentation in ABI/testing/sysfs-=
bus-iio
to make that clear however.

> > ...
> > =20
> > > +static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
> > > +                                 struct iio_chan_spec const *ch,
> > > +                                 int *val)
> > > +{
> > > +     struct device *dev =3D priv->dev;
> > > +     unsigned int addr =3D ch->address;
> > > +     unsigned int regval;
> > > +     int ret;
> > > +
> > > +     pm_runtime_get_sync(dev);
> > > +     ret =3D regmap_read(priv->regmap, addr, &regval);
> > > +     pm_runtime_mark_last_busy(dev);
> > > +     pm_runtime_put(dev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     /* Power and VBUS is unsigned 16-bit, others are signed 16-bit =
*/
> > > +     if (addr =3D=3D RTQ6056_REG_BUSVOLT || addr =3D=3D RTQ6056_REG_=
POWER)
> > > +             *val =3D regval;
> > > +     else
> > > +             *val =3D sign_extend32(regval, 16);
> > > + =20
> >
> > One blank line only.
> > =20
> > > +
> > > +     return IIO_VAL_INT;
> > > +}
> > > + =20
> > ...
> >
> > =20
> > > +
> > > +static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
> > > +                              struct iio_chan_spec const *chan, int =
val,
> > > +                              int val2, long mask)
> > > +{
> > > +     struct rtq6056_priv *priv =3D iio_priv(indio_dev);
> > > +
> > > +     if (iio_buffer_enabled(indio_dev)) =20
> >
> > This is racy as can enter buffered mode immediately after this check.
> > Use iio_device_claim_direct_mode() to avoid any races around this.
> > =20
> for the shunt resistor attribute write, also?
> > > +             return -EBUSY;
> > > +
> > > +     switch (mask) {
> > > +     case IIO_CHAN_INFO_INT_TIME:
> > > +             return rtq6056_adc_set_conv_time(priv, chan, val);
> > > +     case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > > +             return rtq6056_adc_set_average(priv, val);
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +} =20
> >
> > =20
> > > +
> > > +static void rtq6056_remove(void *dev)
> > > +{
> > > +     pm_runtime_dont_use_autosuspend(dev);
> > > +     pm_runtime_disable(dev);
> > > +     pm_runtime_set_suspended(dev); =20
> >
> > There isn't anything here to push the device into a suspend state, so w=
hy
> > does calling pm_runtime_set_suspended() make sense?
> > =20
> As I know, It is needed, at least 'pm_runtime_set_suspended' must be kept.
>=20
> To think one case, adc is reading, module is removing.
> Who  will change the IC state to off?

That's not what set_suspended does.  We aren't telling the device to
'suspend' we are telling the runtime pm code that it already is.
If you want that to be the case, then you need to manually call whatever yo=
ur
driver needs to do to suspend the device.

Note that if runtime pm is not configured into the kernel, everything should
still work. That is you should always power the device up in probe() and do=
wn
in remove().  That powerdown is needs to not use the runtime pm paths (as t=
hey
aren't being built in such a kernel!)

>=20
> pm_runtime is already disabled, the IC will be kept in 'active', right?
> > > +}
> > > +
> > >
> > > +
> > > +static int rtq6056_probe(struct i2c_client *i2c)
> > > +{
> > > +     struct iio_dev *indio_dev;
> > > +     struct rtq6056_priv *priv;
> > > +     struct device *dev =3D &i2c->dev;
> > > +     struct regmap *regmap;
> > > +     unsigned int vendor_id, shunt_resistor_uohm;
> > > +     int ret;
> > > +
> > > +     if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WORD_=
DATA))
> > > +             return -EOPNOTSUPP;
> > > +
> > > +     indio_dev =3D devm_iio_device_alloc(dev, sizeof(*priv));
> > > +     if (!indio_dev)
> > > +             return -ENOMEM;
> > > +
> > > +     priv =3D iio_priv(indio_dev);
> > > +     priv->dev =3D dev;
> > > +     priv->vshuntct_us =3D priv->vbusct_us =3D 1037;
> > > +     priv->avg_sample =3D 1;
> > > +     i2c_set_clientdata(i2c, priv);
> > > +
> > > +     regmap =3D devm_regmap_init_i2c(i2c, &rtq6056_regmap_config);
> > > +     if (IS_ERR(regmap))
> > > +             return dev_err_probe(dev, PTR_ERR(regmap),
> > > +                                  "Failed to init regmap\n");
> > > +
> > > +     priv->regmap =3D regmap;
> > > +
> > > +     ret =3D regmap_read(regmap, RTQ6056_REG_MANUFACTID, &vendor_id);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret,
> > > +                                  "Failed to get manufacturer info\n=
");
> > > +
> > > +     if (vendor_id !=3D RTQ6056_VENDOR_ID)
> > > +             return dev_err_probe(dev, -ENODEV,
> > > +                                  "Invalid vendor id 0x%04x\n", vend=
or_id);
> > > +
> > > +     ret =3D devm_regmap_field_bulk_alloc(dev, regmap, priv->rm_fiel=
ds,
> > > +                                        rtq6056_reg_fields, F_MAX_FI=
ELDS);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret, "Failed to init regmap f=
ield\n");
> > > +
> > > +     /*
> > > +      * By default, configure average sample as 1, bus and shunt con=
version
> > > +      * timea as 1037 microsecond, and operating mode to all on.
> > > +      */
> > > +     ret =3D regmap_write(regmap, RTQ6056_REG_CONFIG, RTQ6056_DEFAUL=
T_CONFIG);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret,
> > > +                                  "Failed to enable continuous sensi=
ng\n");
> > > +
> > > +     pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
> > > +     pm_runtime_use_autosuspend(dev);
> > > +     pm_runtime_set_active(dev);
> > > +     pm_runtime_mark_last_busy(dev);
> > > +     pm_runtime_enable(dev); =20
> >
> > Look at whether you can use devm_pm_runtime_enable()
> > Note it handles disabling autosuspend for you.
> >
> > When using runtime_pm() you want to ensure that the device works without
> > runtime pm support being enabled.  As such, you turn the device on befo=
re
> > enabling runtime_pm() and (this is missing I think) turn it off after d=
isabling
> > runtime pm.  So I'd expect a devm_add_action_or_reset() call to unwind
> > setting the device into continuous sending above.
> > =20
> If so, I think it's better to configure the device keep in off state
> in probe stage.

Only keep it in off state 'if' runtime pm is configured in.
Normally you need to power the device up in probe then
enable runtime pm to turn it off again (if runtime pm is supported).
If runtime pm isn't supported, we just leave the device powered up the whole
time until remove() when we power it down.

> The calling order may need to be changed as below
> devm_add_action_or_reset...
>=20
> pm_runtime_set_autosuspend_delay
> pm_runtime_use_auto_suspend
> devm_pm_runtime_enable



>=20
> > > +
> > > +     ret =3D devm_add_action_or_reset(dev, rtq6056_remove, dev); =20
> >
> > The callback naming is too generic. It should give some indication
> > of what it is undoing (much of probe is handled by other devm_ callback=
s).
> > =20
> How about to change the name to 'rtq6056_enter_shutdown_state'?
> And in this function, to change the device state in shutdown with
> 'pm_runtime_set_suspended' API.

I think this reflects back to earlier misunderstanding of what
pm_runtime_set_suspended() actually does (assuming I have understood it
correctly).

> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     /* By default, use 2000 micro-ohm resistor */
> > > +     shunt_resistor_uohm =3D 2000;
> > > +     device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> > > +                              &shunt_resistor_uohm);
> > > +
> > > +     ret =3D rtq6056_set_shunt_resistor(priv, shunt_resistor_uohm);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret,
> > > +                                  "Failed to init shunt resistor\n");
> > > +
> > > +     indio_dev->name =3D "rtq6056";
> > > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > +     indio_dev->channels =3D rtq6056_channels;
> > > +     indio_dev->num_channels =3D ARRAY_SIZE(rtq6056_channels);
> > > +     indio_dev->info =3D &rtq6056_info;
> > > +
> > > +     ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > > +                                           rtq6056_buffer_trigger_ha=
ndler,
> > > +                                           NULL);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret,
> > > +                                  "Failed to allocate iio trigger bu=
ffer\n");
> > > +
> > > +     return devm_iio_device_register(dev, indio_dev);
> > > +} =20
> > =20
> > > +
> > > +static const struct dev_pm_ops rtq6056_pm_ops =3D {
> > > +     RUNTIME_PM_OPS(rtq6056_runtime_suspend, rtq6056_runtime_resume,=
 NULL) =20
> >
> > Is there any reason we can't use these same ops to achieve at least som=
e power
> > saving in suspend?  i.e. use DEFINE_RUNTIME_PM_OPS() =20
>                                                  ~~~~~~~~~~~~~~~~~~~~~~~
>                                                  Where can I find this?

oops. DEFINE_RUNTIME_DEV_PM_OPS()
https://elixir.bootlin.com/linux/v5.19-rc6/source/include/linux/pm_runtime.=
h#L37

> >
> > I have tidying this up in existing drivers on my todo list as I think i=
t is almost
> > always a good idea.  Note this is why there isn't a define to create the
> > particular combination you have here.
> > =20
> If there's no combination like as that one, why  not unify it  to
> '_DEFINE_DEV_PM_OPS'?
> > > +};
> > > + =20
> > =20

