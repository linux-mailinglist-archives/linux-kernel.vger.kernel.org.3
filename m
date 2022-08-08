Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0B758C976
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243336AbiHHNaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242628AbiHHNaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:30:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C75BC26;
        Mon,  8 Aug 2022 06:30:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D5B06121F;
        Mon,  8 Aug 2022 13:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B98EC433C1;
        Mon,  8 Aug 2022 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659965404;
        bh=a11PrFr0QU2TMyjEjHd+D+4ZCEi56EIcD/sVdbPA3TI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NuDhuwm/QcTsNh0is7t//3B9+WHiIeVx3ZPjdyJFyhaQIlDI9bkrYIfyqbntMFhS9
         M1YTVKshagYN9BdY3hHlXibw4YOp61AipofX35bPepSo40/IN9bDHAS9t8aTLSNEoQ
         /maE81f8ccwW5SFOO0BcZyUWwOqDhNurpW1QDIuxpYRHokbBZAzYF9UWSBZHIVaMnY
         CEke5nKo+Ny0U0wWF8mx35fHbr4/w7cEXyCoHk+1J0j2n8mFj+Hh4JP8Gym42dBttp
         2dpxkEUoBOJ5qyISKDmA9HpORWlZlvBQV8+POdgMOeVsi2Hl1yLSejntcmCQvTres3
         H4UmlRnhvB2Kw==
Date:   Mon, 8 Aug 2022 14:29:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     patrice.chotard@foss.st.com
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: stm32_qspi: Add transfer_one_message() spi
 callback
Message-ID: <YvEP15/7KmQGyPgL@sirena.org.uk>
References: <20220808074051.44736-1-patrice.chotard@foss.st.com>
 <20220808074051.44736-3-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cLMWiIMhBnFRWQta"
Content-Disposition: inline
In-Reply-To: <20220808074051.44736-3-patrice.chotard@foss.st.com>
X-Cookie: Flee at once, all is discovered.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cLMWiIMhBnFRWQta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 08, 2022 at 09:40:50AM +0200, patrice.chotard@foss.st.com wrote:

> +	ret = pm_runtime_get_sync(qspi->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(qspi->dev);
> +		return ret;
> +	}

Use the core runtime PM, there should be no need to open code.

--cLMWiIMhBnFRWQta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLxD9YACgkQJNaLcl1U
h9B5sgf+In74ixHnCRZMTBmlDnGq0rbz2vl15eopttvjouYl8KTYKUmRnu8dfafd
nscthycpSYVRecbPtNW3Q1PoEOg9x5iEwUtC7uEPmk2oWD/c2Ck2691Zd5aUA18r
aOPa0BO3D/TPDhAwWfI6jPIcNbrPYksSL2yFSRogAeBhq3ze/USWI+6IOspS6IR9
uvkG/XI2gA6b5CcJBXQsK40bZNX97y4QnKtzWLERmPDe3s+ljYTdJf0+djVVQg24
Oi67dvkkT8FFu8Je4S/bStR8rNvksD40FnM7RYU7Z+200TzNcRd/NCBrfAx5xSuD
BAaW4TcV9hF2egVdRVLL+xLtZR63Ew==
=y3IU
-----END PGP SIGNATURE-----

--cLMWiIMhBnFRWQta--
