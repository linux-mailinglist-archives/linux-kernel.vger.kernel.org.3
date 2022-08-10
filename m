Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED97358EEC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiHJOtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiHJOtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:49:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCA77391B;
        Wed, 10 Aug 2022 07:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0A4C60B7A;
        Wed, 10 Aug 2022 14:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3EBC433C1;
        Wed, 10 Aug 2022 14:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660142954;
        bh=UlnvNtS2PYfeiyYEh4WcIGFDpJnH7nyR5cNpKi8CjtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zl3CihL+cc0bTGDr0zwQW+ZxtIWVVPKGGYIHssAtI4F8BEqEFW3GZ1QDsy4LiJgcu
         pQS8pZ44/jCO8laQgoeAB/z0Rl5EMylLq4BZ/7AWSnVo5ICeBOKS/xGvc8rp1tEboK
         Z3br8a6X6buszDfU6MRpzsjARX/qygAQ5EeiNJMDg9BKS2rKJi80VOTH6ZHln1QxKn
         N0S5JyJGGqgGO+vda1Ipocy/kKt6qjOq9xCiRAQ+zoL8DfMHrDhXP6hYDqy4O/8t2V
         NhRF/n2unwqaf1vH5v2ZbjwHvijBzyfi8RZ+gNg/Bnnq5yXt5Cncn5N/OQmAj5376N
         V+YcEYePjBHaA==
Date:   Wed, 10 Aug 2022 15:49:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Da Xue <da@libre.computer>
Subject: Re: [PATCH] spi: meson-spicc: save pow2 datarate between messages
Message-ID: <YvPFZZ2HT2zK9XjQ@sirena.org.uk>
References: <20220809152019.461741-1-narmstrong@baylibre.com>
 <YvJ84qkuXdvVgXRm@sirena.org.uk>
 <39c2f53b-8f53-ceb1-ae0c-81e5e53d01aa@baylibre.com>
 <YvOmnDJA+ov49chC@sirena.org.uk>
 <518f22f4-1582-924c-9eaa-28ebbe53a632@baylibre.com>
 <YvPBX7zJ72RXnrpk@sirena.org.uk>
 <9dabe979-f6b5-329d-f017-a8f0c00adeca@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ueoh6h2+Qr1KrJd4"
Content-Disposition: inline
In-Reply-To: <9dabe979-f6b5-329d-f017-a8f0c00adeca@baylibre.com>
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


--ueoh6h2+Qr1KrJd4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 10, 2022 at 04:40:04PM +0200, Neil Armstrong wrote:

> I don't think it's worth adding so much code for this since we already

I don't recall the code for clock providers being that hard?  They're
generally pretty small, some of the ASoC CODEC drivers did something
similar.

> had an open-coded function which perfectly worked before.

Except in the cases it didn't...

> I'm perfectly OK to remove the CCF driver for the legacy clock path
> and return back to the old open coded calculation since it perfectly
> worked and stop using the legacy clock path for new SoCs since it would
> never be selected anyway...

It does seem better to go the clock provider route TBH.

> ... but GX SoCs are broken so it would need an intermediate fix until
> I push the refactoring to cleanup all this.

I'm trying to figure out if this is actually fixing the problem or just
papering over one case where things happened to go badly.

--ueoh6h2+Qr1KrJd4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLzxWQACgkQJNaLcl1U
h9DYQQf/QZ4CbFLmTpm/v3VlaF0OZUMbkfJ+OzC3L2yQO8LFvsudGllwYcUAY0ks
Wgk3BuL7xPDkmstAgIoJulYomZKeUgP0vnpIfk6jlfzpdDQhfA/r2z/87nrQtjCw
9TrHXn5w9t6kDa5XIS0bE87+PHTqeuwmPcZJPNbU8faGXyJoegZPGBAb/HBpe4lz
m6fza4Zhx66dnbmQ3r9F5cW85yEeuD95BeW9FfN583uD87bzQAOaIqDJnvbMvDj4
gyu1xiiIw0QhxHLyNZZaMLMoaYWr4869eziFmcqNkwdejET11UqXwrnQusZzzUFs
JoOMpvNMSzkYCQo48Vy6CGJBsXtq8w==
=bPSm
-----END PGP SIGNATURE-----

--ueoh6h2+Qr1KrJd4--
