Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1383A4C5DE3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 18:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiB0Rui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 12:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiB0Ruh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 12:50:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B295C3DDE9;
        Sun, 27 Feb 2022 09:50:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C7AA60FF7;
        Sun, 27 Feb 2022 17:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92D4C340EF;
        Sun, 27 Feb 2022 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645984199;
        bh=bqyY3XQdRlzIGOWzFJrkb/oKUh63XEB+VuO9HJ3geNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bu65S8Mdj6BE/d7Ux8sTDXYbJA3pBAHP/NTA8ktur3Dh2CZ6bJ0/8notLz7rKRLl9
         U5Z8jUXayPRS7V3IM2Rro+U1wlRp9Ao/J/b1cWghUyvF/qXsZzHjvXI58td34kNaw2
         GsgyAJNF/fS0X8UbYEUull970geXbaLOeqvrdSNLrb1vS9B7V2jT47A6UMmXDPit5D
         0vfwYauN6FHKvnp8LH/cXSofUnv69teeUAQtXgpBJoTF6SRaOiScLCH81qAwomAeYY
         h29MjzjtZ6ir1gsav7TNvNJS7FhwEFjyKvogxEInTf93L1oufN3WWfujToo4to9o4v
         3K6xp/Y5DGwGw==
Date:   Sun, 27 Feb 2022 17:57:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     lars@metafoo.de, matthias.bgg@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com, linus.walleij@linaro.org,
        ardeleanalex@gmail.com, Tom Rix <trix@redhat.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] iio: adc: mt6360: strengthen return check of
 mt6360_adc_read_channel
Message-ID: <20220227175701.4cacbe3d@jic23-huawei>
In-Reply-To: <5477fb05-d72f-ccc0-1c07-8f2f40d9dde0@wanadoo.fr>
References: <20220227164357.84742-1-trix@redhat.com>
        <5477fb05-d72f-ccc0-1c07-8f2f40d9dde0@wanadoo.fr>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2022 18:01:47 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Le 27/02/2022 =C3=A0 17:43, trix-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org =
a=20
> =C3=A9crit=C2=A0:
> > From: Tom Rix <trix-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >=20
> > Clang static analysis reports this issue
> > mt6360-adc.c:277:20: warning: Assigned value is
> >    garbage or undefined
> >    data.values[i++] =3D val;
> >                     ^ ~~~
> >=20
> > val is set by a successful call to m6360_adc_read_channel().
> > A negative return is checked but within m6360_adc_read_channel,
> > a non zero check is done.
> > Strengthen the check to non zero. =20
>=20
> Hi, my understanding of m6360_adc_read_channel() is that on success, it=20
> returns IIO_VAL_INT (i.e. 1).
>=20
> So, I think that with your patch, we will now always fail because 'ret'=20
> is never 0 at this point.

Firstly I'm glad you were more awake than me Christophe as I missed that
entirely. :(

So two ways we could deal with the warning (which is valid given there
is no way clang could sensibly tell that all those if (ret) actually
mean if (ret < 0).

I don't like changing them to if (ret < 0) inside _adc_read_channel()
because generally it ends up cleaner to just do if (ret) based handling
for regmap calls.  So we could just assign a default to val that is never
used or we could change that function to return 0 on success and adjust
the other call site to return IIO_VAL_INT if there isn't an error.

The second one would make the other caller rather messier so I'd suggest
just giving val a default and adding a comment saying it's for warning
suppression purposes...

Jonathan


>=20
> CJ
>=20
> >=20
> > Signed-off-by: Tom Rix <trix-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >   drivers/iio/adc/mt6360-adc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
> > index 07c0e67683910..9fb6dc305a392 100644
> > --- a/drivers/iio/adc/mt6360-adc.c
> > +++ b/drivers/iio/adc/mt6360-adc.c
> > @@ -269,7 +269,7 @@ static irqreturn_t mt6360_adc_trigger_handler(int i=
rq, void *p)
> >   	memset(&data, 0, sizeof(data));
> >   	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->maskle=
ngth) {
> >   		ret =3D mt6360_adc_read_channel(mad, bit, &val);
> > -		if (ret < 0) {
> > +		if (ret) {
> >   			dev_warn(&indio_dev->dev, "Failed to get channel %d conversion val=
\n", bit);
> >   			goto out;
> >   		} =20
>=20

