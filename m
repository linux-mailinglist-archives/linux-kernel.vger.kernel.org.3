Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8903A53D8C1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 00:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242293AbiFDWlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 18:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbiFDWlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 18:41:25 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53744CE2E;
        Sat,  4 Jun 2022 15:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1654382472; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rptKCpjnSy70Y/kdV9v2auApDVZ4hLbfEas6KBoTjv8=;
        b=tL6I2zgJ5kdKetzLRAr2ijBcONtbibTSBYCswQWHEq7GECf1cAJoVl6FnE5giKxsrs31A7
        /RQZma+2fZ+iT3rRdWvHnBIhpQQx93i8Kko9FWuxyCW50YU9DcAFeF2k3O2uRkHBQTbf3q
        SXKq+fDEPI+FhTpGTB58CXDod4yvFTk=
Date:   Sat, 04 Jun 2022 23:41:02 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/2] iio: at91-sama5d2: Limit requested watermark value to
 hwfifo size
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Message-Id: <EO5ZCR.QO9V0UA1ZW04@crapouillou.net>
In-Reply-To: <20220604160557.1e82077e@jic23-huawei>
References: <20220117102512.31725-1-paul@crapouillou.net>
        <20220117102512.31725-2-paul@crapouillou.net>
        <20220122170447.68f35cfa@jic23-huawei>
        <20220604160557.1e82077e@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Le sam., juin 4 2022 at 16:05:57 +0100, Jonathan Cameron=20
<jic23@kernel.org> a =E9crit :
> On Sat, 22 Jan 2022 17:04:47 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
>>  On Mon, 17 Jan 2022 10:25:12 +0000
>>  Paul Cercueil <paul@crapouillou.net> wrote:
>>=20
>>  > Instead of returning an error if the watermark value is too high,=20
>> which
>>  > the core will silently ignore anyway, limit the value to the=20
>> hardware
>>  > FIFO size; a lower-than-requested value is still better than=20
>> using the
>>  > default, which is usually 1.
>>=20
>>  There is another potential error condition in this function which=20
>> will
>>  also be ignored by the core.
>>=20
>>  As such whilst I agree this is a sensible thing to do in this
>>  particular case I think we should also be handling the error in the=20
>> core.
>>=20
>>  I think it would be better to clean that up at the same time
>>  as these improvements - particularly as I'd guess you have a=20
>> convenient
>>  test setup to check the error unwind is correct?
>=20
> Hi Paul,
>=20
> I was trawling through patchwork and realised this one is stalled.
>=20
> Thoughts on the above?

Totally forgot about this patch.

Aren't you afraid that if we start handling these errors in the core,=20
we'll somehow break the ABI?

-Paul

> Thanks,
>=20
> Jonathan
>=20
>>=20
>>  Thanks,
>>=20
>>  Jonathan
>>=20
>>  >
>>  > Cc: Eugen Hristev <eugen.hristev@microchip.com>
>>  > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
>>  > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>  > Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
>>  > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  > ---
>>  >  drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
>>  >  1 file changed, 1 insertion(+), 1 deletion(-)
>>  >
>>  > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c=20
>> b/drivers/iio/adc/at91-sama5d2_adc.c
>>  > index 854b1f81d807..5cc84f4a17bb 100644
>>  > --- a/drivers/iio/adc/at91-sama5d2_adc.c
>>  > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
>>  > @@ -1752,7 +1752,7 @@ static int at91_adc_set_watermark(struct=20
>> iio_dev *indio_dev, unsigned int val)
>>  >  	int ret;
>>  >
>>  >  	if (val > AT91_HWFIFO_MAX_SIZE)
>>  > -		return -EINVAL;
>>  > +		val =3D AT91_HWFIFO_MAX_SIZE;
>>  >
>>  >  	if (!st->selected_trig->hw_trig) {
>>  >  		dev_dbg(&indio_dev->dev, "we need hw trigger for DMA\n");
>>=20
>=20


