Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1572B58CBD0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbiHHQFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiHHQFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:05:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0195715829
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:05:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6CBEB80FE4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 16:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDEAC433C1;
        Mon,  8 Aug 2022 16:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659974703;
        bh=LDouG7rFjTDAUM/UZ8BMNNASjVm4YB8Ed6+aS5UWEC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGsb0zLuchufkeYDi6vIPjfmObotel5prFYIzIJS85hjxWI4f1qB3JOyGAE8nl4LL
         js9ZxjvqOGUggI1qx+G8bgdK80yCsTOGLos84RcrXdmFXmWY2t1J70nBF2IFW+0MRo
         ZS1Qe1SDuOaR0WeVUW0hpeCpWVcA7nCWL7x4UV64OWKf+BiXCljedP0pkqhLXpSf6/
         CEUpT0tUzOzannCNGy8ACbjCkwOMqHUO0UOSMv6XpzEETjUzBrg5Ul5BVoKSqLQ0pa
         rr1rxTJCm8iRv5Ceq2mLpJesXDqzaZPPZ0WIPqrnYT5nEgxNZ/Zlhd10TTLakEC5ht
         uhNJWpND7mzQQ==
Date:   Mon, 8 Aug 2022 17:04:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 5/5] regmap: mmio: Introduce IO accessors that can
 talk to IO port
Message-ID: <YvE0KroZDQuPVd+V@sirena.org.uk>
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
 <20220805205321.19452-5-andriy.shevchenko@linux.intel.com>
 <YvENHSRQuwAzfQJW@sirena.org.uk>
 <CAHp75VeA8tA-m_gHu5iuhriSfm_qo1PRnUWe7kQ68CCm+UCgHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FitPG0KbKZ5nuKsn"
Content-Disposition: inline
In-Reply-To: <CAHp75VeA8tA-m_gHu5iuhriSfm_qo1PRnUWe7kQ68CCm+UCgHA@mail.gmail.com>
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


--FitPG0KbKZ5nuKsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 08, 2022 at 04:40:26PM +0200, Andy Shevchenko wrote:
> On Mon, Aug 8, 2022 at 3:31 PM Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Aug 05, 2022 at 11:53:21PM +0300, Andy Shevchenko wrote:

> > > Currently regmap MMIO is inconsistent with IO accessors. I.e.
> > > the Big Endian counterparts are using ioreadXXbe() / iowriteXXbe()
> > > which are not clean implementations of readXXbe(). Besides that
> > > some users may use regmap MMIO for IO ports, and this can be done
> > > by assigning ioreadXX()/iowriteXX() and their Big Endian counterparts
> > > to the regmap context.

> > Have you validated that nothing is relying on whatever the problem is
> > with using the io versions?

> I have cross-checked 1) the architectures that are BE and have IO port
> capability, and 2) the drivers that are using regmap MMIO with a
> big-endian setting. I found no driver is mapping IO ports and uses
> regmap MMIO at the same time. The architecture wise the x86 and ia64
> are not in question, I think. And alpha is more academical nowadays.
> Did I miss anything?

> That said, I'm 99.999% sure there is no problem with that.

The issue is the potential that something that is currently using the
ioport accessors might be relying on whatever it is that they do that
causes a problem.

> > > That said, reimplement current Big Endian MMIO accessors by replacing
> > > ioread()/iowrite() with respective read()/write() and swab() calls.
> > > While at it, add IO port support with a corresponding flag added.

> > This should be a separate patch.

> OK! Then we remove some code and (re-)add it later. Do we need this churn?
> Another way is to add IO port accessors and then fix the MMIO.

Add and then fix seems sensible,

--FitPG0KbKZ5nuKsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLxNCkACgkQJNaLcl1U
h9Audgf/T24WSifqH0sa2VA/IJYVxYAypJW/8mjyrZ76bz0h3N8pnJeXMRNIuV4G
1ig+FQi6lDvekaJ6LCwzFadoCQ6waO3Cd8mk9a9EqZxbA5BVVz2+IUBomjoxStIj
xD6b0Rq0l87ApB1hEtAQVT2qY6XsTHPDf/bnnwGaLokcJ0RjC/i1oOmYk4CR9wNK
IrxwXxTxeF6UTWwO2DSerbvJ/UuXIyoE+KAfdtOcSOI/Ue659qBS1AMu0Af1NO4u
6Svo4aPA9PNMsq7RFLppqYkPPSfkUTtmVc3b7lCeeGgunAiLOSNdxt22GYdT6U68
GMcHrZD5T5zWGSpzZ254iuPvvcx0pg==
=O0Sq
-----END PGP SIGNATURE-----

--FitPG0KbKZ5nuKsn--
