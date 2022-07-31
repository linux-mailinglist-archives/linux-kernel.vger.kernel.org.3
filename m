Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA82585FF8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbiGaQsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbiGaQsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:48:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE90101E3;
        Sun, 31 Jul 2022 09:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AF0E60F2F;
        Sun, 31 Jul 2022 16:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138D8C433C1;
        Sun, 31 Jul 2022 16:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659286116;
        bh=IKkkDjy8UGLgZ46vcwSqvLNnr3yuB44rwZPMd7wRBsU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kkLoP54GuCdqkuHodDosluzdCfEstrjF5X2hR9Fr9/HtrJ2DqTPexZFYpo+7rfJgV
         7zPNAvSsn0NuijKJnlH9UY7PzX3ocn1FADtMFK8iGNF3L+AMScinS7L22Zeh2BN5Bs
         L7Ovs2A8mXooxDJs/AbDPGFkHY+Uh5eCdvmhjp4FEDOvcGHYgbwEr8MxSdY50Y6pKv
         mjpRo3O3iBFDiRg3p2LeqOwhvZh/clIGeMXiCZpXGipVBpALLwt8ACgFQt7/vCj4Z8
         SB1GMPJDqE9a5cFvYgio54kxVHQ6d5boTcxOLJy9rgSKa8moySCiZliqkgKkS711dP
         p8ttstuvtUoiA==
Date:   Sun, 31 Jul 2022 17:58:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: afe/rescale: Add support for converting scale
 avail table
Message-ID: <20220731175848.3f557174@jic23-huawei>
In-Reply-To: <MBZEFR.J5QW1P07Y388@crapouillou.net>
References: <20220721191526.374152-1-paul@crapouillou.net>
        <20220721191526.374152-4-paul@crapouillou.net>
        <b413604e-8a94-a31d-35ce-52eb2cc78a46@axentia.se>
        <MBZEFR.J5QW1P07Y388@crapouillou.net>
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

