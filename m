Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BA159C4D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbiHVRPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiHVRPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:15:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD8E1D33B;
        Mon, 22 Aug 2022 10:15:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2847C61238;
        Mon, 22 Aug 2022 17:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E8DC433D7;
        Mon, 22 Aug 2022 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661188508;
        bh=hfMDfB9Z0RHdEPefMvfhyYxfM05fQdL1z9y6UoPE9bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CBokHbKMDoaFHEVNy2WUkgAQ2ohCgGI87CovEnbbwy3hS79PfUULUa9pwuOnxRSoa
         05E/9W6bzAltwRHmVoZSn4M1qu67oJJDD5yiKSDKG6m0rwfkXelsjLjEfLGeP2TPSO
         kSxvTVunCUZuH6AK47gqM1e+SaCcqGEHAfpXHD5LbmUxbD2TnX+AlqNycIjX86Ao/5
         pPpCfdOYsXcd4VILWtQ+00Ui6FVJ4Vj2tz2g5XKn9i6ZwWj2VUadRDimRxEqiVcsDN
         RcW5DRR87rFtfCWwzGC9pBiHarnOPezEyu0hqykDpVcD7tYx9RScAl+G18hFswU2Hp
         /Ec2kk9oSesKg==
Date:   Mon, 22 Aug 2022 18:15:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Rob Herring <robh+dt@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 2/2] spi: fsl-spi: Implement trailing bits
Message-ID: <YwO5l/KpXoKJVawq@sirena.org.uk>
References: <cover.1646060734.git.christophe.leroy@csgroup.eu>
 <fe4a3946a66ede73f6d6871700f2aaf0171372a1.1646060734.git.christophe.leroy@csgroup.eu>
 <YhzqbYW1q5bPNWXn@sirena.org.uk>
 <7afaab3d-50e0-4716-18d4-41eabc2a9cb9@csgroup.eu>
 <Yhz0/1kiAy7Mlgtv@sirena.org.uk>
 <f9046e68-ff22-2652-48dc-d277b4af75dd@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kt0uLPcdMuEcGWGx"
Content-Disposition: inline
In-Reply-To: <f9046e68-ff22-2652-48dc-d277b4af75dd@csgroup.eu>
X-Cookie: Do not write in this space.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kt0uLPcdMuEcGWGx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 18, 2022 at 06:35:39PM +0000, Christophe Leroy wrote:

> Yes indeed. Therefore in v3 I took a different approach : a flag .cs_off=
=20
> tells to spi_transfer_one_message() that a given transfer has to be=20
> performed with chipselect OFF, therefore the consumer has full control=20
> of how and when to add those additional fake clock cycles during a=20
> transfer, and can eventually add one at anyplace during the transfer.

> Here an exemple of what will do the consumer.

Hrm, we should already be able to synthesize that with cs_change though
there's usability challenges there and AFAICT it doesn't work for the
first transfer which your proposal would so there's a functional benefit
even if you don't need it for your device right now.  It would be good
if you could have a look at using cs_change for your use case.  Sorry, I
don't think I'd fully realised what you were looking to accomplish here
until I saw your proposal.

--kt0uLPcdMuEcGWGx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMDuZYACgkQJNaLcl1U
h9BCQgf7BRyI74U3FqIlPEFuflzYCBYqArtPaZVSdt6JQS6g8jGTaQNDvhuOM5QK
MIIaKDYm5X5q23rZf5OO/DiKa/f9yJDE7mIFI6ggc9YTy/letJxu2ofnYSr9xKSW
ZN4SI1iwjcfFHW5USFuZdiDa0g/p7GwlnWNuZm/lo756TriY+bSBUjZBfYX+wP2f
crkB3W1rqlU7CTdPBAwrCHhOIqMf1v29OrfjEeMLIq8PK5vNsjMGa4VkbypO5rOz
mHRnw+LCsJBla5zt5aWAUtF512WkPLaLn2ag0yZVLBFPqCLDEVLMyNCXVo5SxKVk
VX7fsEpBFCd3xxf1O0TulXrYzybAiQ==
=maO1
-----END PGP SIGNATURE-----

--kt0uLPcdMuEcGWGx--
