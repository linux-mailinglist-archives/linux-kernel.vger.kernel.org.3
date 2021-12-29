Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAFF4810B3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 08:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbhL2HfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 02:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhL2HfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 02:35:24 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6041C061574;
        Tue, 28 Dec 2021 23:35:24 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id n16so15333801plc.2;
        Tue, 28 Dec 2021 23:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CVOIz0TCuoGj6iBnMQu7U/8DnECXErcPvKBFtS77TtY=;
        b=EOsPSBixH2X/38JLoQGhapJcSz4dp7LHsze/mG1qEqzr+wp0zsz5wXK4q8uuxDMQzu
         ZBfvV52x+mocCAEm6PXdLga1yQwgZUqqbFylz30tNjftOBwZLcYhTFrJbC49P2FvvDpY
         LsPxThfoclTJAEboOt90adzGMeP3y5rVrv+DRmy8ZrOReVB7iOueNWZrDCTY26e2Dl+m
         l5CEhpQTylkya7tyr+y4Ev/9+u79UnejJv2ODy5mB3xHP4JlIdi0HgpWcx4/lhXA2xnB
         wCk1yYnFkB2gPxt6Iafuqpt2w++gkM/E/tUUEGVPuAJCE5gQwBHK+hkT2G9561XrOFYC
         SAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CVOIz0TCuoGj6iBnMQu7U/8DnECXErcPvKBFtS77TtY=;
        b=68jYZUt+XnNHaNatuaegIZ702C7xlLCkv35GEprqK1AzwEj+5aEkpP2aPBj2XiukxW
         VvjH25+By+naOssAnlKgEY5W5RkkjgKreRGIHr4z/9rD36LE4uSreLeGBvtmQnafsg6i
         HObpYRNSDPCsAiMEyxjLaOL2f9DYikuVXhYs8O+8rjjuAlxCGicmi5u7oembANM5ZGAn
         U69yW8bs/9MvF36/YXGtXXu8fdh3MFoFY2z4hU8piUJDebICD3pND3R/v50timpOybBv
         dKHh8yogrrIgrhisQ6O56oQYw1udm75JWTPhr11IwjvjiRI9V4nnIXAfw1duCxjtceXL
         04Gw==
X-Gm-Message-State: AOAM5314Ip0F4ye1nYvtQvN/LVL4fxNqlW0VZz7GndRqUb/t33f7JI3Q
        DzU9TwpHgFUgvv5OwdaMjfQ=
X-Google-Smtp-Source: ABdhPJxPcwClLMvLJFjy34FTF6R4jPFWyHA71hFLd5zV41d2FdjsPUjUyqJBdus0+y+gKQaiqBboHw==
X-Received: by 2002:a17:902:9894:b0:149:8a72:98ae with SMTP id s20-20020a170902989400b001498a7298aemr9650995plp.132.1640763324329;
        Tue, 28 Dec 2021 23:35:24 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id g19sm16163044pfv.19.2021.12.28.23.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 23:35:23 -0800 (PST)
Date:   Wed, 29 Dec 2021 16:35:17 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 07/23] counter: microchip-tcb-capture: Convert to
 counter_priv() wrapper
