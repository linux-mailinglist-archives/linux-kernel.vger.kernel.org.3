Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395EC544B10
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244568AbiFILyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiFILyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:54:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EBE2AF5;
        Thu,  9 Jun 2022 04:54:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CF65B82D2A;
        Thu,  9 Jun 2022 11:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE14C34114;
        Thu,  9 Jun 2022 11:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654775671;
        bh=W1JWHnccUeXeAdpiFbBoUz5WTQ95dDENGZmMGVO/HCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qxvUp7I06JbQcQ1Ts5s+jxq7RgLhlztPitqQElHUmbhCwAWbQXoEveAJnO+fb2JPn
         KZCr7755OH2Sk8WSRFRBfvlItBmyYUM4as4j38U6BAtI/79y5dx9BXM9gtpPWITv6T
         VT0nnQ0KpsL98b6uDPT/y3hwhcQBq9a8DUyOdNC18vzxOpfz8ozjE/YYAdzeaspgOM
         XBLv4lEP5GnSCpAnkoxeCGTZkagXQLcbRs9PQeli3RCV4xHYAlnZ12ukx0fqK5Pwj/
         1HOt52OjyRureUhAHb135ViPF6n1fOE9PzN6wABgWe70eBcQ71n00TcXxaYyCczjAk
         oskBBB3AEwoEw==
Date:   Thu, 9 Jun 2022 12:54:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, git@xilinx.com, michal.simek@xilinx.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, michael@walle.cc,
        linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH 1/2] spi: Add multiple CS support for a single SPI
 device
Message-ID: <YqHfccvhy7e5Bc6m@sirena.org.uk>
References: <20220606112607.20800-1-amit.kumar-mahapatra@xilinx.com>
 <20220606112607.20800-2-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jdtMuzYKequAryYb"
Content-Disposition: inline
In-Reply-To: <20220606112607.20800-2-amit.kumar-mahapatra@xilinx.com>
X-Cookie: Space is limited.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jdtMuzYKequAryYb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2022 at 04:56:06PM +0530, Amit Kumar Mahapatra wrote:

> ---
>  drivers/spi/spi-zynqmp-gqspi.c | 30 ++++++++++++++++++++++++++----
>  drivers/spi/spi.c              | 10 +++++++---
>  include/linux/spi/spi.h        | 10 +++++++++-
>  3 files changed, 42 insertions(+), 8 deletions(-)

Please split the core and driver support into separate patches, they are
separate things.

> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2082,6 +2082,8 @@ static int of_spi_parse_dt(struct spi_controller *c=
tlr, struct spi_device *spi,
>  {
>  	u32 value;
>  	int rc;
> +	u32 cs[SPI_CS_CNT_MAX];
> +	u8 idx;
> =20
>  	/* Mode (clock phase/polarity/etc.) */
>  	if (of_property_read_bool(nc, "spi-cpha"))

This is changing the DT binding but doesn't have any updates to the
binding document.  The binding code also doesn't validate that we don't
have too many chip selects.

> +	/* Bit mask of the chipselect(s) that the driver
> +	 * need to use form the chipselect array.
> +	 */
> +	u8			cs_index_mask : 2;

Why make this a bitfield? =20

I'm also not seeing anything here that checks that the driver supports
multiple chip selects - it seems like something that's going to cause
issues and we should probably have something to handle that situation.

--jdtMuzYKequAryYb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKh33AACgkQJNaLcl1U
h9CsYAf+K7KXAUBJmbfepS1Fpu01afQQATn4uiX25nly77oXZeedKRHFW8DxNljZ
YrOPvrEgZ1RifDvfB2rXf7nqI1vbnPYs7V5fDbXEmY+CHgkkuoQTVmEI68woVgmh
bLGBMoegY4LCy9p+WVKdQNQ+qVjLC+DZvfzdvhCnWfNtvPV0dwyAZfkrtzzwLNdn
r2gtsF0vRwXeWXXWf4SzYdEhwjgGjJDM8ZRI/BIx4Q5Qzi80xTQIhy6lpps/YmTk
BgCy9wXOjDysA5+pPv9JB+V4n75ReIyNCVcYTztEmdGEJZPVswnKgzjUC0Da1h9K
uH3JL+kR4RFtVVb5+a6522VKxKGNdg==
=xJNv
-----END PGP SIGNATURE-----

--jdtMuzYKequAryYb--
