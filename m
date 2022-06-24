Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C25855A00C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiFXR7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiFXR7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:59:50 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF9349B59;
        Fri, 24 Jun 2022 10:59:48 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7BA72C0004;
        Fri, 24 Jun 2022 17:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656093587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QnYk4LM/FaI0hTQEp6s2QfDya067fAkGlMpiIGk0dfg=;
        b=XNgCDjBF2isQmvQ2XE+g5+QrPpA6B73kCtIEyO/jdume+4vHVZyNetZLS8NcL6W/p5vfvz
        60v4j2YAVmu3d3w2JJP9WMaK3W2pkJ7F6FhXirwQYzyr2BeLwAxnrphZ8W6SOjapL9A597
        U3s3QE8E0ydC35Ihf2rFgUa11ydmgmdTwG9FckA4aRbtQTi02rlO0QFY5fIgNxpXgfMxgf
        VU/GCNWFfHN2b2YC9LSka6kqJU06ExShtf/wNJ8L2TKgesJJcZqN4Nbp52bKhPntu9GM4O
        SCCYPHOcJq7k06h13b7drKTmmMNZdYgw/IuRh/NGzpSAQlNZgXjKzHURJq9v5w==
Date:   Fri, 24 Jun 2022 19:59:45 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] iio: dac: mcp4922: add support to mcp4921
Message-ID: <20220624195945.6b5cf1be@xps-13>
In-Reply-To: <20220624095619.1415614-1-kory.maincent@bootlin.com>
References: <20220624095619.1415614-1-kory.maincent@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kory,

kory.maincent@bootlin.com wrote on Fri, 24 Jun 2022 11:56:17 +0200:

> Add support to mcp4921 which has only one output channel.
>=20
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> ---
>  drivers/iio/dac/mcp4922.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
> index cb9e60e71b91..0d41c0f25515 100644
> --- a/drivers/iio/dac/mcp4922.c
> +++ b/drivers/iio/dac/mcp4922.c
> @@ -17,10 +17,12 @@
>  #include <linux/bitops.h>
> =20
>  #define MCP4922_NUM_CHANNELS	2
> +#define MCP4921_NUM_CHANNELS	1
> =20
>  enum mcp4922_supported_device_ids {
>  	ID_MCP4902,
>  	ID_MCP4912,
> +	ID_MCP4921,
>  	ID_MCP4922,
>  };
> =20
> @@ -105,9 +107,10 @@ static int mcp4922_write_raw(struct iio_dev *indio_d=
ev,
>  	}
>  }
> =20
> -static const struct iio_chan_spec mcp4922_channels[3][MCP4922_NUM_CHANNE=
LS] =3D {
> +static const struct iio_chan_spec mcp4922_channels[4][MCP4922_NUM_CHANNE=
LS] =3D {
>  	[ID_MCP4902] =3D { MCP4922_CHAN(0, 8),	MCP4922_CHAN(1, 8) },
>  	[ID_MCP4912] =3D { MCP4922_CHAN(0, 10),	MCP4922_CHAN(1, 10) },
> +	[ID_MCP4921] =3D { MCP4922_CHAN(0, 12),	{} },
>  	[ID_MCP4922] =3D { MCP4922_CHAN(0, 12),	MCP4922_CHAN(1, 12) },
>  };
> =20
> @@ -154,7 +157,10 @@ static int mcp4922_probe(struct spi_device *spi)
>  	indio_dev->info =3D &mcp4922_info;
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
>  	indio_dev->channels =3D mcp4922_channels[id->driver_data];
> -	indio_dev->num_channels =3D MCP4922_NUM_CHANNELS;
> +	if (id->driver_data =3D=3D ID_MCP4921)
> +		indio_dev->num_channels =3D MCP4921_NUM_CHANNELS;
> +	else
> +		indio_dev->num_channels =3D MCP4922_NUM_CHANNELS;
>  	indio_dev->name =3D id->name;
> =20
>  	ret =3D iio_device_register(indio_dev);
> @@ -185,6 +191,7 @@ static void mcp4922_remove(struct spi_device *spi)
>  static const struct spi_device_id mcp4922_id[] =3D {
>  	{"mcp4902", ID_MCP4902},
>  	{"mcp4912", ID_MCP4912},
> +	{"mcp4921", ID_MCP4921},
>  	{"mcp4922", ID_MCP4922},
>  	{}
>  };


Thanks,
Miqu=C3=A8l