Message-ID: <YcwPtc2STMA/mKKj@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-8-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Mjc+xZwTVwGHVxqI"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-8-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Mjc+xZwTVwGHVxqI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:10AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This is a straight forward conversion to the new counter_priv() wrapper.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/microchip-tcb-capture.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/mi=
crochip-tcb-capture.c
> index bb69f2e0ba93..1b56b7444668 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -72,7 +72,7 @@ static int mchp_tc_count_function_read(struct counter_d=
evice *counter,
>  				       struct counter_count *count,
>  				       enum counter_function *function)
>  {
> -	struct mchp_tc_data *const priv =3D counter->priv;
> +	struct mchp_tc_data *const priv =3D counter_priv(counter);
> =20
>  	if (priv->qdec_mode)
>  		*function =3D COUNTER_FUNCTION_QUADRATURE_X4;
> @@ -86,7 +86,7 @@ static int mchp_tc_count_function_write(struct counter_=
device *counter,
>  					struct counter_count *count,
>  					enum counter_function function)
>  {
> -	struct mchp_tc_data *const priv =3D counter->priv;
> +	struct mchp_tc_data *const priv =3D counter_priv(counter);
>  	u32 bmr, cmr;
> =20
>  	regmap_read(priv->regmap, ATMEL_TC_BMR, &bmr);
> @@ -148,7 +148,7 @@ static int mchp_tc_count_signal_read(struct counter_d=
evice *counter,
>  				     struct counter_signal *signal,
>  				     enum counter_signal_level *lvl)
>  {
> -	struct mchp_tc_data *const priv =3D counter->priv;
> +	struct mchp_tc_data *const priv =3D counter_priv(counter);
>  	bool sigstatus;
>  	u32 sr;
> =20
> @@ -169,7 +169,7 @@ static int mchp_tc_count_action_read(struct counter_d=
evice *counter,
>  				     struct counter_synapse *synapse,
>  				     enum counter_synapse_action *action)
>  {
> -	struct mchp_tc_data *const priv =3D counter->priv;
> +	struct mchp_tc_data *const priv =3D counter_priv(counter);
>  	u32 cmr;
> =20
>  	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr);
> @@ -197,7 +197,7 @@ static int mchp_tc_count_action_write(struct counter_=
device *counter,
>  				      struct counter_synapse *synapse,
>  				      enum counter_synapse_action action)
>  {
> -	struct mchp_tc_data *const priv =3D counter->priv;
> +	struct mchp_tc_data *const priv =3D counter_priv(counter);
>  	u32 edge =3D ATMEL_TC_ETRGEDG_NONE;
> =20
>  	/* QDEC mode is rising edge only */
> @@ -230,7 +230,7 @@ static int mchp_tc_count_action_write(struct counter_=
device *counter,
>  static int mchp_tc_count_read(struct counter_device *counter,
>  			      struct counter_count *count, u64 *val)
>  {
> -	struct mchp_tc_data *const priv =3D counter->priv;
> +	struct mchp_tc_data *const priv =3D counter_priv(counter);
>  	u32 cnt;
> =20
>  	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CV), &cnt);
> --=20
> 2.33.0
>=20

--Mjc+xZwTVwGHVxqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMD7UACgkQhvpINdm7
VJIV+g/8CeqtAG5oJbZrQz5K0nH0VFWgH9+4eMBGEXzttztypiyLm4nSrzi4Zfbn
DVz1302MqsIpXufbOwZMmfzhGRJ4220Mk3+BkAxserMHCeioaCVWgoIACBnF8Oz2
TOrmBcQg0fJhjAtywwi+AE5LJzI9sqG8fB/G3KFn09mwqfJqS7sFHVtc0BbCiwSh
lNcQ8ct4XdQwiD4UTw4p36RDKXGkPUq6j47RW0B8t5qc9sl0+18bIf+K74/RLzWU
IAFQP9Aes5opx+UXrC1V+FZ6kJ/xhXG99bZWrVkFdY7QlSL3b+8Z+h298UJGfaBu
zvpBZ6k0MviKBhBU8Y0SzIjVfTGpniiXlmkoyCVu/ZjP02d7rzUKEGC865vtezuB
QFRbiQE0et3MJAXKiWVhqckUBsh6Lmmgrc+ewGkOvswhLGhufy1PNRv6T+7S+DWe
8G6CLqPAUVlBivW35tx98xPVIbUl3xqZKnElmO4bLmh6IGsiXefqgVZV3h0KIdBg
8dLXmok2BhtWN5Kf6KqdTFcYTBKdq81iEganJRPnBfyofTSZnFL6IiGJzJlXfaCY
DKr/dTPRRw6v+8PhqcXRcDbXaUP9oRDwz2pxKUH3h9yblC7M3NfLnHryZLe/eChr
1k9fwEFVGRdWdorkOK0zrK+EtIrmUxYqI7ywr4JYhmKvMCDTKPU=
=Dl0a
-----END PGP SIGNATURE-----

--Mjc+xZwTVwGHVxqI--
