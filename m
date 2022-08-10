Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F1158ECC2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiHJNG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiHJNGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:06:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B691B792FC;
        Wed, 10 Aug 2022 06:06:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1805C61449;
        Wed, 10 Aug 2022 13:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F51FC433D6;
        Wed, 10 Aug 2022 13:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660136811;
        bh=DFYcxkifXKeWtF6+tBZaGptaS5MZmDKyrcXwMH4vbSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cjw9igqkuWhf0iIB0dISFN8WPn2Pdqse0igBL2QaHIhBUXgORx9+YoGFSYRkWDF6U
         DeQlP5G1A7u7K/uu0KGYfWc1mca6irazbf+gDohG4kTqb0V1eqZtOz5lwmbh7nB0jJ
         bRz4BAnreazX2IpuhfcyvI5cRzZCu1sruAR3xo9pC8LNFIetGlYtiiH8yPmRdfUEz2
         jkSo1Yo7etVmb9D5kW8omuxoHXDIld2vppvSx4iLiR//DEw4dYXbcz6QNMSIfoHTj/
         /c9NvBSrowwEFe/FHTinkwPifCq5XhsEAhi7dP23IS2bbuSRcdDFBWfzMvml6MkRRn
         8URZpnbQO+xyA==
Date:   Wed, 10 Aug 2022 14:06:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     patrice.chotard@foss.st.com
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com
Subject: Re: [PATCH v2 1/2] spi: stm32_qspi: Add transfer_one_message() spi
 callback
Message-ID: <YvOtZtrRHd4AT+j+@sirena.org.uk>
References: <20220810093215.794977-1-patrice.chotard@foss.st.com>
 <20220810093215.794977-2-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qIGcIJcaVg00Gpny"
Content-Disposition: inline
In-Reply-To: <20220810093215.794977-2-patrice.chotard@foss.st.com>
X-Cookie: First pull up, then pull down.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qIGcIJcaVg00Gpny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 10, 2022 at 11:32:14AM +0200, patrice.chotard@foss.st.com wrote:

> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>=20
> v2: _ use parallel-memories property
>     _ set auto_runtime_pm to true
>     _ remove pm_runtime_*() usage in transfer_one_message() callback
> ---

The changelog should come after the --- so that it gets automatically
stripped out by tooling.  No need to resend just for this.

> +	/*
> +	 * Dual flash mode is only enable in case "parallel-memories" and
> +	 * "cs-gpios" properties are found in DT
> +	 */
> +	if (of_property_read_bool(dev->of_node, "parallel-memories") &&
> +	    of_gpio_named_count(dev->of_node, "cs-gpios")) {
> +		qspi->cr_reg =3D CR_DFM;
> +		dev_dbg(dev, "Dual flash mode enable");
> +	}

Do we need to add something to the DT bindings to indicate that
parallel-memories is valid?

--qIGcIJcaVg00Gpny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLzrWUACgkQJNaLcl1U
h9AkJQf/Y+IYz/LCzWBub55CWbzvK9ruoENfm9CuX6uNA/3NAwmONWNa9ggB08wO
4TujrybikyjoRk1vZ7QNKx49cA/4npKx0vDeAplPuSSKKJYQJjIfcOBfYpVkurqX
w9mj2AptUhV9ZCc5wcasgXSz6uIvyl/RtyKjCc7o49laJq/pyEEgPPpH/hKaO+jH
lZM8oIHqlZcWxdhL5p0XDFPpZd2sbiFeY714yWVh2kX/bSx8DFNU8Y+NJ43gkgEH
5duFoaAQp9i2IfaoBT75NZgKUhiR+mmF+ujsc+7GMXbqp1ekFX3V6ynW7BavXs+X
Nh/xQwsJT6MvqILv4XCxHvVbWs48BA==
=p2wA
-----END PGP SIGNATURE-----

--qIGcIJcaVg00Gpny--
