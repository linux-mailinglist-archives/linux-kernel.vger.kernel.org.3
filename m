Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EF0591FE6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 15:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiHNNm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 09:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNNmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 09:42:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727FB193FD;
        Sun, 14 Aug 2022 06:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 231B4B80AEF;
        Sun, 14 Aug 2022 13:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB60C433D6;
        Sun, 14 Aug 2022 13:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660484540;
        bh=+xdN7oEY+9WqrPGLxQ2PsJ7z5Wp8A3zEOWd7PA8ZFJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mMHxT07i2boHESQ31CF3NEOyDRe/KKj/BDNLEKuHp+1Swp8j3/HHNyU8Bv7kVCQ+S
         4hzBsjfZhVvaW+07zODSxiALgmPNQyEpvHAgma2IpNnBVRRiLW2aax9nFmpu4pZBVD
         RFdbPKxYJNnZ9miIjCKNCySWd3ll91CuCZ7huorMtkiiPwA0q8j6M/Uu+8dTcPCZMM
         C8rxGEqifYP0jo+qBhqxVIo1+Jmew7LHnV43U/kN27Nnze9kO1s7Ng5fKszVRUybsQ
         dfSVCHfBSoaYes3qfNNk8vk3qCQCqwA6Q0mG8yiYywEWa1GIPfX4/SHaiTLhJDEi/C
         kyxXkdWkIUdFA==
Date:   Sun, 14 Aug 2022 14:52:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/5] iio: pressure: bmp280: Fix alignment for DMA
 safety
Message-ID: <20220814145249.701f1261@jic23-huawei>
In-Reply-To: <ba71ba74e9115bebce82a2afbd5d62a2e4ecf666.camel@gmail.com>
References: <cover.1659872590.git.ang.iglesiasg@gmail.com>
        <49086f5c1401d7d28ebf921a67b49f8403ddb16a.1659872590.git.ang.iglesiasg@gmail.com>
        <CAHp75Vfanb+tZe_D5_hPWn2BrOEkds9i7AZzD5Xc1M5a9GK6qg@mail.gmail.com>
        <ba71ba74e9115bebce82a2afbd5d62a2e4ecf666.camel@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2022 11:59:50 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> On lun, 2022-08-08 at 10:53 +0200, Andy Shevchenko wrote:
> > On Sun, Aug 7, 2022 at 1:56 PM Angel Iglesias <ang.iglesiasg@gmail.com>=
 wrote: =20
> > >=20
> > > Adds DMA-safe buffers to driver data struct to store raw data from se=
nsors
> > >=20
> > > The multiple buffers used thorough the driver share the same memory
> > > allocated as part of the device data instance. The union containing
> > > the buffers is aligned to allow safe usage with DMA operations, such
> > > as regmap bulk read calls. =20
> >=20
> > ...
> >  =20
> > > =C2=A0#include <linux/completion.h>
> > > =C2=A0#include <linux/pm_runtime.h>
> > > =C2=A0#include <linux/random.h> =20
> >=20
> > + Blank line.
> >  =20
> > > +#include <asm/unaligned.h> =20
> >=20
> > ...
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* sensor data buffer */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 u8 data[3];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* calibration data buffers */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 __le16 bmp280_cal[BMP280_CONTIGUOUS_CALIB_REGS / 2];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 __be16 bmp180_cal[BMP180_REG_CALIB_COUNT / 2];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } buf __aligned(IIO_DMA_MINALIG=
N); =20
> >=20
> > Hmm... And which field in the struct defines which of the buffers is be=
ing
> > used? =20

I think the answer to this is which callback is set in the chip_data struct=
ure
defines which one of the calibration buffers is in use for that purpose.
The one used for everything else is defined by the code path, not an explic=
it
variable.

There might be some (I haven't looked) but lock protection is unnecessary as
_cal buffers used before we register the device so there is no concurrency =
yet.

>=20
> There's no concurrent use of the buffers. Calibration data is read during=
 the
> initialization of the sensor. The data buffer is then used to store the r=
aw data
> read from the measurement regs, and is also used a few times to read a th=
e humid
> calibration on BME280, but again, in a sequential, non concurrent manner.
>=20
> Regarding which calibration buffer is used, is the same situation as the
> calibration data union, helper functions and callback for the sensor use =
the
> buffer reserved for the sensor. I don't know if this is the best approach=
, I
> just followed what I saw previously on this drivers and others from IIO
> subsystem.
>=20
> > Also, do you need a non-anonymous union? =20
>=20
> No I could use an anonymous function. Should I change it to an anonymous =
union?
yes.  That seems a good idea.

It's worth giving unions a name if you are using them such that you write v=
ia
one element and read via another (e.g. for type conversion) but where it's =
really
just a case of potential space saving like this, nice to use an anonymous u=
nion
and shorten all the lines accessing the elements.

>=20
> > > =C2=A0}; =20
> >=20
> > ...
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* parse temperature calibratio=
n data */ =20
> >=20
> > Be consistent! Check all your patches for the consistency (comments,
> > other code style, etc).
> >=20
> > ...
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 calib->H5 =3D sign_extend32(((g=
et_unaligned_le16(data->buf.data) >> 4)
> > > & 0xfff), 11); =20
> >=20
> > (It's not directly related to this change, but good to ask)
> > Are you going to change all those masks to use GENMASK()? =20
>=20
> I thought I made sense refresh previous code on the driver to use GENMASK=
() and
> FIELD_PREP and FIELD_GET helpers to use the same standards on the BMP380
> codepath. Having in mind other feedback you gave me on this iteration, th=
is
> GENMASK() and FIELD_PREP/FIELD_GET changes make more sense in a prerequis=
ite
> patch and not as part of patch 1.

Agreed. I was thinking the same thing.  Pulling out that conversion as a pr=
ecursor
nop cleanup will make all the subsequent changes more readable. Great!

>=20
> > ...
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bmp180_calib *calib =3D =
&data->calib.bmp180;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bmp180_calib *calib =3D =
&data->calib.bmp180; =20
> >=20
> > Exactly my point given the previous patch, now you have a ping-pong
> > style of changes: the introduced line in the series is being touched
> > again in the very same series without any need. =20
>=20
> Yup, apologies. I'll be more careful

I'm not particularly fussy about reverse xmas tree so wouldn't normally
advocate a cleanup patch just to reorder local variable definitions.
However, I think in this case it would be good to have such a precursor
patch so as to make the ordering more logical for the additions made
by the rest of the series.

Thanks,

Jonathan

>=20
> > ...
> >  =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 oss =3D data->oversampl=
ing_press;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
> >=20
> > Ditto.
> >  =20
>=20

