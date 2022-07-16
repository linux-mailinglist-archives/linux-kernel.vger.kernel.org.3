Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E22C576FDF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 17:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiGPPaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 11:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPPaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 11:30:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A060D5FAD;
        Sat, 16 Jul 2022 08:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 511AEB8090C;
        Sat, 16 Jul 2022 15:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6384DC34114;
        Sat, 16 Jul 2022 15:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657985418;
        bh=MnjQDi+s18Y6mvbMliByj9VVbSII2QdLpTH5ln/Iyc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NrLTZf+hVCQ3AUXaDXZBd2JKqS7qVbOI2P460HMiA4EDRwAICne34NFF7LOLnvPmC
         DAhwIXdSq2v8gW0RjCUFm608VxISs1Br3S+yHPU7yjKe0RNdHffVMQrmmS/NyrkKsp
         G+yxNP8WuU7WSyaaJbiY4lY/wSPyZj9Hi6RKDYjR48/9GEl7fx8SKhEokz5gAp5hFw
         5VChnBGaiVD62iHVza814arvMsKaTaIX0ELPlUSa5A6BprSpNZ/nq/lmM0+R1QvQ+7
         bGtHlmsAynKkco17d4wL3+s5qzM+FZ0pv9dUFfTRNulNqItFMkhpEZ+rs9I9QkhFcz
         nVO/BDn6h2Lcw==
Date:   Sat, 16 Jul 2022 16:40:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mxc4005: report orientation of
 accelerometer
Message-ID: <20220716164012.473f59d9@jic23-huawei>
In-Reply-To: <7f562418-f56c-07bb-27b4-d2e54834ef2f@theobroma-systems.com>
References: <20220615110240.684744-1-foss+kernel@0leil.net>
        <20220619152726.030f8e27@jic23-huawei>
        <7f562418-f56c-07bb-27b4-d2e54834ef2f@theobroma-systems.com>
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

On Mon, 4 Jul 2022 18:49:54 +0200
Quentin Schulz <quentin.schulz@theobroma-systems.com> wrote:

> Hi Jonathan,
>=20
> On 6/19/22 16:27, Jonathan Cameron wrote:
> > On Wed, 15 Jun 2022 13:02:40 +0200
> > Quentin Schulz <foss+kernel@0leil.net> wrote:
> >  =20
> >> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> >> =20
> > Hi Quentin,
> >=20
> > Interesting / horribly ill defined little feature ;)
> >  =20
> >> The accelerometer can report precise values for x, y and z acceleratio=
ns
> >> but it can also simply report its orientation on XY plane and Z axis.
> >>
> >> Since the orientation of the device may be enough information for
> >> userspace and allows to avoid expensive fusion algorithms, let's add
> >> support for it.
> >>
> >> The orientation register stores a 2b value for XY plane orientation:
> >> between 225=C2=B0 and 315=C2=B0, returns 0, between 315=C2=B0 and 45=
=C2=B0, 1, between 45=C2=B0
> >> and 135=C2=B0, 2 and between 135=C2=B0 and 225=C2=B0, 3. We "round" th=
ose to 270=C2=B0,
> >> 0=C2=B0, 90=C2=B0 and 180=C2=B0 degrees. =20
> >=20
> > Wow. The datasheet description of this very confusing... =20
>=20
> I'm relieved I'm not the only one confused by this datasheet :)

Probably 100s of people world wide :)

