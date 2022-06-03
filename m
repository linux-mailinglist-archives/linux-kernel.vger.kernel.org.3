Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F8653CE0B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344461AbiFCR0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243101AbiFCR0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:26:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461EB527FE;
        Fri,  3 Jun 2022 10:26:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8424B823BD;
        Fri,  3 Jun 2022 17:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F646C385B8;
        Fri,  3 Jun 2022 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654277201;
        bh=pFyKs6bDeRujyUNMZ+mgdO3kgrwHB8+8YjKvunjGXII=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uo6v3MnaMRAekuoozDiyXyy5X0pRwHtJf5UbQjqT70y/Gsc02kv6e/qHPRjuXszib
         36dZJUyw0q5Eugp0lgfXN0W1r3jbUB4duZiG379Vrd9RrtQRP57rhF16hhHuXLJTJd
         aScXv9OITcXs+XSve7X+m51mS4VB5hot6KnueXJnDRgb+l455ZW11WqYsQGEqmoi/N
         2fnJ/dlILqQMPs1D9g2I/FdAQ9z+LR+F1oDqzUcxhPBNw+Nsw5+lnLFRugECsKjwsD
         YnjR28sLr1vOC3zF2we40fX1ug0jVnW0WQJrgS4gzffuUP8gjXMgDZOtBJ2yx6kVXu
         KNIPT1N6bMprw==
Date:   Fri, 3 Jun 2022 18:35:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/2] iio: adc: nau7802: Convert driver to use
 ->probe_new()
Message-ID: <20220603183542.3485d903@jic23-huawei>
In-Reply-To: <20220531213922.72992-1-andriy.shevchenko@linux.intel.com>
References: <20220531213922.72992-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Jun 2022 00:39:21 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use the ->probe_new() callback.
>=20
> The driver does not use const struct i2c_device_id * argument,
> so convert it to utilise the simplified I=C2=B2C driver registration.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Series applied,

Thanks for all these cleanups btw.

Jonathan

> ---
>  drivers/iio/adc/nau7802.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
> index 976c235f3079..2d71cdbcd82f 100644
> --- a/drivers/iio/adc/nau7802.c
> +++ b/drivers/iio/adc/nau7802.c
> @@ -407,8 +407,7 @@ static const struct iio_info nau7802_info =3D {
>  	.attrs =3D &nau7802_attribute_group,
>  };
> =20
> -static int nau7802_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int nau7802_probe(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev;
>  	struct nau7802_state *st;
> @@ -417,11 +416,6 @@ static int nau7802_probe(struct i2c_client *client,
>  	u8 data;
>  	u32 tmp =3D 0;
> =20
> -	if (!client->dev.of_node) {
> -		dev_err(&client->dev, "No device tree node available.\n");
> -		return -EINVAL;
> -	}
> -
>  	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*st));
>  	if (indio_dev =3D=3D NULL)
>  		return -ENOMEM;
> @@ -550,7 +544,7 @@ static const struct of_device_id nau7802_dt_ids[] =3D=
 {
>  MODULE_DEVICE_TABLE(of, nau7802_dt_ids);
> =20
>  static struct i2c_driver nau7802_driver =3D {
> -	.probe =3D nau7802_probe,
> +	.probe_new =3D nau7802_probe,
>  	.id_table =3D nau7802_i2c_id,
>  	.driver =3D {
>  		   .name =3D "nau7802",

