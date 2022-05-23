Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A261853149F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbiEWN1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiEWN12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:27:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDE2205DE;
        Mon, 23 May 2022 06:27:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E433E6090A;
        Mon, 23 May 2022 13:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DBCC385AA;
        Mon, 23 May 2022 13:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653312440;
        bh=Fermaw7N8qoNQ4T1a2iSIeEbX8O6G2yVSE7iwmWudss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GmfXRMOC2Jq8CtoOUwJM1VavjbnVJHeeB2gILExxly8MAmqfZhHJ/Wbnr31lmZuc+
         wRYq40jnFTKkb3zYRyUxxTQUQpqVs0a4kIHq63BCjYQUhRuBoy2D6eH6z/Ej1AeGaF
         6BHiHODEZcD3AZyIAhNjlzgE3lnY71oyD36cxdomuHb6WNEHvv+UwAU5NDRummaDEW
         +1m1ydammfOJGvtM/NL8NcetPtsFcmCYvZ/GqSfMLzANNIFU2QjyFAT4mLNN8rukP1
         R+yTG4FRygSuXoQk/3MI2kt0CQzuRlLunp4sIopod04gQGVl4fnjUfZwZsxvpK4tNf
         Yf5X984hpF2/w==
Date:   Mon, 23 May 2022 14:27:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v1] spi: imx: mx51-ecspi: fix clk polarity and phase
 configuration for CS > 4
Message-ID: <YouLs1xoxOCdyBlU@sirena.org.uk>
References: <20220523073143.778664-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dE31JipDzIkqI+Sx"
Content-Disposition: inline
In-Reply-To: <20220523073143.778664-1-o.rempel@pengutronix.de>
X-Cookie: Sales tax applies.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dE31JipDzIkqI+Sx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 23, 2022 at 09:31:43AM +0200, Oleksij Rempel wrote:

> -	/* set chip select to use */
> -	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);
> +	if (spi->cs_gpiod) {
> +		chip_select = 0;

What if someone mixed GPIO and regular chip selects and 0 is one of the
in use chip selects?  Ideally we should check for an unused chip select
here, though the current change is still an improvement since we'll at
least only write in the chip select field.

--dE31JipDzIkqI+Sx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKLi7IACgkQJNaLcl1U
h9CxGQf9H/g5UyTrEeUzmcTSlNIAMnppIbjCjex9k6S57Xm+hDke4Pu3hHQmxRe7
gBeCNC2A6VJWqPTY0L1M7atQO/FAOpMMoUjCkw7w/aM1Oz42j6HL20euo7HL/lud
olVB7SeBhWwQMriA0M5QUiDkxFi5Zx5xb3vCWPdPqdHf3T1nu45Y8vPGdv0cWGbT
ogcKA5d0UYF4RCH24yAe1r2nRCWQerheg8MxgcY5rP0uFJZABL2aAvUKk/iydXEN
pUEPXVdcfv+rrf82Sz1Zz8Y+hmDe0F6OqWz40xT+Dbhdoo9KEkHtmkSnxD2EZFLR
VQmADajaeyoUXMUtQFbO3gLDs1TzBQ==
=KLbp
-----END PGP SIGNATURE-----

--dE31JipDzIkqI+Sx--
