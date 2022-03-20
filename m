Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F414E1C4C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 16:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245380AbiCTPfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 11:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiCTPfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 11:35:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB49D3207E;
        Sun, 20 Mar 2022 08:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E92461171;
        Sun, 20 Mar 2022 15:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F209C340EE;
        Sun, 20 Mar 2022 15:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647790453;
        bh=clyv+Cf8jIhp2zt7N+bu2NWuiZjPaJMzWpNWJYGHg9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zs/t4WHY6YYQiktm3bIPZ+6alFrHOgBWbNOeDat/vTrCzJ8WkKDTcTY9jz8eyU9nm
         xG65YHyNCgk6ZBjtr/aYWLOpydl0BSIWndO0NB64XMR5klzghpfcNlsOMJiRSqLi9Y
         /OCnyb5uLQx243r3dSzJPMujluyUEgctpZOvjToBBe+ewy8DzTSHmpTo4IW8DvNaP9
         8eYC1dRyIGLr5J+hSir/ecGSXALmbiKDl8TAy1O4SpuYtO5lrORmSh7uBmFQRWG/FN
         GuHtkWO75xG+Uh0em3s1r+/pTp5Fw+zbE3YSLyOBayjETNx+Ps0VDCLJ0SxVCFYIY0
         kFtRUUUq5l+AA==
Date:   Sun, 20 Mar 2022 15:41:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: dac: ltc2688: Use temporary variable for
 struct device
Message-ID: <20220320154139.104b07f2@jic23-huawei>
In-Reply-To: <PH0PR03MB678602F6E1B491B2A882BC7C99049@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220302153142.52743-1-andriy.shevchenko@linux.intel.com>
        <PH0PR03MB678602F6E1B491B2A882BC7C99049@PH0PR03MB6786.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 13:34:00 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Wednesday, March 2, 2022 4:32 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; linux-iio@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > <lars@metafoo.de>
> > Subject: [PATCH v1 1/1] iio: dac: ltc2688: Use temporary variable for
> > struct device
> >=20
> > [External]
> >=20
> > Use temporary variable for struct device to make code neater.
> >=20
> > Signed-off-by: Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the togreg branch of iio.git but I'll be rebaseing that
on rc1 so for now just pushed out as testing so 0-day can take
a look at it.

Thanks,

Jonathan

>=20
> >  drivers/iio/dac/ltc2688.c | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
> > index e41861d29767..d249fa28202c 100644
> > --- a/drivers/iio/dac/ltc2688.c
> > +++ b/drivers/iio/dac/ltc2688.c
> > @@ -703,21 +703,20 @@ static int ltc2688_tgp_clk_setup(struct
> > ltc2688_state *st,
> >  				 struct ltc2688_chan *chan,
> >  				 struct fwnode_handle *node, int tgp)
> >  {
> > +	struct device *dev =3D &st->spi->dev;
> >  	unsigned long rate;
> >  	struct clk *clk;
> >  	int ret, f;
> >=20
> > -	clk =3D devm_get_clk_from_child(&st->spi->dev,
> > to_of_node(node), NULL);
> > +	clk =3D devm_get_clk_from_child(dev, to_of_node(node),
> > NULL);
> >  	if (IS_ERR(clk))
> > -		return dev_err_probe(&st->spi->dev, PTR_ERR(clk),
> > -				     "failed to get tgp clk.\n");
> > +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get
> > tgp clk.\n");
> >=20
> >  	ret =3D clk_prepare_enable(clk);
> >  	if (ret)
> > -		return dev_err_probe(&st->spi->dev, ret,
> > -				     "failed to enable tgp clk.\n");
> > +		return dev_err_probe(dev, ret, "failed to enable tgp
> > clk.\n");
> >=20
> > -	ret =3D devm_add_action_or_reset(&st->spi->dev,
> > ltc2688_clk_disable, clk);
> > +	ret =3D devm_add_action_or_reset(dev, ltc2688_clk_disable,
> > clk);
> >  	if (ret)
> >  		return ret;
> >=20
> > @@ -858,6 +857,7 @@ static int ltc2688_channel_config(struct
> > ltc2688_state *st)
> >=20
> >  static int ltc2688_setup(struct ltc2688_state *st, struct regulator *v=
ref)
> >  {
> > +	struct device *dev =3D &st->spi->dev;
> >  	struct gpio_desc *gpio;
> >  	int ret;
> >=20
> > @@ -865,10 +865,9 @@ static int ltc2688_setup(struct ltc2688_state
> > *st, struct regulator *vref)
> >  	 * If we have a reset pin, use that to reset the board, If not, use
> >  	 * the reset bit.
> >  	 */
> > -	gpio =3D devm_gpiod_get_optional(&st->spi->dev, "clr",
> > GPIOD_OUT_HIGH);
> > +	gpio =3D devm_gpiod_get_optional(dev, "clr",
> > GPIOD_OUT_HIGH);
> >  	if (IS_ERR(gpio))
> > -		return dev_err_probe(&st->spi->dev, PTR_ERR(gpio),
> > -				     "Failed to get reset gpio");
> > +		return dev_err_probe(dev, PTR_ERR(gpio), "Failed to
> > get reset gpio");
> >  	if (gpio) {
> >  		usleep_range(1000, 1200);
> >  		/* bring device out of reset */
> > @@ -887,7 +886,7 @@ static int ltc2688_setup(struct ltc2688_state *st,
> > struct regulator *vref)
> >  	 * Duplicate the default channel configuration as it can change
> > during
> >  	 * @ltc2688_channel_config()
> >  	 */
> > -	st->iio_chan =3D devm_kmemdup(&st->spi->dev,
> > ltc2688_channels,
> > +	st->iio_chan =3D devm_kmemdup(dev, ltc2688_channels,
> >  				    sizeof(ltc2688_channels),
> > GFP_KERNEL);
> >  	if (!st->iio_chan)
> >  		return -ENOMEM;
> > --
> > 2.34.1 =20
>=20