On Fri, 22 Jul 2022 09:52:34 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Peter,
>=20
> Le ven., juil. 22 2022 at 00:16:31 +0200, Peter Rosin <peda@axentia.se>=20
> a =C3=A9crit :
> > Hi!
> >=20
> > 2022-07-21 at 21:15, Paul Cercueil wrote: =20
> >>  When the IIO channel has a scale_available attribute, we want the=20
> >> values
> >>  contained to be properly converted the same way the scale value is.
> >>=20
> >>  Since rescale_process_scale() may change the encoding type, we must
> >>  convert the IIO_AVAIL_LIST to a IIO_AVAIL_LIST_WITH_TYPE.
> >>=20
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >>   drivers/iio/afe/iio-rescale.c   | 85=20
> >> +++++++++++++++++++++++++++++++++
> >>   include/linux/iio/afe/rescale.h |  2 +
> >>   2 files changed, 87 insertions(+)
> >>=20
> >>  diff --git a/drivers/iio/afe/iio-rescale.c=20
> >> b/drivers/iio/afe/iio-rescale.c
> >>  index 6949d2151025..5c9970b93384 100644
> >>  --- a/drivers/iio/afe/iio-rescale.c
> >>  +++ b/drivers/iio/afe/iio-rescale.c
> >>  @@ -232,6 +232,18 @@ static int rescale_read_avail(struct iio_dev=20
> >> *indio_dev,
> >>   		*type =3D IIO_VAL_INT;
> >>   		return iio_read_avail_channel_raw(rescale->source,
> >>   						  vals, length);
> >>  +	case IIO_CHAN_INFO_SCALE:
> >>  +		if (rescale->chan_processed) { =20
> >=20
> > I think it is wrong to simply feed the info-scale to the source=20
> > channel if it
> > happens to be processed. It still needs the inverse rescale. But see=20
> > below. =20
>=20
> Yes, when I started working on that patchset, processed channels=20
> weren't a thing, and I don't think I understood what they are about.
>=20
> >  =20
> >>  +			return iio_read_avail_channel_attribute(rescale->source,
> >>  +								vals, type,
> >>  +								length,
> >>  +								IIO_CHAN_INFO_SCALE);
> >>  +		} else if (rescale->scale_len) {
> >>  +			*length =3D rescale->scale_len;
> >>  +			*vals =3D rescale->scale_data;
> >>  +			return IIO_AVAIL_LIST_WITH_TYPE;
> >>  +		}
> >>  +		fallthrough;
> >>   	default:
> >>   		return -EINVAL;
> >>   	}
> >>  @@ -266,11 +278,74 @@ static ssize_t rescale_write_ext_info(struct=20
> >> iio_dev *indio_dev,
> >>   					  buf, len);
> >>   }
> >>=20
> >>  +static int rescale_init_scale_avail(struct device *dev, struct=20
> >> rescale *rescale)
> >>  +{
> >>  +	int ret, type, length, *data;
> >>  +	const int *scale_raw;
> >>  +	unsigned int i;
> >>  +	size_t out_len;
> >>  +
> >>  +	ret =3D iio_read_avail_channel_attribute(rescale->source,=20
> >> &scale_raw,
> >>  +					       &type, &length,
> >>  +					       IIO_CHAN_INFO_SCALE);
> >>  +	if (ret < 0)
> >>  +		return ret;
> >>  +
> >>  +	switch (ret) {
> >>  +	case IIO_AVAIL_LIST_WITH_TYPE:
> >>  +		out_len =3D length;
> >>  +		break;
> >>  +	case IIO_AVAIL_LIST:
> >>  +		if (type =3D=3D IIO_VAL_INT)
> >>  +			out_len =3D length * 3 / 1;
> >>  +		else
> >>  +			out_len =3D length * 3 / 2;
> >>  +		break;
> >>  +	default:
> >>  +		/* TODO: Support IIO_AVAIL_RANGE */
> >>  +		return -EOPNOTSUPP;
> >>  +	}
> >>  +
> >>  +	data =3D devm_kzalloc(dev, sizeof(*data) * out_len, GFP_KERNEL);
> >>  +	if (!data)
> >>  +		return -ENOMEM;
> >>  +
> >>  +	if (ret =3D=3D IIO_AVAIL_LIST_WITH_TYPE) {
> >>  +		memcpy(data, scale_raw, sizeof(*scale_raw) * length);
> >>  +	} else if (type =3D=3D IIO_VAL_INT) {
> >>  +		for (i =3D 0; i < length; i++) {
> >>  +			data[i * 3 + 0] =3D scale_raw[i];
> >>  +			data[i * 3 + 2] =3D IIO_VAL_INT;
> >>  +		}
> >>  +	} else {
> >>  +		for (i =3D 0; i < length / 2; i++) {
> >>  +			data[i * 3 + 0] =3D scale_raw[i * 2];
> >>  +			data[i * 3 + 1] =3D scale_raw[i * 2 + 1];
> >>  +			data[i * 3 + 2] =3D type;
> >>  +		}
> >>  +	}
> >>  +
> >>  +	for (i =3D 0; i < out_len; i +=3D 3) {
> >>  +		ret =3D rescale_process_scale(rescale, data[i + 2],
> >>  +					    &data[i], &data[i + 1]);
> >>  +		if (ret < 0)
> >>  +			return ret;
> >>  +
> >>  +		data[i + 2] =3D ret;
> >>  +	}
> >>  +
> >>  +	rescale->scale_len =3D out_len;
> >>  +	rescale->scale_data =3D data;
> >>  +
> >>  +	return 0;
> >>  +}
> >>  +
> >>   static int rescale_configure_channel(struct device *dev,
> >>   				     struct rescale *rescale)
> >>   {
> >>   	struct iio_chan_spec *chan =3D &rescale->chan;
> >>   	struct iio_chan_spec const *schan =3D rescale->source->channel;
> >>  +	int ret;
> >>=20
> >>   	chan->indexed =3D 1;
> >>   	chan->output =3D schan->output;
> >>  @@ -303,6 +378,16 @@ static int rescale_configure_channel(struct=20
> >> device *dev,
> >>   	    !rescale->chan_processed)
> >>   		chan->info_mask_separate_available |=3D BIT(IIO_CHAN_INFO_RAW);
> >>=20
> >>  +	if (iio_channel_has_available(schan, IIO_CHAN_INFO_SCALE)) {
> >>  +		chan->info_mask_separate_available |=3D BIT(IIO_CHAN_INFO_SCALE);
> >>  +
> >>  +		if (!rescale->chan_processed) {
> >>  +			ret =3D rescale_init_scale_avail(dev, rescale);
> >>  +			if (ret)
> >>  +				return ret;
> >>  +		}
> >>  +	}
> >>  + =20
> >=20
> > Does a (sane) processed channel really have a scale? That seems a bit=20
> > fringe.
> > Wouldn't it be better to conditionally publish availability of=20
> > info-scale so
> > that it isn't visible for processed channels and dodge that=20
> > rabbit-hole? In
> > either case, the above commented implementation of info-scale for=20
> > rescaled
> > processed channels is wrong (I think...). =20
>=20
> I could set the IIO_CHAN_INFO_SCALE only for non-processed channels,=20
> since this is what I can test with.

Indeed both nonsensical for PROCESSED channels to have a scale and in the
rare corner case where it happens you shouldn't apply it anyway.

I'm struggling to think of when it might happen due to maintaining
backwards compatibility and similar (the reason we have channels with
both PROCESSED and RAW) but in those cases I don't think we'd have
SCALE because they tend to be devices with nasty non linear transfer
functions where SCALE isn't appropriate.

Jonathan


>=20
> Cheers,
> -Paul
>=20
> >>   	return 0;
> >>   }
> >>=20
> >>  diff --git a/include/linux/iio/afe/rescale.h=20
> >> b/include/linux/iio/afe/rescale.h
> >>  index 6eecb435488f..74de2962f864 100644
> >>  --- a/include/linux/iio/afe/rescale.h
> >>  +++ b/include/linux/iio/afe/rescale.h
> >>  @@ -26,6 +26,8 @@ struct rescale {
> >>   	s32 numerator;
> >>   	s32 denominator;
> >>   	s32 offset;
> >>  +	int scale_len;
> >>  +	int *scale_data;
> >>   };
> >>=20
> >>   int rescale_process_scale(struct rescale *rescale, int scale_type, =
=20
>=20
>=20

