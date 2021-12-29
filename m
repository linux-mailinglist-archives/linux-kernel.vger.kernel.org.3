Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D8E4810A8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 08:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbhL2H1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 02:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239095AbhL2H1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 02:27:46 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD85C061574;
        Tue, 28 Dec 2021 23:27:46 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id a11-20020a17090a854b00b001b11aae38d6so19194410pjw.2;
        Tue, 28 Dec 2021 23:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pfBf+mjxOblstT2YDIb8V2e3fmSWylUHns8bL17IC00=;
        b=b5KZcAny+xSwIy0THUcaGOOHTQxnGwojlUlOwt3uD6zNwFMg4y28E7n/3NHt79BRYf
         Rtx9jMnBscStnPvNVCaPenl7VuzsDrZkgcZgUttTxdRjUJbJ3ZGSOyTFM5PmHqZ8KTWt
         PUIJ+BCWndySF10Ttx1cIaBhLr4CF9QRrawiRGrGDLBIARsK6W18OEt9eUDij/s8wgQx
         926s10jg78rx9Fes1dY6sVVqyl+hDQq9ZhPgkUg25nyxuRmoIz+gnanWu/TeysytNEze
         nrab1nWVIN8r6jHaR1qTKY/NfRh2y7MIPKRoXKfD6mo4ufBQFBCj2OFFcIEbhvo2syHO
         ybFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pfBf+mjxOblstT2YDIb8V2e3fmSWylUHns8bL17IC00=;
        b=6O6D3qYEseq/3Qk1C+5yPsg65WH3zDlY1H3bxThDxcFjPBL0+cic9DUCdC+4AidbMo
         JhF3to73+lqInSJmLauGjlQEZM+4lkI6BmcjV6O5rtIcmG/GaMxOJqsXBCx5poXZSAzg
         FVLS1D4jUSEuEZNaTu8B0wD3wd0xuHWukYcH/XkXgH7LuqQjuJu1JJrUGspp6lL4G4ub
         emrDJU/apK+GqylK5keDePDmwBLnebVyS+4H51dOU9S160CAMFWAwSPF9w7ZXUHMKRVv
         ZXAyWg/8lYchX9irTYY1pHYVbz1jZmOI7g6+nUR5imIzLmF4zscC0Kd6WK4kAvG0OMIP
         Q+Jg==
X-Gm-Message-State: AOAM532BBkTpT+v+NorjbN7nPFgypOjBw4+GqwoJi7ARI7GOMnvNTi3i
        BRo/Jbv2rUTmio0GMX5LMFs=
X-Google-Smtp-Source: ABdhPJykrXpuFtgpYnoFTothOw3+sFl3t0vcuC1+pdXTBlR6r0Fh3fghhsmtDw3796Uz5Ao4dvd3aA==
X-Received: by 2002:a17:90b:38c7:: with SMTP id nn7mr30321022pjb.135.1640762866050;
        Tue, 28 Dec 2021 23:27:46 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id ot6sm23409193pjb.32.2021.12.28.23.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 23:27:45 -0800 (PST)
Date:   Wed, 29 Dec 2021 16:27:33 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v2 05/23] counter: 104-quad-8: Convert to counter_priv()
 wrapper
Message-ID: <YcwN5e7zjNLANT6d@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-6-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5JDDowHSaG6hAjzN"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-6-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5JDDowHSaG6hAjzN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:08AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This is a straight forward conversion to the new counter_priv() wrapper.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