>=20
> > One key thing is we need to be careful of is that tilt (x/y is
> > not always available - but rather shows the last, and probably
> > now garbage, value) =20
>=20
> Being pedantic here, not garbage, but outdated. This register exists so=20
> that the values aren't garbage (at the cost of being outdated). Except=20
> this small notion, I agree on the statement.
>=20
> >>
> >> For Z axis, the register bit returns 0 if facing the user, 1 otherwise,
> >> which the driver translates to 0=C2=B0 and 180=C2=B0 respectively. =20
> >=20
> > I assume facing up vs facing down?  User might be lying on their
> > back in which case this description doesn't work.  The datasheet =20
>=20
> Correct, I was playing with the device while seated, hence the bias. But=
=20
> yes, everything is relative to Earth gravity, so face up/down is a=20
> better description indeed.
>=20
> > also talks about the case where g lies near the XY plane and hence
> > the z axis is horizontal.
> >=20
> >  =20
> >>
> >> Those values are proper if the accelerometer is mounted such that the
> >> XYZ axes are as follows when the device is facing the user in portrait
> >> mode (respecting the right-hand rule):
> >>
> >>       y
> >>       ^
> >>       |
> >>       |
> >>       |
> >>       +----------> x
> >>      /
> >>     /
> >>    /
> >>   L
> >> z
> >>
> >> Since this information is very basic, imprecise (only 4 values for XY
> >> plane and 2 for Z axis) and can be extrapolated from the actual,
> >> precise, x, y and z acceleration values, it is not made available
> >> through buffers.
> >>
> >> A change in XY plane or Z axis orientation can also trigger an interru=
pt
> >> but this feature is not added in this commit.
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> >> ---
> >>   drivers/iio/accel/mxc4005.c | 39 +++++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 39 insertions(+)
> >>
> >> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> >> index b3afbf064915..61f24058d239 100644
> >> --- a/drivers/iio/accel/mxc4005.c
> >> +++ b/drivers/iio/accel/mxc4005.c
> >> @@ -20,6 +20,11 @@
> >>   #define MXC4005_IRQ_NAME		"mxc4005_event"
> >>   #define MXC4005_REGMAP_NAME		"mxc4005_regmap"
> >>  =20
> >> +#define MXC4005_REG_TILT_ORIENT		0x01
> >> +#define MXC4005_REG_TILT_ORIENT_Z_MASK		BIT(6) =20
> >=20
> > I think you need to deal with BIT(7) as well.
> >  =20
> >> +#define MXC4005_REG_TILT_ORIENT_XY_MASK		GENMASK(5, 4)
> >> +#define MXC4005_REG_TILT_ORIENT_XY_SHIFT	4 =20
> >=20
> > Don't define the shift, you can use FIELD_GET(MASK, val)
> >  =20
>=20
> Wasn't aware of this neat macro, thanks for the heads up.
>=20
> >> +
> >>   #define MXC4005_REG_XOUT_UPPER		0x03
> >>   #define MXC4005_REG_XOUT_LOWER		0x04
> >>   #define MXC4005_REG_YOUT_UPPER		0x05
> >> @@ -96,6 +101,7 @@ static const struct attribute_group mxc4005_attrs_g=
roup =3D {
> >>   static bool mxc4005_is_readable_reg(struct device *dev, unsigned int=
 reg)
> >>   {
> >>   	switch (reg) {
> >> +	case MXC4005_REG_TILT_ORIENT:
> >>   	case MXC4005_REG_XOUT_UPPER:
> >>   	case MXC4005_REG_XOUT_LOWER:
> >>   	case MXC4005_REG_YOUT_UPPER:
> >> @@ -214,6 +220,28 @@ static int mxc4005_read_raw(struct iio_dev *indio=
_dev,
> >>   	int ret;
> >>  =20
> >>   	switch (mask) {
> >> +	case IIO_CHAN_INFO_PROCESSED:
> >> +		switch (chan->type) {
> >> +		case IIO_ROT:
> >> +			ret =3D regmap_read(data->regmap, chan->address, val);
> >> +			if (ret < 0) {
> >> +				dev_err(data->dev, "failed to read rotation\n");
> >> +				return ret;
> >> +			}
> >> +
> >> +			if (chan->channel2 =3D=3D IIO_MOD_X_AND_Y) {
> >> +				*val &=3D MXC4005_REG_TILT_ORIENT_XY_MASK;
> >> +				*val >>=3D MXC4005_REG_TILT_ORIENT_XY_SHIFT; =20
> > FIELD_GET()
> >  =20
> >> +				/* 00 =3D 270=C2=B0; 01 =3D 0=C2=B0; 10 =3D 90=C2=B0; 11 =3D 180=
=C2=B0 */
> >> +				*val =3D (360 + (*val - 1) * 90) % 360; =20
> >=20
> > In event of tilt not being set (BIT (7)) I think you should return an e=
rror
> > code here.  -EBUSY perhaps? To reflect the fact we don't have valid dat=
a.
> >  =20
>=20
> Difficult to find the appropriate error code to return. It's not=20
> technically busy, especially if the device stays in that position=20
> forever, it'll never return a valid value.

True. It's a fun corner.  We return -EBUSY in other cases where action of
some type is needed for it to free up.  We aren't implying a retry will get
you anywhere (unlikely EAGAIN).  To be honest, I'm fine with any error code
you fancy, but I think it should be an error code.

>=20
> >> +			} else {
> >> +				*val &=3D MXC4005_REG_TILT_ORIENT_Z_MASK;
> >> +				*val =3D *val ? 180 : 0; =20
> > Documentation for this is really confusing, as it refers to a circumsta=
nce
> > when it can be assumed to be horizontal, but then doesn't define it.
> >=20
> > It might be a simple as tilt being set and thus indicating significant
> > acceleration due to gravity in the xy plane.
> > However, the Z orientation is still updated in that case...
> >  =20
>=20
> I'm wondering if it's not an exclusive validity of axes. E.g. XY plane=20
> is valid only when Z is not and vice-versa?

Maybe...  I get the feeling that scattering liberal comments through the
code along the lines of 'we think this is how it works' with datasheet
references might be the best we can do.

>=20
> "The vertical/horizontal Z axis
> orientation is determined by the same criteria used to determine the=20
> XY-plane off-axis tilt angle" seems to indicate that the TILT bit=20
> defines whether the Z axis is vertical or horizontal.
>=20
> "When the XY plane
> has a sufficiently small off-axis tilt angle, XY orientation detection=20
> is valid (and continues to be updated), and the Z
> axis is detected as horizontal" would mean Z is just not usable when XY=20
> orientation is valid (because Z is horizontal and thus does not have a=20
> big enough acceleration to be usable).
>=20
> "When off-axis tilt angle exceeds the
> threshold discussed above, the Z axis is detected as either vertical up=20
> or vertical down, depending on the sign of the
> Z axis acceleration output." could be interpreted as "when XY=20
> orientation is invalid, Z orientation is either vertical up or down".
>=20
> >> +			}
> >> +			return IIO_VAL_INT;
> >> +		default:
> >> +			return -EINVAL;
> >> +		}
> >>   	case IIO_CHAN_INFO_RAW:
> >>   		switch (chan->type) {
> >>   		case IIO_ACCEL:
> >> @@ -287,11 +315,22 @@ static const unsigned long mxc4005_scan_masks[] =
=3D {
> >>   	},							\
> >>   }
> >>  =20
> >> +#define MXC4005_CHANNEL_ORIENTATION(_axis) {			\
> >> +	.type =3D IIO_ROT,					\ =20
> >=20
> > Hmm.  Should this be rotation or inclination (so referenced
> > to gravity).  Inclination is not particularly tightly defined but the
> > point is that it is relative to gravity - kind of a special case of
> > rot.
> >=20
> > For the adis16209 we handled inclination and rotation.  I think rotation
> > in that device corresponds to XY here. (though it's oddly defined for
> > X axis, whereas I'm fairly sure it should be Z - as rotation 'about'
> > z axis). The Z one here should I think be an inclination because it's n=
ot
> > about any particular axis.
> >=20
> > We also have angle to confuse matters. In that case intent was 'between'
> > two things. Arguably all the uses of rot are as well, just that one of =
those
> > things is gravity or magnetic north.  With hindsight I think we could h=
ave
> > gotten away with one of them, but hard to tidy up now.
> >  =20
>=20
> You mentioned the three candidates I had in mind, but none seemed to=20
> perfectly match (or maybe I'm just confused about the difference between=
=20
> the three and just can't make up my mind) so I picked rotation because=20
> the English term seemed closer to what I think those values represent?
>=20
> > In conclusion, what you have here I think is best described as
> > IIO_ROT about Z axis (the XY one) =20
>=20
> I disagree, this would mean that having XY plane parallel to ground and=20
> rotate the device along the Z axis (so XY plane staying parallel to=20
> ground) should change the value of this IIO_ROT on Z axis, but it does=20
> not if I'm not mistaken (I assume because the acceleration on X and Y=20
> axes are too small because the axes are parallel to the ground).

I'm confused. Why would XY be parallel to ground?  I'm struggling to get
my head around it, but I though for rotation in the x-y plane it's z that
is always parallel to the ground (or near enough that we can sensibly estim=
ate
what is going on in the xy plane)
(I spent lots of time in my youth working with the Geometric Algebra versio=
n of this
stuff where it's the XY bivector, but that's a different story and probably
not helpful here :)

>=20
> But that also kind of highlights that IIO_ROT for Z as I've done it in=20
> the patch probably isn't correct either and inclination would probably=20
> match best?

I'm lost...  Best way forward here is probably for you to propose what
you think is the best we have with a lot of description and we see if that
aligns with my thoughts on how this should work (and anyone else who
cares to join in ;)

Foggy brain today I'm afraid...

Jonathan
>=20
> I feel like this will be an interesting discussion :)
>=20
> Cheers,
> Quentin

