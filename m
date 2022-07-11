Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A87857063D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiGKOwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiGKOwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:52:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B1C6F7EC;
        Mon, 11 Jul 2022 07:52:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7FF5B81026;
        Mon, 11 Jul 2022 14:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66C9C34115;
        Mon, 11 Jul 2022 14:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657551160;
        bh=T5/YgjZEyFa9qar9PBcP/h4QGGDW5ssEp2nL2da/rbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FruxfvHb7pRbBBKIhc4BZ4LRHPprizlmPVXQS1iaXTGP3mgGGgRP55lY90bNGTJnA
         OT1+WTtiPEFSUVn2Tg5wAMGpjjG3usGRRsF6/jUH758RS/RygHWSHg/lMONF2Rqlkq
         4X1cHCexjg+mTGOGHaJGJ6nPWWtvjhHaSnFpd3vYobOIzYlxPgZjnRkAZ/Luf40u83
         0t9djetXzX5gMjB7V4yP0O1Gm/io7vVDjEJy3sg8p3PodwEUxchAZxGEksxtZB8Blu
         sFcf1VXgD+ZN0cIf0lQtlo+upOC9x0DA/NjhmVkz2e4jveY5VCqFuBi3ES8Y2BtO4q
         Tmr8GBBH/12eQ==
Date:   Mon, 11 Jul 2022 15:52:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, git@xilinx.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH 1/2] spi: Add multiple CS support for a single SPI
 device
Message-ID: <Ysw5MpvjKM5LKvWd@sirena.org.uk>
References: <20220606112607.20800-1-amit.kumar-mahapatra@xilinx.com>
 <20220606112607.20800-2-amit.kumar-mahapatra@xilinx.com>
 <YqHfccvhy7e5Bc6m@sirena.org.uk>
 <40110ff8-5c19-bc54-759b-a51a919788eb@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="myd8/Fo7asf/V7NN"
Content-Disposition: inline
In-Reply-To: <40110ff8-5c19-bc54-759b-a51a919788eb@xilinx.com>
X-Cookie: I am NOMAD!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--myd8/Fo7asf/V7NN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 11, 2022 at 02:47:54PM +0200, Michal Simek wrote:
> On 6/9/22 13:54, Mark Brown wrote:
> > On Mon, Jun 06, 2022 at 04:56:06PM +0530, Amit Kumar Mahapatra wrote:

> > > +	u32 cs[SPI_CS_CNT_MAX];
> > > +	u8 idx;
> > >   	/* Mode (clock phase/polarity/etc.) */
> > >   	if (of_property_read_bool(nc, "spi-cpha"))

> > This is changing the DT binding but doesn't have any updates to the
> > binding document.  The binding code also doesn't validate that we don't
> > have too many chip selects.

> I would like to better understand your request here in connection to change
> in the binding code for validation.
> What exactly do you want to validate?
> That child reg property is not bigger than num-cs in controller node?

If you are adding support for multiple chip selects in the driver then
there must be some mechanism for expressing that in the bindings which I
would expect to see appear as a change to the binding document.

--myd8/Fo7asf/V7NN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLMOTEACgkQJNaLcl1U
h9DUywf/elR3ZLKLxsB3PZJFT+KXa1Qr7NqEluE38DikQ0asVPDKT2SyDCuVZBFu
P1WzVgQFGEAjOkRrNtJYKBi8zPlGyjCp45MoWQeXNMqI/1jyNP0O9ewCBZH8rT2x
zhtyqxEFRWbPxdGdiNvhUodfbdnWjbE6tgt6XEgnJT+b9yqAUx13OGx5PK4tf8ql
Bg+I0GCGybcOmQgJ1DPuTY8l1c5Hs2sd3kHCdpgjtEjnSnD7dqOtDQ0lH2vSVVzF
1tlp1tSqbatA+jmgJSki0T/eVtXpiNHOWq/WBdjEx9nBu8YN28UR8iMVtxeua7Ni
i8DPKRKrXRFE6Qz2NK5U6/DYNEVDVw==
=ZBqB
-----END PGP SIGNATURE-----

--myd8/Fo7asf/V7NN--
