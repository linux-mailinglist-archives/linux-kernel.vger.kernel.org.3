Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CCD58EC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiHJMiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiHJMhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:37:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5417756F;
        Wed, 10 Aug 2022 05:37:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A0F561347;
        Wed, 10 Aug 2022 12:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7B5C433D6;
        Wed, 10 Aug 2022 12:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660135073;
        bh=ROHaIZk75ZgJisF7nTMLDJS9o0AxLi1V/y+T67/KwWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qg7V+bjI7lf3dzSN62yYr9g4pSgwDtQDJWcjI3dRgZRvMIoOD/bbKegaOJMO2MzWN
         SE+A3aKfjpe80HoF1s2lo5xVS6gIkpmA1DpXIUnW2aHmkkpf3RJ/y8dJotPeQecNET
         e5qc36Vnk3SFh2ixHl5EoVsn2FhJ3CmaaVXyK9sh5fVsJqfdHGFcit844ItnozYVb6
         CGZ4Ma5LOKbVbJtmpUwe4+JSb49OOdw677rfq2XdN3V5GeorsO5RJZw/LAVbThEAK4
         woyx4cJp5ybMTB/NJtCaI8FBAu4HmfiRtObEhNrpbt1GgSGGFejKux81LEpIDva+n8
         xCEk6z1CseItQ==
Date:   Wed, 10 Aug 2022 13:37:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Da Xue <da@libre.computer>
Subject: Re: [PATCH] spi: meson-spicc: save pow2 datarate between messages
Message-ID: <YvOmnDJA+ov49chC@sirena.org.uk>
References: <20220809152019.461741-1-narmstrong@baylibre.com>
 <YvJ84qkuXdvVgXRm@sirena.org.uk>
 <39c2f53b-8f53-ceb1-ae0c-81e5e53d01aa@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2hd26sDiWQtv5ujx"
Content-Disposition: inline
In-Reply-To: <39c2f53b-8f53-ceb1-ae0c-81e5e53d01aa@baylibre.com>
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


--2hd26sDiWQtv5ujx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 10, 2022 at 11:17:14AM +0200, Neil Armstrong wrote:
> On 09/08/2022 17:27, Mark Brown wrote:
> > On Tue, Aug 09, 2022 at 05:20:19PM +0200, Neil Armstrong wrote:

> > When you say the value set by the clock framework does that mean that
> > the clock driver is adjusting hardware inside the SPI controller IP
> > block which is then getting reset by the SPI driver without the SPI
> > driver knowing about it?  That seems like a bad idea as you're finding
> > here.

> The SPI driver is explicitely triggering a reset at the end of each message
> to get back to a clean HW state, but it does reset the content of the "legacy"
> registers containing the power of 2 divider value, the new registers configuring
> the new clock divider path (only on newer SoCs) doesn't get cleared.

Sure, but that doesn't really address the concern - is this something
that the clk driver programmed or is this the driver forgetting to
restore a register that it programmed itself?  The commit message sounds
like the former which is a much bigger problem.

--2hd26sDiWQtv5ujx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLzppwACgkQJNaLcl1U
h9CP8Qf/cMQYM72jnQkNExfj6dskX5IIOlwCnAVUEnsbYrFpv3QL6BNLxgKx4eqx
cjDy+gszIhOd4rr7/ayE4siN6fjOo/hWNIuydrrCsRWKrjvKTUInWB16AnVv5NrK
JAjl3RZ9vrkKp2UcN/dsaU11B5Xce59ko2nuniDhKYZhubO9F2uYxOPiBLvufQyU
Q20TDeHIgYaClQvbbnVnIBpjkeOYaZxhkpAjZmw/Btip07mzspkcC4ASnTbTKs2j
cCeDY+xkSNPqT+Pie+GxbV0bOeAjLdUOwP7QoXIsrP4BJRzuoHk/aXWC8GzXo13a
3baxwuQr/bFzHeoJRT+a3zrpms9mLA==
=yOBS
-----END PGP SIGNATURE-----

--2hd26sDiWQtv5ujx--
