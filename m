Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C4A4ADB6A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351240AbiBHOla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiBHOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:41:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E67C03FED0;
        Tue,  8 Feb 2022 06:41:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACFB5B81AF8;
        Tue,  8 Feb 2022 14:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F45C004E1;
        Tue,  8 Feb 2022 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644331285;
        bh=S2Mhl+SP+krSYHv8YbK+y9MJgy+YlW+2kfYbIoDxG68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HKCzlP4n8IGs7fL0TOcDJCjbRQNsbErtXPYz5+Fa3jOdvZ8xePIsFRZHfOX/CrCi+
         oR09E+WrZeEaoXNz7F3K17cNPzCzGuTGR6bwztv8tBDYnSNObLfn7t1cP46SmVWlu5
         ymTKB2BUW7dlrwBoZUlIE5O5WXb4HEte4tOzsq/mDep3SHpG8tb+qvIM8uRy5j9ZMk
         EUneCfvv4owzLlepm9/oLbGtm0wGiXl8+oxX0457N5qXJeMwO1oJCfu7Pq0SGXL2gF
         4Gm9WRrPMASGK7rVtffRpvm3gcusYO8oexcyEOdvk4PT7OJHISgSiSuUh1eUK/84+X
         yGIMw8ldInbRw==
Date:   Tue, 8 Feb 2022 14:41:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2] regmap-irq: Use regmap_irq_update_bits instead of
 regmap_write
Message-ID: <YgKBEIapL8MAQAoI@sirena.org.uk>
References: <20220119142953.1804-1-quic_pkumpatl@quicinc.com>
 <CGME20220208122955eucas1p2d4e32f51224242e9ebd0bce58b9c04ca@eucas1p2.samsung.com>
 <39f1b598-58ca-1e3d-3065-8dd692ee7c9f@samsung.com>
 <20220208133957.GC112838@ediswmail.ad.cirrus.com>
 <20220208135036.GD112838@ediswmail.ad.cirrus.com>
 <YgJ2hG2vwUclA/zF@sirena.org.uk>
 <20220208143316.GE112838@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jv8MBE5QGK8kAXmU"
Content-Disposition: inline
In-Reply-To: <20220208143316.GE112838@ediswmail.ad.cirrus.com>
X-Cookie: This is your fortune.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jv8MBE5QGK8kAXmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 08, 2022 at 02:33:16PM +0000, Charles Keepax wrote:
> On Tue, Feb 08, 2022 at 01:56:20PM +0000, Mark Brown wrote:

> > My understanding was that they'd mixed interrupt handling in as a
> > bitfield in another register.

> Eek.. what a courageous choice. I guess that might work as
> long as there is only a single IRQ status bit in the register,
> if there are multiple bits this really needs more complex
> handling, like you basically need the old behaviour for the
> IRQ part of the register, and the new behaviour for the not
> IRQ part of the register. So perhaps a new mask to denote which
> bit of the register is being used for IRQ stuff?

Yeah, I think that's what I misread the code as doing.

--jv8MBE5QGK8kAXmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmICgQ8ACgkQJNaLcl1U
h9CuOQf/f55QEPYWcJesb5ASdVandS6mWWUT3NZ4QOrbearecpyY1z2pPh3zx7Yu
qUVYuvfLMfJvSPsjtGHi2THg5eX+ctxJdpsflYf1SDGEQnX1dREsJl+1giBVqogn
ybLMXZmEvzKOYoR9q0MZMw8baesjtlpirunaXvvK7ctnTB/5hfR/Slmm9dqwt2Ph
PoElLbFPTzlvKFYccAyr6dsCxgbL1cV7rw0dSMdreAD7b7Is1V9X0zmq6bPPS0g5
qXG3XIjUDDMqB1gNvAEqz8vUx4sqrh1SHkpyIDjfb5cC4dn1ANqiKeVbkzhTSCky
cciN+AtOT6e9JkzbRLN3gVG8rq08aw==
=Y0qE
-----END PGP SIGNATURE-----

--jv8MBE5QGK8kAXmU--
