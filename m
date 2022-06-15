Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4838154C8AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348802AbiFOMhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241638AbiFOMht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:37:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948EA24F39;
        Wed, 15 Jun 2022 05:37:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BAFEB81CD1;
        Wed, 15 Jun 2022 12:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263F9C34115;
        Wed, 15 Jun 2022 12:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655296665;
        bh=4hVhluLtxcYUeJP9hL5fNVYu7o4eusq8ZzYiuhbcsyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgB8i7Y1m4ufqgINiikVCDZ7wOPU8NETuK2NkgvQLCbj5qcjzVo28O9BrEz81PxAo
         CXIyGUj4BnYOX8JD80e9kqbZ3JOAikM/mpIMAS6LdaFEErd6IXz7vNv1gSHxqUNJYt
         IduEPhxN1zdc0VhNgb/JWlI1/q1TpOw16E8ZzQgKQdEHvRNQS+LJycBU+04hTLgXiT
         DXdF3Dqm9eqivxyPh/sI2T7+MRlZkI2qmN3EeOjt4UYEg8wpJ5/+HIIbtWKIxKtvAC
         xG7e0MutP0kzic/BOdbIauRKt1OHjEqaLecMfS+UmnOR6rbkzpOpJI0xyCVqYtVgpZ
         2fuD5hdfF3csA==
Date:   Wed, 15 Jun 2022 13:37:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     Daire.McNamara@microchip.com, Lewis.Hanly@microchip.com,
        linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [PATCH] spi: microchip-core: fix passing zero to PTR_ERR warning
Message-ID: <YqnSlIcAadwxt1Q5@sirena.org.uk>
References: <20220615113021.2493586-1-conor.dooley@microchip.com>
 <YqnFLCbvrTxNbG1+@sirena.org.uk>
 <7eda95bd-c7f5-767a-fe88-9f7109467cd8@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x91oVE/PcPTtCJq8"
Content-Disposition: inline
In-Reply-To: <7eda95bd-c7f5-767a-fe88-9f7109467cd8@microchip.com>
X-Cookie: byob, v:
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x91oVE/PcPTtCJq8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 15, 2022 at 11:57:37AM +0000, Conor.Dooley@microchip.com wrote:
> On 15/06/2022 12:40, Mark Brown wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > On Wed, Jun 15, 2022 at 12:30:22PM +0100, Conor Dooley wrote:

> >> -             ret = PTR_ERR(spi->clk);
> >> +             ret = !spi->clk ? -ENXIO : PTR_ERR(spi->clk);

> > I think you're looking for PTR_ERR_OR_ZERO() here?

> Maybe I don't understand, so let me explain what I think you're
> suggesting & maybe you can correct me:

> > -             ret = PTR_ERR(spi->clk);
> > +             ret = PTR_ERR_OR_ZERO(spi->clk);

> But if spi->clk is NULL, this will return 0 from the probe
> rather than returning an error?
> If that's not what you meant, lmk

Oh, hang on - what error conditions can clk_get() return 0 in?  The
documentation doesn't mention any...

--x91oVE/PcPTtCJq8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKp0pMACgkQJNaLcl1U
h9Cnkwf/frE4cXtVXU1qGhaIP40Lw1jlf28yAxuK+pWDkVTrMB/XYrRIx0IeJuhj
OOxtWWvD2LqknfmjqYULX2VTgLJ+AgD+bj2uDG2XFSW9nIE74WSte2jGPhAAlK1g
IreVpgy0HXSUBoTjse+YFpVaECTjWpVtcPLKOZrhuJT/r+OFMQYwvlBG3p1YcVmH
92C0k1tSsxv1ujR3UDNvyJUD2z8dbbD4ki8ouPntvyPlVovI3KTCl8C/Pc2rTVkt
aaBRO9bWDsvxVcgWgUqM1V8geOOdaxGQiXaAeytJsZKsHYPbIlJFr6189QPxtvVj
NBviWTjDtiPXjwEhAT/xnXRUGu9mOA==
=+HQB
-----END PGP SIGNATURE-----

--x91oVE/PcPTtCJq8--
