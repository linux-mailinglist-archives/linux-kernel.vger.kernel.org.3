Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A754A94A5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 08:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352999AbiBDHfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 02:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiBDHfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 02:35:19 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C467DC061714;
        Thu,  3 Feb 2022 23:35:19 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id i65so4380304pfc.9;
        Thu, 03 Feb 2022 23:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a1Z4SsvUtbUIh8RWDNefYqNV9onmdeuXC4gShFMsMqM=;
        b=XWJ8igcqJPIKZ7D8uEmrRZVZV1d3cPIZjbuTnvzftsL0G2yoiIh7jjH1AGanq6PIYo
         EGnbgeWNmr0Xry9ycpamYXRAZ3r0olHcG77aDDBhyZpHW7krUhn+aiLegpW5z8AL9hH3
         1gJIT2irlceDxJTPR/FlqreCYJYZTJsPFHxD2SQblKqKnL+uPGuMUlL8cDvj3OF4ftgu
         Mp08uBp4smwS+x6Oo3OyEwBh/u2FqIs0Y/qQI5RS43xzcRiCFsWjpqrIcAMYp6MOXbUw
         fDnvimXMUteyPe1NKXG2p9EnApSSf0L4FuKlnC5p2/8LQGpnvZK0jIafl/Gabq0cqayk
         xCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a1Z4SsvUtbUIh8RWDNefYqNV9onmdeuXC4gShFMsMqM=;
        b=kQWcmgZg6H8rTD6IP4uJZUShC87u4ENGJ2mZ1ETy5046SvHlE1R8RmMK8v/Hsmo3QU
         Ixwgo3RKQ1HSkqovtqcFsnw16Cax0rbeTqgpBkSSl8elTJ4jgsEDNsnh1FsojrblU2wB
         hUBV4gqobrcMn7OkxUr7DwowBgceXY68vt66HrG8n23dtIiErB1wU3l06Eu31y/obdzc
         Gd6tdiymv8rxGJ6tsMWZRWrg5Iz2d7E7W9gSd/9lP0rSZPsDlPNJKfL4BplvNfRQTN2I
         jfSp2eCNvsLz6OmZ03PJqkyZV9H6i7b6IaGSt/N3JPeQ5cVYL1KclInRIzPeOcI8q/+U
         mt6Q==
X-Gm-Message-State: AOAM533Fa4ka7Di81i1N1fmDGWFLwUdwmqavhxH1jIkMoqTYRrUYL6c4
        /Y3tjEEcG0hM3iNv5gIa9PQ=
X-Google-Smtp-Source: ABdhPJzq2XP7kaA9a0Ymfx56t07LHbDV/RzgKiNa67I0eH+1eWcqShMTn/dNualo9Mpsr+FNI2CmjQ==
X-Received: by 2002:a63:2b49:: with SMTP id r70mr1406472pgr.111.1643960119255;
        Thu, 03 Feb 2022 23:35:19 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id a37sm947015pga.3.2022.02.03.23.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 23:35:18 -0800 (PST)
Date:   Fri, 4 Feb 2022 16:35:12 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 2/2] counter: interrupt-cnt: add counter_push_event()
Message-ID: <YfzXMKusj22MEisY@shinobu>
References: <20220203135727.2374052-1-o.rempel@pengutronix.de>
 <20220203135727.2374052-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oRfwSPBWBCinOFIL"
Content-Disposition: inline
In-Reply-To: <20220203135727.2374052-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oRfwSPBWBCinOFIL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 03, 2022 at 02:57:27PM +0100, Oleksij Rempel wrote:
> Add counter_push_event() to notify user space about new pulses
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

This is a simple solution so if it works for your use-case I'm okay with
it; I think future counter devices could make use of this new
COUNTER_EVENT_CHANGE_OF_STATE event type too, so that's a plus.

I'm going to wait a week to give others time to chime in if they want.
Otherwise I'll give a proper approval for this series next week.

William Breathitt Gray

> ---
>  drivers/counter/interrupt-cnt.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-=
cnt.c
> index 9e99702470c2..3b13f56bbb11 100644
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -26,10 +26,13 @@ struct interrupt_cnt_priv {
> =20
>  static irqreturn_t interrupt_cnt_isr(int irq, void *dev_id)
>  {
> -	struct interrupt_cnt_priv *priv =3D dev_id;
> +	struct counter_device *counter =3D dev_id;
> +	struct interrupt_cnt_priv *priv =3D counter_priv(counter);
> =20
>  	atomic_inc(&priv->count);
> =20
> +	counter_push_event(counter, COUNTER_EVENT_CHANGE_OF_STATE, 0);
> +
>  	return IRQ_HANDLED;
>  }
> =20
> @@ -209,7 +212,7 @@ static int interrupt_cnt_probe(struct platform_device=
 *pdev)
>  	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);
>  	ret =3D devm_request_irq(dev, priv->irq, interrupt_cnt_isr,
>  			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> -			       dev_name(dev), priv);
> +			       dev_name(dev), counter);
>  	if (ret)
>  		return ret;
> =20
> --=20
> 2.30.2
>=20

--oRfwSPBWBCinOFIL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmH81xcACgkQhvpINdm7
VJLwgRAApE1ASfE6RJfspMwz4NrDI5m585lKcwyNy3IUVxt8BAvvwu+AdytC3MIT
4u8q6PIZtocI4C4wQIzkrUWewMqmsbAObPQ59nN9208LwuMtu8mwcENEUiLdmhAW
PFQB7qjyUsA04cdWDcxWWVV8Pn/6YO6aFdvOzhbrQZ2sagdhpow49ecXGXvYAC/e
ukiQq7EP+y3sCE5nEu0k8+3yz8SdMnTtbKbVwrS2uzN10swkOLmdMCGSb9Wby48s
lyyXf9rV6hS4yvNuczDVcARUDvD0bBl3BnWE1aRhw/B4mxpyK7kG9UCrxawIB+b8
A47oCbXj7zVXPm7gQPRlQ8dKviE4gh5hT2TIB1c8dGsDSJ6D7LR7kZu0HSAm92uF
iu/xTIgeWhe3ohYzZD4RducAixsJhPRuCkaklVoghlarwLav8He91qEM3qOxYkfv
vLoCawc55Cjk8iC32SBpp/eCuuL8to4S1eu1P/rB/ChUCKN7o5u65PtuZSv+wLB6
yrqhvatz/DUFjBJvt9SV1DP9bT+qywMe9Wj5nWMPIrDwHYfpp67C7R/OjuYClII4
VMxamuzJn4/Qv4D0ZaK9ooPWrv13sfkI9RCsQuvphUd8ILR+zDgCRYykqHvlrKaW
QUaalux97zf2L+2R2Noh86h5vkHWD2NsUhRHy/+nUbnfb3X/yFc=
=1z8E
-----END PGP SIGNATURE-----

--oRfwSPBWBCinOFIL--