This patch results in a minor merge conflict with commit c95cc0d95702
("counter: 104-quad-8: Fix persistent enabled events bug") in linux-next
due to context changes in quad8_events_configure() and
quad8_watch_validate(). Fixing this after a rebase is trivial so I'll
give my Ack here.

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/104-quad-8.c | 58 ++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 1cbd60aaed69..6e5286cd1d4e 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -113,7 +113,7 @@ static int quad8_signal_read(struct counter_device *c=
ounter,
>  			     struct counter_signal *signal,
>  			     enum counter_signal_level *level)
>  {
> -	const struct quad8 *const priv =3D counter->priv;
> +	const struct quad8 *const priv =3D counter_priv(counter);
>  	unsigned int state;
> =20
>  	/* Only Index signal levels can be read */
> @@ -131,7 +131,7 @@ static int quad8_signal_read(struct counter_device *c=
ounter,
>  static int quad8_count_read(struct counter_device *counter,
>  			    struct counter_count *count, u64 *val)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	const int base_offset =3D priv->base + 2 * count->id;
>  	unsigned int flags;
>  	unsigned int borrow;
> @@ -163,7 +163,7 @@ static int quad8_count_read(struct counter_device *co=
unter,
>  static int quad8_count_write(struct counter_device *counter,
>  			     struct counter_count *count, u64 val)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	const int base_offset =3D priv->base + 2 * count->id;
>  	unsigned long irqflags;
>  	int i;
> @@ -213,7 +213,7 @@ static int quad8_function_read(struct counter_device =
*counter,
>  			       struct counter_count *count,
>  			       enum counter_function *function)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	const int id =3D count->id;
>  	unsigned long irqflags;
> =20
> @@ -243,7 +243,7 @@ static int quad8_function_write(struct counter_device=
 *counter,
>  				struct counter_count *count,
>  				enum counter_function function)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	const int id =3D count->id;
>  	unsigned int *const quadrature_mode =3D priv->quadrature_mode + id;
>  	unsigned int *const scale =3D priv->quadrature_scale + id;
> @@ -305,7 +305,7 @@ static int quad8_direction_read(struct counter_device=
 *counter,
>  				struct counter_count *count,
>  				enum counter_count_direction *direction)
>  {
> -	const struct quad8 *const priv =3D counter->priv;
> +	const struct quad8 *const priv =3D counter_priv(counter);
>  	unsigned int ud_flag;
>  	const unsigned int flag_addr =3D priv->base + 2 * count->id + 1;
> =20
> @@ -335,7 +335,7 @@ static int quad8_action_read(struct counter_device *c=
ounter,
>  			     struct counter_synapse *synapse,
>  			     enum counter_synapse_action *action)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	int err;
>  	enum counter_function function;
>  	const size_t signal_a_id =3D count->synapses[0].signal->id;
> @@ -399,7 +399,7 @@ enum {
> =20
>  static int quad8_events_configure(struct counter_device *counter)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	unsigned long irq_enabled =3D 0;
>  	unsigned long irqflags;
>  	size_t channel;
> @@ -442,7 +442,7 @@ static int quad8_events_configure(struct counter_devi=
ce *counter)
>  static int quad8_watch_validate(struct counter_device *counter,
>  				const struct counter_watch *watch)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
> =20
>  	if (watch->channel > QUAD8_NUM_COUNTERS - 1)
>  		return -EINVAL;
> @@ -497,7 +497,7 @@ static int quad8_index_polarity_get(struct counter_de=
vice *counter,
>  				    struct counter_signal *signal,
>  				    u32 *index_polarity)
>  {
> -	const struct quad8 *const priv =3D counter->priv;
> +	const struct quad8 *const priv =3D counter_priv(counter);
>  	const size_t channel_id =3D signal->id - 16;
> =20
>  	*index_polarity =3D priv->index_polarity[channel_id];
> @@ -509,7 +509,7 @@ static int quad8_index_polarity_set(struct counter_de=
vice *counter,
>  				    struct counter_signal *signal,
>  				    u32 index_polarity)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	const size_t channel_id =3D signal->id - 16;
>  	const int base_offset =3D priv->base + 2 * channel_id + 1;
>  	unsigned long irqflags;
> @@ -538,7 +538,7 @@ static int quad8_synchronous_mode_get(struct counter_=
device *counter,
>  				      struct counter_signal *signal,
>  				      u32 *synchronous_mode)
>  {
> -	const struct quad8 *const priv =3D counter->priv;
> +	const struct quad8 *const priv =3D counter_priv(counter);
>  	const size_t channel_id =3D signal->id - 16;
> =20
>  	*synchronous_mode =3D priv->synchronous_mode[channel_id];
> @@ -550,7 +550,7 @@ static int quad8_synchronous_mode_set(struct counter_=
device *counter,
>  				      struct counter_signal *signal,
>  				      u32 synchronous_mode)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	const size_t channel_id =3D signal->id - 16;
>  	const int base_offset =3D priv->base + 2 * channel_id + 1;
>  	unsigned long irqflags;
> @@ -589,7 +589,7 @@ static int quad8_count_mode_read(struct counter_devic=
e *counter,
>  				 struct counter_count *count,
>  				 enum counter_count_mode *cnt_mode)
>  {
> -	const struct quad8 *const priv =3D counter->priv;
> +	const struct quad8 *const priv =3D counter_priv(counter);
> =20
>  	/* Map 104-QUAD-8 count mode to Generic Counter count mode */
>  	switch (priv->count_mode[count->id]) {
> @@ -614,7 +614,7 @@ static int quad8_count_mode_write(struct counter_devi=
ce *counter,
>  				  struct counter_count *count,
>  				  enum counter_count_mode cnt_mode)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	unsigned int count_mode;
>  	unsigned int mode_cfg;
>  	const int base_offset =3D priv->base + 2 * count->id + 1;
> @@ -661,7 +661,7 @@ static int quad8_count_mode_write(struct counter_devi=
ce *counter,
>  static int quad8_count_enable_read(struct counter_device *counter,
>  				   struct counter_count *count, u8 *enable)
>  {
> -	const struct quad8 *const priv =3D counter->priv;
> +	const struct quad8 *const priv =3D counter_priv(counter);
> =20
>  	*enable =3D priv->ab_enable[count->id];
> =20
> @@ -671,7 +671,7 @@ static int quad8_count_enable_read(struct counter_dev=
ice *counter,
>  static int quad8_count_enable_write(struct counter_device *counter,
>  				    struct counter_count *count, u8 enable)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	const int base_offset =3D priv->base + 2 * count->id;
>  	unsigned long irqflags;
>  	unsigned int ior_cfg;
> @@ -699,7 +699,7 @@ static const char *const quad8_noise_error_states[] =
=3D {
>  static int quad8_error_noise_get(struct counter_device *counter,
>  				 struct counter_count *count, u32 *noise_error)
>  {
> -	const struct quad8 *const priv =3D counter->priv;
> +	const struct quad8 *const priv =3D counter_priv(counter);
>  	const int base_offset =3D priv->base + 2 * count->id + 1;
> =20
>  	*noise_error =3D !!(inb(base_offset) & QUAD8_FLAG_E);
> @@ -710,7 +710,7 @@ static int quad8_error_noise_get(struct counter_devic=
e *counter,
>  static int quad8_count_preset_read(struct counter_device *counter,
>  				   struct counter_count *count, u64 *preset)
>  {
> -	const struct quad8 *const priv =3D counter->priv;
> +	const struct quad8 *const priv =3D counter_priv(counter);
> =20
>  	*preset =3D priv->preset[count->id];
> =20
> @@ -736,7 +736,7 @@ static void quad8_preset_register_set(struct quad8 *c=
onst priv, const int id,
>  static int quad8_count_preset_write(struct counter_device *counter,
>  				    struct counter_count *count, u64 preset)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	unsigned long irqflags;
> =20
>  	/* Only 24-bit values are supported */
> @@ -755,7 +755,7 @@ static int quad8_count_preset_write(struct counter_de=
vice *counter,
>  static int quad8_count_ceiling_read(struct counter_device *counter,
>  				    struct counter_count *count, u64 *ceiling)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	unsigned long irqflags;
> =20
>  	spin_lock_irqsave(&priv->lock, irqflags);
> @@ -780,7 +780,7 @@ static int quad8_count_ceiling_read(struct counter_de=
vice *counter,
>  static int quad8_count_ceiling_write(struct counter_device *counter,
>  				     struct counter_count *count, u64 ceiling)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	unsigned long irqflags;
> =20
>  	/* Only 24-bit values are supported */
> @@ -807,7 +807,7 @@ static int quad8_count_preset_enable_read(struct coun=
ter_device *counter,
>  					  struct counter_count *count,
>  					  u8 *preset_enable)
>  {
> -	const struct quad8 *const priv =3D counter->priv;
> +	const struct quad8 *const priv =3D counter_priv(counter);
> =20
>  	*preset_enable =3D !priv->preset_enable[count->id];
> =20
> @@ -818,7 +818,7 @@ static int quad8_count_preset_enable_write(struct cou=
nter_device *counter,
>  					   struct counter_count *count,
>  					   u8 preset_enable)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	const int base_offset =3D priv->base + 2 * count->id + 1;
>  	unsigned long irqflags;
>  	unsigned int ior_cfg;
> @@ -845,7 +845,7 @@ static int quad8_signal_cable_fault_read(struct count=
er_device *counter,
>  					 struct counter_signal *signal,
>  					 u8 *cable_fault)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	const size_t channel_id =3D signal->id / 2;
>  	unsigned long irqflags;
>  	bool disabled;
> @@ -875,7 +875,7 @@ static int quad8_signal_cable_fault_enable_read(struc=
t counter_device *counter,
>  						struct counter_signal *signal,
>  						u8 *enable)
>  {
> -	const struct quad8 *const priv =3D counter->priv;
> +	const struct quad8 *const priv =3D counter_priv(counter);
>  	const size_t channel_id =3D signal->id / 2;
> =20
>  	*enable =3D !!(priv->cable_fault_enable & BIT(channel_id));
> @@ -887,7 +887,7 @@ static int quad8_signal_cable_fault_enable_write(stru=
ct counter_device *counter,
>  						 struct counter_signal *signal,
>  						 u8 enable)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	const size_t channel_id =3D signal->id / 2;
>  	unsigned long irqflags;
>  	unsigned int cable_fault_enable;
> @@ -913,7 +913,7 @@ static int quad8_signal_fck_prescaler_read(struct cou=
nter_device *counter,
>  					   struct counter_signal *signal,
>  					   u8 *prescaler)
>  {
> -	const struct quad8 *const priv =3D counter->priv;
> +	const struct quad8 *const priv =3D counter_priv(counter);
> =20
>  	*prescaler =3D priv->fck_prescaler[signal->id / 2];
> =20
> @@ -924,7 +924,7 @@ static int quad8_signal_fck_prescaler_write(struct co=
unter_device *counter,
>  					    struct counter_signal *signal,
>  					    u8 prescaler)
>  {
> -	struct quad8 *const priv =3D counter->priv;
> +	struct quad8 *const priv =3D counter_priv(counter);
>  	const size_t channel_id =3D signal->id / 2;
>  	const int base_offset =3D priv->base + 2 * channel_id;
>  	unsigned long irqflags;
> --=20
> 2.33.0
>=20

--5JDDowHSaG6hAjzN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMDdoACgkQhvpINdm7
VJIiYxAAvikM2hzuC/EFRYEX/SJ9uYs8rTGWuGJeo6auTea8ZejLWH6PfQ1qpmb/
Qbi4LIy541W4n6vmeb+plOyNizyhiI/NX+9g2MyRCFpMsQiQIfuX5ELsjC0LjisI
SdXAJsAh0i7ELWf2xLw1ZnwuGqfGVApMP5SiCUvOc38K0osrnF20M9HPS/nlCgur
yMhsYMaj0K7EdwgBB6orE3XLQXrDMkraDd5i9SEPhYA2cmoxGHxLrsn8mtFYty2w
sPycIerHj+NGSiv+Y/9M+fazZysbhpg0pIHmJkTC2+1nFhBbluHy6BSNu43kQ2p9
DClq3awQas8hspW+EdnFBLdKDsoEaP+LSnR4G8y2cNcxVVoSfnv0OcugZIfAAcRF
8spcjArSZNuzXt9Cv6CpJFT1mMmUYX/GRUPUFgLx2vu2WR6fAf03k8upwkjkdh3J
Cm8zTp6RUwGZ6MXqJYuXHcGJ8sNDl7LhApY8lZLMPtBJ6/oJjUuhRUxpwlhW91OK
Al3GtAFf+cjyjeD2gN12ieRQMxLfzO7rWNJQDJdzYcLfuFcOKjNwx++hY/hyXr9E
/KC21VPZlv3k3TAJNtLlLf79/GpAFakch5Jkjt5l1kG1+VOSxA4036E7EXo2J2Um
Ig2Oe87OkTrYjSDutL2ZtxHHuUl8fLw6Xa+CjN5oeiiRX5VOLlY=
=AiB1
-----END PGP SIGNATURE-----

--5JDDowHSaG6hAjzN--
