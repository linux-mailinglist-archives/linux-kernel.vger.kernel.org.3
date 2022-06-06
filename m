Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A6153EF6B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiFFUSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiFFURw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:17:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF00862A24;
        Mon,  6 Jun 2022 13:17:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C422614F9;
        Mon,  6 Jun 2022 20:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCE5C385A9;
        Mon,  6 Jun 2022 20:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654546665;
        bh=/B/PloBld3O4RZgCV+lWXc3i8yVuTLMMkjx9VYvCuws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aoKo2oMj/3Zm29onm9GITm4MOVqXfu7+oV0bWECk3Z8pxRMmbBzPeRLkQJ7bc/eMZ
         k0fbcvuo7hEgg+OIva5vuVm112PdpnSHmWtKZkcm3z2ryt0g2UST/yudrgzTG47qCS
         8pdQTb7WDLJ+c43lGsbgXGidsXNQtW3z14NJEje+1u8lCONjFVNgIrvIeYPeYnyzrz
         7BOaEGuqn0FtB5WNp1bye/dOhP9Mnp1ApvtcC3nV0lQ9fH6qhMJ8XO653U1hTrqkpU
         wOa3b2pit7AO9MKP19/cFJFVkN23xKJEEzeNGvfAJaILVx/n4KV/Lp7HJKu72MG2rg
         fp1Rzb6VMDC0Q==
Date:   Mon, 6 Jun 2022 21:17:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev
Subject: Re: [RFC PATCH v2 3/5] ASoC: apple: Add MCA platform driver for
 Apple SoCs
Message-ID: <Yp5g43IxFQsUoS/y@sirena.org.uk>
References: <20220606191910.16580-1-povik+lin@cutebit.org>
 <20220606191910.16580-4-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="elKz+L5SmKmXJeQI"
Content-Disposition: inline
In-Reply-To: <20220606191910.16580-4-povik+lin@cutebit.org>
X-Cookie: Have an adequate day.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--elKz+L5SmKmXJeQI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2022 at 09:19:08PM +0200, Martin Povi=C5=A1er wrote:

> +++ b/sound/soc/apple/mca.c
> @@ -0,0 +1,1122 @@
> +/*
> + * Apple SoCs MCA driver

Please add SPDX headers to all your files.

> +		mca_modify(cl, serdes_conf,
> +			SERDES_CONF_SOME_RST, SERDES_CONF_SOME_RST);
> +		(void) readl_relaxed(cl->base + serdes_conf);

Please drop the cast, casts to/from void are generally a warning sign as
they're unneeded in C.  If you want to document the barrier use a
comment or wrapper function.

> +	/*
> +	 * Codecs require clocks at time of umute with the 'mute_stream' op.
> +	 * We need to enable them here at the latest (frontend prepare would
> +	 * be too late).
> +	 */
> +	if (!mca_fe_clocks_in_use(fe_cl)) {
> +		ret =3D mca_fe_enable_clocks(fe_cl);
> +		if (ret < 0)
> +			return ret;
> +	}

This requirement is CODEC specific.  It's fine to bodge around to
satisfy it though, especially given the restricted set of platforms this
can be used with.

> +	fe_cl =3D &mca->clusters[cl->port_driver];
> +	if (!mca_fe_clocks_in_use(fe_cl))
> +		return 0; /* Nothing to do */
> +
> +	cl->clocks_in_use[substream->stream] =3D false;
> +
> +	if (!mca_fe_clocks_in_use(fe_cl))
> +		mca_fe_disable_clocks(fe_cl);

Are you sure this doesn't need locking?

--elKz+L5SmKmXJeQI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKeYOIACgkQJNaLcl1U
h9BVlQf9Hhza64pdhAryt0leuNmoItrjQI4ru3oVzIPzjS1FTHojgISfLilo8RjN
xsVACb5GG0HKM5P/KUmFuH3+niL6W1zxmfO67gzGz0gr5zGpQLvy7XaNc52rVqM5
u5A9NH0Mqv4/OBbjCi8UzbhG8wZfkAIr2B6FENy3KsSbzdUq2crOrOhiS+TwEK8P
gQ0yfnnAAm7oueBiZ0ByCfMHOeBtG6dR3o5Yz+UhnZDmg783E0xvz4okjXcbuo2m
eHMDeulABPHv86DHGZ3KlvUHIK3n8398P1iZxs/0NuJqvNkT4JFcL06Y1TFYeywz
/0ogXX5hoScevm8+OW4gzuc99bGDBA==
=ItfL
-----END PGP SIGNATURE-----

--elKz+L5SmKmXJeQI--
