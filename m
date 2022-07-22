Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA6157DEE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiGVJmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbiGVJmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:42:33 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB652CE24;
        Fri, 22 Jul 2022 02:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1658482437; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efP/FwtOtTUpKjZuYdoEK0j+rpGT+Y4uAqf2YDXcKhw=;
        b=rCvjMkF8W8/gQFjC46TKAp3B/5oXVBNnxfnhUUQ4RWjeGcYU6FAyMEgBSHqHT2Rduv1JR4
        eFLyZUzhR5RklkuB62ku98bmG2TNCcI4n5yEHvnGI4DzpGJulbn/Qep+7ttk5YYQTH6c1M
        NvnFpt48Mcf05p1gu2UE5jmc5Ai9CbI=
Date:   Fri, 22 Jul 2022 10:33:47 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/4] iio: afe/rescale: Implement write_raw
To:     Peter Rosin <peda@axentia.se>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <B81FFR.XDQDJYR0QG6N2@crapouillou.net>
In-Reply-To: <b8539e31-b20a-6eb5-4b86-59a17d7c6939@axentia.se>
References: <20220721191526.374152-1-paul@crapouillou.net>
        <20220721191526.374152-5-paul@crapouillou.net>
        <b8539e31-b20a-6eb5-4b86-59a17d7c6939@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Le ven., juil. 22 2022 at 00:16:36 +0200, Peter Rosin <peda@axentia.se>=20
a =E9crit :
> Hi!
>=20
> 2022-07-21 at 21:15, Paul Cercueil wrote:
>>  Implement write_raw by converting the value if writing the scale, or
>>  just calling the managed channel driver's write_raw otherwise.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/iio/afe/iio-rescale.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>=20
>>  diff --git a/drivers/iio/afe/iio-rescale.c=20
>> b/drivers/iio/afe/iio-rescale.c
>>  index 5c9970b93384..0edb62ee4508 100644
>>  --- a/drivers/iio/afe/iio-rescale.c
>>  +++ b/drivers/iio/afe/iio-rescale.c
>>  @@ -141,6 +141,27 @@ int rescale_process_offset(struct rescale=20
>> *rescale, int scale_type,
>>   	}
>>   }
>>=20
>>  +static int rescale_write_raw(struct iio_dev *indio_dev,
>>  +			     struct iio_chan_spec const *chan,
>>  +			     int val, int val2, long mask)
>>  +{
>>  +	struct rescale *rescale =3D iio_priv(indio_dev);
>>  +	unsigned long long tmp;
>>  +
>>  +	switch (mask) {
>>  +	case IIO_CHAN_INFO_SCALE:
>>  +		tmp =3D val * 1000000000LL;
>>  +		do_div(tmp, rescale->numerator);
>>  +		tmp *=3D rescale->denominator;
>>  +		do_div(tmp, 1000000000LL);
>=20
> do_div is for unsigned operands. Can val never ever be negative?
> What about the numerator and denominator, can those be negative? I
> think this code should live in a new rescale_process_inverse_scale
> function, or something like that (and a few tests could be added to
> drivers/iio/test/iio-test-rescale.c)

I can do that.

>=20
>>  +		return iio_write_channel_attribute(rescale->source, tmp, 0,
>>  +						   IIO_CHAN_INFO_SCALE);
>>  +	default:
>=20
> What if the source driver has a .write_raw_get_fmt callback? That bit
> of info is silently dropped (with no comment that a shortcut has been
> taken). How does inverse rescaling mix with a .write_raw_get_fmt that
> returns e.g. IIO_VAL_INT_PLUS_MICRO_DB anyway? I think all cases might
> get a bit hairy to support, so I think you need to do some filtering
> and somehow fail the .write_raw call if the .write_raw_get_fmt of the
> source returns something that gets too difficult to support.

If the inverse rescale uses the same code as rescale_process_scale()=20
then it becomes problematic, yes, as it likes to change the type of the=20
value.

What I could try - compute the inverse of the value, then find the=20
closest scale value+type that the source driver supports, and use this=20
as the value+type. Then the only failure point would be if=20
.write_raw_get_fmt returns something different than the formats=20
returned by .read_avail, but that sounds unlikely to happen.

Cheers,
-Paul

>>  +		return iio_write_channel_attribute(rescale->source,
>>  +						   val, val2, mask);
>>  +	}
>>  +}
>>  +
>>   static int rescale_read_raw(struct iio_dev *indio_dev,
>>   			    struct iio_chan_spec const *chan,
>>   			    int *val, int *val2, long mask)
>>  @@ -250,6 +271,7 @@ static int rescale_read_avail(struct iio_dev=20
>> *indio_dev,
>>   }
>>=20
>>   static const struct iio_info rescale_info =3D {
>>  +	.write_raw =3D rescale_write_raw,
>>   	.read_raw =3D rescale_read_raw,
>>   	.read_avail =3D rescale_read_avail,
>>   };


