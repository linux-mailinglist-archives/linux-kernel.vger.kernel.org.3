Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE405547948
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 10:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiFLIkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 04:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiFLIk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 04:40:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02C11D0DD;
        Sun, 12 Jun 2022 01:40:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55D2CB80B9D;
        Sun, 12 Jun 2022 08:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15439C34115;
        Sun, 12 Jun 2022 08:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655023224;
        bh=Y3/zdEYrNIh+3ecvcNshflYk4eVJpP4sH1/urx8J2fQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TppMPssgr7fu/K/ICQkT7vTN8zfppudtahaIRVSwYEq0oKKm96DUEm5XboeJ+5Iik
         2Dl8qyLYHlZHfvMt/c8tnqNLxeN6pGjzY0FdadxJ34lthD/ylaavlq+QTLzPdJsJ3n
         Qmj4y8syqoeSQ2DEjaRv/oVvnr3Dp+vdweRh9cB071i/6zQhgKcrw8LkmkorB2CQh/
         JMSVelWvb68Xy5Oejl9vFSQeXYXlQ3DoXCJEHaO/0uJNuCRxuRzRlp3QubcCG2sBTJ
         1n6twc5Oxap7tt1fG/Bwj8iOkRhNbtJr6LCEvh6Z6fUT2vUDTm3NxCY1x4hzcdJPXE
         8WsRtNr/Fq5/Q==
Date:   Sun, 12 Jun 2022 09:49:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 2/2] iio: at91-sama5d2: Limit requested watermark value
 to hwfifo size
Message-ID: <20220612094842.00ffc23b@jic23-huawei>
In-Reply-To: <EO5ZCR.QO9V0UA1ZW04@crapouillou.net>
References: <20220117102512.31725-1-paul@crapouillou.net>
        <20220117102512.31725-2-paul@crapouillou.net>
        <20220122170447.68f35cfa@jic23-huawei>
        <20220604160557.1e82077e@jic23-huawei>
        <EO5ZCR.QO9V0UA1ZW04@crapouillou.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Jun 2022 23:41:02 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
>=20
> Le sam., juin 4 2022 at 16:05:57 +0100, Jonathan Cameron=20
> <jic23@kernel.org> a =C3=A9crit :
> > On Sat, 22 Jan 2022 17:04:47 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  =20
> >>  On Mon, 17 Jan 2022 10:25:12 +0000
> >>  Paul Cercueil <paul@crapouillou.net> wrote:
> >>  =20
> >>  > Instead of returning an error if the watermark value is too high,  =
=20
> >> which =20
> >>  > the core will silently ignore anyway, limit the value to the  =20
> >> hardware =20
> >>  > FIFO size; a lower-than-requested value is still better than  =20
> >> using the =20
> >>  > default, which is usually 1. =20
> >>=20
> >>  There is another potential error condition in this function which=20
> >> will
> >>  also be ignored by the core.
> >>=20
> >>  As such whilst I agree this is a sensible thing to do in this
> >>  particular case I think we should also be handling the error in the=20
> >> core.
> >>=20
> >>  I think it would be better to clean that up at the same time
> >>  as these improvements - particularly as I'd guess you have a=20
> >> convenient
> >>  test setup to check the error unwind is correct? =20
> >=20
> > Hi Paul,
> >=20
> > I was trawling through patchwork and realised this one is stalled.
> >=20
> > Thoughts on the above? =20
>=20
> Totally forgot about this patch.
>=20
> Aren't you afraid that if we start handling these errors in the core,=20
> we'll somehow break the ABI?
>=20
Been a while, but I think my concern was more that there are other
error conditions in these calls.  Whilst we can indeed clamp the
watermark, the other conditions should probably be handled in the core.

I guess that doesn't mean i shouldn't take these in the meantime, just
that there is more work to do here and I was sneakily trying to make
it your problem *evil laugh*

As such, applied these two to, but if anyone has time to take a look
at handling the error returns in the core that would be great.

Applied to the togreg branch of iio.git and I'll push out as testing
later (on train with dodgy wifi) for 0-day to take a look.

Thanks,

Jonathan

> -Paul
>=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> >>=20
> >>  Thanks,
> >>=20
> >>  Jonathan
> >>  =20
> >>  >
> >>  > Cc: Eugen Hristev <eugen.hristev@microchip.com>
> >>  > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> >>  > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> >>  > Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> >>  > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  > ---
> >>  >  drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
> >>  >  1 file changed, 1 insertion(+), 1 deletion(-)
> >>  >
> >>  > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c  =20
> >> b/drivers/iio/adc/at91-sama5d2_adc.c =20
> >>  > index 854b1f81d807..5cc84f4a17bb 100644
> >>  > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> >>  > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> >>  > @@ -1752,7 +1752,7 @@ static int at91_adc_set_watermark(struct  =20
> >> iio_dev *indio_dev, unsigned int val) =20
> >>  >  	int ret;
> >>  >
> >>  >  	if (val > AT91_HWFIFO_MAX_SIZE)
> >>  > -		return -EINVAL;
> >>  > +		val =3D AT91_HWFIFO_MAX_SIZE;
> >>  >
> >>  >  	if (!st->selected_trig->hw_trig) {
> >>  >  		dev_dbg(&indio_dev->dev, "we need hw trigger for DMA\n"); =20
> >>  =20
> >  =20
>=20
>=20

