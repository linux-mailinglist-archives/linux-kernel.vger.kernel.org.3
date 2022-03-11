Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62E14D625A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245737AbiCKN1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240969AbiCKN1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:27:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EDB77AA6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 05:26:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC6C461E1E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 13:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89470C340E9;
        Fri, 11 Mar 2022 13:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647005193;
        bh=JV5dp9g+TAY5SSai+UAS2mG/uTcSNrIa389c8fPQlPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmQaGbDuPPEXWIpZXDwFBVdTQLTyOXbaJi9fSvRLcNqcHa24Aym+DFKAvfwGqbWaa
         KovDSW3KGMppZJYyfwNaayDpLmDCEiil2NCHgOCdw/ydgrmLF6atTVUX2NEyKByufR
         YXIElxIwTyophPfYhTyQT/i6/LLk3KtavUYF96BWaEdRN5XiiUxh8U3IndAwaWHD8m
         ZRUKKjyPzWHB0cj+bxrbjv0SoJzGKWiYRUXIw3cWiYw3VLjWEP1YygSJyBfiMzz5E6
         DXcglmqg2SKbdMZ7qLU9zy832p8B5cotjnR9FiopSmbWozjUUqWtT/5zQLGaBiUdCD
         7Ss9C0e/SB+HQ==
Date:   Fri, 11 Mar 2022 13:26:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Asymmetric regmap read/write reg
Message-ID: <YitOBbJd4mY3hjSA@sirena.org.uk>
References: <20220310215408.GA3149079@euler>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tfzFQds3CQb/PCVZ"
Content-Disposition: inline
In-Reply-To: <20220310215408.GA3149079@euler>
X-Cookie: A fool and his money are soon popular.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tfzFQds3CQb/PCVZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 10, 2022 at 01:54:08PM -0800, Colin Foster wrote:

> The Ocelot chip has requires 100ns between address write and when the
> address is ready to be clocked out. This can be dealt with in three
> different ways:
> 1. Use a slow enough clock speed
> 2. Use a delay between address write and value read
> 3. Clock out N padding bytes to account for the 100ns access time
>=20
> Forcing a slow clock speed is obviously not ideal, and forcing a delay
> between "write_then_read" sounds too driver-specific, so option 3 seems
> like the best option - especially if bulk reads are utilized.
>=20
> Where regmap comes in is specifically the padding bytes. Reads require

Why not implement this using a delay?  That seems both more
straightforward and likely tending to be more accurate given that clock
rates for SPI devices tend to be a bit vague.  Much less disruptive to
implement too.

--tfzFQds3CQb/PCVZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIrTgQACgkQJNaLcl1U
h9BeLgf+LLbPW8CHVk2YjB9BkNqoZblpnZ7lo74hLtRI/781lHmhBNxm/MvZxAI7
XhlErE0SmyQfLKrnIM+ns5yYYt36eYV5j1FxoJwxubZu6r82CA4xNj/jPiUfBks8
qgI7YzIsxly7PVz6SBFgRjlNWe4IP+j9sjkYLy+Ez3EK812kyrnpvDWDCYHa+jhx
M4Oh6G1+5HtoUcv4pVG7yWqD40d+RKgSB47TvEJThoL0j5K8gcbpTXYADvb2/P8f
iqrNzeQv6KeZnYtfP5WWFi2hEpEQpejzeOFnq8MjJPd3RpVErTjJNdZp++qxQtwS
FA6Mt8UfJRVTEMNYMep/FcrhRWiWsQ==
=XMCC
-----END PGP SIGNATURE-----

--tfzFQds3CQb/PCVZ--
