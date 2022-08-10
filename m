Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6698958EE68
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiHJOcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiHJOcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:32:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EAC2B18D;
        Wed, 10 Aug 2022 07:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1975C61527;
        Wed, 10 Aug 2022 14:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1488CC433C1;
        Wed, 10 Aug 2022 14:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660141924;
        bh=XP7o0LqW4ri+tvBAJ6DfVBQ+7ISFbLgZEwquRdB528k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOOqLTx3irxJuXHiFn1x/As+urVyIjJLwJ0kZh7MRjVEOzk1HOrbpCJKqM23T08z/
         BDVdaEdyq839+KXhhP90/qtIzq1iuFTIVvg07ZVWfcxY05UEaM1zn2bIKyCkQEZZAu
         axdKHUl4J2Fqx5QAIugZiKPwRedE9UtOKFZJqBGC/V4mvgCU7t2mZdaza21GXzX3zd
         3SuvUZK+BP59iZ/+aZ0PHppRLHVTFUVqr1URngKnStUvNylmaa/Hu9TgZs8eZA1pvS
         bENV5m0pSKcrZe4JnxqKSGFplvqaklXdfOOHwlVbOnNcg3u6ow3f2QHZNnBY9CxipE
         4WNKredHSqT2w==
Date:   Wed, 10 Aug 2022 15:31:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Da Xue <da@libre.computer>
Subject: Re: [PATCH] spi: meson-spicc: save pow2 datarate between messages
Message-ID: <YvPBX7zJ72RXnrpk@sirena.org.uk>
References: <20220809152019.461741-1-narmstrong@baylibre.com>
 <YvJ84qkuXdvVgXRm@sirena.org.uk>
 <39c2f53b-8f53-ceb1-ae0c-81e5e53d01aa@baylibre.com>
 <YvOmnDJA+ov49chC@sirena.org.uk>
 <518f22f4-1582-924c-9eaa-28ebbe53a632@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WEqUYi41ANWCpin/"
Content-Disposition: inline
In-Reply-To: <518f22f4-1582-924c-9eaa-28ebbe53a632@baylibre.com>
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


--WEqUYi41ANWCpin/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 10, 2022 at 04:01:33PM +0200, Neil Armstrong wrote:
> On 10/08/2022 14:37, Mark Brown wrote:

> > Sure, but that doesn't really address the concern - is this something
> > that the clk driver programmed or is this the driver forgetting to
> > restore a register that it programmed itself?  The commit message sounds
> > like the former which is a much bigger problem.

> It's what is programmed by the Clock Framework yes, it was designed as-is
> so the Clock Framework takes the most accurate clock path but the reset case
> wasn't taken in account.

This seems like a bad idea, we shouldn't have two different drivers
managing the same register without explicit and visible coordination
with each other, this is at best asking for trouble as you've found
here.  I've not looked in detail but I think if you want to use the
clock framework here then this driver should register a clock provider
for the clock hardware in the IP block.

How does this work with runtime PM, what happens if the clock driver
decides to change something while the device is powered down?

--WEqUYi41ANWCpin/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLzwV8ACgkQJNaLcl1U
h9CRwgf+K7WOMvAJpCDDJzGeEDnvO60A4KqWEROJNwU9pzFD/oES6Slzi83SHzvp
lHZWpvuJRnofLap5EVCebAtxNtqVJzX00q+MB25XxtFgLICY+MHghQ6g9+/C3BkV
NuexPyuLn6Q5EAXthFBx/ZKKkg2wDxBtygX5uHpMuFggSpduJ+X5Gm8fu8idcG6o
m+tr8K+ChscFOhMkLy/6yMdXjU8sMt46egyYYhasKbKFT7oSjlMb383OBIp4WVFw
vusuEWjSoy0xK2LmHEOD23/jxjkB2Lr7mtFe5QPkE/L9hGG4pvdU4hqaVAlSQrpZ
aJ/9Oaoi0ApclyH8g3naLiygsa7Amw==
=e05v
-----END PGP SIGNATURE-----

--WEqUYi41ANWCpin/--
